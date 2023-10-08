Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C709D7BCED3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 16:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344848AbjJHODA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 10:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344860AbjJHOCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 10:02:55 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A669FDB;
        Sun,  8 Oct 2023 07:02:54 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-352a27ab1aeso14614515ab.3;
        Sun, 08 Oct 2023 07:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696773774; x=1697378574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTC0xEmiJQH7h7RgVwIyYpryKqxuFMiJlFaccvcwhZQ=;
        b=ENV4VPiDBvLRzzsLHM2PZwTTLRSPlG2becQIU9xNVwZyEeAnJW2rnuw6vPfYI8YAW4
         BJwxZuA8CxJqS+5fr4+Mxc0bHvQFtsFMsH9CSSNAv4j/ljSP54MNT5cN7oq6M0qPdcJQ
         Leq6rxtvkibHU0jG6VEPm6OUJjGfdoFcfg7oRnKB1tOtCceR6brtyIS1HtxcDy1A6C8l
         7P3Jh6pqtpBWnhG4mL0lBL7dXB3YWIY6jVcyCew2p6BoN5mP4346yfsp6f/mdMxi5evs
         uucpJccwmKWOXNPJw7OziMHsO0MNEy636qHXGhnKE0GXV24nGLmrb7BFFRFFsy16WtzJ
         E7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696773774; x=1697378574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTC0xEmiJQH7h7RgVwIyYpryKqxuFMiJlFaccvcwhZQ=;
        b=GDhZbeegVUDfjGiYG3gMybN5xnPo3zuYNxDaHYFhL6uGIt5anBoBiGK8OvnKsfxPLy
         BFrZxRjO8zL+HqsusgY5yi/KDFcXdAZ/Ssyk5ipb9PjIILxlw7zgLRIqs/A8itA75nd5
         Kv0Y5PjQcIjaasuTphRISeR/VBsjHdns/PSnL7YT2xvLUEeIXi2TYeOWQw/zuqJwXx/i
         G6JDtFd4qPeSLvf63nnnD2ETXmhYjtFTJSxMJyoG2uWSI+z7c2TpJBv84LmCbQ6nUbXB
         +BU/cfYUNRypx1/HYhBWl1qDaZ7+xI8NfRVRIjcPbA7yzUnI/cS75s31dRKnyKfFSYae
         0ycg==
X-Gm-Message-State: AOJu0YyT5qbJ1LXKeZNpPfjJ+ahFTOiSXQfgtmoCAQCRqBSS607FE/Hx
        yhgWOJVP18vU/n7qsgEWKlQ=
X-Google-Smtp-Source: AGHT+IEzCYpXETF0AL0AJMaTo99wIyDMfeggA89aScfylY2EDiRMqv7flqKYaaYtyItJUrON4lRM4A==
X-Received: by 2002:a05:6e02:2189:b0:34f:35e8:5098 with SMTP id j9-20020a056e02218900b0034f35e85098mr16568780ila.20.1696773773923;
        Sun, 08 Oct 2023 07:02:53 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:a2fe:632a:2360:50d3])
        by smtp.gmail.com with ESMTPSA id 2-20020a921302000000b0035134f1a240sm2272901ilt.86.2023.10.08.07.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 07:02:53 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/4] arm64: dts: imx8mn-beacon: Add DMIC support
Date:   Sun,  8 Oct 2023 09:02:37 -0500
Message-Id: <20231008140239.6601-3-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008140239.6601-1-aford173@gmail.com>
References: <20231008140239.6601-1-aford173@gmail.com>
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

The baseboard has a connector for a pulse density microphone.
This is connected via the micfil interface and uses the DMIC
audio codec with the simple-audio-card.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  Fix missing tripple-hyphen to separate notes from git commit
V2:  Rebase and remove sound-dai-cells since it's been moved to the SoC.
Reviewed-by: Fabio Estevam <festevam@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index 16761975f56e..20018ee2c803 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -4,6 +4,12 @@
  */
 
 / {
+	dmic_codec: dmic-codec {
+		compatible = "dmic-codec";
+		num-channels = <1>;
+		#sound-dai-cells = <0>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -74,6 +80,22 @@ reg_usb_otg_vbus: regulator-usb {
 		enable-active-high;
 	};
 
+	sound-dmic {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "dmic";
+		simple-audio-card,format = "pdm";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+
+		dailink_master: simple-audio-card,cpu {
+			sound-dai = <&micfil>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&dmic_codec>;
+		};
+	};
+
 	sound-wm8962 {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "wm8962";
@@ -221,6 +243,15 @@ mipi_csi_in: endpoint {
 	};
 };
 
+&micfil {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&clk IMX8MN_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <49152000>;
+	status = "okay";
+};
+
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
@@ -311,6 +342,13 @@ MX8MN_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI5_RXC_PDM_CLK	0xd6
+			MX8MN_IOMUXC_SAI5_RXD0_PDM_BIT_STREAM0	0xd6
+		>;
+	};
+
 	pinctrl_reg_usb_otg: reg-otggrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SAI3_RXC_GPIO4_IO29     0x19
-- 
2.40.1

