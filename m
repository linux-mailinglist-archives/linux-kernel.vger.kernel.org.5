Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BAB7D4C11
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbjJXJZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjJXJZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:25:26 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B73410C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:25:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507be298d2aso6182822e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698139518; x=1698744318; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IL2ResPg+hiG9clxg6x2c6XDYehjwty0hK+xdAu13LQ=;
        b=yB+DyUJpIf61qotEtQ6kbDTGoNDDduSWFH6Y+aeseq6xAIfA0dqO/kttnWh2NrXDfr
         Z5sE3mEmTSe7qst6OQ6806Q4mK7PT6n3eMrnBKaRVChVHQL5ic5dFdikuFPrdwtG5wCa
         NM8RnExY7e8QZaEDlRgXiof0N5U6XRaGDZOmZKaOafNEtxezcMwny4DqEGPlMsYB6ju0
         Uc1t0mLJ6aE7+mhHZJ1fN3tQP+SvmhOhaoMGb+9/UQ/emeOBs6eDG5gsQu0DZ58QjPMF
         CFCsHCWMkhQkPl7CitdcS61W3I/UbkKREl58v58qLnhtjLz+QY3yu5bmgX69XBfofDWj
         3m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698139518; x=1698744318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IL2ResPg+hiG9clxg6x2c6XDYehjwty0hK+xdAu13LQ=;
        b=Mn3QATMwOZxlK+K0/ydGUZ7TuQwkgwhuDYdwtFKKF3s+ICnXoJpzQNDPum6wzBfnEi
         oh8fskKsAPFAVEUGpSptds2czsV7cA8QYu7PTvfTaslnvET4DzlJGSgMcYkgC9pJOYTR
         OQBuSixI9NwKZKzeDR9hkwUThOFdKoKXr8B2ZeOISpPQl+7ZfJ1YA0swCDVUCv8xcYEU
         Hhp/3xcF0JjAsLU50x2C4mihCGJXpd2aHUBp8ooHksAmp+1ugmT3LlKmRldUyG7aI83a
         yYtyi1+3BTrxsJzAdSOZK8CAfDLOdEWb8p08mOaYJmX7rhU0btm5oBNfHr+nwg+R9pmY
         rBUw==
X-Gm-Message-State: AOJu0YyG2DIlHM/uCNuNhTBG7K8Lp0Ap0N1dNVmhnLrsTVY3ufivmIGJ
        5F/gbpRa8k12cXAZLkENUj5Xpg==
X-Google-Smtp-Source: AGHT+IHiAmDaii+Y/8xzXoI7TaEkG5wf52TGtgVTeGML5F/Ke5SXzVjB2CMjKNMPFV2JRbs9BlHA8A==
X-Received: by 2002:ac2:43ac:0:b0:507:a383:fe18 with SMTP id t12-20020ac243ac000000b00507a383fe18mr8305956lfl.40.1698139518122;
        Tue, 24 Oct 2023 02:25:18 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id c12-20020ac25f6c000000b004fbc82dd1a5sm2060246lfc.13.2023.10.24.02.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 02:25:17 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Oct 2023 11:24:57 +0200
