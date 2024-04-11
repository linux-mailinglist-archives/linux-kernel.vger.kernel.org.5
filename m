Return-Path: <linux-kernel+bounces-139759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF978A0761
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7712EB21590
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D7D13C3F1;
	Thu, 11 Apr 2024 04:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHPewMpy"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB861C0DE7;
	Thu, 11 Apr 2024 04:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712811395; cv=none; b=VnAo/IycF+6MMfiDF1vYOj4oz75AuHw1WsI9qHMmCMHDa7S/bahblQyqmEJQruH/OPD3IlQuh5Pvm8EHqnnluUDt1O/hXM6n8YTSu63sEcoYCniDqywOSP73+n5SI6Woht3rPRCTtPaaxwqsCxTpVGmibyaRYkKQn5c4UywxQgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712811395; c=relaxed/simple;
	bh=QrkWE8Xnlw+q5oIxRSNTYtkcjR+a7cB4X4I7TbrA5To=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GqKDh+Gmy+mvD1ZtQwrMzHGFkqMyewrltwo3yO5V4nUTCintGOJ7C++DdUY7vF2o62Wcmrn/uRil+EPumi9O1A4cvwrqxGOBnHdoedgnLjMMzs3hBBXEVrnfU35SUf2IkR1jrdvWeHhxAfS4CA51fZq/xAj5paC+ePON82eqPpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHPewMpy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed5109d924so3042323b3a.0;
        Wed, 10 Apr 2024 21:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712811393; x=1713416193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wHTNrwtVfB656IwmijcBPMC2ZgOyFKP3zBvEDwvoMC8=;
        b=hHPewMpyKPtzmZd2UINqRn3+v2wpm6FFKo6Qaxfmufu8TcK1p8rVELtJxZOTvyPkM1
         Q0w5GJMDW8B7Dfev4g7vx/VaVsUD6HZTMPHoSTFIzC/MXneGORWQBxA3ZupYvub+aItW
         o21btC+BwCixEpG13eMk5RLzjxpw7Qtw+n5afs2vje7nj1IleflrrMXhByQLSIDF4Z8J
         tFrJSp9CVyCa2znOTKk72Gj7u3c3ynvQrVrkekLILBrBf6eqW18INU+tqMaSMoZVz1Cj
         dRr9tHyYU8BZXXZoR70BSvwkuN6gSWQ/wmzwx8bRrfpI5qhGsFMp+We44UqAO5I9jyLO
         iFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712811393; x=1713416193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHTNrwtVfB656IwmijcBPMC2ZgOyFKP3zBvEDwvoMC8=;
        b=aGBRkMUpnqB7fKdKgz1Q473iyrAwX/BAU8cJMuNmm+atJRQhMPJr+CfVMIyzaj1KmZ
         pMCya2m8FCRTU0Z2ExEM2zKTfYQUBkz0DtKkmkSu8IxvUATGw7O51xl/ej8pGjDRh+Y0
         cd+RRUTT+UVFH8NCbwTQk1I135h16hfHRAlPjLcrgqquROSNJOlDB0mJ4xUOXWpirbot
         k2XGAW6yN1mrxc+AXMCgc6ysPxS6sK+jzLcidiRNT8rJsK177DVHXq/BIGutTYGtqVK+
         zHIHn7uxgTXMkNN411zNYVMNPb62OnDhciJVnwvaaL6RnKDBRVZswrrAyDUdWFa6VM7x
         o7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa+LGQMcVGy7ur5B9sav5w2xXr/QXbpdB4TJ+2EfLVcsSmI/cUSAqq6OfLDYka1/LOM5vTPnDqrC6K/hUJqKsMiZfWs02KrLR1pyHNSCNQtmnzUmDWF0erw2weu/FwoKHd2B1KFahqYQ==
X-Gm-Message-State: AOJu0YxqlhHwj4+PbfVZcNuJwXqb1atbmpFweo8OuYENKl/cavN5M0S1
	ffp0fDwH6Uic+nYwNa+V1Zhyv9+edh+yXjljzJ0vO3fDGTYxbgv4
X-Google-Smtp-Source: AGHT+IHtf+Wl4dhvIBwFO5quw26YDztgDGpa8JMW+Q3uEfK/tNr4QU1WIV2KNcjoDf4O75QBFns8wQ==
X-Received: by 2002:a05:6a21:8806:b0:1a7:9476:6cb9 with SMTP id ta6-20020a056a21880600b001a794766cb9mr6205729pzc.32.1712811392865;
        Wed, 10 Apr 2024 21:56:32 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-195-222.hsd1.ca.comcast.net. [24.6.195.222])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090abf0900b002a610ef880bsm809998pjs.6.2024.04.10.21.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 21:56:32 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	taoren@meta.com
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH] ARM: dts: aspeed: Remove Facebook Cloudripper dts
Date: Wed, 10 Apr 2024 21:56:18 -0700
Message-ID: <20240411045622.7915-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

