Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D963F803CC7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjLDSXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjLDSXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:23:40 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079AB113;
        Mon,  4 Dec 2023 10:23:44 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B4IMo9V034870;
        Mon, 4 Dec 2023 12:22:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701714170;
        bh=SwS6Hp++rPXPP2EoDuktDgnS3dXRGhf3rRr4kieOuH4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Uk4mX5a8SmOZWvUp2ceF1Jkcjgu5NGBH+c56o+wceIyTXaab5hsDM7sBQA4vOa5ZA
         jbtyjp0E/oKTV1RUQqX2pbBmMpMjLq0tJk/KzLCs52bzFTJnYDXNe1Zlp+U7i6OerM
         XatY8P/aQ1eoZzOndc3rKFsqLP3J7ViJR0tv17tU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B4IMo78083397
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Dec 2023 12:22:50 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 12:22:50 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 12:22:50 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B4IMkx5042313;
        Mon, 4 Dec 2023 12:22:49 -0600
From:   Andrew Davis <afd@ti.com>
To:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Adam Ford <aford173@gmail.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-omap@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH RFC 02/10] ARM: dts: omap3: Add device tree entry for SGX GPU
Date:   Mon, 4 Dec 2023 12:22:37 -0600
Message-ID: <20231204182245.33683-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204182245.33683-1-afd@ti.com>
References: <20231204182245.33683-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SGX GPU device entries to base OMAP3 dtsi files.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/ti/omap/am3517.dtsi   | 11 ++++++-----
 arch/arm/boot/dts/ti/omap/omap34xx.dtsi | 11 ++++++-----
 arch/arm/boot/dts/ti/omap/omap36xx.dtsi |  9 +++++----
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am3517.dtsi b/arch/arm/boot/dts/ti/omap/am3517.dtsi
index 77e58e686fb17..19aad715dff70 100644
--- a/arch/arm/boot/dts/ti/omap/am3517.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am3517.dtsi
@@ -162,12 +162,13 @@ sgx_module: target-module@50000000 {
 			clock-names = "fck", "ick";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0 0x50000000 0x4000>;
+			ranges = <0 0x50000000 0x10000>;
 
-			/*
-			 * Closed source PowerVR driver, no child device
-			 * binding or driver in mainline
-			 */
+			gpu@0 {
+				compatible = "ti,omap3430-gpu", "img,powervr-sgx530";
+				reg = <0x0 0x10000>; /* 64kB */
+				interrupts = <21>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/ti/omap/omap34xx.dtsi b/arch/arm/boot/dts/ti/omap/omap34xx.dtsi
index fc7233ac183a8..acdd0ee34421d 100644
--- a/arch/arm/boot/dts/ti/omap/omap34xx.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap34xx.dtsi
@@ -164,12 +164,13 @@ sgx_module: target-module@50000000 {
 			clock-names = "fck", "ick";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0 0x50000000 0x4000>;
+			ranges = <0 0x50000000 0x10000>;
 
-			/*
-			 * Closed source PowerVR driver, no child device
-			 * binding or driver in mainline
-			 */
+			gpu@0 {
+				compatible = "ti,omap3430-gpu", "img,powervr-sgx530";
+				reg = <0x0 0x10000>; /* 64kB */
+				interrupts = <21>;
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
index e6d8070c1bf88..c3d79ecd56e39 100644
--- a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
@@ -211,10 +211,11 @@ sgx_module: target-module@50000000 {
 			#size-cells = <1>;
 			ranges = <0 0x50000000 0x2000000>;
 
-			/*
-			 * Closed source PowerVR driver, no child device
-			 * binding or driver in mainline
-			 */
+			gpu@0 {
+				compatible = "ti,omap3630-gpu", "img,powervr-sgx530";
+				reg = <0x0 0x2000000>; /* 32MB */
+				interrupts = <21>;
+			};
 		};
 	};
 
-- 
2.39.2

