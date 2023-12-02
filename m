Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECC0801F1C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 23:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjLBWgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 17:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjLBWgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 17:36:03 -0500
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B9C11F;
        Sat,  2 Dec 2023 14:36:06 -0800 (PST)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 9F73F1612B2;
        Sat,  2 Dec 2023 23:30:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1701556237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H06nUo8NYq1Srt6kCqyIjmT3qxIhv0OVvzkrHAKz+wE=;
        b=Ihrzn+2V+Iz+hI6yCIEVTqpk6Q3K7UnJXSZ4rYwvVsIPjENhOW1FI/YBj074krzAVsooNN
        XklGxMFylJ7g45GED+wDRwzMZD5fx55O1EaG9ymIn9qhYRSERG25rERltsDRJBWPiKhA0y
        HSr0oG6aXm2/KCjE7KBWnICaCwCrY0g=
From:   David Heidelberg <david@ixit.cz>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Peter Rosin <peda@axentia.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        David Heidelberg <david@ixit.cz>
Cc:     Simon Guinot <simon.guinot@sequanux.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] ARM: dts: marvell: make dts use gpio-fan matrix instead of array
Date:   Sat,  2 Dec 2023 23:29:04 +0100
Message-ID: <20231202222934.137191-5-david@ixit.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231202222934.137191-1-david@ixit.cz>
References: <20231202222934.137191-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes.

Adjust to comply with dt-schema requirements
and make possible to validate values.

Acked-by: Simon Guinot <simon.guinot@sequanux.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/marvell/armada-370-rd.dts   |   2 +-
 .../marvell/armada-370-seagate-nas-2bay.dts   |   8 +-
 .../marvell/armada-370-seagate-nas-4bay.dts   |   8 +-
 .../marvell/armada-370-synology-ds213j.dts    |  16 +--
 .../dts/marvell/armada-385-synology-ds116.dts |  16 +--
 arch/arm/boot/dts/marvell/armada-388-gp.dts   |   4 +-
 arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi |   6 +-
 .../marvell/kirkwood-linkstation-6282.dtsi    |   9 +-
 .../marvell/kirkwood-linkstation-lswxl.dts    |   9 +-
 arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi  |   9 +-
 arch/arm/boot/dts/marvell/kirkwood-ns2max.dts |  18 ++--
 .../arm/boot/dts/marvell/kirkwood-ns2mini.dts |  18 ++--
 .../boot/dts/marvell/kirkwood-synology.dtsi   | 102 +++++++++---------
 .../dts/marvell/mvebu-linkstation-fan.dtsi    |   8 +-
 14 files changed, 121 insertions(+), 112 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-370-rd.dts b/arch/arm/boot/dts/marvell/armada-370-rd.dts
