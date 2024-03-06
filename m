Return-Path: <linux-kernel+bounces-94750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4987D8744BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8881F23E98
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F55B1F934;
	Wed,  6 Mar 2024 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="pKRsTPww"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8E01CA9F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769037; cv=none; b=Rp/hVNsBMq7vI/yOgDiYJsWavMrL+OXzBECgdlkSP+YLKLqEtuVwUWJRcgawPzpCTsQvSFPt3tW6ISL5g6eacxvh/XshJv4GdBUIVmkumSGRmcHCPOPmjfUmlK55jeBeU5aniDGyfrcMLuQUT4fjAmAMQQiN7qIvRWYvnOARbI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769037; c=relaxed/simple;
	bh=U+D/K8p4oppEdsGsoshGKHE1AK3NIrOT3Q8TDbUIqts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4M4yEM5kThAReJNsqq6q7jPjr43NswcFrkzh7O/bC7GDfY0s6n7DqDlzd5pqQf0h6+79IPtwpeNIbVl2UPzV1hf+vm2INQK0CME4MWyuUFztX7UqQ2ZN108MMOtjt6Nsxd/8sXuKlU7Xnqx8gPbgrznDwM4aGdLyNWrcqqp9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=pKRsTPww; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D3EEB2C02A7;
	Thu,  7 Mar 2024 12:50:25 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709769025;
	bh=hEo6KY4W7nBtXqY6R2q5MzGe77wJMePNpigq9T0aJNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKRsTPww1ig7X3A3xybGBb8ThKNywhmJG3Id8AYlCo1RI48WusHqiPauBUWy9k4hQ
	 dnKukgmXlQUApW6+O0cma2s0bFG0wAByeu8PgJajcpmVJT+N5GS2GLn4FY1LBMz4cI
	 QrLL6W2jH5THvt+x0sKGxHn4bo0iLEIXOLWbbng8Gx7AKB1EYQB48Ky9TAGoE/klwj
	 BXcuwSpVL9e059w+7w6rZmaJGV81uCTCXLwdVtCrupF/qUcBYHWtX5NMNA4+ckrIFp
	 J1plG3bhFaAQHuURmI6nzrs0jOBgZPdDQgGtzT7nH2pgpQRWKpLc9/S8OTXLu0ZoN8
	 A0KV/ere64gLQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65e901410003>; Thu, 07 Mar 2024 12:50:25 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 8A33513EE8E;
	Thu,  7 Mar 2024 12:50:25 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 873F1280B6D; Thu,  7 Mar 2024 12:50:25 +1300 (NZDT)
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
Subject: [PATCH v5 3/3] ARM: dts: marvell: Add 7-segment LED display on x530
Date: Thu,  7 Mar 2024 12:50:21 +1300
Message-ID: <20240306235021.976083-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
References: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65e90141 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=Eze4_Z_RUzIZFoL9sA8A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The Allied Telesis x530 products have a 7-segment LED display which is
used for node identification when the devices are stacked. Represent
this as a gpio-7-segment device.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
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


