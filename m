Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A60E7CA3BA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjJPJNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjJPJNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:13:04 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E0DED
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:13:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50308217223so4921000e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697447580; x=1698052380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRAJxOH+ejiFnd2dNnRhzRVyCxEiMIKKKk9Axu7hk70=;
        b=gD117U+9Y4IcvmAhkic2zi/lEUGk6s1hogaUAZq2oprwEMC8bDMF+kPHAhWeuL19Gb
         QvwNKubIcMIda0fRh9WPC48uIWuKADK0ZY8w96K8n+5Gm4c3jlU8H7Aw5oIFXfQUTNmd
         ksutv8VwqAgk01/xX7e9RuNcHwYV2lEQLf9ucPtO3IB0H0SGvQWt2nmxgaxsXyFo4nRS
         o/jBsIHDs0H/5TetjHqgaOzKpvrw3zy+kmCQzchAzTS9sg4z5x/k+Y9QggDLNajZu7k+
         swHxRcxBRxmryd683a73LIN3gCN/4LHrF+ykd50nQl4S8mf1+ZZxb/GzQeBGya9k3VaE
         3UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697447580; x=1698052380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRAJxOH+ejiFnd2dNnRhzRVyCxEiMIKKKk9Axu7hk70=;
        b=LmKaET9SlX76YSEamM2vJR4OvuKVXWXY6WowNYKQr4pUcMpDneXc0X+GuuElXlgnrL
         UmxMjyzO+lTEx8ssj1Qa5PPx2rxN5Pvw2Iq0L1+AadmXpKx8Kuuz8ZAcGedmZXH1I1R8
         ZD9CNgDf0+PyaxOsUydFPh0bv0SxYMTKejfBuu4jxZQYXOq0wvpTrDdB988eJuCUOzz5
         niEjI6RYkgBv4w/HrJUIxQquWPhjLHQZoDv9Vg5p0M7xy3rn+f86F7wkH0MgwaaEtjER
         9AFGNNXslfDlFpSF3qdAlMNlenb7YhNQB1qppdk6VQAA2vhFLsZ+WNqpSUTefKZ9BH8P
         BcOQ==
X-Gm-Message-State: AOJu0YyQP53C2CxFFdUYNboRpqmO6sIzFTcDpHMomGkInbvY0tnsBOGJ
        v5Gsjlt2W7SO4uVKhF3p8jskjw==
X-Google-Smtp-Source: AGHT+IFfLerwONC0S927A86IHPsTKC6pq6bBeya6cSJJxJSsnxnBAPU+X7G49WCZODxiZI1Stl0blw==
X-Received: by 2002:ac2:44cb:0:b0:4fe:279b:8a02 with SMTP id d11-20020ac244cb000000b004fe279b8a02mr26090531lfm.67.1697447580506;
        Mon, 16 Oct 2023 02:13:00 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id br34-20020a056512402200b005068e7a2e7dsm4160986lfb.77.2023.10.16.02.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:13:00 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Oct 2023 11:12:58 +0200
Subject: [PATCH net-next v3 5/6] ARM: dts: nxp: Fix some common switch
 mistakes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-marvell-88e6152-wan-led-v3-5-38cd449dfb15@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some errors in the Marvell MV88E6xxx switch descriptions:
- switch0@0 is not OK, should be switch@0

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts      | 2 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts  | 8 ++++----
 arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts      | 2 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts  | 4 ++--
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts
index 1a19aec8957b..add47d8fb58a 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts
@@ -162,7 +162,7 @@ mdio1: mdio {
 		suppress-preamble;
 		status = "okay";
 
-		switch0: switch0@0 {
+		switch0: switch@0 {
 			compatible = "marvell,mv88e6085";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_switch>;
diff --git a/arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts
index df1335492a19..50356bd87d04 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts
@@ -47,7 +47,7 @@ mdio_mux_1: mdio@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch0: switch0@0 {
+			switch0: switch@0 {
 				compatible = "marvell,mv88e6190";
 				reg = <0>;
 				dsa,member = <0 0>;
@@ -130,7 +130,7 @@ mdio_mux_2: mdio@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch1: switch1@0 {
+			switch1: switch@0 {
 				compatible = "marvell,mv88e6190";
 				reg = <0>;
 				dsa,member = <0 1>;
@@ -188,7 +188,7 @@ mdio_mux_4: mdio@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch2: switch2@0 {
+			switch2: switch@0 {
 				compatible = "marvell,mv88e6190";
 				reg = <0>;
 				dsa,member = <0 2>;
@@ -276,7 +276,7 @@ mdio_mux_8: mdio@8 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch3: switch3@0 {
+			switch3: switch@0 {
 				compatible = "marvell,mv88e6190";
 				reg = <0>;
 				dsa,member = <0 3>;
diff --git a/arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts
index 1461804ecaea..20e9e2dacbe6 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts
+++ b/arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts
@@ -123,7 +123,7 @@ mdio1: mdio {
 		suppress-preamble;
 		status = "okay";
 
-		switch0: switch0@0 {
+		switch0: switch@0 {
 			compatible = "marvell,mv88e6190";
 			pinctrl-0 = <&pinctrl_gpio_switch0>;
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts
index 463c2452b9b7..aa53a60518c3 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts
+++ b/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts
@@ -112,7 +112,7 @@ mdio1: mdio {
 		suppress-preamble;
 		status = "okay";
 
-		switch0: switch0@0 {
+		switch0: switch@0 {
 			compatible = "marvell,mv88e6190";
 			pinctrl-0 = <&pinctrl_gpio_switch0>;
 			pinctrl-names = "default";
@@ -167,7 +167,7 @@ port@9 {
 				};
 			};
 
-			mdio1 {
+			mdio-external {
 				compatible = "marvell,mv88e6xxx-mdio-external";
 				#address-cells = <1>;
 				#size-cells = <0>;
diff --git a/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts
index f5ae0d5de315..0b7063b74130 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts
@@ -137,7 +137,7 @@ mdio1: mdio {
 		suppress-preamble;
 		status = "okay";
 
-		switch0: switch0@0 {
+		switch0: switch@0 {
 			compatible = "marvell,mv88e6190";
 			pinctrl-0 = <&pinctrl_gpio_switch0>;
 			pinctrl-names = "default";

-- 
2.34.1

