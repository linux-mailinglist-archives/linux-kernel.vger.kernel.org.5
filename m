Return-Path: <linux-kernel+bounces-98202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D7C877668
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 12:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795A01C20A5F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EFE24A06;
	Sun, 10 Mar 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="y7GrLhCw"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122E1E481;
	Sun, 10 Mar 2024 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710070921; cv=none; b=h1OIpaNT/hMJftstjdOYISXLvWUuek7epfL48i1WDYUXrMxtx8EOcxMTkdj942o5OUdwnPCiBrKljaLQNY97Qq9zJjW88HwqL2kwrwYNy83iNFmnft2oismtziSkmYiubJDsTa2iUcKv4fgUYh4LAir2PIfMRuw89Yj9unn32Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710070921; c=relaxed/simple;
	bh=gooI2GvtR0miSzuVWMq/Hf+b17GQwvqJfDaFJtnjsGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AbStCp7uEch9FSzq+TAT91H07UaJHcUx22YGepqTSlmjLoy/bfXRlqRRbExVWkR7aX52oVRaEaem2pMNylbFxKPgwZoDOBdz43+M4cx4qxlsG/SoYTSDAaKh7WO9R1Dx9g2YRMwj3XLnWDDeeK3E600ZQk0OeiWGaEQXo6BP+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=y7GrLhCw; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710070913; bh=gooI2GvtR0miSzuVWMq/Hf+b17GQwvqJfDaFJtnjsGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=y7GrLhCwfai35TBJft+BdV3j9pyDDyFh+2F7ZigvV38LHDcDcmE2/JNwjfHeEpmN6
	 u7z1s+2G0UjNCknCt3GFlqCmkLqUkI9Xhocll5NEKGYTUnKn0uzZQ6FZv0wQCNihzf
	 Wpe3Mjb/WnQzhaPa8unvjlPOH3RgtLt29AgRLYms=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 10 Mar 2024 12:41:09 +0100
Subject: [PATCH 3/3] ARM: dts: qcom: Add Sony Xperia Z3 smartphone
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240310-shinano-common-v1-3-d64cd322ebca@z3ntu.xyz>
References: <20240310-shinano-common-v1-0-d64cd322ebca@z3ntu.xyz>
In-Reply-To: <20240310-shinano-common-v1-0-d64cd322ebca@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=gooI2GvtR0miSzuVWMq/Hf+b17GQwvqJfDaFJtnjsGE=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl7Zx+sseVwBS5nVE27KGQZDzAmAt9iYSHpu53u
 Fc6JUsDMIOJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZe2cfgAKCRBy2EO4nU3X
 Vj8jD/9OD9nCVzyDZExPQq/AO7gfn/fqWoXJq8EHb+QjE9AF/XinHZX2ZbmcV9sHJOlpqpvgzNd
 7ijEFn7z5wOMBjVeelAj3rLuMe8HQqEiD627wtgtGccop/HPhgW/RFEqC6FaaC0lgyx1IeZEzYX
 ubQkZxBBKKEzeTj8UrYGbAeQ5VgJJ0cO+nJwtEAJ46gKvDKoeWWis7KNlD8KwA8kR6q8I0Y2Tox
 GzbYRW8EoKKbP48MPBXqMmMj1Kfxa0S2WgbL2rLQKtBw+Rd22pTEh2CcWeSfsk2NNR/5BAiPV5F
 aFF0iwkZEs3krweqLSyTqQFzDJmZ33P7MnagVcO+uB1EGOvWhCtbjWRjE+Ly2uCZDe83CGYFxUh
 nI1dylQK5Mr2D5wsQz3488ir09d36NzYOus31+32DcPP1q0/ccaOxHlxWgD1/Tg0zxIpm/DvThz
 ON3xzF/Sl71a0fXbDv22HHNzwcZcOgGG1qMaWly3bZW//jbDrLeLhv7bPFvxSV1u7roREWq/r22
 ZQ6IRIvmhTQTOXJEI7HYonj6AidAftrbHXF8tgQwK08dag4aYL10YB6RvY+uaObQipvXKApc/sp
 OONqw/uokdR+GxxHuhfIeTOwJ/6pUYG6E1lyYxWUkh5JK3ZS20yF61GaO679ZOIz3vmN0To4r44
 4s5v1bsxC2d5mww==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the dts for the Xperia Z3 smartphone which is based on Sony's
shinano platform, so at the moment there's little device-specific dts to
add on top of the common parts.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../qcom-msm8974pro-sony-xperia-shinano-leo.dts    | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-leo.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-leo.dts
new file mode 100644
index 000000000000..1ed6e1cc21d5
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-leo.dts
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "qcom-msm8974pro-sony-xperia-shinano-common.dtsi"
+
+/ {
+	model = "Sony Xperia Z3";
+	compatible = "sony,xperia-leo", "qcom,msm8974pro", "qcom,msm8974";
+	chassis-type = "handset";
+
+	gpio-keys {
+		key-camera-snapshot {
+			label = "camera_snapshot";
+			gpios = <&pm8941_gpios 3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_CAMERA>;
+			debounce-interval = <15>;
+		};
+
+		key-camera-focus {
+			label = "camera_focus";
+			gpios = <&pm8941_gpios 4 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_CAMERA_FOCUS>;
+			debounce-interval = <15>;
+		};
+	};
+};
+
+&gpio_keys_pin_a {
+	pins = "gpio2", "gpio3", "gpio4", "gpio5";
+};
+
+&smbb {
+	usb-charge-current-limit = <1500000>;
+	qcom,fast-charge-safe-current = <3000000>;
+	qcom,fast-charge-current-limit = <2150000>;
+	qcom,fast-charge-safe-voltage = <4400000>;
+	qcom,fast-charge-high-threshold-voltage = <4350000>;
+	qcom,auto-recharge-threshold-voltage = <4280000>;
+	qcom,minimum-input-voltage = <4200000>;
+
+	status = "okay";
+};
+
+&synaptics_touchscreen {
+	vio-supply = <&pm8941_s3>;
+};

-- 
2.44.0


