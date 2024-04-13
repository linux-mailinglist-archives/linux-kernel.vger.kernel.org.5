Return-Path: <linux-kernel+bounces-143807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6408A3DAC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607591F219D5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCA34D9F4;
	Sat, 13 Apr 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JbdgBJqb"
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECF91CD0C;
	Sat, 13 Apr 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713025258; cv=none; b=nz0VVdnP6XHSshq61Tj7K7Iq9QcrnoXxWmpyd0l4SYkgIUg5+E5YgjzyHnX7uu+7lsQjUcf1z9HNiS7ped4YhpMdNmBujLlJwlBa4j1URtMVHXQ5SMC9X3uvxSlntSuQBP/+v9iXsZrDCpUPU3aKPBGHqaM1aKNG7BMEys/1UUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713025258; c=relaxed/simple;
	bh=417b/9d43ngFcbNVrFBgM4rmbkWOa98VnzaLc1bwHFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBcuHzgsoWV4jJYtx3pPX1e3HKymjWU67XbreaS62kxiewU17HFx5gC/ilaeWYN9qta8C5Ieeds38SaGlmcFX1lGlZZqil0VVkpHN4RqwcHcikU5xUpdZOHB2cccghYdLBXqtZzV7K7BOpH0qhxgeEWatn/asBO5E2AvEx8gcxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JbdgBJqb; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vg6RrrzjkO6CFvg6RrPV6e; Sat, 13 Apr 2024 18:19:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713025184;
	bh=rLizR9RhE9tMh50jc6ZMXVKjpOwIq/OMFzbiVdRM4Js=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JbdgBJqbvKLNmKlYXZ3QW99hVCWnpC6aB3SbBqhK3IQckB7U3u2pHv7Plng+RHEYD
	 TRtdq5LVqNbjddwKgebQPb63sDFxjGFJ4bAxd0SzGtqwMo2SN/sJ45N0SSeUkLUpx2
	 OP/msNKXsviqq9mKEkXCVShGFTa6Mg+JOzlhUBmPTiVaeAj/CVJi9yNj2UpHIxKUsj
	 UIdeDqjYbP/kFu/R/6kQntdkg93fRdClcDkc9x9JdWUY5CT0Qtdf7d0d1YBLWnxv5e
	 HM3YlFkWnTmyw5QFo6NGuOk+PI8NsL3sq3p4MVBXOXgnj4fEhMc9ho2tt41oTF5AVU
	 PWcEY0eysMo6w==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 13 Apr 2024 18:19:44 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH] clk: renesas: r8a7740: Remove an unused field in struct div4_clk
Date: Sat, 13 Apr 2024 18:19:40 +0200
Message-ID: <658e6b1b23d5b66646bb830361b8c55ccf797771.1713025170.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct div4_clk", the 'flags' field is unused.

Remove it and update the 'div4_clks' array accordingly.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

Apparently, it has never been used. It is not a left-over from a
refactoring. I don't if it is supposed to be used somewhere in the driver.

Should it help the review, renesas/clk-r8a73a4.c has a very similar
construction and also a struct div4_clk without this 'flags' field.
---
 drivers/clk/renesas/clk-r8a7740.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/renesas/clk-r8a7740.c b/drivers/clk/renesas/clk-r8a7740.c
index 3ee3f57e4e9a..325394b6e55e 100644
--- a/drivers/clk/renesas/clk-r8a7740.c
+++ b/drivers/clk/renesas/clk-r8a7740.c
@@ -32,22 +32,21 @@ struct div4_clk {
 	const char *name;
 	unsigned int reg;
 	unsigned int shift;
-	int flags;
 };
 
 static struct div4_clk div4_clks[] = {
-	{ "i", CPG_FRQCRA, 20, CLK_ENABLE_ON_INIT },
-	{ "zg", CPG_FRQCRA, 16, CLK_ENABLE_ON_INIT },
-	{ "b", CPG_FRQCRA,  8, CLK_ENABLE_ON_INIT },
-	{ "m1", CPG_FRQCRA,  4, CLK_ENABLE_ON_INIT },
-	{ "hp", CPG_FRQCRB,  4, 0 },
-	{ "hpp", CPG_FRQCRC, 20, 0 },
-	{ "usbp", CPG_FRQCRC, 16, 0 },
-	{ "s", CPG_FRQCRC, 12, 0 },
-	{ "zb", CPG_FRQCRC,  8, 0 },
-	{ "m3", CPG_FRQCRC,  4, 0 },
-	{ "cp", CPG_FRQCRC,  0, 0 },
-	{ NULL, 0, 0, 0 },
+	{ "i", CPG_FRQCRA, 20 },
+	{ "zg", CPG_FRQCRA, 16 },
+	{ "b", CPG_FRQCRA,  8 },
+	{ "m1", CPG_FRQCRA,  4 },
+	{ "hp", CPG_FRQCRB,  4 },
+	{ "hpp", CPG_FRQCRC, 20 },
+	{ "usbp", CPG_FRQCRC, 16 },
+	{ "s", CPG_FRQCRC, 12 },
+	{ "zb", CPG_FRQCRC,  8 },
+	{ "m3", CPG_FRQCRC,  4 },
+	{ "cp", CPG_FRQCRC,  0 },
+	{ NULL, 0, 0 },
 };
 
 static const struct clk_div_table div4_div_table[] = {
-- 
2.44.0


