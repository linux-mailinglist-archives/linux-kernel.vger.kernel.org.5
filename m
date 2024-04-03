Return-Path: <linux-kernel+bounces-129068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE682896444
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E080B21ED2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CEC4D133;
	Wed,  3 Apr 2024 05:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbCKW/3w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9224CB2B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 05:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712123663; cv=none; b=sGMToyYLueIoq6+z6dxkmXLZw3PEZbtXXaPkxBFn+6vp/iq//KkDGB8TDP3BM5H8WNrDz4DAi4yiLEfbXgsHjNJffnAREbnjbPHXN2gfERGhQep93moIoX1G9gMV+uqzWUJ3kVrYNS09/Z0Fzd2nzdrWOJ7nkbdeLPQI9RCE64c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712123663; c=relaxed/simple;
	bh=2AbxKAfDZUN1hrqHIFLRsS3F44dpdKbXX0E1kqQankY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KEfFf/7zZBNj6kWAgHcEYUrOvikeN7IwUAbCw29wlFGYPXP2QoC0FOmmtUwKFJdrmQbao+XoOkNcwfnV60p2t5hnUzA0mgV6PmUQzUVbI/URXkPz/Lg1g2tMJvgVTrK+aMRek/kebA/hew5uG+uZhkVFJ8h306YFjtvUt9CYm3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbCKW/3w; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712123662; x=1743659662;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2AbxKAfDZUN1hrqHIFLRsS3F44dpdKbXX0E1kqQankY=;
  b=fbCKW/3w+kurh+LhzGuf81u1EEu0iAI7yCphvJ6nwvtsqbJmxHSSqDRM
   Epfqd4j5fjR1hghL9ImMBEFc6oWChnOa83K1cjMw1OZn9ZZkwgOEriAx7
   c8EXKakpVmA6gm5FByl2B9UmkJtgQ9aS2IoS5ixn3idmuWiA+z1/mLkPs
   lpY+qWBIdzAm4LGhNOfKycDD3zbWyd0y63JUzxlxu0zwMMYLL9GGh0sd+
   HN14V3c7c8g33kaQ+sJysI652plH0yZKlfIMsc4w8nvAoz6R7x/uW6Yo+
   ILNUc5Rkfgrd+z987hKMtvUJM7qb+yOX+QeL1oTTy208wdjCdTi8I1ANq
   w==;
X-CSE-ConnectionGUID: DYBp18h3Sr2TXrgZFV+aSA==
X-CSE-MsgGUID: FU5QPQnsQ5S9lYvNQrunxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="11154091"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="11154091"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 22:54:22 -0700
X-CSE-ConnectionGUID: YbCp/abMSxq0/KlztLLKBw==
X-CSE-MsgGUID: dB/1mYqlRvSpj5mMrk7x8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18776156"
Received: from wangmei-mobl.amr.corp.intel.com (HELO desk) ([10.209.86.58])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 22:54:22 -0700
Date: Tue, 2 Apr 2024 22:54:19 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	antonio.gomez.iglesias@linux.intel.com,
	alyssa.milburn@linux.intel.com, andrew.cooper3@citrix.com,
	linux-kernel@vger.kernel.org,
	Alyssa Milburn <alyssa.milburn@intel.com>, stable@kernel.org
Subject: [PATCH v3] x86/bugs: Default retbleed to =stuff when retpoline is
 enabled
Message-ID: <20240402-retbleed-auto-stuff-v3-1-e65f275a8ec8@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAJ/uDGYC/33NQQ7CIBCF4asY1tIwQBvqynsYF9gOlqSCAUpqm
 t5d2pWJxuX/kvlmIRGDxUhOh4UEzDZa70qI44F0g3Z3pLYvTTjjknGmaMB0GxF7qqfkaUyTMbQ
 WyIxuQbAaSbl8BjR23tXLtfRgY/LhtT/JsK3/vQwUaGOAYw1CNcqcR+umubIu4Vh1/kE2NfMPC
 fhviRdJtZJBI1shQX9L67q+Ae7piSsGAQAA
X-Mailer: b4 0.12.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Intel systems when retpoline mitigation is enabled for spectre-v2,
retbleed=auto does not enable RSB stuffing. This may make the system
vulnerable to retbleed. Retpoline is not the default mitigation when
IBRS is present, but in virtualized cases a VMM can hide IBRS from
guests, resulting in guest deploying retpoline by default. Even if IBRS
is enumerated, a user can still select spectre_v2=retpoline.

As with other mitigations, mitigate retbleed by default. On Intel
systems when retpoline is enabled, and retbleed mitigation is set to
auto, enable Call Depth Tracking and RSB stuffing i.e. retbleed=stuff
mitigation. For AMD/Hygon auto mode already selects the appropriate
mitigation.

Reported-by: Alyssa Milburn <alyssa.milburn@intel.com>
Cc: stable@kernel.org
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
v3:
- Rebased to v6.9-rc2

v2: https://lore.kernel.org/r/20240212-retbleed-auto-stuff-v2-1-89401649341a@linux.intel.com
- Mitigate retbleed by default for spectre_v2=retpoline. (Josh)
- Add the missing ',' in the comment. (Josh)
- Rebased to v6.8-rc4

v1: https://lore.kernel.org/r/20240208-retbleed-auto-stuff-v1-1-6f12e513868f@linux.intel.com
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e7ba936d798b..69d8ce58f244 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1092,11 +1092,17 @@ static void __init retbleed_select_mitigation(void)
 			else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY) &&
 				 boot_cpu_has(X86_FEATURE_IBPB))
 				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
+		} else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+			   spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
+			if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING))
+				retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
+			else
+				pr_err("WARNING: Retpoline enabled, but kernel not compiled with CALL_DEPTH_TRACKING.\n");
 		}
 
 		/*
-		 * The Intel mitigation (IBRS or eIBRS) was already selected in
-		 * spectre_v2_select_mitigation().  'retbleed_mitigation' will
+		 * If Intel mitigation (IBRS or eIBRS) was already selected in
+		 * spectre_v2_select_mitigation(),  'retbleed_mitigation' will
 		 * be set accordingly below.
 		 */
 

---
base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
change-id: 20240208-retbleed-auto-stuff-53e0fa91305e


