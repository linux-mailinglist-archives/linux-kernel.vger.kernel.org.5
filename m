Return-Path: <linux-kernel+bounces-77949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7266860D39
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB882859A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FAC1AADE;
	Fri, 23 Feb 2024 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFdGHXnF"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C054B1AAD8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678340; cv=none; b=k7Iw5oraMrrCODCpatL7R8e3DQHfUWTW3FCJpx7gk/ZLtx/zebsqopU6PwlsmIH8rYOCFqxoPLqlHyX2NCkG2/Lzj2wnvklc730LbrUs/1JXxARE//WR6ayuGahBn2Sn7Rzh56CCpqiysdwW8R3VSie0uGepccA7ztYykFn7gTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678340; c=relaxed/simple;
	bh=shI4snK4SsxOr92XTKwkqdy4D04fYRsYSgmhbyc1cr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAoUjBojyWb/RL7VriToew1HMAGm1dMB0lWrA5IhwUWQyVdOdYn0HJ40nt5YvGjGG4dKgIU32L+l3x+2zmpXsoLrVP8HHQp+eI06De45gmhWudBhIeHTwWDa1rUiGM2rcVSCtucv3+Ylejn6i3kfYtdwCxHWjuGZYhpmHXpOj18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uFdGHXnF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412949fd224so605555e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708678336; x=1709283136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOESMyan+flAcJ4QttQasCea652A8wI1qP6NEVlibnU=;
        b=uFdGHXnFaTjkGa9xnppKUpRrr8BP904AefOFqhWPwxKkDas5argaR9sK4KTGr8ab2x
         0Ro87QL8icI6VTYIfnu0JnoYRli4vPY2RLThBuKldXxich8uzt4P+0Nqt6aa3d9uihcx
         x/Q29+u/TApABp+D8qY0z3Xmk6XNaui14rZXGBnBSWmP+hrRq9Sg71bkyuhYl1EZ3sti
         uovibTYl639Djf5FUK/pQvroUZlp4E6zjIiHSTGZ+JFysFpLk0KqKQh13V9f1m8bx87Q
         6cgoaBjPRnM4CvMFuTq9erUb5RBs7dEb0j1EP3GJZy//bURb8EGGMeGGLjzoODqvu/t3
         5Q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708678336; x=1709283136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOESMyan+flAcJ4QttQasCea652A8wI1qP6NEVlibnU=;
        b=ktaMOLSj/OiSb10VJuwP0VjdpIsKnlUbgabpiJo8/5vpubP24gGTofeyqxJbNSmk0K
         lfQ0A1RiK79rOqafy+AZHJTpgAhcVgr5Ielvpc1LOVWtX9+y4l9UZ6LAwji27A57OpT8
         XuLpnvYjFRvibI7Bta+wc2BAxEcW3dv9MBZhmw7MYyi5SACSijKLtuISFytdXLsJ+BpE
         xSsGgDXDLJlRVmKbVcCLWWgIK0aW4QC7pkOOXaI4O/CrqK5m9szpHsKUXbzlXZARszV/
         SLIUSmhQ2AsVgG7dqai8+BZfeRPWP4oIsr7//onx0qLF0G8j4OmygNzbREqsfY1ldduz
         4nNw==
X-Forwarded-Encrypted: i=1; AJvYcCWMXiNRejWfIpXOYlSjn+utXI9iUZx8THhNmLmAogzPlskkkwmbXY93TrsKKVYI7k+NYltWcRVvTyBd79LNh5uT6H99F5p5uZvXnDba
X-Gm-Message-State: AOJu0Yy0TeS6WI0YGtKILBgLrrYPE3o6FVqW4alFApTrrB5HddX9EPIz
	KDI9wvJDPb6z9eip4xprkUE4l77Ar3pSEFV1clw3SN5acxTJAidXztvSHEb54F73/SMQ+6OC830
	Sg/AWqw==
X-Google-Smtp-Source: AGHT+IH+WDC6Z/LWIIcjsEM2gQNaVzqWbm5wn6zeMmr/8jgZTRAZj6SXck8c8lp6Yy7mXhKTnXZzIg==
X-Received: by 2002:a5d:6602:0:b0:33d:31ec:e09c with SMTP id n2-20020a5d6602000000b0033d31ece09cmr1134748wru.11.1708678336103;
        Fri, 23 Feb 2024 00:52:16 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 11-20020a056000156b00b0033d1b760125sm2028168wrz.92.2024.02.23.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:52:15 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 23 Feb 2024 09:52:09 +0100
Subject: [PATCH 3/3] arch: arm64: dts: sm8650-hdk: add support for the
 Display Card overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-topic-sm8650-upstream-hdk-v1-3-ccca645cd901@linaro.org>
