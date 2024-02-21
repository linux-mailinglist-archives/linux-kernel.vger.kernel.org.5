Return-Path: <linux-kernel+bounces-74896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BB585DFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9441F1C24007
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660967F7EF;
	Wed, 21 Feb 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yS9l3byX"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F169D13
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525904; cv=none; b=FnIpOSRXgdhC/5IRY7wng+g6oXUb8qNNwRha6B/58BEW2KN8SCb0u8MyvA1ffj7hAPcgEFK5k5Qr2QS3F+EHrRzYMmy3i+go2c1SAgOlHa5AqKCdp1EQlJQMtjKpMXDj32VpINJj8JOBaZeSXNQohDqHeHvZeWiOVZfBy4lpQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525904; c=relaxed/simple;
	bh=tIlda+yBAO+nKMsxQJQvIb26CRGsj/VptIeKeX7mTUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOKV0V06xQ6SphKJJegeuw4jFy1gPT24u02XfvYJxOwA3ki4C88NpkHG7P5p4ePmxi2WnhnWtiC9LqcuBcNn+qCR3YAsmEauIsBmu3h4KvkuSg4aDg84bsrHK13L+pM2LVQwvum+m0bmbwWnbzldGvc8XxnZGQLOckbNKKFtmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yS9l3byX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so1083775a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708525900; x=1709130700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2JdI3YAxaGTmA0HoW3eMpz5feqBHWJQ7MSJAU6hfHw=;
        b=yS9l3byXDk2MoaPQVWeHGqrSgGl4Ff/C2guYaaKDfPe0Brn0+T+jK946Hu6UFewG+k
         Yd4gbdZe4c5okupyNMcrTF1ydxVuEZgVW3TKJzlAohJW2VF3o28+4MSqhkcYN/ceqzgJ
         kL3PnnCkM3JkEIpaeSFlV4fMR1cDcLXjkIwMBs2URXFlcwW5IEqlpeteklwMaskFffqn
         WOM+T5MZD0zzR7HgRCV/kcCipG82fIUgfwnpYlYisLaddgkfAt9zANXhUZdIblNO9rtV
         PLSQqAvE5QiX4slAPdW+DEW+1gzsOGWm25B0XQVedPisTatSbmuSwUmn/WzOzy2viumK
         SwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708525900; x=1709130700;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2JdI3YAxaGTmA0HoW3eMpz5feqBHWJQ7MSJAU6hfHw=;
        b=DZZXSEp4NRrmocEkH3ykdXuvk6OszYL76EebD7pwysbuq/W7MX4fXWRoaslcw0FWA5
         MTNvqg4+i6VZS6eYDMGdCyZuaIMWgA+++HMdeY6UFdmyAE3iKRIL+lib+05xUeLE5X/j
         MPThvpP0qL2NEH3PhDBp1C+Hb20wXNRhjYG1mTJoDF5044CRBLdd2s+CXfwEFvXtp/8U
         HiFcaAXPGCt+mDWWIhi3bEDYihGxIS+mokc0IUXfgRf4g30u43KthtBeX+sLL6HyHfcq
         7N2Epp62fMC3x19wGhrsaY1S8Z9XfJRqXN05sNY5824T/aYaFvDSoH9KuAKa94s9tIbm
         m13g==
X-Forwarded-Encrypted: i=1; AJvYcCVqqPPxMBkpwm6TW1uQPzGX1ZhS69L7VJilwVU3TNFJyXOtTko9l6Q6Ko+IjXdTCo0iUkoG5JLIb3HIYvvFFemCJ+qImDxDr4f2rfIK
X-Gm-Message-State: AOJu0YxJ2/DII7K2hYOtIG/jzu9Zk+zjbVnZw8e4W4GrMimOYQn02vWT
	JlH+zUER9T/g+jgUYTM1hDwMOysGRosxJ6ity5MDihY5My3Mj3APTtGw+FORikE=
X-Google-Smtp-Source: AGHT+IEDJ16WYJiD+UFATfu6RX4YFohZBjzeM38hER/3jaUSl/tHjrnZnyOYfGy86xU3JxF7qtUdgA==
X-Received: by 2002:aa7:d343:0:b0:564:5109:25c5 with SMTP id m3-20020aa7d343000000b00564510925c5mr6766060edr.13.1708525899759;
        Wed, 21 Feb 2024 06:31:39 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id eo11-20020a056402530b00b00564acce7d31sm1995424edb.45.2024.02.21.06.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 06:31:39 -0800 (PST)
Message-ID: <a0677780-d013-44f7-94bf-ea7e23aab019@linaro.org>
Date: Wed, 21 Feb 2024 15:31:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: qcom: Add global irq support for
 SA8775p
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 root <root@hu-msarkar-hyd.qualcomm.com>, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, jingoohan1@gmail.com,
 gustavo.pimentel@synopsys.com, manivannan.sadhasivam@linaro.org,
 conor+dt@kernel.org, quic_nitegupt@quicinc.com
Cc: quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
 quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
 quic_vbadigan@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240221140405.28532-1-root@hu-msarkar-hyd.qualcomm.com>
 <20240221140405.28532-2-root@hu-msarkar-hyd.qualcomm.com>
 <08ca89da-d6a1-440c-8347-f2e31222bede@linaro.org>
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
In-Reply-To: <08ca89da-d6a1-440c-8347-f2e31222bede@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.02.2024 15:28, Krzysztof Kozlowski wrote:
> On 21/02/2024 15:04, root wrote:
>> From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>>
>> Add global interrupt support in dt-bindings for SA8775p RC platform.
> 
> What is this global interrupt? Why wasn't it there before?
> 
>>
>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>> ---
>>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 26 +++++++++++++++++--
>>  1 file changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index a93ab3b54066..d86fb63a2d2c 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -63,7 +63,7 @@ properties:
>>  
>>    interrupt-names:
>>      minItems: 1
>> -    maxItems: 8
>> +    maxItems: 9
>>  
>>    iommu-map:
>>      minItems: 1
>> @@ -873,8 +873,30 @@ allOf:
>>          compatible:
>>            contains:
>>              enum:
>> -              - qcom,pcie-msm8996
>>                - qcom,pcie-sa8775p
>> +    then:
>> +      oneOf:
> 
> No need, drop.

Moreover, I think this global irq should be present on all qc platforms

Konrad

