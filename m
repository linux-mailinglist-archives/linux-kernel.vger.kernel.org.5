Return-Path: <linux-kernel+bounces-126817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503B4893D02
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF92280E79
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF2C47774;
	Mon,  1 Apr 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="IDWpuH0V"
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A898208D1;
	Mon,  1 Apr 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986089; cv=none; b=M03eAqiirt9E5jaMPjR66rcSmrsK9eF7RJNrkwd4FRzlanRkEMhXOePaRfv8FAcNy/g4WtjV2C/ZBPv2rstGWeHeifZP+PPOZfGEB08+lrjLrRSu7Pk38TxjoU4xHEPSS8OgHHGrUqfFO7B6XV1Z8FjRsPZd6F3chGkdMcztQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986089; c=relaxed/simple;
	bh=Y/Bj6IHFimK/L3bQZNyOgnhAWh2BT8FNakGZBoDEYtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CLh5nl7WQC3lii1UhLkk/QEYKVSLWKnHYATk5wZhdxiuW0GjSQpjaV7Kk7XyjdkeV3oDmOtBMV900Rqyec7/BJ8nit0+rjtQPBYtdrglLEWh6AljpmGCThsjmIjwo5UHTQiiG3EJwmq14jGM0kl7XVeoUnfAD+zV6JFvQBmn6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=IDWpuH0V; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id rJdfrt5eMFDStrJdfryokC; Mon, 01 Apr 2024 17:32:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1711985520;
	bh=HXJxPRAT/1ovZ08zVcfoBlF6cHXXFiWjqhU7B+IHfPk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IDWpuH0VtaQGNJrHB+Kmke7pWKxXeWu2l81BpKO/eq73sF1I/wnJZzDDo7zicuXwx
	 0Q6v4yp2nvdWIddFwiNicKVu6gwe9fLKAtSQqr1JW/MZs3AzA8/71gvplrbLwVEbtv
	 Lb177vNRMW/uOWMHzMeB2iRPqAjZ7jd1OMQn23I67ZxJNUkCgrprYtC+H5C12CAZZB
	 8azL/WIP1/uoELoviK6YRM+LjgmMW50FF6e6gYs5IihxZFk+eP4l7IfSWjrZIJQJ2Z
	 qHUzOAkf94+lViLj0ImVp7DT/5KTiIm0sX8rTGAfNr82XJUYN0h1Y7GFEdd1XX4OY5
	 PX7McXIfyIAnQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 Apr 2024 17:32:00 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clk: nxp: Remove an unused field in struct lpc18xx_pll
Date: Mon,  1 Apr 2024 17:31:53 +0200
Message-ID: <6cfb0e5251c3a59a156e70bcf6a0cc74aa764faa.1711985490.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct lpc18xx_pll", the 'lock' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/clk/nxp/clk-lpc18xx-cgu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/nxp/clk-lpc18xx-cgu.c b/drivers/clk/nxp/clk-lpc18xx-cgu.c
index 69ebf65081b8..81efa885069b 100644
--- a/drivers/clk/nxp/clk-lpc18xx-cgu.c
+++ b/drivers/clk/nxp/clk-lpc18xx-cgu.c
@@ -250,7 +250,6 @@ static struct lpc18xx_cgu_base_clk lpc18xx_cgu_base_clks[] = {
 struct lpc18xx_pll {
 	struct		clk_hw hw;
 	void __iomem	*reg;
-	spinlock_t	*lock;
 	u8		flags;
 };
 
-- 
2.44.0


