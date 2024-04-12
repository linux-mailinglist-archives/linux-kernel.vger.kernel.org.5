Return-Path: <linux-kernel+bounces-143159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 207F58A352D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19191F23FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F35414F10D;
	Fri, 12 Apr 2024 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J40qsZ/o"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1614F103
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712944403; cv=none; b=VrX2+rVsKidLh7Qps1EeAcGNAeYQXZFbG9VMznnNfDwlI55C6avWg0ZS5Fok0/Q0tM7/4vJXGgTpvlP72xVnEc+3rIf36j330kg/6cq6QCmbKh5Vz5Queu9Qc+xbxu+Hg7RWSUP0odrOhA2C9toJKTq6naPXaGvRs1Kh3xuFgXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712944403; c=relaxed/simple;
	bh=Vy2PIzMgnUyeUzulkPx73WrRDMmKgp/2MfijXqNpzkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4fbuUr2sxMrV6K+Lc05aw5ukPw0LVOtQNHyKaS4Ts5H++WF2dSCsHzkpOshPQUsF2ue99RVAjfJnDBGnn3QlZkbYT/ul4OInjesDyWs2i+g7Z8vc1xJra+yC/7n1mhDE98ULlAebmmHZCJPps3UsXQi/yoizfslq8tiMFbSOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J40qsZ/o; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46a7208eedso162360266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712944400; x=1713549200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nKSg4RwnYAFK/sdZVIxX1EI01vqvwtxplSvYVO3pwdw=;
        b=J40qsZ/oCObbwCh/3eaCg98IrVG7FuMDYzTgR7tAr7+0AHWRwmBFLnGbwTAxwa+fg8
         IN5IMXTEKcQ+GcnSHzloYNxw0VEgauPZblmCp2uZ4ZE0beeFYmehl8CWIcJDmiRuU7lB
         oSgFTVGdBIhnGGQk4pAcaYiD/rxyTUPUzioMdKgdOm1LketMhEdhQlGyqQYy54MHhhQH
         VozbQc497XqoqMo8HudyEmv/NN1lE4eGcEkZJad71LSdhwR8I8syRbOgajRen7v4ANQz
         98Cdge0jb60qW7p5EI9sdc9oL87YCj5rX7dfjVFncBukeijGTj+Ns2rTUCLKAdIPia+i
         3JjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712944400; x=1713549200;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKSg4RwnYAFK/sdZVIxX1EI01vqvwtxplSvYVO3pwdw=;
        b=Y5iaU+4n3sZcBiV8sFfelS1cJ2E7N6qpQ/FYeMPGAIGQpAyfvmvsIKI0T3SNJqXWyY
         2i6m7j9mGqP995oVS85UYoGbBIu6IjAYb/Oz84Sz49ApAT3S3UBDFD6GNrFudAZ3fi63
         u7x3HSVJZQYNAKIkUqPC0vzhImiJ5pcqrolrzcyeObhz3IYVS0H04sq6B2WZJLuXh+AT
         Jhdlf7hCb/9DCmKN6gHLO/YxfrGx+2sFm7yWdS48kp33wFDchaDhviIQUTZIGRDTBwbP
         uAOQaCn71DacCKvGxiAua+e6OX9AbhRAZW32igLrhcCx+6UomrF184q+S2VEPhLJ2yy3
         28WQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3T5EB5n0/MCGGZe9tN8y2Dki4/wLwuLoU/GZylbymiyjZVDi9jx43ak+yaHYuhkVs7siXhVpemf+BBAK2tbA3TIKljnVrF/9fOZcM
X-Gm-Message-State: AOJu0Yzm/yN2FSJ9qM1kCMH3jIBEvzRViSafCiOsLCjnfr52nyXIllW+
	6s0VQVP3lgQrNJK/Ayyoir96IyhaLsie1jTlCv7ZgOzFGdQRc4RHbUuimVz9M3s=
X-Google-Smtp-Source: AGHT+IE+48AwCZJK1tO3vPUrupImxUEL4FlsEHnWSK5nuwyle2XzTwNHPamxrL/MXwiOKVnKZh8Acg==
X-Received: by 2002:a17:906:e2cd:b0:a52:b11:5406 with SMTP id gr13-20020a170906e2cd00b00a520b115406mr2043944ejb.16.1712944399823;
        Fri, 12 Apr 2024 10:53:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id bb2-20020a1709070a0200b00a520e463227sm2061592ejc.127.2024.04.12.10.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 10:53:19 -0700 (PDT)
Message-ID: <dca6c1bf-4e7f-4177-bfe6-f43e0591b535@linaro.org>
Date: Fri, 12 Apr 2024 19:53:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8155p-adp: fix SDHC2 configuration
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Stephan Gerhold <stephan@gerhold.net>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240410134022.732767-1-volodymyr_babchuk@epam.com>
 <20240411115506.1170360-1-volodymyr_babchuk@epam.com>
 <769a6a2a-2f38-42de-b3ce-8585b8b0a758@linaro.org> <87v84m4nah.fsf@epam.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <87v84m4nah.fsf@epam.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/04/2024 17:24, Volodymyr Babchuk wrote:
