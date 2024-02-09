Return-Path: <linux-kernel+bounces-60029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5202184FEDC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E70E7B255B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FB1210FA;
	Fri,  9 Feb 2024 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="KU20LfmD"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131B63B8;
	Fri,  9 Feb 2024 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514117; cv=none; b=ADnrC6ABTWcLNoBjAOpyV2GNECYm+HiQ58+g37EYV4iQs0bJ6O/ZT9peDgD0PfQgWXmhak0X55z+L6SbgUl4kZlJUd0iFbAGnbmlDY15mZBE4mGQxUPPpS/TO+EhRnZDeVcymoNF+/TugdEdOp/5TtcxoIqBi4TJbXeWL1ybST8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514117; c=relaxed/simple;
	bh=Sg6ty5lFgb0E8wyNFf6Q/fJgsvPT+sUgeeRN1ME6NWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbMKiR6g58Y0kjazdP2TVh5eiqTLy7ipwGzcEhg+xOotSdBhqCojPe9/JX7ITmtI2N45LdeEup85mHs+v1ygH2mKtyQfKSJmb7JKy4sOsrhZ71KOltSBI7UUU1lZSP6uTWCGk/Aag8blT2M4OSarbOhsKCivWKrW1hagAliLFMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=KU20LfmD; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B5415100003;
	Sat, 10 Feb 2024 00:28:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B5415100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1707514105;
	bh=Eg+ityGP9rRaB35HLWZFr9cbeY7LycCsMeGBmIKbnDQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=KU20LfmD28/1tOTu66gfksmeNT/jBygd6gypPcL8DKj0jDOgA/Nu0io84j7cxnAI4
	 UrNzk1jDMa1SG0crSUHfhnJGzM0kIpXg5m8XZHQglKdUfn/RahbLd8FWo6o61LBfQr
	 okA88sPPeDnBi7nfIljeph+9se7Qom9BwxWljsKnSfIpt+LnhOFXz0yvPv3+9aYrMu
	 iY5QEhya4lEo5kfOi3GyeEQKeRmye63MhwoJyeKtyLFqjiyL6hiIDapXPEu1GlMvZM
	 nsDbbbHMOeB0QaeJBAL9Srcs3d8AQkamGNjYkpqQfcE67BswWmwJm+vbaZI8bJdzbd
	 b/QF6ZkZYPXWA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 10 Feb 2024 00:28:25 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 10 Feb 2024 00:28:25 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <adeep@lexina.in>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <conor+dt@kernel.org>
CC: <kernel@sberdevices.ru>, <sdfw_system_team@sberdevices.ru>,
	<rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v1 1/2] arm64: dts: amlogic: axg: move cpu cooling-cells to common dtsi
Date: Sat, 10 Feb 2024 00:28:05 +0300
Message-ID: <20240209212816.11187-2-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209212816.11187-1-ddrokosov@salutedevices.com>
References: <20240209212816.11187-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183341 [Feb 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/09 20:35:00 #23447606
X-KSMG-AntiVirus-Status: Clean, skipped

The CPU cooling-cells property should be located in the meson-axg common
dtsi, as it is required for all AXG-based boards with DVFS.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 .../amlogic/meson-axg-jethome-jethub-j1xx.dtsi   | 16 ----------------
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi       |  4 ++++
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
index db605f3a22b4..55802fb03a46 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
@@ -332,19 +332,3 @@ &gpio {
 		"", "", "", "", "", // 80 - 84
 		"", ""; // 85-86
 };
-
-&cpu0 {
-	#cooling-cells = <2>;
-};
-
-&cpu1 {
-	#cooling-cells = <2>;
-};
-
-&cpu2 {
-	#cooling-cells = <2>;
-};
-
-&cpu3 {
-	#cooling-cells = <2>;
-};
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 7e5ac9db93f8..ea96fef328e8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -74,6 +74,7 @@ cpu0: cpu@0 {
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -83,6 +84,7 @@ cpu1: cpu@1 {
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -92,6 +94,7 @@ cpu2: cpu@2 {
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -101,6 +104,7 @@ cpu3: cpu@3 {
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
+			#cooling-cells = <2>;
 		};
 
 		l2: l2-cache0 {
-- 
2.43.0


