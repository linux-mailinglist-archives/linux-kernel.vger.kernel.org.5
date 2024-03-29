Return-Path: <linux-kernel+bounces-125418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18B88925B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ACC9B2217C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B8413BC16;
	Fri, 29 Mar 2024 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="mIU5BVwv"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E28433C7;
	Fri, 29 Mar 2024 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745960; cv=none; b=fFOEY9ahumQ7bmebNnx6ZfVC9vnQCLF2PDMjYZpeqRsVgoNkwjGtohm/VJMhU0d1Wa4lBBH732NlSjRH988xNqgNB0giTh32o3nLOviDj762FDr3GYaeHPWiaMJKSGgFo3ZFVusOD20HOGcs0n6YoMzlYstfuPS2QybC30rUB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745960; c=relaxed/simple;
	bh=lrnHdJupkNtFuPzV/0Ht97re0E6z/Ta2cl/hQCTDnjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvYEFVhvYAdhgccrtAciZsIH9MGfbYOc4MtZ3vSxwCCyyxl5ITuvLTOi3lbdsVACxmN+MvUcKWf+2xLqVlaUFmJxCB6hozvmap7V0Mzqc7xLpy0+78Jw2PSzg/aAFi/WF8n7ezXLzfvIzy550g6+icjgG5I/T45gewu6APy0ZHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=mIU5BVwv; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 46A74120018;
	Fri, 29 Mar 2024 23:59:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 46A74120018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711745955;
	bh=A5x5jKRDY5bKTnsE7ZPSAZXHgm2KzJ5lAzPlz2XgJ8o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=mIU5BVwv28i10hrRdZaJEk1em0XFBEUYSPODNtOBKY3m/IgvqqX8eY9PjLRw4scEs
	 L8yQkJfz1rQMimfMCS/RyY9EevTSpe4zRz+BbZZwOkWcZZZ2fuhodejy21g61laNiZ
	 KqzvIoAgEnfGHz/16W0r/sdyO4jQew/BBv+H9FkCsN9pmHhSBGu39Uiqk2y5nppxVc
	 kadPsLnm6T71c/qXHjGBontxfNjBNJTwTwSYSaAhettfsSqoRSQH0B6pkoeF1D239K
	 nmq9mYyypsTiricoLBcPI6QIGKHc9ironM9dd5pV9NB8lCQZ0ZBBACLDjmdk0Y3MRU
	 1qRyio+Fwlvmg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 29 Mar 2024 23:59:15 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 23:59:14 +0300
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
Subject: [PATCH v1 2/6] clk: meson: a1: pll: support 'syspll' general-purpose PLL for CPU clock
Date: Fri, 29 Mar 2024 23:58:42 +0300
Message-ID: <20240329205904.25002-3-ddrokosov@salutedevices.com>
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

The 'syspll' PLL, also known as the system PLL, is a general and
essential PLL responsible for generating the CPU clock frequency.
With its wide-ranging capabilities, it is designed to accommodate
frequencies within the range of 768MHz to 1536MHz.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/clk/meson/a1-pll.c | 78 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/a1-pll.h |  6 +++
 2 files changed, 84 insertions(+)

diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
index 60b2e53e7e51..02fd2d325cc6 100644
--- a/drivers/clk/meson/a1-pll.c
+++ b/drivers/clk/meson/a1-pll.c
@@ -138,6 +138,81 @@ static struct clk_regmap hifi_pll = {
 	},
 };
 
+static const struct pll_mult_range sys_pll_mult_range = {
+	.min = 32,
+	.max = 64,
+};
+
+/*
+ * We assume that the sys_pll_clk has already been set up by the low-level
+ * bootloaders as the main CPU PLL source. Therefore, it is not necessary to
+ * run the initialization sequence.
+ */
+static struct clk_regmap sys_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = ANACTRL_SYSPLL_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = ANACTRL_SYSPLL_CTRL0,
+			.shift   = 0,
+			.width   = 8,
+		},
+		.n = {
+			.reg_off = ANACTRL_SYSPLL_CTRL0,
+			.shift   = 10,
+			.width   = 5,
+		},
+		.frac = {
+			.reg_off = ANACTRL_SYSPLL_CTRL1,
+			.shift   = 0,
+			.width   = 19,
+		},
+		.l = {
+			.reg_off = ANACTRL_SYSPLL_STS,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.current_en = {
+			.reg_off = ANACTRL_SYSPLL_CTRL0,
+			.shift   = 26,
+			.width   = 1,
+		},
+		.l_detect = {
+			.reg_off = ANACTRL_SYSPLL_CTRL2,
+			.shift   = 6,
+			.width   = 1,
+		},
+		.range = &sys_pll_mult_range,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sys_pll",
+		.ops = &meson_clk_pll_ops,
+		.parent_names = (const char *[]){ "syspll_in" },
+		.num_parents = 1,
+		/*
+		 * This clock is used as the main CPU PLL source in low-level
+		 * bootloaders, and it is necessary to mark it as critical.
+		 */
+		.flags = CLK_IS_CRITICAL,
+	},
+};
+
+static struct clk_fixed_factor sys_pll_div16 = {
+	.mult = 1,
+	.div = 16,
+	.hw.init = &(struct clk_init_data){
+		.name = "sys_pll_div16",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&sys_pll.hw
+		},
+		.num_parents = 1,
+	},
+};
+
 static struct clk_fixed_factor fclk_div2_div = {
 	.mult = 1,
 	.div = 2,
@@ -283,6 +358,8 @@ static struct clk_hw *a1_pll_hw_clks[] = {
 	[CLKID_FCLK_DIV5]	= &fclk_div5.hw,
 	[CLKID_FCLK_DIV7]	= &fclk_div7.hw,
 	[CLKID_HIFI_PLL]	= &hifi_pll.hw,
+	[CLKID_SYS_PLL]		= &sys_pll.hw,
+	[CLKID_SYS_PLL_DIV16]	= &sys_pll_div16.hw,
 };
 
 static struct clk_regmap *const a1_pll_regmaps[] = {
@@ -293,6 +370,7 @@ static struct clk_regmap *const a1_pll_regmaps[] = {
 	&fclk_div5,
 	&fclk_div7,
 	&hifi_pll,
+	&sys_pll,
 };
 
 static struct regmap_config a1_pll_regmap_cfg = {
diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
index 4be17b2bf383..666d9b2137e9 100644
--- a/drivers/clk/meson/a1-pll.h
+++ b/drivers/clk/meson/a1-pll.h
@@ -18,6 +18,12 @@
 #define ANACTRL_FIXPLL_CTRL0	0x0
 #define ANACTRL_FIXPLL_CTRL1	0x4
 #define ANACTRL_FIXPLL_STS	0x14
+#define ANACTRL_SYSPLL_CTRL0	0x80
+#define ANACTRL_SYSPLL_CTRL1	0x84
+#define ANACTRL_SYSPLL_CTRL2	0x88
+#define ANACTRL_SYSPLL_CTRL3	0x8c
+#define ANACTRL_SYSPLL_CTRL4	0x90
+#define ANACTRL_SYSPLL_STS	0x94
 #define ANACTRL_HIFIPLL_CTRL0	0xc0
 #define ANACTRL_HIFIPLL_CTRL1	0xc4
 #define ANACTRL_HIFIPLL_CTRL2	0xc8
-- 
2.43.0


