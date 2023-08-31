Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064FE78F446
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbjHaUso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347456AbjHaUsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:48:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F2FE65
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:48:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso2295168e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693514914; x=1694119714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+VNiNJcbRB6L5CsfmBHuAoSkrFtMVzdoiE8/5l+Qls=;
        b=PFqUYZwvZcQIG0v2rV+sIss8orvKIgU/rk7H/SH91faixsOTu06fKZf4FlW5TqOPfg
         ODeuoMCWUpPkGkpKrhwvlFmCRyv4O2uzJSLIy4qW+ZPWAkKPWTHaRVRGQFkl230uldng
         3dUdE4gdh1pdGq/e6wGy7l2ihDdeUdsxgmRo1rH9lLPseL6NCdUJNgRJ3gdF3y9ZbV0Q
         IGhEqvoOaaLGhXQsqwo9QF12Ma1MNtE8fiYBmPii9oHBX6+Ex14FD2DKJjlg4S/3hWcR
         +xIpFCUxinQJMMhbEA0AUzE1yxAalvoZdBOOv1vcYF2ysKOiYtbNIqxZ6iWWsiwyrdBj
         uWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693514914; x=1694119714;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+VNiNJcbRB6L5CsfmBHuAoSkrFtMVzdoiE8/5l+Qls=;
        b=CslQxujZhEi0rcuh7LWUOfOhVGGm0h6PBr9FYFKccPhXmn+7UlFDA5Evr5f9B+aIfA
         bkFtILF5TcUymKJDnTUdT8pbTTVHYNnsyG1MyA28hDGUJqQrKm35ldvUxYrWivVyEFyw
         hEDx5Kk6r6SIEF0meNUiJNXKhv9z809x5vcb6iRCAQO+2CGh8T1XKNgLdBOvOyrYcr2b
         kUQJwFEIvPuTgox5/7M33WWH9Zeptcy/W/AvH2zf3anIysDmuD4SGfyWpRUJask0CtuC
         J+wocz9L4Fn/XzLglfeuNvJhFluVITA2XeBw3Jjxe2iGgThgVSbPOq1RXu59+eJhFdMP
         FCDg==
X-Gm-Message-State: AOJu0YyE5vS2CDNFK0EB4ASth8eYkv1jy1M6PeTbmsc78HXV+biAxG0t
        /WPBW8WcUFDrtFG1WnKzkwJyOg==
X-Google-Smtp-Source: AGHT+IF4IT9J4RhjGBLsuNtS/p90trbwJ67hqDYHXbmr3jc+38tFf4hB7PjRzc/EGdnMpDwIz4cIbQ==
X-Received: by 2002:a19:5f53:0:b0:4fd:ddbc:1577 with SMTP id a19-20020a195f53000000b004fdddbc1577mr217173lfj.2.1693514914009;
        Thu, 31 Aug 2023 13:48:34 -0700 (PDT)
Received: from [192.168.1.101] (abxj133.neoplus.adsl.tpnet.pl. [83.9.3.133])
        by smtp.gmail.com with ESMTPSA id k20-20020ac24574000000b00500a7c7ea59sm404894lfm.173.2023.08.31.13.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 13:48:33 -0700 (PDT)
