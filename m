Return-Path: <linux-kernel+bounces-27850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEDB82F6C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADD42871D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1993D59173;
	Tue, 16 Jan 2024 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uC8dPT0l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E4A59154;
	Tue, 16 Jan 2024 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434367; cv=none; b=CCF7E1xWod85YEjnEA8fbp8c7aam3snrMw5jjnLYcrFCOTOD9KV+Rp8QiyKT7MKu7fsQev6zZyaXDcdNiYSZjNfFtQGnPBkUQ0Q+luOCQUYeQ9BukHYbs4vOo5A9BAGqKKVQ/Eq3u/5QLHc1radY0b5F7LtIORdbK/HV1wPx1rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434367; c=relaxed/simple;
	bh=vJJxC7GvRRYzz6QEBXf0pJwer78D45JjpVws+KiMlxY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=uzsnL3CE9FJH/LN9WfCfzqXASzLd/6E/WPNW0itPUNQJ4KTL8Fck7Sf04PQ1p32kQ8ydNZn8OIfQZqlGog9uutPVtIOhomsifE3EG9PL/zN+3IqsWaoRhZkCQynYN4blJ02WEUgtzgTJb3SwoyIFexxs7MuVWpJPmiphUS5LiTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uC8dPT0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3C6C43399;
	Tue, 16 Jan 2024 19:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434367;
	bh=vJJxC7GvRRYzz6QEBXf0pJwer78D45JjpVws+KiMlxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uC8dPT0lLSkpgSxXZ16lUXCIap5M/a0BqbVE8GlPUpRKCDZWQefQ9k6tbvFq/qbJf
	 fCVi+ksrQvuJkEs1wr7RpEDPqS5NFM6Fl4G8VoY1K/O5/0SSYL7K2ro+WttKzgF/7h
	 +FOnD95rVm2mzyJHX8AXtJMcEAuSgcE5I0mT6xKEPfTVlGiLnRpEQt7gEvZsVR5J1v
	 j8JBrC/Jw/EG48u0ZUECRAHo9IM0EhdyhFjIpwP7yTu7b2yRcxqiLm5teoPvnCu/p0
	 vVJn48q0+qkzwoWjc5cNokESvjJveozLl/+0gCCmKQZ4kB/b260zFuKLyR2qZoHtSa
	 X2g62Lg0HecJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	sebastian.hesselbarth@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 079/108] ARM64: dts: marvell: Fix some common switch mistakes
Date: Tue, 16 Jan 2024 14:39:45 -0500
Message-ID: <20240116194225.250921-79-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit fedb923aaf611e36adad4cd8c91d35bc283d3eea ]

Fix some errors in the Marvell MV88E6xxx switch descriptions:
- The top node had no address size or cells.
- switch0@0 is not OK, should be ethernet-switch@0.
- ports should be ethernet-ports
- port@0 should be ethernet-port@0
- PHYs should be named ethernet-phy@

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../marvell/armada-3720-espressobin-ultra.dts | 14 +--
 .../dts/marvell/armada-3720-espressobin.dtsi  | 20 ++---
 .../dts/marvell/armada-3720-gl-mv1000.dts     | 20 ++---
 .../dts/marvell/armada-3720-turris-mox.dts    | 85 +++++++++++--------
 .../boot/dts/marvell/armada-7040-mochabin.dts | 24 +++---
 .../marvell/armada-8040-clearfog-gt-8k.dts    | 22 ++---
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi   | 42 +++++----
 7 files changed, 115 insertions(+), 112 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
