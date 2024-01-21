Return-Path: <linux-kernel+bounces-32080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A483563F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30861F21ACB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D15376E4;
	Sun, 21 Jan 2024 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VfvY2jXj"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858F36B04
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705850199; cv=none; b=bUYJ60bPkVV2c+rE6z5G0SnrxddzWmczOw2Jy7TATm5wFzGUeaCb3VsBURPjH7CeP88FGh91ZI1uKJcAj1q+Z6wiyuyo8UuGd62TTrFxw1UkQBy2VpxKl3v7yWZ612rJ3K59M528PpvskXz76CsbTOBDSPlzIzkl1KSleSiRAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705850199; c=relaxed/simple;
	bh=aE5loClksuGePGR6Lbm0lCF9Z4jkrkChjspAaoHIygg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h8Eh+YjtNvlwjGZrpeMBNjHHJeQ932jwM9H7+kZ4sTrlohm5BxW/28T6/4zN6tfoB2MDvJeuHaVnKHXDaEISRar3CK+SsigLckLWEzBAfVMvnNtWrWIhZU01fFhh/cNmWFuTs4C1EeBz+SONT9L9omwm2HBAJNoN2TBHNvKFVz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VfvY2jXj; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id RZYgrRMmRCqsFRZYgrzab7; Sun, 21 Jan 2024 16:16:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705850188;
	bh=t7DqkZJVqfp9AUlCGJgpNPf8G7Pty9cbAs3eq1MTuT0=;
	h=From:To:Cc:Subject:Date;
	b=VfvY2jXjJaHg1Jp2ixRAbC+dqFMVMOwEgvjTFWEWM67ME2KPAXY3+Fk0F6z7DnbPC
	 zQ8IEQANQGYzfuPGUec4QZAQlWxChFdFonJTW52FN10x22HC/w45hUg2LrApv8RkXC
	 bEd9vO9UPJZnHelrm2xZbnxLZPax4s/CWSMzHXUg8aPVIy3JaWhyu6BexbauctZzYi
	 yVf7YkpY89qX8isuNbtMfyE2RCTwgZ312tCNav4tTMXWfgTW8d2Z02HSI6wUaigF09
	 SAbK5kGvnnyYEd7S7iwXakdECCP0qSNrWY0rL4Zk2/7zhGAGNE2+P32esveCb4NGS6
	 wvbN2Ge97164g==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jan 2024 16:16:28 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dongjiu Geng <gengdongjiu@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-clk@vger.kernel.org
Subject: [PATCH] clk: hisilicon: hi3559a: Fix an erroneous devm_kfree()
Date: Sun, 21 Jan 2024 16:16:24 +0100
Message-ID: <773fc8425c3b8f5b0ca7c1d89f15b65831a85ca9.1705850155.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'p_clk' is an array allocated just before the for loop for all clk that
need to be registered.
It is incremented at each loop iteration.

If a clk_register() call fails, 'p_clk' may point to something different
from what should be freed.

The best we can do, is to avoid this wrong release of memory.

Fixes: 6c81966107dc ("clk: hisilicon: Add clock driver for hi3559A SoC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
devm_kfree() is clearly wrong (IMHO :)), but just removing it is maybe not
the best solution.

Should hisi_clk_register_pll() return an error?
Should some data->clk_data.clks[clks[i].id] be set to NULL?
(hisi_clk_alloc() doesn't zero the allocated memory)
Should hisi_clk_alloc() use kzalloc() when allocating clk_table?
---
 drivers/clk/hisilicon/clk-hi3559a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index ff4ca0edce06..4623befafaec 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -491,7 +491,6 @@ static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
 
 		clk = clk_register(NULL, &p_clk->hw);
 		if (IS_ERR(clk)) {
-			devm_kfree(dev, p_clk);
 			dev_err(dev, "%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
 			continue;
-- 
2.43.0


