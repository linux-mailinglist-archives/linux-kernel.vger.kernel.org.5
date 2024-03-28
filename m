Return-Path: <linux-kernel+bounces-123478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C96589093B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7321C246AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653C51386DC;
	Thu, 28 Mar 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="cpxwPgHY"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D15FBA7;
	Thu, 28 Mar 2024 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654018; cv=none; b=Go2Lt297Jl2Ex2+mhD+QKt6oGTWjzIRk+TxNJv0E6ZHFixmqKZc1hNZGvRTE2oF/z2XYUPA5epegKhT4vnniJdm1VB9658OI5z58QSvmxew6Qwt113kzRAsyj5w+RrFafzlMmVv9QuvpYZHAs3qIDLD8s3ZYLDjQk5mes0XqBXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654018; c=relaxed/simple;
	bh=O/zPJqMScFyr+uUwH1taZvk6WHHMRgUrwtRRh43jXxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPF/r4dQwAEdRz2xKTrVE3y27c1KFhUyBLEvQ7rB18tBu1ibhKaRTsgMA16AVI0JH8Xi3qHavhNgkDSlrj/a90BRbTF7CtkxazwVy9hKcpK9ofSZO481ZvUpHb7KdseZZKJN96rmA72AhMChcJvv15qSZzyjIonH0AZV52AaBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=cpxwPgHY; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9258410000C;
	Thu, 28 Mar 2024 22:26:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9258410000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711654014;
	bh=kNqCEs4ZMc5QNb0vP9PAlmbeoSILx0x0jZh1NRLUS7c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=cpxwPgHYtNqHTry/vsYoLZUEwq6k62ZufdTz7TSsY/BRKKxHUxPiVeLzQV40G8Dgv
	 XfrTjUI1imU42jDumllpov7dOa7Bzs/gzWG21rKCrlT13+44hX66Zja+REP/1U5U7f
	 CW1Wa6nn6gXB4po/0M3c1Ek3cgi+/0C1cRStpY1vpUp/VIQQP8jd6hpueAR9dQYH04
	 Cc8//+NPPoqfmByaYHorSVnpzUV2yOlI19HLyT+PCi5YonEEw70HAwyjHZMGentPwc
	 dghg61dvgc8cuUeky6JHiBMSoz600snMD9+ZQXGknsdzHVspdoCwRKxPvAsxU6EeY5
	 xd6jcFTxz/7Ow==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 28 Mar 2024 22:26:54 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 22:26:53 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <glaroque@baylibre.com>,
	<rafael@kernel.org>, <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
	<lukasz.luba@arm.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v2 2/3] arm64: dts: amlogic: a1: introduce cpu temperature sensor
Date: Thu, 28 Mar 2024 22:26:36 +0300
Message-ID: <20240328192645.20914-3-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328192645.20914-1-ddrokosov@salutedevices.com>
References: <20240328192645.20914-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184477 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/28 18:13:00 #24496606
X-KSMG-AntiVirus-Status: Clean, skipped

The A1 SoC family has only one thermal sensor for CPU temperature
measurement. It is required to set the TS clock rate to 500kHz to make
it workable.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index f65d4a77ee52..de77eb53d1dc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -854,6 +854,17 @@ usb2_phy1: phy@4000 {
 				power-domains = <&pwrc PWRC_USB_ID>;
 			};
 
+			cpu_temp: temperature-sensor@4c00 {
+				compatible = "amlogic,a1-cpu-thermal";
+				reg = <0x0 0x4c00 0x0 0x50>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc_periphs CLKID_TS>;
+				assigned-clocks = <&clkc_periphs CLKID_TS>;
+				assigned-clock-rates = <500000>;
+				#thermal-sensor-cells = <0>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
 			hwrng: rng@5118 {
 				compatible = "amlogic,meson-rng";
 				reg = <0x0 0x5118 0x0 0x4>;
-- 
2.43.0


