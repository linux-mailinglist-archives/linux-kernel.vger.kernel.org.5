Return-Path: <linux-kernel+bounces-87789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6186B86D912
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7255A1C21604
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6AB38385;
	Fri,  1 Mar 2024 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="l67SaZlz"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2C92E842
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257335; cv=none; b=MaSmRrcx/KebcdkD3NK0LZx5nMCAQ3NlaVqaLTb/Dg40tcqD6eGq5Y/gLx+McSFLuGTRaSMnQiioXc8JmLExjrtMZUsrvQ46ow/UKPHjhyVLolLFpbqMJFZ0WLpVDosGmv961br9KYDaP33CGqjyjNKQgqXAfQUuTVVa0sV+oV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257335; c=relaxed/simple;
	bh=mqJ/h7AKCJjaQlaxgMWt2R0Pal/NayZ3fO20oRdoXeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYdIRISShwObdn4hWEGl2UKx7AHRNC88jY7HWBe65ulTcBRCZqxoXVzzb/gmTn7OKij1tCp/9schtAMAyquoUI99aJ3XHxBc8DQyU4DLpjXn2ONjuTdJPAhUUyDmCukbddx0RFEDvmc9AHIBgRfdWVq6BAqRbLxgYXZiBgUg8Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=l67SaZlz; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4DC852C05E7;
	Fri,  1 Mar 2024 14:42:10 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709257330;
	bh=2OH3OgCTooM4dlx8pTy20vLATdgGUykmG4vimpbjzRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l67SaZlzE/pE9H68zgUNjYcx621jCphPo5OKM+07TZ4S8tEhsanBfIVODaMgfdTom
	 DCdFRTr0RGMvz4XgP8I7x38fHpSPgYsra51iFAneZSgFCkVWwpR5vmw4hrQ00hOw+g
	 IWVcf8RM3Z/vqCP5KRP90ax2xvhhLFkDSKc6BgG6p85GpIXjdJSlbwFCgAtAFQ49PO
	 7QQJgb9Y17CEtx+VQSEh3pmWatc5EhBK/WeTafgpmYMpJJe0tCx3d+/G4fXLmRAL3/
	 uaSKytU1i0VghXyRUEnJBGe32kHprkMRnI6tn8T8OodRlaGSVZ/TuPMjYUWnW+Umnq
	 uzoBUhZxlR+rQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65e132720003>; Fri, 01 Mar 2024 14:42:10 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 1974113EE4F;
	Fri,  1 Mar 2024 14:42:10 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 16C3D280062; Fri,  1 Mar 2024 14:42:10 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andy@kernel.org,
	geert@linux-m68k.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	pavel@ucw.cz,
	lee@kernel.org
Cc: linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 3/4] ARM: dts: marvell: Add 7-segment LED display on x530
Date: Fri,  1 Mar 2024 14:42:02 +1300
Message-ID: <20240301014203.2033844-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65e13272 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=ZwCSNx74X_mE_I29kl4A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The Allied Telesis x530 products have a 7-segment LED display which is
used for node identification when the devices are stacked. Represent
this as a generic-gpio-7seg device.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - Use compatible =3D "gpio-7-segment" as suggested by Rob
    Changes in v2:
    - Use compatible =3D "generic-gpio-7seg" to keep checkpatch.pl happy

 arch/arm/boot/dts/marvell/armada-385-atl-x530.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts b/arch/arm=
/boot/dts/marvell/armada-385-atl-x530.dts
index 5a9ab8410b7b..60c2abf572b6 100644
--- a/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
@@ -43,6 +43,17 @@ uart0: serial@12000 {
 			};
 		};
 	};
+
+	led-7seg {
+		compatible =3D "gpio-7-segment";
+		segment-gpios =3D <&led_7seg_gpio 0 GPIO_ACTIVE_LOW
+				 &led_7seg_gpio 1 GPIO_ACTIVE_LOW
+				 &led_7seg_gpio 2 GPIO_ACTIVE_LOW
+				 &led_7seg_gpio 3 GPIO_ACTIVE_LOW
+				 &led_7seg_gpio 4 GPIO_ACTIVE_LOW
+				 &led_7seg_gpio 5 GPIO_ACTIVE_LOW
+				 &led_7seg_gpio 6 GPIO_ACTIVE_LOW>;
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


