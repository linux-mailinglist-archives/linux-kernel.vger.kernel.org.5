Return-Path: <linux-kernel+bounces-102361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F4A87B126
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6BF1C27F51
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1A274410;
	Wed, 13 Mar 2024 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1L3DvCV"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A974404
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354469; cv=none; b=aBqvfZlGoQCUnhnhsj6vdKAGC/rFUG6l1SH6tvG+mRXZPP9gIcKDF8vsil/bWOJ8plvpzRkyLWlQHu+ghhQDLA70ZEcvtwBKm85Z/d/kq6Srstv0/yi5OPAw6RRcT0mAgHAXb5PIAQH1uWwf90g6E4+oh7WuDHBxOHe+mVxpn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354469; c=relaxed/simple;
	bh=qopp5qh3RZHNjIu2FlP1yXeq96LeZUWZ5bgrIeXx0GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTN7O4TPVHqNlWBZEJYXozckBOLiN89LCsPEDrOVxeQ3l0wam/YYOkFT7UGVpkJVg7IB27D1ZVS7ZMubE/6qRels3U0kHmODMYvZMUW44jNn8xVkcIo3VJHld7ybbAHeeqRYUJ4TGfTyHa3PqVM2KVWrs0Lx43sAF85Es2TSlBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p1L3DvCV; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso229494e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710354466; x=1710959266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=apbSKOocO0NP+sa6Wr9E2eUjCO233hf7PGNso7mAiCw=;
        b=p1L3DvCVh9ZppS69F9kem1h3ZhJ18sKOz6JYWXxt1rTPN0ZFKbMoJghYBklSYF4kpM
         yx46Kj5ZnjfuTPGTU3x8wR0HbdBJzvUZcuNMfs1hDgkJ42UpnyHLFkodQTdgCBrmoTU1
         9+LFL9k05J1o1XDbIW85ee6ap6jDh7nB3AFCalkHeBsIaBKQCY9miTX2n+PUX7nQ2Mt9
         TLvREyuCwy+1F2y3OWQf5y5Zoakf3ZURtH2nhNYxdvRzzHbQIFmupoQPUi7fU+eUYiR2
         BZD2Igjba03Wi5Lmn7V4NGGO7M32EEzYls6g8RT81/gM6PHiFnFq+kcvFQkXUp054Wu7
         ZX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710354466; x=1710959266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=apbSKOocO0NP+sa6Wr9E2eUjCO233hf7PGNso7mAiCw=;
        b=d4dGAwa13Pn1DfwFnWTapxNKySZroN7Uo0S3pRKLnvwbjH9RWgVZpdPCKSVaFf3t61
         /nCB0JYRR6oTiqFxKm58Pl6Rmn63x161fgMx7/TjP1HPMM/toUA7KkEahA0w5/vK59ov
         0PYW+gQQ+Yb1Z0L1yYdgbGIV/CewY6oqcP9kdFRb4aFEI2Ophc7c6as/iewjasyx6YK5
         UOFCqzbxhSVcbuZzJRflGQYo69aZmoPP98TjYyH08MlgyMV86fMUvgCHqAdaRJwflPxD
         9i3BkKwu0TeXkEFKMO4I2MOaFYZXxFSFSHjgKMgvZs4JP9ETL+/c/ppbGwLm1ysRvt4u
         y7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx1fySnWoowZDaFK1+mV8zKTISJV8qOwSUfQ5RnYBk/DPlsiRvI4WTZlGTK/OoiIdsa3KXeEh6lFQAaLaeBDdRQQLzJaGVnXC20y9c
X-Gm-Message-State: AOJu0YwAm3NLs4LLuYSUzRwR9745uovRsSSdslI5hDqkXi2/Qgd0Pibs
	DpEb33MBaSdocyCOYc99EziETr452TJSNpbvR7EWC+IFrYL88j3ychy537ZY/8g=
X-Google-Smtp-Source: AGHT+IErs4ojVm6JqNAmE1N9FllNoLENjESLRyBEOnyG7ovdPpxqbngvbB8P38A0ixdPVz4b74rjAA==
X-Received: by 2002:ac2:454a:0:b0:513:c625:a6f4 with SMTP id j10-20020ac2454a000000b00513c625a6f4mr2718100lfm.4.1710354466140;
        Wed, 13 Mar 2024 11:27:46 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id fc15-20020a056512138f00b005139e4fbc04sm2005613lfb.137.2024.03.13.11.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 11:27:45 -0700 (PDT)
Message-ID: <b8d9117e-5e99-4f69-844d-997a3fbf04d6@linaro.org>
Date: Wed, 13 Mar 2024 19:27:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: add TP-Link Archer AX55 v1
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240313-archer-ax55-v1-v3-0-cd9402efab59@gmail.com>
 <20240313-archer-ax55-v1-v3-2-cd9402efab59@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240313-archer-ax55-v1-v3-2-cd9402efab59@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/13/24 19:25, Gabor Juhos wrote:
> Add device tree source for the TP-Link Archer AX55 v1 [1]
> which is a dual-band WiFi router based on the IPQ5018 SoC.
> 
> At the moment, only the UART, the GPIO LEDs and buttons
> are usable, but it makes it possible to boot an initramfs
> image on the device.
> 
> The device tree can be extended in the future, once support
> for other periherals will be available for the platform.
> 
> 1. https://www.tp-link.com/en/home-networking/wifi-router/archer-ax55/v1/
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Changes in v3:
>    - change pin configuration to use "gpio20" and "gpio21" for UART pins
>    - rebase on top of v6.8.

Did you actually check this? And how so?

Konrad

