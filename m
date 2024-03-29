Return-Path: <linux-kernel+bounces-125427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F848925CF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC31EB21DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E9313CF8F;
	Fri, 29 Mar 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="udeFtLVr"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC156A346;
	Fri, 29 Mar 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746306; cv=none; b=KU2lbppmz1Q7F3u1lxXDWUbfBABpW/8mtDZv2unBoCHNU/Sylyd9SNiUexinWSkAhljBwhYB6AnpoVIThABO7GzjjCf+S/tJ7PVCUPjfxNJaQaM5PbvmBCM0sPljGwbghzBBapUKUAQhmshkW1yMP1bb1m4MTLJOvZRzmYu+EOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746306; c=relaxed/simple;
	bh=QANRpYf1p5Qfsp1ggD7SKI2bHsGJHzinBeiDVrYi8bM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1n/hglgtHrqJFEvBM/WqxjVwHyl9xNmit1w6l+cNuRAYA+dUHOs/5w7Qoslc7HpHykijQZNX8d9EbxXMylgJM37p8KyzmS3/R9FB4xdxBpcdN3y+pgtXDuEpU901J+nlc4adukZT237N3eahac88v0DBJ4k9ve68YGxbl/jtcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=udeFtLVr; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 5966F100004;
	Sat, 30 Mar 2024 00:05:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5966F100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711746302;
	bh=t0bgy3GqVeV50u4W7JqTfnWO02NuPPPw5/W/uajecvo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=udeFtLVr1u1ROsx4eHomGaeLwxT7hKdwD3Ubeo1zWuUPCv3xe1vOY5Gryu6biwxA3
	 Hb/+/KMyi4PITAHYhWJQFvz97o6+IDFrkLPFfejFsP539r0SRIgSyAsEiAP00eHTu5
	 xwANfD2lh2Uxbt5SsKu5/+9vlgQfeU8YNmTVwLFD95MyW4Na9fyWpjqGrEmDYGLS4U
	 E/FSfu/XKBo8U1iRQkcNIXTorBDQk1J/BYACg6Hpr6EsMXKKk8fMG5O3GjsqhkyWX7
	 ISrCwkCMJHOHUh5Rt2Jz1u/3QRj7DzAuSMUY5myO0VD4ZNDwxaOkMd59h9Ha0jtTzg
	 OzGFc0WmzwL6Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 30 Mar 2024 00:05:02 +0300 (MSK)
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
Subject: [PATCH v1 3/4] arm64: dts: amlogic: a1: add new input clock 'sys_pll_div16' to clkc_periphs
Date: Sat, 30 Mar 2024 00:04:41 +0300
Message-ID: <20240329210453.27530-4-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/29 16:52:00 #24511844
X-KSMG-AntiVirus-Status: Clean, skipped

The input clock 'sys_pll_div16' is a clock with a fixed ratio inherited
from the main system PLL.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 07fd0be828d4..0de809f4d42c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -747,10 +747,12 @@ clkc_periphs: clock-controller@800 {
 					 <&clkc_pll CLKID_FCLK_DIV5>,
 					 <&clkc_pll CLKID_FCLK_DIV7>,
 					 <&clkc_pll CLKID_HIFI_PLL>,
+					 <&clkc_pll CLKID_SYS_PLL_DIV16>,
 					 <&xtal>;
 				clock-names = "fclk_div2", "fclk_div3",
 					      "fclk_div5", "fclk_div7",
-					      "hifi_pll", "xtal";
+					      "hifi_pll", "sys_pll_div16",
+					      "xtal";
 			};
 
 			i2c0: i2c@1400 {
-- 
2.43.0


