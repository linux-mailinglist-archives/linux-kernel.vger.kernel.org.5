Return-Path: <linux-kernel+bounces-122987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18268900B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410B71F2642F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE2584FDA;
	Thu, 28 Mar 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Go1erYTu"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E080639;
	Thu, 28 Mar 2024 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633514; cv=none; b=IRkG7wz/VVB9HZUfShE+mGyrL49qQc4BMNmINq6RdlQDhdF/18eKZavu8NAvNZ8Ns3t7IZVmjxL25beKCZarj3vJVPTy5EQvqvhaBeaYqc4YyJmeVci2WH3ieOKszkIRWwSsNa1ym4FpkP/17DBmkMhLrLFz/ODO4DkxxYlaMiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633514; c=relaxed/simple;
	bh=vwSFSGR9bfNDcThzkOUIaAgtD60B7Pss7f2WlcQz124=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRoaZCUZmVRkYq7y7j9f6K+T97BU6T+zfXckZ646jdX3quOmJBAkdpeb03RkRYaWvNVhbAPn4mMwltcd1RftQ6ATuz6oJPTH+rTpRRkiitZmFjzk49aQWRwcsAZvuzzOYLJP+1mQlSJVHHzeQAc+cTob4OcACSm8NDLF4+KJIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Go1erYTu; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id DEACD120016;
	Thu, 28 Mar 2024 16:45:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DEACD120016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711633510;
	bh=9CPwvn2kpzZJnAOi5N/hirprKnzIWIB81uV2cDqMcbY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Go1erYTunGWvX7kXxUqgYWpokLxLg2Tn8v944gydddoaNTsIwlux/pfO3yf2jM6G8
	 f0szahcr3BbVsjl4colW11N77vk4J08U8ZCJJ2KQ9/pnpRv781I4iH511Nvgr75Qtx
	 CPvbAKlfdlrwQYUVkRdm2qquXjc5ialGip84yKm9+QL5UBTL0KJScZHM2zzWv4nc02
	 CzjzMRfWlF+2w1HUDy+tEAAklu34YVcUlv1tVQS1HwsrpL4tkiyraaiH0xorb/f847
	 scbGmi7MNCvB16CPhmHoP10yiUPiGBLS5BtbOV8rKG3C8oF780j0uT0DcJXX8NxJYr
	 IY65bM50ih6rg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 28 Mar 2024 16:45:10 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 16:45:10 +0300
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
Subject: [PATCH v1 3/3] arm64: dts: amlogic: ad402: setup thermal-zones
Date: Thu, 28 Mar 2024 16:44:39 +0300
Message-ID: <20240328134459.18446-4-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328134459.18446-1-ddrokosov@salutedevices.com>
References: <20240328134459.18446-1-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184470 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/28 10:33:00 #24492761
X-KSMG-AntiVirus-Status: Clean, skipped

There is one thermal zone with 3 trip points: soc_passive, soc_hot, and
soc_critical, as well as two cooling maps.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 .../arm64/boot/dts/amlogic/meson-a1-ad402.dts | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts b/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
index 6c02301840ff..2d22e8b45c6d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "meson-a1.dtsi"
+#include <dt-bindings/thermal/thermal.h>
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -177,6 +178,50 @@ codec {
 			};
 		};
 	};
+
+	thermal-zones {
+		soc_thermal: soc_thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			sustainable-power = <130>;
+
+			thermal-sensors = <&cpu_temp>;
+
+			trips {
+				soc_passive: soc-passive {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				soc_hot: soc-hot {
+					temperature = <85000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				soc_critical: soc-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			soc_cooling_maps: cooling-maps {
+				map0 {
+					trip = <&soc_passive>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&soc_hot>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
 };
 
 /* Bluetooth HCI H4 */
-- 
2.43.0


