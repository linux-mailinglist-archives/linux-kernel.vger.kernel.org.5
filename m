Return-Path: <linux-kernel+bounces-49826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29321847018
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EAE1F282A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC0914079C;
	Fri,  2 Feb 2024 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIPmnWw5"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6656913F00D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876405; cv=none; b=d9B2wcdRc8sjeUm+r/0UOe0iKhA8bxvdBRoyRQdGwxId3nNq4GjjDeGjR/nLa/yiD/D0c8C/h1Q7bIRsXXq2UQ6UR4Ap1Y/HKyPGRL5gPLF8o7lNwO86f2/13gNgH3sOoxP05J16tNpv1JK/wmHNBsEyN0Efh22gGekdaYsG6EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876405; c=relaxed/simple;
	bh=ZFLQdei8xlg1cwqkesOsjr5bgM9I79Lr3BOF4Qbotno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVUD25p4+dLAR9tg7P3a4SADVZRw9VaQK63bDNAU6WM/MtpCrdfDG9yH6XAQz+o7Zv7T7RerejQx5+tIrYPBSshrDuqeWPmvT4jVtVK+9BiMM+57xD4nnBkEfNtlszBvQG8GPl+/5VgqRVxlFxf5gSduipqkPaHWgWn+EHbPd4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xIPmnWw5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so2892864a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 04:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706876400; x=1707481200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiajaXq4ADJJJV5m89dGHzIE2BPOaQ5OEIoMtsAKSSw=;
        b=xIPmnWw5JxcztMy5CboIwIuMMm41oExIwr+OE7BnWKRAFXZzXXofRfaPS52eEBq7tJ
         lsTS+To5l/QAj7JOnCHSyNKIr+6vCOkE+xSCF6TM8noEkv+IlE1Aa7XH6VsXI/U5SBt8
         cstU6oYOWPUIryAxvw/jg/tK9XM/x1tgn0qCXccdUKFF5UATA24BrkgNNlsZJX3fPjk/
         qZOwT+Dj3wnD1FFhOAwyl55gg3LNjoi3peT/C422bvclz13LQ/7Ybg7ki8nAxPmKnHdy
         f2SDDCzHwLPE6eFrgFHV4dC2yLpQfMv+ifNmcp+qt+ZOJ+QfWpE7WWeKSgDlBrQqYsGD
         hEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876400; x=1707481200;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiajaXq4ADJJJV5m89dGHzIE2BPOaQ5OEIoMtsAKSSw=;
        b=Z8CNh2u5e1X7W0iFeDtvhXVOHdrDvHnS6YSWvZlBVemOdKTkJe7RLsnM9tBwJYhtFx
         t7khtN8HtOYuNXC/VO0KylSVo6uF5/Dqwb31xZ6lQprkQa7yjctTz3Lezmq7ZqIQTVHc
         VxQudLXJeSXPJ4wgK6kAQ2P5385+yox6SHYJaMmcQSdAvK+U4bY9snV0LgapWyH+rwPA
         Y30RDH0fZbfAcV2Rw2YxzLsVcpf7N+emzgS/0adfnwdpFMqgUUhQC9YbG9KpxrfRyyQu
         ZHbhiWeXYXjZ0SPW1z8JbmaizkoDarZxKT5tUgFUjhMROhF+unECADXv4HVwzR+cUa4G
         joaQ==
X-Gm-Message-State: AOJu0YzUY3cfmRKwAjUTNwe5vZaoQyGVF3ZBAEI/IjAZVH8U+tjKc9Ie
	gKGKqmNYED610wEcJN2dAL6kuiw5dPVG7A5GL3mH96WH30U1QkCzBWyC1G0+kTU=
