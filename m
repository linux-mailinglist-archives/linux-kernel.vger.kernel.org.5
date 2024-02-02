Return-Path: <linux-kernel+bounces-49831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55E1847027
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4142FB2679C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEE2140787;
	Fri,  2 Feb 2024 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXYOI+0D"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3462313F01B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876442; cv=none; b=Z0hAXBRGc0P2+qQRm8hmRjKloLPgnPBLiE7H3wRbMdEQx5zxa0sPgREPy65H54AXMAk/mwyHlJ/yUjUmZhRo1am2OsqEirdoLZSaZXFajVUr+9cfIxpgJt07U/BJuBXV6FhpzGI00vo2qGKl7iKQng/J2q8yNkW8IWgiKLII6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876442; c=relaxed/simple;
	bh=9YZopy2TeHxgP0yzQOepMLgIqTR9PKUUU3JWfTdcnPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeRMAfe7UbqKY1j/gyaVZFjTsUSR1J16fyWfrD3M1PGbEKI/s1b+tlKFf4q0+rPeqwmD/RkFTh2fxW1axVeFNM3RnyxJr2evO3DV+V+e4Jq63KCtBdmFCJGaDACicUK0G4RlteiHDkwX8Ud9FhQOyboAaDQFYah9Gq4Ex79fgnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DXYOI+0D; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so2465141a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 04:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706876438; x=1707481238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEhP/kvo7+H18lNfoFAvBKQU0xRqI+1E+89VLjha/LM=;
        b=DXYOI+0DtyivwCwv748yuNyE6v5ouygyQUVod8y4XFjv3wHF40AStY6xY2axOY8FdA
         u4KqjfDxJYodVieQDXmBTWA+KZw/2HKg3uDN9XLRP9HRXwCk7OeboksbsyOKp9yQYahg
         rc+cUQO6Vls0Vke1tf0sVCqwanYOxSaQSfPGIymPPparts2bBAan4E1MFzFfgRYu+TIw
         6fttIMZG6c7ZJOLQWRatOHE4921tYv6iVE6svSa/RHmbXp4VckT6oqF1Y2zV/6sFWgR9
         yEwZqew4k8V3oPDNys8SjG87pMhjpiZeNui5eZ+bWJHr3+WhKMbQMZIaesLUB6AKHFbr
         CqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876438; x=1707481238;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEhP/kvo7+H18lNfoFAvBKQU0xRqI+1E+89VLjha/LM=;
        b=rYcrgSze3uQAWKn00C6n1XigeouCOE9Emy8ANZV2im7Y+Ue7KGToKvS6gPqJ8N1zx9
         MOCCCunCH3GFH/lZe3TDQdlYIPTVSUX3/qJe845fOl1fVn+6UdOg4NGh1O+LZBEhYsKs
         IM2hbSUYDMNC4+yO3qnajy1SD+TQXNw44eVPi/oYfulflRR9p+dK62xeFVeVBu/NEUz+
         frcrfypfj0BkPH3fOjLb0nMbr2sm1CzMBbMwBWibiMCh1wTWhF9SwCPvQ90RfY1Q7hZC
         vJARITafuTueWMJF6thG//xOPwctPpJEXJXGf7TxCcA5sDlXxCrstwe2FSv+pHljV9fl
         34pg==
X-Gm-Message-State: AOJu0Yx0HMZxkt4iRm/XCHLba9dCcXWGDhMw2jmNLWN/Nk7pWUzo5bcS
	v1Cku5qMJGZc5JU7BM1YOP3Evu0Z5cq/2ue3fnA/Yr+QqyX8NfQ3JUF9lRk5rv4=
X-Google-Smtp-Source: AGHT+IHEwghXMkMYvzhrYxzhjMV5XxasDfqebbFISQpYq3RlsI6QkgJUrVfM3rugUa15VEj18xzWqA==
X-Received: by 2002:a05:6402:33d6:b0:55f:eb11:8937 with SMTP id a22-20020a05640233d600b0055feb118937mr1116681edc.33.1706876438268;
        Fri, 02 Feb 2024 04:20:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUJ6CB6Kd/kBE2Og35lVxEEr7zhoybwpRuUZxuZrNZb6PCSVMO9J6jrihRsKrEf+yTKDKKIKv8jHcNnEfRZxsw+oQfXamBlKp4bJjgEOoRvdWcsSx0mStzcmemh0cLGQC2sBeHAeUnP9a+V0QkUQUhIXmq6OAAgQT7kZaZZDvgPQIGpBtjc77ZKZlLoEPaGY4SYoQJj9kcy0Z74BN1yDaAOVqx2VTno4UdFz2sMDJAs8j6BvabP6inxjXYhqgO4BvT3sn8TO6SLAD0nRcIuEacV+SUO9qu4uYwIpTuXNJKL7PDoYD45CKXDkFGmSWAYBe0riRz5W1XdzaXOpfDw13RzFP+A3FfNwJt0FA5j/24e8BPpNZuZFbu3T35yvOtRSkwb0vaxMeZtpg==
