Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E155E78F483
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347551AbjHaVXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347534AbjHaVXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:23:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B42710CB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:22:46 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so24038511fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693516949; x=1694121749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1AoFu3YY2A2D/Vht+AXgb+PkLNyMfnsxtR7/rrK95mo=;
        b=YCa+9+JNjTPz7bpvY8+epdEyMY5+APK1AMHkcycFk45Iy5pu67HRM/wrtFz3IJ9klU
         F4+Y+QBRd+vMqLqHal6MsOkBMBnx1kYwVV4x/3Fn1YmOAZdil3sSEvNHPb3kjTe480i1
         en1ySOl4rikx3mG441FEU9tgl3pkwROtyQwfx/Dpe2Su6D5Wtfr5bV8ljmgA8nqDnmYi
         8tpOe2rQ4Dh1TIWucIMgaYNjjTD4gx/71waDXCgA6qHwb+lmeondPDRqHrDRhDN6lqaD
         G83mR0vfEdATeN3Nm/OFfRTzgASAzIwHiQUYjUhtbeY/6ihGm90mTbOUxTmU1eqbp7kd
         bNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693516949; x=1694121749;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AoFu3YY2A2D/Vht+AXgb+PkLNyMfnsxtR7/rrK95mo=;
        b=YLgN1hc2f6dL9SC8Si7we0t2i6aV1WOh0fRa0tVXQ2Vdb/ChrclB7CjXuO/JtajmBN
         eJY7lMI9IqNZ0DH7ny057I9nJkQri5T9XwEkFhb0GeWJtQpNLAXlJzk+yuautWOVXN8Z
         5l3TOdlbky8d3aUjXdFT+MtrFD3+PKucH1WTWzHWtim8Pm4B2/58qyd1YS6K68Iws5OD
         +6TXyQAavTov/FZE6Iz879hLNYBRNJdfsiWwL41/mAb3cgu87uyVyndcrv9sJaMHNvcE
         a745JOnlS75WBrK4cA3icrKD8jWkUX3Mggr4McYo2MtFLEhEnaLUo6nhMnTRYb8H421L
         IywA==
X-Gm-Message-State: AOJu0Yx5A2L00yyUfd0VmnNhWatsH+kbP5SFVtEcLDY+ldzMdBShkxCQ
        SDBr2aL5BdS+feu4t+yzI1LGnA==
X-Google-Smtp-Source: AGHT+IGFPvcXmKwK9xVDDjCOUvIZGOIn3s3MnWew1g7JSFY9e4DGWfZWv+T6bb12+VwAzMEdVmsGzA==
X-Received: by 2002:a05:651c:8f:b0:2b9:ee3e:2412 with SMTP id 15-20020a05651c008f00b002b9ee3e2412mr314104ljq.22.1693516948990;
        Thu, 31 Aug 2023 14:22:28 -0700 (PDT)
Received: from [192.168.1.101] (abxh154.neoplus.adsl.tpnet.pl. [83.9.1.154])
        by smtp.gmail.com with ESMTPSA id m6-20020a2e9106000000b002b6e15ccf88sm499933ljg.135.2023.08.31.14.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 14:22:28 -0700 (PDT)