Remove Facebook Cloudripper dts because the switch platform is not
actively maintained (all the units are deprecated).

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 -
 .../aspeed-bmc-facebook-cloudripper.dts       | 544 ------------------
 2 files changed, 545 deletions(-)
 delete mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cloudripper.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index d3ac20e316d0..1c0e08c9ed3e 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -13,7 +13,6 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-bytedance-g220a.dtb \
 	aspeed-bmc-delta-ahe50dc.dtb \
 	aspeed-bmc-facebook-bletchley.dtb \
-	aspeed-bmc-facebook-cloudripper.dtb \
 	aspeed-bmc-facebook-cmm.dtb \
 	aspeed-bmc-facebook-elbert.dtb \
 	aspeed-bmc-facebook-fuji.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cloudripper.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cloudripper.dts
deleted file mode 100644
index d49328fa487a..000000000000
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cloudripper.dts
+++ /dev/null
@@ -1,544 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-// Copyright (c) 2020 Facebook Inc.
-
-/dts-v1/;
-
-#include <dt-bindings/leds/common.h>
-#include "ast2600-facebook-netbmc-common.dtsi"
-
-/ {
-	model = "Facebook Cloudripper BMC";
-	compatible = "facebook,cloudripper-bmc", "aspeed,ast2600";
-
-	aliases {
-		/*
-		 * PCA9548 (1-0070) provides 8 channels connecting to
-		 * SMB (Switch Main Board).
-		 */
-		i2c16 = &imux16;
-		i2c17 = &imux17;
-		i2c18 = &imux18;
-		i2c19 = &imux19;
-		i2c20 = &imux20;
-		i2c21 = &imux21;
-		i2c22 = &imux22;
-		i2c23 = &imux23;
-
-		/*
-		 * PCA9548 (2-0070) provides 8 channels connecting to
-		 * SCM (System Controller Module).
-		 */
-		i2c24 = &imux24;
-		i2c25 = &imux25;
-		i2c26 = &imux26;
-		i2c27 = &imux27;
-		i2c28 = &imux28;
-		i2c29 = &imux29;
-		i2c30 = &imux30;
-		i2c31 = &imux31;
-
-		/*
-		 * PCA9548 (3-0070) provides 8 channels connecting to
-		 * SMB (Switch Main Board).
-		 */
-		i2c32 = &imux32;
-		i2c33 = &imux33;
-		i2c34 = &imux34;
-		i2c35 = &imux35;
-		i2c36 = &imux36;
-		i2c37 = &imux37;
-		i2c38 = &imux38;
-		i2c39 = &imux39;
-
-		/*
-		 * PCA9548 (8-0070) provides 8 channels connecting to
-		 * PDB (Power Delivery Board).
-		 */
-		i2c40 = &imux40;
-		i2c41 = &imux41;
-		i2c42 = &imux42;
-		i2c43 = &imux43;
-		i2c44 = &imux44;
-		i2c45 = &imux45;
-		i2c46 = &imux46;
-		i2c47 = &imux47;
-
-		/*
-		 * PCA9548 (15-0076) provides 8 channels connecting to
-		 * FCM (Fan Controller Module).
-		 */
-		i2c48 = &imux48;
-		i2c49 = &imux49;
-		i2c50 = &imux50;
-		i2c51 = &imux51;
-		i2c52 = &imux52;
-		i2c53 = &imux53;
-		i2c54 = &imux54;
-		i2c55 = &imux55;
-	};
-
-	spi_gpio: spi {
-		num-chipselects = <2>;
-		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>,
-			   <&gpio0 ASPEED_GPIO(X, 1) GPIO_ACTIVE_HIGH>;
-
-		eeprom@1 {
-			compatible = "atmel,at93c46d";
-			spi-max-frequency = <250000>;
-			data-size = <16>;
-			spi-cs-high;
-			reg = <1>;
-		};
-	};
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-/*
- * "mdio1" is connected to the MDC/MDIO interface of the on-board
- * management switch (whose ports are connected to BMC, Host and front
- * panel ethernet port).
- */
-&mdio1 {
-	status = "okay";
-};
-
-&mdio3 {
-	status = "okay";
-
-	ethphy1: ethernet-phy@13 {
-		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <0x0d>;
-	};
-};
-
-&mac3 {
-	status = "okay";
-	phy-mode = "rgmii";
-	phy-handle = <&ethphy1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_rgmii4_default>;
-};
-
-&i2c0 {
-	multi-master;
-	bus-frequency = <1000000>;
-};
-
-&i2c1 {
-	/*
-	 * PCA9548 (1-0070) provides 8 channels connecting to SMB (Switch
-	 * Main Board).
-	 */
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x70>;
-		i2c-mux-idle-disconnect;
-
-		imux16: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		imux17: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		imux18: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-
-		imux19: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-
-		imux20: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux21: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux22: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux23: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-	};
-};
-
-&i2c2 {
-	/*
-	 * PCA9548 (2-0070) provides 8 channels connecting to SCM (System
-	 * Controller Module).
-	 */
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x70>;
-		i2c-mux-idle-disconnect;
-
-		imux24: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		imux25: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		imux26: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-
-		imux27: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-
-		imux28: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux29: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux30: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux31: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-	};
-};
-
-&i2c3 {
-	/*
-	 * PCA9548 (3-0070) provides 8 channels connecting to SMB (Switch
-	 * Main Board).
-	 */
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x70>;
-		i2c-mux-idle-disconnect;
-
-		imux32: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		imux33: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		imux34: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-
-		imux35: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-
-		imux36: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux37: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux38: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux39: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-	};
-};
-
-&i2c6 {
-	lp5012@14 {
-		compatible = "ti,lp5012";
-		reg = <0x14>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		multi-led@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-			color = <LED_COLOR_ID_MULTI>;
-			function = LED_FUNCTION_ACTIVITY;
-			label = "sys";
-
-			led@0 {
-				reg = <0>;
-				color = <LED_COLOR_ID_RED>;
-			};
-
-			led@1 {
-				reg = <1>;
-				color = <LED_COLOR_ID_BLUE>;
-			};
-
-			led@2 {
-				reg = <2>;
-				color = <LED_COLOR_ID_GREEN>;
-			};
-		};
-
-		multi-led@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-			color = <LED_COLOR_ID_MULTI>;
-			function = LED_FUNCTION_ACTIVITY;
-			label = "fan";
-
-			led@0 {
-				reg = <0>;
-				color = <LED_COLOR_ID_RED>;
-			};
-
-			led@1 {
-				reg = <1>;
-				color = <LED_COLOR_ID_BLUE>;
-			};
-
-			led@2 {
-				reg = <2>;
-				color = <LED_COLOR_ID_GREEN>;
-			};
-		};
-
-		multi-led@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-			color = <LED_COLOR_ID_MULTI>;
-			function = LED_FUNCTION_ACTIVITY;
-			label = "psu";
-
-			led@0 {
-				reg = <0>;
-				color = <LED_COLOR_ID_RED>;
-			};
-
-			led@1 {
-				reg = <1>;
-				color = <LED_COLOR_ID_BLUE>;
-			};
-
-			led@2 {
-				reg = <2>;
-				color = <LED_COLOR_ID_GREEN>;
-			};
-		};
-
-		multi-led@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-			color = <LED_COLOR_ID_MULTI>;
-			function = LED_FUNCTION_ACTIVITY;
-			label = "scm";
-
-			led@0 {
-				reg = <0>;
-				color = <LED_COLOR_ID_RED>;
-			};
-
-			led@1 {
-				reg = <1>;
-				color = <LED_COLOR_ID_BLUE>;
-			};
-
-			led@2 {
-				reg = <2>;
-				color = <LED_COLOR_ID_GREEN>;
-			};
-		};
-	};
-};
-
-&i2c8 {
-	/*
-	 * PCA9548 (8-0070) provides 8 channels connecting to PDB (Power
-	 * Delivery Board).
-	 */
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x70>;
-		i2c-mux-idle-disconnect;
-
-		imux40: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		imux41: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		imux42: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-
-		imux43: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-
-		imux44: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux45: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux46: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux47: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-
-	};
-};
-
-&i2c15 {
-	/*
-	 * PCA9548 (15-0076) provides 8 channels connecting to FCM (Fan
-	 * Controller Module).
-	 */
-	i2c-mux@76 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x76>;
-		i2c-mux-idle-disconnect;
-
-		imux48: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		imux49: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		imux50: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-
-		imux51: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-
-		imux52: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux53: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux54: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux55: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-	};
-};
-- 
2.44.0


