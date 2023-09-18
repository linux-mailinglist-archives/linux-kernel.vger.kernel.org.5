Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1477A4378
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbjIRHwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbjIRHvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:51:46 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B097A30FB;
        Mon, 18 Sep 2023 00:50:13 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 604401BF203;
        Mon, 18 Sep 2023 07:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1695023390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ay9z8iCgn/QbbcXOHhzU2eHu2INYQIkvsbpXhE3QZ/c=;
        b=eg7QVZ51CDJsCQNwbIDmlAyAOx6jXVk4bEaLQZ2OGn5oknpL2Dn6JZ6BVJurC35IsCncRZ
        PEpjRdWqhKPNzJRmQVOH6z+W7OZ0SNF21p8VoVAOepcZ+KdMpzV/ASMt++au0CiOgBk1oo
        xaJdDqwC9bZz2ZcdBUfaXs7yIJmffOZC6wSj0VQLIHz02KbiwviVGSJ3wPVmZwfi3cmtzl
        wb8ToQaq8kAIWfI3XgOqUV+4P3gJVZ9MH+jOoCR0AmHZovO2X+6blnqcOzQOKR6kiaCNqP
        nehlSUg6SDnOvGCL3UUwbDnyyosAiEfRqkO84VYTmSE6kWXihPs/kur32ipC3w==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: {mt7622,mt7986}: add port@5 as CPU port
Date:   Mon, 18 Sep 2023 10:49:38 +0300
Message-Id: <20230918074938.79796-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Banana Pi BPI-R64, MediaTek MT7622 RFB1 board, MediaTek MT7986b RFB, and
MediaTek MT7986a RFB, port 5 of the MT7531 switch is connected to the
second MAC of the SoC as a CPU port. Add the port and set up the second MAC
on the bindings.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  | 12 ++++++++++
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts  | 24 +++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts  | 24 +++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts  | 24 +++++++++++++++++++
 4 files changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 86cedb0bf1a9..f2cc95d4a343 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -186,6 +186,18 @@ port@4 {
 					label = "lan3";
 				};
 
+				port@5 {
+					reg = <5>;
+					ethernet = <&gmac1>;
+					phy-mode = "rgmii";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+						pause;
+					};
+				};
+
 				port@6 {
 					reg = <6>;
 					label = "cpu";
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index dad8e683aac5..018912964b32 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -117,6 +117,18 @@ fixed-link {
 		};
 	};
 
+	gmac1: mac@1 {
+		compatible = "mediatek,eth-mac";
+		reg = <1>;
+		phy-mode = "rgmii";
+
+		fixed-link {
+			speed = <1000>;
+			full-duplex;
+			pause;
+		};
+	};
+
 	mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -155,6 +167,18 @@ port@4 {
 					label = "wan";
 				};
 
+				port@5 {
+					reg = <5>;
+					ethernet = <&gmac1>;
+					phy-mode = "rgmii";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+						pause;
+					};
+				};
+
 				port@6 {
 					reg = <6>;
 					label = "cpu";
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index 3ef371ca254e..3aba067f56b6 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -65,6 +65,18 @@ fixed-link {
 		};
 	};
 
+	gmac1: mac@1 {
+		compatible = "mediatek,eth-mac";
+		reg = <1>;
+		phy-mode = "rgmii";
+
+		fixed-link {
+			speed = <1000>;
+			full-duplex;
+			pause;
+		};
+	};
+
 	mdio: mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -287,6 +299,18 @@ port@4 {
 			label = "lan4";
 		};
 
+		port@5 {
+			reg = <5>;
+			ethernet = <&gmac1>;
+			phy-mode = "rgmii";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+				pause;
+			};
+		};
+
 		port@6 {
 			reg = <6>;
 			label = "cpu";
diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
index dde190442e38..89ca852a9854 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
@@ -45,6 +45,18 @@ fixed-link {
 		};
 	};
 
+	gmac1: mac@1 {
+		compatible = "mediatek,eth-mac";
+		reg = <1>;
+		phy-mode = "rgmii";
+
+		fixed-link {
+			speed = <1000>;
+			full-duplex;
+			pause;
+		};
+	};
+
 	mdio: mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -83,6 +95,18 @@ port@4 {
 					label = "lan4";
 				};
 
+				port@5 {
+					reg = <5>;
+					ethernet = <&gmac1>;
+					phy-mode = "rgmii";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+						pause;
+					};
+				};
+
 				port@6 {
 					reg = <6>;
 					label = "cpu";
-- 
2.39.2