X-Google-Smtp-Source: AGHT+IFcMewJjcknQFXbl/2jGBD++vhG15oI4+ONCQPvlMd7FtZTjhXyojzsYeR+ZVbm5x27KGzOCw==
X-Received: by 2002:aa7:c444:0:b0:55f:fd22:ff6e with SMTP id n4-20020aa7c444000000b0055ffd22ff6emr779342edr.39.1706876400517;
        Fri, 02 Feb 2024 04:20:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUKttvY3oKSyHZXC8LNqHvkOTYN6ZYqt2BnSlOUcJYynbbCZxUdaRqhPOzV7i2Vx99T3vsnsyMyZkXBZaCEQj10idzfGibTtC9cXmmL4c3CbIny3z4pDsjTGSBIMuTAysWZ71tNZ2HqtStFQQUDUcspk46g9BP0Wsdeg9D7q4YfiC5dEk7PNvAaXNDRenTUYdpSSqGulOPNESuc8XnX7AHo1hG1rSizLgJ5W4y8UJj5LPkMhSTLUYmSm52KHV1CoH9eI6TfJ5ycamXs4MdWsJ/YHKIQ5bt361YoZDncZxyJdlZ1wvXnNAvsltt84QYs3mBJ0xRa8qOYtsncepA2XW3h/AmBpB0Mdy+l8yc365irLFWQjqGtvxJEu46fVpWGEcYmf8rddKSssLANFjKDMSk6decyba1kcHuCE5pO4QOveVEp0S2H
Received: from [192.168.159.104] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id c16-20020aa7c990000000b0055ef1d4fcb5sm751602edt.9.2024.02.02.04.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 04:20:00 -0800 (PST)
Message-ID: <9dabe028-278c-4273-8a57-1cb080c1019d@linaro.org>
Date: Fri, 2 Feb 2024 13:19:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] arm64: dts: qcom: msm8953: Add GPU IOMMU
Content-Language: en-US
To: Luca Weiss <luca@z3ntu.xyz>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vladimir Lypak <vladimir.lypak@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240125-msm8953-gpu-v1-0-f6493a5951f3@z3ntu.xyz>
 <d576e655-5d00-44ff-9405-0fceaa2d3935@linaro.org>
 <a75d8b2f-a55a-4087-b039-60769678a480@linaro.org>
 <6009977.lOV4Wx5bFT@z3ntu.xyz>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <6009977.lOV4Wx5bFT@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27.01.2024 18:24, Luca Weiss wrote:
> On Freitag, 26. Jänner 2024 00:49:55 CET Konrad Dybcio wrote:
>> On 1/25/24 23:24, Dmitry Baryshkov wrote:
>>> On 25/01/2024 23:56, Luca Weiss wrote:
>>>> From: Vladimir Lypak <vladimir.lypak@gmail.com>
>>>>
>>>> Add the IOMMU used for the GPU on MSM8953.
>>>>
>>>> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
>>>> ---
>>>>   arch/arm64/boot/dts/qcom/msm8953.dtsi | 31
>>>> +++++++++++++++++++++++++++++++ 1 file changed, 31 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi
>>>> b/arch/arm64/boot/dts/qcom/msm8953.dtsi index dcb5c98b793c..91d083871ab0
>>>> 100644
>>>> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
>>>> @@ -1046,6 +1046,37 @@ mdss_dsi1_phy: phy@1a96400 {
>>>>               };
>>>>           };
>>>> +        gpu_iommu: iommu@1c48000 {
>>>
>>> Nit: most of the platforms use the adreno_smmu label. But maybe the
>>> msm-iommu vs arm-smmu makes difference here.
>> Not really :)
>>
>> Please keep the labels unified
> 
> Ack, renaming to adreno_smmu
> 
>>
>>> Nevertheless:
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>
>>>> +            compatible = "qcom,msm8953-iommu", "qcom,msm-iommu-v2";
>>>> +            ranges = <0 0x01c48000 0x8000>;
>>>> +
>>>> +            clocks = <&gcc GCC_OXILI_AHB_CLK>,
>>>> +                 <&gcc GCC_BIMC_GFX_CLK>;
>>
>> And align these
> 
> They are?

Not in my email client :P, anyway..

> 
> Also any comment about the issues listed in the cover letter?

I think v2 on all smmus on this platform is right

Konrad

