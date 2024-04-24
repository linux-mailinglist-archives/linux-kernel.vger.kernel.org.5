Return-Path: <linux-kernel+bounces-157481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C548B120E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E796C291C05
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727CC181D14;
	Wed, 24 Apr 2024 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UCkIxdrn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CC218133A;
	Wed, 24 Apr 2024 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982523; cv=none; b=BRP3Ys80+ls+V+WHxDQO1lX7eHZ9+rB7Vde6ow27+/o5kd5Ovv+2QYtErUPW9+Sj5xteQh6aI2QIlWDt9B7KMD0sk3qTiiLZ9AAE/2j8qDFFkDTHfPptZ7anO6+7Iu13AY2mf3xeTyDcVxEMMBZkdr2aoUN4fnf1FATfIvWt4Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982523; c=relaxed/simple;
	bh=J5hiIdzXZvx6tAF17llwzadEEbvMd4HK2TJQKlWWZVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaXSCY8QBPkWwI8LopEpsyT8tBZ0tgJVdgglJFRR0h4MBogadx4fTU28dp1ZdOFoNOtLvuFxQgvTc9JEt6cqBZsLpurMeqSvOAZGo9pzC2AaNQsQ3raPt8Vfh2reJNXZEyYy8+QKhNs5ltZ8JdjbDI6fL0R9TLaQVVlBPKSONPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UCkIxdrn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982522; x=1745518522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J5hiIdzXZvx6tAF17llwzadEEbvMd4HK2TJQKlWWZVo=;
  b=UCkIxdrnsmSKj+DzxJkQEwIKAcyqo6wsFZCiAqIxec68E7E9KJCxRCHE
   DDZyMOUqGJfblyU1N7aeGBfpa8fCYnXwtTsKRbvCUTZ5sPXBDD1+B+2F2
   QpCwekAVzihJP6UByVRjlunpbRQoK/mxIMz41vZkD/fHamqFTeCN2R3SO
   G061f5cE6K7ZKUKxKvJg2BMQgN1GSAhsMq1aKbsZ38Y6Uj8htpRmMfGQL
   TUN9KJWNf1P2VZeC01R+CNv9y+HYhAqEOWWaIGzNCIPl6l8BmFI5x6lmB
   pOgJHCsWBJzVNSswVO1+FxyfWlCSyvhv1zrpcohdYX/OB3t5tOMrwBNER
   Q==;
X-CSE-ConnectionGUID: 42oprxY3Ro2AggsFbfmsKw==
X-CSE-MsgGUID: 8r4wpvh7SVeAG1HQzMzQpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481994"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481994"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:12 -0700
X-CSE-ConnectionGUID: u9kpHmymT3qBVaY3N+AmTg==
X-CSE-MsgGUID: sLnf+kpDTLyA3e6CtDkmrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262744"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:12 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 32/71] x86/mce: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:11 -0700
Message-ID: <20240424181511.41772-1-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/mce/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 771a9f183260..ad0623b659ed 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -47,7 +47,7 @@
 #include <linux/kexec.h>
 
 #include <asm/fred.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/traps.h>
 #include <asm/tlbflush.h>
@@ -1948,14 +1948,14 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		if (c->x86 == 6 && c->x86_model <= 13 && cfg->bootlog < 0)
 			cfg->bootlog = 0;
 
-		if (c->x86 == 6 && c->x86_model == 45)
+		if (c->x86_vfm == INTEL_SANDYBRIDGE_X)
 			mce_flags.snb_ifu_quirk = 1;
 
 		/*
 		 * Skylake, Cascacde Lake and Cooper Lake require a quirk on
 		 * rep movs.
 		 */
-		if (c->x86 == 6 && c->x86_model == INTEL_FAM6_SKYLAKE_X)
+		if (c->x86_vfm == INTEL_SKYLAKE_X)
 			mce_flags.skx_repmov_quirk = 1;
 	}
 
-- 
2.44.0