References: <20240223-topic-sm8650-upstream-hdk-v1-0-ccca645cd901@linaro.org>
In-Reply-To: <20240223-topic-sm8650-upstream-hdk-v1-0-ccca645cd901@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4636;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=shI4snK4SsxOr92XTKwkqdy4D04fYRsYSgmhbyc1cr4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl2Fy8KVDMNW30PPi+lOoHGGKXVvpIv/Weks0SDrL9
 Gu9nvY2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZdhcvAAKCRB33NvayMhJ0aFtD/
 9B3J0lQK3PQdAExaHPQu0VtLisRXRH34xh0m6S0FPtyw3SuO1OTzaZYcHt9YZDU+b1OiuLJOkj4Ddo
 tO+Y6K/Ghlx4ItipzhnaELD7iaFPcoTUMmClBhHnV1iPx/1RiOLFAZOVzlmuf9mCymwnxvvTvr68Sr
 ebIE2pn1pDM3xPjLvr9OurMdsdeUTZPNQACiJnsLLV6TyVV7FqWJVn8oALVJxjWPvi9zG4Xtgu3VZA
 7KoZP/IZrDeHeZMRaRAogaRFzDUX1PSvI3s+0S1Iw1oIO0FUa9NOKD6i+diXIKatac6Zl4dXmD2mh1
 994qqAtCmE3Nuq3nHspVOBGExD5out2/mAVrgV+NU7TruR4DzwiY83T+a4ldh17IhT5oIMPXEyeaPg
 oKPD+fjGgVe6LT0q8zx5xtNq86s9IJTh76+GXFbfVcr8FX1Fg1sBgSwCVAWYdkd7owLzU9O5gpj1ko
 f8AKQ9FPm+zTWJoUo+N5GGtMxg17uX7Krwqo7qOeu3ShlppCgJnKvGsVJqf+ycUlnKHwFx8aSHDV6W
 op0wiFKHHKmVKzq8VP2H8jVShlxTDXvuvICc8b/el+TjPqiWm6sKHeTMNQRM82elVtzuQl2cUeaBH/
 ZQTOkWddHsYgW8QyEaeDcWJ4bl1echudY/LHMcb3yocWR5BCrLJW/aLQurTA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

With the SM8650-HDK, a Display Card kit can be connected to provide
a VTDR6130 display with Goodix Berlin Touch controller.

In order to route the DSI lanes to the connector for the Display
Card kit, a switch must be changed on the board.

The HDMI nodes are disabled since the DSI lanes are shared with
the DSI to HDMI transceiver.

Add support for this card as an overlay and apply it it at
build-time to the sm8650-hdk dtb.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   4 +
 .../boot/dts/qcom/sm8650-hdk-display-card.dtso     | 151 +++++++++++++++++++++
 2 files changed, 155 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 4f48c98451de..566997db4b37 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -241,6 +241,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
+
+sm8650-hdk-display-card-dtbs	:= sm8650-hdk.dtb sm8650-hdk-display-card.dtbo
+
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk-display-card.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso b/arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso
new file mode 100644
index 000000000000..b9de6c9ce10e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2024, Linaro Limited
+ */
+
+/*
+ * Display Card kit overlay
+ * This requires S5702 Switch 7 to be turned to OFF to route DSI0 to the display panel
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/dts-v1/;
+/plugin/;
+
+&i2c6 {
+	status = "disabled";
+};
+
+&lt9611_1v2 {
+	status = "disabled";
+};
+
+&lt9611_3v3 {
+	status = "disabled";
+};
+
+&vreg_bob_3v3 {
+	status = "disabled";
+};
+
+&lt9611_codec {
+	status = "disabled";
+};
+
+&mdss_dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	panel@0 {
+		compatible = "visionox,vtdr6130";
+		reg = <0>;
+
+		reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+
+		vddio-supply = <&vreg_l12b_1p8>;
+		vci-supply = <&vreg_l13b_3p0>;
+		vdd-supply = <&vreg_l11b_1p2>;
+
+		pinctrl-0 = <&disp0_reset_n_active>, <&mdp_vsync_active>;
+		pinctrl-1 = <&disp0_reset_n_suspend>, <&mdp_vsync_suspend>;
+		pinctrl-names = "default", "sleep";
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+
+	/*
+	 * DTC requires to have both endpoints when compiling the overlay
+	 * and also requires the #address/size-cells + reg properties
+	 */
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			reg = <1>;
+
+			mdss_dsi0_out: endpoint {
+				remote-endpoint = <&panel0_in>;
+			};
+		};
+	};
+};
+
+&spi4 {
+	/* DTC requires the #address/size-cells to compile DTBO */
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	status = "okay";
+
+	touchscreen@0 {
+		compatible = "goodix,gt9916";
+		reg = <0>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <162 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&tlmm 161 GPIO_ACTIVE_LOW>;
+
+		avdd-supply = <&vreg_l14b_3p2>;
+
+		spi-max-frequency = <1000000>;
+
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2400>;
+
+		pinctrl-0 = <&ts_irq>, <&ts_reset>;
+		pinctrl-names = "default";
+	};
+};
+
+&tlmm {
+	disp0_reset_n_active: disp0-reset-n-active-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	disp0_reset_n_suspend: disp0-reset-n-suspend-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mdp_vsync_active: mdp-vsync-active-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mdp_vsync_suspend: mdp-vsync-suspend-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	ts_irq: ts-irq-state {
+		pins = "gpio161";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+		output-disable;
+	};
+
+	ts_reset: ts-reset-state {
+		pins = "gpio162";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+};

-- 
2.34.1


