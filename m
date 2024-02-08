Return-Path: <linux-kernel+bounces-58870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8741D84EDE3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FF91F23F59
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE1856464;
	Thu,  8 Feb 2024 23:25:15 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6270555E6C;
	Thu,  8 Feb 2024 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434715; cv=none; b=l/wqy7PxBvxJb8elSVjUwo074hA/1M8JH6QXAfcKCkdGH/SE2TxOE51kYmqTShOmnnkY3WAVKis4IcNQHI7QKh4eAplP5CjvHRM+SIKS8DPG/Pg5IpNpvgowWq+Y3zMWctj0hj96sKOb4v0wkK4+LCjDRgfoe1vHVEpF8RtxvhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434715; c=relaxed/simple;
	bh=syoVVf9VMb64NoUsLBQVCQqnSHZWsX5SLQZaMft+iQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MnXd4alCZvbvsrDTMHEajxkKXS8JAXISYCWccdtQ0n0iT8sbzCy/rxvesV73Nhp4MDxLY4+aS+7aVAPOw4vGhRyJWwMKIlbMY4GSfhCIebir61mSsDGO5Tysetha0nzZaL7t0UCBA9etOv2Bvw8ltt7EiOc0PNjgU4eA8no4GtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.05,255,1701097200"; 
   d="scan'208";a="193379771"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 09 Feb 2024 08:25:08 +0900
Received: from mulinux.home (unknown [10.226.92.227])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 130E04009BDC;
	Fri,  9 Feb 2024 08:25:04 +0900 (JST)
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
Subject: [PATCH v6 4/4] arm64: dts: renesas: rzv2m evk: Enable pwm
Date: Thu,  8 Feb 2024 23:24:11 +0000
Message-Id: <20240208232411.316936-5-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208232411.316936-1-fabrizio.castro.jz@renesas.com>
References: <20240208232411.316936-1-fabrizio.castro.jz@renesas.com>
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


