Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756FB7DC0C9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjJ3TmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjJ3Tl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:41:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFCEE4;
        Mon, 30 Oct 2023 12:41:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507bd19eac8so7042054e87.0;
        Mon, 30 Oct 2023 12:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694912; x=1699299712; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3545GZ4rTilRPlMK6OENQjdsYfS2hQ9SURsOYUBvQmk=;
        b=GbsBVjjyOyzIskIWEeaalbRZE7qm+QeFubY9uQGYKm9iAVYvbeUQoJXkpSUOycQdIo
         O0ac9ffx4GtAWjODST59irQ+HgjGNWEMq2XINvt9IYpoz5vL41UoN5FbdL25NcCTZU9X
         bqNKUJcwkPVtYPn3CU2YNu8KAgzXews/g+it3oQfR1Js8YwobGUuqjInfZmbTHTmXL3N
         MJSjIIkh+FCHlKGqjrrdB+G+633JSFe+iT07/uvj+HORN/K+y03vQUDNK/Ib0onT6vqg
         KQ00CiQAFwDG3yo57mpOFjz9/vqbIDfZ46PaOA/qf7P6y4r3VsKRnNlA1OjMkrdhurfE
         b5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694912; x=1699299712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3545GZ4rTilRPlMK6OENQjdsYfS2hQ9SURsOYUBvQmk=;
        b=uc+t/dJtYcvvxgmFXnAG1tlmVmOUS40uHe7ykCYc3hElBtNIsJg+To+Qb3P+3f+Flu
         aJS/St4sV/JVFieuT0+tDw1d1wvla38s3c4TA1p2LF3ISnj25IHHy1RtYGc67+Tqz6Ci
         Mn/XAogGeqVRDFg2Oh3WhXTBQanpgn76SZMTZQzw3CHXoafbOHsW26rXUKH3f74kXKcC
         BPtVVgFyUTT7degIoRT5Pj7TtAK2VBvRs4dF48UXdwPLtx5rUr9KSRYcnGNpwuQyq+xL
         vveFS6sFIgNboZOXGgnIppikZ06WlgiJXtDTwnFtv960/90Z2jgKYvHo30BS0USqjmkE
         hsCA==
X-Gm-Message-State: AOJu0YzWHkD2zilcKqGHy2bJqqk6WKb6PBt5vM1gUxNJF79WR3FGFab1
        BlTDHpQbai6T603Cqd7k2s4=
X-Google-Smtp-Source: AGHT+IGWswxESjDHXYLTl5Cpnzaj8IEwQ99AVQmntdpTDHIAk6Pqzn4ikpab+YANcim3rmmp2FIGqA==
X-Received: by 2002:a19:f80e:0:b0:500:7f71:e46b with SMTP id a14-20020a19f80e000000b005007f71e46bmr8209208lff.1.1698694911772;
        Mon, 30 Oct 2023 12:41:51 -0700 (PDT)
Received: from hex.my.domain (83.11.208.51.ipv4.supernova.orange.pl. [83.11.208.51])
        by smtp.gmail.com with ESMTPSA id m10-20020ac2428a000000b005057184ae62sm1527802lfh.96.2023.10.30.12.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:41:51 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
Date:   Mon, 30 Oct 2023 20:41:45 +0100
Subject: [PATCH v2 3/6] ARM: dts: Drop DTS for BCM59056 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-bcm59054-v2-3-5fa4011aa5ba@gmail.com>
References: <20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com>
In-Reply-To: <20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com>
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
        linux-arm-kernel@lists.infradead.org,
        Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698694906; l=3995;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=DBtpuYO/zr95rgnLU/rQbbV2xjIrUTq43L7BHBrPA9U=;
 b=HDu0zf8GfviM5rEV5zkbcvF2LUTvgWofykCLZFC+mAUEKB0AesBtIFkSJQRg/3R/1a1/uY2vW
 2Lnqvief9jhAomuborD/4Csi+k8a/E1A0MHcWibrdbGm9siphhSAZMh
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

