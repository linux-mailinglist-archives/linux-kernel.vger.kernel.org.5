Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC91785885
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjHWNK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjHWNK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:10:56 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC767E4A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:10:51 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6477:4282:8a75:3696])
        by xavier.telenet-ops.be with bizsmtp
        id d1Ap2A0080iR7xF011ApCk; Wed, 23 Aug 2023 15:10:50 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qYndA-001Y5a-J4;
        Wed, 23 Aug 2023 15:10:49 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qYndJ-00HVW7-2r;
        Wed, 23 Aug 2023 15:10:49 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] arm64: dts: mediatek: mt8186: bpi-r3: Convert to sugar syntax
Date:   Wed, 23 Aug 2023 15:10:48 +0200
Message-Id: <f34a84d5c19b070ac95c93af9b6a60477736509f.1692796112.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Overlay syntactic sugar for generating target-path fragments is
supported by the version of dtc supplied with the kernel since commit
50aafd60898a8b3e ("scripts/dtc: Update to upstream version
v1.4.6-21-g84e414b0b5bc").  Hence convert the Bananapi R3 overlay
devicetree source files to sugar syntax, improving readability.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
No changes in generated dtbo.
---
 .../mt7986a-bananapi-bpi-r3-emmc.dtso         | 28 +++---
 .../mt7986a-bananapi-bpi-r3-nand.dtso         | 74 ++++++++-------
 .../mediatek/mt7986a-bananapi-bpi-r3-nor.dtso | 90 +++++++++----------
 .../mediatek/mt7986a-bananapi-bpi-r3-sd.dtso  | 16 ++--
 4 files changed, 98 insertions(+), 110 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dtso
index 779dc6782bb1986f..047a8388811eb9c0 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dtso
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dtso
@@ -9,21 +9,17 @@
 
 / {
 	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
-
-	fragment@0 {
-		target-path = "/soc/mmc@11230000";
-		__overlay__ {
-			bus-width = <8>;
-			max-frequency = <200000000>;
-			cap-mmc-highspeed;
-			mmc-hs200-1_8v;
-			mmc-hs400-1_8v;
-			hs400-ds-delay = <0x14014>;
-			non-removable;
-			no-sd;
-			no-sdio;
-			status = "okay";
-		};
-	};
 };
 
+&{/soc/mmc@11230000} {
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	hs400-ds-delay = <0x14014>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso
index 543c13385d6e3f82..12ec15e3188de082 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso
@@ -9,46 +9,44 @@
 
 / {
 	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
+};
+
+&{/soc/spi@1100a000} {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	spi_nand: spi_nand@0 {
+		compatible = "spi-nand";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+		spi-tx-buswidth = <4>;
+		spi-rx-buswidth = <4>;
 
-	fragment@0 {
-		target-path = "/soc/spi@1100a000";
-		__overlay__ {
+		partitions {
+			compatible = "fixed-partitions";
 			#address-cells = <1>;
-			#size-cells = <0>;
-			spi_nand: spi_nand@0 {
-				compatible = "spi-nand";
-				reg = <0>;
-				spi-max-frequency = <10000000>;
-				spi-tx-buswidth = <4>;
-				spi-rx-buswidth = <4>;
-
-				partitions {
-					compatible = "fixed-partitions";
-					#address-cells = <1>;
-					#size-cells = <1>;
-
-					partition@0 {
-						label = "bl2";
-						reg = <0x0 0x100000>;
-						read-only;
-					};
-
-					partition@100000 {
-						label = "reserved";
-						reg = <0x100000 0x280000>;
-					};
-
-					partition@380000 {
-						label = "fip";
-						reg = <0x380000 0x200000>;
-						read-only;
-					};
-
-					partition@580000 {
-						label = "ubi";
-						reg = <0x580000 0x7a80000>;
-					};
-				};
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "bl2";
+				reg = <0x0 0x100000>;
+				read-only;
+			};
+
+			partition@100000 {
+				label = "reserved";
+				reg = <0x100000 0x280000>;
+			};
+
+			partition@380000 {
+				label = "fip";
+				reg = <0x380000 0x200000>;
+				read-only;
+			};
+
+			partition@580000 {
+				label = "ubi";
+				reg = <0x580000 0x7a80000>;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
index e48881be4ed60c98..6a0d529b54aca5bd 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
@@ -9,54 +9,52 @@
 
 / {
 	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
+};
+
+&{/soc/spi@1100a000} {
+	#address-cells = <1>;
+	#size-cells = <0>;
 
-	fragment@0 {
-		target-path = "/soc/spi@1100a000";
-		__overlay__ {
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
 			#address-cells = <1>;
-			#size-cells = <0>;
-			flash@0 {
-				compatible = "jedec,spi-nor";
-				reg = <0>;
-				spi-max-frequency = <10000000>;
-
-				partitions {
-					compatible = "fixed-partitions";
-					#address-cells = <1>;
-					#size-cells = <1>;
-
-					partition@0 {
-						label = "bl2";
-						reg = <0x0 0x40000>;
-						read-only;
-					};
-
-					partition@40000 {
-						label = "u-boot-env";
-						reg = <0x40000 0x40000>;
-					};
-
-					partition@80000 {
-						label = "reserved2";
-						reg = <0x80000 0x80000>;
-					};
-
-					partition@100000 {
-						label = "fip";
-						reg = <0x100000 0x80000>;
-						read-only;
-					};
-
-					partition@180000 {
-						label = "recovery";
-						reg = <0x180000 0xa80000>;
-					};
-
-					partition@c00000 {
-						label = "fit";
-						reg = <0xc00000 0x1400000>;
-					};
-				};
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "bl2";
+				reg = <0x0 0x40000>;
+				read-only;
+			};
+
+			partition@40000 {
+				label = "u-boot-env";
+				reg = <0x40000 0x40000>;
+			};
+
+			partition@80000 {
+				label = "reserved2";
+				reg = <0x80000 0x80000>;
+			};
+
+			partition@100000 {
+				label = "fip";
+				reg = <0x100000 0x80000>;
+				read-only;
+			};
+
+			partition@180000 {
+				label = "recovery";
+				reg = <0x180000 0xa80000>;
+			};
+
+			partition@c00000 {
+				label = "fit";
+				reg = <0xc00000 0x1400000>;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dtso
index f623bce075ce6ea4..d9e01967acc471b8 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dtso
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dtso
@@ -9,15 +9,11 @@
 
 / {
 	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
-
-	fragment@0 {
-		target-path = "/soc/mmc@11230000";
-		__overlay__ {
-			bus-width = <4>;
-			max-frequency = <52000000>;
-			cap-sd-highspeed;
-			status = "okay";
-		};
-	};
 };
 
+&{/soc/mmc@11230000} {
+	bus-width = <4>;
+	max-frequency = <52000000>;
+	cap-sd-highspeed;
+	status = "okay";
+};
-- 
2.34.1

