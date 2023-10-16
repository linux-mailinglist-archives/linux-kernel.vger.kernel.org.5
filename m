Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D637CA3BF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjJPJNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjJPJNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:13:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5817FEB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:13:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a772ed97so1790139e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697447581; x=1698052381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1L3K+Ebs1IkB2w2DJrMtsRdnXrx4C52cUF/HzYsLH8=;
        b=hhj2zEX02wOMHppCejkRKiGl0rKxAnn5nTqpCnjFcLYddfqc/VTVsukvQXtkEPd9F/
         9mZhCGjzID/SA0dxkdRbCBB1aDLD3/QBXhv83LE2yp0UbICTDH0M1LVNZBoC/UowMs9Y
         1d1aX57i0349x1YOufs78PPirM9Mzo7DwXTAfz4WNGtMIbiGd9mcsDSzsMlAfe5IApuS
         BWF2765H36/4xuOdVMkMQWVtCAPJJAQVoqiYvAz4gMUs/5JdF8+ZBQd+E0LGHAJ8PAEW
         IgIAI8O5dIIrZv2OouQkqMMz5P1Kb1w7RfMvvuljDDMFN3BXtZj4k5+eKvXROk6TMLj8
         Nc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697447581; x=1698052381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1L3K+Ebs1IkB2w2DJrMtsRdnXrx4C52cUF/HzYsLH8=;
        b=m+EVB1Rouvar1wqu57HaqmUnWYsDOBt9ArW4xt7HzC7TGi89ITLShPZJO/SAnP1pf6
         TCxI/HA2RCEOo8wgY68afBqRcRq3vlfUxsCKyFoI7VRu6x47wvYx/dckawfoqyQczHKM
         Iw7UQ8uy5F7/DaNccIuxA4RwQrdW5ZAtpIoUwkH/WgGlHEYH6LlwFqesFPzaX8UvDKVZ
         1ACKMHfUDP+wECDcwJG/nSG7aUTB3Y6keGtOXqt2IPuowM6A+lMMTQxHPB8t/Twxmmiz
         7SzWkrnMO9dvQrMVD1qRCzQXaeb/IYB+fi1Q7lG6GirhbZ8Fc7OIcviN4cJEDjkcstgJ
         LQag==
X-Gm-Message-State: AOJu0YxV+MwBdY0WGZRTffWQ1iG4FJse5BfvzuvXCezWF7msK0l12SP4
        rAVTcnurw41m0VizMRXaSZZn9A==
X-Google-Smtp-Source: AGHT+IFfn9Snr0I842kSxbpCROov7mU/wJ/1gG4z+6bAP/V9j0dkm180JjDQesFPWG8M5bNfdl48TA==
X-Received: by 2002:ac2:54ad:0:b0:507:adc9:a739 with SMTP id w13-20020ac254ad000000b00507adc9a739mr2409707lfk.37.1697447581524;
        Mon, 16 Oct 2023 02:13:01 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id br34-20020a056512402200b005068e7a2e7dsm4160986lfb.77.2023.10.16.02.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:13:01 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Oct 2023 11:12:59 +0200
