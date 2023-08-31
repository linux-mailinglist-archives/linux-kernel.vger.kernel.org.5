Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4114478EC78
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346114AbjHaLvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjHaLvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:51:48 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6316EE40;
        Thu, 31 Aug 2023 04:51:45 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34baf19955cso2532165ab.2;
        Thu, 31 Aug 2023 04:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693482705; x=1694087505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfUzkZpC6rdjKYz9PfqxdgDOVImLXmjN2Ob+UFv9fCI=;
        b=lnP80rYC4furarMha7mKtWVjOOicTgzYZfWWx0q4u5CpmLbY6ZrwbTe5FVyBy3xkmQ
         kF9AM0HreJEvfqXKft2xAIZA1aF7BE9eiLwaQPcZCiC0YnWEBRbXPH9jAsCjrptfWfEN
         Qwr7a9U8FMxZf874qv1y09jv9xqk6jxX6/3vhdqYgLNJ6fZzv/oq3vWCcbhjJeD6owKh
         sk4PLuzTunJH2MaZH9JDFbij4a/azmZ40g5Z4ArPrmuppiR5aBJFjFfLgrLUhw3Famnu
         nvuGWAJXag0etVrezNJoMnq586hUeQF6Z5otLIU+nyYz8NuXtE22WX3vShL06GkAGwyU
         B0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693482705; x=1694087505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfUzkZpC6rdjKYz9PfqxdgDOVImLXmjN2Ob+UFv9fCI=;
        b=eQ2qQ4C0pyehrFBnHVH+jtk++g15SlCrgL//lWAqIXxFdbX4hO/ojWnxMzj0ZRCmvX
         1XSBNF405ISOHnxHfD/IQurzfC82NCUkUA2vsd6cnBokcmGlWjZg801Rx7ACsyBU6c12
         tNHimxmGRPhxrZ0745Pi/EgtwwsAwQKgNdVGKG3ChVGQSARBEJyFboQ5yULRpkZlS8K3
         3h/S7yRqIjRyKhDA7Q5KWWLrF18hiyEbIHnF2KzIvozy0MAhNC2xwRrAIqbxs4v9jqCg
         IBI89iKn6gxdfc+S58ERicaGBw3IF6WfR089tA9Pa+uE+l5rGr3e+dPxjVL+ibwxA0wu
         YYFQ==
X-Gm-Message-State: AOJu0YxdV6Mjxt3TYgtcyRTZ23b+vIyhn5zL51TEdtJ5IdIs5UOcYatH
        JlcodIJ1D6FO8lARwhAgR60=
X-Google-Smtp-Source: AGHT+IFeFDeXFOoBQ84rxQO9XbuweuUTlmCmC4f45FCzPK0ABR8WvTiRSiDkUN3Q3WXEdPhG9P8MRA==
X-Received: by 2002:a92:4b08:0:b0:34c:a9dd:5fe3 with SMTP id m8-20020a924b08000000b0034ca9dd5fe3mr5415080ilg.23.1693482704623;
        Thu, 31 Aug 2023 04:51:44 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:2a0f:e1d5:3688:f2b8])
        by smtp.gmail.com with ESMTPSA id o28-20020a02cc3c000000b0042b1d495aecsm353529jap.123.2023.08.31.04.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 04:51:44 -0700 (PDT)
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: imx8mm-beacon: Add DMIC support
Date:   Thu, 31 Aug 2023 06:51:26 -0500
Message-Id: <20230831115128.254226-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230831115128.254226-1-aford173@gmail.com>
References: <20230831115128.254226-1-aford173@gmail.com>
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

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index 313e93663d6f..d0dd4c81a557 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -6,6 +6,13 @@
 #include <dt-bindings/phy/phy-imx8-pcie.h>
 
 / {
+
+	dmic_codec: dmic-codec {
+		compatible = "dmic-codec";
+		num-channels = <1>;
+		#sound-dai-cells = <0>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -98,6 +105,22 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
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
@@ -228,6 +251,16 @@ pca6416_1: gpio@21 {
 	};
 };
 
+&micfil {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&clk IMX8MM_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <49152000>;
+	status = "okay";
+	#sound-dai-cells = <0>;
+};
+
 &mipi_csi {
 	status = "okay";
 	ports {
@@ -365,6 +398,13 @@ MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXC_PDM_CLK	0xd6
+			MX8MM_IOMUXC_SAI5_RXD0_PDM_DATA0	0xd6
+		>;
+	};
+
 	pinctrl_reg_usb_otg1: usbotg1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29     0x19
-- 
2.39.2

