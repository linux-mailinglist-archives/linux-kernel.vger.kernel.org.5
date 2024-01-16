Return-Path: <linux-kernel+bounces-27989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D06F82F8C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB971C25127
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19B51386AE;
	Tue, 16 Jan 2024 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzYYl+9b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A8D1386BC;
	Tue, 16 Jan 2024 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434779; cv=none; b=mB3tElMXk8Zz5joVRjqds4gFCwnRSrvrgFHfNK4AjMo46+oHYlTmeHWAyc1unL6b77V7sinbpCPjuJa2MpAca62kKMULkW3tiL5mHNIDKMQHAKmYwvRmfeha2TCSTQV4oxlyaWBqgSsQz2j1jcl56FRYH8PsHqRHxJzb9GGSh2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434779; c=relaxed/simple;
	bh=ctt53Mc0LgAk/l4JinwByhQj7Sm9oGI6DQIo409V9Ic=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ifGnPJ1mPXomkZrplErH9lgZ46WWq2LTG8+jAk8MOQdyvancAzC28t5aZ789wuESW0Db0l1y0qgTOyS2uGn1GfSWF+baLvZiBTbLXFcC7oLUa3V3mGzYSkmHDr1sC1loqAIDGz3kqF/Qv/flkqPaep+CnucGrtGtCoxfsq4Uqac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzYYl+9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C05C433F1;
	Tue, 16 Jan 2024 19:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434779;
	bh=ctt53Mc0LgAk/l4JinwByhQj7Sm9oGI6DQIo409V9Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EzYYl+9bLZPujJKFxAUJW7mEkoIZKm6YS33vAsCDEUS8q1B8XFAzGF/5mUY0U1KSx
	 UbP5NS6bgnCYo6ht8BRflz08ofoKIVF+HZ4+WppLUbM1hMQh1b4GvRk2ExQyR8rd0d
	 /CFHsqJyVks3zcX5bcQcLI7EnOcIPsupdPe13ALCppH0zGoQ7SbSO5Ckdln+y3+Vga
	 n7SLXibKWhuYHDBIJTnM7yP8M879tllj5C9n+GVYdAHtLdMrdaijm77J5x1PlqTBKq
	 6eLex3ZOCRcJbyPOwE+3If2Ev3guHaPN9KJq4EMuuIB1gjgHrhWmLDreXxoLEaQqi4
	 abkLLoeWbHYkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 077/104] ARM: dts: marvell: Fix some common switch mistakes
Date: Tue, 16 Jan 2024 14:46:43 -0500
Message-ID: <20240116194908.253437-77-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 2b83557a588f739fd0a63efe1c3bc851cdf3d5f6 ]

Fix some errors in the Marvell MV88E6xxx switch descriptions:
- The top node had no address size or cells.
- switch0@0 is not OK, should be ethernet-switch@0.
- The ports node should be named ethernet-ports
- The ethernet-ports node should have port@0 etc children, no
  plural "ports" in the children.
- Ports should be named ethernet-port@0 etc
- PHYs should be named ethernet-phy@0 etc

This serves as an example of fixes needed for introducing a
schema for the bindings, but the patch can simply be applied.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/marvell/armada-370-rd.dts   | 24 +++++-----
 .../marvell/armada-381-netgear-gs110emx.dts   | 44 +++++++++----------
 .../marvell/armada-385-clearfog-gtr-l8.dts    | 38 ++++++++--------
 .../marvell/armada-385-clearfog-gtr-s4.dts    | 22 +++++-----
 .../boot/dts/marvell/armada-385-linksys.dtsi  | 18 ++++----
 .../dts/marvell/armada-385-turris-omnia.dts   | 20 ++++-----
 .../boot/dts/marvell/armada-388-clearfog.dts  | 20 ++++-----
 .../dts/marvell/armada-xp-linksys-mamba.dts   | 18 ++++----
 8 files changed, 96 insertions(+), 108 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-370-rd.dts b/arch/arm/boot/dts/marvell/armada-370-rd.dts
