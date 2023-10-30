Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79327DC0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjJ3ThD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjJ3Tg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:36:59 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A86EA;
        Mon, 30 Oct 2023 12:36:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-508126afb9bso6792745e87.0;
        Mon, 30 Oct 2023 12:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694615; x=1699299415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3545GZ4rTilRPlMK6OENQjdsYfS2hQ9SURsOYUBvQmk=;
        b=A+e3+i6htx2s2elGh3IHaPlPGRUyh6++kHhK3TxVzr0WPNjzFAeopth8zFAjfwn2MN
         Ug2Ai8JtxKE76gPP1pUJNMCthVGeRzNA+SaaX5n+8EKDppgQwjvNz7G3VVdeGzfJlmQ4
         z9io28Coag9k1ziFIzMQYR8znBLE5ka7ybhZDc7hy8lktQgKdDRs8ShT0x46/Oqmll5f
         iAtcZ16c9wKWJfNWq4+d1CCxa1g58GchplG/iu93u92wsYi+lQd/9c/P/H74oG6aqhWs
         O8nfnVC+FhDdFfkeWPt0Cv7RGvYXvo+maJDQHD1p923zmhSX1MuTSIQpaLdrTdeRWD4z
         Qkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694615; x=1699299415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3545GZ4rTilRPlMK6OENQjdsYfS2hQ9SURsOYUBvQmk=;
        b=pwU6RiAvDFG2uoOgFK/bdi+Wlzg/A3sTOv9Oue4/WySqS5Kni4gONq7ei3AsAEavYn
         7MFKcZr4euIf2MLGZkYsuBWpkQ/os/A4BmPhdlZo8sxbdRYm53ozTZBhBcS2uZoYAlLw
         ykk8RXR/+Fb5cCTHELswk3/7rki3Mc23udbxl5Mdnp88w2MIu7Eurhq1N7m8SQ38Fv3g
         1aa6DuZIhzjqby7iL1SUdPdbbIuRbPiWcBE+GGracR1vM2KMxpwj/QVg+ufYOt/wQOTp
         buiyh6j6X34J0qvEEAFBzLxv+KrfKShGW82PypUTcC4pPfCFd8QdL5lauJ8PtarsTMqy
         xpOA==
X-Gm-Message-State: AOJu0YwqmHmUm+KNM5VUoQ3WCqiiKNw+aMEV0Tvs7GhewEV1s4y2RECX
        zR9naQqr0bNmrwNlx8Ya56w=
X-Google-Smtp-Source: AGHT+IH4tyRtZxoFgaCdcYiyDVNGjcMgbv6ArWgd/XQf8AUJ2MXWhaZebmU+QV/0TBLyx0L18j6UVw==
X-Received: by 2002:a05:6512:3e09:b0:503:19d8:8dc3 with SMTP id i9-20020a0565123e0900b0050319d88dc3mr9284816lfv.31.1698694615292;
        Mon, 30 Oct 2023 12:36:55 -0700 (PDT)
Received: from hex.my.domain (83.11.208.51.ipv4.supernova.orange.pl. [83.11.208.51])
        by smtp.gmail.com with ESMTPSA id a27-20020ac2521b000000b0050482b29ac8sm1510781lfl.31.2023.10.30.12.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:36:54 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
Date:   Mon, 30 Oct 2023 20:36:40 +0100
Subject: [PATCH 3/6] ARM: dts: Drop DTS for BCM59056 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-bcm59054-v1-3-3517f980c1e3@gmail.com>
References: <20231030-bcm59054-v1-0-3517f980c1e3@gmail.com>
In-Reply-To: <20231030-bcm59054-v1-0-3517f980c1e3@gmail.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698694608; l=3995;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=DBtpuYO/zr95rgnLU/rQbbV2xjIrUTq43L7BHBrPA9U=;
 b=hZdG9wUjwVxv+mKU8AxupCxa7wqP/eesbom+u4x00YcCHX2XrH7KzI07mJSBw3r5HgIZBwjah
 DN7mNasV6LeCrxA/gv2MoC855gyUl/PFMS7JhkQ8aXq3b+MPu7jsmk3
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM59056 PMIC has its own separate DTSI, meant to be included
in a DTS file after defining the pmu node on some I2C bus.

