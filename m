Return-Path: <linux-kernel+bounces-157452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929908B11D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED92284555
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2572316EBF8;
	Wed, 24 Apr 2024 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2YH92De"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6F116D9D8;
	Wed, 24 Apr 2024 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982490; cv=none; b=MPinb3uPWD99aAz/n2QtKDcrrnsM1iKuqMjTZU8T3Iki3mjWtmm/4F5YOtVPm5qH9I3mXO2gCEg+kA127RigVV/WkhhcdCEfZ7bNKdt096pWAbEmk5XpCI5mBS7/DClEjtH/rKWNcD+JeaRyfxXukTAsr1fAk5HJjgED8hv4BdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982490; c=relaxed/simple;
	bh=yQ5L+dbNHtvkAp/pj5zzra7nuxWzgvQKIkDpzo8Sudc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtVkeZqv2gDfdJDwSyY7LitSTwwyt1OK3Tjik3Mrm66zjjeZVlhmFlaqLP+8L6dLV/E0attbJuW3F9uEAdMg1wJ7RNZfSlEChv1xexfycgPFwctZ08UN6ND2qffygZStsa3zwzmK+f6H4OGGtIuMvmUVVjpNrwU0ruQBZySTENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2YH92De; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982488; x=1745518488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQ5L+dbNHtvkAp/pj5zzra7nuxWzgvQKIkDpzo8Sudc=;
  b=j2YH92DerdBsb3j2CULYHy6xGiznmxpCkIUbkRTODj0lmdYCglH8fuG7
   ZbSH8mm0KJvCtFL092gbtwibGfqA17bPjSQHCULZdtGYHFiG1ujcZFPPE
   UMWxSwlRfKOJB9wV5Ih6HATNUOJ+8EFJ+LISiYhLRhzzgqBI0r8g3KVc3
   Kdk+KR0iLDEWdjzO58FFddm5KlctBZrLqFow9264sKloLbT/Ej+RPx8Fg
   YQF2DwK+TKe+3fTLUkId0JT1by2aCFYLGxpqe5GceyVg8K5hBQAwdyB8r
   2BJiZnwxdzIUebt0MpMw9pTR0if7FSugLCXOhdW87DL/HjJh1Hl5njGH4
   Q==;
X-CSE-ConnectionGUID: Y05e2gROSh66M3N7mTXVlA==
X-CSE-MsgGUID: vspZE9jjSHqK3qMPnpoRbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503368"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503368"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:46 -0700
X-CSE-ConnectionGUID: mb43gOObTESWrDtc6+X6xA==
X-CSE-MsgGUID: NiRwbu/jRtevqmqHDB1oEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24683653"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:46 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Jithu Joseph <jithu.joseph@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 02/71] platform/x86/intel/ifs: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:14:45 -0700
Message-ID: <20240424181445.41193-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 7b11198d85a1..33412a584836 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -11,16 +11,15 @@
 
 #include "ifs.h"
 
-#define X86_MATCH(model, array_gen)				\
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,	\
-		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, array_gen)
+#define X86_MATCH(vfm, array_gen)				\
+	X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_CORE_CAPABILITIES, array_gen)
 
 static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
-	X86_MATCH(SAPPHIRERAPIDS_X, ARRAY_GEN0),
-	X86_MATCH(EMERALDRAPIDS_X, ARRAY_GEN0),
-	X86_MATCH(GRANITERAPIDS_X, ARRAY_GEN0),
-	X86_MATCH(GRANITERAPIDS_D, ARRAY_GEN0),
-	X86_MATCH(ATOM_CRESTMONT_X, ARRAY_GEN1),
+	X86_MATCH(INTEL_SAPPHIRERAPIDS_X, ARRAY_GEN0),
+	X86_MATCH(INTEL_EMERALDRAPIDS_X, ARRAY_GEN0),
+	X86_MATCH(INTEL_GRANITERAPIDS_X, ARRAY_GEN0),
+	X86_MATCH(INTEL_GRANITERAPIDS_D, ARRAY_GEN0),
+	X86_MATCH(INTEL_ATOM_CRESTMONT_X, ARRAY_GEN1),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
-- 
2.44.0


