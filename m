Return-Path: <linux-kernel+bounces-103708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1BE87C338
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CF21F25E68
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96987640E;
	Thu, 14 Mar 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="fU2gSPS3"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505AC762C1;
	Thu, 14 Mar 2024 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442616; cv=none; b=UxGANbeADqz4tEEtyCUL1bpygJ5WBB92IdUBJrGtDGBnxw3qk3oFGDfFUYppuBefoxSITSSh6hHl/d7hkN5rI+vKC0xcBgD5QlxBcrqCg7XUM7fqQkyX7bt5t1QvPQTybzJbXtF1Qm8/jzAHBcYTaP7YQbyZfdq2kHwqxbhNbwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442616; c=relaxed/simple;
	bh=6cPYJ+ZbtXR0UtPv3MSIlGZ1h+gUPr3OrtY8mAXzPK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G+k51092Hi5dmgqTriDRcvfhlC5voRR38FCuPcsICgBMi3OmrCqASAr8H38oWBkuaHC2QmWQl1kSgi76w5WWgJIUTYWBvI3NaFsK2QfjhsET6AnPbY4WdiL0w5wylMALylTRiGS4YnJXlDWgLMOeasZLKxMHadTiJvknzE+07Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=fU2gSPS3; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710442607; bh=6cPYJ+ZbtXR0UtPv3MSIlGZ1h+gUPr3OrtY8mAXzPK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fU2gSPS3KDIOsgahtNXCw+Z3Wm8JC3UmAeNQLBw/aFzSP3t+Ts2zQjXNFS0RBtrBy
	 DlDemsmTq8c40aHlBXX1w2OrZLP3E/IOERrDJiU/+rG+x1BRF2IzpB7Clh5m3VbJFB
	 EciMaPcW42XKYlRJqFfVunRKmHtrndma8Bf6xZa4=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Thu, 14 Mar 2024 19:56:24 +0100
Subject: [PATCH v2 3/3] ARM: dts: qcom: Add Sony Xperia Z3 smartphone
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-shinano-common-v2-3-a0fce1c72c74@z3ntu.xyz>
References: <20240314-shinano-common-v2-0-a0fce1c72c74@z3ntu.xyz>
In-Reply-To: <20240314-shinano-common-v2-0-a0fce1c72c74@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2380; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=6cPYJ+ZbtXR0UtPv3MSIlGZ1h+gUPr3OrtY8mAXzPK0=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl80hmEHmVKCJ3s1H+/yDBxjlpxtjSnBHqgNlcc
 eqRWFUgj1aJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZfNIZgAKCRBy2EO4nU3X
 VhSpD/9JLNVmizFnIpa+UDLB1P8SbbuNFEW9UfZGOC2Pf5sLnLfcXipT2flWTb9CiATdCX/cO9i
 PcjvtWYWcBMi3weHjLnBhFupz3n7XERD7FWPic9NbMvGDzf4/OwbwSWoFZwK/3fnRytmcnP0CxF
 7uCGZcyeZx36904abIC3TEZmh+rUAnlC+hCPmWmfuxlOj8gXgiI8muPcHp8EDD+A00KfRrXZ/yt
 7AsKJg+ZBba/EB9LP9UYkipkU1CF8ZJYjeEDQBVigg+3YgcrsFc4qPSvPvx6lbwUh30jCdaWAYE
 oGskdyNtG3UopTGNjW4ljjT+84hclKJTSkSDaoRKyyOtyPYMVgUa5RXkBpNS3pV1cI+/qHgSPyY
 PtLkxT7jUFw+jfEjdPo/wZuuJROLXHieamCuoPEXyjoqtaJ36HurTI3uUq3Nd88PduIQvIY0aHW
 YilFcrBEJwFNtEVlKBCxLO+evc+KEqfUKxWjKYA4msFHh7qNBm0aadn0ugloZzAMlntvJti0x0/
 mFEG2vDQr7BPjZ+2tj2xhPrzrPEEAtQzraC+ngca82A0PicuxgeS3VpS9I3oDkXdIbDpFQ1MYsB
 bCDU7PgOzeJOv2UADX1ogKg8EJMawyMXEOViX8jcAAs8Vx+4bPYxFuKqWZXZDACWuDgMT++PVSN
 fkfIMSfk6hS+BxQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the dts for the Xperia Z3 smartphone which is based on Sony's
shinano platform, so at the moment there's little device-specific dts to
add on top of the common parts.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/Makefile                    |  1 +
 .../qcom-msm8974pro-sony-xperia-shinano-leo.dts    | 44 ++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
index 9cc1e14e6cd0..92eca505a4ab 100644
--- a/arch/arm/boot/dts/qcom/Makefile
+++ b/arch/arm/boot/dts/qcom/Makefile
@@ -45,6 +45,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8974pro-oneplus-bacon.dtb \
 	qcom-msm8974pro-samsung-klte.dtb \
 	qcom-msm8974pro-sony-xperia-shinano-castor.dtb \
+	qcom-msm8974pro-sony-xperia-shinano-leo.dtb \
 	qcom-mdm9615-wp8548-mangoh-green.dtb \
 	qcom-sdx55-mtp.dtb \
 	qcom-sdx55-t55.dtb \
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


