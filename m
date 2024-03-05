Return-Path: <linux-kernel+bounces-91635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 649B9871479
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21459283DF3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386073CF4B;
	Tue,  5 Mar 2024 03:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="JZ+sQf8I"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A6F405DC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709611142; cv=none; b=Apa8xRCbwPQumJJpwvq6/x9KbZ5RVIag/i5Tk95+gqiN7sH6p3mN0POcDmmmdizovgDWF832QQb8zuc8tbgE409tLPRkZYJWj31bNofk1KZFlgSjA0fl6W5dzcex3k9pjUoyZzntSGQPbDzEzWpOKV3zNABEPBl+80nnijCw4jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709611142; c=relaxed/simple;
	bh=+cOgSZtXjjMtnKVw1LPuAiZ6Mn8UevCnRyLJXg+DB5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkRd5Lq+hbtxAmQl2MwD9bqPVcnjTNPA74eExNBMv77o0esUYJaJC4kqGIqyqpoEyFPkMBvDJRU/UgOzSaelK5R9GKiC6Gny6MPmXEFDH1aRXd0c4pcGmPz+lkxw3TUyxndV9Eo7YCzOG+/ZrIMNKQUJ0AvPaOw9ExhmCOvQuZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=JZ+sQf8I; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EBFB12C0191;
	Tue,  5 Mar 2024 16:58:57 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709611137;
	bh=jv/qZKUBNtFx0wjDYe7udNJ1VJ7C8qUMETi24rpmi5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZ+sQf8IkMImYFNUjBSxpyFSJcv5YsSMABU8wqRukBTLo+A6R0N1YlLEzmIxXMH+w
	 ibkIgUjRV9QwgjlrZ9kce/UECwwt6pz9X7GZsbaPu1wcPBLa49r+c+3G9VhkfJ77Q8
	 uHeyQqJMoW/qmILnVhpChGuYmNMocXQcbHgOIyy16vRkZnz12RHIve3Go6mBVFaheS
	 ktLaXlxNPOUCbuetk0L/UMWh1g2xsMvLpgvbTXEfttv+aCl5J0LQb53akg3okF5i28
	 OVhzlw6YPRcO47qHgM1I2vkPRNRzzzaQKdLjtWBMcPlE6iqoBFQLyZ518SK66ik7DM
	 +U1FEKQQta5zw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65e698810003>; Tue, 05 Mar 2024 16:58:57 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id B376513EE85;
	Tue,  5 Mar 2024 16:58:57 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id AFB3728084D; Tue,  5 Mar 2024 16:58:57 +1300 (NZDT)
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
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-leds@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 3/3] ARM: dts: marvell: Add 7-segment LED display on x530
Date: Tue,  5 Mar 2024 16:58:52 +1300
Message-ID: <20240305035853.916430-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240305035853.916430-1-chris.packham@alliedtelesis.co.nz>
References: <20240305035853.916430-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65e69881 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=Eze4_Z_RUzIZFoL9sA8A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The Allied Telesis x530 products have a 7-segment LED display which is
used for node identification when the devices are stacked. Represent
this as a gpio-7-segment device.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
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


