Return-Path: <linux-kernel+bounces-122035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B788F10A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B4029E24B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5681153586;
	Wed, 27 Mar 2024 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="de5rGAFx"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7515219B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575252; cv=none; b=l7FEYBVZuA9zdW8hA65jBZPbEO6tZ/X3R6YARcR2T9erSidRSAlgqxOhDLWxK9bE9jSX3zhCFA4Onqvuk23/+is+Lho0x7LwP4F6R2L2GmPuQZf9ceIiKl/3X5yo44GBrjWhFHZyn5M6E3wdouNKJp3a2WiW2oREoqvAZV2/Z+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575252; c=relaxed/simple;
	bh=uNmhgt+DPkbrA1TAlnzDHSWQFJYNFD30M1MPoNpmNWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYCNeWuTBgzw8KXQBu5YPFImtVIb3jjnKMudnjKv1nTt3+ep0GhYuO1AYhJxZ8QGObQZVQ5eY5BJELRZn+CKe9g/8WZ3B9peaCIvH2/49CTXhKFfo8RztTMei672fXMpHHwGewGUkS5JYpA2RJjpvxYXEDj7CoefuJ869tkCAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=de5rGAFx; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4751063318so35702266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711575249; x=1712180049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z+UzAYrVvdJAWKN2jU1pBtV2WcylIKnFACHwU9dAWU=;
        b=de5rGAFxA+89hYgRZwiSA3s1ovJ0lWYATid1MaJPsLaiRzU7NIp2kkSy4hJMbnGqYI
         0aTk7DLNq2eRPeQRhMpSwM8yhwvjDZTZD8t6aJ8FmNYbuzroVwTdSeJ3jsTm+HVLiJmI
         mdYCU5McYMv4E+vcUzXx8YrmAdD5qitFUzDEUVQBLIqYKc/m/DbwKT9mlPnZhrp3FxVo
         vpq4qfeVC0T6xkPDzFvwRvrPcj6RgF5DtW2EVMprqExlEIsBOnhP6JEdvuCuOJ5s0ypo
         eeIl55MRzDYSAW1evS00/TQxxJIywvFRFyOq/EfzuZURYgWEQbCWPJNxuJ/4IGY/+TMF
         A2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575249; x=1712180049;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z+UzAYrVvdJAWKN2jU1pBtV2WcylIKnFACHwU9dAWU=;
        b=fZ3BOsNOx9v588asB8Bsssftc4AiAAkxbgFb480uFFa1DG/sEchayVQkynqdJndN8m
         TNk1VdKGVb9JPjx+6qFF9JWQXiORmrqbg6xblG84Sa+92yqzcu6I7EB4eIgUrHJrFQ6D
         /s294lCc0pFM02n4EchzvWoDnokFzN7MBF3G52xNJ3QNY+sQCFeR6qrszqh25d/lyaps
         nQCjWsQG1/HwxhOBiSXFwldZI/1SlqMcxijBTmuLLqjTKoRR8KzkilfkkyRDHdeVVT89
         Kin9NNTcC41PdJvoVITznsxPGmnSIxzjuG9AeMzezlq5DI7GJT3a+vsYJpPiiJ2an/bd
         2QRg==
X-Forwarded-Encrypted: i=1; AJvYcCVNsjHfIxkQb9djmbCoJspqVTRqg7N40mXJ8vqXBmMyKg0mHAhjDfpMGyp56Tjb8L7OmRwWrh5M9OA9wc3i30b87vEo10GGeDhS/s/u
X-Gm-Message-State: AOJu0YwyPX6kCU/HORnWnLJElxy31pO4pMG01igEcg7tkEa+LsRIphSh
	XTMqrsl/0U052xyQrUV1OYc2TaKaBpUtmGbid9h76Rgqdrip4vbi7FDfyyZQJHA=
X-Google-Smtp-Source: AGHT+IFNa+gOgt0M4HZIlSz3Nu+an+rSzVrU5NorBMJZZdaN0POvqtdPbYOHzxoyFu//ZGEG4381HA==
X-Received: by 2002:a17:907:9689:b0:a47:1d3f:b2ac with SMTP id hd9-20020a170907968900b00a471d3fb2acmr569978ejc.76.1711575248851;
        Wed, 27 Mar 2024 14:34:08 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id d9-20020a1709063ec900b00a4737dbff13sm5865811ejj.3.2024.03.27.14.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 14:34:08 -0700 (PDT)
