Return-Path: <linux-kernel+bounces-43847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7304384197D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F445289DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D47374F0;
	Tue, 30 Jan 2024 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5xdLO+p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EECC36B1E;
	Tue, 30 Jan 2024 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582588; cv=none; b=sRaoBLjDjTXw4gpn/4aDbPi9DiboxHcQpqwMUewhXAS5dqLb32a+9eYNGmirqj4iGSBaxrq7umQ5aqWNUXzexjyhUeNPMwHEQF1nLYM1lJGrGdV4A4JPe5HVEg0Ciw3q7NgMLSNjsvHI5OylqQicmf2eaH10ZC3WZkD0Sy4jfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582588; c=relaxed/simple;
	bh=K37aEDqRuJkgbyoKfj6QrsTeE2KT/iqTlg+8d9xGoy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j4nSZ0uUVvtU5F5o4awF+ykMOSMzSLbf02X4g/DucjrIYxFUCXs7vZM6AJvBMEs0BicHD/KdCWPiQsbOFgUhVoY8izrw9LG26/H9juUExFYwKfLItkPUhj+hZVb7EDIO8iR66Azl9OomLhJbpLUnvgFkh24xZjZ3smNwhMaa2gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5xdLO+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6D49C433A6;
	Tue, 30 Jan 2024 02:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706582587;
	bh=K37aEDqRuJkgbyoKfj6QrsTeE2KT/iqTlg+8d9xGoy8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I5xdLO+pnMv4FZyZ4hsgFtdTLMWshxxcUBsOdNjdPdShElmmKb2d8hYM9/QyzCpND
	 rie+c3gT4P7ljmY2t3AL+HaM9XNRD4LH2BDYiFB5gerdM1iw5NzwCIzQteuFcrLnGd
	 HFb3bLnj6tmc0j3ydcwTe/dwOnePn17z9ZpMB9ax4SvtRSl5sfh4CDOjOxJTgFpEDm
	 Nf4pvEJdIWYkNywuJajkT4zuhRX7LVa/mXKFcZZdiariyiwEcYi2MmGBu/uUkXPTQy
	 2QCcsSG4febqqnvHResFW/nyAJ0aX27cuo3MgxQEEhTVRWzX4Q7uURimT2sCEeyID4
	 WamaHifFuv3Eg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEDEC48285;
	Tue, 30 Jan 2024 02:43:06 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Mon, 29 Jan 2024 18:43:06 -0800
Subject: [PATCH 1/2] ARM: dts: qcom: msm8960: Add gsbi3 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240129-expressatt_mxt224s_touchscreen-v1-1-fb8552e1c32c@gmail.com>
References:
 <20240129-expressatt_mxt224s_touchscreen-v1-0-fb8552e1c32c@gmail.com>
In-Reply-To:
 <20240129-expressatt_mxt224s_touchscreen-v1-0-fb8552e1c32c@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rudraksha Gupta <guptarud@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706582586; l=2174;
 i=guptarud@gmail.com; s=20240120; h=from:subject:message-id;
 bh=71iD1TcYIaHc5nmS/5IyoaavDQDYXrkg8rcaJA80YFE=;
 b=+YgFjGIGrCn96fSpHtUZX/Eau/zRUk1I3kDEu6G3B/hIxpJgS+376e0e0TsFJMmPnUYU8cO3v
 nrQuuGBZAzkCAWlmG+vDRL434BGJCgGI43bFp1zjWn7H0UYUzzeP4x1
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
 arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi | 29 +++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi      | 27 +++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi
new file mode 100644
index 000000000000..c74c6625d276
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+&msmgpio {
+	i2c3_pins: i2c3 {
+		mux {
+			pins = "gpio16", "gpio17";
+			function = "gsbi3";
+		};
+
+		pinconf {
+			pins = "gpio16", "gpio17";
+			drive-strength = <8>;
+			bias-disable;
+		};
+	};
+
+	i2c3_pins_sleep: i2c3_pins_sleep {
+		mux {
+			pins = "gpio16", "gpio17";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio16", "gpio17";
+			drive-strength = <2>;
+			bias-bus-hold;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
index f420740e068e..62a5a9622e82 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
@@ -359,5 +359,32 @@ usb_hs1_phy: phy {
 				};
 			};
 		};
+
+		gsbi3: gsbi@16200000 {
+			status = "disabled";
+			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <3>;
+			reg = <0x16200000 0x100>;
+			clocks = <&gcc GSBI3_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			gsbi3_i2c: i2c@16280000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				pinctrl-0 = <&i2c3_pins>;
+				pinctrl-1 = <&i2c3_pins_sleep>;
+				pinctrl-names = "default", "sleep";
+				reg = <0x16280000 0x1000>;
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


