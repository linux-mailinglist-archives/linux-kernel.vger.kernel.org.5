Return-Path: <linux-kernel+bounces-116832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA9888A3AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3221C3968D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ADA1B6315;
	Mon, 25 Mar 2024 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zNcklAVV"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA01E143876
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362411; cv=none; b=fn8TQAyqzuJ/4jwHFkHRIUlhNcvL/qiShaf61CDGJy3HbZJWVTN+l10M529U+4OHHAKcbNoh6bZ5oLldh7YyUYVVa2Ep/clilkcicRv32T8fMvmE6OuzVqSf2bWUVJlpSSJmXATFqIFMIfbdZbrMjnVUNH8VLXWNCNu5p5Ra1Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362411; c=relaxed/simple;
	bh=AVZSrQHdL6+a9g8t2+zyIIc6BMSaxfc0zjl2VVu7ZTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ugSDgl6fdXo/8zJOQ6vnW4heKkTxwD/zYnDJvdHhf+ALqv73ptWE6cmL8yV378BgNRN/YKHLiBB7oPqjMFYVb9OirIvVZiZJZFwekZ3H6lvjeqHJBm1hneqelKubis+RlQQZtwFTqot25mAcSMVjcK5e+dXjv361db+ZnE9bY4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zNcklAVV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41489d4ffccso3357315e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711362407; x=1711967207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8ARN0OO92nzc+m2sww4E8smHE2ruuORKG++blmW30w=;
        b=zNcklAVVO/qnjuI1B1nAy2uaFEmMlY8IZ91645WPldnEhexP/HuAqnIfUqtZyqb+Gh
         1TAKvhkGuMpeh9nXueVZx5B6ldpwUR/hxZ2IuWVi053m8slz6Ig9fOhHcwDOSXG2TLUh
         I+x7tX46ihpHRL2xHoLOBRVJngNNe/5SpT8bYm+zv/2JcjSRLR7U/Z5TtXzIyhBXeVVZ
         LE7krA8jd0VwgNQkXgyxuLvJaSVSh5Ms7agxhwTy5NHC++B+EQhR3dVufcE3pJlJs+/I
         SgpMyHlOCsewiF1tZ7EtWdwf91c9OTEnisdnhKyHDBcLb3SbdPMxcQ4mw0DGYBVU5aNr
         5jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711362407; x=1711967207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8ARN0OO92nzc+m2sww4E8smHE2ruuORKG++blmW30w=;
        b=HwW57eH4oBZKF83J77aW4i4epsa2AMX0ywuPWWf7qDelx/9oqck0QbFGi8HUBNc1Vp
         cxTPD1Hjm5HcQHGVGhIWRo6GQ+/WPwsRAC3IWhPvgLmKi47DPh70q5SqCxxB584trs+7
         wVgFWsfIEWSHamrrkdMLBa5NZmU9/pb+Z9yvJyI6jY2ziSiQYr7BnwVzTlXRq75nTm0Q
         wuLWUB/GO0pT/JtIm8kX/ZTDzobJGRahZ+njLk5fMuvMvO7+i6I9PULnzLOqy7/wUBOu
         BPXKvs42bfpN/afpGNJz45zvmRCVRtyJ73w8T9iuogU/jUFR580W+Xxu94SEAR7960TU
         wrfw==
X-Forwarded-Encrypted: i=1; AJvYcCVt47g2DiqmVGvMG4ZESngiwneP5tcdKY9LCFuR8N3YWMO/xlaNLdJNQzdhCRTDoGGDRr3L1c304Gxbot0INAUKBlOxEHIczPbW2IwU
X-Gm-Message-State: AOJu0Yztnc+pPFHHzmS5mqELF3iBgWYg/cLzom2bOAoyM1uxIsOIgKX5
	fHuKZW76+sC8yYTcKtWhPVb0J04wUva/eeCZGf6HBi18z+7k0qzfZ1ctMRQXnX1jj7X2UHmbYYx
	wwYX8fg==
X-Google-Smtp-Source: AGHT+IFWYaj11680FvZjRS8qRXW4+Wu0d5RA4CgfBOVb5w9dtZ26sS8X9/XhMtVlw2Iy0cWBRQ0Rfg==
X-Received: by 2002:a05:600c:a47:b0:412:ee8b:dead with SMTP id c7-20020a05600c0a4700b00412ee8bdeadmr4937307wmq.34.1711362407048;
        Mon, 25 Mar 2024 03:26:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id jg24-20020a05600ca01800b0041489884a98sm2899023wmb.6.2024.03.25.03.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:26:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Mar 2024 11:26:39 +0100
Subject: [PATCH v3 3/3] arch: arm64: dts: sm8650-hdk: add support for the
 Display Card overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-topic-sm8650-upstream-hdk-v3-3-4f365d7932af@linaro.org>
References: <20240325-topic-sm8650-upstream-hdk-v3-0-4f365d7932af@linaro.org>
In-Reply-To: <20240325-topic-sm8650-upstream-hdk-v3-0-4f365d7932af@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4583;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=AVZSrQHdL6+a9g8t2+zyIIc6BMSaxfc0zjl2VVu7ZTc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmAVFj+bj0cS/JEa31zINxK4DPoJ7mFC33f4Sl/kXv
 SL1wBYiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZgFRYwAKCRB33NvayMhJ0SVAD/
 9ounW2XzP/jRlsB/c8YJ6DXxOT0lqUaDL9wRvdq4eIW0kAn+pS4DrzUD6ch2HubcsNodDNc7glkQd+
 VnnCwTY1oS2QqkTffXKawFfu2m8kQR/rwomOw5Pxwom4Z0PjqsPNtOTsgn4ch8eglPgQ9G/hKmmo1J
 TXyVzknkYDYTnpfDrrJUCk8XtWZnvv4eMzolTCrXmGZlHQSB5RUM+Eq+MwCZaGuXvN2OIx4boGt11P
 0MEkPX7zJzCL8n8bUTYF28frnovoFbU6HfrArjOaVLEJUao9JxPUn5IU2ryyhbLaqP7akN3LxgOx7d
 OWq/ygjXvQOXcCfxjnetnDNYaOPiJms/WUtTOKh/jWUEOcAyVNSg0dqGT79XS5oGjTgEZpboK/gN+h
 U25WW6dsF3sogaFlHhDywk6IRxP9xYy8wO9dEuO8H9pyrtsouAA3Ofbv9yKz+2o7msWhnJdsoBICjG
 e2r3PF396e9XOXI83SgOxMASW6nWwZk9vpZrxoU0YKPC57/Hv0JHsO9Eth8xkxlrEk8Mi+Q77TW7Tx
 2p0oCJDe+vWtxsm99eJV/QH3MZcdnJGXZ2q/QtSr7pOvbalDeZEcZ/iDWqLdx8q7V6+sWRFf48NCuw
 og0kue3FEtNccRsjz2QgLFYGrQ/v6sTG4Z1+kPFAsBGpVXjlm8LdjBCqUCtg==
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

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   4 +
 .../boot/dts/qcom/sm8650-hdk-display-card.dtso     | 144 +++++++++++++++++++++
 2 files changed, 148 insertions(+)

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
index 000000000000..83f2338e5bf4
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso
@@ -0,0 +1,144 @@
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
+		pinctrl-0 = <&disp0_reset_n_active>, <&mdp_vsync>;
+		pinctrl-1 = <&disp0_reset_n_suspend>, <&mdp_vsync>;
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
+	mdp_vsync: mdp-vsync-state {
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


