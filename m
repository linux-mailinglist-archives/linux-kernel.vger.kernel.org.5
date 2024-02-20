Return-Path: <linux-kernel+bounces-72288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E77F85B1A2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4085C28220E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990E457314;
	Tue, 20 Feb 2024 03:48:47 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6242A90
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400927; cv=none; b=eJp6U82BvTfIONAlhKLgL89qA6sfILTkxb3JlIauoKuoxjZg9x+Q018BA0xKzK2dyauuaZWaax7ihipRjnIuu8A4Qhoi9uM9FBXxDBTd9XPfehpDamNUK6rSpolKDAes4Glzvbp5aRkEvf6qdXeptccUdYJLwgEaC/Wtt8ANJ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400927; c=relaxed/simple;
	bh=9zPP/06aqtEGjkcTlwLNHLTPh3CxYzxxpdU+1Cgyaso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uaw4Io/LwS82dcJXPKp7vKx5R/HVmnN5b3cvbZH8dipbXr+EsC+OfKib+fSohTRnMvwIxX7g3+8Jcv/FoYoFOTYS0KPR3YTXRrl3ssTMhHL4GnE67lw/wd4ibsAbUMgZyDUdm+T5EioXG65IxYtq1N3Y1NW8vjwIEHzB9OhNBn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tf51P26KHz2BdDP;
	Tue, 20 Feb 2024 11:46:33 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 09ADB1402DE;
	Tue, 20 Feb 2024 11:48:41 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 20 Feb 2024 11:48:40 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <mawupeng1@huawei.com>,
	<bp@suse.de>, <mingo@redhat.com>, <rdunlap@infradead.org>,
	<bhelgaas@google.com>, <linux-mm@kvack.org>
Subject: [PATCH v4 2/3] x86/mm/pat: Cleanup unused parameter in follow_phys
Date: Tue, 20 Feb 2024 11:48:34 +0800
Message-ID: <20240220034835.507022-3-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220034835.507022-1-mawupeng1@huawei.com>
References: <20240220034835.507022-1-mawupeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200001.china.huawei.com (7.185.36.224)

From: Ma Wupeng <mawupeng1@huawei.com>

Parameter flags is always zero in caller untrack_pfn() and
track_pfn_copy(). let's drop it.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 arch/x86/mm/pat/memtype.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index d8c37aaaf041..5b56f08f8ce6 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -950,8 +950,7 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 		memtype_free(paddr, paddr + size);
 }
 
-static int follow_phys(struct vm_area_struct *vma,
-		unsigned long address, unsigned int flags,
+static int follow_phys(struct vm_area_struct *vma, unsigned long address,
 		unsigned long *prot, resource_size_t *phys)
 {
 	int ret = -EINVAL;
@@ -965,14 +964,10 @@ static int follow_phys(struct vm_area_struct *vma,
 		goto out;
 	pte = ptep_get(ptep);
 
-	if ((flags & FOLL_WRITE) && !pte_write(pte))
-		goto unlock;
-
 	*prot = pgprot_val(pte_pgprot(pte));
 	*phys = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
 
 	ret = 0;
-unlock:
 	pte_unmap_unlock(ptep, ptl);
 out:
 	return ret;
@@ -997,7 +992,7 @@ int track_pfn_copy(struct vm_area_struct *vma)
 		 * reserve the whole chunk covered by vma. We need the
 		 * starting address and protection from pte.
 		 */
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
+		if (follow_phys(vma, vma->vm_start, &prot, &paddr)) {
 			WARN_ON_ONCE(1);
 			return -EINVAL;
 		}
@@ -1084,7 +1079,7 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	/* free the chunk starting from pfn or the whole chunk */
 	paddr = (resource_size_t)pfn << PAGE_SHIFT;
 	if (!paddr && !size) {
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
+		if (follow_phys(vma, vma->vm_start, &prot, &paddr)) {
 			WARN_ON_ONCE(1);
 			return;
 		}
-- 
2.25.1


