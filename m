Return-Path: <linux-kernel+bounces-32276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDDE835952
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2829B2823FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6054B4C98;
	Mon, 22 Jan 2024 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ogz9f/Wn"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE664C87
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705890218; cv=none; b=m+ejXRxbnQZhUglMocSYvfnL0urIg8UxMJrXbesHfodVWAJy80X5UMPa4Ha/jAJfjvuY9EeWJfLp/T83FmY62hr/vp/W/jWUR0ifY3PiFcQ5tMVCeW9chUNDRLGCVugqvX26ud1uGkYKnuX+1PD9JR+v96JAakTk/BaoL2/uc+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705890218; c=relaxed/simple;
	bh=SrjGkBt4ws/L7TjHduCftjvbL8f6eEJFzr2T3hjmFk0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MCYTYSDUkog4pezyQQ8q/eV7TZnl9ZTucw3WDxQEyOmnlvfpjo09c2JeCWId3pjTTuy8FL+gOXpK1AzpnMnGImef/d4XDaMm1fR2CdRBQct9vz/Mr5dzp+9rF8XIKeFKA2HNqQvDEkiD0uDk6W9WKrah5OqmgqetBnn+2mfVwJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ogz9f/Wn; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3723d14eb8cd11ee9e680517dc993faa-20240122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bRxKAlBcxk+wjGn9fgIoumEgOFMc9m85oqcebArTOQs=;
	b=Ogz9f/WnjJkKND+iWq8RxdlEuTaMO/8DZT2p/bxdhTQawN9iZUfIPI7Rtl+KO1Ea+oyyJzZ1liRc0J35skL0Fm0ewaq6T5bqpdWGO6vNXO/7VaxA+1m3qPOci+Fo8pwhYZr8FIf1tkYunr8Uj9oPF+iwbaZK9OI1X9pO3x0D/1A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:ccd3e91b-b6a8-44eb-a738-2a7388ec1eae,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6e16cf4,CLOUDID:6af17f8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 3723d14eb8cd11ee9e680517dc993faa-20240122
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <haiqiang.gong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1256969273; Mon, 22 Jan 2024 10:23:22 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 Jan 2024 10:23:21 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 Jan 2024 10:23:20 +0800
From: Haiqiang Gong <Haiqiang.Gong@mediatek.com>
To: <linux-kernel@vger.kernel.org>
CC: <haiqiang.gong@mediatek.com>, <mike.zhang@mediatek.com>, Andrew Morton
	<akpm@linux-foundation.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Haiqiang Gong
	<Haiqiang.Gong@mediatek.com>
Subject: [PATCH] mm/compaction: add check mechanism to avoid cma alloc fail
Date: Mon, 22 Jan 2024 10:23:17 +0800
Message-ID: <20240122022317.30091-1-Haiqiang.Gong@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.251100-8.000000
X-TMASE-MatchedRID: riRbj5ZX+8qJ+w2BcN2shkZakoam9+aeKFFZAe4nyZ6M2ehTV+imi/+i
	UQ058Mu6pSxgXQCmVD5G77nj4gxZpFXkr5xNB8EcyeVujmXuYYUzTWEsGiZW/N9RlPzeVuQQMSu
	S6JxBG64Cym2hDB78TgykqSdZGSoeZMLMXtQ7bzGJLx4p0P/u5AYX4TqbN42omyiLZetSf8mfop
	0ytGwvXiq2rl3dzGQ1ropAi/FV10xvOMKV9GJxgt1zlJ6cDFtyq0Ik/XvnkHxi4XnZ0i355d/T4
	9kdKys+
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.251100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	AC853335170166E5CE942A0222C21DE05826A344C137900CD90F48576EEBCC162000:8

cma alloc may fail when we doing cma alloc/free test on kernel 5.10/5.15.

We found that the next memory cannot be migrated because of the alloc of
fs as next backtrace:
__alloc_pages_nodemask
pagecache_get_page
grow_dev_page
__getblk_gfp
ext4_sb_breadahead_unmovable
__ext4_get_inode_loc
__ext4_iget
ext4_lookup
__lookup_slow
walk_component
path_lookupat
filename_lookup
vfs_statx
This kind of unmovable memory is not placed in the cma buffer when kernel
memory alloc but is migrated in by kcompactd when the kernel migration.
It will cause memory can't be migrate when cma alloc.

Add check mechanism in the compaction_alloc() where kcompaced alloc for
memory. Will return NULL and give up this memory migration if the
allocated memory is in the cma buffer and the memory is unmovable.

Signed-off-by: Haiqiang Gong <Haiqiang.Gong@mediatek.com>
---
 mm/compaction.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 27ada42924d5..29c0661adc22 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -25,6 +25,11 @@
 #include <linux/psi.h>
 #include "internal.h"
 
+#ifdef CONFIG_CMA
+#include <linux/cma.h>
+#include "cma.h"
+#endif
+
 #ifdef CONFIG_COMPACTION
 /*
  * Fragmentation score check interval for proactive compaction purposes.
@@ -1758,6 +1763,33 @@ static void isolate_freepages(struct compact_control *cc)
 	split_map_pages(freelist);
 }
 
+#ifdef CONFIG_CMA
+static bool is_in_cma_range(struct folio *folio)
+{
+	int i;
+	unsigned long pfn = 0;
+	struct page *page = folio_page(folio, 0);
+
+	pfn = page_to_pfn(page);
+	for (i = 0; i < cma_area_count; i++) {
+		struct cma *cma = &cma_areas[i];
+
+		if (cma->base_pfn <= pfn && (cma->base_pfn + cma->count) > pfn)
+			return true;
+	}
+
+	return false;
+}
+
+static bool forbid_move_to_cma_range(struct folio *src, struct folio *dst)
+{
+	if (folio_mapping(src) && is_in_cma_range(dst))
+		return true;
+
+	return false;
+}
+#endif
+
 /*
  * This is a migrate-callback that "allocates" freepages by taking pages
  * from the isolated freelists in the block we are migrating to.
@@ -1775,6 +1807,12 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	}
 
 	dst = list_entry(cc->freepages.next, struct folio, lru);
+#ifdef CONFIG_CMA
+	if (forbid_move_to_cma_range(src, dst)) {
+		pr_notice("kcompactd: could not move non-cma memory to cma buffer\n");
+		return NULL;
+	}
+#endif
 	list_del(&dst->lru);
 	cc->nr_freepages--;
 
-- 
2.25.1


