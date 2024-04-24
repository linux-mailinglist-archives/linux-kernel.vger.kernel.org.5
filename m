Return-Path: <linux-kernel+bounces-157144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCAF8B0D61
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4904228A94C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E7115EFD5;
	Wed, 24 Apr 2024 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gqigxi7m"
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8915EFB0;
	Wed, 24 Apr 2024 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970679; cv=none; b=Q7DWvT+4RpRuDnLK7ENk5TM5tC87+rbJgalBriZmp+U8XisstLcclM3botiiLUJ6hEhY9xnVKBlrD9ovbmsrG3bNIKOneQbC6SqugHrzWR5UjgaVkwVuo66/ApwAqlNI93vaioYXYoDopVsMSP+7ZxjTi+8U8NKNNLCPh7WXtAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970679; c=relaxed/simple;
	bh=Tkm/ZL2BucURiAvXPcBT2Jhd9yaHdg76lUCFgS1SDpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yt0tyTWIxjvvHkuJ+6+ifGi9NZwe/xtlOoGNY5P66SSkGz/V/DkS3XQcRaCoYfJDtxSTaGp6wAnkGRCV2g2Z09skYTHrlQ5SkxqTCV/FIAjFZTOHZlgZTH9pUYp/Gd6oAJ1G2QzHokkWEtoVM+kTYFdb6mI85a4yQouW7PUzVNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gqigxi7m; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id zdvHrVBipBgCpzdvHrXTtd; Wed, 24 Apr 2024 16:48:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713970118;
	bh=GysVhjc3jwVBUnjotsdi6hoQgzGItSC3vfYl+wJfA7Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gqigxi7matvvstvzj9pbU7drkXFb1U8gb11FLCkw8HOVd0G1h45y+Dq2DXQJamyrF
	 ieSSch/8E80FXzwJZ/yhnfIAMrvre/kyh4gU3ycrJ43YAprtaXsQ77hWeIfgTk97zb
	 jbBp3JaWVEZaMxmya7lfKxokGCuVV7YsykFGM91vGiQYg/oPvegJSX/M01DrZFc3CG
	 wHgJ+mWFVg8w9Hv1+2YtX/BLwgi8c5/wEKTjg6yqpgjS/oP5jeKo0c4JaDYYgmKa30
	 Zh1p+m5pBoDpf7uayHkroOPxygV0p+pAgkF7LOsdhXrJlVkvcU7TgsHKFVmD3hxtJe
	 3g0pvLpCWWG1g==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Apr 2024 16:48:38 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] clk: rockchip: Remove some unused fields in struct rockchip_mmc_clock
Date: Wed, 24 Apr 2024 16:48:29 +0200
Message-ID: <410bc0f86c7b9f1c80f8a4e9a2a028a9a6ee1ec0.1713970085.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct rockchip_mmc_clock", the 'id' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

Apparently, it has never been used. It is not a left-over from a
refactoring.
---
 drivers/clk/rockchip/clk-mmc-phase.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-mmc-phase.c b/drivers/clk/rockchip/clk-mmc-phase.c
index 975454a3dd72..91012078681b 100644
--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -14,7 +14,6 @@
 struct rockchip_mmc_clock {
 	struct clk_hw	hw;
 	void __iomem	*reg;
-	int		id;
 	int		shift;
 	int		cached_phase;
 	struct notifier_block clk_rate_change_nb;
-- 
2.44.0