> 
> Hi Krzysztof,
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> 
>> On 11/04/2024 13:55, Volodymyr Babchuk wrote:
>>> There are multiple issues with SDHC2 configuration for SA8155P-ADP,
>>> which prevent use of SDHC2 and causes issues with ethernet:
>>>
>>> - Card Detect pin for SHDC2 on SA8155P-ADP is connected to gpio4 of
>>>   PMM8155AU_1, not to SoC itself. SoC's gpio4 is used for DWMAC
>>>   TX. If sdhc driver probes after dwmac driver, it reconfigures
>>>   gpio4 and this breaks Ethernet MAC.
>>>
>>> - pinctrl configuration mentions gpio96 as CD pin. It seems it was
>>>   copied from some SM8150 example, because as mentioned above,
>>>   correct CD pin is gpio4 on PMM8155AU_1.
>>>
>>> - L13C voltage regulator limits minimal voltage to 2.504V, which
>>>   prevents use 1.8V to power SD card, which in turns does not allow
>>>   card to work in UHS mode.
>>
>> That's not really related. One issue, one commit.
>>
>>>
>>> This patch fixes all the mentioned issues.
>>>
>>> Fixes: 0deb2624e2d0 ("arm64: dts: qcom: sa8155p-adp: Add support for uSD card")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>>>
>>> ---
>>>
>>> In v2:
>>>  - Added "Fixes:" tag
>>>  - CCed stable ML
>>>  - Fixed pinctrl configuration
>>>  - Extended voltage range for L13C voltage regulator
>>> ---
>>>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 32 +++++++++++-------------
>>>  1 file changed, 14 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
>>> index 5e4287f8c8cd1..b9d56bda96759 100644
>>> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
>>> @@ -283,7 +283,7 @@ vreg_l12c_1p808: ldo12 {
>>>  
>>>  		vreg_l13c_2p96: ldo13 {
>>>  			regulator-name = "vreg_l13c_2p96";
>>> -			regulator-min-microvolt = <2504000>;
>>> +			regulator-min-microvolt = <1800000>;
>>>  			regulator-max-microvolt = <2960000>;
>>>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>  		};
>>> @@ -384,10 +384,10 @@ &remoteproc_cdsp {
>>>  &sdhc_2 {
>>>  	status = "okay";
>>>  
>>> -	cd-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
>>> +	cd-gpios = <&pmm8155au_1_gpios 4 GPIO_ACTIVE_LOW>;
>>>  	pinctrl-names = "default", "sleep";
>>> -	pinctrl-0 = <&sdc2_on>;
>>> -	pinctrl-1 = <&sdc2_off>;
>>> +	pinctrl-0 = <&sdc2_on &pmm8155au_1_sdc2_cd>;
>>> +	pinctrl-1 = <&sdc2_off &pmm8155au_1_sdc2_cd>;
>>>  	vqmmc-supply = <&vreg_l13c_2p96>; /* IO line power */
>>>  	vmmc-supply = <&vreg_l17a_2p96>;  /* Card power line */
>>>  	bus-width = <4>;
>>> @@ -505,13 +505,6 @@ data-pins {
>>>  			bias-pull-up;		/* pull up */
>>>  			drive-strength = <16>;	/* 16 MA */
>>>  		};
>>> -
>>> -		sd-cd-pins {
>>> -			pins = "gpio96";
>>> -			function = "gpio";
>>> -			bias-pull-up;		/* pull up */
>>> -			drive-strength = <2>;	/* 2 MA */
>>> -		};
>>>  	};
>>>  
>>>  	sdc2_off: sdc2-off-state {
>>> @@ -532,13 +525,6 @@ data-pins {
>>>  			bias-pull-up;		/* pull up */
>>>  			drive-strength = <2>;	/* 2 MA */
>>>  		};
>>> -
>>> -		sd-cd-pins {
>>> -			pins = "gpio96";
>>> -			function = "gpio";
>>> -			bias-pull-up;		/* pull up */
>>> -			drive-strength = <2>;	/* 2 MA */
>>> -		};
>>>  	};
>>>  
>>>  	usb2phy_ac_en1_default: usb2phy-ac-en1-default-state {
>>> @@ -604,3 +590,13 @@ phy-reset-pins {
>>>  		};
>>>  	};
>>>  };
>>> +
>>> +&pmm8155au_1_gpios {
>>> +	pmm8155au_1_sdc2_cd: pmm8155au_1-sdc2-cd {
>>
>> No underscores in node names.
> 
> Fill fix.
> 
>> Please also follow tlmm style of naming nodes.
> 
> Just to be on the same page, will "pmm8155au_1_sdc2_cd: sdc2-cd-pins" be fine?

pins are for sublevel, so you want -state. Just like other pmic GPIOs.

> 
>> Also does not look like node is placed in alphabetical place. Where did
>> you put it?
> 
> I can't say that the file is sorted in the first place:
> 
> # grep "^&" arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> &apps_rsc {
> &ethernet {
> &qupv3_id_1 {
> &remoteproc_adsp {
> &remoteproc_cdsp {
> &sdhc_2 {
> &uart2 {
> &uart9 {
> &ufs_mem_hc {
> &ufs_mem_phy {
> &usb_1 {
> &usb_1_dwc3 {
> &usb_1_hsphy {
> &usb_1_qmpphy {
> &usb_2 {
> &usb_2_dwc3 {
> &usb_2_hsphy {
> &usb_2_qmpphy {

Was sorted till here...

> &pcie0 {
> &pcie0_phy {
> &pcie1_phy {
> &tlmm {

and here second sorting started...

> &pmm8155au_1_gpios {

and you started third.

> 
> 
> So, I can put after &pci1 to have it grouped with other entries that
> start with p*, or I can put right after &ethernet to make it appear in
> alphabetical order. It is your call.

Please put it in the first group, so after ethernet. If this gets ever
sorted, then at least one less move.

Best regards,
Krzysztof


