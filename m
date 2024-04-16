Return-Path: <linux-kernel+bounces-147567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812088A7645
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D701F2377B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57111369B8;
	Tue, 16 Apr 2024 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqV7EpTo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7546E611
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302402; cv=none; b=czQvgDVh/hkaoijMKJBK0jjx11pRLdBWUc/5yypdRqNTDNU6A6tahmwp3f8213TWfC5O1SydaNbhR2URvKmwV3zUIVoUOfnAqXjuHykG30g2ZQ7DHk7Q1qIK4pEMgWV9nll/0elbsI1M3xsmwxHKIdmbRAroQj8bQRaQIjm+9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302402; c=relaxed/simple;
	bh=XAPDGw5vqm4R68C0iiGxVia58si6InFh20Tr6Ma0z9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aB2dqZs03qyVoceEXuoUjVlxK1dMmdiX9yE3PPutCpcfWD76qkVA1JdW2IoDY08543WVGtp2TVZzzFiPb7ZzJCQVufSZFdb/n7O0PHjhdTRAwTkXV4LZi0Go1eeFqDkGnaYdZBnBrLhj09K6WUqZUbNUkfO3LtDI4Utt5Wx3bF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqV7EpTo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302401; x=1744838401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XAPDGw5vqm4R68C0iiGxVia58si6InFh20Tr6Ma0z9k=;
  b=PqV7EpToLp55rLP8rzMsK/QakOUwivmB3eJBYwiCV2rMGlwB1WbqThhf
   J2aMGGBDd6VSC2o0EFSXNoxTzB9DBZh1bo99HqNbypWuteo86DY1D1sDQ
   fp/Xqx0vCBTU8fco3tMnBDrLTveRZ/U3xDF2WXwW9H8b+fw0lLRtkhlNW
   lhx3IRMiQqRpIEGxga+tT7rnbgT2kk242ET5nxInNi41HRZirOBWWeV13
   RNxU01ll4Y6/jMKuPf79mxumDhb9jGXuGkn2lTCzrPA8uCYyka7qMVm6r
   bvPgSC8QFB6EZ+ktI8QzODt7L2PoxqknZpf+xwu9FG0yDfWC37gLArBz5
   w==;
X-CSE-ConnectionGUID: CyHOV44mSvSBVqvDdZvT+w==
X-CSE-MsgGUID: dadmQX4yRL2itI2tAXvWJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914696"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914696"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:58 -0700
X-CSE-ConnectionGUID: uxQp+azUSZO8TQtcABg0JA==
X-CSE-MsgGUID: yal2XiSEQgahQSb+YlVWiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871894"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:57 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 07/74] x86/cpu/vfm: Update arch/x86/events/intel/lbr.c
Date: Tue, 16 Apr 2024 14:19:09 -0700
Message-ID: <20240416211941.9369-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416211941.9369-1-tony.luck@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/events/intel/lbr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 78cd5084104e..86277196ffad 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -2,6 +2,7 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/perf_event.h>
 #include <asm/msr.h>
 
@@ -1457,7 +1458,7 @@ void __init intel_pmu_lbr_init_atom(void)
 	 * to have an operational LBR which can freeze
 	 * on PMU interrupt
 	 */
-	if (boot_cpu_data.x86_model == 28
+	if (boot_cpu_data.x86_vfm == INTEL_ATOM_BONNELL
 	    && boot_cpu_data.x86_stepping < 10) {
 		pr_cont("LBR disabled due to erratum");
 		return;
-- 
2.44.0


