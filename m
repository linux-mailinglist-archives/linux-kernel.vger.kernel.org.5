Return-Path: <linux-kernel+bounces-147585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A008A765A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F2D1F2200E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE1E13D285;
	Tue, 16 Apr 2024 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9d3Gs19"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C788E13C662
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302410; cv=none; b=UXrnorXQGM6bYPODivqbxryn/T73d/LXJA82WLfvMLbNYn4GVufHDvT3ed0U2oZ5yYmXZHnW0tsxSVycWQ8eZGYNeWSqI7jkJipP06nYZmO+Y57cSPEbvyjO+S2rriljcb79YyKuzIcSQalapYqn6JrQ7svv5k7KrCqhw2iK+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302410; c=relaxed/simple;
	bh=Cyosn7hM3IeTtbbG0GJFCApjNoIXS85OOK7GlheZX7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlZGTp8Oe/oAyeCd9KWv0rTuLaGhPy8WEiWRuhvQM2U1SuLEv/pD38DB9y0k3U8ciErYoRyX6U0qVrqUdO+i5HqPb73fRbdr2ySEGKI9gGWiuZ2YMv4XIONeBzn3HOsf8se0xch3gAX+Oe5rP8cdFsgrPsjQ/G/HYoe+DGrladA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9d3Gs19; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302409; x=1744838409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cyosn7hM3IeTtbbG0GJFCApjNoIXS85OOK7GlheZX7w=;
  b=Q9d3Gs19fD33hAQL20dvWBxx6G7h8BoraaOm3gXXxcd7vpUNZB52JvQl
   daOGQ0nnuHOEdDRaQp1B1uUEESRpXy1Bmk+QMZMmNx+GE/BwF9qSVps/g
   1//l9GXsSJKiI76EVrbmYk6itW7mSdzfyqQ1RqvC44MEp0UuMiGC8IYLY
   RJLpE+6h5RHFonn6/Id88hQnJiOmajOVHv1+4SvBxl81pSLvGnsGPkCVO
   KfJbfwPXx/YpHrH1Y7cXHBHPDtg2pE9Hap0I9JasGLmOGu5wdoXDFuFJw
   8O7Z8GgfuHbytZ1KHTPWHWjrjcnp1Uo4Idl5sY+hjzk01zi9jCKffu4KI
   w==;
X-CSE-ConnectionGUID: PgMiZPQ7QPWPyMAT0HQaBQ==
X-CSE-MsgGUID: FDsBbrKEQHqTnHOvgRp4pA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914781"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914781"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:00 -0700
X-CSE-ConnectionGUID: pcVGpz32TBW7ycuR1pR9Pw==
X-CSE-MsgGUID: NANA0DjdT+yL3e8FzD9NwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871962"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:00 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 24/74] x86/cpu/vfm: Update arch/x86/kernel/cpu/microcode/intel.c
Date: Tue, 16 Apr 2024 14:19:26 -0700
Message-ID: <20240416211941.9369-25-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/microcode/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 5f0414452b67..64809f3271b0 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -21,6 +21,7 @@
 #include <linux/uio.h>
 #include <linux/mm.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/processor.h>
 #include <asm/tlbflush.h>
@@ -577,8 +578,7 @@ static bool is_blacklisted(unsigned int cpu)
 	 * This behavior is documented in item BDF90, #334165 (Intel Xeon
 	 * Processor E7-8800/4800 v4 Product Family).
 	 */
-	if (c->x86 == 6 &&
-	    c->x86_model == INTEL_FAM6_BROADWELL_X &&
+	if (c->x86_vfm == INTEL_BROADWELL_X &&
 	    c->x86_stepping == 0x01 &&
 	    llc_size_per_core > 2621440 &&
 	    c->microcode < 0x0b000021) {
-- 
2.44.0


