Return-Path: <linux-kernel+bounces-151086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF668AA8E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69BF28292B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E242F5A;
	Fri, 19 Apr 2024 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqOLtkT5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E83EA8C;
	Fri, 19 Apr 2024 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510637; cv=none; b=c3QcBl8Md7JNsrgOvwZGCaCl/SFYd93vYx6xPS3skO2Tid4/inx3pLInz3B10y0+M52Yf/hgmHEFlE6TRAox5T3U99QSmmX3cUp//OrvuQ+0FqPYrJrFlF6kRXFxCN94IARL4N77sjLuaL7bkAhCzvQXlhjvF8G3VGacOub14Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510637; c=relaxed/simple;
	bh=AD2YHgpvG3H1bwnNHY2V5QplwYDpTc/UYjGIYty3wdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=otG1en5ZfBtbMYc+OTdMoKMXiO+nSYcpS8fReQxVmYL/watwCFHQ1jgng9kamDb38/Ah7sCVncTHZqetZZgH3Fsj6i7dGsV9GnCm/6a5C+K4X9gwURYYGNMdVYoP4oWW9eQtcL40Z8vfazGxiFqD6EYizexdZtpRHQQWAqUiJuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqOLtkT5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713510636; x=1745046636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AD2YHgpvG3H1bwnNHY2V5QplwYDpTc/UYjGIYty3wdU=;
  b=EqOLtkT5tr9SGqqHdLl3vFcZ2ZTIKoGS+Ds9UZ9UhR5vU9L4w7u+8OBU
   bZpOLlXedi+CskYZBBCmr/kOme69i6B1ExpIU9kkjoWPZqhPM5ygho/3G
   fBzfhDi5LNKjz0zR6+wbcEhAe+vbriOHNEXDZzWl/333iuxlG548N0CTI
   lnUPfnJ/hHwaEdGotw9ml3NeucJfo3CTRMrRWwe2s4n9Df531CsKpPKrP
   1IDba5gSRHCJX+1Ie4rsxRO0L3Xw2A4tcPu6eI6Anv6mP4Zkl5VRcv+qJ
   NP0vMsuPTFgcc4gVYexDUKWM6e5dh4/WhP1lYfzCmEcA7a+3X0bajZo8l
   Q==;
X-CSE-ConnectionGUID: A3JCxkVVT4OEzA5uKxRnzw==
X-CSE-MsgGUID: Ial6hy2gSGSjGLsaaDIBmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="26611864"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="26611864"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 00:10:35 -0700
X-CSE-ConnectionGUID: NeBMEeEGTJCPTYLRBQzKDw==
X-CSE-MsgGUID: Kw3X5Z8JSa2fgD2kvIx/pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="54451876"
Received: from lxia1-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.214.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 00:10:31 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ak@linux.intel.com,
	kan.liang@linux.intel.com
Subject: [PATCH 2/3] perf/x86/intel/cstate: Add Arrowlake support
Date: Fri, 19 Apr 2024 15:10:18 +0800
Message-Id: <20240419071019.1103953-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419071019.1103953-1-rui.zhang@intel.com>
References: <20240419071019.1103953-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like Alderlake, Arrowlake supports CC1/CC6/CC7 and PC2/PC3/PC6/PC8/PC10.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/intel/cstate.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index b304430ba64a..22e8f2687349 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,7 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
- *					  MTL,SRF,GRR
+ *					  MTL,SRF,GRR,ARL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -53,30 +53,31 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						GRR
+ *						GRR,ARL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
- *						ICL,TGL,RKL,ADL,RPL,MTL
+ *						ICL,TGL,RKL,ADL,RPL,MTL,ARL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL
+ *						RPL,SPR,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
  *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
- *						ADL,RPL,MTL
+ *						ADL,RPL,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
- *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF
+ *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
+ *						ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -86,7 +87,7 @@
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
  *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL,
- *						ADL,RPL,MTL
+ *						ADL,RPL,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
@@ -95,7 +96,7 @@
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT,RKL,ADL,RPL,MTL
+ *						TNT,RKL,ADL,RPL,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
  *			       perf code: 0x00
@@ -765,6 +766,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&adl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		&adl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H,		&adl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.34.1


