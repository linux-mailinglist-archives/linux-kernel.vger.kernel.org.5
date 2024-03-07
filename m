Return-Path: <linux-kernel+bounces-96134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4954B875784
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A8F1F22E13
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFCA1369BD;
	Thu,  7 Mar 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="eRn1cqgT"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A096E130AD0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841062; cv=none; b=BbLDMekkTIauCpgZw+6TfE0Dw2emKXIdIpvWF9w0Ch5XFumAZOi7iVRrS8uB+2Sp2Do0wJYpRC0iijckGo/9kxK5FAL4d9cHmhVVOE4YuZ7Y/YB3diS4vswXvcI3G2e63J0GtfIOJ3V85JtLqZxMCb975OkS0s692rkAzj2DixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841062; c=relaxed/simple;
	bh=Fub+Qf4fF34mx+5PYfabuIQTPYpAjthBJi2cEhUl+7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smZ6bmDdsM8+NwRcb3CwegdgoRAcHAuvFsdj3vs6qoc9gnv/Nofxp6zSb6l2a7ZAD2U+dDvVL6P1AhCBqIXBbE8vNnmoqRf3dOSrS73LWd3A73swu5miKm9DLAJ7A7eZBzJsFaFe3F4LiBwTL1e+6aUCTJICNp+vLBPxw1Cww2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=eRn1cqgT; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2D9E92C02B2;
	Fri,  8 Mar 2024 08:50:56 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709841056;
	bh=f2EpxCUQwV9BoS1rC4W6zzuOSyxVkf/IGbDuI2bHh2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRn1cqgTNoA0J476R98zDq/U97hHkApSfDVPy7DUjkf77kTjQW7EbD7/aWmGMgGWd
	 7BG3zGGjZYeyReMqG1h9K/+cXiURaDM8y22US/S0M6Mefcb7Qpqhcgv6pNtUMu2zCP
	 EhTZygyPuvVaHRgBr+y8T8OXbaijjAHdgPU4QF4ndX8hyvb7PqPvs4KhParHEunCIQ
	 M2k9fnzii2zAJPh9Thct/XT4//E4lFDr5gAER/G1sf5QUd//kl1vOYCBQDtzFppsvR
	 /ChxRJhcwAlYHvMTwvS9xYEMXvSAgzEzuZ7P5nIgGx90vuU8boW8MPoDfs1O8VP2oD
	 O5y8qBnfuRmig==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65ea1a9f0004>; Fri, 08 Mar 2024 08:50:55 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id C917913EE8E;
	Fri,  8 Mar 2024 08:50:55 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id C3D572808A5; Fri,  8 Mar 2024 08:50:55 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andy@kernel.org,
	geert@linux-m68k.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	lee@kernel.org
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v6 3/3] ARM: dts: marvell: Add 7-segment LED display on x530
Date: Fri,  8 Mar 2024 08:50:53 +1300
Message-ID: <20240307195053.1320538-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307195053.1320538-1-chris.packham@alliedtelesis.co.nz>
References: <20240307195053.1320538-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65ea1a9f a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=Eze4_Z_RUzIZFoL9sA8A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The Allied Telesis x530 products have a 7-segment LED display which is
used for node identification when the devices are stacked. Represent
this as a gpio-7-segment device.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v6:
    - None
    Changes in v5:
    - group GPIO specifiers
    Changes in v4:
    - Use correct compatible name in commit message
    Changes in v3:
    - Use compatible =3D "gpio-7-segment" as suggested by Rob
    Changes in v2:
    - Use compatible =3D "generic-gpio-7seg" to keep checkpatch.pl happy

 arch/arm/boot/dts/marvell/armada-385-atl-x530.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts b/arch/arm=
/boot/dts/marvell/armada-385-atl-x530.dts
index 5a9ab8410b7b..2fb7304039be 100644
--- a/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
@@ -43,6 +43,17 @@ uart0: serial@12000 {
 			};
 		};
 	};
+
+	led-7seg {
+		compatible =3D "gpio-7-segment";
+		segment-gpios =3D <&led_7seg_gpio 0 GPIO_ACTIVE_LOW>,
+				<&led_7seg_gpio 1 GPIO_ACTIVE_LOW>,
+				<&led_7seg_gpio 2 GPIO_ACTIVE_LOW>,
+				<&led_7seg_gpio 3 GPIO_ACTIVE_LOW>,
+				<&led_7seg_gpio 4 GPIO_ACTIVE_LOW>,
+				<&led_7seg_gpio 5 GPIO_ACTIVE_LOW>,
+				<&led_7seg_gpio 6 GPIO_ACTIVE_LOW>;
+	};
 };
=20
 &pciec {
@@ -149,7 +160,7 @@ i2c@3 {
 			#size-cells =3D <0>;
 			reg =3D <3>;
=20
-			gpio@20 {
+			led_7seg_gpio: gpio@20 {
 				compatible =3D "nxp,pca9554";
 				gpio-controller;
 				#gpio-cells =3D <2>;
--=20
2.43.2