Subject: [PATCH net-next v3 6/6] ARM64: dts: marvell: Fix some common
 switch mistakes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-marvell-88e6152-wan-led-v3-6-38cd449dfb15@linaro.org>
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

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../boot/dts/marvell/armada-3720-espressobin.dtsi  |  4 +--
 .../boot/dts/marvell/armada-3720-gl-mv1000.dts     |  4 +--
 .../boot/dts/marvell/armada-3720-turris-mox.dts    | 32 +++++++++++-----------
 .../boot/dts/marvell/armada-7040-mochabin.dts      |  2 --
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |  2 +-
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi        |  6 ++--
 6 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 5fc613d24151..b526efeee293 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -145,10 +145,8 @@ &usb2 {
 };
 
 &mdio {
-	switch0: switch0@1 {
+	switch0: switch@1 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <1>;
 
 		dsa,member = <0 0>;
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
index b1b45b4fa9d4..5de4417f929c 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
@@ -152,10 +152,8 @@ &uart0 {
 };
 
 &mdio {
-	switch0: switch0@1 {
+	switch0: switch@1 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <1>;
 
 		dsa,member = <0 0>;
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 9eab2bb22134..ea66ba5a9762 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -305,7 +305,7 @@ phy1: ethernet-phy@1 {
 	};
 
 	/* switch nodes are enabled by U-Boot if modules are present */
-	switch0@10 {
+	switch@10 {
 		compatible = "marvell,mv88e6190";
 		reg = <0x10>;
 		dsa,member = <0 0>;
@@ -410,8 +410,8 @@ port@9 {
 				managed = "in-band-status";
 			};
 
-			switch0port10: port@a {
-				reg = <0xa>;
+			switch0port10: port@10 {
+				reg = <10>;
 				label = "dsa";
 				phy-mode = "2500base-x";
 				managed = "in-band-status";
@@ -419,8 +419,8 @@ switch0port10: port@a {
 				status = "disabled";
 			};
 
-			port-sfp@a {
-				reg = <0xa>;
+			port-sfp@10 {
+				reg = <10>;
 				label = "sfp";
 				sfp = <&sfp>;
 				phy-mode = "sgmii";
@@ -430,7 +430,7 @@ port-sfp@a {
 		};
 	};
 
-	switch0@2 {
+	switch@2 {
 		compatible = "marvell,mv88e6085";
 		reg = <0x2>;
 		dsa,member = <0 0>;
@@ -497,7 +497,7 @@ port@5 {
 		};
 	};
 
-	switch1@11 {
+	switch@11 {
 		compatible = "marvell,mv88e6190";
 		reg = <0x11>;
 		dsa,member = <0 1>;
@@ -602,8 +602,8 @@ switch1port9: port@9 {
 				link = <&switch0port10>;
 			};
 
-			switch1port10: port@a {
-				reg = <0xa>;
+			switch1port10: port@10 {
+				reg = <10>;
 				label = "dsa";
 				phy-mode = "2500base-x";
 				managed = "in-band-status";
@@ -611,8 +611,8 @@ switch1port10: port@a {
 				status = "disabled";
 			};
 
-			port-sfp@a {
-				reg = <0xa>;
+			port-sfp@10 {
+				reg = <10>;
 				label = "sfp";
 				sfp = <&sfp>;
 				phy-mode = "sgmii";
@@ -622,7 +622,7 @@ port-sfp@a {
 		};
 	};
 
-	switch1@2 {
+	switch@2 {
 		compatible = "marvell,mv88e6085";
 		reg = <0x2>;
 		dsa,member = <0 1>;
@@ -689,7 +689,7 @@ port@5 {
 		};
 	};
 
-	switch2@12 {
+	switch@12 {
 		compatible = "marvell,mv88e6190";
 		reg = <0x12>;
 		dsa,member = <0 2>;
@@ -794,8 +794,8 @@ switch2port9: port@9 {
 				link = <&switch1port10 &switch0port10>;
 			};
 
-			port-sfp@a {
-				reg = <0xa>;
+			port-sfp@10 {
+				reg = <10>;
 				label = "sfp";
 				sfp = <&sfp>;
 				phy-mode = "sgmii";
@@ -805,7 +805,7 @@ port-sfp@a {
 		};
 	};
 
-	switch2@2 {
+	switch@2 {
 		compatible = "marvell,mv88e6085";
 		reg = <0x2>;
 		dsa,member = <0 2>;
diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
index 48202810bf78..3cc794fcf12e 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
@@ -303,8 +303,6 @@ eth2phy: ethernet-phy@1 {
 	/* 88E6141 Topaz switch */
 	switch: switch@3 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <3>;
 
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index 4125202028c8..7a25ea36b565 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -497,7 +497,7 @@ ge_phy: ethernet-phy@0 {
 		reset-deassert-us = <10000>;
 	};
 
-	switch0: switch0@4 {
+	switch0: switch@4 {
 		compatible = "marvell,mv88e6085";
 		reg = <4>;
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
index 32cfb3e2efc3..2f6281b66467 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
@@ -207,11 +207,9 @@ phy0: ethernet-phy@0 {
 		reg = <0>;
 	};
 
-	switch6: switch0@6 {
+	switch6: switch@6 {
 		/* Actual device is MV88E6393X */
 		compatible = "marvell,mv88e6190";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <6>;
 		interrupt-parent = <&cp0_gpio1>;
 		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
@@ -280,7 +278,7 @@ port@9 {
 				managed = "in-band-status";
 			};
 
-			port@a {
+			port@10 {
 				reg = <10>;
 				ethernet = <&cp0_eth0>;
 				phy-mode = "10gbase-r";

-- 
2.34.1

