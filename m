Return-Path: <linux-kernel+bounces-136799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5598789D84A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3311C245E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663C212A144;
	Tue,  9 Apr 2024 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h15vBCMv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB08004E;
	Tue,  9 Apr 2024 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662949; cv=none; b=ata3g7j6/JE4L7/B9ByVa5Fj2euWJtaC3j6afEcdGIUmb4mokrOcMvgYlkE4eZV/Kk4dKX6vyZLRTa2s277EEfIkZAgoAh0lVuvNQPkaa5kxZjt7W73ma9O6m3DH8670BeFLVsVRZPSogqDb/d71FyB3vYHG6r05l1PEjCogfYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662949; c=relaxed/simple;
	bh=v4vUCuSjUww6FJAfXwVkRyRenCihx6Rkh72bQi4n8MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TN08G8/aLL5+Qhkur2FdRV/Q8o4wn78RkCw7mnOh/ec91fNYiCLPFCDw893l/ibgSCyp6Ung+QiCnuqJJ/LIUJKjBp79+02RlzBgpXj/uxF1PuTn5S9rjSO3cn/DFrfPRAUhyrGjU97c3EV8vXPncwOq13+CAN5wJRuRiEjR9nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h15vBCMv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712662946;
	bh=v4vUCuSjUww6FJAfXwVkRyRenCihx6Rkh72bQi4n8MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h15vBCMvFNJEepnXxpT1jZtNp37p8f03FkdXhLd6AzvvZzYAyBdNIQe0ud6IUbmO0
	 4b8wLG80kk1IO6NjPAPdt+zDxDJjUJwyFExAjOndiHRuvqUoTgZbUinholQ6qOREcP
	 A+jcnFPaC9ybm48SJI0490KddvghK4WSXzl6yfveRumMB+bwqrY9QCL2kTTswpW6WY
	 OcUFE44wOpTEAay1FNyiIrpgvLA7YmrxD7UFM/QS+njM1IRuqc7NvIt4ZgGK7TuPcl
	 henBVapu+v0hMtt/owY6KG70Ws24yHsvLw3ReFrBJhBbLU+xlrW8TJ1CuRXXv87vjf
	 M6R8dzWKUYntw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D4F2837820F8;
	Tue,  9 Apr 2024 11:42:25 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 1/5] arm64: dts: mediatek: mt8395-nio-12l: Fix MT6360 regulator nodes names
Date: Tue,  9 Apr 2024 13:42:07 +0200
Message-ID: <20240409114211.310462-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409114211.310462-1-angelogioacchino.delregno@collabora.com>
References: <20240409114211.310462-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The regulators' node names for mt6360-regulator are supposed to be
uppercase. Also, drop "-regulator" from the usb-otg-vbus node name
to make all vregs to probe correctly.

The alternative would've been to use regulator-compatible, but that's
a deprecated property.
Now all regulators are probing fine.

Fixes: 96564b1e2ea4 ("arm64: dts: mediatek: Introduce the MT8395 Radxa NIO 12L board")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8395-radxa-nio-12l.dts | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index e5d9b671a405..18182cf073fb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -216,7 +216,7 @@ charger {
 			compatible = "mediatek,mt6360-chg";
 			richtek,vinovp-microvolt = <14500000>;
 
-			otg_vbus_regulator: usb-otg-vbus-regulator {
+			otg_vbus_regulator: usb-otg-vbus {
 				regulator-name = "usb-otg-vbus";
 				regulator-min-microvolt = <4425000>;
 				regulator-max-microvolt = <5825000>;
@@ -228,7 +228,7 @@ regulator {
 			LDO_VIN1-supply = <&vsys_buck>;
 			LDO_VIN3-supply = <&mt6360_buck2>;
 
-			mt6360_buck1: buck1 {
+			mt6360_buck1: BUCK1 {
 				regulator-name = "emi_vdd2";
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <1300000>;
@@ -238,7 +238,7 @@ MT6360_OPMODE_LP
 				regulator-always-on;
 			};
 
-			mt6360_buck2: buck2 {
+			mt6360_buck2: BUCK2 {
 				regulator-name = "emi_vddq";
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <1300000>;
@@ -248,7 +248,7 @@ MT6360_OPMODE_LP
 				regulator-always-on;
 			};
 
-			mt6360_ldo1: ldo1 {
+			mt6360_ldo1: LDO1 {
 				regulator-name = "ext_lcd_3v3";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
@@ -257,7 +257,7 @@ mt6360_ldo1: ldo1 {
 				regulator-always-on;
 			};
 
-			mt6360_ldo2: ldo2 {
+			mt6360_ldo2: LDO2 {
 				regulator-name = "panel1_p1v8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -265,7 +265,7 @@ mt6360_ldo2: ldo2 {
 							   MT6360_OPMODE_LP>;
 			};
 
-			mt6360_ldo3: ldo3 {
+			mt6360_ldo3: LDO3 {
 				regulator-name = "vmc_pmu";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3600000>;
@@ -273,7 +273,7 @@ mt6360_ldo3: ldo3 {
 							   MT6360_OPMODE_LP>;
 			};
 
-			mt6360_ldo5: ldo5 {
+			mt6360_ldo5: LDO5 {
 				regulator-name = "vmch_pmu";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
@@ -282,7 +282,7 @@ mt6360_ldo5: ldo5 {
 				regulator-always-on;
 			};
 
-			mt6360_ldo6: ldo6 {
+			mt6360_ldo6: LDO6 {
 				regulator-name = "mt6360_ldo6"; /* Test point */
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <2100000>;
@@ -290,7 +290,7 @@ mt6360_ldo6: ldo6 {
 							   MT6360_OPMODE_LP>;
 			};
 
-			mt6360_ldo7: ldo7 {
+			mt6360_ldo7: LDO7 {
 				regulator-name = "emi_vmddr_en";
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <2100000>;
-- 
2.44.0


