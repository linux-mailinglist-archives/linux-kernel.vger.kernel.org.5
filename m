Return-Path: <linux-kernel+bounces-139196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37C089FFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EB01C240D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAB31836CD;
	Wed, 10 Apr 2024 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2oToFOs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928D181323;
	Wed, 10 Apr 2024 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773567; cv=none; b=eVElcq4VorQ+pHdbdTb4KBkeiShRumtX6iLnCLPqxFm30fiDMGd5izR5puXn9g9nRrrTdsx/9PxsMTjwno1Fg1wG6TPzno7gUBlhOOuHpCjTaBPflU1Po+uFOiONbM8iD1ihjmoKRmYAX2TqtUcAd+qJjgjN/1UbO8sNrKkVbmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773567; c=relaxed/simple;
	bh=GVmH+kv/HkN/3oKiH/OAZRZFAl6rXWV6hfpIh+kFE40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b68xSNDjK6NW5VeIVAFjV/a0GqOSYzFmGH61pBxJr4mNpPyIbkgu1/MWkHc0L9BCaKAT739kjUUovE/QlaAdrJsRJBTHbWZUS8gsqjF2d8HX1C/9k/pjA88La0df3NtADmNtEaEfX8x5N395yZVIoqRwM+RvY/HntAutVm4oElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2oToFOs; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712773566; x=1744309566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GVmH+kv/HkN/3oKiH/OAZRZFAl6rXWV6hfpIh+kFE40=;
  b=R2oToFOsJpVXSbicmYIZQiaoNYNiPFzyVYBjzNPoCrqtE/aGPVWrzKfI
   XXk16fmpw4t7S1dqw89Y7lkoi6tENEtRZhEU22RCAw6XEAPE2ulIJcNuY
   3KYrplToeUehtQMlSiPYEzcZzF64oPFsjlxldjscDDIYcU91QT+F7osYz
   It8VzJUUn10Hiwzp2vtxDsEIxz4YDDczqJijnuAhrnlK8xIY7kQZfPQRD
   F3oMcvBHHDbE22DuXBZ2H/7Wai4BUAdhzRSy/rS+epARYlY1JsL+dC2+2
   CWv/UGRMcSY7vTWat8kwnOa/+hVMpcTXxXbRIWtPhfBQ4yviES67xA6bp
   Q==;
X-CSE-ConnectionGUID: oPoxMtHpQxSu2qPljxSmrQ==
X-CSE-MsgGUID: HeBzod0NRtmBdpIamE5kAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19583701"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="19583701"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 11:26:01 -0700
X-CSE-ConnectionGUID: /RQHGd8TTwyHwQ8jxnevoA==
X-CSE-MsgGUID: azUsSHElRM6erjrckWZhIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="21232433"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2024 11:26:00 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	x86@kernel.org,
	cgroups@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	sohil.mehta@intel.com,
	tim.c.chen@linux.intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com,
	chrisyan@microsoft.com
Subject: [PATCH v11 08/14] x86/sgx: Add basic EPC reclamation flow for cgroup
Date: Wed, 10 Apr 2024 11:25:52 -0700
Message-Id: <20240410182558.41467-9-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410182558.41467-1-haitao.huang@linux.intel.com>
References: <20240410182558.41467-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristen Carlson Accardi <kristen@linux.intel.com>

Currently in the EPC page allocation, the kernel simply fails the
allocation when the current EPC cgroup fails to charge due to its usage
reaching limit.  This is not ideal. When that happens, a better way is
to reclaim EPC page(s) from the current EPC cgroup (and/or its
descendants) to reduce its usage so the new allocation can succeed.

Add the basic building blocks to support per-cgroup reclamation.

Currently the kernel only has one place to reclaim EPC pages: the global
EPC LRU list.  To support the "per-cgroup" EPC reclaim, maintain an LRU
list for each EPC cgroup, and introduce a "cgroup" variant function to
reclaim EPC pages from a given EPC cgroup and its descendants.

Currently the kernel does the global EPC reclaim in sgx_reclaim_page().
It always tries to reclaim EPC pages in batch of SGX_NR_TO_SCAN (16)
pages.  Specifically, it always "scans", or "isolates" SGX_NR_TO_SCAN
pages from the global LRU, and then tries to reclaim these pages at once
for better performance.

