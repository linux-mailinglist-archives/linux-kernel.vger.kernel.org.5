Return-Path: <linux-kernel+bounces-147568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2338A7647
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14122844F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C88E13AA2C;
	Tue, 16 Apr 2024 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6dN4BvZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449BC6E61F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302403; cv=none; b=MQ+RDJouoP3wdCU2Yyd4pa1eypRSBnrgajUqKsCiRiMMwLZUEYtZ++ZZoj5m8nSEAnV/RdSTsQiXmfO26TgorIUtxtXkTMSSuTTjsfW5IGwEf34r6E0lYA1TIYhSg4n2eMJjgtgfit16uTysWVUQP/myA4BuaRJ1UQI1E/TmsX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302403; c=relaxed/simple;
	bh=dOmQ7jUeo78k2rwa4FbxrxxtpSbAveIjEYydSHsCBrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8EKsUy2HG3vx8BhC6g0UmwoeNjL+tLpfye9/MjwfkBy7UbN/6nkUmYFmwzkmH9xs6OFfvXzLhSXE23oOcR0tmZTyNuQvcVNW1+0wX3aKNMVLHJOopCC/upq5ZtT1MJioIyPIi6zwiMARuuSj1unYgGDKZZ8ygz1Ri9TJuBF7pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6dN4BvZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302401; x=1744838401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dOmQ7jUeo78k2rwa4FbxrxxtpSbAveIjEYydSHsCBrw=;
  b=X6dN4BvZgqoSWGBi0z4k3zNgEHWWjWkejQaEFHWEIZb8+kSmjLkvelYl
   CFe7KsfZtd4ctBh9/gOKnkx97POexKBZN8gFeShsc1NzaA+b5QB3Lq9Mp
   7/7JUWQAvUZ6fNxYLrDBOCAyuU1rg51ipdKtNdTVOCiRGICKpqqF9KOC1
   NWIFFJQnLX2fD5aFvS4XV7nXfTxjIgeulpkA+rogPdBc+SbL2FZ+2BY82
   lYsyRy/TcI7J/0LBMBJEjg/WBbXeHnxsu+V/8A0hm1/gsV4ejFzjzLM6K
   KmEnTzf/cbxA1masr/LqiVLYzmKFNgZWrur2fsDk/MOjwQ7YExYXLbrQj
   w==;
X-CSE-ConnectionGUID: rL/26N0bR22Y6+JOSt4QQg==
X-CSE-MsgGUID: lBmFJ3LHSQSZwPHTD6FFDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914700"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914700"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:58 -0700
X-CSE-ConnectionGUID: aR8oZ0HFSq2pax2xgW7KwQ==
X-CSE-MsgGUID: DeE0Jp8YTFuGRY5XaZsF+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871897"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:57 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 08/74] x86/cpu/vfm: Update arch/x86/events/intel/pt.c
Date: Tue, 16 Apr 2024 14:19:10 -0700
Message-ID: <20240416211941.9369-9-tony.luck@intel.com>
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
 arch/x86/events/intel/pt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 8e2a12235e62..e3320c2ee7c6 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -22,6 +22,7 @@
 #include <asm/insn.h>
 #include <asm/io.h>
 #include <asm/intel_pt.h>
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
 #include "../perf_event.h"
@@ -211,11 +212,11 @@ static int __init pt_pmu_hw_init(void)
 	}
 
 	/* model-specific quirks */
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_BROADWELL:
-	case INTEL_FAM6_BROADWELL_D:
-	case INTEL_FAM6_BROADWELL_G:
-	case INTEL_FAM6_BROADWELL_X:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_BROADWELL:
+	case INTEL_BROADWELL_D:
+	case INTEL_BROADWELL_G:
+	case INTEL_BROADWELL_X:
 		/* not setting BRANCH_EN will #GP, erratum BDM106 */
 		pt_pmu.branch_en_always_on = true;
 		break;
-- 
2.44.0


