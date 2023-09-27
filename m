Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D9D7B02A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjI0LU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjI0LU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:20:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA0C191
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:20:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3215f19a13aso10673792f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695813653; x=1696418453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yH8ZpbImzRMbT8TFfZwK2hRhUzXNjPd5gvlGsVb+cac=;
        b=CY0Mdf4ULkW1IPk1JaZa6GX966jxocILppqWzhIX+diL2P1ofQhODuoBHQZhA2m3ry
         mVyDWRi/SsY3GAwH31Q09HVc1vfB9fD+Ek2G07Msy9p6/9/N4YSRG7x4YQLx0pfeAns3
         9J+dyzwe638QXYWV+ZxuB7lkw69iwTo1JWjNCNyvhR2JND/3oVJJmhoUrvMMlJeQaFuu
         4Sx58exrUj4Nwi/0X2O6wziEn2PRso2WEnNi2NfJrOc8NkXD8jKzp1RWSw0RyDSHD7hl
         7WUKaRkLvzQCqZiVR5JEnV1rBZlX6yX5DR/2YmEj3ytn4b/pF3BikNIn4ACNLsONS4Yz
         4k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813653; x=1696418453;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yH8ZpbImzRMbT8TFfZwK2hRhUzXNjPd5gvlGsVb+cac=;
        b=n25JjGULKQTaZZw2L6lhqljvsgQ3lkK3bkNO+0bMWBrs0Gh1GXXOe5OJmc2H2If20D
         RGOnUH5SGlqzt3DJj/rbcU4zOzKGJQrriWb/73jZJsq0X7XxAg/Xo2HaHrIHN0oRVWXn
         i4G3bwIcnwjQ2Qyf/7PcLjvBZsk0ORuGxmSEDAdfewVqxDLZnXXMIhJTIu1GDXk7/UsG
         0FU0kXyfBz2ZFlSOqBlKhNPLCQkLTmKYr1Er+zmCN7ndB/fwVJmVDoKCDX6UeGDmP7Mj
         Hux8qqlW536LCk0GTgi0dWM0L9KbQHvkY2l2cf4qQ4/30ohV9cBFJdNLjG0kZzDvmSbz
         CCgA==
X-Gm-Message-State: AOJu0YxYY+/QoSgySVKLOK3AYINGXM8K3+TQgQRbahsxCJVcmDP95TYq
        kiVMOlUxSE4WzwkMI2NfAJdGnA==
X-Google-Smtp-Source: AGHT+IEGbfGOH+WAT9qhjw+R5iczZS5ixJdH3+1VErLPvfslIhY99+WTNVtEYx+x8Z2pNOQXLvjidQ==
X-Received: by 2002:a5d:568e:0:b0:323:2038:944 with SMTP id f14-20020a5d568e000000b0032320380944mr1484063wrv.58.1695813653169;
        Wed, 27 Sep 2023 04:20:53 -0700 (PDT)
Received: from [192.168.33.189] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709061f1700b0098921e1b064sm9144649ejj.181.2023.09.27.04.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 04:20:52 -0700 (PDT)
Message-ID: <96649a0f-63ab-4d88-acad-7b9bfb221a02@linaro.org>
Date:   Wed, 27 Sep 2023 13:20:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm6375-pdx225: Add USBPHY
 regulators
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230927-topic-6375_stuff-v1-0-12243e36b45c@linaro.org>
 <20230927-topic-6375_stuff-v1-4-12243e36b45c@linaro.org>
 <8bbdf132-a007-4cb7-b842-a81de7c1629a@linaro.org>
 <354e5b45-468e-4fe6-9646-6b4d9596393a@linaro.org>
 <2bd16a5b-260d-457d-98c5-bee030f05f00@linaro.org>
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
In-Reply-To: <2bd16a5b-260d-457d-98c5-bee030f05f00@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.2023 13:16, Bryan O'Donoghue wrote:
> On 27/09/2023 12:05, Konrad Dybcio wrote:
>> On 27.09.2023 13:01, Bryan O'Donoghue wrote:
>>> On 27/09/2023 10:21, Konrad Dybcio wrote:
>>>> To make dtbs_check happy and the software more aware of what's going
>>>> on, describe the HSUSB PHY's regulators and tighten up VDDA_PLL to match.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
>>>> index bbec7aee60be..0ce4fa8de8b0 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
>>>> @@ -243,8 +243,8 @@ pm6125_l6: l6 {
>>>>            };
>>>>              pm6125_l7: l7 {
>>>> -            regulator-min-microvolt = <720000>;
>>>> -            regulator-max-microvolt = <1050000>;
>>>> +            regulator-min-microvolt = <880000>;
>>>> +            regulator-max-microvolt = <880000>;
>>>
>>> Where did the old values come from and why are the new values better ?
>>>
>>> Consider enumerating that in the commit log.
>> That's the pretty standard situation where:
>>
>> - downstream defines very loose ranges
>> - developer uses these very loose ranges as a guideline
>> - some hardware (often the exclusive user of that regulator)
>>    has a hidden-ish request of a tighter range
>> - the developer realizes that and has to fix up the ranges
>>
>> Konrad
> 
> If you got 72 and 105 from downstream, where did you get 88 from ?
Also from downstream, except from the consumer driver

Konrad
