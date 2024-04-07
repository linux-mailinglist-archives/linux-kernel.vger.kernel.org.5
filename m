Return-Path: <linux-kernel+bounces-134202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B835B89AEEB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5BF2820A7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C26747F;
	Sun,  7 Apr 2024 06:49:51 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5AB6AB9
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712472591; cv=none; b=AmhJca/rRDRPsFroVjG00appD1oF3WTcDuLftZF6/MfmOMWPCvb8NLMIyf+u7Pq5zcYcmvpmNHCtYIFwfQM4vJeo90APxu6dNGHeSXjBZ1tSBG0X2C7Zmx2a7HFb7QCmBzYIzxTSU9nS9lKq2epBSr3vupdOat8FUOxyCUqLk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712472591; c=relaxed/simple;
	bh=VzBgMWIipo8dvuOwdfeJHy93Ig+nMTsHCDqomq9vKyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f8CiVFVQxGiwTTM9R20D7lSvhQLH4Gbwyx3xsDGMYMkdSA9dC7Z2Pzpk3Q4HEzQRDNmnsxdvCQE98GnOVg76cH/Mqmue722RYor/6I5ENQfCkiDUvrEPtUOdDDrBUPezy10E5xYEUCf3jQByebhibrphXDHIfYHYFwWssxeu4VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 853831faf4a911eeaf09c5092e5928d1-20240407
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:6a87ddd8-a97e-488c-b23f-a506d9702244,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:9
X-CID-INFO: VERSION:1.1.37,REQID:6a87ddd8-a97e-488c-b23f-a506d9702244,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:9
X-CID-META: VersionHash:6f543d0,CLOUDID:d014e1c5571e26ea1f8e0c8013bf06fb,BulkI
	D:240407143903GLJEOIN6,BulkQuantity:0,Recheck:0,SF:66|38|25|72|19|44|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
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
X-UUID: 853831faf4a911eeaf09c5092e5928d1-20240407
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 181228655; Sun, 07 Apr 2024 14:39:01 +0800
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
Subject: [PATCH] mm/mmap: make accountable_mapping return bool
Date: Sun,  7 Apr 2024 14:38:43 +0800
Message-Id: <20240407063843.804274-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

accountable_mapping can return bool,so we change it

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ac219f1689e0..e37dd5c9ffee 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1549,14 +1549,14 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
  * We account for memory if it's a private writeable mapping,
  * not hugepages and VM_NORESERVE wasn't set.
  */
-static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
+static inline bool accountable_mapping(struct file *file, vm_flags_t vm_flags)
 {
 	/*
 	 * hugetlb has its own accounting separate from the core VM
 	 * VM_HUGETLB may not be set yet so we cannot check for that flag.
 	 */
 	if (file && is_file_hugepages(file))
-		return 0;
+		return false;
 
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
 }
-- 
2.25.1


