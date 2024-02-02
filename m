Return-Path: <linux-kernel+bounces-49948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2E88471E3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28B3B2996F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9147B13EFEA;
	Fri,  2 Feb 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="tv1lOjPn"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF31854;
	Fri,  2 Feb 2024 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884031; cv=none; b=ZVi1el5BYsDo00rW8sLH5XgYOCHrVHhYZ5/95RlCk6+bv+I6MGff/c7WxLByogp8baDY1vbBnPqxBY3xfOEztsTFblPMGJ1n88OB+XkTmjoGn0YZbzbFM2SVhixqZ/Ln1FrD0ArBKKVXz9ascgm933qrOqIkGrgqoJf+XHbHRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884031; c=relaxed/simple;
	bh=CHL4VTwATVPlntAxMS+V97knUqQfUioN/hnMfpChPiY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DOvTpdWYHhCym8NMXGfHzssHmIIpsjncNx8iGyg/1mYmeRCuo4D9DDEFnms/zQWabHP1AbTTkK44vmkO/4HKrscYlZjfg2Hdwok+/TRN5xY5zZ/vkYKIrsxY1uswalZb9n8QNugViYGEbIaGO11pSmENLhKl+mo3kc2ZugpUugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=tv1lOjPn; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 856F8100009;
	Fri,  2 Feb 2024 17:27:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 856F8100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706884023;
	bh=JeqPP36z4pnlbw1sLnjMU+SnvqzYB8B7+7WjQdUZT4c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=tv1lOjPnlavwyjm3XqtQCuyI0jQIgx8BjwD5J7mtuY+0ASihXhtcUwGqBSlJOpxF0
	 4VcsGPlJbYKLmhw4lYFAHsYtbmjiRh6elHhYTXK16Txt+RykRNbsbloux+baHiiROX
	 O37p8jA5N1pIMokgEMIfVIHfHW8aiWYuyJ5Jt0y3likxUqK0Y4+Q3N5+TD23MQyNmh
	 JL1FlWWuJiMA4sWq+EBP80SCK6Ckxspn9FxGmMxjpacDIaBY4YL2T4SdV6rqW26I4N
	 UBwHr9zyHt7iTS+fJ2xhaDLfRz5V6XQbSr4acJqiKHuO/pqPndy8yaPV2POm8jBRTd
	 hCSgBs0aA0r9Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri,  2 Feb 2024 17:27:03 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 17:27:03 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <jbrunet@baylibre.com>, <neil.armstrong@linaro.org>
CC: <kernel@salutedevices.com>, <prusovigor@gmail.com>, Igor Prusov
	<ivprusov@salutedevices.com>, Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: meson: Add missing clocks to axg_clk_regmaps
Date: Fri, 2 Feb 2024 17:25:48 +0300
Message-ID: <20240202172537.1.I64656c75d84284bc91e6126b50b33c502be7c42a@changeid>
X-Mailer: git-send-email 2.34.1
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
X-KSMG-AntiSpam-Lua-Profiles: 183159 [Feb 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/02 11:00:00 #23326006
X-KSMG-AntiVirus-Status: Clean, skipped

Some clocks were missing from axg_clk_regmaps, which caused kernel panic
during cat /sys/kernel/debug/clk/clk_summary

[   57.349402] Unable to handle kernel NULL pointer dereference at virtual address 00000000000001fc
..
[   57.430002] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   57.436900] pc : regmap_read+0x1c/0x88
[   57.440608] lr : clk_regmap_gate_is_enabled+0x3c/0xb0
[   57.445611] sp : ffff800082f1b690
[   57.448888] x29: ffff800082f1b690 x28: 0000000000000000 x27: ffff800080eb9a70
[   57.455961] x26: 0000000000000007 x25: 0000000000000016 x24: 0000000000000000
[   57.463033] x23: ffff800080e8b488 x22: 0000000000000015 x21: ffff00000e7e7000
[   57.470106] x20: ffff00000400ec00 x19: 0000000000000000 x18: ffffffffffffffff
[   57.477178] x17: 0000000000000000 x16: 0000000000000000 x15: ffff0000042a3000
[   57.484251] x14: 0000000000000000 x13: ffff0000042a2fec x12: 0000000005f5e100
[   57.491323] x11: abcc77118461cefd x10: 0000000000000020 x9 : ffff8000805e4b24
[   57.498396] x8 : ffff0000028063c0 x7 : ffff800082f1b710 x6 : ffff800082f1b710
[   57.505468] x5 : 00000000ffffffd0 x4 : ffff800082f1b6e0 x3 : 0000000000001000
[   57.512541] x2 : ffff800082f1b6e4 x1 : 000000000000012c x0 : 0000000000000000
[   57.519615] Call trace:
[   57.522030]  regmap_read+0x1c/0x88
[   57.525393]  clk_regmap_gate_is_enabled+0x3c/0xb0
[   57.530050]  clk_core_is_enabled+0x44/0x120
[   57.534190]  clk_summary_show_subtree+0x154/0x2f0
[   57.538847]  clk_summary_show_subtree+0x220/0x2f0
[   57.543505]  clk_summary_show_subtree+0x220/0x2f0
[   57.548162]  clk_summary_show_subtree+0x220/0x2f0
[   57.552820]  clk_summary_show_subtree+0x220/0x2f0
[   57.557477]  clk_summary_show_subtree+0x220/0x2f0
[   57.562135]  clk_summary_show_subtree+0x220/0x2f0
[   57.566792]  clk_summary_show_subtree+0x220/0x2f0
[   57.571450]  clk_summary_show+0x84/0xb8
[   57.575245]  seq_read_iter+0x1bc/0x4b8
[   57.578954]  seq_read+0x8c/0xd0
[   57.582059]  full_proxy_read+0x68/0xc8
[   57.585767]  vfs_read+0xb0/0x268
[   57.588959]  ksys_read+0x70/0x108
[   57.592236]  __arm64_sys_read+0x24/0x38
[   57.596031]  invoke_syscall+0x50/0x128
[   57.599740]  el0_svc_common.constprop.0+0x48/0xf8
[   57.604397]  do_el0_svc+0x28/0x40
[   57.607675]  el0_svc+0x34/0xb8
[   57.610694]  el0t_64_sync_handler+0x13c/0x158
[   57.615006]  el0t_64_sync+0x190/0x198
[   57.618635] Code: a9bd7bfd 910003fd a90153f3 aa0003f3 (b941fc00)
[   57.624668] ---[ end trace 0000000000000000 ]---

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---

 drivers/clk/meson/axg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index c12f81dfa674..5f60f2bcca59 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -2142,7 +2142,9 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_vclk_input,
 	&axg_vclk2_input,
 	&axg_vclk_div,
+	&axg_vclk_div1,
 	&axg_vclk2_div,
+	&axg_vclk2_div1,
 	&axg_vclk_div2_en,
 	&axg_vclk_div4_en,
 	&axg_vclk_div6_en,
-- 
2.34.1