Message-ID: <8eb45771-096a-443f-b017-3ec8bc4940ba@linaro.org>
Date: Wed, 27 Mar 2024 22:34:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT] arm64: dts: qcom: sm8350: Reenable crypto & cryptobam
To: Luca Weiss <luca.weiss@fairphone.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>, David Heidelberg <david@ixit.cz>,
 Stephan Gerhold <stephan@gerhold.net>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240108-sm8350-qce-v1-1-b7d586ff38af@fairphone.com>
 <a5923bf7-0a05-43bd-b282-b45e5653ac4d@linaro.org>
 <CY9E4ZCHOMWU.C18NR0H7V1QX@fairphone.com>
 <CAA8EJppCAMXds5F4bgeb9VJSwph-+4ekVsJ=rGib5=RR5m0DPg@mail.gmail.com>
 <CZ6FR855VPP7.3GHX4EO9WEZIH@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
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
In-Reply-To: <CZ6FR855VPP7.3GHX4EO9WEZIH@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.02.2024 11:36 AM, Luca Weiss wrote:
> On Mon Jan 8, 2024 at 11:45 PM CET, Dmitry Baryshkov wrote:
>> On Mon, 8 Jan 2024 at 16:23, Luca Weiss <luca.weiss@fairphone.com> wrote:
>>>
>>> On Mon Jan 8, 2024 at 3:18 PM CET, Konrad Dybcio wrote:
>>>> On 8.01.2024 14:49, Luca Weiss wrote:
>>>>> When num-channels and qcom,num-ees is not provided in devicetree, the
>>>>> driver will try to read these values from the registers during probe but
>>>>> this fails if the interconnect is not on and then crashes the system.
>>>>>
>>>>> So we can provide these properties in devicetree (queried after patching
>>>>> BAM driver to enable the necessary interconnect) so we can probe
>>>>> cryptobam without reading registers and then also use the QCE as
>>>>> expected.
>>>>
>>>> This really feels a bit backwards.. Enable the resource to query the
>>>> hardware for numbers, so that said resource can be enabled, but
>>>> slightly later :/
>>>
>>> If you think adding interconnect support to driver and dtsi is better,
>>> let me know.
>>
>> I'd say, adding the proper interconnect is a better option. Otherwise
>> we just depend on the QCE itself to set up the vote for us.
> 
> Yes, currently we depend on that.
> 
>>
>>>
>>> Stephan (+CC) mentioned it should be okay like this *shrug*
>>>
>>> For the record, this is the same way I got the values for sc7280[0] and
>>> sm6350[1].
>>>
>>> [0] https://lore.kernel.org/linux-arm-msm/20231229-sc7280-cryptobam-fixup-v1-1-bd8f68589b80@fairphone.com/
>>> [1] https://lore.kernel.org/linux-arm-msm/20240105-sm6350-qce-v1-0-416e5c7319ac@fairphone.com/
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>>> index b46236235b7f..cd4dd9852d9e 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>>> @@ -1756,8 +1756,8 @@ cryptobam: dma-controller@1dc4000 {
>>>                         qcom,controlled-remotely;
>>>                         iommus = <&apps_smmu 0x594 0x0011>,
>>>                                  <&apps_smmu 0x596 0x0011>;
>>> -                       /* FIXME: Probing BAM DMA causes some abort and system hang */
>>> -                       status = "fail";
>>> +                       interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
>>> +                       interconnect-names = "memory";
>>>                 };
>>>
>>>                 crypto: crypto@1dfa000 {
>>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>>> index 5e7d332731e0..9de28f615639 100644
>>> --- a/drivers/dma/qcom/bam_dma.c
>>> +++ b/drivers/dma/qcom/bam_dma.c
>>> @@ -40,6 +40,7 @@
>>>  #include <linux/circ_buf.h>
>>>  #include <linux/clk.h>
>>>  #include <linux/dmaengine.h>
>>> +#include <linux/interconnect.h>
>>>  #include <linux/pm_runtime.h>
>>>
>>>  #include "../dmaengine.h"
>>> @@ -394,6 +395,7 @@ struct bam_device {
>>>         const struct reg_offset_data *layout;
>>>
>>>         struct clk *bamclk;
>>> +       struct icc_path *mem_path;
>>>         int irq;
>>>
>>>         /* dma start transaction tasklet */
>>> @@ -1206,6 +1208,7 @@ static int bam_init(struct bam_device *bdev)
>>>                 bdev->num_channels = val & BAM_NUM_PIPES_MASK;
>>>         }
>>>
>>> +       printk(KERN_ERR "%s:%d DBG num_ees=%u num_channels=%u\n", __func__, __LINE__, bdev->num_ees, bdev->num_channels);
>>>         /* Reset BAM now if fully controlled locally */
>>>         if (!bdev->controlled_remotely && !bdev->powered_remotely)
>>>                 bam_reset(bdev);
>>> @@ -1298,6 +1301,14 @@ static int bam_dma_probe(struct platform_device *pdev)
>>>                 return ret;
>>>         }
>>>
>>> +       bdev->mem_path = devm_of_icc_get(bdev->dev, "memory");
>>> +       if (IS_ERR(bdev->mem_path))
>>> +               return PTR_ERR(bdev->mem_path);
>>> +
>>> +       ret = icc_set_bw(bdev->mem_path, 1, 1);
>>
>> Probably this needs some more sensible value.
> 
> So downstream qcedev driver uses 384 for the interconnect. But this is
> crypto-specific and probably different BAMs have different minimum
> requirements?
> 
> #define CRYPTO_AVG_BW			384
> #define CRYPTO_PEAK_BW			384
> https://github.com/xiaomi-sm8450-kernel/android_kernel_platform_msm-kernel/blob/lineage-20/drivers/crypto/msm/qce.h#L57
> 
> Do you have any suggestion what to use here?

I'dve expected this to mean anything, but apparently not.

My immediate guess is that the 384 was the lowest magic value that didn't
result in the bus getting kicked offline.. 1 should be fine upstream due
to commit 91e045b93db7 ("interconnect: qcom: Fix small BW votes being
truncated to zero").

> 
> Also I'd assume that with pm_runtime suspended we'd need to clear the
> votes in the driver so we don't keep the interconnect alive
> unnecessarily?

My naive understanding is that the power should only be necessary when
the thing is in use, so early probe and pm-active sounds about sane..

Konrad

