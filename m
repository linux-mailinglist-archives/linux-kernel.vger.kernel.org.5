Return-Path: <linux-kernel+bounces-125428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323BF8925D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E59E1F239E9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D36013D53E;
	Fri, 29 Mar 2024 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="n75yb7nR"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4B013AD1E;
	Fri, 29 Mar 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746306; cv=none; b=qIsA6lXUgqZJebWl/Gl4tlLxfvYekeJDzrNfk+b6fXnMkf1BHv+83TwSJAw03iBVty1kiRyscskrKmw0Y5EOPtdfKJg3mGmEXpRGOheaxFAUS16DC9HPlara+eJTc7+ifato3RR0ZVgo+thBBdCBf9j291RT1TToo/0bf44Q36g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746306; c=relaxed/simple;
	bh=pXYEYgKZ3Uofr33TNsjVz/KOqp3itzo08YoqXY3ebkI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrR6SxubRXkANAhxvgAyimc04nhqr/11+vqzbuTwMSkNwnN6wzAYactPH5zIs/RLVoHYhkZx1hz9C3PKKTn55nCvgqFxXX3x56z8MNV6rKZMCWy4temjgAGDldAuN57Tj7+T5O7/h8E3W3PdsZulLnTHFpO/oFw0GD13u1o1MPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=n75yb7nR; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2DA06120019;
	Sat, 30 Mar 2024 00:05:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2DA06120019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711746303;
	bh=v6iv2cWxrh0L5w2lrSwq07tbyW+/upAYliG0TyxpP3o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=n75yb7nRtRwdTAS4wjIRKlbscogi02NEL+0ey+lQnVTTtp+mOcfI6HrJoGn8lHuN2
	 A6YTD4LlJN8gBo18oOk8l+1ShZ+WMF4e2E2PwasVdNXcyNn3fS9Ildt3OhoJ990rkK
	 b4LlXrrGUxkyBj6llNF85gYS8YCdE0847XOfAjPs6DmOgAzlM1w1A741E2A1yPyKKv
	 4hKrdy9Ptcm28W5Y8OGQHNRU27BO8FKvCjhlHwqbnByq3myO4eK3g/n8bvCXZeCUHa
	 F/jr/rjzAbpXaBqaoMb1DBETLarMCkSG5+4QdGI71xh5Ru9NiZfzWoSHNDaBQY9956
	 /2LSX6gzbqK0Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 30 Mar 2024 00:05:02 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 30 Mar 2024 00:05:02 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v1 4/4] arm64: dts: amlogic: a1: setup CPU power management
Date: Sat, 30 Mar 2024 00:04:42 +0300
Message-ID: <20240329210453.27530-5-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329210453.27530-1-ddrokosov@salutedevices.com>
References: <20240329210453.27530-1-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184500 [Mar 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/29 16:52:00 #24511844
X-KSMG-AntiVirus-Status: Clean, skipped

The Amlogic A1 SoC family utilizes static operating points and a
PWM-controlled core voltage regulator, which is specific to the board.
As the main CPU clock input, the SoC uses CLKID_CPU_CLK from the CPU
clock controller, which can be inherited from the system PLL (syspll) or
a fixed CPU clock.

Currently, the stable operating points at all frequencies are set to
800mV. This value is obtained from the vendor setup of several A1
boards.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 0de809f4d42c..c57c7c1cd5f8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -33,6 +33,13 @@ cpu0: cpu@0 {
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&clkc_cpu CLKID_CPU_CLK>;
+			clock-names = "core_clk";
+			operating-points-v2 = <&cpu_opp_table0>;
+			voltage-tolerance = <0>;
+			clock-latency = <50000>;
+			capacity-dmips-mhz = <400>;
+			dynamic-power-coefficient = <80>;
 			#cooling-cells = <2>;
 		};
 
@@ -42,6 +49,13 @@ cpu1: cpu@1 {
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&clkc_cpu CLKID_CPU_CLK>;
+			clock-names = "core_clk";
+			operating-points-v2 = <&cpu_opp_table0>;
+			voltage-tolerance = <0>;
+			clock-latency = <50000>;
+			capacity-dmips-mhz = <400>;
+			dynamic-power-coefficient = <80>;
 			#cooling-cells = <2>;
 		};
 
@@ -52,6 +66,36 @@ l2: l2-cache0 {
 		};
 	};
 
+	cpu_opp_table0: cpu_opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <128000000>;
+			opp-microvolt = <800000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <256000000>;
+			opp-microvolt = <800000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <512000000>;
+			opp-microvolt = <800000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <768000000>;
+			opp-microvolt = <800000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <800000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <800000>;
+		};
+	};
+
 	efuse: efuse {
 		compatible = "amlogic,meson-gxbb-efuse";
 		clocks = <&clkc_periphs CLKID_OTP>;
-- 
2.43.0


