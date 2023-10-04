Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E267B98DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbjJDXrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238556AbjJDXrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:47:43 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1091C0;
        Wed,  4 Oct 2023 16:47:39 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79f8e4108c3so20503739f.3;
        Wed, 04 Oct 2023 16:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696463259; x=1697068059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLe99n6dqY5T1J7qsApaL18A2DozvmXs+CapV1oqmyQ=;
        b=aFZg0N5oPa5tIOUlxMC/E1US0y+WhAyF7EKiEjMuDP99+N26Iz3q7/RJwLyP+tWyRX
         hpoYVfNx08X6pHbP9krfK0js6rg6ZhN3Czcgpl1XcEIYtlt6UKlWHScG94BhRTakpfBR
         C8i+vaKcy7QdxkYF+UkLTzJFRq+tSfwXitYP9o1GiOg25ZGXCbGmRcZbhh1Ak3FX60cR
         1reeY8sexPZc/Zo0Sb9JPzhPHf52RK8/nAXReXEWVhnZhCQErnWUFJll3YjTJy6MIial
         pN4g+JrVRk0iNp6SBotxHuZyymVUOYCV3ScMtA9gVel7H58reWAeleiZDryCae0ze4vM
         L8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696463259; x=1697068059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLe99n6dqY5T1J7qsApaL18A2DozvmXs+CapV1oqmyQ=;
        b=QdFHN3YLME3Nx07YrJTqtVcehqa61gr1/UOSLZQpqUln4znH2kekpmqQwE2QpAKA8F
         DdN9OZdoGzgBMdZb19wJHPOxmWokcfz3mGYd+jmSa8+ErkctIZjm1B3cZjpkCavzngeO
         VCxgQmuKnR7+E2XBkbOF9UKboyyNVOtr8wI1jzY+jw/S1Qpff8cJdVCnRZf6zgwFOS7B
         R1ChgaN3eK519B1oecjmizCO+Y/BeV6CQELaw5D536AkCYixOS3OyT0fM95AEZ+QVb0L
         8vKOe7cj6QW1j63T3yUR+0UgA++VU5EEGLcH/WNQSJibpiiPAol7l57ynDPJeusACuTr
         aybg==
X-Gm-Message-State: AOJu0YzXNRVcx8u6nvWZ7nN9JcgNFYT0ebBnyklN8YAwpoNjMq/iQKVy
        aA6JlTz9tEA0e+ENb5r51m0=
X-Google-Smtp-Source: AGHT+IEUy4/pMrC8hA7uPIVGCZ1bc0yXTurG3NimHBvr9JL9n6bNMQAzDYA6zxrm3JmeWCjR8QjfJw==
X-Received: by 2002:a6b:a05:0:b0:792:70f2:a8ed with SMTP id z5-20020a6b0a05000000b0079270f2a8edmr4141499ioi.4.1696463259102;
        Wed, 04 Oct 2023 16:47:39 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id l13-20020a5e880d000000b0079fa3d0d790sm50062ioj.31.2023.10.04.16.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 16:47:38 -0700 (PDT)
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
Subject: [PATCH V2 2/4] arm64: dts: imx8mm-beacon: Add DMIC support
Date:   Wed,  4 Oct 2023 18:46:55 -0500
Message-Id: <20231004234657.44592-2-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004234657.44592-1-aford173@gmail.com>
References: <20231004234657.44592-1-aford173@gmail.com>
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
V2:  Rebase and remove sound-dai-cells since it's been moved to the SoC.

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index 313e93663d6f..6086dae2e5fb 100644
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
@@ -228,6 +251,15 @@ pca6416_1: gpio@21 {
 	};
 };
 
+&micfil {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&clk IMX8MM_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <49152000>;
+	status = "okay";
+};
+
 &mipi_csi {
 	status = "okay";
 	ports {
@@ -365,6 +397,13 @@ MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
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
2.40.1