Message-ID: <36c90f71-3e74-4aab-aec7-4ad222ac8665@linaro.org>
Date:   Thu, 31 Aug 2023 23:22:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] pinctrl: qcom: sm6115: Add MPM pin mappings
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230809-topic-mpm_mappings-v1-0-5e17dd76b3c8@linaro.org>
 <20230809-topic-mpm_mappings-v1-3-5e17dd76b3c8@linaro.org>
 <ZNSPi3mDScn9ZMNJ@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 xsFNBF9ALYUBEADWAhxdTBWrwAgDQQzc1O/bJ5O7b6cXYxwbBd9xKP7MICh5YA0DcCjJSOum
 BB/OmIWU6X+LZW6P88ZmHe+KeyABLMP5s1tJNK1j4ntT7mECcWZDzafPWF4F6m4WJOG27kTJ
 HGWdmtO+RvadOVi6CoUDqALsmfS3MUG5Pj2Ne9+0jRg4hEnB92AyF9rW2G3qisFcwPgvatt7
 TXD5E38mLyOPOUyXNj9XpDbt1hNwKQfiidmPh5e7VNAWRnW1iCMMoKqzM1Anzq7e5Afyeifz
 zRcQPLaqrPjnKqZGL2BKQSZDh6NkI5ZLRhhHQf61fkWcUpTp1oDC6jWVfT7hwRVIQLrrNj9G
 MpPzrlN4YuAqKeIer1FMt8cq64ifgTzxHzXsMcUdclzq2LTk2RXaPl6Jg/IXWqUClJHbamSk
 t1bfif3SnmhA6TiNvEpDKPiT3IDs42THU6ygslrBxyROQPWLI9IL1y8S6RtEh8H+NZQWZNzm
 UQ3imZirlPjxZtvz1BtnnBWS06e7x/UEAguj7VHCuymVgpl2Za17d1jj81YN5Rp5L9GXxkV1
 aUEwONM3eCI3qcYm5JNc5X+JthZOWsbIPSC1Rhxz3JmWIwP1udr5E3oNRe9u2LIEq+wH/toH
 kpPDhTeMkvt4KfE5m5ercid9+ZXAqoaYLUL4HCEw+HW0DXcKDwARAQABzShLb25yYWQgRHli
 Y2lvIDxrb25yYWQuZHliY2lvQGxpbmFyby5vcmc+wsGOBBMBCAA4FiEEU24if9oCL2zdAAQV
 R4cBcg5dfFgFAmQ5bqwCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQR4cBcg5dfFjO
 BQ//YQV6fkbqQCceYebGg6TiisWCy8LG77zV7DB0VMIWJv7Km7Sz0QQrHQVzhEr3trNenZrf
 yy+o2tQOF2biICzbLM8oyQPY8B///KJTWI2khoB8IJSJq3kNG68NjPg2vkP6CMltC/X3ohAo
 xL2UgwN5vj74QnlNneOjc0vGbtA7zURNhTz5P/YuTudCqcAbxJkbqZM4WymjQhe0XgwHLkiH
 5LHSZ31MRKp/+4Kqs4DTXMctc7vFhtUdmatAExDKw8oEz5NbskKbW+qHjW1XUcUIrxRr667V
 GWH6MkVceT9ZBrtLoSzMLYaQXvi3sSAup0qiJiBYszc/VOu3RbIpNLRcXN3KYuxdQAptacTE
 mA+5+4Y4DfC3rUSun+hWLDeac9z9jjHm5rE998OqZnOU9aztbd6zQG5VL6EKgsVXAZD4D3RP
 x1NaAjdA3MD06eyvbOWiA5NSzIcC8UIQvgx09xm7dThCuQYJR4Yxjd+9JPJHI6apzNZpDGvQ
 BBZzvwxV6L1CojUEpnilmMG1ZOTstktWpNzw3G2Gis0XihDUef0MWVsQYJAl0wfiv/0By+XK
 mm2zRR+l/dnzxnlbgJ5pO0imC2w0TVxLkAp0eo0LHw619finad2u6UPQAkZ4oj++iIGrJkt5
 Lkn2XgB+IW8ESflz6nDY3b5KQRF8Z6XLP0+IEdLOOARkOW7yEgorBgEEAZdVAQUBAQdAwmUx
 xrbSCx2ksDxz7rFFGX1KmTkdRtcgC6F3NfuNYkYDAQgHwsF2BBgBCAAgFiEEU24if9oCL2zd
 AAQVR4cBcg5dfFgFAmQ5bvICGwwACgkQR4cBcg5dfFju1Q//Xta1ShwL0MLSC1KL1lXGXeRM
 8arzfyiB5wJ9tb9U/nZvhhdfilEDLe0jKJY0RJErbdRHsalwQCrtq/1ewQpMpsRxXzAjgfRN
 jc4tgxRWmI+aVTzSRpywNahzZBT695hMz81cVZJoZzaV0KaMTlSnBkrviPz1nIGHYCHJxF9r
 cIu0GSIyUjZ/7xslxdvjpLth16H27JCWDzDqIQMtg61063gNyEyWgt1qRSaK14JIH/DoYRfn
 jfFQSC8bffFjat7BQGFz4ZpRavkMUFuDirn5Tf28oc5ebe2cIHp4/kajTx/7JOxWZ80U70mA
 cBgEeYSrYYnX+UJsSxpzLc/0sT1eRJDEhI4XIQM4ClIzpsCIN5HnVF76UQXh3a9zpwh3dk8i
 bhN/URmCOTH+LHNJYN/MxY8wuukq877DWB7k86pBs5IDLAXmW8v3gIDWyIcgYqb2v8QO2Mqx
 YMqL7UZxVLul4/JbllsQB8F/fNI8AfttmAQL9cwo6C8yDTXKdho920W4WUR9k8NT/OBqWSyk
 bGqMHex48FVZhexNPYOd58EY9/7mL5u0sJmo+jTeb4JBgIbFPJCFyng4HwbniWgQJZ1WqaUC
 nas9J77uICis2WH7N8Bs9jy0wQYezNzqS+FxoNXmDQg2jetX8en4bO2Di7Pmx0jXA4TOb9TM
 izWDgYvmBE8=
