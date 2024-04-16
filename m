Return-Path: <linux-kernel+bounces-147183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6328A70A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B752847B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D617B13BC2E;
	Tue, 16 Apr 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o60sRPAD"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0513BAE6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282831; cv=none; b=gfzhDfLMsFSlYqBVO0h5dwQW6bIY8Ua67lAOut4uVJ/sR4mrd6Ez5+F1oD2ixYg6U5jjMIAqqx9jGmrNFVUtvaY680RkPhBg5KZVF/DvUhiQFBEy2S1pE/Or4WYBJFKIYcjGMo1JiPCQs4cJTcCJhns7MR6tTXbo1ytUsj+AOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282831; c=relaxed/simple;
	bh=M4i1c6AYDA2tEdZrTCUtzyXixpIxmwigGiG2fPItjfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQsBBNjJodvlZUS2jVDPYVlBt5D/wrRazdLhgan+cx2Hq/6w4dF6h62yl5drTq7qchozP26KAydhG4vMUWGbL64iaRjJRH+ey+s5FdkVJpnGZubo3l/+9ZwSb8o/q8h3yDL3I++0tDYyNTrFQeQPpyyNi6Uypdyxi2orS4O1lRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o60sRPAD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5200202c1bso603229366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713282828; x=1713887628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kk43UIDm9M9R8V3T1CIiMiMRKcLoO2R/eVKjmVeC/UE=;
        b=o60sRPADiDQNwfVEzWFCKUehB4Z4zCK25cvSv3edf9d7Uf0L7ekATOpZVo0jHC0dUq
         EB5jWgXc+AhyeGQxX/sTwWAOJ0u4tUaburQ1YQX6bH8oNB8JiRRoHCYIGa3vbVtuE7X/
         9zohXVIo96xcyStmsDDZ5+uJPorQuuZSpVTHas7iwDsiBW6H0gtzlWMn49OcLLce4J2e
         xXtdpgjleLDCCP8Rd7WCdxZrDEBkAqAiePRe+DbQroJ2WbWhkWXh/sKSQ57sBVmnsQ6Q
         cvk1ZSAfWp1dgXFRM2rvvaLItJo2GjLqtPazyylDeacCxWDd1KSBbOgCHo3cZAW6K/JQ
         2+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282828; x=1713887628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kk43UIDm9M9R8V3T1CIiMiMRKcLoO2R/eVKjmVeC/UE=;
        b=BmJAGIRhvwuCjzbAVunmk2sNOx8dcHkL2s/I6uiYww3GI6t07v21TJDgLd15lol6nL
         YLHkCwpgDmQ+c0nT+iGOVlwNyljQ+mOdGU7aHGdm1d/XEZR3cQFcEBsPTRDHBwR1iuax
         oKhu2+QptTqWa7g/7+RWgCtUIOxA3CDQkfm1ctY7d8dkBasIP18voasw0tyRKLAU6pwC
         dSslwY8T7i4U8ch8gKPmiS/NrNqAZvBH1znEB+GT3CY9vU7B+Z0wHPOOCAPFl34GQGHL
         gBGYlR4r3uviYDWzQAdRKacKMUp/HSi+mU9QKX1JTsPFOAacd+rTB3Hw6IryjVs7slE9
         JnoA==
X-Forwarded-Encrypted: i=1; AJvYcCURA12VOp3OfYeCjgfiDKiFUh0C4+CrTU13NLWjx47cAMR4FODBBBr/6DTMemVa9Lm0OSWjIika0SSmTZEZuLXGOSfupbinXkzuyt2H
X-Gm-Message-State: AOJu0YzF6p0b+uhpojYmJD9+9eiVcDXqWRdLiE4aKvdSYYZpfl0/uIF0
	eZn30pGCEpcZNsBYCzLkYNObSW3GEHGN/wNIQl6w02fAY8Bb/qOJXXBIzG4096w=
X-Google-Smtp-Source: AGHT+IFO9RIMh6kvWocz6pLKLsYWpWuuznyn5mp7qBiekbbqjWT0jnC8LdvlQLxbJKuw5b6fDOrdsg==
X-Received: by 2002:a17:907:1b29:b0:a52:617d:d77f with SMTP id mp41-20020a1709071b2900b00a52617dd77fmr6077497ejc.56.1713282828539;
        Tue, 16 Apr 2024 08:53:48 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4156691eje.94.2024.04.16.08.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:48 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 16 Apr 2024 17:53:19 +0200
Subject: [PATCH v2 18/18] arm64: dts: mediatek: add display support for
 mt8365-evk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v2-18-33ce8864b227@baylibre.com>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
