Return-Path: <linux-kernel+bounces-32216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA37835850
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1306B20F56
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6EF39860;
	Sun, 21 Jan 2024 22:41:44 +0000 (UTC)
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0E383A7
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705876903; cv=none; b=jkyKWE2tOIixlZWs7DgrAk6yOw+yE/cEpoeGi9EweJuJNg7bKA4jupXoGU8zwF8enKryISiBuoPgaaQjlfQyucvgMdrS2F/45ctKnojQomYS9ozKzv2K6g90vkQiHJdFNFYKVCU1wXL8y3DRw9ZmQHwwxhV9p8ctcZNubI5r9w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705876903; c=relaxed/simple;
	bh=v0gMRoyQDCC1TKIVZdeJRib9E5iuXMlTlBxUT/A1zTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZG9JZ7Eo1o5fB4+vffTLv4+iSSIGBJTVTvT2TCLtmCwJ8Cf15UFjtVvZuuZ0UQXAUTV42ObQ8CQaI7Y0DtlVMEfm1k6LqozTdwnjOVLvsahy7V03SBZefYNuzFXFg832PiejO4cD4/asnzoAPkAWJJdsMQI2zAQSVdyKnirIsXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 24B0020332;
	Sun, 21 Jan 2024 23:33:40 +0100 (CET)
From: Marijn Suijten <marijn.suijten@somainline.org>
Date: Sun, 21 Jan 2024 23:33:38 +0100
Subject: [PATCH v2 1/6] arm64: dts: qcom: pmi8950: Add USB vbus and id
 sensing nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-msm8976-dt-v2-1-7b186a02dc72@somainline.org>
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
 Marijn Suijten <marijn.suijten@somainline.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.4

USB sensing is performed on the PMIC, exposed as extcon nodes for use in
the relevant USB (otg) driver nodes as the hardware itself is not able
to sense USB presence (5V vbus) nor the role (ID pin).

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 arch/arm64/boot/dts/qcom/pmi8950.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
index 1029f3b1bb9a..49e97ebdbb3c 100644
--- a/arch/arm64/boot/dts/qcom/pmi8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
@@ -12,6 +12,20 @@ pmic@2 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmi8950_usb_id: usb-id@1100 {
+			compatible = "qcom,pm8941-misc";
+			reg = <0x1100>;
+			interrupts = <0x2 0x11 0x3 IRQ_TYPE_NONE>;
+			interrupt-names = "usb_id";
+		};
+
+		pmi8950_usb_vbus: usb-detect@1300 {
+			compatible = "qcom,pm8941-misc";
+			reg = <0x1300>;
+			interrupts = <0x2 0x13 0x2 IRQ_TYPE_NONE>;
+			interrupt-names = "usb_vbus";
+		};
+
 		pmi8950_vadc: adc@3100 {
 			compatible = "qcom,spmi-vadc";
 			reg = <0x3100>;

-- 
2.43.0


