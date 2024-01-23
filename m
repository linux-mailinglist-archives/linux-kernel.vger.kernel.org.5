Return-Path: <linux-kernel+bounces-35739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 365548395CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0231F32ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E75129A6B;
	Tue, 23 Jan 2024 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="I4l8Sbmc"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A2486AD9;
	Tue, 23 Jan 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029141; cv=none; b=oOWBx9jO38qsBa5PiK1tJ3kS21SuqabnS9/QEk2qF8BfYa3EgoJpqkGlV+n2arD1luscfU3J+EcYh87v+eDJ8Y5Xua2U5gGNOvdTech2sXPnrxH9+UhJYj5k7ZAmLSCd0SoDMkqHU2khMDba8BXX5hO1GmHDoO+oBxsntTRJF+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029141; c=relaxed/simple;
	bh=9V8uJQtsEA//xLdXsxXFSPvAvLQWNJZAzbrMxb2xIFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drJujMwyZAeeOxn15DBjsoAmvvRxZyGpMWesndXpL6cUYN/cmGr1fbWakIduhi+Y13YvvIqd4xOGtEJ5TstC14LX0R2FAbRxckIFbPCPkmexkAImIcdtT3THRcAd4U1UQopYdIYXLrxuWJazMos9hLBf4iebmTEloMehRapDe+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=I4l8Sbmc; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A37D3120013;
	Tue, 23 Jan 2024 19:58:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A37D3120013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706029135;
	bh=Suu3M8yZ3iQK1BgAjDId2N0FtfrKgiBllmAvXu1xcB0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=I4l8SbmcubLWHYLQ+J4+/SkY/I4VnhuHFtWD350/+uXzOyitRLBpp5HzY+FNQOVpj
	 tGwss3jhEW+DkHfioanOoqxXYPuTwXPqAVy2uAiipqgZ7AV3q011r6Mj0RPsc4jA+S
	 gREMBpDMk4k4uNS85QNK2azjwVsvZi48R7PLPYc0FDvWWw3AdqjsPc66kpJpK87Bjb
	 UqEwdC5I23vZSrEU+I4MCAZTF8X+ORkFBuuu3rvu6ArVOhIQdk0tnz9O3mEhLym0XG
	 FW0tV0Cj9YImXOAysJ7DJZ5oLQO+sffIbbAG9wAmnpFMDxNsa7Nx0oF9L3bCXQXcfm
	 SHf+WTZmFz6Dw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 23 Jan 2024 19:58:55 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 19:58:55 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <clabbe@baylibre.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <linux-crypto@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@salutedevices.com>, Alexey
 Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 17/20] arch: arm64: dts: meson: a1: add crypto node
Date: Tue, 23 Jan 2024 19:58:28 +0300
Message-ID: <20240123165831.970023-18-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123165831.970023-1-avromanov@salutedevices.com>
References: <20240123165831.970023-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182874 [Jan 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/23 13:53:00 #23383939
X-KSMG-AntiVirus-Status: Clean, skipped

This patch adds a crypto node declaration. With the
Amlogic crypto driver we can use HW implementation
of SHA1/224/256 and AES algo.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index cf150f568335..516b914033ab 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -653,6 +653,13 @@ sd_emmc: sd@10000 {
 				power-domains = <&pwrc PWRC_SD_EMMC_ID>;
 				status = "disabled";
 			};
+
+			crypto: crypto@6000 {
+				compatible = "amlogic,a1-crypto";
+				reg = <0x0 0x6000 0x0 0x48>;
+				interrupts = <GIC_SPI 120 IRQ_TYPE_EDGE_RISING>;
+				power-domains = <&pwrc PWRC_DMA_ID>;
+			};
 		};
 
 		usb: usb@fe004400 {
-- 
2.34.1