In-Reply-To: <ZNSPi3mDScn9ZMNJ@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.2023 09:19, Stephan Gerhold wrote:
> On Wed, Aug 09, 2023 at 09:38:56PM +0200, Konrad Dybcio wrote:
>> Add pin <-> wakeirq mappings to allow for waking up the AP from sleep
>> through MPM-connected pins.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/pinctrl/qcom/pinctrl-sm6115.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-sm6115.c b/drivers/pinctrl/qcom/pinctrl-sm6115.c
>> index 2a06025f4885..4e91c75ad952 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-sm6115.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-sm6115.c
>> @@ -867,6 +867,16 @@ static const struct msm_pingroup sm6115_groups[] = {
>>  	[120] = SDC_QDSD_PINGROUP(sdc2_data, SOUTH, 0x73000, 9, 0),
>>  };
>>  
>> +static const struct msm_gpio_wakeirq_map sm6115_mpm_map[] = {
>> +	{ 0, 84 }, { 3, 75 }, { 4, 16 }, { 6, 59 }, { 8, 63 }, { 11, 17 }, { 13, 18 },
>> +	{ 14, 51 }, { 17, 20 }, { 18, 52 }, { 19, 53 }, { 24, 6 }, { 25, 71 }, { 27, 73 },
>> +	{ 28, 41 }, { 31, 27 }, { 32, 54 }, { 33, 55 }, { 34, 56 }, { 35, 57 }, { 36, 58 },
>> +	{ 39, 28 }, { 46, 29 }, { 62, 60 }, { 63, 61 }, { 64, 62 }, { 65, 30 }, { 66, 31 },
>> +	{ 67, 32 }, { 69, 33 }, { 70, 34 }, { 72, 72 }, { 75, 35 }, { 79, 36 }, { 80, 21 },
>> +	{ 81, 38 }, { 83, 9 }, { 84, 39 }, { 85, 40 }, { 86, 19 }, { 87, 42 }, { 88, 43 },
>> +	{ 89, 45 }, { 91, 74 }, { 93, 46 }, { 94, 47 }, { 95, 48 }, { 96, 49 }, { 97, 50 },
>> +};
> 
> Did you omit the mappings for GPIO 99-112 here on purpose?
> 
> The order here looks fine BTW. Maybe downstream changed the order and
> you got confused? :)
I checked more downstreams and still couldn't find it, I'll skip it
for now.

Konrad
