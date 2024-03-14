Return-Path: <linux-kernel+bounces-103861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B1E87C5D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9DF28257C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87A0101EE;
	Thu, 14 Mar 2024 23:20:55 +0000 (UTC)
Received: from sraa.de (sraa.de [85.214.240.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB916119;
	Thu, 14 Mar 2024 23:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.240.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458455; cv=none; b=LqWPfUubSmTgHzq4N6gOoTpfGsZhPlwG3HJoGIXyILvP9ff1OMjRrsSMIYezkr0arbQC+GAfki50bJcEIwolM9EP/lZfeFeQDIz29bWHG2ZW57A+Kjbe01i6v3iZmMu5PqtUCB3N1CmIZ0cd1nEZ6L8WDhsvMTcltCe/rLW7T9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458455; c=relaxed/simple;
	bh=QBOQpe1cDYEpTvChQ54IMY0pQimCYjwhdFsGp2n8hpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyNgrhNSNHzV4Hz77Y2TdNFaHkdgHv2wKpkhQ4O0KacE0YEmAVAr6n2sXZRySvlVPr/0Nvy9DFvidPEmT/C+Z7LTvFDNqgij83jgLJkxw2+Vsqw/skJ1SQpfBO+DuBnwJbHT7VIgDd6V3+IvbANUoTA/8cplm00lvRr1C3uF0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sraa.de; spf=pass smtp.mailfrom=sraa.de; arc=none smtp.client-ip=85.214.240.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sraa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sraa.de
Received: from c-bda170d5.017-30-6c756e3.bbcust.telenor.se ([213.112.161.189] helo=senor0lunlx0336.fritz.box)
	by sraa.de with esmtpa (Exim 4.94.2)
	(envelope-from <basti@sraa.de>)
	id 1rkuNU-006TiD-Og; Fri, 15 Mar 2024 00:20:48 +0100
From: Sebastian Raase <linux@sraa.de>
To: linux@sraa.de
Cc: marijn.suijten@somainline.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sdm630-nile: add pinctrl for camera key
Date: Fri, 15 Mar 2024 00:20:39 +0100
Message-ID: <20240314232043.1441395-1-linux@sraa.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240314200037.549206-1-linux@sraa.de>
References: <20240314200037.549206-1-linux@sraa.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: basti@sraa.de

Add pinctrl configuration for gpio-keys. Without this,
camera button half-presses are not detected.

Tested on discovery and pioneer.

Fixes: e781633b6067 ("arm64: dts: qcom: Add support for Sony Xperia XA2/Plus/Ultra (Nile platform)")
Signed-off-by: Sebastian Raase <linux@sraa.de>
---
 arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 87d0293c728d..823c21d5ee59 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -90,6 +90,8 @@ cam_vana_rear_vreg: cam-vana-rear-regulator {
 
 	gpio-keys {
 		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_default>;
 
 		key-camera-focus {
 			label = "Camera Focus";
@@ -635,6 +637,13 @@ ts_lcd_id_active: ts-lcd-id-active-state {
 		bias-disable;
 	};
 
+	gpio_keys_default: gpio-keys-default-state {
+		pins = "gpio64", "gpio113";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 	imx300_vana_default: imx300-vana-default-state {
 		pins = "gpio50";
 		function = "gpio";
-- 
2.42.0


