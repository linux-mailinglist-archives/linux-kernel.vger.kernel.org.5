Return-Path: <linux-kernel+bounces-46099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B48843A52
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F411C27B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A72634FA;
	Wed, 31 Jan 2024 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwOxeAPh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55863FB30;
	Wed, 31 Jan 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691887; cv=none; b=glgv01KjDz0pTT4nZB7fU4EIKklH9CcFFYMoVA/ITiYLhj1eczjgjbAlBd4x15aJi5+UCxV2CljPXuy8zDem2y3mrzYeAINVybH7DkPH9An6LrhbaVB9mfH9Kh4zISJ8S1Nd4ZeV/e3SA53P5TRxkJfQDE4mESEf3Q9CJ8oGhrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691887; c=relaxed/simple;
	bh=ZbYXhjXWvoG2xDHKAPM5zoanyvcH1F57GIo4k0O2Kbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HSRaseb33w+G6p2BKlxgGGpgEAj6LxP7l7x562OjuxoENTVToQpRYm7VgRC/TkcKtMdg9neCpYpJeuKrP7RuF6BsUqfKF08BN+wpEVM6Z3NuggqMaGY76NC2osioIOpZ0dYQFsXE/G5OvTuwoNI+4T8s41TQZJGcZkF2ZGE7bls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwOxeAPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28AA1C433F1;
	Wed, 31 Jan 2024 09:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706691887;
	bh=ZbYXhjXWvoG2xDHKAPM5zoanyvcH1F57GIo4k0O2Kbo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uwOxeAPhkzEr97hEhwDUhB+el3jF0xxMUZixm9MFJbHKYtYnbBogtmk30Ghls2wd9
	 y+U7MU/r9BML9IV8L0LpxGpMRq+pky3R5JKbk1DEohwnuzPeXwogVOMRGcALlZH5NM
	 BHXlVcOAuFxqsd5GbIHTCsVM4zNFc5v7ukligRZpY7CHtXMon1R8t7OUeOCXJktMZq
	 To4oG6TDmvsQsWsPTSlHNCJ/uIvLrNh1pkCN84w+jMmNraU7Wk0MEzsmF54Lnf3oB9
	 T2Ej2baiuVx6HfYykYtq3D9JQelSB/8kiDO4tj1QiMWgXC6HbVH8mCo4itJVgqqDLG
	 Oow+qMUahv06A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171F9C47DDF;
	Wed, 31 Jan 2024 09:04:47 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Wed, 31 Jan 2024 01:04:46 -0800
Subject: [PATCH v2 1/2] ARM: dts: qcom: msm8960: Add gsbi3 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240131-expressatt_mxt224s_touchscreen-v2-1-4463ae0414b5@gmail.com>
References:
 <20240131-expressatt_mxt224s_touchscreen-v2-0-4463ae0414b5@gmail.com>
In-Reply-To:
 <20240131-expressatt_mxt224s_touchscreen-v2-0-4463ae0414b5@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rudraksha Gupta <guptarud@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706691886; l=2107;
 i=guptarud@gmail.com; s=20240120; h=from:subject:message-id;
 bh=G6XPs19Hk+i3uuDKqNqjvb4ePyJrYWEvOCZGE4iK36g=;
 b=01IhAm1m43JwSoG5qVDfjpK8EYKpRI+iitc0eh5r8bOoHY63CcTmbb+icdnyO8w6DpwEG2+9h
 MKJA/e9ZOBMC/McxNWDd0JY00M+xsKWcXn+e7C9iU3zQYOWdu2t+XwZ
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=RGmug3GRHS4XYTXDcT2VrlTGXlEF2gY4L9/swGIU1ko=
X-Endpoint-Received:
 by B4 Relay for guptarud@gmail.com/20240120 with auth_id=114
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: <guptarud@gmail.com>

From: Rudraksha Gupta <guptarud@gmail.com>

Copy gsbi3 node from qcom-apq8064.dtsi and set appropriate properties

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi | 21 ++++++++++++++++++++
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi      | 28 +++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi
new file mode 100644
index 000000000000..4fa982771288
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+&msmgpio {
+	i2c3_default_state: i2c3-default-state {
+		i2c3-pins {
+			pins = "gpio16", "gpio17";
+			function = "gsbi3";
+			drive-strength = <8>;
+			bias-disable;
+		};
+	};
+
+	i2c3_sleep_state: i2c3-sleep-state {
+		i2c3-pins {
+			pins = "gpio16", "gpio17";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-bus-hold;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
index f420740e068e..93365298c5ae 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
@@ -359,5 +359,33 @@ usb_hs1_phy: phy {
 				};
 			};
 		};
+
+		gsbi3: gsbi@16200000 {
+			compatible = "qcom,gsbi-v1.0.0";
+			reg = <0x16200000 0x100>;
+			ranges;
+			cell-index = <3>;
+			clocks = <&gcc GSBI3_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			gsbi3_i2c: i2c@16280000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x16280000 0x1000>;
+				pinctrl-0 = <&i2c3_default_state>;
+				pinctrl-1 = <&i2c3_sleep_state>;
+				pinctrl-names = "default", "sleep";
+				interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GSBI3_QUP_CLK>,
+					 <&gcc GSBI3_H_CLK>;
+				clock-names = "core", "iface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
 	};
 };
+#include "qcom-msm8960-pins.dtsi"

-- 
2.43.0


