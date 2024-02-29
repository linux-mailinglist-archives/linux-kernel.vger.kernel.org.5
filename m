Return-Path: <linux-kernel+bounces-87701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C2586D7EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A21B28611E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B73B13E7D3;
	Thu, 29 Feb 2024 23:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evIrjnqh"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0E13C9EE;
	Thu, 29 Feb 2024 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249772; cv=none; b=pKsu1/HgGe0K7QkBxsZJIsY5HxCgQwAgl4OnzGQyq7JxVik6ooOqysztvIrnVjUjqEa47w2Yqe/x9tdukvyVy4/qzNni+gXDZBiDQcgLpeAPG8xwt8JzJ2DIb47XwgNCP/lQtmQj4342+e2uXFYGahwQmDRRCuV9crk4gzRZn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249772; c=relaxed/simple;
	bh=sbdwlifiN6TQX37CANALuKwRq4qcVl/xA8MlOkG3rE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sM6AnScd/SHgyS8OxxOdPi5SAsS4NAw+HUafEvZdWwNif40EP+IoN9hcRZ/+B942yC9u4wRaB25It87JU7EdO8lVAzWGmLsNKAIUTKlxBW5nVQ58hSAPCUHCEFmw/+4DdQb4pz/fS/EnfPKUFpaf5Rjt9S2lqOUJHF4yOUVSgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evIrjnqh; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-364f791a428so8014305ab.3;
        Thu, 29 Feb 2024 15:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709249770; x=1709854570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0Ig8cWW0xOB22oHG7WVbhrtiV1AkK22ZMx8ROiAXXA=;
        b=evIrjnqh7r4RukSevTn9WIS6kCWBvqP9kmDuIq8AclAKzxnCFXk83+zbPt8KHPEYCz
         S2kAdaKf2EV+zCgGxCoc8K+0ziA2DLRk7hFiy3s2B1sdCHZnNvAXg0km4MsOYZBJcx3D
         wqIQqfZvomlBls1w+Q9BsdnalnWLlSJruiVLtdDHDHMA+3eANhTemvFoiSUFlsMzkwHO
         VCvRByjzrzhUXPBn0+pLqvzRre7bV2OFJj+qIuDo+xO5NuYWLKHYU4F3cZyVCLAM15ZG
         3cWVpAaO2CoE7tYrbaTDs9ixUUDCe8P5hPVSA3sGklw0mgdHAycY40ltgD1ZHOW/teLr
         PR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249770; x=1709854570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0Ig8cWW0xOB22oHG7WVbhrtiV1AkK22ZMx8ROiAXXA=;
        b=F+KlTLPieO2BOZR5dGTgRhOYdX2wqF6eHtQMoY2fF6yTCmmZC08Aj3peBfpDbrAVfp
         OJQbG9UN1eMGT+2tdJ4pk6oal85f0xb9GrUX5h4aFrwX9EefWX7fOwxUQdttCPwk/pM8
         oGSL18LlMhhSC01CWuFtCNKZLi179NldFWg9a17CEYKQw67ZTWkJwpPL4TZc26hDPKOi
         7pjEOAP7lCM8nSpEi6/BEzo9Cagn6yPrn0y9PeWf7afw0PjjavBNsloxVbduQ0n4yMcb
         WmFcz8n+3cxWruey2+LGJeKkVUKdXgnEVXoDivHQv6Uj/cQkbXqujl+zoguAE0Zs88es
         2Y5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjPFIJXtCPyb465DZ6nbBzHu3xnd4HK2u+hohcZld4p+dGNcpfrtL2l0IJNE/4JhMuqzlo7d3pcVDQPRdcFCRtkWd6pXbQvDgGqye0Zt02gNrZiIK3p5a22SZ318XbO8qtbw5dnOCnFg==
X-Gm-Message-State: AOJu0YzpNG/1zPO5Y49wf0HLXBJzx3CXyklzsu+JvvbE+Rsyck5CqHry
	fuR5JSa0vm8WSySTGjody8FMOXLLYIyEOUpU9BrELk7O+EGUxX2B
X-Google-Smtp-Source: AGHT+IGhaVKIJe0LnTK6LmXIG0SAEJYhhBGCSiIuC00weRqkOsIJvHsV9vMBU6VkGt/rYec7uNAayg==
X-Received: by 2002:a05:6e02:1747:b0:365:3a69:1e1a with SMTP id y7-20020a056e02174700b003653a691e1amr236417ill.0.1709249769634;
        Thu, 29 Feb 2024 15:36:09 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:c0ab:242c:2712:ad44])
        by smtp.gmail.com with ESMTPSA id j5-20020a056e020ee500b0036576880ffcsm584260ilk.85.2024.02.29.15.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:36:09 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: imx8mp-beacon: Enable LVDS-1