Subject: [PATCH net-next v6 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-marvell-88e6152-wan-led-v6-5-993ab0949344@linaro.org>
References: <20231024-marvell-88e6152-wan-led-v6-0-993ab0949344@linaro.org>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v6-0-993ab0949344@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some errors in the Marvell MV88E6xxx switch descriptions:
- The top node had no address size or cells.
- switch0@0 is not OK, should be ethernet-switch@0.
- ports should be ethernet-ports
- port@0 should be ethernet-port@0
- PHYs should be named ethernet-phy@

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../dts/marvell/armada-3720-espressobin-ultra.dts  |  14 +-
 .../boot/dts/marvell/armada-3720-espressobin.dtsi  |  20 +--
 .../boot/dts/marvell/armada-3720-gl-mv1000.dts     |  20 +--
 .../boot/dts/marvell/armada-3720-turris-mox.dts    | 189 +++++++++++----------
 .../boot/dts/marvell/armada-7040-mochabin.dts      |  24 ++-
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |  22 +--
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi        |  42 +++--
 7 files changed, 164 insertions(+), 167 deletions(-)

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
index 5fc613d24151..86ec0df1c676 100644
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
index 9eab2bb22134..cdf1b8bdb230 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -304,7 +304,12 @@ phy1: ethernet-phy@1 {
 		reg = <1>;
 	};
 
-	/* switch nodes are enabled by U-Boot if modules are present */
+	/*
+	 * NOTE: switch nodes are enabled by U-Boot if modules are present
+	 * DO NOT change this node name (switch0@10) even if it is not following
+	 * conventions! Deployed U-Boot binaries are explicitly looking for
+	 * this node in order to augment the device tree!
+	 */
 	switch0@10 {
 		compatible = "marvell,mv88e6190";
 		reg = <0x10>;
@@ -317,92 +322,92 @@ mdio {
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
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@1 {
+			ethernet-port@1 {
 				reg = <0x1>;
 				label = "lan1";
 				phy-handle = <&switch0phy1>;
 			};
 
-			port@2 {
+			ethernet-port@2 {
 				reg = <0x2>;
 				label = "lan2";
 				phy-handle = <&switch0phy2>;
 			};
 
-			port@3 {
+			ethernet-port@3 {
 				reg = <0x3>;
 				label = "lan3";
 				phy-handle = <&switch0phy3>;
 			};
 
-			port@4 {
+			ethernet-port@4 {
 				reg = <0x4>;
 				label = "lan4";
 				phy-handle = <&switch0phy4>;
 			};
 
-			port@5 {
+			ethernet-port@5 {
 				reg = <0x5>;
 				label = "lan5";
 				phy-handle = <&switch0phy5>;
 			};
 
-			port@6 {
+			ethernet-port@6 {
 				reg = <0x6>;
 				label = "lan6";
 				phy-handle = <&switch0phy6>;
 			};
 
-			port@7 {
+			ethernet-port@7 {
 				reg = <0x7>;
 				label = "lan7";
 				phy-handle = <&switch0phy7>;
 			};
 
-			port@8 {
+			ethernet-port@8 {
 				reg = <0x8>;
 				label = "lan8";
 				phy-handle = <&switch0phy8>;
 			};
 
-			port@9 {
+			ethernet-port@9 {
 				reg = <0x9>;
 				label = "cpu";
 				ethernet = <&eth1>;
@@ -410,7 +415,7 @@ port@9 {
 				managed = "in-band-status";
 			};
 
-			switch0port10: port@a {
+			switch0port10: ethernet-port@a {
 				reg = <0xa>;
 				label = "dsa";
 				phy-mode = "2500base-x";
@@ -430,7 +435,7 @@ port-sfp@a {
 		};
 	};
 
-	switch0@2 {
+	ethernet-switch@2 {
 		compatible = "marvell,mv88e6085";
 		reg = <0x2>;
 		dsa,member = <0 0>;
@@ -442,52 +447,52 @@ mdio {
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
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@1 {
+			ethernet-port@1 {
 				reg = <0x1>;
 				label = "lan1";
 				phy-handle = <&switch0phy1_topaz>;
 			};
 
-			port@2 {
+			ethernet-port@2 {
 				reg = <0x2>;
 				label = "lan2";
 				phy-handle = <&switch0phy2_topaz>;
 			};
 
-			port@3 {
+			ethernet-port@3 {
 				reg = <0x3>;
 				label = "lan3";
 				phy-handle = <&switch0phy3_topaz>;
 			};
 
-			port@4 {
+			ethernet-port@4 {
 				reg = <0x4>;
 				label = "lan4";
 				phy-handle = <&switch0phy4_topaz>;
 			};
 
-			port@5 {
+			ethernet-port@5 {
 				reg = <0x5>;
 				label = "cpu";
 				phy-mode = "2500base-x";
@@ -497,7 +502,7 @@ port@5 {
 		};
 	};
 
-	switch1@11 {
+	ethernet-switch@11 {
 		compatible = "marvell,mv88e6190";
 		reg = <0x11>;
 		dsa,member = <0 1>;
@@ -509,92 +514,92 @@ mdio {
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
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@1 {
+			ethernet-port@1 {
 				reg = <0x1>;
 				label = "lan9";
 				phy-handle = <&switch1phy1>;
 			};
 
-			port@2 {
+			ethernet-port@2 {
 				reg = <0x2>;
 				label = "lan10";
 				phy-handle = <&switch1phy2>;
 			};
 
-			port@3 {
+			ethernet-port@3 {
 				reg = <0x3>;
 				label = "lan11";
 				phy-handle = <&switch1phy3>;
 			};
 
-			port@4 {
+			ethernet-port@4 {
 				reg = <0x4>;
 				label = "lan12";
 				phy-handle = <&switch1phy4>;
 			};
 
-			port@5 {
+			ethernet-port@5 {
 				reg = <0x5>;
 				label = "lan13";
 				phy-handle = <&switch1phy5>;
 			};
 
-			port@6 {
+			ethernet-port@6 {
 				reg = <0x6>;
 				label = "lan14";
 				phy-handle = <&switch1phy6>;
 			};
 
-			port@7 {
+			ethernet-port@7 {
 				reg = <0x7>;
 				label = "lan15";
 				phy-handle = <&switch1phy7>;
 			};
 
-			port@8 {
+			ethernet-port@8 {
 				reg = <0x8>;
 				label = "lan16";
 				phy-handle = <&switch1phy8>;
 			};
 
-			switch1port9: port@9 {
+			switch1port9: ethernet-port@9 {
 				reg = <0x9>;
 				label = "dsa";
 				phy-mode = "2500base-x";
@@ -602,7 +607,7 @@ switch1port9: port@9 {
 				link = <&switch0port10>;
 			};
 
-			switch1port10: port@a {
+			switch1port10: ethernet-port@a {
 				reg = <0xa>;
 				label = "dsa";
 				phy-mode = "2500base-x";
@@ -622,7 +627,7 @@ port-sfp@a {
 		};
 	};
 
-	switch1@2 {
+	ethernet-switch@2 {
 		compatible = "marvell,mv88e6085";
 		reg = <0x2>;
 		dsa,member = <0 1>;
@@ -634,52 +639,52 @@ mdio {
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
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@1 {
+			ethernet-port@1 {
 				reg = <0x1>;
 				label = "lan9";
 				phy-handle = <&switch1phy1_topaz>;
 			};
 
-			port@2 {
+			ethernet-port@2 {
 				reg = <0x2>;
 				label = "lan10";
 				phy-handle = <&switch1phy2_topaz>;
 			};
 
-			port@3 {
+			ethernet-port@3 {
 				reg = <0x3>;
 				label = "lan11";
 				phy-handle = <&switch1phy3_topaz>;
 			};
 
-			port@4 {
+			ethernet-port@4 {
 				reg = <0x4>;
 				label = "lan12";
 				phy-handle = <&switch1phy4_topaz>;
 			};
 
-			port@5 {
+			ethernet-port@5 {
 				reg = <0x5>;
 				label = "dsa";
 				phy-mode = "2500base-x";
@@ -689,7 +694,7 @@ port@5 {
 		};
 	};
 
-	switch2@12 {
+	ethernet-switch@12 {
 		compatible = "marvell,mv88e6190";
 		reg = <0x12>;
 		dsa,member = <0 2>;
@@ -701,92 +706,92 @@ mdio {
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
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@1 {
+			ethernet-port@1 {
 				reg = <0x1>;
 				label = "lan17";
 				phy-handle = <&switch2phy1>;
 			};
 
-			port@2 {
+			ethernet-port@2 {
 				reg = <0x2>;
 				label = "lan18";
 				phy-handle = <&switch2phy2>;
 			};
 
-			port@3 {
+			ethernet-port@3 {
 				reg = <0x3>;
 				label = "lan19";
 				phy-handle = <&switch2phy3>;
 			};
 
-			port@4 {
+			ethernet-port@4 {
 				reg = <0x4>;
 				label = "lan20";
 				phy-handle = <&switch2phy4>;
 			};
 
-			port@5 {
+			ethernet-port@5 {
 				reg = <0x5>;
 				label = "lan21";
 				phy-handle = <&switch2phy5>;
 			};
 
-			port@6 {
+			ethernet-port@6 {
 				reg = <0x6>;
 				label = "lan22";
 				phy-handle = <&switch2phy6>;
 			};
 
-			port@7 {
+			ethernet-port@7 {
 				reg = <0x7>;
 				label = "lan23";
 				phy-handle = <&switch2phy7>;
 			};
 
-			port@8 {
+			ethernet-port@8 {
 				reg = <0x8>;
 				label = "lan24";
 				phy-handle = <&switch2phy8>;
 			};
 
-			switch2port9: port@9 {
+			switch2port9: ethernet-port@9 {
 				reg = <0x9>;
 				label = "dsa";
 				phy-mode = "2500base-x";
@@ -805,7 +810,7 @@ port-sfp@a {
 		};
 	};
 
-	switch2@2 {
+	ethernet-switch@2 {
 		compatible = "marvell,mv88e6085";
 		reg = <0x2>;
 		dsa,member = <0 2>;
@@ -817,52 +822,52 @@ mdio {
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
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@1 {
+			ethernet-port@1 {
 				reg = <0x1>;
 				label = "lan17";
 				phy-handle = <&switch2phy1_topaz>;
 			};
 
-			port@2 {
+			ethernet-port@2 {
 				reg = <0x2>;
 				label = "lan18";
 				phy-handle = <&switch2phy2_topaz>;
 			};
 
-			port@3 {
+			ethernet-port@3 {
 				reg = <0x3>;
 				label = "lan19";
 				phy-handle = <&switch2phy3_topaz>;
 			};
 
-			port@4 {
+			ethernet-port@4 {
 				reg = <0x4>;
 				label = "lan20";
 				phy-handle = <&switch2phy4_topaz>;
 			};
 
-			port@5 {
+			ethernet-port@5 {
 				reg = <0x5>;
 				label = "dsa";
 				phy-mode = "2500base-x";
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
index 32cfb3e2efc3..7538ed56053b 100644
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
2.34.1

