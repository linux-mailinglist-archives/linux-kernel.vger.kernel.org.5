Return-Path: <linux-kernel+bounces-135306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E2189BEAB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF497B22B82
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEFA6A33F;
	Mon,  8 Apr 2024 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iC9iw0e8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B11169E07;
	Mon,  8 Apr 2024 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578167; cv=none; b=DCHSMtu3E+oBeSgsgTDaz9icsNnabuDNxDMZmRN2Wcz7eD/DD/H0I29uoT7IMEJiJy+Wqo/tNifLS1wMSbrqFqQHm74d251uOfPtcMlo+Dp5ga3R9YMBQ8M2zttR4Oph2v5d5X/g2QQ3IAJoBPQzQOI89io7OiWiHMr0EM/GCYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578167; c=relaxed/simple;
	bh=jMhyIsACrXJPq53fcYvr3d0wlQI+edXLZWNObmw9AEU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ECzZsqZNs7hKgo6+C5ebFigbpzfqrudL+Dt463PHKV3zMcgzkWg6pPbPs1uaxW4a7acx4DP6plTT4vqs9KqC2JLSl31C70/6AhsSKuMT9dDUqerBTt8gp4DT9StGzTANH84WRJ5A21vUBZ1dVEtyT/ArIRtfWANtxAOVFhhxYbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iC9iw0e8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712578165; x=1744114165;
  h=from:to:cc:subject:date:message-id;
  bh=jMhyIsACrXJPq53fcYvr3d0wlQI+edXLZWNObmw9AEU=;
  b=iC9iw0e8sQegLjGdWuR8hWOT4gN2X1+Uj5V8prrIaV8ff7Reo8YhciZ0
   vIDo8QGgYgQztzHJsKaG/0cSYr3v7TMAZiE2mz7m5QUh7Nd/s80aLRgUP
   pRFUpf6lxZogNnKoLsOEojOYuB4pNCupIVGQwbnA1qIIQqSweCRDFPy8j
   ucxpm5GZFRft03PUPz3SM+5gDmIh/Fh4jFBPxYQJ27aahF8RgoHB245YT
   49ppczSVri01YjLBF8QKJ9os/gIIkkbBvypftrWdgfeHiaTpOm0uk27e/
   WsCT6HYl0z2RDjN5ziUnW5vPn40r5tmSuiVc5iDDLqvALVoOQFSECRpnu
   g==;
X-CSE-ConnectionGUID: B1oEyCpeTkyBe5bQaYPKVQ==
X-CSE-MsgGUID: /rga3l4HR9uAFSj+8HN8DA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="18463659"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="18463659"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 05:09:24 -0700
X-CSE-ConnectionGUID: M5fgWsTQQRKekXUmxflf9g==
X-CSE-MsgGUID: Z3t4AKR7S8mEqSiz4pwDBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="57334813"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 05:09:23 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Aristeu Rozanski <aris@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/skx_common: Allow decoding of SGX addresses
Date: Mon,  8 Apr 2024 20:04:19 +0800
Message-Id: <20240408120419.50234-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

There are no "struct page" associations with SGX pages, causing the check
pfn_to_online_page() to fail. This results in the inability to decode the
SGX addresses and warning messages like:

  Invalid address 0x34cc9a98840 in IA32_MC17_ADDR

Add an additional check to allow the decoding of the error address and to
skip the warning message, if the error address is an SGX address.

Fixes: 1e92af09fab1 ("EDAC/skx_common: Filter out the invalid address")
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 9c5b6f8bd8bd..27996b7924c8 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -648,7 +648,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	memset(&res, 0, sizeof(res));
 	res.mce  = mce;
 	res.addr = mce->addr & MCI_ADDR_PHYSADDR;
-	if (!pfn_to_online_page(res.addr >> PAGE_SHIFT)) {
+	if (!pfn_to_online_page(res.addr >> PAGE_SHIFT) && !arch_is_platform_page(res.addr)) {
 		pr_err("Invalid address 0x%llx in IA32_MC%d_ADDR\n", mce->addr, mce->bank);
 		return NOTIFY_DONE;
 	}
-- 
2.17.1