Date: Thu, 29 Feb 2024 17:35:55 -0600
Message-ID: <20240229233556.116944-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229233556.116944-1-aford173@gmail.com>
References: <20240229233556.116944-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Beacon has an LVDS display that can connect to one of the
LVDS ports on the baseboard.  The display requires a 30MHz
clock to display properly, and the LDB needs to run at 7x that.
With the audio CODEC now moved to the AUDIO_PLL1, the AUDIO_PLL2
is now available to source the LDB at 210MHz and the DISP_PIX2.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index 1f827ef38e36..731ee2667060 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -19,6 +19,26 @@ aliases {
 		ethernet1 = &fec;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 100000 0>;
+		power-supply = <&reg_lcd1_reset>;
+		status = "okay";
+
+		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
+				     10 11 12 13 14 15 16 17 18 19
+				     20 21 22 23 24 25 26 27 28 29
+				     30 31 32 33 34 35 36 37 38 39
+				     40 41 42 43 44 45 46 47 48 49
+				     50 51 52 53 54 55 56 57 58 59
+				     60 61 62 63 64 65 66 67 68 69
+				     70 71 72 73 74 75 76 77 78 79
+				     80 81 82 83 84 85 86 87 88 89
+				     90 91 92 93 94 95 96 97 98 99
+				    100>;
+		default-brightness-level = <80>;
+	};
+
 	chosen {
 		stdout-path = &uart2;
 	};
@@ -135,6 +155,38 @@ led-3 {
 		};
 	};
 
+	lvds-1 {
+		compatible = "panel-lvds";
+		power-supply = <&reg_lcd1>;
+		width-mm = <223>;
+		height-mm = <125>;
+		backlight = <&backlight>;
+		data-mapping = "vesa-24";
+
+		panel-timing {
+			/* 800x480@60Hz */
+			clock-frequency = <30000000>;
+			hactive = <800>;
+			vactive = <480>;
+			hsync-len = <48>;
+			hfront-porch = <40>;
+			hback-porch = <40>;
+			vfront-porch = <13>;
+			vback-porch = <29>;
+			vsync-len = <1>;
+			hsync-active = <1>;
+			vsync-active = <3>;
+			de-active = <1>;
+			pixelclk-active = <0>;
+		};
+
+		port {
+			panel1_in: endpoint {
+				remote-endpoint = <&ldb_lvds_ch1>;
+			};
+		};
+	};
+
 	reg_audio: regulator-wm8962 {
 		compatible = "regulator-fixed";
 		regulator-name = "3v3_aud";
@@ -144,6 +196,25 @@ reg_audio: regulator-wm8962 {
 		enable-active-high;
 	};
 
+	reg_lcd1_reset: regulator-lcd1-reset {
+		compatible = "regulator-fixed";
+		regulator-name = "LVDS-1 reset";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416_3 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_lcd1>;
+	};
+
+	reg_lcd1: regulator-lcd1 {
+		compatible = "regulator-fixed";
+		regulator-name = "lvds-1 power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416_3 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		regulator-name = "VSD_3V3";
@@ -457,6 +528,38 @@ &lcdif1 {
 	status = "okay";
 };
 
+&lcdif2 {
+	status = "okay";
+};
+
+&lvds_bridge {
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>, <&clk IMX8MP_AUDIO_PLL2_OUT>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL2_OUT>;
+	assigned-clock-rates = <210000000>, <210000000>;
+	status = "okay";
+
+	ports {
+		port@2 {
+			ldb_lvds_ch1: endpoint {
+				remote-endpoint = <&panel1_in>;
+			};
+		};
+	};
+};
+
+&media_blk_ctrl {
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_AXI>,
+			  <&clk IMX8MP_CLK_MEDIA_APB>,
+			  <&clk IMX8MP_CLK_MEDIA_DISP1_PIX>,
+			  <&clk IMX8MP_CLK_MEDIA_DISP2_PIX>,
+			  <&clk IMX8MP_VIDEO_PLL1>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>,
+				 <&clk IMX8MP_SYS_PLL1_800M>,
+				 <&clk IMX8MP_VIDEO_PLL1_OUT>,
+				 <&clk IMX8MP_AUDIO_PLL2_OUT>;
+	assigned-clock-rates = <500000000>, <200000000>, <0>, <0>, <1039500000>;
+};
+
 &micfil {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pdm>;
@@ -496,6 +599,12 @@ &pcie_phy {
 	status = "okay";
 };
 
+&pwm2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+};
+
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
@@ -596,6 +705,13 @@ &usdhc2 {
 };
 
 &iomuxc {
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO09__PWM2_OUT	0x116
+		>;
+	};
+
 	pinctrl_ecspi2: ecspi2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK	0x82
-- 
2.43.0


