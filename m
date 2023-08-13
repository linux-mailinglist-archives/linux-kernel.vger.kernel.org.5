Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8502077AA19
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjHMQkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHMQkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:40:09 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BC893;
        Sun, 13 Aug 2023 09:40:11 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79095499a17so164254439f.3;
        Sun, 13 Aug 2023 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691944810; x=1692549610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jkYKfnm23y0JZXyxkiMl6WeMULC/M4WeYqcWbde97zA=;
        b=H/GsSPCbd4ors8L8mZCdUp4F+d2nKBW9GbUMH1M1DUSAyvBY8fzWA9Uf9/P7s7GYu0
         4XbALQdTivKcTStQ92sKecNqszOFyg5VlKi8gBjbL2Q9gRyoqIHvoS8lMm71t6222Q3s
         zVUYab5IkC01C+FlXLbpYDhTUGOXs60VAZdV4IjehFoM5nzN2CKZicSeB+Xo5v9gdKR8
         /Gd0WEC3TKiACGpEWaJPRVCNsQfn+CN54+rLbpipVXaxKgoPFQyOp9O+C4VkP+Ldvhcj
         5+FuaJE5sp8H/iumKHesFLdOQiqHZ4hXTY85k4x02kldao5LWgzhR9E4JbFsYrjs0buv
         tBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691944810; x=1692549610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkYKfnm23y0JZXyxkiMl6WeMULC/M4WeYqcWbde97zA=;
        b=OYE5eMCcEfw/rz/pEMfPl2ySUtbovoVaGQYagA3DhviREfZ2jQdh4IIi+A2rnt/7o7
         uJftuDS7b6TCLJAC+LaHHiUK4N/OBmJiviJ0l4DsJnnXfHybQsrtYGIyk+nfWYSAiUdn
         FXVLL34sM1QhKw4VJIvjdzeSq2LShpYdNPPTRPrwPgkI5GwiSQYqFe6+xGQjoNqwCpVa
         AQUeePCg06Kz1r/iXRIM9K1jpeL/wDOF2ACybrnNIMt1YhpKspQDMjipi8i5Xx34DLOX
         PLFKsGGqEoBCE8VD1qri8m4lawgiMmagddAsR3g43PZys+RUYXMOEqL19VEApWM3Tbor
         gP3A==
X-Gm-Message-State: AOJu0Yxh9AAnz1uwJZGNHBFkk72rJu5OrZdqpSngG3aS7Oz2V2+EL17o
        oWDCjJg6zspFoNEFvtO56E8=
X-Google-Smtp-Source: AGHT+IE2qfswRLj3jlOF1cETGSsfShv4HGhthFo8w78EYX1/sTVx0ndJHRkiAVZ+xw1wHg0pp1Jong==
X-Received: by 2002:a05:6e02:dc1:b0:348:1a1c:3ed9 with SMTP id l1-20020a056e020dc100b003481a1c3ed9mr10065642ilj.11.1691944810330;
        Sun, 13 Aug 2023 09:40:10 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:21ab:bc25:b29c:7b7e])
        by smtp.gmail.com with ESMTPSA id v1-20020a92d241000000b00345d6297aa7sm2631301ilg.16.2023.08.13.09.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 09:40:09 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2] arm64: dts: imx8mp-beacon: Configure 100MHz PCIe Ref Clk
Date:   Sun, 13 Aug 2023 11:40:03 -0500
Message-Id: <20230813164003.23665-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a I2C controlled 100MHz Reference clock used by the PCIe
controller. Configure this clock's DIF1 output to be used by
the PCIe.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Remove the pcie0_refclk clock that the new one replaces.

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index acd265d8b58e..a8ccde678c33 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -23,6 +23,12 @@ chosen {
 		stdout-path = &uart2;
 	};
 
+	clk_xtal25: clk-xtal25 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
 	connector {
 		compatible = "usb-c-connector";
 		label = "USB-C";
@@ -112,12 +118,6 @@ led-3 {
 		};
 	};
 
-	pcie0_refclk: clock-pcie {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
 	reg_audio: regulator-wm8962 {
 		compatible = "regulator-fixed";
 		regulator-name = "3v3_aud";
@@ -246,6 +246,13 @@ pca6416_3: gpio@20 {
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
+
+	pcieclk: clk@68 {
+		compatible = "renesas,9fgv0241";
+		reg = <0x68>;
+		clocks = <&clk_xtal25>;
+		#clock-cells = <1>;
+	};
 };
 
 &i2c3 {
@@ -372,8 +379,9 @@ &pcie {
 };
 
 &pcie_phy {
+	fsl,clkreq-unsupported;
 	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
-	clocks = <&pcie0_refclk>;
+	clocks = <&pcieclk 1>;
 	clock-names = "ref";
 	status = "okay";
 };
-- 
2.39.2

