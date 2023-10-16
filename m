Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E457E7CA3B7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjJPJNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjJPJND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:13:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B34F95
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:13:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50308217223so4920977e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697447579; x=1698052379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhgTFSg7xZQFKqQUdPj7mdXINHwkkUMiMJQ/LwbGzwg=;
        b=hV1+j3oWkJdZ47Ch0mlBiSELXadHIAWPM9iTzg05wH/Lw0noqw2OwkR6zKitV7/yXU
         rk8X5uHrJYgv7HCqZ4zGvgtPiX6+TNCmzxcvy8yzMp22hxNrkrquIdVZqXELoZXUlIJV
         G4V7phcoOE1Ek9ejF+nCGBvpXYJ4FhVAK3d/2KNw6THBUSk0jGbf0lD5OdEdHuSPIfM3
         S/8ZytuKKUInv2AB2wbVbOGpUyC1wrlyTIu8SCdTskJFmf84/gAD4FBi3+xWwQPr2EMq
         n5xQ8DYoGYoxdKZDMLeYMeQyzLJC50jDzMHIZ7uEi9EoCaH8u/0Uf1BDmtyXRqbROdk6
         gEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697447579; x=1698052379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhgTFSg7xZQFKqQUdPj7mdXINHwkkUMiMJQ/LwbGzwg=;
        b=iWfLXjfQ63/JUxnZPmyGLQj2zOm5X2JiNfpUopOf7tvcxL/x3OPwHYu9t6jxNYv046
         wBAskRZM/+z7QGEWSCq4gArhuNGGTADdFDegqYgKHkjnfCgEp5yQl1XufY6sF22hBgFK
         VFxtSn1RMnZyalY23v1CrHokebSWtWQTuIs3IseOpah7HIxnS8PnqqmSP/UqoaC866jc
         BVTJ7k8AaMA7Xz9R/akZs0W2+jBTyAUSBtxQr0P042wJVfUm/UWOxJF/ThqKvbGzQKD7
         qFa7hxT9EQKAy/xNhmwn+fGdpqm/xtq4U7EyaMy0r8ssBPLWR6QoBkUAzJ9FcJz5OyFH
         qkPg==
X-Gm-Message-State: AOJu0YxDukvU13W690c7ZDOfZ5Vr20MOy6wnoIbcTj5aBxpaV2+o272a
        biEhp21pEHC4pd7bD8Fipa3bXw==
X-Google-Smtp-Source: AGHT+IFwxkItfXo61GLxyM7+8mDRV2+ix06U126IFotWglQsdZKz0AerU0/hD4OYRK7FL4MKJarDRA==
X-Received: by 2002:ac2:5623:0:b0:507:a624:3f36 with SMTP id b3-20020ac25623000000b00507a6243f36mr3355753lff.11.1697447579524;
        Mon, 16 Oct 2023 02:12:59 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id br34-20020a056512402200b005068e7a2e7dsm4160986lfb.77.2023.10.16.02.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:12:59 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Oct 2023 11:12:57 +0200
Subject: [PATCH net-next v3 4/6] ARM: dts: marvell: Fix some common switch
 mistakes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-marvell-88e6152-wan-led-v3-4-38cd449dfb15@linaro.org>
References: <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
In-Reply-To: <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
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
        Paolo Abeni <pabeni@redhat.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some errors in the Marvell MV88E6xxx switch descriptions:
- The top node had no address size or cells.
- switch0@0 is not OK, should be switch@0.
- port@a is not normal port naming, use decimal port@10.
- The ports node should have port@0 etc children, no
  plural "ports".

This serves as an example of fixes needed for introducing a
schema for the bindings, but the patch can simply be applied.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/marvell/armada-370-rd.dts              |  2 --
 .../arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts |  6 ++----
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts |  2 +-
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts |  2 +-
 arch/arm/boot/dts/marvell/armada-385-linksys.dtsi        |  2 --
 arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts    | 16 +++++++---------
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts        |  2 --
 arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts    |  2 --
 8 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-370-rd.dts b/arch/arm/boot/dts/marvell/armada-370-rd.dts
index b459a670f615..e3a1834986ee 100644
--- a/arch/arm/boot/dts/marvell/armada-370-rd.dts
+++ b/arch/arm/boot/dts/marvell/armada-370-rd.dts
@@ -151,8 +151,6 @@ led@0 {
 
 	switch: switch@10 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <0x10>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts b/arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts
index f4c4b213ef4e..cf37f53ec070 100644
--- a/arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts
+++ b/arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts
@@ -79,14 +79,12 @@ &mdio {
 
 	switch@0 {
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
@@ -214,12 +212,12 @@ port@9 {
 				reg = <9>;
 			};
 
-			port@a {
+			port@10 {
 				/* 88X3310P external phy */
 				label = "lan10";
 				phy-handle = <&phy2>;
 				phy-mode = "xaui";
-				reg = <0xa>;
+				reg = <10>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
index 1990f7d0cc79..1be0419f8f3e 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
@@ -7,7 +7,7 @@ / {
 };
 
 &mdio {
-	switch0: switch0@4 {
+	switch0: switch@4 {
 		compatible = "marvell,mv88e6190";
 		reg = <4>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts
index b795ad573891..6ec536222bfb 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts
@@ -11,7 +11,7 @@ &sfp0 {
 };
 
 &mdio {
-	switch0: switch0@4 {
+	switch0: switch@4 {
 		compatible = "marvell,mv88e6085";
 		reg = <4>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/marvell/armada-385-linksys.dtsi b/arch/arm/boot/dts/marvell/armada-385-linksys.dtsi
index fc8216fd9f60..63a0bc9455ca 100644
--- a/arch/arm/boot/dts/marvell/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/marvell/armada-385-linksys.dtsi
@@ -160,8 +160,6 @@ &mdio {
 
 	switch@0 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <0>;
 
 		ports {
diff --git a/arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts b/arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts
index 2d8d319bec83..8c69dbd6a2c7 100644
--- a/arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts
@@ -439,8 +439,6 @@ switch@10 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&swint_pins>;
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		dsa,member = <0 0>;
 		reg = <0x10>;
@@ -452,32 +450,32 @@ ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			ports@0 {
+			port@0 {
 				reg = <0>;
 				label = "lan0";
 			};
 
-			ports@1 {
+			port@1 {
 				reg = <1>;
 				label = "lan1";
 			};
 
-			ports@2 {
+			port@2 {
 				reg = <2>;
 				label = "lan2";
 			};
 
-			ports@3 {
+			port@3 {
 				reg = <3>;
 				label = "lan3";
 			};
 
-			ports@4 {
+			port@4 {
 				reg = <4>;
 				label = "lan4";
 			};
 
-			ports@5 {
+			port@5 {
 				reg = <5>;
 				ethernet = <&eth1>;
 				phy-mode = "rgmii-id";
@@ -488,7 +486,7 @@ fixed-link {
 				};
 			};
 
-			ports@6 {
+			port@6 {
 				reg = <6>;
 				ethernet = <&eth0>;
 				phy-mode = "rgmii-id";
diff --git a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
index 32c569df142f..ab46903580aa 100644
--- a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
@@ -94,8 +94,6 @@ &mdio {
 
 	switch@4 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <4>;
 		pinctrl-0 = <&clearfog_dsa0_clk_pins &clearfog_dsa0_pins>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
index 7a0614fd0c93..2a5518c73bff 100644
--- a/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
@@ -267,8 +267,6 @@ &mdio {
 
 	switch@0 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <0>;
 
 		ports {

-- 
2.34.1