index f9abef8dcc94..870bb380a40a 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -126,32 +126,32 @@ &switch0 {
 
 	reset-gpios = <&gpiosb 23 GPIO_ACTIVE_LOW>;
 
-	ports {
-		switch0port1: port@1 {
+	ethernet-ports {
+		switch0port1: ethernet-port@1 {
 			reg = <1>;
 			label = "lan0";
 			phy-handle = <&switch0phy0>;
 		};
 
-		switch0port2: port@2 {
+		switch0port2: ethernet-port@2 {
 			reg = <2>;
 			label = "lan1";
 			phy-handle = <&switch0phy1>;
 		};
 
-		switch0port3: port@3 {
+		switch0port3: ethernet-port@3 {
 			reg = <3>;
 			label = "lan2";
 			phy-handle = <&switch0phy2>;
 		};
 
-		switch0port4: port@4 {
+		switch0port4: ethernet-port@4 {
 			reg = <4>;
 			label = "lan3";
 			phy-handle = <&switch0phy3>;
 		};
 
-		switch0port5: port@5 {
+		switch0port5: ethernet-port@5 {
 			reg = <5>;
 			label = "wan";
 			phy-handle = <&extphy>;
@@ -160,7 +160,7 @@ switch0port5: port@5 {
 	};
 
 	mdio {
-		switch0phy3: switch0phy3@14 {
+		switch0phy3: ethernet-phy@14 {
 			reg = <0x14>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 49cbdb55b4b3..fed2dcecb323 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -145,19 +145,17 @@ &usb2 {
 };
 
 &mdio {
-	switch0: switch0@1 {
+	switch0: ethernet-switch@1 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <1>;
 
 		dsa,member = <0 0>;
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch0port0: port@0 {
+			switch0port0: ethernet-port@0 {
 				reg = <0>;
 				label = "cpu";
 				ethernet = <&eth0>;
@@ -168,19 +166,19 @@ fixed-link {
 				};
 			};
 
-			switch0port1: port@1 {
+			switch0port1: ethernet-port@1 {
 				reg = <1>;
 				label = "wan";
 				phy-handle = <&switch0phy0>;
 			};
 
-			switch0port2: port@2 {
+			switch0port2: ethernet-port@2 {
 				reg = <2>;
 				label = "lan0";
 				phy-handle = <&switch0phy1>;
 			};
 
-			switch0port3: port@3 {
+			switch0port3: ethernet-port@3 {
 				reg = <3>;
 				label = "lan1";
 				phy-handle = <&switch0phy2>;
@@ -192,13 +190,13 @@ mdio {
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
 		};
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
index b1b45b4fa9d4..63fbc8352161 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
@@ -152,31 +152,29 @@ &uart0 {
 };
 
 &mdio {
-	switch0: switch0@1 {
+	switch0: ethernet-switch@1 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <1>;
 
 		dsa,member = <0 0>;
 
-		ports: ports {
+		ports: ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@0 {
+			ethernet-port@0 {
 				reg = <0>;
 				label = "cpu";
 				ethernet = <&eth0>;
 			};
 
-			port@1 {
+			ethernet-port@1 {
 				reg = <1>;
 				label = "wan";
 				phy-handle = <&switch0phy0>;
 			};
 
-			port@2 {
+			ethernet-port@2 {
 				reg = <2>;
 				label = "lan0";
 				phy-handle = <&switch0phy1>;
@@ -185,7 +183,7 @@ port@2 {
 				nvmem-cell-names = "mac-address";
 			};
 
-			port@3 {
+			ethernet-port@3 {
 				reg = <3>;
 				label = "lan1";
 				phy-handle = <&switch0phy2>;
@@ -199,13 +197,13 @@ mdio {
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
 		};
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 9eab2bb22134..66cd98b67744 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -304,7 +304,13 @@ phy1: ethernet-phy@1 {
 		reg = <1>;
 	};
 
-	/* switch nodes are enabled by U-Boot if modules are present */
+	/*
+	 * NOTE: switch nodes are enabled by U-Boot if modules are present
+	 * DO NOT change this node name (switch0@10) even if it is not following
+	 * conventions! Deployed U-Boot binaries are explicitly looking for
+	 * this node in order to augment the device tree!
+	 * Also do not touch the "ports" or "port@n" nodes. These are also ABI.
+	 */
 	switch0@10 {
 		compatible = "marvell,mv88e6190";
 		reg = <0x10>;
@@ -317,35 +323,35 @@ mdio {
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
@@ -430,6 +436,7 @@ port-sfp@a {
 		};
 	};
 
+	/* NOTE: this node name is ABI, don't change it! */
 	switch0@2 {
 		compatible = "marvell,mv88e6085";
 		reg = <0x2>;
@@ -442,19 +449,19 @@ mdio {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch0phy1_topaz: switch0phy1@11 {
+			switch0phy1_topaz: ethernet-phy@11 {
 				reg = <0x11>;
 			};
 
-			switch0phy2_topaz: switch0phy2@12 {
+			switch0phy2_topaz: ethernet-phy@12 {
 				reg = <0x12>;
 			};
 
-			switch0phy3_topaz: switch0phy3@13 {
+			switch0phy3_topaz: ethernet-phy@13 {
 				reg = <0x13>;
 			};
 
-			switch0phy4_topaz: switch0phy4@14 {
+			switch0phy4_topaz: ethernet-phy@14 {
 				reg = <0x14>;
 			};
 		};
@@ -497,6 +504,7 @@ port@5 {
 		};
 	};
 
+	/* NOTE: this node name is ABI, don't change it! */
 	switch1@11 {
 		compatible = "marvell,mv88e6190";
 		reg = <0x11>;
@@ -509,35 +517,35 @@ mdio {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch1phy1: switch1phy1@1 {
+			switch1phy1: ethernet-phy@1 {
 				reg = <0x1>;
 			};
 
-			switch1phy2: switch1phy2@2 {
+			switch1phy2: ethernet-phy@2 {
 				reg = <0x2>;
 			};
 
-			switch1phy3: switch1phy3@3 {
+			switch1phy3: ethernet-phy@3 {
 				reg = <0x3>;
 			};
 
-			switch1phy4: switch1phy4@4 {
+			switch1phy4: ethernet-phy@4 {
 				reg = <0x4>;
 			};
 
-			switch1phy5: switch1phy5@5 {
+			switch1phy5: ethernet-phy@5 {
 				reg = <0x5>;
 			};
 
-			switch1phy6: switch1phy6@6 {
+			switch1phy6: ethernet-phy@6 {
 				reg = <0x6>;
 			};
 
-			switch1phy7: switch1phy7@7 {
+			switch1phy7: ethernet-phy@7 {
 				reg = <0x7>;
 			};
 
-			switch1phy8: switch1phy8@8 {
+			switch1phy8: ethernet-phy@8 {
 				reg = <0x8>;
 			};
 		};
@@ -622,6 +630,7 @@ port-sfp@a {
 		};
 	};
 
+	/* NOTE: this node name is ABI, don't change it! */
 	switch1@2 {
 		compatible = "marvell,mv88e6085";
 		reg = <0x2>;
@@ -634,19 +643,19 @@ mdio {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch1phy1_topaz: switch1phy1@11 {
+			switch1phy1_topaz: ethernet-phy@11 {
 				reg = <0x11>;
 			};
 
-			switch1phy2_topaz: switch1phy2@12 {
+			switch1phy2_topaz: ethernet-phy@12 {
 				reg = <0x12>;
 			};
 
-			switch1phy3_topaz: switch1phy3@13 {
+			switch1phy3_topaz: ethernet-phy@13 {
 				reg = <0x13>;
 			};
 
-			switch1phy4_topaz: switch1phy4@14 {
+			switch1phy4_topaz: ethernet-phy@14 {
 				reg = <0x14>;
 			};
 		};
@@ -689,6 +698,7 @@ port@5 {
 		};
 	};
 
+	/* NOTE: this node name is ABI, don't change it! */
 	switch2@12 {
 		compatible = "marvell,mv88e6190";
 		reg = <0x12>;
@@ -701,35 +711,35 @@ mdio {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch2phy1: switch2phy1@1 {
+			switch2phy1: ethernet-phy@1 {
 				reg = <0x1>;
 			};
 
-			switch2phy2: switch2phy2@2 {
+			switch2phy2: ethernet-phy@2 {
 				reg = <0x2>;
 			};
 
-			switch2phy3: switch2phy3@3 {
+			switch2phy3: ethernet-phy@3 {
 				reg = <0x3>;
 			};
 
-			switch2phy4: switch2phy4@4 {
+			switch2phy4: ethernet-phy@4 {
 				reg = <0x4>;
 			};
 
-			switch2phy5: switch2phy5@5 {
+			switch2phy5: ethernet-phy@5 {
 				reg = <0x5>;
 			};
 
-			switch2phy6: switch2phy6@6 {
+			switch2phy6: ethernet-phy@6 {
 				reg = <0x6>;
 			};
 
-			switch2phy7: switch2phy7@7 {
+			switch2phy7: ethernet-phy@7 {
 				reg = <0x7>;
 			};
 
-			switch2phy8: switch2phy8@8 {
+			switch2phy8: ethernet-phy@8 {
 				reg = <0x8>;
 			};
 		};
@@ -805,6 +815,7 @@ port-sfp@a {
 		};
 	};
 
+	/* NOTE: this node name is ABI, don't change it! */
 	switch2@2 {
 		compatible = "marvell,mv88e6085";
 		reg = <0x2>;
@@ -817,19 +828,19 @@ mdio {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch2phy1_topaz: switch2phy1@11 {
+			switch2phy1_topaz: ethernet-phy@11 {
 				reg = <0x11>;
 			};
 
-			switch2phy2_topaz: switch2phy2@12 {
+			switch2phy2_topaz: ethernet-phy@12 {
 				reg = <0x12>;
 			};
 
-			switch2phy3_topaz: switch2phy3@13 {
+			switch2phy3_topaz: ethernet-phy@13 {
 				reg = <0x13>;
 			};
 
-			switch2phy4_topaz: switch2phy4@14 {
+			switch2phy4_topaz: ethernet-phy@14 {
 				reg = <0x14>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
index 48202810bf78..40b7ee7ead72 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
@@ -301,10 +301,8 @@ eth2phy: ethernet-phy@1 {
 	};
 
 	/* 88E6141 Topaz switch */
-	switch: switch@3 {
+	switch: ethernet-switch@3 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <3>;
 
 		pinctrl-names = "default";
@@ -314,35 +312,35 @@ switch: switch@3 {
 		interrupt-parent = <&cp0_gpio1>;
 		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			swport1: port@1 {
+			swport1: ethernet-port@1 {
 				reg = <1>;
 				label = "lan0";
 				phy-handle = <&swphy1>;
 			};
 
-			swport2: port@2 {
+			swport2: ethernet-port@2 {
 				reg = <2>;
 				label = "lan1";
 				phy-handle = <&swphy2>;
 			};
 
-			swport3: port@3 {
+			swport3: ethernet-port@3 {
 				reg = <3>;
 				label = "lan2";
 				phy-handle = <&swphy3>;
 			};
 
-			swport4: port@4 {
+			swport4: ethernet-port@4 {
 				reg = <4>;
 				label = "lan3";
 				phy-handle = <&swphy4>;
 			};
 
-			port@5 {
+			ethernet-port@5 {
 				reg = <5>;
 				label = "cpu";
 				ethernet = <&cp0_eth1>;
@@ -355,19 +353,19 @@ mdio {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			swphy1: swphy1@17 {
+			swphy1: ethernet-phy@17 {
 				reg = <17>;
 			};
 
-			swphy2: swphy2@18 {
+			swphy2: ethernet-phy@18 {
 				reg = <18>;
 			};
 
-			swphy3: swphy3@19 {
+			swphy3: ethernet-phy@19 {
 				reg = <19>;
 			};
 
-			swphy4: swphy4@20 {
+			swphy4: ethernet-phy@20 {
 				reg = <20>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index 4125202028c8..67892f0d2863 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -497,42 +497,42 @@ ge_phy: ethernet-phy@0 {
 		reset-deassert-us = <10000>;
 	};
 
-	switch0: switch0@4 {
+	switch0: ethernet-switch@4 {
 		compatible = "marvell,mv88e6085";
 		reg = <4>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&cp1_switch_reset_pins>;
 		reset-gpios = <&cp1_gpio1 24 GPIO_ACTIVE_LOW>;
 
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
 				label = "cpu";
 				ethernet = <&cp1_eth2>;
@@ -545,19 +545,19 @@ mdio {
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
diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
index 47d45ff3d6f5..6fcc34f7b464 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
@@ -207,11 +207,9 @@ phy0: ethernet-phy@0 {
 		reg = <0>;
 	};
 
-	switch6: switch0@6 {
+	switch6: ethernet-switch@6 {
 		/* Actual device is MV88E6393X */
 		compatible = "marvell,mv88e6190";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <6>;
 		interrupt-parent = <&cp0_gpio1>;
 		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
@@ -220,59 +218,59 @@ switch6: switch0@6 {
 
 		dsa,member = <0 0>;
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@1 {
+			ethernet-port@1 {
 				reg = <1>;
 				label = "p1";
 				phy-handle = <&switch0phy1>;
 			};
 
-			port@2 {
+			ethernet-port@2 {
 				reg = <2>;
 				label = "p2";
 				phy-handle = <&switch0phy2>;
 			};
 
-			port@3 {
+			ethernet-port@3 {
 				reg = <3>;
 				label = "p3";
 				phy-handle = <&switch0phy3>;
 			};
 
-			port@4 {
+			ethernet-port@4 {
 				reg = <4>;
 				label = "p4";
 				phy-handle = <&switch0phy4>;
 			};
 
-			port@5 {
+			ethernet-port@5 {
 				reg = <5>;
 				label = "p5";
 				phy-handle = <&switch0phy5>;
 			};
 
-			port@6 {
+			ethernet-port@6 {
 				reg = <6>;
 				label = "p6";
 				phy-handle = <&switch0phy6>;
 			};
 
-			port@7 {
+			ethernet-port@7 {
 				reg = <7>;
 				label = "p7";
 				phy-handle = <&switch0phy7>;
 			};
 
-			port@8 {
+			ethernet-port@8 {
 				reg = <8>;
 				label = "p8";
 				phy-handle = <&switch0phy8>;
 			};
 
-			port@9 {
+			ethernet-port@9 {
 				reg = <9>;
 				label = "p9";
 				phy-mode = "10gbase-r";
@@ -280,7 +278,7 @@ port@9 {
 				managed = "in-band-status";
 			};
 
-			port@a {
+			ethernet-port@a {
 				reg = <10>;
 				ethernet = <&cp0_eth0>;
 				phy-mode = "10gbase-r";
@@ -293,35 +291,35 @@ mdio {
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
-- 
2.43.0


