Return-Path: <linux-kernel+bounces-113422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE514888432
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787AC288102
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113381A8A6D;
	Sun, 24 Mar 2024 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdwNPz1P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C811A8A52;
	Sun, 24 Mar 2024 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320224; cv=none; b=gboF1kTtzfS4TVU/VfaqLUyemKqXHxVDW6ixh5nW30v394CRhOdqYixSuADsCcH3vQU5wb1Uk+iQBisF1rCdrGY8ya7XbaJWLyYZ7+UjB+s1JpBqi3NoABcTcYcCCeIVCzXk/M3XO/0T6ELSQ+zHBg29f/OHbiIRe5ZOzNOw4iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320224; c=relaxed/simple;
	bh=62r4vxA+IA//AviHhGf5YTaoys7+pFLJ6dOAi0DvKK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlP3UOeLLFsaH3ANvQ2o8He9jzObXUwuZ2LFQ6J96GsBFw/Nd8r6uN2G8gAQzgreiOBdKRPLGU7ss5UvpHsLCm5/SDHA/W/s0PfW+uY1VXZyvPt+zrrSmv/G/LZfMtFIE4Vk0wwscM/r1WaZPziajGMNgUH0EmB9YjEgCaGenN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdwNPz1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE0FC433C7;
	Sun, 24 Mar 2024 22:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320224;
	bh=62r4vxA+IA//AviHhGf5YTaoys7+pFLJ6dOAi0DvKK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WdwNPz1POgYdbsNQA4SHP9r13FvDRUUvu3hW2P49RNGevyAfKteWonAto5umO++/h
	 lMEBxiiUNjpX2I0EnvBAx4ss4ycDHlsNHTwxikklC9Ly5PQW/Xwve1z/Rnx6nFPV8I
	 RzvO+C0sS5d56YuzNXT7SOTlXoO3bJeQnG5MYg0ptPYZ6h/MQvi0FS7S6NPMjwxCUq
	 upPHNE4xsFJT330g2+BfZcLV6u4EMNQ3njpNoP1ML46+45LpWP8Zb+gKvgXaZeyVK4
	 46tAXeykd1BZqkGgOoek+b0zACDnRHTgZaH1he/j/XcoUO5MT/hwVE+pVXlFyoBAox
	 C3Nwl/3PC/VKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 531/715] mtd: maps: sun_uflash: Declare uflash_devinit static
Date: Sun, 24 Mar 2024 18:31:50 -0400
Message-ID: <20240324223455.1342824-532-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Sam Ravnborg <sam@ravnborg.org>

[ Upstream commit 6892982316846d4c40d12b0641d59519d868a784 ]

This fixes the following warning:
sun_uflash.c:50:5: error: no previous prototype for 'uflash_devinit'

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Fixes: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes globally")
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Link: https://lore.kernel.org/r/20240224-sam-fix-sparc32-all-builds-v2-3-1f186603c5c4@ravnborg.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/maps/sun_uflash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
index f58cfb15d6e85..b69dade3f7ad0 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -47,7 +47,7 @@ struct map_info uflash_map_templ = {
 	.bankwidth =	UFLASH_BUSWIDTH,
 };
 
-int uflash_devinit(struct platform_device *op, struct device_node *dp)
+static int uflash_devinit(struct platform_device *op, struct device_node *dp)
 {
 	struct uflash_dev *up;
 
-- 
2.43.0


