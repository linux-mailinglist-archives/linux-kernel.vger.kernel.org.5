Return-Path: <linux-kernel+bounces-74429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A282885D3F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584B01F26AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBDB3EA91;
	Wed, 21 Feb 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+kXeJQl"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EA63D55A;
	Wed, 21 Feb 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508504; cv=none; b=cA8O/hn403zln9K/0pH7bTddm2MKtBtPWXQfZ3SCBb/utwUUFkQ92iRLzWIM/Q5Bzqfhnhaj5xZYf1njkC7tQ8gfocGciHrHJGPcvM+zgDpS0Li9F/vUr263QqNsoGiJhEoBh5fyEU09A+Nr8KqB943qOn72yVYS2+zz9icjrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508504; c=relaxed/simple;
	bh=9WADVJJVD9uJ1S9KzLlikKR0zghswLsvPBCUmK13lFQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GP1PjJKg7AgVHV41ms4ktW40CJWUU94zPgLTrto8FF7gIWWV6bipmkEMfwBW0j9bv8sE3iFqTzo3MP6DJhDRY7B5QqJeG+E5mvpVcYUD2OJ1/L7847WPRXJePqq5P/B18mxyHV5GY5cDkGt/Nkz9WR/yYPINbxhYvQbzn9jLvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+kXeJQl; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dc8b280155so272460a34.0;
        Wed, 21 Feb 2024 01:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708508501; x=1709113301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+fqIWtBV/T+80XSNaZFcmZX/ftnbYEEAJ0ueKG+0WM=;
        b=J+kXeJQlCnQwfPKqtFNh26VEr8UgTM47Fqug1dkXjXOXRyzT8cEmUBqLCmCxqnm11y
         rTldzW/KCqR/2gjAYRu4cr3ZSzu+CWIb/VRG9uiS8gvUefiYbJeycohNXCVvArh1s3y9
         6/vrIDNchC7VQXNR+sPCR/5EGKij6xwnqOdyg0uI46+duweVUU1w/9hu/OotoEJbaYjS
         0fSDUIDJbKQkxCa+xe9pBlE/7MwWFo/sw0iZfb7g2UJt+I8EvNM+Vg6tY8w5Ju/mPe/U
         L2uwQE6XjZ+X5FY4/qtGBeCTXhfTbMXsAz5Dc1/qOoD2AIM/Csa7d/yBYOYjmoghdkWN
         SK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508501; x=1709113301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+fqIWtBV/T+80XSNaZFcmZX/ftnbYEEAJ0ueKG+0WM=;
        b=CWo831EyplEfrFGXG6wTBjtb6UGNKTL4wZuTPNnxMPC0g54Fg2xf1f0+rY1Wybzile
         bSk2cRgB8Eeh2EpYY8d/J072mA7iNVM8ACzvI1BTRPj9vQzcaNZcM/T/531pOxFXWeOJ
         8BS8KotQXtW0BkvqPjdUaenqwwFBswDbMS+k69ykXhEGCy0B2oaPyTE0BeC1/zqW49GS
         N27WjVaMuAo2z9tPuPbojsg1htIPnANx5wr/8T1JJ3gOAL+Y+3e5STcg2r+s9D5lufeP
         ts0KTyPfzEPqfh2uBlOr/FyN7hbItC/QDc72gbgmCRNsJ/Bm4noLDGqFOu/13E4Rc2GN
         gCIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNQRFIMIKaO1s4cv7vQew2AeoECeqRH+lbMQDp67/3DCXFJR6RMUe6Zl3oCzPHM+kd1cD0Ggns7VYd2/k+wG0djD6HCy82bo4PRx1sdvXXJ4+z1bQME6sdGYrz+sBi/oF0Fq/aDwuVkw==
X-Gm-Message-State: AOJu0YyosnD7QDBYIHdv7H219KJisKSnAaFf2yvyD75+CPQnelLS1k0s
	RsGFis1NWPyV9k0dO1nhRtLHFubtSqjhTXkjciIlLEDiizz/r6ay
X-Google-Smtp-Source: AGHT+IF1GoYh7XXEdgap6KD6EGkJ/IAtnwN7zdRfDtlSN78cbe1OxDqtEK1736aeFfZZVDCfAOCrJg==
X-Received: by 2002:a05:6358:7e52:b0:17b:583d:63d9 with SMTP id p18-20020a0563587e5200b0017b583d63d9mr1482811rwm.7.1708508501647;
        Wed, 21 Feb 2024 01:41:41 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id lm4-20020a056a003c8400b006e488553f09sm1645026pfb.81.2024.02.21.01.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:41:40 -0800 (PST)
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
Subject: [PATCH v3 5/9] ARM: dts: aspeed: Harma: Add spi-gpio
Date: Wed, 21 Feb 2024 17:39:20 +0800
Message-Id: <20240221093925.2393604-6-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
References: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
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


