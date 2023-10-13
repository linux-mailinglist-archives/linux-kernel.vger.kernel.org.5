Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D844D7C7B46
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 03:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjJMBl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 21:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJMBlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 21:41:24 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF66C0;
        Thu, 12 Oct 2023 18:41:22 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-79fe8986355so62689539f.2;
        Thu, 12 Oct 2023 18:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697161282; x=1697766082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZStzgvvobzmH5MTIYJodlyUC67aXTA2OSqCAvankGE=;
        b=OtjityQGBucnHnuFIJ3Qy2XGhp8D7AlA9IDOQMK19gQN5r/RrgJdPxOcFs7aKGb+Ye
         oIx7VMgZlTZ4sCmc8cL2SPkX4Kk2pix8dkiRY72PS15K4gV6IMiZoAjUpGvIrGhPPOvi
         OzCIFjaG1KFccQR5lsUWQm/kIKeAS83AKMKma8gY9mf21xZiyY+KVv4cAJx1bvFyhesF
         wGFX0cNjypBwA1FtuIcDn1DMLy9tUu0mmXZqKTuwPm16oT5Ixt4ncxu+q6J3TR7BKHN/
         YviIA7w84pBtx1YZRXvNvL61eox6n5IZpUdqqpPQ+TiLKIDj60qT3dnmYyKlm/et6Z9x
         LTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697161282; x=1697766082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZStzgvvobzmH5MTIYJodlyUC67aXTA2OSqCAvankGE=;
        b=uG7p7QO/b7z9JaN1XqtoWPdlpfqG6WTzqLohhIFGJ00w2IKH7UceEyEXr82y6lztcG
         QdXfBX9AyNYOZIXrwh6q9qMRuFrNPImRKgrLStYSd26bR+oOkNp9nCM5GVuO9M/588Ek
         I4jfQ8klY6o2UHxfA1ALlTFBmGYAoT6f5Esf/bFXWnuuUnxGvE8gfQPgzZzcICVBZR5R
         TJsutniZfVt4yUAEmCjpXH/1Iv8kSljQoMHPPfF9T4CE9SiIHeliDxeSxmWt4O/7LxhA
         Eut3c4+kAKlbQ26aj03OnCllD62nfqKbQf4nRKTlmTEjo9JoQj0cnXlwGdZ6TRRUNwPq
         KD1g==
X-Gm-Message-State: AOJu0YwFWbTWmXFg65EbXe4D5e+LbglG0c5MHLt24EarlKZb2WtXPaN8
        ftF281crGuZLWenqsPOnK4U=
X-Google-Smtp-Source: AGHT+IGEoCXsBz9wCXz64aA5MQm1zNM7DnhY0QAIfvaYwZjL8u3dp/WMyMgk5S05hZAKbWLRNiWXzw==
X-Received: by 2002:a6b:7841:0:b0:79f:e99b:474a with SMTP id h1-20020a6b7841000000b0079fe99b474amr26209903iop.18.1697161281732;
        Thu, 12 Oct 2023 18:41:21 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:4979:b5dc:3d65:edd2])
        by smtp.gmail.com with ESMTPSA id r18-20020a056638101200b0042319c38763sm4325633jab.15.2023.10.12.18.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 18:41:21 -0700 (PDT)
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
Subject: [PATCH] arm64: dts: imx8mp-beacon-kit: Enable DSI to HDMI Bridge
Date:   Thu, 12 Oct 2023 20:41:17 -0500
Message-Id: <20231013014117.124202-1-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
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

The baseboard of the Beacon i.MX8M Plus development kit has
an ADV7535 DSI to HDMI bridge capable of stereo sound.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index 0bea0798d2db..feae77e03835 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -94,6 +94,17 @@ button-3 {
 		};
 	};
 
+	bridge-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&adv7535_out>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -153,6 +164,21 @@ reg_usb1_host_vbus: regulator-usb1-vbus {
 		enable-active-high;
 	};
 
+	sound-adv7535 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sound-adv7535";
+		simple-audio-card,format = "i2s";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai5>;
+			system-clock-direction-out;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&adv_bridge>;
+		};
+	};
+
 	sound-dmic {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "sound-pdm";
@@ -274,6 +300,35 @@ pca6416_3: gpio@20 {
 		#interrupt-cells = <2>;
 	};
 
+	adv_bridge: hdmi@3d {
+		compatible = "adi,adv7535";
+		reg = <0x3d>, <0x3c>, <0x3e>, <0x3f>;
+		reg-names = "main", "cec", "edid", "packet";
+		adi,dsi-lanes = <4>;
+		#sound-dai-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				adv7535_in: endpoint {
+					remote-endpoint = <&dsi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				adv7535_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+
 	pcieclk: clock-generator@68 {
 		compatible = "renesas,9fgv0241";
 		reg = <0x68>;
@@ -398,6 +453,10 @@ hd3ss3220_out_ep: endpoint {
 	};
 };
 
+&lcdif1 {
+	status = "okay";
+};
+
 &micfil {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pdm>;
@@ -407,6 +466,21 @@ &micfil {
 	status = "okay";
 };
 
+&mipi_dsi {
+	samsung,esc-clock-frequency = <10000000>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+
+			dsi_out: endpoint {
+				remote-endpoint = <&adv7535_in>;
+			};
+		};
+	};
+};
+
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
@@ -433,6 +507,16 @@ &sai3 {
 	status = "okay";
 };
 
+&sai5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai5>;
+	assigned-clocks = <&clk IMX8MP_CLK_SAI5>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -612,6 +696,14 @@ MX8MP_IOMUXC_SAI3_MCLK__AUDIOMIX_SAI3_MCLK	0xd6
 		>;
 	};
 
+	pinctrl_sai5: sai5grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD3__AUDIOMIX_SAI5_TX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI5_RXD2__AUDIOMIX_SAI5_TX_BCLK	0xd6
+			MX8MP_IOMUXC_SAI5_RXD1__AUDIOMIX_SAI5_TX_SYNC	0xd6
+		>;
+	};
+
 	pinctrl_tpm: tpmgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00	0x19 /* Reset */
-- 
2.40.1