Implement the "cgroup" variant EPC reclaim in a similar way, but keep
the implementation simple: 1) change sgx_reclaim_pages() to take an LRU
as input, and return the pages that are "scanned" and attempted for
reclamation (but not necessarily reclaimed successfully); 2) loop the
given EPC cgroup and its descendants and do the new sgx_reclaim_pages()
until SGX_NR_TO_SCAN pages are "scanned".

This implementation, encapsulated in sgx_cgroup_reclaim_pages(), always
tries to reclaim SGX_NR_TO_SCAN pages from the LRU of the given EPC
cgroup, and only moves to its descendants when there's no enough
reclaimable EPC pages to "scan" in its LRU.  It should be enough for
most cases.

Note, this simple implementation doesn't _exactly_ mimic the current
global EPC reclaim (which always tries to do the actual reclaim in batch
of SGX_NR_TO_SCAN pages): when LRUs have less than SGX_NR_TO_SCAN
reclaimable pages, the actual reclaim of EPC pages will be split into
smaller batches _across_ multiple LRUs with each being smaller than
SGX_NR_TO_SCAN pages.

A more precise way to mimic the current global EPC reclaim would be to
have a new function to only "scan" (or "isolate") SGX_NR_TO_SCAN pages
_across_ the given EPC cgroup _AND_ its descendants, and then do the
actual reclaim in one batch.  But this is unnecessarily complicated at
this stage.

Alternatively, the current sgx_reclaim_pages() could be changed to
return the actual "reclaimed" pages, but not "scanned" pages. However,
the reclamation is a lengthy process, forcing a successful reclamation
of predetermined number of pages may block the caller for too long. And
that may not be acceptable in some synchronous contexts, e.g., in
serving an ioctl().

With this building block in place, add synchronous reclamation support
in sgx_cgroup_try_charge(): trigger a call to
sgx_cgroup_reclaim_pages() if the cgroup reaches its limit and the
caller allows synchronous reclaim as indicated by s newly added
parameter.

A later patch will add support for asynchronous reclamation reusing
sgx_cgroup_reclaim_pages().

Note all reclaimable EPC pages are still tracked in the global LRU thus
no per-cgroup reclamation is actually active at the moment. Per-cgroup
tracking and reclamation will be turned on in the end after all
necessary infrastructure is in place.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V11:
- Use commit message suggested by Kai
- Remove "usage" comments for functions. (Kai)

V10:
- Simplify the signature by removing a pointer to nr_to_scan (Kai)
- Return pages attempted instead of reclaimed as it is really what the
cgroup caller needs to track progress. This further simplifies the design.
- Merge patch for exposing sgx_reclaim_pages() with basic synchronous
reclamation. (Kai)
- Shorten names for EPC cgroup functions. (Jarkko)
- Fix/add comments to justify the design (Kai)
- Separate out a helper for for addressing single iteration of the loop
in sgx_cgroup_try_charge(). (Jarkko)

V9:
- Add comments for static variables. (Jarkko)

V8:
- Use width of 80 characters in text paragraphs. (Jarkko)
- Remove alignment for substructure variables. (Jarkko)