Message-ID: <836fab48-9602-4b3d-8393-64ffb7602dcf@linaro.org>
Date:   Thu, 31 Aug 2023 22:48:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] pinctrl: qcom: msm8998: Fix MPM mappings
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230809-topic-mpm_mappings-v1-0-5e17dd76b3c8@linaro.org>
 <20230809-topic-mpm_mappings-v1-1-5e17dd76b3c8@linaro.org>
 <ZNSOO47C5N88FpUz@gerhold.net>
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
In-Reply-To: <ZNSOO47C5N88FpUz@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.2023 09:14, Stephan Gerhold wrote:
> On Wed, Aug 09, 2023 at 09:38:54PM +0200, Konrad Dybcio wrote:
>> Commit 29f6e7e379fd ("pinctrl: qcom: msm8998: Add MPM pin mappings")
>> added a map of pins <-> wakeirqs. The values in each tuple were swapped
>> and the last one was missing. Fix that.
>>
>> Fixes: 29f6e7e379fd ("pinctrl: qcom: msm8998: Add MPM pin mappings")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/pinctrl/qcom/pinctrl-msm8998.c | 19 ++++++++++---------
>>  1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm8998.c b/drivers/pinctrl/qcom/pinctrl-msm8998.c
>> index b7cbf32b3125..08d6e555652a 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-msm8998.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm8998.c
>> @@ -1496,15 +1496,16 @@ static const struct msm_pingroup msm8998_groups[] = {
>>  };
>>  
>>  static const struct msm_gpio_wakeirq_map msm8998_mpm_map[] = {
>> -	{ 1, 3 }, { 5, 4 }, { 9, 5 }, { 11, 6 }, { 22, 8 }, { 24, 9 }, { 26, 10 },
>> -	{ 34, 11 }, { 36, 12 }, { 37, 13 }, { 38, 14 }, { 40, 15 }, { 42, 16 }, { 46, 17 },
>> -	{ 50, 18 }, { 53, 19 }, { 54, 20 }, { 56, 21 }, { 57, 22 }, { 58, 23 }, { 59, 24 },
>> -	{ 60, 25 }, { 61, 26 }, { 62, 27 }, { 63, 28 }, { 64, 29 }, { 66, 7 }, { 71, 30 },
>> -	{ 73, 31 }, { 77, 32 }, { 78, 33 }, { 79, 34 }, { 80, 35 }, { 82, 36 }, { 86, 37 },
>> -	{ 91, 38 }, { 92, 39 }, { 95, 40 }, { 97, 41 }, { 101, 42 }, { 104, 43 }, { 106, 44 },
>> -	{ 108, 45 }, { 110, 48 }, { 112, 46 }, { 113, 47 }, { 115, 51 }, { 116, 54 }, { 117, 55 },
>> -	{ 118, 56 }, { 119, 57 }, { 120, 58 }, { 121, 59 }, { 122, 60 }, { 123, 61 }, { 124, 62 },
>> -	{ 125, 63 }, { 126, 64 }, { 127, 50 }, { 129, 65 }, { 131, 66 }, { 132, 67 }, { 133, 68 },
>> +	{ 3, 1 }, { 4, 5 }, { 5, 9 }, { 6, 11 }, { 8, 22 }, { 9, 24 }, { 10, 26 },
>> +	{ 11, 34 }, { 12, 36 }, { 13, 37 }, { 14, 38 }, { 15, 40 }, { 16, 42 }, { 17, 46 },
>> +	{ 18, 50 }, { 19, 53 }, { 20, 54 }, { 21, 56 }, { 22, 57 }, { 23, 58 }, { 24, 59 },
>> +	{ 25, 60 }, { 26, 61 }, { 27, 62 }, { 28, 63 }, { 29, 64 }, { 7, 66 }, { 30, 71 },
>> +	{ 31, 73 }, { 32, 77 }, { 33, 78 }, { 34, 79 }, { 35, 80 }, { 36, 82 }, { 37, 86 },
>> +	{ 38, 91 }, { 39, 92 }, { 40, 95 }, { 41, 97 }, { 42, 101 }, { 43, 104 }, { 44, 106 },
>> +	{ 45, 108 }, { 48, 110 }, { 46, 112 }, { 47, 113 }, { 51, 115 }, { 54, 116 }, { 55, 117 },
>> +	{ 56, 118 }, { 57, 119 }, { 58, 120 }, { 59, 121 }, { 60, 122 }, { 61, 123 }, { 62, 124 },
>> +	{ 63, 125 }, { 64, 126 }, { 50, 127 }, { 65, 129 }, { 66, 131 }, { 67, 132 }, { 68, 133 },
>> +	{ 69, 145 },
>>  };
> 
> Are you sure this is correct?
> 
> /**
>  * struct msm_gpio_wakeirq_map - Map of GPIOs and their wakeup pins
>  * @gpio:          The GPIOs that are wakeup capable
>  * @wakeirq:       The interrupt at the always-on interrupt controller
>  */
> struct msm_gpio_wakeirq_map {
> 	unsigned int gpio;
> 	unsigned int wakeirq;
> };
> 
> MSM8998 has 150 GPIOs and 96 MPM IRQs. The tuple { 69, 145 } can't be
> right because 145 is not a valid MPM pin. It's a valid GPIO though so
> the original order was correct. Maybe replace "Fixes:" with "Breaks:"? :D
Went over this again, this is totally a "Breaks"

Konrad
