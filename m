Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0325075AB6F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGTJuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjGTJtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:49:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3977FFD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:48:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso873580e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689846484; x=1690451284;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m66C/vpUoNhXNL/USqnmEN/SERtYzszLXqFxfokE9/I=;
        b=AWPzHzVbimx7mJ3OJTXHoi7CjWuZXJgAH526sIkk+eZqFQ2+MP313fRQuFSZ9Oqt18
         TlhzEWo+V7nRwsKKpBwgEYrbvO+xl8I8WxlUETa3bCwUueNEajSMtpNFZMRrrkkFktFV
         2UE7qWA8txGyKBrXbvC5Lp/FsPVl3QhQjjDWmMfdPQnzu02ikXlbh2gDyTKtVHp0cnAk
         LnIwSQ9k4DngRiyjJyQqpfiLXlfnHpMdfo+62th1/gtfc15FoOljNN8fyIIMKCzO4Rfe
         O9TZotuM+hZVB+hU31kCBmL7EKZ29DXgDMqixlBkwgWbqApz7m/bSjzprqYd0e2kOIsO
         fW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689846484; x=1690451284;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m66C/vpUoNhXNL/USqnmEN/SERtYzszLXqFxfokE9/I=;
        b=CE37N7teVlmHWeqePLqUWm3dvP+Ohz4mPLnklNLbpGYPWu9xawrF5UfWzJAtuVnk6V
         kUVPoDiKo+dzt/xi5MT3NCr2C14Hfrof2qBR0u6A9XwaGUd3EoI/n3wQljB+NcrN+s85
         JoAfBQTYZRt++GJUBqCH1gR0HvTWMiwueM7NePgtPph7PmoXWzAdJsND1ZWtzoHrXAaZ
         Qmfr56yGxzWnDZFCBqZqtXLxI3JWTnEdd4SnRwrQNoa0DBECg1l0cmgELL6+Qq6brgqI
         NQL9XwcvxvRGzlN22rbPNstTjkMvNm3LgMKKeRe4sSmFYAfKg4aCli+IFBi0xSMoTGtI
         hdqg==
X-Gm-Message-State: ABy/qLbfuJQXZbWX8Ac6Epa00fJ1leDWWTnNpiry0B+QAJJ6cAUF1vpe
        SztLXo83cxM4ffokbF/Z1RWz3Q==
X-Google-Smtp-Source: APBJJlFqoMhnweK+l5F3+WSGWFBzdrxM8oVIsbig1fVnXEChSXlao+MmrcENPeeMbW8GhoJJ+cvDnA==
X-Received: by 2002:a05:6512:46d:b0:4f6:1779:b1c1 with SMTP id x13-20020a056512046d00b004f61779b1c1mr1902595lfd.48.1689846484327;
        Thu, 20 Jul 2023 02:48:04 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id g12-20020a19ee0c000000b004fb8c31c8dfsm116388lfb.267.2023.07.20.02.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 02:48:03 -0700 (PDT)
Message-ID: <9e401641-1334-c0bc-c49a-481a8a9af2de@linaro.org>
Date:   Thu, 20 Jul 2023 11:48:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: document AL02-Cx and AL03-C2
 boards based on IPQ9574 family
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sridharan S N <quic_sridsn@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230720084534.6461-1-quic_sridsn@quicinc.com>
 <20230720084534.6461-2-quic_sridsn@quicinc.com>
 <87c3a3db-d172-bc98-cf83-89b874c9fee7@linaro.org>
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
In-Reply-To: <87c3a3db-d172-bc98-cf83-89b874c9fee7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.2023 10:49, Krzysztof Kozlowski wrote:
> On 20/07/2023 10:45, Sridharan S N wrote:
>> Document the below listed (Reference Design Platform) RDP boards based on IPQ9574
>> family of SoCs.
>>
>> AL02-C3  - rdp437
>> AL02-C7  - rdp433-mht-phy
>> AL02-C10 - rdp433-mht-switch
>> AL02-C11 - rdp467
>> AL02-C12 - rdp455
>> AL02-C13 - rdp459
>> AL02-C15 - rdp457
>> AL02-C16 - rdp456
>> AL02-C17 - rdp469
>> AL02-C19 - rdp461
>> AL03-C2  - rdp458
>>
>> Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
>> ---
>>  .../devicetree/bindings/arm/qcom.yaml         | 20 +++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index dd66fd872c31..d992261da691 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -89,10 +89,20 @@ description: |
>>          adp
>>          ap-al01-c1
>>          ap-al02-c2
>> +        ap-al02-c3
>>          ap-al02-c6
>>          ap-al02-c7
>>          ap-al02-c8
>>          ap-al02-c9
>> +        ap-al02-c10
>> +        ap-al02-c11
>> +        ap-al02-c12
>> +        ap-al02-c13
>> +        ap-al02-c15
>> +        ap-al02-c16
>> +        ap-al02-c17
>> +        ap-al02-c19
> 
> Why? I asked once, but there was no feedback from Qualcomm.
> 
> Why do we need to do this? What's the point?
Another question would be, whether these boards are just one-off test
prototypes of which there exist like 5-10 units, or are they actually
going to be supported and useful.

If it's the former, I don't think it makes sense to keep the device
trees upstream.

Konrad