V7:
- Reworked from patch 9 of V6, "x86/sgx: Restructure top-level EPC reclaim
function". Do not split the top level function (Kai)
- Dropped patches 7 and 8 of V6.
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 119 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |   5 +-
 arch/x86/kernel/cpu/sgx/main.c       |  45 ++++++----
 arch/x86/kernel/cpu/sgx/sgx.h        |   1 +
 4 files changed, 148 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index ff4d4a25dbe7..74d403d1e0d4 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -9,16 +9,128 @@
 static struct sgx_cgroup sgx_cg_root;
 
 /**
- * sgx_cgroup_try_charge() - try to charge cgroup for a single EPC page
+ * sgx_cgroup_lru_empty() - check if a cgroup tree has no pages on its LRUs
+ * @root:	Root of the tree to check
  *
+ * Return: %true if all cgroups under the specified root have empty LRU lists.
+ */
+static bool sgx_cgroup_lru_empty(struct misc_cg *root)
+{
+	struct cgroup_subsys_state *css_root;
+	struct cgroup_subsys_state *pos;
+	struct sgx_cgroup *sgx_cg;
+	bool ret = true;
+
+	/*
+	 * Caller must ensure css_root ref acquired
+	 */
+	css_root = &root->css;
+
+	rcu_read_lock();
+	css_for_each_descendant_pre(pos, css_root) {
+		if (!css_tryget(pos))
+			break;
+
+		rcu_read_unlock();
+
+		sgx_cg = sgx_cgroup_from_misc_cg(css_misc(pos));
+
+		spin_lock(&sgx_cg->lru.lock);
+		ret = list_empty(&sgx_cg->lru.reclaimable);
+		spin_unlock(&sgx_cg->lru.lock);
+
+		rcu_read_lock();
+		css_put(pos);
+		if (!ret)
+			break;
+	}
+
+	rcu_read_unlock();
+
+	return ret;
+}
+
+/**
+ * sgx_cgroup_reclaim_pages() - reclaim EPC from a cgroup tree
+ * @root:	The root of cgroup tree to reclaim from.
+ *
+ * This function performs a pre-order walk in the cgroup tree under the given
+ * root, attempting to reclaim pages at each node until a fixed number of pages
+ * (%SGX_NR_TO_SCAN) are attempted for reclamation. No guarantee of success on
+ * the actual reclamation process. In extreme cases, if all pages in front of
+ * the LRUs are recently accessed, i.e., considered "too young" to reclaim, no
+ * page will actually be reclaimed after walking the whole tree.
+ */
+static void sgx_cgroup_reclaim_pages(struct misc_cg *root)
+{
+	struct cgroup_subsys_state *css_root;
+	struct cgroup_subsys_state *pos;
+	struct sgx_cgroup *sgx_cg;
+	unsigned int cnt = 0;
+
+	 /* Caller must ensure css_root ref acquired */
+	css_root = &root->css;
+
+	rcu_read_lock();
+	css_for_each_descendant_pre(pos, css_root) {
+		if (!css_tryget(pos))
+			break;
+		rcu_read_unlock();
+
+		sgx_cg = sgx_cgroup_from_misc_cg(css_misc(pos));
+		cnt += sgx_reclaim_pages(&sgx_cg->lru);
+
+		rcu_read_lock();
+		css_put(pos);
+
+		if (cnt >= SGX_NR_TO_SCAN)
+			break;
+	}
+
+	rcu_read_unlock();
+}
+
+static int __sgx_cgroup_try_charge(struct sgx_cgroup *epc_cg)
+{
+	if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE))
+		return 0;
+
+	/* No reclaimable pages left in the cgroup */
+	if (sgx_cgroup_lru_empty(epc_cg->cg))
+		return -ENOMEM;
+
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
+	return -EBUSY;
+}
+
+/**
+ * sgx_cgroup_try_charge() - try to charge cgroup for a single EPC page
  * @sgx_cg:	The EPC cgroup to be charged for the page.
+ * @reclaim:	Whether or not synchronous EPC reclaim is allowed.
  * Return:
  * * %0 - If successfully charged.
  * * -errno - for failures.
  */
-int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg)
+int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
 {
-	return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, sgx_cg->cg, PAGE_SIZE);
+	int ret;
+
+	for (;;) {
+		ret = __sgx_cgroup_try_charge(sgx_cg);
+
+		if (ret != -EBUSY)
+			return ret;
+
+		if (reclaim == SGX_NO_RECLAIM)
+			return -ENOMEM;
+
+		sgx_cgroup_reclaim_pages(sgx_cg->cg);
+		cond_resched();
+	}
+
+	return 0;
 }
 
 /**
@@ -43,6 +155,7 @@ static void sgx_cgroup_free(struct misc_cg *cg)
 
 static void sgx_cgroup_misc_init(struct misc_cg *cg, struct sgx_cgroup *sgx_cg)
 {
+	sgx_lru_init(&sgx_cg->lru);
 	cg->res[MISC_CG_RES_SGX_EPC].priv = sgx_cg;
 	sgx_cg->cg = cg;
 }
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index 0ecb170830f1..4ec5d8753084 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -20,7 +20,7 @@ static inline struct sgx_cgroup *sgx_get_current_cg(void)
 
 static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg) { }
 
-static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg)
+static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
 {
 	return 0;
 }
@@ -33,6 +33,7 @@ static inline void sgx_cgroup_init(void) { }
 
 struct sgx_cgroup {
 	struct misc_cg *cg;
+	struct sgx_epc_lru_list lru;
 };
 
 static inline struct sgx_cgroup *sgx_cgroup_from_misc_cg(struct misc_cg *cg)
@@ -63,7 +64,7 @@ static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
 	put_misc_cg(sgx_cg->cg);
 }
 
-int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg);
+int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim);
 void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
 void sgx_cgroup_init(void);
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 552455365761..b79c1d6cdc23 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -286,11 +286,14 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 	mutex_unlock(&encl->lock);
 }
 
-/*
- * Take a fixed number of pages from the head of the active page pool and
- * reclaim them to the enclave's private shmem files. Skip the pages, which have
- * been accessed since the last scan. Move those pages to the tail of active
- * page pool so that the pages get scanned in LRU like fashion.
+/**
+ * sgx_reclaim_pages() - Attempt to reclaim a fixed number of pages from an LRU
+ * @lru:	The LRU from which pages are reclaimed.
+ *
+ * Take a fixed number of pages from the head of a given LRU and reclaim them to
+ * the enclave's private shmem files. Skip the pages, which have been accessed
+ * since the last scan. Move those pages to the tail of the list so that the
+ * pages get scanned in LRU like fashion.
  *
  * Batch process a chunk of pages (at the moment 16) in order to degrade amount
  * of IPI's and ETRACK's potentially required. sgx_encl_ewb() does degrade a bit
@@ -298,8 +301,10 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
  * + EWB) but not sufficiently. Reclaiming one page at a time would also be
  * problematic as it would increase the lock contention too much, which would
  * halt forward progress.
+ *
+ * Return:	Number of pages attempted for reclamation.
  */
