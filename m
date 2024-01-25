Return-Path: <linux-kernel+bounces-38810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B41883C64B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54A71C224DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AC6745DE;
	Thu, 25 Jan 2024 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2XpZRtj"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B651C6AF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195805; cv=none; b=DyeHQG94kyBGv5HJp50ywcET/YL2H9+Eg7KDZx9xhfMeo6i0PSXiNHZBAJWo0L0bv0kwd7T04hVLNe1kkCuuX1WGHDaljhLs4yKs+weoU4ohRj8iO8KxFo+k4XAn4cLQrncQOtpPN2oo16LIqCx7dbzxd5sh8Zj0oJQM5o2EAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195805; c=relaxed/simple;
	bh=8fhkwYMTO5zd1oqKM8Iyt+6kig9k4plTdDM5enIVcLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCutq50VaJhpI8fUChB1Qc0MAphXokgc5VF1CZvBUArJCGkyYSnwQtz90D1jBLHQFbisHJtTEyry3OZeQGZGipwS5q2dX9wsRWoYv0gjN283tt+Em+ObHKcGri1ia3jNYh6Wyu0gtx7ZH5jeLk94bB8sWsw+rAJl42Gw8RShmU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g2XpZRtj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-339289fead2so5817229f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706195802; x=1706800602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilrhb+yvw7RYPUylHsWS4mRgbYDWwTIuPMtV7XuwEs8=;
        b=g2XpZRtjsr8wzGkq5Xc0zx4BT5vjq1Le5xfRQWmiaD4RlyTBXIAK5TiNOxJ20EHxPz
         TbfnmQxWaef0sOGRaH1wC1jShojAQ7QeHf4OSEgOJ2kJ7ARAqvcbN3IpfGmIQy0f+dK3
         BRz+N1e0jR1LWbFtCcFZpe1KaQUZhOFbr0rVOhl+wXFeO7kj+TrO8w/hviLwf+SR9yaG
         eqmh7AML4mqT3Km86Z7Ry0WAvy4keRah7/Zo077DeLw+YOdqvlyZJNk+eWsGy9Cgd62M
         QeTv3u8E6wIbN2AQfu2saESNGppVlZ1d5s/eiebagx/uTRgdmlbe/paMMLMH+8m0FvDe
         euyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195802; x=1706800602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilrhb+yvw7RYPUylHsWS4mRgbYDWwTIuPMtV7XuwEs8=;
        b=kfxQCTTRE8ZgpsqpDGTsaewWjFkC/s5bNdYIMFyfv3pNePyT9gYP4T33vb4YcBXm5B
         xLw+Y78DmiUM9nzv+3e8Y0LpkFfTP/6DljjPFHw5RTRMputvMXEnAI9/mWMyfkMeFvWC
         urXgxqt/Wi9sz2vozO+ju6zkYyUA7T2tSKW4GkZwShR77AgVz75ikqAmw9QbgNr1wKke
         ezdewzha8r1gEL5r/KHWtqNjDRQT03hApc/dGC//5JLK5TSq/HUBzbOhii9CBBancNC1
         iaS+rf0i8xhQ6NHIrCNWEyZwJSkR3rT+Wli//ebRzLPiq//DHKxhgVZTgjLB5CizqbTP
         3XMQ==
X-Gm-Message-State: AOJu0Yx5p++KEI4GVe1D1FPj1Yka7w96XSvnErkNxilQSSMC31PZUoMf
	mjrfBK/NWVZRgHsNVu/sPTWi4cEMBSL1LUsS+bRaqgh5zPgjhekWrDKEWwd3HOe0xgbZ2gu6p9A
	jwFo=
X-Google-Smtp-Source: AGHT+IFCdeVIQDMEFggx7BG29AF0iTnRkUSlpmQhqh/e6UutEr+l//6no5ADcVZJRCWMQADXMYUYLg==
X-Received: by 2002:a05:6000:1e91:b0:337:d651:e65c with SMTP id dd17-20020a0560001e9100b00337d651e65cmr530562wrb.111.1706195802323;
        Thu, 25 Jan 2024 07:16:42 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id q17-20020adfcb91000000b00337d3465997sm3184656wrh.38.2024.01.25.07.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:16:41 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski+dt@linaro.org,
	broonie@kernel.org
Cc: robh+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 2/7] ARM: dts: samsung: exynos3250: specify the SPI fifosize
Date: Thu, 25 Jan 2024 15:16:25 +0000
Message-ID: <20240125151630.753318-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125151630.753318-1-tudor.ambarus@linaro.org>
References: <20240125151630.753318-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Up to now the SPI alias was used as an index into an array defined in
the SPI driver to determine the SPI FIFO size. Drop the dependency on
the SPI alias and specify the SPI FIFO size directly into the SPI node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm/boot/dts/samsung/exynos3250.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos3250.dtsi b/arch/arm/boot/dts/samsung/exynos3250.dtsi
index 3f1015edab43..2f974059ec45 100644
--- a/arch/arm/boot/dts/samsung/exynos3250.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos3250.dtsi
@@ -826,6 +826,7 @@ spi_0: spi@13920000 {
 			samsung,spi-src-clk = <0>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi0_bus>;
+			samsung,spi-fifosize = <256>;
 			status = "disabled";
 		};
 
@@ -842,6 +843,7 @@ spi_1: spi@13930000 {
 			samsung,spi-src-clk = <0>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi1_bus>;
+			samsung,spi-fifosize = <64>;
 			status = "disabled";
 		};
 
-- 
2.43.0.429.g432eaa2c6b-goog


