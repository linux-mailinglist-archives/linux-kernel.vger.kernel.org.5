Return-Path: <linux-kernel+bounces-125426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3AB8925CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7491C21749
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BA713C9D1;
	Fri, 29 Mar 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="PcrQbv2+"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930B3BB2A;
	Fri, 29 Mar 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746305; cv=none; b=CV51qMf27xEKcu/ieYBL5HHxKt5WVPKSl/XGlzjjh+D7VhtOz+Zd30PdTIVsjEYfnyVi/8/FsSMx7B8PMjI++TteklTj2ff9SL6GHpCYeqkW0tB/D56E7LttDdkwzR4EyMAFKmD2h1NDajQ5CM68Mc/MSwqrYafzB2doy52eqeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746305; c=relaxed/simple;
	bh=8rRcO2tlRpuO4+Z1Y75YuBrVkBUFKWAUea4mZefG2Qg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sli/iDZAXzVx8ZC5O7orYC5EbO3Qqd5tQvzxBTfERMCE6MEv9i4XDtMDvPJJ71qe+oKxZ4AAV1DghyZ/ZNlvY4RvAPq3XOeV3ZjDciiPTsHNt1OM8O/A53xy66qTPsKYUQJCLRMpYmZA8UVgP/PUP3TZrOXuHtXi94vUwWfEBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=PcrQbv2+; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9FEB4120018;
	Sat, 30 Mar 2024 00:05:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9FEB4120018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711746301;
	bh=TBUJfg5IMWeRuk8vm7T0kAE8raYv0qxt4befaq85+wU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=PcrQbv2+Ou3IIPD064exFt0Z2wW3yxWKXzW28H70JfvdX1jjz6XAH57I+e4XXOEoB
	 fMuBvpstsfJOXKRtYmyIScMWTPI2P8odPBM1kCwH9dIgoGNskDT5ZqOdQqTsnPYbS1
	 /Ch/zkiLNt9LwiG2fMpLCmGMpsxnVTwaX11XCP9MITq/ST78rW11Z350k93v/zpHez
	 wLPqdbYGdD2rwWH8aDMsDr+adCjA6doePbRTPiWXbdVOOKr33FhzlDHLYb0uopkMjB
	 md05pfaC1DpDRkQfRZQ+aWmJWRyvrW+nAimTtBH55IBNp6UgR2ofEgKM6h4Hr9Kg0U
	 xFG0hI6viDKXQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 30 Mar 2024 00:05:01 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 30 Mar 2024 00:05:01 +0300
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
Subject: [PATCH v1 2/4] arm64: dts: amlogic: a1: declare cpu clock controller
Date: Sat, 30 Mar 2024 00:04:40 +0300
Message-ID: <20240329210453.27530-3-ddrokosov@salutedevices.com>
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

The Amlogic A1 SoC family relies on the CPU clock controller to generate
CPU clocks, serving a crucial function. It has 4 inputs: main
oscillator, fixed clocks and system pll.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 8ae944bfeee4..07fd0be828d4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
  */
 
+#include <dt-bindings/clock/amlogic,a1-cpu-clkc.h>
 #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
 #include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
 #include <dt-bindings/clock/amlogic,a1-audio-clkc.h>
@@ -94,6 +95,19 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
+		clkc_cpu: clock-controller@fd000000 {
+			compatible = "amlogic,a1-cpu-clkc";
+			reg = <0 0xfd000000 0 0x88>;
+			#clock-cells = <1>;
+
+			clocks = <&clkc_pll CLKID_FCLK_DIV2>,
+				 <&clkc_pll CLKID_FCLK_DIV3>,
+				 <&clkc_pll CLKID_SYS_PLL>,
+				 <&xtal>;
+			clock-names = "fclk_div2", "fclk_div3",
+				      "sys_pll", "xtal";
+		};
+
 		spifc: spi@fd000400 {
 			compatible = "amlogic,a1-spifc";
 			reg = <0x0 0xfd000400 0x0 0x290>;
-- 
2.43.0