-static void sgx_reclaim_pages(void)
+unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru)
 {
 	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
 	struct sgx_backing backing[SGX_NR_TO_SCAN];
@@ -310,10 +315,9 @@ static void sgx_reclaim_pages(void)
 	int ret;
 	int i;
 
-	spin_lock(&sgx_global_lru.lock);
+	spin_lock(&lru->lock);
 	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
-		epc_page = list_first_entry_or_null(&sgx_global_lru.reclaimable,
-						    struct sgx_epc_page, list);
+		epc_page = list_first_entry_or_null(&lru->reclaimable, struct sgx_epc_page, list);
 		if (!epc_page)
 			break;
 
@@ -328,7 +332,7 @@ static void sgx_reclaim_pages(void)
 			 */
 			epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 	}
-	spin_unlock(&sgx_global_lru.lock);
+	spin_unlock(&lru->lock);
 
 	for (i = 0; i < cnt; i++) {
 		epc_page = chunk[i];
@@ -351,9 +355,9 @@ static void sgx_reclaim_pages(void)
 		continue;
 
 skip:
-		spin_lock(&sgx_global_lru.lock);
-		list_add_tail(&epc_page->list, &sgx_global_lru.reclaimable);
-		spin_unlock(&sgx_global_lru.lock);
+		spin_lock(&lru->lock);
+		list_add_tail(&epc_page->list, &lru->reclaimable);
+		spin_unlock(&lru->lock);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 
@@ -379,6 +383,8 @@ static void sgx_reclaim_pages(void)
 
 		sgx_free_epc_page(epc_page);
 	}
+
+	return cnt;
 }
 
 static bool sgx_should_reclaim(unsigned long watermark)
@@ -387,6 +393,11 @@ static bool sgx_should_reclaim(unsigned long watermark)
 	       !list_empty(&sgx_global_lru.reclaimable);
 }
 
+static void sgx_reclaim_pages_global(void)
+{
+	sgx_reclaim_pages(&sgx_global_lru);
+}
+
 /*
  * sgx_reclaim_direct() should be called (without enclave's mutex held)
  * in locations where SGX memory resources might be low and might be
@@ -395,7 +406,7 @@ static bool sgx_should_reclaim(unsigned long watermark)
 void sgx_reclaim_direct(void)
 {
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		sgx_reclaim_pages();
+		sgx_reclaim_pages_global();
 }
 
 static int ksgxd(void *p)
@@ -418,7 +429,7 @@ static int ksgxd(void *p)
 				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
-			sgx_reclaim_pages();
+			sgx_reclaim_pages_global();
 
 		cond_resched();
 	}
@@ -572,7 +583,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 	int ret;
 
 	sgx_cg = sgx_get_current_cg();
-	ret = sgx_cgroup_try_charge(sgx_cg);
+	ret = sgx_cgroup_try_charge(sgx_cg, reclaim);
 	if (ret) {
 		sgx_put_cg(sgx_cg);
 		return ERR_PTR(ret);
@@ -600,7 +611,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
-		sgx_reclaim_pages();
+		sgx_reclaim_pages_global();
 		cond_resched();
 	}
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 81bdff099d69..828d30cd18fa 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -135,6 +135,7 @@ void sgx_reclaim_direct(void);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim);
+unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru);
 
 void sgx_ipi_cb(void *info);
 
-- 
2.25.1


