Return-Path: <linux-kernel+bounces-162101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DEE8B55D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FDB1C23096
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE833F8D6;
	Mon, 29 Apr 2024 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBcBjgMh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C813B1AA;
	Mon, 29 Apr 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387915; cv=none; b=RD3n3UF1jjv/ZDZQO8y3VJJ7D+4jUlJtEGj5EoXW4SWMoNu2jtkt+lHXofI1/pGAqZBrOUHIBuenw3eeqNICrDww6HbWAUgxDrqM7zRPVejALd/SRzGL/izj+6k0xW9xKz9evsqgifPWH9mmr1mY0I6V5TGT4FNoryddvpsZnpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387915; c=relaxed/simple;
	bh=SPji/tPmFFHL8U+kFt+PeP/ts0wBsLsJIjNj7rxU1N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eol/wdbGdHbzhvs4d10tDxL0Ouuzzo0q8FbafMz7xQUksS+xiCKFbE8TawfnpvgIxgyJAB9BalLMow8SEuSnyFzIeZdN9peC/kJfoL1w7zVRQSYrpcPLBOW3TipXlHbfXtralr/II3kxtMo1hvQYpevYy2W6GnwJRyOaxcyfB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBcBjgMh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387914; x=1745923914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SPji/tPmFFHL8U+kFt+PeP/ts0wBsLsJIjNj7rxU1N4=;
  b=EBcBjgMhea4o7vwWMNU+i63fvv/ZJiZZzdU3Ze5gWPVj+YoQYTJA8ksP
   JqdtwceLRyG2ACG7dGQDecn/N4+7C5rSyw7NNh2VpLpHqd88k9uG8JJ6Y
   ZB+jfYCLoZ8sseYWBvMdXZo7shp7kz47zUvdaqxn/rW3O23eEiRipgU4F
   vreyhkeZ4Yjh0gQNHwz/eeDemlKs0CkcOWCSrLIdc+Fto/zap40LsyFqz
   V/nypoeq/2LvJ8PSsCtw21DmZYQn7L/I68tcbJ2aAY6rsC1XAavZnGB7l
   CHBZFj/Ww1fntt4nK9ubgcn7bSjcl++NY6i3dWGKcEiigc7AowOO8md2O
   w==;
X-CSE-ConnectionGUID: a7fQyHSGTvSsWkGxjdeSSA==
X-CSE-MsgGUID: AyjNIbhTQq+TqGAditUk7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10202099"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10202099"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:51:52 -0700
X-CSE-ConnectionGUID: T52XsUMzQROgQuy3XeVlng==
X-CSE-MsgGUID: JduiRfhfSNCMK0T8ykORiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26590746"
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
	stable@vger.kernel.org,
	=?UTF-8?q?Marcelina=20Ko=C5=9Bcielnicka?= <mwk@invisiblethingslab.com>
Subject: [PATCH 1/2] x86/sgx: Resolve EAUG race where losing thread returns SIGBUS
Date: Mon, 29 Apr 2024 03:43:29 -0700
Message-Id: <20240429104330.3636113-2-dmitrii.kuvaiskii@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240429104330.3636113-1-dmitrii.kuvaiskii@intel.com>
References: <20240429104330.3636113-1-dmitrii.kuvaiskii@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10, 85579 Neubiberg, Germany
Content-Transfer-Encoding: 8bit

Two enclave threads may try to access the same non-present enclave page
simultaneously (e.g., if the SGX runtime supports lazy allocation). The
threads will end up in sgx_encl_eaug_page(), racing to acquire the
enclave lock. The winning thread will perform EAUG, set up the page
table entry, and insert the page into encl->page_array. The losing
thread will then get -EBUSY on xa_insert(&encl->page_array) and proceed
to error handling path.

This error handling path contains two bugs: (1) SIGBUS is sent to
userspace even though the enclave page is correctly installed by another
thread, and (2) sgx_encl_free_epc_page() is called that performs EREMOVE
even though the enclave page was never intended to be removed. The first
bug is less severe because it impacts only the user space; the second
bug is more severe because it also impacts the OS state by ripping the
page (added by the winning thread) from the enclave.

Fix these two bugs (1) by returning VM_FAULT_NOPAGE to the generic Linux
fault handler so that no signal is sent to userspace, and (2) by
replacing sgx_encl_free_epc_page() with sgx_free_epc_page() so that no
EREMOVE is performed.

Fixes: 5a90d2c3f5ef ("x86/sgx: Support adding of pages to an initialized enclave")
Cc: stable@vger.kernel.org
Reported-by: Marcelina Kościelnicka <mwk@invisiblethingslab.com>
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dmitrii Kuvaiskii <dmitrii.kuvaiskii@intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 279148e72459..41f14b1a3025 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -382,8 +382,11 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	 * If ret == -EBUSY then page was created in another flow while
 	 * running without encl->lock
 	 */
-	if (ret)
+	if (ret) {
+		if (ret == -EBUSY)
+			vmret = VM_FAULT_NOPAGE;
 		goto err_out_shrink;
+	}
 
 	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
 	pginfo.addr = encl_page->desc & PAGE_MASK;
@@ -419,7 +422,7 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 err_out_shrink:
 	sgx_encl_shrink(encl, va_page);
 err_out_epc:
-	sgx_encl_free_epc_page(epc_page);
+	sgx_free_epc_page(epc_page);
 err_out_unlock:
 	mutex_unlock(&encl->lock);
 	kfree(encl_page);
-- 
2.34.1


