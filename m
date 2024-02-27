Return-Path: <linux-kernel+bounces-84028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFAE86A18F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8931F282D5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421E31509BA;
	Tue, 27 Feb 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="rgEa11Ft"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7D314F96A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068972; cv=none; b=TfJ9dFv4Qvq0/33KQG29ajHavAwJChrc7fGW0fH6DSwMznkhyTnojGzHafoVaFjASqUoXMCPKw5hhZCZPN/PzJU5lUH/RZiXBSb/xLFYVOvYi+a4MsFgoVOvdD6EsbvjUI4bS33xaRHOLfgC9NiKFQUt/n2FAq8PpthMHiVyHVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068972; c=relaxed/simple;
	bh=Gnh3JrvCtbi+RZ0t2Ao7E//MKtGp49YaGLcT5DciouM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FryWVUIiUF8bfaU35HMQGbk4z0AxT3C0RnNzLHZG4oGE7cCw5UO3FGaKwakD5zlL9P+JHd5nWgqIKpXixvtTMUxJr41U/1U9D3ZV+WVaHKWefSQXK/KQalDUDbEuOmA0nTo5/A7JNtG2gMBVK34MspUCJPAqpcLEpNjWYNfhOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=rgEa11Ft; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C222F2C03C7;
	Wed, 28 Feb 2024 10:22:46 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709068966;
	bh=2s9FjwQ0X7gd+sc4hj1WiFxP/hCuXY9HchgOBuvK4lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgEa11Ftr7fgvz9hYjHPOASvy38xJ/ROkDCEO4Z0Nfqz29hujzLrwjx2M8jLH7OG4
	 8lcu3zNEUH8MKvauWk4CblJgab/tW7/nmZ0eGw4tsZcLuRV+pyl2TsR7gtAdOn9aKo
	 sWHO6r+yLmu1VkzCS/QTno3DI812xSEbzpYal0Mth4Plxg2uWYwAU4hwRtTozP5XGR
	 MQJ48AFgb6fnvtoSkac8bVlmBa7zzlotAQCloWpGiuAyrvKcC7IPsYw8/Eenbmi+wg
	 gPbmWxqQVqPI8hC19cKGqqApsvPrv5atiEFxdDCXObosVqTD0ytorXG1dg/Fn/7JAk
	 Ez7S1LpwWY5dQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65de52a60003>; Wed, 28 Feb 2024 10:22:46 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 6940813EE8E;
	Wed, 28 Feb 2024 10:22:46 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 67145280AFE; Wed, 28 Feb 2024 10:22:46 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andy@kernel.org,
	geert@linux-m68k.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	ojeda@kernel.org,
	tzimmermann@suse.de,
	javierm@redhat.com,
	robin@protonic.nl,
	lee@kernel.org,
	pavel@ucw.cz
Cc: devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 3/4] ARM: dts: marvell: Add 7 segment LED display on x530
Date: Wed, 28 Feb 2024 10:22:43 +1300
Message-ID: <20240227212244.262710-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65de52a6 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=k7vzHIieQBIA:10 a=75wrGpN2Od3tzqupbDsA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The Allied Telesis x530 products have a 7 segment LED display which is
used for node identification when the devices are stacked. Represent
this as a gpio-7seg device.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - Use compatible =3D "generic-gpio=3D7seg" to keep checkpatch.pl happ=
y

 arch/arm/boot/dts/marvell/armada-385-atl-x530.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts b/arch/arm=
/boot/dts/marvell/armada-385-atl-x530.dts
index 5a9ab8410b7b..f55a3dc6b6de 100644
--- a/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
@@ -43,6 +43,17 @@ uart0: serial@12000 {
 			};
 		};
 	};
+
+	led-7seg {
+		compatible =3D "generic-gpio-7seg";
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


