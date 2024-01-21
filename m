Return-Path: <linux-kernel+bounces-32212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E7D835844
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3424C1F21AD2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF143984B;
	Sun, 21 Jan 2024 22:33:47 +0000 (UTC)
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6174A38F96
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705876426; cv=none; b=gRtP7j3yr2edfQs2apQBAkP+oomp0299KfZF1pcuR4ibZVfgZsepRcOwDfZxsrwjIpPCzN1/7ruE3NEpDhXIAfkryRLbQA5mmWl0L3wMCYSkz+meQf6AhXH3NvJ5YixweE0Re3ai9ORXXJoqkqeOcmWEYVatGKSyBVl5Y77xYHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705876426; c=relaxed/simple;
	bh=VbDBG4qhPodRfMvJ9XKMOJeUDdjCBEhllCKMHhMsXow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ataOhudSn4l587FyiJM6GpjbQZKb68tgzfGJzEnJEbklbM7WRE/1OEu3wraIQFxd4DgWPxMs6dIr/A9I3iOzBF8A4SVdm5w7nFkj1hNdiLFrZB1BErTGxIXJBLZdjrDteV+EK9lFjBw2ur6ha9HPWEKk18sw8SDUUKSorqnYm10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 3A7DD20300;
	Sun, 21 Jan 2024 23:33:43 +0100 (CET)
From: Marijn Suijten <marijn.suijten@somainline.org>
Date: Sun, 21 Jan 2024 23:33:42 +0100
Subject: [PATCH v2 5/6] arm64: dts: qcom: msm8976: Declare and use SDC2
 pins
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-msm8976-dt-v2-5-7b186a02dc72@somainline.org>
References: <20240121-msm8976-dt-v2-0-7b186a02dc72@somainline.org>
In-Reply-To: <20240121-msm8976-dt-v2-0-7b186a02dc72@somainline.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Luca Weiss <luca@z3ntu.xyz>, Adam Skladowski <a39.skl@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Martin Botka <martin.botka@somainline.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.4

Add the pinctrl states for SDC2 and use them on sdhc_2 to support SD
Cards on the currently mainlined Sony Loire platform.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../dts/qcom/msm8956-sony-xperia-loire-kugo.dts    |  6 +++
 .../boot/dts/qcom/msm8956-sony-xperia-loire.dtsi   |  6 +++
 arch/arm64/boot/dts/qcom/msm8976.dtsi              | 45 ++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts
index 3fb8e23e4330..9178943e2ee1 100644
--- a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts
+++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts
@@ -33,3 +33,9 @@ &pm8950_l1 {
 	regulator-min-microvolt = <1100000>;
 	regulator-max-microvolt = <1300000>;
 };
+
+&sdc2_on_state {
+	data-pins {
+		drive-strength = <8>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
index a82b58cdd99c..b0b83edd3627 100644
--- a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
@@ -264,6 +264,12 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdc2_on_state {
+	clk-pins {
+		drive-strength = <10>;
+	};
+};
+
 &sdhc_2 {
 	bus-width = <4>;
 	cd-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 1d06f9b8a0f1..c100f63b1883 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -719,6 +719,46 @@ rclk-pins {
 				};
 			};
 
+			sdc2_off_state: sdc2-off-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			sdc2_on_state: sdc2-on-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+			};
+
 			spi1_default: spi0-default-state {
 				spi-pins {
 					pins = "gpio0", "gpio1", "gpio3";
@@ -911,6 +951,11 @@ sdhc_2: mmc@7864900 {
 				 <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "iface", "core", "xo";
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc2_on_state>;
+			pinctrl-1 = <&sdc2_off_state>;
+
 			status = "disabled";
 		};
 

-- 
2.43.0


