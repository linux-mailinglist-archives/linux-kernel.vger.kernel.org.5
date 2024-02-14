Return-Path: <linux-kernel+bounces-65985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D11398554C8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582111F2249B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F0413EFFD;
	Wed, 14 Feb 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJbqnp4v"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA3413B7A6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945965; cv=none; b=IQCEuwEmlatZyjNfnDiBFSW3bevHDB8PPCS30YHTACi6aCX2g8E1ujKsb3V0yY+v4RiRUoWis/+j/CBGO6A/k2EgppjqDB0zibRYiA2o5nK/QcIFYDi9K8YrHAE9n6eE+FAYGVPgfXlumyz6SCNXAfGU62V1oyJc9O+8CjgkMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945965; c=relaxed/simple;
	bh=oaiUPMkAp8jC6JLP4yuy4naVAJPbARycV+mYUfgPxEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fw3bA+7U8JLmyxoPdB44kBNVrhVZC/IP/o4CRhrA7EkUU1Iwic/4+8VPEJ1pL5HBz9cM8CtYDW4yEdBGTCtHNLORhGq0nG8LiOF4wmF0bXQ5QRNuayXBZ1oBWBP0VYaThX6yoQets+TgCSO1HcVUbp5sutdt7qq2T3gI2B4DYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fJbqnp4v; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5639b00a25cso292680a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707945961; x=1708550761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UeI6ueEZISbOKE339VfpwspxNu7S+AXBqVSOxQ+7kNQ=;
        b=fJbqnp4vwcYYioaRIV7vUx/yIcSm+OY6I0k0vNU0LqcP7eXXub7PlfTSocVvu/Evd+
         usm44o7UbRV8f9idoATWF7Bf2uIpj3/IscrMmx/F56b37ftoEKbSzBlj3moOoWN/GhTf
         wfQpW0KIFQg9wYJTetY5l5Naol77TigXAqgpUESJaH6UBDvoOm4yiJiNJQwSgdtST8C3
         84wj2GjltCSzS/8MX6lzOZgsGbb/tP0w96VL6RWE4xOHHCeLpGpDECh84tAh4i1roKV3
         ufieEZr0k4AZPJYa2pUJnUTUX1Kfhu/RqcI7O4r60JDzbxNBSbEgHRSwhsuFBosmc5Vs
         6h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707945961; x=1708550761;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UeI6ueEZISbOKE339VfpwspxNu7S+AXBqVSOxQ+7kNQ=;
        b=VCg7sw0J04wB/FIfEuZA1rGDasOfpt06V+CpH8jPxXK0fDXCDK5ynnIuMskaMkixKF
         3jxlgVyQmdBiphY9ZrK+cC/qzjhBbTqzytRDBm6s8+LMImG8vtFp9f1r95jY4Qfyl6hv
         UsLcz1OqZ2uE+j2vOoMoKZB8qJTvn3e/gMt/ad4vcEa/RbfL41tpz4PkwoZP65IT1I04
         3IhM9wVx3llamNeUQDcY5aKSXpPmbIiMFVo1IaAjv9mlaeROf/0aNDofzNBHy1R78PpQ
         UWayXK0GZtTg9AJjgtG2lnVQ0SusPvyPO7PTrMF0Mj6x8QS1I3KzHuLaIZHbSeZ9r7TJ
         bDRw==
X-Forwarded-Encrypted: i=1; AJvYcCWe4WC644UIPwBsb1R7K4z/h0tTEkUZZrt1OAT4daOPL9ukVQd5hMkzWv9cLioifKuei6/2Wcen62NnMu4uEqkyWIZaofU6nmeLPMqj
X-Gm-Message-State: AOJu0Yz29KlMTpK6ExqpwCcyQ36bDoSc48nPBRng3JkcyEe3LKFifuHN
	5vNp2Vhrljw2y0t1wZO3f8hQCD5wVLJvfUiALKjFwUBvJX4Jw+nnkYUvhkny1jM=
X-Google-Smtp-Source: AGHT+IEiseIgDXjdO3agtRrrSuA4Ij6kdVlB2WGEnNrYS0rcqxoFSloi9gU6MBefcXPysCy7g/BwQQ==
X-Received: by 2002:a05:6402:398:b0:561:61ca:700e with SMTP id o24-20020a056402039800b0056161ca700emr2832780edv.6.1707945961498;
        Wed, 14 Feb 2024 13:26:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoZ8VKH0GLHPuJvmOY+hX8UmR+INOcXAqfR3P8DpcNAZtTyHosnqy6K8XiBiGIipZVFSkzkbAWH8W7GErMzKpYhvAAkjuCGyQH+ZzJ7w7T5hmrMWRhmGrGOoG2tXkcHEEcYdZLIn6OWM+CFkx+9chvv8AynO984tgszjEF3EC6FobJkx4Aatz74HZEQABXfkt1tNSeCux6dBVGABU/Pv7dANzenP+RLAKRnMwJTci618hSVXwcvhmJEn7GtS9YAOnBZrS9PCFsTBklp2ScRVFcm42tm5TQPxSLsQ==
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id cs12-20020a0564020c4c00b00561e675a3casm2193381edb.68.2024.02.14.13.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 13:26:01 -0800 (PST)
Message-ID: <31e77873-bbe4-48d7-a996-ccbea52623c9@linaro.org>
Date: Wed, 14 Feb 2024 22:25:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] ARM: dts: qcom: msm8974-klte-common: Pin WiFi
 board type
Content-Language: en-US
To: Rong Zhang <i@rong.moe>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
References: <20240213110137.122737-1-i@rong.moe>
 <20240213110137.122737-3-i@rong.moe>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240213110137.122737-3-i@rong.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.02.2024 11:58, Rong Zhang wrote:
> klte* variants have little difference in the WiFi part. Without
> "brcm,board-type", variant-specific NVRAM file will be probed (e.g.,
> klte probes samsung,klte). Pin it to "samsung,klte" to allow klte* to
> load the same NVRAM file as klte.
> 
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

