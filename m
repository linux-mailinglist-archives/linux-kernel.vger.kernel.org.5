Return-Path: <linux-kernel+bounces-134206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E5689AEF3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9EC281BFE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6B618C05;
	Sun,  7 Apr 2024 06:53:55 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14571802E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712472834; cv=none; b=ObaJzkK/7aNvpkfn9Tk3OlsxnN5+InvJtI0vBh5nMAGELOkYhARqcpZZ55j8mu6Gc2AW+0auqrbrcO7zNNQ0U6axlUb/f6BKamthoZzBpqJuZpFSEEZjHWC318HJL4GlixmXNF80vDqrPOHvnjkIQrSnc2jG8Y+rPAk3zavJHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712472834; c=relaxed/simple;
	bh=NXBeI8nM38jsXftlPIL2RhoAHKBqMyKcR+Dp0rYNUtw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jL7LeWKOriEkuQpZ04UluE3qLNq59s8ZVXV8oUu/8Wt84E7TJG9vtu80H1DbKRh1jy8kXb72hKBbCbIdnorNoyGy33E6ySgb3Yqa1e/0OZ2q1Smh9Z1psBOVlqEGTC60LglUgxKqb3DrmyhwOwyVaT2S9MybXhpAWg6MvWIAWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: da943092f4a711eeaf09c5092e5928d1-20240407
X-CID-UNFAMILIAR: 1
X-CID-O-RULE: Release_Ham
X-CID-RULE: EDM_GE969F26
X-CID-O-INFO: VERSION:1.1.37,REQID:948c4543-3f8b-4a76-ab10-3baa5673adff,IP:15,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:12,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:2
X-CID-INFO: VERSION:1.1.37,REQID:948c4543-3f8b-4a76-ab10-3baa5673adff,IP:15,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:12,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:2
X-CID-META: VersionHash:6f543d0,CLOUDID:60e088d839de1bf4cdd3d3db2ff0b4a3,BulkI
	D:2404071427067MY2OJ0A,BulkQuantity:0,Recheck:0,SF:66|38|25|16|19|44|102,T
	C:nil,Content:0,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
	ZHF_RECV_LOCALHOST
X-UUID: da943092f4a711eeaf09c5092e5928d1-20240407
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1678508837; Sun, 07 Apr 2024 14:27:05 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	willy@infradead.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gehao618@163.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/mmap: make vma_wants_writenotify return bool
Date: Sun,  7 Apr 2024 14:26:53 +0800
Message-Id: <20240407062653.803142-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vma_wants_writenotify should return bool,so we change it

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 include/linux/mm.h |  2 +-
 mm/mmap.c          | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0436b919f1c7..e2f1374c43b0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2550,7 +2550,7 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 					    MM_CP_UFFD_WP_RESOLVE)
 
 bool vma_needs_dirty_tracking(struct vm_area_struct *vma);
-int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
+bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
 {
 	/*
diff --git a/mm/mmap.c b/mm/mmap.c
index 6dbda99a47da..ac219f1689e0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1514,32 +1514,32 @@ bool vma_needs_dirty_tracking(struct vm_area_struct *vma)
  * to the private version (using protection_map[] without the
  * VM_SHARED bit).
  */
-int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
+bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
 {
 	/* If it was private or non-writable, the write bit is already clear */
 	if (!vma_is_shared_writable(vma))
-		return 0;
+		return false;
 
 	/* The backer wishes to know when pages are first written to? */
 	if (vm_ops_needs_writenotify(vma->vm_ops))
-		return 1;
+		return true;
 
 	/* The open routine did something to the protections that pgprot_modify
 	 * won't preserve? */
 	if (pgprot_val(vm_page_prot) !=
 	    pgprot_val(vm_pgprot_modify(vm_page_prot, vma->vm_flags)))
-		return 0;
+		return false;
 
 	/*
 	 * Do we need to track softdirty? hugetlb does not support softdirty
 	 * tracking yet.
 	 */
 	if (vma_soft_dirty_enabled(vma) && !is_vm_hugetlb_page(vma))
-		return 1;
+		return true;
 
 	/* Do we need write faults for uffd-wp tracking? */
 	if (userfaultfd_wp(vma))
-		return 1;
+		return true;
 
 	/* Can the mapping track the dirty pages? */
 	return vma_fs_can_writeback(vma);
-- 
2.25.1


