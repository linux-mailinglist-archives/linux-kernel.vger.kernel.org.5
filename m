Return-Path: <linux-kernel+bounces-127402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37004894AD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2844D1C21AF8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7D317BD8;
	Tue,  2 Apr 2024 05:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="krFd6x85"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F40CA6F;
	Tue,  2 Apr 2024 05:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712035578; cv=none; b=c8AJfuvG/yRmCwMr6F8qU6hArg8hdQH/ClEdXwf3MHaZxJaS0wK2MM60olfP1gQLVsOKULxtOdmDmluDc84DdsaRNQKj67sC51L5A74G1LxciI8XSM1vdrbulApO36qZQuMdLll60Bvm1Q8Oh/68pWmptxMgsjNOmpl/cDGFIn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712035578; c=relaxed/simple;
	bh=WtUDqbuarXEIgkevhlTVfLHVbMrMQHOYBjHuxT1cJ54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL6U4ZmHvYMWfmmuxY2eosfk8DDH+X+tQMHN7IGkgaERFD8SY3MDoH+XdN+mY+lnFbR6t160y3jqW9/A8HO4GX3CUEH1ft02NgAHqP9BdUpwrBiKeWeM/bD3hMHuVlR1/M8WIA1qaay0qdb1zbQiBzMWyozQIujjzxvp/ZVdljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=krFd6x85; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7t2WjsmH8l5lF/Pmb1Te6bnqZx4BXhCY++fg2NjSv5c=; b=krFd6x850goqIRx5xWkc8LQbPX
	L1dVt9sISoRBhDUDFdjSOa+piX61bhGbbqw9U0isYl17RkNU8lWzACm/gP/t2y6ANPlSuHGH5aNxa
	4g/8D1C2AHt5QAzmbLYw+HSLhkvlnuD1V+feTdMOCwfZdZX4UCL33os5bnrdVnHIiM/GOosC+VvdT
	KBibFwG2gIRfqLeaB4LCXAauvUp7WgKgOD1wcsbz2/amhCfiz71r3erRdjAVppW28F3YMBivo9g9x
	VqfGKcCzgQI3TRVb0RtvEMFjDlTKEtQP1WO6aE2p0dLKjQKlwTUwZjKzjt1E/QptSTmaP6bWy/WUn
	dbRihOuA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrWev-00000002HaX-2ykM;
	Tue, 02 Apr 2024 05:26:10 +0000
Date: Tue, 2 Apr 2024 06:26:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	ltp@lists.linux.it, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 7/9] mm: Free up PG_slab
Message-ID: <ZguW8RtudvsJaHLq@casper.infradead.org>
References: <20240321142448.1645400-8-willy@infradead.org>
 <202403312344.c0d273ab-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403312344.c0d273ab-oliver.sang@intel.com>

On Sun, Mar 31, 2024 at 11:11:10PM +0800, kernel test robot wrote:
> kernel test robot noticed "UBSAN:shift-out-of-bounds_in_fs/proc/page.c" on:
> 
> commit: 30e5296811312a13938b83956a55839ac1e3aa40 ("[PATCH 7/9] mm: Free up PG_slab")

Quite right.  Spotted another one while I was at it.  Not able to test
right now, but this should do the trick:

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 5bc82828c6aa..55b01535eb22 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -175,6 +175,8 @@ u64 stable_page_flags(const struct page *page)
 		u |= 1 << KPF_OFFLINE;
 	if (PageTable(page))
 		u |= 1 << KPF_PGTABLE;
+	if (folio_test_slab(folio))
+		u |= 1 << KPF_SLAB;
 
 #if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
 	u |= kpf_copy_bit(k, KPF_IDLE,          PG_idle);
@@ -184,7 +186,6 @@ u64 stable_page_flags(const struct page *page)
 #endif
 
 	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
-	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
 	u |= kpf_copy_bit(k, KPF_ERROR,		PG_error);
 	u |= kpf_copy_bit(k, KPF_DIRTY,		PG_dirty);
 	u |= kpf_copy_bit(k, KPF_UPTODATE,	PG_uptodate);
diff --git a/tools/cgroup/memcg_slabinfo.py b/tools/cgroup/memcg_slabinfo.py
index 1d3a90d93fe2..270c28a0d098 100644
--- a/tools/cgroup/memcg_slabinfo.py
+++ b/tools/cgroup/memcg_slabinfo.py
@@ -146,12 +146,11 @@ def detect_kernel_config():
 
 
 def for_each_slab(prog):
-    PGSlab = 1 << prog.constant('PG_slab')
-    PGHead = 1 << prog.constant('PG_head')
+    PGSlab = ~prog.constant('PG_slab')
 
     for page in for_each_page(prog):
         try:
-            if page.flags.value_() & PGSlab:
+            if page.page_type.value_() == PGSlab:
                 yield cast('struct slab *', page)
         except FaultError:
             pass

