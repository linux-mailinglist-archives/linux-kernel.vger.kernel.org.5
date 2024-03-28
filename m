Return-Path: <linux-kernel+bounces-123536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A98890A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F119E2976DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD329139D04;
	Thu, 28 Mar 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ij6tDyPi"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64981DDEE;
	Thu, 28 Mar 2024 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655866; cv=none; b=eAPpgem1vKUyxbvdPUUQeQMpZWJB1aJxT68G2vjIbpbAcZqWWHo8HEWBIlq3Gj7K7NghRsHSdKJIAXcEBKnoIlbVqAc52N4//sF4kDkADmDNJMb7Kw1DkR0Us9VJ2LD3IHbi514NKpJ8viIZ78ExsXE9drvQhv9QC47HvWrqZ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655866; c=relaxed/simple;
	bh=7JXe9YzedTYhE82EFXVYkzaD8exZPpH+SswVS252TeI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B3X/GIE0Po/dEixDhCGg42AL8ZgiJPVrLtjDCnoyuHtzSvnxnpm7pYhHWtx6Vzs8+P2GfoSZW3N+phnW4Z9PFlYes+JJ8oM7ikDYhKcBciITpqz44vUhGN7JLMZmC0Q2DFsgvz6yuzfXOP07UGPjnEcBJn756qhdNPnR+Fmzr8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ij6tDyPi; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7C6FD120006;
	Thu, 28 Mar 2024 22:57:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7C6FD120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711655862;
	bh=J1/tsMz9G9CRvZryKckzyx/QA25/rYaJHeU8Rg8upNg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ij6tDyPiW4C1258e7K6nBMoIU18H1z4zgXG+IH5DSnAgh11efPtYTZHRIcbHt8ZTi
	 dRveYjM0c72rVRxPc/tcw52+vWVZnhpo+x5XTT6w/03PHZ2kaZNFeShkaTI3ZZMr7D
	 2sNZFi/h/l7BBlo8ymuyWTSoB0VBtTf3hoDMmEnEWVJQa8n+8j7ka5+EX64qVBMWpf
	 a/gUt5KekUo8fP7wZdF0a+IGsW8+nm1qL73SWvaL6uGkFXRXF0dXit/RAwpRA7m1H2
	 Ztdabxe1yPChvhpCzpRCKFHKydbfVjOeZUR43A94qNRc3eg+VPKGPk8cnLK1gmU45f
	 YjtE22mUplBJg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 28 Mar 2024 22:57:42 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 22:57:41 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <sboyd@kernel.org>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1] clk: meson: pll: print out pll name when unable to lock it
Date: Thu, 28 Mar 2024 22:57:29 +0300
Message-ID: <20240328195733.30572-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
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
X-KSMG-AntiSpam-Lua-Profiles: 184478 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/28 18:13:00 #24496606
X-KSMG-AntiVirus-Status: Clean, skipped

In most meson systems, multiple PLLs are present, making it difficult to
identify the specific PLL that fails to lock. To address this issue,
print out the name of the PLL that cannot be locked.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/clk/meson/clk-pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 6fa7639a3050..78d17b2415af 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -436,8 +436,8 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	ret = meson_clk_pll_enable(hw);
 	if (ret) {
-		pr_warn("%s: pll did not lock, trying to restore old rate %lu\n",
-			__func__, old_rate);
+		pr_warn("%s: pll %s didn't lock, trying to set old rate %lu\n",
+			__func__, clk_hw_get_name(hw), old_rate);
 		/*
 		 * FIXME: Do we really need/want this HACK ?
 		 * It looks unsafe. what happens if the clock gets into a
-- 
2.43.0


