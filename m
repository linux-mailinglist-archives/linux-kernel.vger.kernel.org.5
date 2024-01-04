Return-Path: <linux-kernel+bounces-16729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3B1824309
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF5F0B2408A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D8F241F2;
	Thu,  4 Jan 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow0V4YEb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81523779;
	Thu,  4 Jan 2024 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d44200b976so3288885ad.2;
        Thu, 04 Jan 2024 05:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704376070; x=1704980870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+fqIWtBV/T+80XSNaZFcmZX/ftnbYEEAJ0ueKG+0WM=;
        b=Ow0V4YEbj75sw3j8idCE/zXTN8k+zmKaFn7luq5gzmOO9WYaXdBTPcIfXKOF2NxVE+
         5zaWNwgxWAz5roI3qM5Q+C6l7ALUkHo24PfYX1JeaMhfKWgV95yfnRFo4CIGqeL/mLWD
         uKLDKVdUQejgnnNQ5CFx4GNmch1vVwphNJ2mBGnkPKN6VJaaa4bvQbh5JDMcfqZvmcQr
         Uj0YtaxLFTCRjmE61Lv3G5uwWMuYUieoZlio/ShuxuMuQErZifIuRHfAB668G3mk6pqq
         /XOs2ndwOOjFE7R/xwNe16AQ1Khsee+4/FWaNZKwuSxqPuOXzMUtqjye66z3FiQG2x45
         mV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376070; x=1704980870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+fqIWtBV/T+80XSNaZFcmZX/ftnbYEEAJ0ueKG+0WM=;
        b=aRbOZS+ljDOaex0etJ4x2r5bYbxi0m1f9LLSrMSQG4rb+Xu03qEepkw3OQSDzzQE/x
         3VZQyLK2TE5exkEPSWflsdBOgn3Hi56FwPr3/xCrYCb3p4lCxSidkmX8SxOsX+EJ3W+X
         nHCmpVHya9vappiK25UY1QdbgfQOxKPvDLivL2AlkZWQdJzbOfUlVCM0gNXR4u6CjkUi
         ARo6MSHqvEdJQmtrkgVBTuSknGgT33sqNWXStBVnRZwJpfoq/b8BQf9CFdZOThsUOX7u
         SQcNfqipe6YFx2SA0vaCD/axAWeT9gqxtYB6ayxZoGhF1ZX8I4KdSnHZuKxrSi2hFy7q
         sSmg==
X-Gm-Message-State: AOJu0YyopPVSA50NXiNMfIHBKnuzUHBMGeMW64DsIB4Rf3ERU4fpKo5/
	wbj1zKaCGPoFcwUVJ1tn3HY=
X-Google-Smtp-Source: AGHT+IHBxBwSpW28GZdntaZFG1A80qvbNoZ957AWOQCPnqqsFROz+rNn2v5UlOyhSbVyKo80+N6cXw==
X-Received: by 2002:a17:903:120a:b0:1d3:beea:972b with SMTP id l10-20020a170903120a00b001d3beea972bmr514003plh.93.1704376069727;
        Thu, 04 Jan 2024 05:47:49 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709027d9600b001d425d495c9sm22990550plm.190.2024.01.04.05.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:47:49 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] ARM: dts: aspeed: Harma: Add spi-gpio
Date: Thu,  4 Jan 2024 21:45:31 +0800
Message-Id: <20240104134532.536793-6-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240104134532.536793-1-peteryin.openbmc@gmail.com>
References: <20240104134532.536793-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spi-gpio for tpm device.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 36aad01dda20..ca3052cce0e0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -28,6 +28,8 @@ aliases {
 		i2c29 = &imux29;
 		i2c30 = &imux30;
 		i2c31 = &imux31;
+
+		spi1 = &spi_gpio;
 	};
 
 	chosen {
@@ -67,6 +69,25 @@ led-2 {
 			gpios = <&gpio0 124 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	spi_gpio: spi-gpio {
+		status = "okay";
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
 };
 
 // HOST BIOS Debug
-- 
2.25.1


