Return-Path: <linux-kernel+bounces-147599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BAD8A7668
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D24284690
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656313C90A;
	Tue, 16 Apr 2024 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzQWEfCG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E014386C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302417; cv=none; b=NVhZiObgKpHQeQ0fYupJzWHhkzjySZyN7C+FXO5HYxq/Tmqy5V+PNbpJhHHHihcefM9KzuY8tj8sE5wQLeu4/kryyY2dtxRpK2fDwIXxj6crEhRfZVRYqsM9B/y8fQAvXTw1MK2WbxS6tvY4kIgDV7Lm2P/zpoQSmZyBm4UWE8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302417; c=relaxed/simple;
	bh=LSVHB/ZFgQlGo/cpHX9BEf/V4nmVp0b/qXAMR2F9w/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAh9Uj2yaDh/t/QSItiGThncE0OT5uyaKSQmjH8rt64nq3+KB2SnJVRBrmTDqfZxNh5l2mKhEbY7CvHNXUFnDw8CFealk7Li+THbXpq9nohfoseVHlvcmzSqjYaUBOVxpvMGzNEMcrmnHQbPM0qMUgaChn3NsgJGM6/kgb6MW30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzQWEfCG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302415; x=1744838415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LSVHB/ZFgQlGo/cpHX9BEf/V4nmVp0b/qXAMR2F9w/o=;
  b=fzQWEfCGWuwGih5WX3aPwDgx1+CEWTBev8M/wwXpoLjIeooN7XCOR8Hz
   W6Y9pTnaj8Ryr7yXzEntKCi8KgISJ4jEWNS4l1HM7Uoe9gar9hymLvfy+
   q4W++MENlzOZe/kUabKusMmmMZXVRAAwGRyf6w6S96LkTNM88Pncsnywb
   W1KFjj6gNW+mc35m/f1xk1G+5cor9knp3mCG5meBOJK4AhbnT+QxABy4r
   PmSOCNPICf2U3Rs3Cgs0TkCbCweijJitWlYtcf2ktCf+/9eaWmgSnYkAE
   NZx4Ylbi4/xcL3kfGn01/iTWZHC+n0WTxfC1CZvo//3iKKpbwyOVvICWp
   A==;
X-CSE-ConnectionGUID: nXtJfTKNRPuRzJQkeVQMSQ==
X-CSE-MsgGUID: tSzsbVzlQHadFSWIbYMSHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914853"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914853"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:03 -0700
X-CSE-ConnectionGUID: RZuV7ujTQ8iw8hCKDRSCbw==
X-CSE-MsgGUID: /cgppyrATcuFIEaBQ8rkDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22872076"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:03 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 39/74] x86/cpu/vfm: Update arch/x86/boot/cpucheck.c
Date: Tue, 16 Apr 2024 14:19:41 -0700
Message-ID: <20240416211941.9369-40-tony.luck@intel.com>
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
 arch/x86/boot/cpucheck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/cpucheck.c b/arch/x86/boot/cpucheck.c
index fed8d13ce252..0aae4d4ed615 100644
--- a/arch/x86/boot/cpucheck.c
+++ b/arch/x86/boot/cpucheck.c
@@ -203,7 +203,7 @@ int check_knl_erratum(void)
 	 */
 	if (!is_intel() ||
 	    cpu.family != 6 ||
-	    cpu.model != INTEL_FAM6_XEON_PHI_KNL)
+	    cpu.model != 0x57 /*INTEL_XEON_PHI_KNL*/)
 		return 0;
 
 	/*
-- 
2.44.0