index b459a670f615..1b241da11e94 100644
--- a/arch/arm/boot/dts/marvell/armada-370-rd.dts
+++ b/arch/arm/boot/dts/marvell/armada-370-rd.dts
@@ -149,39 +149,37 @@ led@0 {
 		};
 	};
 
-	switch: switch@10 {
+	switch: ethernet-switch@10 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <0x10>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@0 {
+			ethernet-port@0 {
 				reg = <0>;
 				label = "lan0";
 			};
 
-			port@1 {
+			ethernet-port@1 {
 				reg = <1>;
 				label = "lan1";
 			};
 
-			port@2 {
+			ethernet-port@2 {
 				reg = <2>;
 				label = "lan2";
 			};
 
-			port@3 {
+			ethernet-port@3 {
 				reg = <3>;
 				label = "lan3";
 			};
 
-			port@5 {
+			ethernet-port@5 {
 				reg = <5>;
 				ethernet = <&eth1>;
 				phy-mode = "rgmii-id";
@@ -196,25 +194,25 @@ mdio {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switchphy0: switchphy@0 {
+			switchphy0: ethernet-phy@0 {
 				reg = <0>;
 				interrupt-parent = <&switch>;
 				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			switchphy1: switchphy@1 {
+			switchphy1: ethernet-phy@1 {
 				reg = <1>;
 				interrupt-parent = <&switch>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			switchphy2: switchphy@2 {
+			switchphy2: ethernet-phy@2 {
 				reg = <2>;
 				interrupt-parent = <&switch>;
 				interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			switchphy3: switchphy@3 {
+			switchphy3: ethernet-phy@3 {
 				reg = <3>;
 				interrupt-parent = <&switch>;
 				interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts b/arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts
index f4c4b213ef4e..5baf83e5253d 100644
--- a/arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts
+++ b/arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts
@@ -77,51 +77,49 @@ &mdio {
 	pinctrl-0 = <&mdio_pins>;
 	status = "okay";
 
-	switch@0 {
+	ethernet-switch@0 {
 		compatible = "marvell,mv88e6190";
-		#address-cells = <1>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		interrupt-parent = <&gpio1>;
 		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-0 = <&switch_interrupt_pins>;
 		pinctrl-names = "default";
-		#size-cells = <0>;
 		reg = <0>;
 
 		mdio {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch0phy1: switch0phy1@1 {
+			switch0phy1: ethernet-phy@1 {
 				reg = <0x1>;
 			};
 
-			switch0phy2: switch0phy2@2 {
+			switch0phy2: ethernet-phy@2 {
 				reg = <0x2>;
 			};
 
-			switch0phy3: switch0phy3@3 {
+			switch0phy3: ethernet-phy@3 {
 				reg = <0x3>;
 			};
 
-			switch0phy4: switch0phy4@4 {
+			switch0phy4: ethernet-phy@4 {
 				reg = <0x4>;
 			};
 
-			switch0phy5: switch0phy5@5 {
+			switch0phy5: ethernet-phy@5 {
 				reg = <0x5>;
 			};
 
-			switch0phy6: switch0phy6@6 {
+			switch0phy6: ethernet-phy@6 {
 				reg = <0x6>;
 			};
 
-			switch0phy7: switch0phy7@7 {
+			switch0phy7: ethernet-phy@7 {
 				reg = <0x7>;
 			};
 
-			switch0phy8: switch0phy8@8 {
+			switch0phy8: ethernet-phy@8 {
 				reg = <0x8>;
 			};
 		};
@@ -142,11 +140,11 @@ phy2: ethernet-phy@c {
 			};
 		};
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@0 {
+			ethernet-port@0 {
 				ethernet = <&eth0>;
 				phy-mode = "rgmii";
 				reg = <0>;
@@ -158,55 +156,55 @@ fixed-link {
 				};
 			};
 
-			port@1 {
+			ethernet-port@1 {
 				label = "lan1";
 				phy-handle = <&switch0phy1>;
 				reg = <1>;
 			};
 
-			port@2 {
+			ethernet-port@2 {
 				label = "lan2";
 				phy-handle = <&switch0phy2>;
 				reg = <2>;
 			};
 
-			port@3 {
+			ethernet-port@3 {
 				label = "lan3";
 				phy-handle = <&switch0phy3>;
 				reg = <3>;
 			};
 
-			port@4 {
+			ethernet-port@4 {
 				label = "lan4";
 				phy-handle = <&switch0phy4>;
 				reg = <4>;
 			};
 
-			port@5 {
+			ethernet-port@5 {
 				label = "lan5";
 				phy-handle = <&switch0phy5>;
 				reg = <5>;
 			};
 
-			port@6 {
+			ethernet-port@6 {
 				label = "lan6";
 				phy-handle = <&switch0phy6>;
 				reg = <6>;
 			};
 
-			port@7 {
+			ethernet-port@7 {
 				label = "lan7";
 				phy-handle = <&switch0phy7>;
 				reg = <7>;
 			};
 
-			port@8 {
+			ethernet-port@8 {
 				label = "lan8";
 				phy-handle = <&switch0phy8>;
 				reg = <8>;
 			};
 
-			port@9 {
+			ethernet-port@9 {
 				/* 88X3310P external phy */
 				label = "lan9";
 				phy-handle = <&phy1>;
@@ -214,7 +212,7 @@ port@9 {
 				reg = <9>;
 			};
 
-			port@a {
+			ethernet-port@a {
 				/* 88X3310P external phy */
 				label = "lan10";
 				phy-handle = <&phy2>;
diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
index 1990f7d0cc79..1707d1b01545 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
@@ -7,66 +7,66 @@ / {
 };
 
 &mdio {
-	switch0: switch0@4 {
+	switch0: ethernet-switch@4 {
 		compatible = "marvell,mv88e6190";
 		reg = <4>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&cf_gtr_switch_reset_pins>;
 		reset-gpios = <&gpio0 18 GPIO_ACTIVE_LOW>;
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@1 {
+			ethernet-port@1 {
 				reg = <1>;
 				label = "lan8";
 				phy-handle = <&switch0phy0>;
 			};
 
-			port@2 {
+			ethernet-port@2 {
 				reg = <2>;
 				label = "lan7";
 				phy-handle = <&switch0phy1>;
 			};
 
-			port@3 {
+			ethernet-port@3 {
 				reg = <3>;
 				label = "lan6";
 				phy-handle = <&switch0phy2>;
 			};
 
-			port@4 {
+			ethernet-port@4 {
 				reg = <4>;
 				label = "lan5";
 				phy-handle = <&switch0phy3>;
 			};
 
-			port@5 {
+			ethernet-port@5 {
 				reg = <5>;
 				label = "lan4";
 				phy-handle = <&switch0phy4>;
 			};
 
-			port@6 {
+			ethernet-port@6 {
 				reg = <6>;
 				label = "lan3";
 				phy-handle = <&switch0phy5>;
 			};
 
-			port@7 {
+			ethernet-port@7 {
 				reg = <7>;
 				label = "lan2";
 				phy-handle = <&switch0phy6>;
 			};
 
-			port@8 {
+			ethernet-port@8 {
 				reg = <8>;
 				label = "lan1";
 				phy-handle = <&switch0phy7>;
 			};
 
-			port@10 {
+			ethernet-port@10 {
 				reg = <10>;
 				phy-mode = "2500base-x";
 
@@ -83,35 +83,35 @@ mdio {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch0phy0: switch0phy0@1 {
+			switch0phy0: ethernet-phy@1 {
 				reg = <0x1>;
 			};
 
-			switch0phy1: switch0phy1@2 {
+			switch0phy1: ethernet-phy@2 {
 				reg = <0x2>;
 			};
 
-			switch0phy2: switch0phy2@3 {
+			switch0phy2: ethernet-phy@3 {
 				reg = <0x3>;
 			};
 
-			switch0phy3: switch0phy3@4 {
+			switch0phy3: ethernet-phy@4 {
 				reg = <0x4>;
 			};
 
-			switch0phy4: switch0phy4@5 {
+			switch0phy4: ethernet-phy@5 {
 				reg = <0x5>;
 			};
 
-			switch0phy5: switch0phy5@6 {
+			switch0phy5: ethernet-phy@6 {
 				reg = <0x6>;
 			};
 
-			switch0phy6: switch0phy6@7 {
+			switch0phy6: ethernet-phy@7 {
 				reg = <0x7>;
 			};
 
-			switch0phy7: switch0phy7@8 {
+			switch0phy7: ethernet-phy@8 {
 				reg = <0x8>;
 			};
 		};
diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts
index b795ad573891..a7678a784c18 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts
@@ -11,42 +11,42 @@ &sfp0 {
 };
 
 &mdio {
-	switch0: switch0@4 {
+	switch0: ethernet-switch@4 {
 		compatible = "marvell,mv88e6085";
 		reg = <4>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&cf_gtr_switch_reset_pins>;
 		reset-gpios = <&gpio0 18 GPIO_ACTIVE_LOW>;
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@1 {
+			ethernet-port@1 {
 				reg = <1>;
 				label = "lan2";
 				phy-handle = <&switch0phy0>;
 			};
 
-			port@2 {
+			ethernet-port@2 {
 				reg = <2>;
 				label = "lan1";
 				phy-handle = <&switch0phy1>;
 			};
 
-			port@3 {
+			ethernet-port@3 {
 				reg = <3>;
 				label = "lan4";
 				phy-handle = <&switch0phy2>;
 			};
 
-			port@4 {
+			ethernet-port@4 {
 				reg = <4>;
 				label = "lan3";
 				phy-handle = <&switch0phy3>;
 			};
 
-			port@5 {
+			ethernet-port@5 {
 				reg = <5>;
 				phy-mode = "2500base-x";
 				ethernet = <&eth1>;
@@ -63,19 +63,19 @@ mdio {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch0phy0: switch0phy0@11 {
+			switch0phy0: ethernet-phy@11 {
 				reg = <0x11>;
 			};
 
-			switch0phy1: switch0phy1@12 {
+			switch0phy1: ethernet-phy@12 {
 				reg = <0x12>;
 			};
 
-			switch0phy2: switch0phy2@13 {
+			switch0phy2: ethernet-phy@13 {
 				reg = <0x13>;
 			};
 
-			switch0phy3: switch0phy3@14 {
+			switch0phy3: ethernet-phy@14 {
 				reg = <0x14>;
 			};
 		};
diff --git a/arch/arm/boot/dts/marvell/armada-385-linksys.dtsi b/arch/arm/boot/dts/marvell/armada-385-linksys.dtsi
index fc8216fd9f60..4116ed60f709 100644
--- a/arch/arm/boot/dts/marvell/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/marvell/armada-385-linksys.dtsi
@@ -158,42 +158,40 @@ nand: nand@0 {
 &mdio {
 	status = "okay";
 
-	switch@0 {
+	ethernet-switch@0 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <0>;
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@0 {
+			ethernet-port@0 {
 				reg = <0>;
 				label = "lan4";
 			};
 
-			port@1 {
+			ethernet-port@1 {
 				reg = <1>;
 				label = "lan3";
 			};
 
-			port@2 {
+			ethernet-port@2 {
 				reg = <2>;
 				label = "lan2";
 			};
 
-			port@3 {
+			ethernet-port@3 {
 				reg = <3>;
 				label = "lan1";
 			};
 
-			port@4 {
+			ethernet-port@4 {
 				reg = <4>;
 				label = "wan";
 			};
 
-			port@5 {
+			ethernet-port@5 {
 				reg = <5>;
 				phy-mode = "sgmii";
 				ethernet = <&eth2>;
diff --git a/arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts b/arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts
index 2d8d319bec83..7b755bb4e4e7 100644
--- a/arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts
@@ -435,12 +435,10 @@ phy1: ethernet-phy@1 {
 	};
 
 	/* Switch MV88E6176 at address 0x10 */
-	switch@10 {
+	ethernet-switch@10 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&swint_pins>;
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		dsa,member = <0 0>;
 		reg = <0x10>;
@@ -448,36 +446,36 @@ switch@10 {
 		interrupt-parent = <&gpio1>;
 		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			ports@0 {
+			ethernet-port@0 {
 				reg = <0>;
 				label = "lan0";
 			};
 
-			ports@1 {
+			ethernet-port@1 {
 				reg = <1>;
 				label = "lan1";
 			};
 
-			ports@2 {
+			ethernet-port@2 {
 				reg = <2>;
 				label = "lan2";
 			};
 
-			ports@3 {
+			ethernet-port@3 {
 				reg = <3>;
 				label = "lan3";
 			};
 
-			ports@4 {
+			ethernet-port@4 {
 				reg = <4>;
 				label = "lan4";
 			};
 
-			ports@5 {
+			ethernet-port@5 {
 				reg = <5>;
 				ethernet = <&eth1>;
 				phy-mode = "rgmii-id";
@@ -488,7 +486,7 @@ fixed-link {
 				};
 			};
 
-			ports@6 {
+			ethernet-port@6 {
 				reg = <6>;
 				ethernet = <&eth0>;
 				phy-mode = "rgmii-id";
diff --git a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
index 32c569df142f..3290ccad2374 100644
--- a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
@@ -92,44 +92,42 @@ pcie2-0-w-disable-hog {
 &mdio {
 	status = "okay";
 
-	switch@4 {
+	ethernet-switch@4 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <4>;
 		pinctrl-0 = <&clearfog_dsa0_clk_pins &clearfog_dsa0_pins>;
 		pinctrl-names = "default";
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@0 {
+			ethernet-port@0 {
 				reg = <0>;
 				label = "lan5";
 			};
 
-			port@1 {
+			ethernet-port@1 {
 				reg = <1>;
 				label = "lan4";
 			};
 
-			port@2 {
+			ethernet-port@2 {
 				reg = <2>;
 				label = "lan3";
 			};
 
-			port@3 {
+			ethernet-port@3 {
 				reg = <3>;
 				label = "lan2";
 			};
 
-			port@4 {
+			ethernet-port@4 {
 				reg = <4>;
 				label = "lan1";
 			};
 
-			port@5 {
+			ethernet-port@5 {
 				reg = <5>;
 				ethernet = <&eth1>;
 				phy-mode = "1000base-x";
@@ -140,7 +138,7 @@ fixed-link {
 				};
 			};
 
-			port@6 {
+			ethernet-port@6 {
 				/* 88E1512 external phy */
 				reg = <6>;
 				label = "lan6";
diff --git a/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
index 7a0614fd0c93..ea859f7ea042 100644
--- a/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
@@ -265,42 +265,40 @@ flash@0 {
 &mdio {
 	status = "okay";
 
-	switch@0 {
+	ethernet-switch@0 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <0>;
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@0 {
+			ethernet-port@0 {
 				reg = <0>;
 				label = "lan4";
 			};
 
-			port@1 {
+			ethernet-port@1 {
 				reg = <1>;
 				label = "lan3";
 			};
 
-			port@2 {
+			ethernet-port@2 {
 				reg = <2>;
 				label = "lan2";
 			};
 
-			port@3 {
+			ethernet-port@3 {
 				reg = <3>;
 				label = "lan1";
 			};
 
-			port@4 {
+			ethernet-port@4 {
 				reg = <4>;
 				label = "internet";
 			};
 
-			port@5 {
+			ethernet-port@5 {
 				reg = <5>;
 				phy-mode = "rgmii-id";
 				ethernet = <&eth0>;
-- 
2.43.0


