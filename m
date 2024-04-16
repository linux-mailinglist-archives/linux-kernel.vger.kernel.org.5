Return-Path: <linux-kernel+bounces-147588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC6B8A765D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84D028340C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAF513DDD8;
	Tue, 16 Apr 2024 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQi7qAD8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B9B13C8EC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302412; cv=none; b=kR7x9bIu+HBtwx9Yp84mZrm/xSBGR0jf1VVyZSsQqe3ZnminzBXD9eInfafyJBVi0saNY9hlgKld53Bmrfon6pz7k4rhLAQMYUy//aedXmbgAio6+zo/ZpWh69AJzxfwoMgp9HNkRrUyXdC91SgwC2t2rDKnH8SbDo/r9Qa5BqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302412; c=relaxed/simple;
	bh=MGAFX/pQ0txb1l1dIq0DhSgBPKYTlahDlBrDWyImM3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arMYzNmNek+GQnIJMYX9A0WTKGlxHGHlEJI8FpvOLonGEQKgBrHjFXNuBHdeviQHdjcg3fDjy+1tHK2vBnK4wN5LPsqt0e4Ci0/UTf5PsI8VV/Y3gdFvz31dtbcIyjLZ8q8KTpds6zf8yw/Yu84srue3syo1YU3/tykvlFfVFsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQi7qAD8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302410; x=1744838410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MGAFX/pQ0txb1l1dIq0DhSgBPKYTlahDlBrDWyImM3Q=;
  b=aQi7qAD8mmCmyi4/GSQp1KaUXJXLnU+2IaxlogEfJkJuKSC/GSHyxyKL
   3WqJTnnZs96h+U2dmT2SUVR+qNf6nfgKNu7j/r1k9Gf6LXtDu0eb/+O/9
   /QWL81c9bIzrUpM6jpF/ih2x4KxewjmtGi7G/nn6JuymAMzGgBUz9aK8J
   pa/w+iEkPC4nZoxpYMIEv5UvS5qoK5wIxuhlwGshDm+BebywG5WjgyBKQ
   6dw+MQTeosgEfeXio4LHb9s5zr2S1Yzx8eUYnU7GKvfPdaW01waCD3Xkk
   /idSlFQSvc8JBcDlDFQ4zxKZjEuREhNsHdvtCHiyTPLOpPT+4usGYVbEe
   Q==;
X-CSE-ConnectionGUID: FunRbAVOSNGvToQPILthHQ==
X-CSE-MsgGUID: 5upppVCuQ2G1gIQN4Gckrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914793"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914793"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:01 -0700
X-CSE-ConnectionGUID: jJhUFNV0TXWPBYnGE9mawA==
X-CSE-MsgGUID: nzYOSGRJRrGUEhXD/tAq2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871983"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:00 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 27/74] x86/cpu/vfm: Update arch/x86/kernel/smpboot.c
Date: Tue, 16 Apr 2024 14:19:29 -0700
Message-ID: <20240416211941.9369-28-tony.luck@intel.com>
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
 arch/x86/kernel/smpboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a58109583c47..8dc83b16845b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -438,9 +438,9 @@ static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  */
 
 static const struct x86_cpu_id intel_cod_cpu[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X, 0),	/* COD */
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X, 0),	/* COD */
-	X86_MATCH_INTEL_FAM6_MODEL(ANY, 1),		/* SNC */
+	X86_MATCH_VFM(INTEL_HASWELL_X, 0),	/* COD */
+	X86_MATCH_VFM(INTEL_BROADWELL_X, 0),	/* COD */
+	X86_MATCH_VFM(INTEL_ANY, 1),		/* SNC */
 	{}
 };
 
-- 
2.44.0


