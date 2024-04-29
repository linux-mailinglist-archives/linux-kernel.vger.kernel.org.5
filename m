Return-Path: <linux-kernel+bounces-162102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1208B55D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD411C21AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52D93BB43;
	Mon, 29 Apr 2024 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlPSGjih"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8816A3BBFE;
	Mon, 29 Apr 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387916; cv=none; b=iRrGoCjBruUy7EKJQ9mckGxc1OcZ/A4OS+L8XZQwD57C+cYNw40GOyk6EoKbC03K+I2SxZtK7puqkvUfON6l3AcJxtb/6C/eHr4Szp4Y/bUBFCoiX+oiEjSURqziHw5oVA9qCKOE298GcnEQtMKig6cdxZmaCO9EVhvuLgaHq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387916; c=relaxed/simple;
	bh=g81innlEewrLFposHO2uObGU0GQGyQGxN7UIEasnQRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xb7RHP04h2/0dwYAIJLLhwG2lhVPhYhTmu6Y3RQi4BNg4fzACTyA24xwpTYUE1koJw4HYbIlwENJ8VOWF0FQz0JL/2TPXMTS8ExUN7wOl1OCek9Q4M7ByF387lSdUvpX2VajzJ79PLUMws/q9DmshqoNrzyQr3PwMtZylY6tmks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlPSGjih; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387915; x=1745923915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g81innlEewrLFposHO2uObGU0GQGyQGxN7UIEasnQRw=;
  b=MlPSGjihbac1a2A/7vw08QHkhTkjqJ47uVn/6Z4n8Ptm0qiNz/3NNmhp
   mBZCRSNAuDI1yWCKqSWZz4lLNGf5fZsQoXGI+H9eYLBclQdp89jE5TRvB
   ClCWIwQ9fh1qJ1m1ygENqP10ivYKEmE8cjBGuj4A1UaE8F77lvXnRBF0r
   4yBswBgXZnPvtKvFit94YRE0RmALh2GVf5LaJM9dxnp65WvGDKq4Ulhlv
   naZy0YnI9LxZ6yNkevNz+syyYO/0tZOrRT7kvL7RYl+hBcPAVN9wNZbSQ
   xRkTa5urLQa+KPmH9Z7ALJn89T3sXaBG8TvAIcnfli6Igf3Xg6BRG+Q1t
   A==;
X-CSE-ConnectionGUID: H5W5ZiVcQkGzXOeDUQCZSQ==
X-CSE-MsgGUID: 7oK2eF9ySESQluag8xXCMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10202101"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10202101"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:51:52 -0700
X-CSE-ConnectionGUID: c5Kmju7cSBmnBJr3bLpt4Q==
X-CSE-MsgGUID: 3RReAbxdQNqOxX/diGdDmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26590749"
Received: from mehlow-prequal01.jf.intel.com ([10.54.102.156])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:51:52 -0700
From: Dmitrii Kuvaiskii <dmitrii.kuvaiskii@intel.com>
To: dave.hansen@linux.intel.com,
	jarkko@kernel.org,
	kai.huang@intel.com,
	haitao.huang@linux.intel.com,
	reinette.chatre@intel.com,
	linux-sgx@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mona.vij@intel.com,
	kailun.qin@intel.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] x86/sgx: Resolve EREMOVE page vs EAUG page data race
Date: Mon, 29 Apr 2024 03:43:30 -0700
Message-Id: <20240429104330.3636113-3-dmitrii.kuvaiskii@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240429104330.3636113-1-dmitrii.kuvaiskii@intel.com>
References: <20240429104330.3636113-1-dmitrii.kuvaiskii@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10, 85579 Neubiberg, Germany
Content-Transfer-Encoding: 8bit

Two enclave threads may try to add and remove the same enclave page
simultaneously (e.g., if the SGX runtime supports both lazy allocation
and `MADV_DONTNEED` semantics). Consider this race:

1. T1 performs page removal in sgx_encl_remove_pages() and stops right
   after removing the page table entry and right before re-acquiring the
   enclave lock to EREMOVE and xa_erase(&encl->page_array) the page.
2. T2 tries to access the page, and #PF[not_present] is raised. The
   condition to EAUG in sgx_vma_fault() is not satisfied because the
   page is still present in encl->page_array, thus the SGX driver
   assumes that the fault happened because the page was swapped out. The
   driver continues on a code path that installs a page table entry
   *without* performing EAUG.
3. The enclave page metadata is in inconsistent state: the PTE is
   installed but there was no EAUG. Thus, T2 in userspace infinitely
   receives SIGSEGV on this page (and EACCEPT always fails).

Fix this by making sure that T1 (the page-removing thread) always wins
this data race. In particular, the page-being-removed is marked as such,
and T2 retries until the page is fully removed.

Fixes: 9849bb27152c ("x86/sgx: Support complete page removal")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitrii Kuvaiskii <dmitrii.kuvaiskii@intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c  | 3 ++-
 arch/x86/kernel/cpu/sgx/encl.h  | 3 +++
 arch/x86/kernel/cpu/sgx/ioctl.c | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 41f14b1a3025..7ccd8b2fce5f 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -257,7 +257,8 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 
 	/* Entry successfully located. */
 	if (entry->epc_page) {
-		if (entry->desc & SGX_ENCL_PAGE_BEING_RECLAIMED)
+		if (entry->desc & (SGX_ENCL_PAGE_BEING_RECLAIMED |
+				   SGX_ENCL_PAGE_BEING_REMOVED))
 			return ERR_PTR(-EBUSY);
 
 		return entry;
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index f94ff14c9486..fff5f2293ae7 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -25,6 +25,9 @@
 /* 'desc' bit marking that the page is being reclaimed. */
 #define SGX_ENCL_PAGE_BEING_RECLAIMED	BIT(3)
 
+/* 'desc' bit marking that the page is being removed. */
+#define SGX_ENCL_PAGE_BEING_REMOVED	BIT(2)
+
 struct sgx_encl_page {
 	unsigned long desc;
 	unsigned long vm_max_prot_bits:8;
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index b65ab214bdf5..c542d4dd3e64 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -1142,6 +1142,7 @@ static long sgx_encl_remove_pages(struct sgx_encl *encl,
 		 * Do not keep encl->lock because of dependency on
 		 * mmap_lock acquired in sgx_zap_enclave_ptes().
 		 */
+		entry->desc |= SGX_ENCL_PAGE_BEING_REMOVED;
 		mutex_unlock(&encl->lock);
 
 		sgx_zap_enclave_ptes(encl, addr);
-- 
2.34.1