In-Reply-To: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6020; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=M4i1c6AYDA2tEdZrTCUtzyXixpIxmwigGiG2fPItjfs=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmHp7qUFBca7E08f1ngHlmp33iL1Pv9Lit7GgjOUw5
 xOYM3ZKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh6e6gAKCRArRkmdfjHURaHuD/
 oCDVBZHaWA9Ah4glfGxpEvI/qAqr19rDwqndy7g+YFxItm1BLLAQsDWf3PWwXWINhgk1qp8AKEfHag
 H+AgyR6sJ+RSScJKKnJpxbAnFBw+VTYtw9YxMX6UcBQXdAIuyPREY7V/IxD3NgiMT6YQ60IClUChxT
 g+mZFSBsW83vT6Os/DHuIPf7G4qrYf5kfjjqM1P4PAU0YTT3vxIYB4xZQP8Cp2l1MhcFd7eZ9XZ9Nf
 INmIdRUKKzna7mDY12ofaylFrWAJg5oiNKou9p+gAHHNFtXJ88IILb/zhm+QwKa2E7DchvaenxuLME
 iAfx6sPPAy/YM/AoFIGL8APqIDo/0aFnx010D6scRIxnTKaH04WJXRcJXb744L2Hgti8Jjr9WtrPwS
 dnEy3ADN6SsQDNKHZblKrG+ptfXXklXcYlGeXFJLm5958HRxXXtH9HX+4tHPMOZW3KZ1baxi4UW12Z
 r2ZNaFEFEXXfMoWK8srpDlMujcNCcEGCUWpUoiQ8iOk+mbbl8b0XZkDLsO3dfmDAzYDFHnFFeGdCoK
 BE2whclWEqaxtuwJcuUoduLTywfv+CIlhjgIjLnexvgj2aRnIZYWutHGxZVLArR2HiwGUWXWI3vVnz
 oViDNci7PccfDEQKUvr+wE988NJEI+SgKvgrbd1s+zW9Tz/4onA2Wzl07Smg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

MIPI DSI:
- Add "vsys_lcm_reg" regulator support and setup the "mt6357_vsim1_reg",
to power the pannel plugged to the DSI connector.
- Setup the Display Parallel Interface.
  - Add the startek kd070fhfid015 pannel support.

