Return-Path: <linux-kernel+bounces-143741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3353A8A3CDF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C699B212A1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9918E405EB;
	Sat, 13 Apr 2024 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="d0Csj6yW"
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29F732C85;
	Sat, 13 Apr 2024 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713016488; cv=none; b=TgYxkHT7TMsj+1PVK2PcU5i82E6j+lqSdKGt2P0pi+DObYDTZY4lutEmvi2pjbj6KhE2yb9ErKYzTyHcKdzYXcg8/lllrPDuzQsOjPKDbdSBjKsB2kc5mOgdGoCmMiN5rOglKQP5zHZPmsqZaTcHMuy7D6QQGKkuhtkn7ntYcms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713016488; c=relaxed/simple;
	bh=lIKOY/N7NdxyrWTbLzUc+FdHr7lWJIAJfXrhcEYWq2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gk1sJfXl75f4DDO+rVrFZMihvXBC/CkECY+S6QK2y7Tu6jeduzRPtTGfgYzmECfRTxH5FK+n8B0iHBFEp0L7tYVsC9S6e0inRGHn+i2fXnaslLWqDcaoiI6rLmf7I8kdzdEcRB+Eqn/k+wlb1xK4dgVkGM8+qzKqz8W4I7mHbKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=d0Csj6yW; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vdq1rRHRmiEBqvdq1rAZqK; Sat, 13 Apr 2024 15:54:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713016478;
	bh=ZS4vUeFYwEkQ9aWyFlLyMV25A71DyDHcYUN9aidfiBg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=d0Csj6yW8sntfA95ecykUziTGCULujUK3VycGs2HmPX34Ks9kEPnczfdBzbl//i94
	 kgks39YLgxvcCQjIX8pJzmYM/qS4TlLSKvXiTL/98cnVVlj5YEme3Y9YMUx1AVIBRQ
	 JPjGadkvi7rF/aFku9s+aSrzqzRCG6uWrNDEpXie5IOhVhK4IXg/RWT5P0pH2LPyFk
	 qnkbTZiYwknfdN1EuU+enu6yN9S0nY5eJMpqCQL7D+WLbrWO5+NBFUDQBHBlmsyT3V
	 bBTv97BWbQzGaiA3Iq0Lq1MirdguN5zjdfIFMqtTtaPAsnvKaz68BaURYoZVZN+dg5
	 YrDrayre+XGiQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 13 Apr 2024 15:54:38 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-clk@vger.kernel.org
Subject: [PATCH] clk: highbank: Remove an unused field in struct hb_clk
Date: Sat, 13 Apr 2024 15:54:35 +0200
Message-ID: <90b19f2af3077075d4254e01d5ae919c423d067e.1713016457.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct hb_clk", the 'parent_name' field is unused.

Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

Apparently, it has never been used. It is not a left-over from a
refactoring.
---
 drivers/clk/clk-highbank.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/clk-highbank.c b/drivers/clk/clk-highbank.c
index 2a0cea2946f9..6e68a41a70a1 100644
--- a/drivers/clk/clk-highbank.c
+++ b/drivers/clk/clk-highbank.c
@@ -37,7 +37,6 @@
 struct hb_clk {
         struct clk_hw	hw;
 	void __iomem	*reg;
-	char *parent_name;
 };
 #define to_hb_clk(p) container_of(p, struct hb_clk, hw)
 
-- 
2.44.0