I'm not aware of many other devices that do this, and it seems very
unintuitive. Drop the DTS in favor of adding the BCM59056 PMIC node
directly into the device DTS files.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/broadcom/bcm28155-ap.dts | 68 +++++++++++-----------
 arch/arm/boot/dts/broadcom/bcm59056.dtsi   | 91 ------------------------------
 2 files changed, 32 insertions(+), 127 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm28155-ap.dts b/arch/arm/boot/dts/broadcom/bcm28155-ap.dts
index 2f3634545e64..cefaa9a3c45c 100644
--- a/arch/arm/boot/dts/broadcom/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/broadcom/bcm28155-ap.dts
@@ -37,7 +37,39 @@ &pmu_bsc {
 	status = "okay";
 
 	pmu: pmu@8 {
+		compatible = "brcm,bcm59056";
+		interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x08>;
+
+		regulators {
+			camldo1_reg: camldo1 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			sdldo_reg: sdldo {
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+			};
+
+			sdxldo_reg: sdxldo {
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			usbldo_reg: usbldo {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			iosr1_reg: iosr1 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+		};
 	};
 };
 
@@ -74,39 +106,3 @@ &usbotg {
 &usbphy {
 	status = "okay";
 };
-
-#include "bcm59056.dtsi"
-
-&pmu {
-	compatible = "brcm,bcm59056";
-	interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
-	regulators {
-		camldo1_reg: camldo1 {
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
-		sdldo_reg: sdldo {
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3000000>;
-		};
-
-		sdxldo_reg: sdxldo {
-			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <3300000>;
-		};
-
-		usbldo_reg: usbldo {
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
-		iosr1_reg: iosr1 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/broadcom/bcm59056.dtsi b/arch/arm/boot/dts/broadcom/bcm59056.dtsi
deleted file mode 100644
index a9bb7ad81378..000000000000
--- a/arch/arm/boot/dts/broadcom/bcm59056.dtsi
+++ /dev/null
@@ -1,91 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
-* Copyright 2014 Linaro Limited
-* Author: Matt Porter <mporter@linaro.org>
-*/
-
-&pmu {
-	compatible = "brcm,bcm59056";
-	regulators {
-		rfldo_reg: rfldo {
-		};
-
-		camldo1_reg: camldo1 {
-		};
-
-		camldo2_reg: camldo2 {
-		};
-
-		simldo1_reg: simldo1 {
-		};
-
-		simldo2_reg: simldo2 {
-		};
-
-		sdldo_reg: sdldo {
-		};
-
-		sdxldo_reg: sdxldo {
-		};
-
-		mmcldo1_reg: mmcldo1 {
-		};
-
-		mmcldo2_reg: mmcldo2 {
-		};
-
-		audldo_reg: audldo {
-		};
-
-		micldo_reg: micldo {
-		};
-
-		usbldo_reg: usbldo {
-		};
-
-		vibldo_reg: vibldo {
-		};
-
-		csr_reg: csr {
-		};
-
-		iosr1_reg: iosr1 {
-		};
-
-		iosr2_reg: iosr2 {
-		};
-
-		msr_reg: msr {
-		};
-
-		sdsr1_reg: sdsr1 {
-		};
-
-		sdsr2_reg: sdsr2 {
-		};
-
-		vsr_reg: vsr {
-		};
-
-		gpldo1_reg: gpldo1 {
-		};
-
-		gpldo2_reg: gpldo2 {
-		};
-
-		gpldo3_reg: gpldo3 {
-		};
-
-		gpldo4_reg: gpldo4 {
-		};
-
-		gpldo5_reg: gpldo5 {
-		};
-
-		gpldo6_reg: gpldo6 {
-		};
-
-		vbus_reg: vbus {
-		};
-	};
-};

-- 
2.42.0