HDMI:
- Add HDMI connector support.
- Add the "ite,it66121" HDMI bridge support, driven by I2C1.
- Setup the Display Parallel Interface.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 182 ++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 50cbaefa1a99..4afdcbefc481 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -26,6 +26,18 @@ chosen {
 		stdout-path = "serial0:921600n8";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "d";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_connector_out>;
+			};
+		};
+	};
+
 	firmware {
 		optee {
 			compatible = "linaro,optee-tz";
@@ -86,6 +98,56 @@ optee_reserved: optee@43200000 {
 			reg = <0 0x43200000 0 0x00c00000>;
 		};
 	};
+
+	vsys_lcm_reg: regulator-vsys-lcm {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&pio 129 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vsys_lcm";
+	};
+};
+
+&dpi0 {
+	pinctrl-0 = <&dpi_default_pins>;
+	pinctrl-1 = <&dpi_idle_pins>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&it66121_in>;
+		};
+	};
+};
+
+&dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "startek,kd070fhfid015";
+		status = "okay";
+		reg = <0>;
+		enable-gpios = <&pio 67 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pio 20 GPIO_ACTIVE_HIGH>;
+		iovcc-supply = <&mt6357_vsim1_reg>;
+		power-supply = <&vsys_lcm_reg>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+
+	port {
+		dsi_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
 };
 
 &cpu0 {
@@ -138,6 +200,50 @@ &i2c0 {
 	status = "okay";
 };
 
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-div = <2>;
+	clock-frequency = <100000>;
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	it66121hdmitx: it66121hdmitx@4c {
+		#sound-dai-cells = <0>;
+		compatible = "ite,it66121";
+		interrupt-parent = <&pio>;
+		interrupts = <68 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&ite_pins>;
+		pinctrl-names = "default";
+		reg = <0x4c>;
+		reset-gpios = <&pio 69 GPIO_ACTIVE_LOW>;
+		vcn18-supply = <&mt6357_vsim2_reg>;
+		vcn33-supply = <&mt6357_vibr_reg>;
+		vrf12-supply = <&mt6357_vrf12_reg>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				it66121_in: endpoint {
+					bus-width = <12>;
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				hdmi_connector_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+};
+
 &mmc0 {
 	assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL>;
 	assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
@@ -180,7 +286,55 @@ &mt6357_pmic {
 	#interrupt-cells = <2>;
 };
 
+&mt6357_vsim1_reg {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+};
+
 &pio {
+	dpi_default_pins: dpi-default-pins {
+		pins {
+			pinmux = <MT8365_PIN_0_GPIO0__FUNC_DPI_D0>,
+				 <MT8365_PIN_1_GPIO1__FUNC_DPI_D1>,
+				 <MT8365_PIN_2_GPIO2__FUNC_DPI_D2>,
+				 <MT8365_PIN_3_GPIO3__FUNC_DPI_D3>,
+				 <MT8365_PIN_4_GPIO4__FUNC_DPI_D4>,
+				 <MT8365_PIN_5_GPIO5__FUNC_DPI_D5>,
+				 <MT8365_PIN_6_GPIO6__FUNC_DPI_D6>,
+				 <MT8365_PIN_7_GPIO7__FUNC_DPI_D7>,
+				 <MT8365_PIN_8_GPIO8__FUNC_DPI_D8>,
+				 <MT8365_PIN_9_GPIO9__FUNC_DPI_D9>,
+				 <MT8365_PIN_10_GPIO10__FUNC_DPI_D10>,
+				 <MT8365_PIN_11_GPIO11__FUNC_DPI_D11>,
+				 <MT8365_PIN_12_GPIO12__FUNC_DPI_DE>,
+				 <MT8365_PIN_13_GPIO13__FUNC_DPI_VSYNC>,
+				 <MT8365_PIN_14_GPIO14__FUNC_DPI_CK>,
+				 <MT8365_PIN_15_GPIO15__FUNC_DPI_HSYNC>;
+			drive-strength = <MTK_DRIVE_4mA>;
+		};
+	};
+
+	dpi_idle_pins: dpi-idle-pins {
+		pins {
+			pinmux = <MT8365_PIN_0_GPIO0__FUNC_GPIO0>,
+				 <MT8365_PIN_1_GPIO1__FUNC_GPIO1>,
+				 <MT8365_PIN_2_GPIO2__FUNC_GPIO2>,
+				 <MT8365_PIN_3_GPIO3__FUNC_GPIO3>,
+				 <MT8365_PIN_4_GPIO4__FUNC_GPIO4>,
+				 <MT8365_PIN_5_GPIO5__FUNC_GPIO5>,
+				 <MT8365_PIN_6_GPIO6__FUNC_GPIO6>,
+				 <MT8365_PIN_7_GPIO7__FUNC_GPIO7>,
+				 <MT8365_PIN_8_GPIO8__FUNC_GPIO8>,
+				 <MT8365_PIN_9_GPIO9__FUNC_GPIO9>,
+				 <MT8365_PIN_10_GPIO10__FUNC_GPIO10>,
+				 <MT8365_PIN_11_GPIO11__FUNC_GPIO11>,
+				 <MT8365_PIN_12_GPIO12__FUNC_GPIO12>,
+				 <MT8365_PIN_13_GPIO13__FUNC_GPIO13>,
+				 <MT8365_PIN_14_GPIO14__FUNC_GPIO14>,
+				 <MT8365_PIN_15_GPIO15__FUNC_GPIO15>;
+		};
+	};
+
 	ethernet_pins: ethernet-pins {
 		phy_reset_pins {
 			pinmux = <MT8365_PIN_133_TDM_TX_DATA1__FUNC_GPIO133>;
@@ -222,6 +376,34 @@ pins {
 		};
 	};
 
+	i2c1_pins: i2c1-pins {
+		pins {
+			pinmux = <MT8365_PIN_59_SDA1__FUNC_SDA1_0>,
+				 <MT8365_PIN_60_SCL1__FUNC_SCL1_0>;
+			bias-pull-up;
+		};
+	};
+
+	ite_pins: ite-pins {
+
+		irq_ite_pins {
+			pinmux = <MT8365_PIN_68_CMDAT0__FUNC_GPIO68>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pwr_pins {
+			pinmux = <MT8365_PIN_70_CMDAT2__FUNC_GPIO70>,
+				 <MT8365_PIN_71_CMDAT3__FUNC_GPIO71>;
+			output-high;
+		};
+
+		rst_ite_pins {
+			pinmux = <MT8365_PIN_69_CMDAT1__FUNC_GPIO69>;
+			output-high;
+		};
+	};
+
 	mmc0_default_pins: mmc0-default-pins {
 		clk-pins {
 			pinmux = <MT8365_PIN_99_MSDC0_CLK__FUNC_MSDC0_CLK>;

-- 
2.25.1


