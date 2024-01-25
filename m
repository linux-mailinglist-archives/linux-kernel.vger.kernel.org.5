Return-Path: <linux-kernel+bounces-38815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB8983C65B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23771286B31
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C23D7CF08;
	Thu, 25 Jan 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQh9L4E8"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D99976903
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195810; cv=none; b=smKWwo8qlt7ir/xWK2nCDsYVxiqQqgDTuP/+8izyBiAxjAnvWtFN2fxoOhZcuVKE01xio/IqXsALgiaZ61jM/OZsRUgr7YFcCcWKEl4Da7KNl4ZNrwj/gjOTLs2t9JbyQOInIHCMCy5g31C97KXm2cSuraMB8C65ksKAN21OCF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195810; c=relaxed/simple;
	bh=WYvk9yPR6/JZyjBlCcCevDoHajB/tuMpck369sNB4+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDBrbPLYemTbYtbXhsf4TQ24NVMkfpO3mv8gII7cwy+J+JNwcsI/9alLhzBfdOISU/nRx6O8NX+JWroYeiYO8Uae+LDnu06BDHKfHT43zMu6dwiEnhVJvefyd0368pdBW1iErgJ5c/Hp94dvjWPYLv9tf8aEkhqnLI9UfwZMzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rQh9L4E8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-337d58942c9so6863326f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706195807; x=1706800607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35VmVc/8ejel4BrHqQQU0z/004d8YMTrnLiuRdXtvQo=;
        b=rQh9L4E8KOqZmxwPDnVbP4Hh6rLHIN8v5WN264CEnjHaRBRgYa8gcQ/ViMNJd06kPZ
         HeQytDc5nC27E/tXc9a0UDEcG2d1Mn92QWgukP0wyajkWE8yHPlELhIF9cphYAsUSdpx
         4pWZC5RPG/D0mh9S0RmQDEjZTg2zUf41YkU1SvIKgpv2nLqfwN9BRLcmTXQ/b1CC7cC0
         ZzdooKyOG/fjDkFvxLzM3Oct6nUEgM0E+SGoY+uOsYvGnQtolchfRFuIzRtM8Z4TpQ5B
         xTXY1JQ8Qi8S2BsudXzm2L7i8JhCbIIFmWcvmirMURr7PD9S+lneUAKa99JdgZY/iMKh
         7mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195807; x=1706800607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35VmVc/8ejel4BrHqQQU0z/004d8YMTrnLiuRdXtvQo=;
        b=nJdWalimlTzyIZ9rWI7jZoZPOzi+KZwPxhlatie0v4wiaXsAKQk7TDVRgq3hMJHrp0
         K4wmRzi26jocs7zuWpcH9jf64Th5glyGTmnE429NB+RFJi6HaznL0LwSk9mOoMn8zwbm
         NGLcWxH71ttkBedq3FELTE+aEfgmQM+NqbSSf36umWFXgPJ5zjn1RIAFk6c+QduW/vTN
         BWBHkg7mndvRb81DKbsLlAnA3pMbrzfcZqEFswU77wJ2gQ2kvWpLa4x6GGVSeiy5lxCY
         e+vKRgrqtjl/wiDe96CpycL2cREnznK2pIpnnOlQJiI18rzEi1dF9nP9q5QUnV2XBIsf
         /CqQ==
X-Gm-Message-State: AOJu0YyOhJ7wn5bPmASb3eqVmH40BnG14GZac44n5XLKQGO5G3VwrNvA
	E8QOakFV3DVfr27QsN9qmpW0RuwMC08PtoRpeaNqReb9nKUDEAkU/GuBrSgxMco=
X-Google-Smtp-Source: AGHT+IEJ0OKepjGpb6EdN0r3HkMYVxzhwVDvAZF7vtDAmnhFjc6DcohOMbEY1lslagNHUZP7nt14+g==
X-Received: by 2002:a05:600c:21d5:b0:40e:c193:1de8 with SMTP id x21-20020a05600c21d500b0040ec1931de8mr564537wmj.232.1706195807674;
        Thu, 25 Jan 2024 07:16:47 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id q17-20020adfcb91000000b00337d3465997sm3184656wrh.38.2024.01.25.07.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:16:46 -0800 (PST)
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
Subject: [PATCH 6/7] ARM: dts: samsung: exynos5433: specify the SPI fifosize
Date: Thu, 25 Jan 2024 15:16:29 +0000
Message-ID: <20240125151630.753318-7-tudor.ambarus@linaro.org>
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

The FIFO sizes were determined based on the SPI aliases that are defined
in exynos5433-tm2-common.dtsi.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 7fbbec04bff0..b5c898703e3b 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1468,6 +1468,7 @@ spi_0: spi@14d20000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi0_bus>;
 			num-cs = <1>;
+			samsung,spi-fifosize = <256>;
 			status = "disabled";
 		};
 
@@ -1487,6 +1488,7 @@ spi_1: spi@14d30000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi1_bus>;
 			num-cs = <1>;
+			samsung,spi-fifosize = <64>;
 			status = "disabled";
 		};
 
@@ -1506,6 +1508,7 @@ spi_2: spi@14d40000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi2_bus>;
 			num-cs = <1>;
+			samsung,spi-fifosize = <64>;
 			status = "disabled";
 		};
 
@@ -1525,6 +1528,7 @@ spi_3: spi@14d50000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi3_bus>;
 			num-cs = <1>;
+			samsung,spi-fifosize = <64>;
 			status = "disabled";
 		};
 
@@ -1544,6 +1548,7 @@ spi_4: spi@14d00000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi4_bus>;
 			num-cs = <1>;
+			samsung,spi-fifosize = <64>;
 			status = "disabled";
 		};
 
-- 
2.43.0.429.g432eaa2c6b-goog


