Return-Path: <linux-kernel+bounces-157497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9E68B1226
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79E31C216B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69C31BF6C2;
	Wed, 24 Apr 2024 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DsCe/ZYA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F078519DF7A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982531; cv=none; b=qSX9tLnPyYMxQK5KUfc8SjUMjmLJUS5nUDydNNbmJzrzFD1i0+nJGNPkUOOPc55isQ4JbzFY0u9gn//8JdEDc9AGLcwprQeD6s0fFMyBaHpMujeKatk4keEVpPySUx9zwMGFxZP7QZuMaGsWN+3h/jKbnpxil5iOhn1seiFwHAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982531; c=relaxed/simple;
	bh=FfXHVVXxAXvXhf26U3fzvKJ4+8iaBCg597mpHe5hnu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SU1QlC+B66f5wN0ZILvQYVrRvhs7zTwrJ80Jgt166CsxSSMVpQsQBWG4DjYuK6/0uamorPn/1UpvXLeYv5QpUhcqFlhekS7fPvRzIAQ3QBc6w1WXw1mLYgckZy9WWVhv0KOgl/3ldxiHMqFeTmInFTSYlKWQPnZP2VaJMezUbiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DsCe/ZYA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982530; x=1745518530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FfXHVVXxAXvXhf26U3fzvKJ4+8iaBCg597mpHe5hnu0=;
  b=DsCe/ZYAU7iRq8SD1I9BTCYT6VYG5poUNnyh8yNEcnQ3rT2msr5nkZtS
   KbvjIxRQz1m6d7I2abvQbq1jT9WsWOiEVdKcmQZo3OJpLfC6DnXhq7jv3
   AGEeUKulA1E3q9kvBT2x0zGh2CoAD0Hc2454cIg2lcXzVt4k7gUh7+N+k
   bmZExerT4CW+0buUkM7/d42P5URrXXLfo6HsFbPfv/fW5Mkg3bM3/ho8l
   QhidrqcC50bK7rpc5d3vH1SPgQTLSPJSzxFWxoBdKVInMI0W+EYsozFqa
   Z0x1jdqfPsUOPQd9kXkXwu6UAiBcO+Pcn1DD3gjjeJOmtVeo5JiLBqqT6
   A==;
X-CSE-ConnectionGUID: DQHxgBteQj2VnzYLmj3OVQ==
X-CSE-MsgGUID: q8fCCNrGR/KxzN1kc0xW5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9482081"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9482081"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:19 -0700
X-CSE-ConnectionGUID: bO0fFlafRrua07hw4U++9g==
X-CSE-MsgGUID: WU2AeidrSl6GnEj/OycV3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262793"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:19 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 41/71] x86/mm: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:18 -0700
Message-ID: <20240424181518.41946-1-tony.luck@intel.com>
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
---
 arch/x86/mm/init.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 679893ea5e68..fadc3fc3ee41 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -261,21 +261,17 @@ static void __init probe_page_size_mask(void)
 	}
 }
 
-#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
-			      .family  = 6,			\
-			      .model = _model,			\
-			    }
 /*
  * INVLPG may not properly flush Global entries
  * on these CPUs when PCIDs are enabled.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
-	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+	X86_MATCH_VFM(INTEL_ALDERLAKE, 0),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L, 0),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE, 0),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, 0),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, 0),
 	{}
 };
 
-- 
2.44.0