index b459a670f615..4b5789b73dac 100644
--- a/arch/arm/boot/dts/marvell/armada-370-rd.dts
+++ b/arch/arm/boot/dts/marvell/armada-370-rd.dts
@@ -95,7 +95,7 @@ button {
 			gpio-fan {
 				compatible = "gpio-fan";
 				gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
-				gpio-fan,speed-map = <0 0 3000 1>;
+				gpio-fan,speed-map = <0 0>, <3000 1>;
 				pinctrl-0 = <&fan_pins>;
 				pinctrl-names = "default";
 			};
diff --git a/arch/arm/boot/dts/marvell/armada-370-seagate-nas-2bay.dts b/arch/arm/boot/dts/marvell/armada-370-seagate-nas-2bay.dts
index 8dd242e668e6..6ec3dd3337f4 100644
--- a/arch/arm/boot/dts/marvell/armada-370-seagate-nas-2bay.dts
+++ b/arch/arm/boot/dts/marvell/armada-370-seagate-nas-2bay.dts
@@ -25,9 +25,9 @@ / {
 
 	gpio-fan {
 		gpio-fan,speed-map =
-			<   0 3
-			  950 2
-			 1400 1
-			 1800 0>;
+			<   0 3>,
+			< 950 2>,
+			<1400 1>,
+			<1800 0>;
 	};
 };
diff --git a/arch/arm/boot/dts/marvell/armada-370-seagate-nas-4bay.dts b/arch/arm/boot/dts/marvell/armada-370-seagate-nas-4bay.dts
index 370ca9c43247..3011578a3124 100644
--- a/arch/arm/boot/dts/marvell/armada-370-seagate-nas-4bay.dts
+++ b/arch/arm/boot/dts/marvell/armada-370-seagate-nas-4bay.dts
@@ -106,10 +106,10 @@ NS_V2_LED_ON   1 0
 
 	gpio-fan {
 		gpio-fan,speed-map =
-			<   0 3
-			  800 2
-			  1050 1
-			  1300 0>;
+			<   0 3>,
+			< 800 2>,
+			<1050 1>,
+			<1300 0>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/marvell/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/marvell/armada-370-synology-ds213j.dts
index b07d11d1f124..02599a3e9816 100644
--- a/arch/arm/boot/dts/marvell/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/marvell/armada-370-synology-ds213j.dts
@@ -113,14 +113,14 @@ gpio-fan-32-38 {
 			 &gpio2  0 GPIO_ACTIVE_HIGH
 			 &gpio2  1 GPIO_ACTIVE_HIGH>;
 		alarm-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
-		gpio-fan,speed-map = <    0 0
-				       1000 1
-				       1150 2
-				       1350 4
-				       1500 3
-				       1650 5
-				       1750 6
-				       1900 7 >;
+		gpio-fan,speed-map = <   0 0>,
+				     <1000 1>,
+				     <1150 2>,
+				     <1350 4>,
+				     <1500 3>,
+				     <1650 5>,
+				     <1750 6>,
+				     <1900 7>;
 	};
 
 	gpio-leds {
diff --git a/arch/arm/boot/dts/marvell/armada-385-synology-ds116.dts b/arch/arm/boot/dts/marvell/armada-385-synology-ds116.dts
index ea91ff964d94..6caa5c50175a 100644
--- a/arch/arm/boot/dts/marvell/armada-385-synology-ds116.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-synology-ds116.dts
@@ -131,14 +131,14 @@ gpio-fan {
 			gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>,
 				<&gpio1 17 GPIO_ACTIVE_HIGH>,
 				<&gpio1 16 GPIO_ACTIVE_HIGH>;
-			gpio-fan,speed-map = <   0 0
-					      1500 1
-					      2500 2
-					      3000 3
-					      3400 4
-					      3700 5
-					      3900 6
-					      4000 7>;
+			gpio-fan,speed-map = <   0 0>,
+					     <1500 1>,
+					     <2500 2>,
+					     <3000 3>,
+					     <3400 4>,
+					     <3700 5>,
+					     <3900 6>,
+					     <4000 7>;
 			#cooling-cells = <2>;
 		};
 
diff --git a/arch/arm/boot/dts/marvell/armada-388-gp.dts b/arch/arm/boot/dts/marvell/armada-388-gp.dts
index e2ba50520b6b..1de0a172aa5f 100644
--- a/arch/arm/boot/dts/marvell/armada-388-gp.dts
+++ b/arch/arm/boot/dts/marvell/armada-388-gp.dts
@@ -237,8 +237,8 @@ pcie@3,0 {
 		gpio-fan {
 			compatible = "gpio-fan";
 			gpios = <&expander1 3 GPIO_ACTIVE_HIGH>;
-			gpio-fan,speed-map = <	 0 0
-					      3000 1>;
+			gpio-fan,speed-map = <	 0 0>,
+					     <3000 1>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi
index eb917462b219..0738eb679fcd 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi
@@ -38,9 +38,9 @@ gpio_fan {
 		pinctrl-names = "default";
 		gpios = <&gpio1 14 GPIO_ACTIVE_HIGH
 			 &gpio1 13 GPIO_ACTIVE_HIGH>;
-		gpio-fan,speed-map = <0    0
-				      3000 1
-				      6000 2>;
+		gpio-fan,speed-map = <0    0>,
+				     <3000 1>,
+				     <6000 2>;
 	};
 
 	gpio_poweroff {
diff --git a/arch/arm/boot/dts/marvell/kirkwood-linkstation-6282.dtsi b/arch/arm/boot/dts/marvell/kirkwood-linkstation-6282.dtsi
index 377b6e970259..dfac2045a1eb 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-linkstation-6282.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-linkstation-6282.dtsi
@@ -118,10 +118,11 @@ gpio_fan {
 		gpios = <&gpio0 17 GPIO_ACTIVE_LOW
 			 &gpio0 16 GPIO_ACTIVE_LOW>;
 
-		gpio-fan,speed-map = <0 3
-				1500 2
-				3250 1
-				5000 0>;
+		gpio-fan,speed-map =
+				<   0 3>,
+				<1500 2>,
+				<3250 1>,
+				<5000 0>;
 
 		alarm-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
 	};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-linkstation-lswxl.dts b/arch/arm/boot/dts/marvell/kirkwood-linkstation-lswxl.dts
index c6024b569423..0425df8cb91c 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-linkstation-lswxl.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-linkstation-lswxl.dts
@@ -69,10 +69,11 @@ gpio_fan {
 		gpios = <&gpio1 16 GPIO_ACTIVE_LOW
 			 &gpio1 15 GPIO_ACTIVE_LOW>;
 
-		gpio-fan,speed-map = <0 3
-				1500 2
-				3250 1
-				5000 0>;
+		gpio-fan,speed-map =
+				<   0 3>,
+				<1500 2>,
+				<3250 1>,
+				<5000 0>;
 
 		alarm-gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 	};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi
index 88b70ba1c8fe..f80af24b9e90 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi
@@ -172,10 +172,11 @@ gpio_fan {
 		pinctrl-names = "default";
 		gpios = <&gpio0 19 GPIO_ACTIVE_LOW
 		         &gpio0 18 GPIO_ACTIVE_LOW>;
-		gpio-fan,speed-map = <0    3
-		                      1500 2
-		                      3250 1
-		                      5000 0>;
+		gpio-fan,speed-map =
+				<0    3>,
+				<1500 2>,
+				<3250 1>,
+				<5000 0>;
 		alarm-gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 	};
 
diff --git a/arch/arm/boot/dts/marvell/kirkwood-ns2max.dts b/arch/arm/boot/dts/marvell/kirkwood-ns2max.dts
index c0a087e77408..044958bc55da 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-ns2max.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-ns2max.dts
@@ -29,15 +29,15 @@ &gpio0  7 GPIO_ACTIVE_LOW
 			 &gpio1  1 GPIO_ACTIVE_LOW
 			 &gpio0 23 GPIO_ACTIVE_LOW>;
 		gpio-fan,speed-map =
-			<   0  0
-			 1500 15
-			 1700 14
-			 1800 13
-			 2100 12
-			 3100 11
-			 3300 10
-			 4300  9
-			 5500  8>;
+			<   0  0>,
+			<1500 15>,
+			<1700 14>,
+			<1800 13>,
+			<2100 12>,
+			<3100 11>,
+			<3300 10>,
+			<4300  9>,
+			<5500  8>;
 		alarm-gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
 	};
 
diff --git a/arch/arm/boot/dts/marvell/kirkwood-ns2mini.dts b/arch/arm/boot/dts/marvell/kirkwood-ns2mini.dts
index 5b9fa14b6428..3fbe008f9141 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-ns2mini.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-ns2mini.dts
@@ -30,15 +30,15 @@ &gpio0  7 GPIO_ACTIVE_LOW
 			 &gpio1  1 GPIO_ACTIVE_LOW
 			 &gpio0 23 GPIO_ACTIVE_LOW>;
 		gpio-fan,speed-map =
-			<   0  0
-			 3000 15
-			 3180 14
-			 4140 13
-			 4570 12
-			 6760 11
-			 7140 10
-			 7980  9
-			 9200  8>;
+			<   0  0>,
+			<3000 15>,
+			<3180 14>,
+			<4140 13>,
+			<4570 12>,
+			<6760 11>,
+			<7140 10>,
+			<7980  9>,
+			<9200  8>;
 		alarm-gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
 	};
 
diff --git a/arch/arm/boot/dts/marvell/kirkwood-synology.dtsi b/arch/arm/boot/dts/marvell/kirkwood-synology.dtsi
index 9b6666020cdd..20964eb48fd7 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-synology.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-synology.dtsi
@@ -286,14 +286,15 @@ gpio-fan-150-32-35 {
 		gpios = <&gpio1 0 GPIO_ACTIVE_HIGH
 			 &gpio1 1 GPIO_ACTIVE_HIGH
 			 &gpio1 2 GPIO_ACTIVE_HIGH>;
-		gpio-fan,speed-map = <    0 0
-				       2200 1
-				       2500 2
-				       3000 4
-				       3300 3
-				       3700 5
-				       3800 6
-				       4200 7 >;
+		gpio-fan,speed-map =
+				<   0 0>,
+				<2200 1>,
+				<2500 2>,
+				<3000 4>,
+				<3300 3>,
+				<3700 5>,
+				<3800 6>,
+				<4200 7>;
 	};
 
 	gpio-fan-150-15-18 {
@@ -306,14 +307,15 @@ gpio-fan-150-15-18 {
 			 &gpio0 16 GPIO_ACTIVE_HIGH
 			 &gpio0 17 GPIO_ACTIVE_HIGH>;
 		alarm-gpios = <&gpio0 18 GPIO_ACTIVE_HIGH>;
-		gpio-fan,speed-map = <    0 0
-				       2200 1
-				       2500 2
-				       3000 4
-				       3300 3
-				       3700 5
-				       3800 6
-				       4200 7 >;
+		gpio-fan,speed-map =
+				<   0 0>,
+				<2200 1>,
+				<2500 2>,
+				<3000 4>,
+				<3300 3>,
+				<3700 5>,
+				<3800 6>,
+				<4200 7>;
 	};
 
 	gpio-fan-100-32-35 {
@@ -326,14 +328,15 @@ gpio-fan-100-32-35 {
 			 &gpio1 1 GPIO_ACTIVE_HIGH
 			 &gpio1 2 GPIO_ACTIVE_HIGH>;
 		alarm-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
-		gpio-fan,speed-map = <    0 0
-				       2500 1
-				       3100 2
-				       3800 3
-				       4600 4
-				       4800 5
-				       4900 6
-				       5000 7 >;
+		gpio-fan,speed-map =
+				<   0 0>,
+				<2500 1>,
+				<3100 2>,
+				<3800 3>,
+				<4600 4>,
+				<4800 5>,
+				<4900 6>,
+				<5000 7>;
 	};
 
 	gpio-fan-100-15-18 {
@@ -346,14 +349,15 @@ gpio-fan-100-15-18 {
 			 &gpio0 16 GPIO_ACTIVE_HIGH
 			 &gpio0 17 GPIO_ACTIVE_HIGH>;
 		alarm-gpios = <&gpio0 18 GPIO_ACTIVE_HIGH>;
-		gpio-fan,speed-map = <    0 0
-				       2500 1
-				       3100 2
-				       3800 3
-				       4600 4
-				       4800 5
-				       4900 6
-				       5000 7 >;
+		gpio-fan,speed-map =
+				<   0 0>,
+				<2500 1>,
+				<3100 2>,
+				<3800 3>,
+				<4600 4>,
+				<4800 5>,
+				<4900 6>,
+				<5000 7>;
 	};
 
 	gpio-fan-100-15-35-1 {
@@ -366,14 +370,15 @@ gpio-fan-100-15-35-1 {
 			 &gpio0 16 GPIO_ACTIVE_HIGH
 			 &gpio0 17 GPIO_ACTIVE_HIGH>;
 		alarm-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
-		gpio-fan,speed-map = <    0 0
-				       2500 1
-				       3100 2
-				       3800 3
-				       4600 4
-				       4800 5
-				       4900 6
-				       5000 7 >;
+		gpio-fan,speed-map =
+				<   0 0>,
+				<2500 1>,
+				<3100 2>,
+				<3800 3>,
+				<4600 4>,
+				<4800 5>,
+				<4900 6>,
+				<5000 7>;
 	};
 
 	gpio-fan-100-15-35-3 {
@@ -388,14 +393,15 @@ &gpio0 16 GPIO_ACTIVE_HIGH
 		alarm-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH
 			       &gpio1 12 GPIO_ACTIVE_HIGH
 			       &gpio1 13 GPIO_ACTIVE_HIGH>;
-		gpio-fan,speed-map = <    0 0
-				       2500 1
-				       3100 2
-				       3800 3
-				       4600 4
-				       4800 5
-				       4900 6
-				       5000 7 >;
+		gpio-fan,speed-map =
+				<   0 0>,
+				<2500 1>,
+				<3100 2>,
+				<3800 3>,
+				<4600 4>,
+				<4800 5>,
+				<4900 6>,
+				<5000 7>;
 	};
 
 	gpio-leds-alarm-12 {
diff --git a/arch/arm/boot/dts/marvell/mvebu-linkstation-fan.dtsi b/arch/arm/boot/dts/marvell/mvebu-linkstation-fan.dtsi
index e172029a0c4d..a260c42dbda3 100644
--- a/arch/arm/boot/dts/marvell/mvebu-linkstation-fan.dtsi
+++ b/arch/arm/boot/dts/marvell/mvebu-linkstation-fan.dtsi
@@ -50,10 +50,10 @@ gpio_fan {
 		pinctrl-names = "default";
 
 		gpio-fan,speed-map =
-			<0		3
-			1500	2
-			3250	1
-			5000	0>;
+			<   0 3>,
+			<1500 2>,
+			<3250 1>,
+			<5000 0>;
 	};
 };
 
-- 
2.42.0

