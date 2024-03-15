Return-Path: <linux-kernel+bounces-104972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E7B87D6D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D441C2823CE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E185A102;
	Fri, 15 Mar 2024 22:54:24 +0000 (UTC)
Received: from sraa.de (sraa.de [85.214.240.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508A05786D;
	Fri, 15 Mar 2024 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.240.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710543264; cv=none; b=UJFxCvKDZF0ssapCL3Cu82KCGDgi2N6yDga8LBeXGzVNe613+ffqJDgas9RXTh/aTbtwgTVhut2Fa5JxL3++gZhxp+6GBnNpCG5S8XQLMjYpCl3taQTwpleqUlMT2gRByOghVRporIkzIqGqic3g6pZ9FGeX91bD7P7zn1v6Y4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710543264; c=relaxed/simple;
	bh=6hR05NJk+lMVNR9EfuXcSOG743yQJzWU6Wr45bCwm/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=logEDm5CdaS3iBeagUuyWVRV6KOxxgr3IPCMOyyKZUmMn2tX402rUo/+262KVimw3SRz2dO/ZvQnEpWSajX/znt3ZwO7AI4u/Cyv7ig0l6Unt60yq4lPQOMmqjpgHGnrn3e+41PKx97w0fGfVoDZR4Omj9w3/5h4xXy7XWkx6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sraa.de; spf=pass smtp.mailfrom=sraa.de; arc=none smtp.client-ip=85.214.240.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sraa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sraa.de
Received: from c-bda170d5.017-30-6c756e3.bbcust.telenor.se ([213.112.161.189] helo=senor0lunlx0336.fritz.box)
	by sraa.de with esmtpa (Exim 4.94.2)
	(envelope-from <basti@sraa.de>)
	id 1rlGRG-006eh0-AX; Fri, 15 Mar 2024 23:54:09 +0100
From: Sebastian Raase <linux@sraa.de>
To: linux@sraa.de
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8998-yoshino: fix volume-up key
Date: Fri, 15 Mar 2024 23:52:29 +0100
Message-ID: <20240315225237.1616550-1-linux@sraa.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: basti@sraa.de

The volume-up key is connected to gpio6 on yoshino.
Fix button node ordering while at it.
Disable pm8998_resin, since it is now unused.

Tested on maple and lilac.

Fixes: 390883af89d2e ("arm64: dts: qcom: msm8998: Introduce support for Sony Yoshino platform")
Signed-off-by: Sebastian Raase <linux@sraa.de>
---
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 44 +++++++++++--------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index 876c6921ddf0..fdd3953938d9 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -98,30 +98,35 @@ extcon_usb: extcon-usb {
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "Side buttons";
+		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n &vol_up_n>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&vol_down_n &focus_n &snapshot_n>;
-		button-vol-down {
-			label = "Volume Down";
-			gpios = <&pm8998_gpios 5 GPIO_ACTIVE_LOW>;
-			linux,input-type = <EV_KEY>;
-			linux,code = <KEY_VOLUMEDOWN>;
-			wakeup-source;
+		button-camera-focus {
+			label = "Camera Focus";
+			gpios = <&pm8998_gpios 8 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_CAMERA_FOCUS>;
 			debounce-interval = <15>;
 		};
 
 		button-camera-snapshot {
 			label = "Camera Snapshot";
 			gpios = <&pm8998_gpios 7 GPIO_ACTIVE_LOW>;
-			linux,input-type = <EV_KEY>;
 			linux,code = <KEY_CAMERA>;
 			debounce-interval = <15>;
 		};
 
-		button-camera-focus {
-			label = "Camera Focus";
-			gpios = <&pm8998_gpios 8 GPIO_ACTIVE_LOW>;
-			linux,input-type = <EV_KEY>;
-			linux,code = <KEY_CAMERA_FOCUS>;
+		button-vol-down {
+			label = "Volume Down";
+			gpios = <&pm8998_gpios 5 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+
+		button-vol-up {
+			label = "Volume Up";
+			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
 			debounce-interval = <15>;
 		};
 	};
@@ -345,6 +350,14 @@ vol_down_n: vol-down-n-state {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
 
+	vol_up_n: vol-up-n-state {
+		pins = "gpio6";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		bias-pull-up;
+		input-enable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+	};
+
 	focus_n: focus-n-state {
 		pins = "gpio7";
 		function = PMIC_GPIO_FUNC_NORMAL;
@@ -405,11 +418,6 @@ vib_ldo_en: vib-ldo-en-state {
 	};
 };
 
-&pm8998_resin {
-	linux,code = <KEY_VOLUMEUP>;
-	status = "okay";
-};
-
 &qusb2phy {
 	status = "okay";
 
-- 
2.42.0


