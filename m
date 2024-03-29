Return-Path: <linux-kernel+bounces-125420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BCA8925B8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073C71F233A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8728D13CA94;
	Fri, 29 Mar 2024 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="iykvs8wd"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89906BB22;
	Fri, 29 Mar 2024 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745960; cv=none; b=YzO1owsrRqCd/Yvc4XzO7kdVPPnHtPwMJSUKAJVal1L+ZDClB1NdJ12IJmDyTzsi7/krAMoYjt9+eYqtAU0IH5JxtllLPmYPyB3Z/NMaG1kdBjyLnbLd1O6ArKAhiru+wjup2G4bBfUiu65e+htN+0WU3uQ0SyGzWDtmbmIZRaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745960; c=relaxed/simple;
	bh=TJg16k9up5iAADLfXxJqpl2ySGKF8ytj+xyo5UoGrSw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3Vj3hXJRZNRPaOtayWHTohbbFBajqfuPlJe4hm8O3Tz5QRUJy6IabFiCT6nx6+5XU2NF7FgUcyu84TLQ66xhAiw3OyoVtvK/C7LTCbDT8NqCBpIG3yrzkEcl0EpSVWKKpgQ24dpodvA5QqZFOppOfwFJrVtrqU71EF47eXocpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=iykvs8wd; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9FDD6120019;
	Fri, 29 Mar 2024 23:59:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9FDD6120019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711745956;
	bh=xuKBJ+Bt7jmJARjlnxEbw3uFcDYRdaA63r8bHT466l4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=iykvs8wdwCMKO0S65V/uYgb1g9MuFAgajGnAnFO1mAEfY5MpQPY2/WqC8AWRd9g4C
	 OinbB8il+h4M7HkRr/7gOLzijNxz18pvWbTPcpDJ15vU8bPPSTYMKlAFAYm37xWgd4
	 XzzK3DTSQtre7k2j+ifUoIJDdIgt09GxEw6BTNy29qmutxItgt09uFhWCG5Ng2r/jj
	 KPdL8LzwRcb5vovY8LitwA2+ETkEO9twiYbNWvKfZuXtG6TrTbTKEg5AltPiXOvlFH
	 PQZ+3EfFmtMq+zDUaBrn3wd60IHEm7rR4XuTVNdSA4PqSE+dGauSlEI46j/P9ZWOLh
	 G7Gt3WnOg9EJw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 29 Mar 2024 23:59:16 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 23:59:16 +0300
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
Subject: [PATCH v1 4/6] clk: meson: a1: peripherals: support 'sys_pll_div16' clock as GEN input
Date: Fri, 29 Mar 2024 23:58:44 +0300
Message-ID: <20240329205904.25002-5-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329205904.25002-1-ddrokosov@salutedevices.com>
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/29 16:52:00 #24511844
X-KSMG-AntiVirus-Status: Clean, skipped

The clock 'sys_pll_div16' is one of the parents of the GEN clock. It is
generated in the A1 PLL clock controller with a fixed factor.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/clk/meson/a1-peripherals.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
index 621af1e6e4b2..3c4452f2b146 100644
--- a/drivers/clk/meson/a1-peripherals.c
+++ b/drivers/clk/meson/a1-peripherals.c
@@ -747,13 +747,13 @@ static struct clk_regmap fclk_div2_divn = {
 };
 
 /*
- * the index 2 is sys_pll_div16, it will be implemented in the CPU clock driver,
  * the index 4 is the clock measurement source, it's not supported yet
  */
-static u32 gen_table[] = { 0, 1, 3, 5, 6, 7, 8 };
+static u32 gen_table[] = { 0, 1, 2, 3, 5, 6, 7, 8 };
 static const struct clk_parent_data gen_parent_data[] = {
 	{ .fw_name = "xtal", },
 	{ .hw = &rtc.hw },
+	{ .fw_name = "sys_pll_div16", },
 	{ .fw_name = "hifi_pll", },
 	{ .fw_name = "fclk_div2", },
 	{ .fw_name = "fclk_div3", },
-- 
2.43.0


