Return-Path: <linux-kernel+bounces-62367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EC9851F30
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CAF1F22C71
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7374C61D;
	Mon, 12 Feb 2024 21:07:22 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC384D9E8;
	Mon, 12 Feb 2024 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772041; cv=none; b=R4vtUlc0txeBsx2iH7wbw2k4Rhx50O8bcOASV4D30JHY9bkI7maIjDQvifAFsYm2leSbQ/lvlUqc8E0cjX/eODG1/jQZ1PqZqweRjXivIt5ImP6anfwyzrJj2Hzb2NeYFAZWrwri7h16rOVWj5WA4SFdQAZddypwYSA5xncyENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772041; c=relaxed/simple;
	bh=6uO8+5f0HuUGMhLDr4KYd9xN8pPGpxbc7PKeC1VVNfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CVKSq44OUglfHevKrkRGVNnT9oyq6R49gnWGYv00KWxXp+C3NpG4K3Ay/7ehUUzYn5EN5yLPyfmcFvGPmxfC7AGN6xfpA0DfuJ845pWamH38skvxPTT2Jho15BN57DUDocmqaTt3Gcy0ggSepksDvkSEfSnEGXI/W/JIRTHszzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.06,155,1705330800"; 
   d="scan'208";a="193681651"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 13 Feb 2024 06:07:18 +0900
Received: from mulinux.home (unknown [10.226.93.37])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 439214006DEF;
	Tue, 13 Feb 2024 06:07:14 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH v7 4/4] arm64: dts: renesas: rzv2m evk: Enable pwm
Date: Mon, 12 Feb 2024 21:06:52 +0000
Message-Id: <20240212210652.368680-5-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212210652.368680-1-fabrizio.castro.jz@renesas.com>
References: <20240212210652.368680-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Enable pwm{8..14} on RZ/V2M EVK.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

v6->v7:
 * No change.
v5->v6:
 * No change.
v4->v5:
 * No change
v3->v4:
 * No change
v2->v3:
 * Added Rb tag from Geert.
v1->v2:
 * No change

 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
index 39fe3f94991e..6e636ac2d190 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
@@ -196,6 +196,34 @@ i2c2_pins: i2c2 {
 			 <RZV2M_PORT_PINMUX(3, 9, 2)>; /* SCL */
 	};
 
+	pwm8_pins: pwm8 {
+		pinmux = <RZV2M_PORT_PINMUX(1, 8, 1)>;  /* PM8 */
+	};
+
+	pwm9_pins: pwm9 {
+		pinmux = <RZV2M_PORT_PINMUX(1, 9, 1)>;  /* PM9 */
+	};
+
+	pwm10_pins: pwm10 {
+		pinmux = <RZV2M_PORT_PINMUX(1, 10, 1)>; /* PM10 */
+	};
+
+	pwm11_pins: pwm11 {
+		pinmux = <RZV2M_PORT_PINMUX(1, 11, 1)>; /* PM11 */
+	};
+
+	pwm12_pins: pwm12 {
+		pinmux = <RZV2M_PORT_PINMUX(1, 12, 1)>; /* PM12 */
+	};
+
+	pwm13_pins: pwm13 {
+		pinmux = <RZV2M_PORT_PINMUX(1, 13, 1)>; /* PM13 */
+	};
+
+	pwm14_pins: pwm14 {
+		pinmux = <RZV2M_PORT_PINMUX(1, 14, 1)>; /* PM14 */
+	};
+
 	sdhi0_pins: sd0 {
 		data {
 			pinmux = <RZV2M_PORT_PINMUX(8, 2, 1)>, /* SD0DAT0 */
@@ -251,6 +279,48 @@ &pwc {
 	status = "okay";
 };
 
+&pwm8 {
+	pinctrl-0 = <&pwm8_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pwm9 {
+	pinctrl-0 = <&pwm9_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pwm10 {
+	pinctrl-0 = <&pwm10_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pwm11 {
+	pinctrl-0 = <&pwm11_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pwm12 {
+	pinctrl-0 = <&pwm12_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pwm13 {
+	pinctrl-0 = <&pwm13_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pwm14 {
+	pinctrl-0 = <&pwm14_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-1 = <&sdhi0_pins_uhs>;
-- 
2.34.1


