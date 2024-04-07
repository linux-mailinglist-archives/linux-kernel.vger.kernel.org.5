Return-Path: <linux-kernel+bounces-134631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4A889B3E1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD83281B03
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7BB3FB80;
	Sun,  7 Apr 2024 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qvs10VBO"
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165F03EA93;
	Sun,  7 Apr 2024 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712520197; cv=none; b=WAGJKuXX1EgYrOmV8WJrVrAvcZbyeJTDO1INGnOnkKMW5imnoB1lNV2zNdS387gbRCsXnASEV0k3e5OefHyXDl5/4wYnw5S5lmUd2YQsHDYehTfSO1xMkFEoyZRYmpi+bRrL2n8ltzNkPl5BRb+IYYbkkitIdMCZRZkFSnyVDCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712520197; c=relaxed/simple;
	bh=lHqg1QJCxrsNhs4z4v/Y14TlaLQ598KsjsJ/Pyg4uMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbN5LdtnGNPjXGHspKLjWAvo7vpXEX3OscEDdkoqVzvfLJTwqo6ZK/q01sNzd0dDr1LJCUHnKUUgrCNHI138JLv2fqJtzlXa8o+MLSTsWyTZcbc1mGTVdyTYoYtQfzVjAhMmojIzU/jbJp0FYGvMB2oqbBX06KviMXTUTB/sH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qvs10VBO; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id tYiBrICUDz1OZtYiJrfStr; Sun, 07 Apr 2024 22:02:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1712520125;
	bh=yDBPh3Zd5MPQHTnfbxFeCnae77YFIui58j4SxgeMCkQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qvs10VBOaOJ7o7KEE3sCJ1qbBrUcBXVDTAqkSfuaumV8kz1YI/wUFqQCBed3AqJ4R
	 WW9w1d1LT+Pa1WfjBHBOiD5W9T6ozKlp2uYEujckaXwRLcePiUBTE/qa2cLxOh3qhj
	 S7bk4U7p9jur8kb5szZBdHfstJ6yS/P5BUUAvG2da6/reJuu/Uu7TVbpLYSZ8hIhED
	 X2Y6+UD2jq7xgj6B6xCuzalrhTepBK/dHLHCu5ml/p+pEvUl53XJ5MtceIdCU6/fTY
	 iQUdYdBqAnyNKl4jajCq1mMvX3alsRr4vn5jBA9D7wIYD3ocMw2HwzPf4hnenOfz6l
	 IPjEMwU4liSHA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Apr 2024 22:02:05 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] thermal/drivers/mediatek/lvts_thermal: Improve some memory allocation
Date: Sun,  7 Apr 2024 22:01:49 +0200
Message-ID: <8cb69f245311a348164b0b5ca3dbc59386746035.1712520052.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <42a87fb9837f1760d1ad4eb7162a7536785dc6f5.1712520052.git.christophe.jaillet@wanadoo.fr>
References: <42a87fb9837f1760d1ad4eb7162a7536785dc6f5.1712520052.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lvts_debugfs_init() is called with lvts_td->num_lvts_ctrl being 2, 3 or 4.
sizeof(struct debugfs_regset32) is small. 32 byres on a x86_64.

So, given the overhead of devm_kzalloc(), it is better to allocate all
needed regset at once.

The overhead of devm_kzalloc() is 40 bytes on a x86_64, and because of
rounding in memory allocation, it leads to:
 2 * (32 + 40) = 2 * 72	--> 2 96 bytes allocations for a total of 192 bytes
 3 * (32 + 40) = 3 * 72	--> 3 96 bytes allocations for a total of 288 bytes
 4 * (32 + 40) = 4 * 72	--> 4 96 bytes allocations for a total of 384 bytes

using a single devm_kcalloc():
 2 * 32 + 40 = 104	--> 1 allocation for a total of 128
 3 * 32 + 40 = 136	--> 1 allocation for a total of 192
 4 * 32 + 40 = 168	--> 1 allocation for a total of 192

So, this saves both a few bytes and reduce memory fragmentation.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 drivers/thermal/mediatek/lvts_thermal.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 3003dc350766..b133f731c5ba 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -204,7 +204,7 @@ static const struct debugfs_reg32 lvts_regs[] = {
 
 static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 {
-	struct debugfs_regset32 *regset;
+	struct debugfs_regset32 *regsets;
 	struct lvts_ctrl *lvts_ctrl;
 	struct dentry *dentry;
 	char name[64];
@@ -214,8 +214,14 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 	if (IS_ERR(lvts_td->dom_dentry))
 		return 0;
 
+	regsets = devm_kcalloc(dev, lvts_td->num_lvts_ctrl,
+			       sizeof(*regsets), GFP_KERNEL);
+	if (!regsets)
+		return 0;
+
 	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
 
+		struct debugfs_regset32 *regset = &regsets[i];
 		lvts_ctrl = &lvts_td->lvts_ctrl[i];
 
 		sprintf(name, "controller%d", i);
@@ -223,10 +229,6 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 		if (IS_ERR(dentry))
 			continue;
 
-		regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
-		if (!regset)
-			continue;
-
 		regset->base = lvts_ctrl->base;
 		regset->regs = lvts_regs;
 		regset->nregs = ARRAY_SIZE(lvts_regs);
-- 
2.44.0


