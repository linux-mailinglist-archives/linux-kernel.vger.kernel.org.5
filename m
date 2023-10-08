Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D437BCED1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 16:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344807AbjJHOC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 10:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344857AbjJHOCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 10:02:54 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C71CF;
        Sun,  8 Oct 2023 07:02:53 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3526c9c401aso13220585ab.1;
        Sun, 08 Oct 2023 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696773772; x=1697378572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuvXt9sFvOyA/pPS+UN9EsIG1PlSSdh931kGA4/DRos=;
        b=Fw56lyJ4tLD5dvnyatxlJrY87V5QogjRSXlG1efSd3g+zIzvAT9AoSEgDlExIr1V6x
         X1UXYucxU/pgrwBZ/LxMGaxb235fNyVk6q5eTRu9k4Y2eyUyPrXV4ZVV6Vg2XZ4AET0J
         vd9pGlmvaVY0+LlUrw3cwKfD2lFSjgxatSy9p0Xdm5gf9KfbKg11K5dxrDXhxuSOEWKD
         gZ4eEVDKLzHK5z2JlkHQWd5uaV2s110Xt1b27tiZydVqF+gfLSdGv7MvFMwPjNWaxhi9
         tITfBt1PZCQvpNEM+Ri8bxkbrudm4OghNX9JoKZMOdlP0fpRRDF7aJa1SU0eGbmcfI8g
         m2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696773772; x=1697378572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuvXt9sFvOyA/pPS+UN9EsIG1PlSSdh931kGA4/DRos=;
        b=MD+LeXTAicEEv8PtQ9UMlmkUoz4C9gmfxC2xIzeGCNXXB0Twqt/QpTcJzlbDKVwteF
         viSCpVtM7WRX+tcVDxpkHTDS/ZLhWmZg+wu9IkIBb9RreAKOBie3VnUwxMfOkEY9qP6X
         SoPxDrV+h0zJNGubk/t07/xFytzpWx0+YT+BGkjCm4ZnN1LtrevCH6nf6tlk2rc6Dk8D
         kjD9x0TS6QhWtpUVSLdmfEmeyEbYKcJidQvqjHReQ4ZAS5oPbhY09gYLQVa8gFxNVmhj
         LzkSIOZvbjFwNbuZ4CZeq2phNADLPLe+El4EqjyeIdIHCD+V1TGKkY/jetC2buj8co9v
         qQtw==
X-Gm-Message-State: AOJu0YzYIz0zVe1B1hdh20WFXIDZM3VaiJFJeSEyoSARmQ6LIDyc1H/G
        n26QcVhUGd6m6dehmVwyncQ=
X-Google-Smtp-Source: AGHT+IHz3JglSvRK/HJS7Ms2Uc88OKdv4C6JDCb8MC7Zk4TJZP7o74Arw2OUfnGXngrwh/MdemNIOQ==
X-Received: by 2002:a05:6e02:2192:b0:352:6251:2366 with SMTP id j18-20020a056e02219200b0035262512366mr8108291ila.5.1696773772428;
        Sun, 08 Oct 2023 07:02:52 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:a2fe:632a:2360:50d3])
        by smtp.gmail.com with ESMTPSA id 2-20020a921302000000b0035134f1a240sm2272901ilt.86.2023.10.08.07.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 07:02:51 -0700 (PDT)
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
Subject: [PATCH V3 2/4] arm64: dts: imx8mm-beacon: Add DMIC support
Date:   Sun,  8 Oct 2023 09:02:36 -0500
Message-Id: <20231008140239.6601-2-aford173@gmail.com>
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
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
V3:  No Change
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