Received: from [192.168.159.104] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id c16-20020aa7c990000000b0055ef1d4fcb5sm751602edt.9.2024.02.02.04.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 04:20:37 -0800 (PST)
Message-ID: <7527574c-8faa-4ccb-9387-8563f75be3ab@linaro.org>
Date: Fri, 2 Feb 2024 13:20:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] arm64: dts: qcom: msm8953: Add GPU
Content-Language: en-US
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vladimir Lypak <vladimir.lypak@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240125-msm8953-gpu-v1-0-f6493a5951f3@z3ntu.xyz>
 <20240125-msm8953-gpu-v1-2-f6493a5951f3@z3ntu.xyz>
 <c58c5897-b3f0-4449-a5b1-df10b117733c@linaro.org>
 <4539846.LvFx2qVVIh@z3ntu.xyz>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <4539846.LvFx2qVVIh@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27.01.2024 18:32, Luca Weiss wrote:
> On Freitag, 26. Jänner 2024 00:50:43 CET Konrad Dybcio wrote:
>> On 1/25/24 22:56, Luca Weiss wrote:
>>> From: Vladimir Lypak <vladimir.lypak@gmail.com>
>>>
>>> Add the GPU node for the Adreno 506 found on this family of SoCs. The
>>> clock speeds are a bit different per SoC variant, SDM450 maxes out at
>>> 600MHz while MSM8953 (= SDM625) goes up to 650MHz and SDM632 goes up to
>>> 725MHz.
>>>
>>> To achieve this, create a new sdm450.dtsi to hold the 600MHz OPP and
>>> use the new dtsi for sdm450-motorola-ali.
>>>
>>> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
>>> Co-developed-by: Luca Weiss <luca@z3ntu.xyz>
>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>> ---
>>>
>>>   arch/arm64/boot/dts/qcom/msm8953.dtsi            | 115
>>>   +++++++++++++++++++++++
>>>   arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts |   2 +-
>>>   arch/arm64/boot/dts/qcom/sdm450.dtsi             |  14 +++
>>>   arch/arm64/boot/dts/qcom/sdm632.dtsi             |   8 ++
>>>   4 files changed, 138 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi
>>> b/arch/arm64/boot/dts/qcom/msm8953.dtsi index 91d083871ab0..1fe0c0c4fd15
>>> 100644
>>> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
>>> @@ -1046,6 +1046,94 @@ mdss_dsi1_phy: phy@1a96400 {
>>>
>>>   			};
>>>   		
>>>   		};
>>>
>>> +		gpu: gpu@1c00000 {
>>> +			compatible = "qcom,adreno-506.0", "qcom,adreno";
>>> +			reg = <0x01c00000 0x40000>;
>>> +			reg-names = "kgsl_3d0_reg_memory";
>>> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>>> +
>>> +			clocks = <&gcc GCC_OXILI_GFX3D_CLK>,
>>> +				 <&gcc GCC_OXILI_AHB_CLK>,
>>> +				 <&gcc GCC_BIMC_GFX_CLK>,
>>> +				 <&gcc GCC_BIMC_GPU_CLK>,
>>> +				 <&gcc GCC_OXILI_TIMER_CLK>,
>>> +				 <&gcc GCC_OXILI_AON_CLK>;
>>> +			clock-names = "core",
>>> +				      "iface",
>>> +				      "mem_iface",
>>> +				      "alt_mem_iface",
>>> +				      "rbbmtimer",
>>> +				      "alwayson";
>>> +			power-domains = <&gcc OXILI_GX_GDSC>;
>>> +
>>> +			iommus = <&gpu_iommu 0>;
>>> +			operating-points-v2 = <&gpu_opp_table>;
>>> +
>>> +			#cooling-cells = <2>;
>>> +
>>> +			status = "disabled";
>>> +
>>> +			zap-shader {
>>> +				memory-region = <&zap_shader_region>;
>>> +			};
>>> +
>>> +			gpu_opp_table: opp-table {
>>> +				compatible = "operating-points-v2";
>>> +
>>> +				opp-19200000 {
>>> +					opp-hz = /bits/ 64 <19200000>;
>>> +					opp-supported-hw = <0xff>;
>>> +					required-opps = <&rpmpd_opp_min_svs>;
>>> +				};
>>
>> If you remove all OPPs but this one, can the GPU still spit out pixels?
> 
> Yep, phosh is starting and is rendering at a few fps.
> 
> fairphone-fp3:~$ cat /sys/devices/platform/soc@0/1c00000.gpu/devfreq/1c00000.gpu/min_freq
> 19200000
> fairphone-fp3:~$ cat /sys/devices/platform/soc@0/1c00000.gpu/devfreq/1c00000.gpu/max_freq 
> 19200000
> fairphone-fp3:~$ cat /sys/devices/platform/soc@0/1c00000.gpu/devfreq/1c00000.gpu/cur_freq 
> 19200000

Interesting..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

