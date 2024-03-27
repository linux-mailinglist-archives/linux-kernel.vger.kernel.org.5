Return-Path: <linux-kernel+bounces-120875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169A888DFFC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9491F2DB61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D03F142E66;
	Wed, 27 Mar 2024 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDTAfM+3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145F142911;
	Wed, 27 Mar 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541455; cv=none; b=AJdmHc1k+J0c/KyImksnoTYRxhHj+Rm76rutTNAFPgAe8nUO4onnCMrFHZMwsQYryxsUzX/r5fMK9m+dPDDsvFRyMJRsv3YY+90dTSS8zIcgbPwNP6iGpbqfUXbymmVke7h0BB+umIZig6Po3xdvZ6Es5ZLixOvXiKdE8A2QvhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541455; c=relaxed/simple;
	bh=fqH/vwRWApc26Sbipm6ozbFEBw4FdYS/8zFOtx/kQCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j55t26EDNQrafXRFO/q4W/WZRVlgZzttS+ETGXWjaDwZOpom+K3FN0StKyPU5PGy4HZ7+wKy7gcWKCXvrtz9uXKpXkpUxahFon/t8Q8h3otVQDko5t56Tvend3Wg6Ao1t/tzRY6hDAO38nLleDl5yXJo9r73yCaU96Als0AI/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDTAfM+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81180C433F1;
	Wed, 27 Mar 2024 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541455;
	bh=fqH/vwRWApc26Sbipm6ozbFEBw4FdYS/8zFOtx/kQCs=;
	h=From:To:Cc:Subject:Date:From;
	b=XDTAfM+3cg6Y7XqSxg+1xaNWYwjdsa8D39/Ya/iEp1PqR5n6v861ihotLLVuI4tPB
	 FxaBz/CwDosoXk6GOlNEDVnEeYxe6fvtaES6AfS/GV3qKOcNhnugZw642n/vwsmi3V
	 kFNoQ8KMZEbEjqh/piEuvBq9PwkKoogJtPW9iSpL3yg6wwzvh+PxGzVp8R3uztll4P
	 EWUpLWsf/hkcZNg3ZOPggWwiskzAZGEG5G+6qzUgpV5A5+ddoNWahsfPKM6mexMaQb
	 KE4wn51zEBLEA72WdogYXOKuBJ86Y3iy9pHaNM3PI/l0ecpzsWCEHfZECXVGDVh/9f
	 vmGjbYhWdo9Ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	miquel.raynal@bootlin.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "mtd: rawnand: Ensure all continuous terms are always in sync" failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:10:53 -0400
Message-ID: <20240327121053.2828334-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6fb075fca63c3486612986eeff84ed4179644038 Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 23 Feb 2024 12:55:45 +0100
Subject: [PATCH] mtd: rawnand: Ensure all continuous terms are always in sync

While crossing a LUN boundary, it is probably safer (and clearer) to
keep all members of the continuous read structure aligned, including the
pause page (which is the last page of the lun or the last page of the
continuous read). Once these members properly in sync, we can use the
rawnand_cap_cont_reads() helper everywhere to "prepare" the next
continuous read if there is one.

Fixes: bbcd80f53a5e ("mtd: rawnand: Prevent crossing LUN boundaries during sequential reads")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240223115545.354541-4-miquel.raynal@bootlin.com
---
 drivers/mtd/nand/raw/nand_base.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index d6a27e08b1127..4d5a663e4e059 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1232,6 +1232,15 @@ static void rawnand_cap_cont_reads(struct nand_chip *chip)
 		chip->cont_read.pause_page = rawnand_last_page_of_lun(ppl, first_lun);
 	else
 		chip->cont_read.pause_page = chip->cont_read.last_page;
+
+	if (chip->cont_read.first_page == chip->cont_read.pause_page) {
+		chip->cont_read.first_page++;
+		chip->cont_read.pause_page = min(chip->cont_read.last_page,
+						 rawnand_last_page_of_lun(ppl, first_lun + 1));
+	}
+
+	if (chip->cont_read.first_page >= chip->cont_read.last_page)
+		chip->cont_read.ongoing = false;
 }
 
 static int nand_lp_exec_cont_read_page_op(struct nand_chip *chip, unsigned int page,
@@ -1298,12 +1307,11 @@ static int nand_lp_exec_cont_read_page_op(struct nand_chip *chip, unsigned int p
 	if (!chip->cont_read.ongoing)
 		return 0;
 
-	if (page == chip->cont_read.pause_page &&
-	    page != chip->cont_read.last_page) {
-		chip->cont_read.first_page = chip->cont_read.pause_page + 1;
-		rawnand_cap_cont_reads(chip);
-	} else if (page == chip->cont_read.last_page) {
+	if (page == chip->cont_read.last_page) {
 		chip->cont_read.ongoing = false;
+	} else if (page == chip->cont_read.pause_page) {
+		chip->cont_read.first_page++;
+		rawnand_cap_cont_reads(chip);
 	}
 
 	return 0;
@@ -3510,10 +3518,7 @@ static void rawnand_cont_read_skip_first_page(struct nand_chip *chip, unsigned i
 		return;
 
 	chip->cont_read.first_page++;
-	if (chip->cont_read.first_page == chip->cont_read.pause_page)
-		chip->cont_read.first_page++;
-	if (chip->cont_read.first_page >= chip->cont_read.last_page)
-		chip->cont_read.ongoing = false;
+	rawnand_cap_cont_reads(chip);
 }
 
 /**
-- 
2.43.0





