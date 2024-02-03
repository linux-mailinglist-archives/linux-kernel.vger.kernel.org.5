Return-Path: <linux-kernel+bounces-51260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F269848867
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE69282637
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07906086E;
	Sat,  3 Feb 2024 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="RbjIWUwX"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DAA5F554
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706987551; cv=none; b=GYtBgBOccShbxH/VaEtN9V3+XXLW9mxwqui8TR74ulfVbLdqaqrT5hvchc1Hv4efaBn2G6Y+99pVjKrK8dFPMLYh4X9gmdIlnQhi4vPvW3+6FDTC0By5al7GNZg/YhzjbxQMvbuKc/acIKnSdnumWrYgU1KQIQmMNtRUhGkXJ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706987551; c=relaxed/simple;
	bh=Kyg5hCGVIsasfn2sYOZ2Upwno/GNqXDiIQfjVDfxKzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFpTgVHGkYZX82ODZgSaAu3ee64fRiX2nNjl5IGE35J+ZjVotgJCVgaz3/qP2d1jEjiL3p1bTr4ePRBUHOQyAAQwUDVa+PWU/U2oUBZN6In+7SrOgWAERSGYOhpFMOhQh5noOEgSqbbaNHYBT9zYpZ1O2iEuArWIV/G4VBJoKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=RbjIWUwX; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1706987548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYHXn/FsWUe2ytcr0pi3c4QgJvZ4Eb2tVvL9ad3fkVg=;
	b=RbjIWUwXmQ9KchClb5AWuFa2usojLqz8Bv+i2risRZblgtQW+0z4oIfe6f0rb5VhoY6d7G
	IPQTzKnoT957/z2cORub5Fcv4RXTT8xXEn4JsZGFC496CS5DxrTBiAAxSjrlK8vKmVuhHr
	9ofvbkgDweD4oqZ0JZqCyC4yz0KAuPVmmeMkQkCXNiWqmfwDnPu8ApHEpzxO822WuyubVe
	Dt6duOZd5Xcs+vjzwyUfOXhpYmOdAAqnyjihds0LTJ8itLWvIkgpvNXsANs1Bq8CjPLdni
	BL4jvQ9cZCbBAEfCn6UaONbi+PI3DjyrS6XOksBchN/ul2yE4NAR61CNrChlnw==
From: Anton Bambura <jenneron@postmarketos.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] arm64: dts: qcom: sc8180x-lenovo-flex-5g: enable touchscreen
Date: Sat,  3 Feb 2024 21:11:58 +0200
Message-ID: <20240203191200.99185-5-jenneron@postmarketos.org>
In-Reply-To: <20240203191200.99185-1-jenneron@postmarketos.org>
References: <20240203191200.99185-1-jenneron@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Set regulators, reset gpio and delays according to ACPI tables.

Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
---
 .../boot/dts/qcom/sc8180x-lenovo-flex-5g.dts  | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index 6ae6cb030b70..5bf6285f905f 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -271,6 +271,12 @@ vreg_l3c_1p2: ldo3 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l4c_3p3: ldo4 {
+			regulator-min-microvolt = <3296000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l10c_3p3: ldo10 {
 			regulator-min-microvolt = <3000000>;
 			regulator-max-microvolt = <3312000>;
@@ -337,6 +343,12 @@ vreg_l10e_2p9: ldo10 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l12e_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l16e_3p0: ldo16 {
 			regulator-min-microvolt = <3072000>;
 			regulator-max-microvolt = <3072000>;
@@ -365,11 +377,19 @@ &i2c1 {
 	touchscreen@10 {
 		compatible = "hid-over-i2c";
 		reg = <0x10>;
+
 		hid-descr-addr = <0x1>;
+		reset-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
+
+		vdd-supply = <&vreg_l4c_3p3>;
+		vddl-supply = <&vreg_l12e_1p8>;
+
+		post-power-on-delay-ms = <3>;
+		post-reset-deassert-delay-ms = <200>;
 
 		interrupts-extended = <&tlmm 122 IRQ_TYPE_LEVEL_LOW>;
 
-		pinctrl-0 = <&ts_int_default>;
+		pinctrl-0 = <&ts_int_default>, <&ts_reset_default>;
 		pinctrl-names = "default";
 	};
 };
@@ -735,6 +755,14 @@ ts_int_default: ts-int-default-state {
 		drive-strength = <2>;
 	};
 
+	ts_reset_default: ts-reset-default-state {
+		pins = "gpio54";
+		function = "gpio";
+
+		bias-disable;
+		drive-strength = <16>;
+	};
+
 	usbprim_sbu_default: usbprim-sbu-state {
 		oe-n-pins {
 			pins = "gpio152";
-- 
2.42.0


