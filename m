Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986E7799140
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240678AbjIHUt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjIHUtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:49:55 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C88A9C;
        Fri,  8 Sep 2023 13:49:51 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34ca860051fso8611745ab.2;
        Fri, 08 Sep 2023 13:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694206190; x=1694810990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwUmP0oAaa2Uc/U4TiMNgqrynwkK7R5pG2+a4FTbZ9M=;
        b=pVWhb5objXx9tWWMHxNYKOwGFm5PH7Ge04a0y74zG/fbo2qJdbwhQUx1lirMk6P6SJ
         9SW2xCd6JP1ptpMWvopkNBRRMHzAvzFtF3wf9dvmZeT9JBMU2Ay2xBUw9//l+uLBI/vn
         sUPxSjB2MADHmsDe8vGKPUfhcVpViHrMaOndCbchmCoQjWSqHnzWewe7pPm86fhu6x0A
         YFbWsxPYFRifWjfBQ144ICjPR66cyPltT5GUMdNLsP0Kk0uIEx9AtVAXDyHKdoyCVFui
         Vt7kPBBSaEzOc6u60lcjXZgW4ZfysIKvGEDcHn2CHbLFJlQOjY8HvFzQlw3TGV3ltxEs
         0dTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694206190; x=1694810990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwUmP0oAaa2Uc/U4TiMNgqrynwkK7R5pG2+a4FTbZ9M=;
        b=IhZWPlJT6PUZBewbKegSVAwVWh6mmpYKWNWRjYEH2OPjVw9YGZ+nMRnjhAks8Nw4tT
         ujvusd69GNuZEOyymmQNr2e924GC0AKGTosDlbGkLCP8lwy2EgHiN/l+R5eYn9O+MaSD
         nQa3R3HceRYg12Igk3ph8VmjvyNVPg72+2/mSBuGJvFGXqqRU89q7KMUknwIqKFHGtd8
         CRFCxujMkGrgKnkh//bI+UbnOt8+fyI8syeWzWxIvEpwBJx+lmGIcx4Hm1tRaT4Xzvqm
         74MPTMo3v23K98+Iz+se1lEdrDgZWGcu+8i4iGELD3KCUu+o8F/Y+xK6CXIgXFi3SXsD
         DPDA==
X-Gm-Message-State: AOJu0YyPFNQpsXbuahn5b/p4tYrQhEszVjD8f82Uq7SOi9ouIym1GlNk
        p+Hz4gBh4PEmBy3ivsbKL7QnFCmRdV4=
X-Google-Smtp-Source: AGHT+IEeZjejwIdvy7mNdYAxCvPPYMCsNJMhXLQrkJBmTXX4eWuUmmmqKm1WBgHKmv1DUt0hQLbyRA==
X-Received: by 2002:a92:cd52:0:b0:34d:f0b9:97f7 with SMTP id v18-20020a92cd52000000b0034df0b997f7mr3636224ilq.25.1694206190399;
        Fri, 08 Sep 2023 13:49:50 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:1e20:b059:adc7:9ca8])
        by smtp.gmail.com with ESMTPSA id h6-20020a92c086000000b0034ca3b29c5asm711393ile.57.2023.09.08.13.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:49:50 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Derald D. Woods" <woods.technical@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] arm: dts: am3517-evm: Enable Ethernet PHY Interrupt
Date:   Fri,  8 Sep 2023 15:48:28 -0500
Message-Id: <20230908204828.5242-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230908204828.5242-1-aford173@gmail.com>
References: <20230908204828.5242-1-aford173@gmail.com>
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

The Ethernet PHY interrupt pin is routed to GPIO_58.  Create a
PHY node to configure this GPIO for the interrupt to avoid polling.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Use current device tree naming convention for led-pins

diff --git a/arch/arm/boot/dts/ti/omap/am3517-evm.dts b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
index 866f68c5b504..8a3d850a4f0d 100644
--- a/arch/arm/boot/dts/ti/omap/am3517-evm.dts
+++ b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
@@ -172,11 +172,24 @@ hsusb1_phy: hsusb1_phy {
 &davinci_emac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ethernet_pins>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
 	status = "okay";
 };
 
 &davinci_mdio {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
+
+	ethphy0: ethernet-phy@0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&enet_phy_pins>;
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;	/* gpio_58 */
+	};
 };
 
 &dss {
@@ -257,6 +270,12 @@ OMAP3_CORE1_IOPAD(0x2210, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_50mhz_clk */
 		>;
 	};
 
+	enet_phy_pins: pinmux_ent_phy_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20bc, PIN_INPUT | MUX_MODE4)	/* gpmc_ncs7.gpio_57 */
+		>;
+	};
+
 	i2c2_pins: i2c2-pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x21be, PIN_INPUT_PULLUP | MUX_MODE0)  /* i2c2_scl */
-- 
2.39.2

