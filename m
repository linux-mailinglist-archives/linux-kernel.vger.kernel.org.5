Return-Path: <linux-kernel+bounces-128130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED56895688
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A6A1C22256
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E22786ACA;
	Tue,  2 Apr 2024 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQOYY85c"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B778615E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067906; cv=none; b=k0/JojgLYVjZNcgaSi2FdEwBb30ydW+fIiDNiIYSvsNbt45sM3IaFWkYmM2Y1s2AFRLmrk/fVPWgHYHKVF/JytOR0oai9B+WbMupK7fGNwy9uYAhOOrfQzWgwfwsETgIzzKB0QmP1yNEaqwveHL3Tyla4qO6ALR2EKPYrBoHkos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067906; c=relaxed/simple;
	bh=5wsKlMW6zuiZvmqCr9BLGY7yhgdT6UjqJaE2/GK7Dqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eL36/Rde8YMNjE2Z3hSvHE+ngFR/w0gPlP4SQzkTTXlMNAoSuShyiAcATiRgbzYWiV6PCJ5wgJ3sH+GQ7QDopyxAQHh5+guJVlcnp/uEHIV4Px/93erYDzN6j27VnaPt/LvvM144dsGu1SugAqg2Ub63DPBDd10+EhjFB0J2G1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vQOYY85c; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a46de423039so303114466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712067902; x=1712672702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4hWsU1/H1ichuozopazuwmACCLdHZgCpChahByKTRKc=;
        b=vQOYY85c7GcsJT5xtHv6+xdsQgN0rDTZLGxAqvoK7T3MSzi8jvEbztR7Ior3IRz1me
         OgiGjXathKQZP7Bt4yrBYtHC/W52bYsqloya5W6Wuxy9D6MchipMMFOwaWRvqbcrbOtk
         3SgSON4lLauchGcCEbKQzOhYjzM6vywRBE0TxRTjm1aFiQXmVTWtQzH4blTJMRIjc114
         s8zCdvF2d2vBdAc18ogTWyc1cgyrdAWJFCRmOw9YWluFD8ipSc0EtDZoukeiVXImv8fU
         AF3qMe40/8vYJwk5XS8ZPoGf1HxlhBGr9Rg0ZU04v+Nc4IXo+2y17fKqTD1ItRq+Sieg
         XycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712067902; x=1712672702;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hWsU1/H1ichuozopazuwmACCLdHZgCpChahByKTRKc=;
        b=jX2Ubsq6P8046g8QqDgVqvK/5Bw08UD9ORFSwJZgwniLjQwpnfUrGeKzbZWN7QRGwY
         aPXMqRzlGaopoQQjtrdokfdFneyjbQ44HKeRqE8wxN/piVn3az5VKDtAHfxPkjg6VRb4
         YyjRdZXrFIObKWbrB61ldytP4Yy3vUA7/naQmI9CAVE62tUnJXB3bymf+rL9c0G2z3wR
         JcvjWj8ayqmLmFGrjffaKNclLT1tpFYJ905emnu7476ixPAvB5zfH7KCrriTmST4PPGo
         W2+UVbXPkeuMZ8lJsqTmnkNPAyLpT1pB8Q/6yhwsR2iNwe+nxngBpBsdXHmo9FQlBwXW
         NVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9sVKHfnW3B09j/rfD7YeDeJVsGZpkdMxBntsPV6/MEBYtX9deum4DQ/zRb/IKU2kqo9SMig5tAKtTvuMZgI3rIMvJ+2XKtiVYQoPI
X-Gm-Message-State: AOJu0Yy+T5C9n74JgHMshqNeH43Em0QnC/KTXYvylOn1VXBA3qtHB+rl
	6i7Uu6vrgjbK4we+JADdW7bdktJsT+HwcnWlQtot+17aQMD1wKsTaJ3zx7owWQQ/HusM/ki6Mir
	Y
X-Google-Smtp-Source: AGHT+IE5yfHNcLZvYypEgIbF5cB/0sM4sPMsaHd89klD+N6G/0DtQYDrwwsOfaryz+F6DY+dpQM1Jg==
X-Received: by 2002:a50:9fa7:0:b0:56c:995:5b with SMTP id c36-20020a509fa7000000b0056c0995005bmr1678629edf.11.1712067901982;
        Tue, 02 Apr 2024 07:25:01 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7c24b000000b0056bdec673c3sm6997639edo.38.2024.04.02.07.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 07:25:01 -0700 (PDT)
Message-ID: <51c84af2-73f7-4af4-8676-2276b6c7786d@linaro.org>
Date: Tue, 2 Apr 2024 16:24:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: i2c-qcom-geni: Add support to share an I2C SE
 from two subsystem
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, andersson@kernel.org,
 andi.shyti@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 dmaengine@vger.kernel.org
Cc: quic_vdadhani@quicinc.com, Vinod Koul <vkoul@kernel.org>
References: <20240402062131.9836-1-quic_msavaliy@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240402062131.9836-1-quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2.04.2024 8:21 AM, Mukesh Kumar Savaliya wrote:
> Add feature to share an I2C serial engine between two subsystems(SS) so
> that individual clients from different subsystems can access the same bus.
> For example single i2c slave device can be accessed by Client driver from
> APPS OR modem subsystem image. Same way we can have slave being accessed
> between APPS and TZ subsystems.
> 
> This is possible in GSI mode where driver queues the TREs with required
> descriptors and ensures to execute TREs in an mutually exclusive way.
> Issue a "Lock TRE" command at the start of the transfer and an "Unlock TRE"
> command at the end of the transfer. This prevents other subsystems from
> concurrently performing DMA transfers and avoids disturbance to data path.
> Change MAX_TRE macro to 5 from 3 because of these two additional TREs.
> 
> Since the GPIOs are also shared for the i2c bus, do not touch GPIO
> configuration while going to runtime suspend and only turn off the
> clocks. This will allow other SS to continue to transfer the data.
> 
> This feature needs to be controlled by DTSI flag to make it flexible
> based on the usecase, hence during probe check the same from i2c driver.
> 
> Export function geni_se_clks_off() to call explicitly instead of
> geni_se_resources_off() to not modify TLMM configuration as other SS might
> perform the transfer while APPS SS can go to sleep.
> 
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> ---
> v1 -> v2:
> - Addressed review comments.

The biggest one ("too many changes across the board") is still not
addressed and the patch will not be further reviewed until that is done.

Each subsystem has different owners and each change requires an explanation
(maintainers always "expect your patch to be wrong" and you need to
convince them otherwise through commit messages)

Konrad

