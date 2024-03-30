Return-Path: <linux-kernel+bounces-125677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4B8892A95
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 425B3B21B5A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CAB200D3;
	Sat, 30 Mar 2024 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V10I3fP5"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3EA847B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711795746; cv=none; b=UY7C8npgHs2y2EBmZF09/SVbvN8YiB3qkjbopFXskle2pBl0YQpa73Fk9PuDqrn3lFAO/DXPx2/T8NlfMinH3rSPzbZdQCXh8Fz5OSITDxubQ6eWBI+8nR+DjAXrnDDjhNybuNjshhvqlQzY88KMnQK8hwi27uzuQanWayU/YRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711795746; c=relaxed/simple;
	bh=Fie83Ur35U5dwCPM3XNg4UvVRiW8SyttaizmxIyHq0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SU8XjdbThsKCbIIWcqXXEaCbu8bIzPjwyTHis8Gwg/jT9UG1ShD2EGYzs41QNDxGYdJdRO2vKjCLbjgv16VcdmtrI3DQPKmV8CJjNzH+b5BaLIzOFdZ5N0Kc8FMcBNb5Zm/pcSwkq12Evw6FDjeTTadp/F2cVGjhw5Lz8y1CBg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V10I3fP5; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-515d515e28dso548941e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 03:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711795743; x=1712400543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=un3fHiejt3KZtcwdyk+vlvF4AaAWx68iRqYDfnOW7g8=;
        b=V10I3fP5FKWCUbPRq0rYzgEA7U6eNKqlBGSYppZ/SxjewufB6utYhI6OPu/VRkbOKk
         BW1DmG304SP5bvayTuNCgjYiphV8GGw+inLBKkDvmyKsObXKex+FTgnFmOf/vg+QbZk2
         Vr0wgIgiGXDTEUpZy6e/CV1G0msIPfbFQ8XzjYEZcR/GcD+HBXB+37OJZgnO5DnzvcZV
         bHewZ21gm1y91fVuyoWUDX+C2hcCMyXye4JWT4mpMFI8b77OROSNUgm9feyLA+y71SQJ
         P3Z1ZKYME3IN9XX4IFvIL5NWuGwlzx++IhboDUqFZrRZC9dJ6QKHJXa439lpFOY15LRC
         Chjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711795743; x=1712400543;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=un3fHiejt3KZtcwdyk+vlvF4AaAWx68iRqYDfnOW7g8=;
        b=bjzKcQi++Jv+Bu6vMf6F5DW+Np2LyhS8wXJ/mUC2T4MyrN9v57NOKnTeqDEAy+ui/N
         Tec8c/FvCwor6LJq3c455N6DqSj4/jRF116SMZuQclMuuF8aD42KOrd9EG2wPBIlhyY3
         p8+PCuRDaLldwZGnnhWxj6rvpSwY4hjV4IxhhWMgv43iNT99k3cVwcrxwedqd//W4Gev
         wAzAUnThQOBFmb7sBPsrged8Z1OKSx/fRPWx3kbLZcTOqArPmbusZB90zWHEbVtg5yZC
         4AYITEqF+qUB5FAucTNej4/MYPL3xoHCJBC2eM9k6UeWG5NhGNt/vDgRoUTOMSLGcXGh
         XKmg==
X-Forwarded-Encrypted: i=1; AJvYcCVZqZrDOqZNbPAZBglX6gBEhvHmUk1yrZWt7NXqxhNc9q2JIuhirTo7dma5jBKda4cX3vV1U/Zfy5oGV29uUWLQBYwxW1UV3rgCfL3F
X-Gm-Message-State: AOJu0YyWFlfzxauNeDmpcqIvhZ7mAku/DzAAKZwje2npcLc6lC/iSAHQ
	kyZA/q6Edsh5fyfdY9ONyqaVQx02S7MtCJcQNAvkABoWmOwFeT9S7tMKSsnOSt4=
X-Google-Smtp-Source: AGHT+IGyaJ6/Q7nOE51rfTsnnprCvYRIm9EA7tmhz4Y/IJGoj+wPj0Hrpj/e2/Nw6BKWJ2VgR3Ziyw==
X-Received: by 2002:a05:6512:3e08:b0:515:d24e:4e2e with SMTP id i8-20020a0565123e0800b00515d24e4e2emr3093407lfv.20.1711795743102;
        Sat, 30 Mar 2024 03:49:03 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id o10-20020a170906774a00b00a4e472a8e54sm832430ejn.48.2024.03.30.03.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 03:49:02 -0700 (PDT)
Message-ID: <07f9c7e1-b215-45eb-af96-8ab45dc00cce@linaro.org>
Date: Sat, 30 Mar 2024 11:49:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: pm6150: correct USB VBUS
 regulator compatible
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danila Tikhonov <danila@jiaxyga.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240330091311.6224-1-krzysztof.kozlowski@linaro.org>
 <20240330091311.6224-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240330091311.6224-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.03.2024 10:13 AM, Krzysztof Kozlowski wrote:
> The first part of the compatible of USB VBUS node misses ending quote,
> thus we have one long compatible consisting of two compatible strings
> leading to dtbs_check warnings:
> 
>   sc7180-idp.dtb: usb-vbus-regulator@1100: compatible:0: 'qcom,pm6150-vbus-reg,\n qcom,pm8150b-vbus-reg' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._/]+$'
>   sc7180-idp.dtb: /soc@0/spmi@c440000/pmic@0/usb-vbus-regulator@1100: failed to match any schema with compatible: ['qcom,pm6150-vbus-reg,\n          qcom,pm8150b-vbus-reg']
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: f81c2f01cad6 ("arm64: dts: qcom: pm6150: define USB-C related blocks")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

