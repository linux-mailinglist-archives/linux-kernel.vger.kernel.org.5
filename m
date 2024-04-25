Return-Path: <linux-kernel+bounces-158948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E1E8B273F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC87287B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869DC14E2DF;
	Thu, 25 Apr 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A7SE+Xt7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c/gJfHhG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501214A087;
	Thu, 25 Apr 2024 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065041; cv=none; b=URVvwNZuJZbcHGFMpSaSp3rBt4lKWxzN7dgDm5XS7OcA7sJfkNqWP9KexmXDjrhQjjNaaXnblQeQ3V+V2yehAKAz4vQQIAjDGwUwm1N0gBDGR7+rwQmPED3ZSTk1Hijv7yQiZR+FysAtz0jk9fTNFJKtBaU2wt/ozoxjoT8WJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065041; c=relaxed/simple;
	bh=QKRyFG6BDsRjlzuadOI8XziTz3LtaCGqfDoi1f47NNI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=GEEj0D2zEhMnR1eNlMavhZOJpBmATFzswtM06ptXkWwHbwzF3kCxAuwwXOLpz7qfrlwo8ZgmP0BBIImBobw2LtpAjCYTYhMnUKYlOL1gk03HhJE6dXxEWpIqziReicN1NTQS4+GLSI7A7ZcVIRg30Cn8LdR5soWYncSS6EeiD0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A7SE+Xt7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c/gJfHhG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Apr 2024 17:10:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714065036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6DJ48fD03NBgyHxTniWcpj9wiq5z2vgFYOHvxjnIkkI=;
	b=A7SE+Xt7uhZF9Gspv/tDYw28OKHKd9n+0MgMR2JAet8Uh8WmuKYsJs9c9ySbXw0/VadXQ0
	NiyrPvBeeqIw4WFA4DlALoz9LSr56krUWc6oHZPp5hLd3SW3KBWiPHkCKDel2faCMlByTJ
	BP0ZJsEqWqfLi6HxJBOdc9xhmOCGFgJW5sEwXRPIx7U2tTv+uWXKr4f/dmwGmWZJJ+dM/L
	b6LQCLVc7zsutFxaRoJVvh1+qmP1cBrdWml0H284nSfx2Wj4vg6jwJMRb9yieNvCPJytGw
	hVLKjLUZA4vZoWhvCwBdKTHFtcS5v97DAWifa9myMM+G3BW5fbYxVRIpA0jKHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714065036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6DJ48fD03NBgyHxTniWcpj9wiq5z2vgFYOHvxjnIkkI=;
	b=c/gJfHhGKJSVREcJ9rKkH1oZJcpxjquAtNnU4c27qTzeu1AELgV4867Niqf5xVVXZJMZh8
	/BuEWDNN7uJ2BKDw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] perf/x86/msr: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171406503537.10875.15056829708453932461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e8475a26a94f57f5e6c8e8799dd3f9b936647f0b
Gitweb:        https://git.kernel.org/tip/e8475a26a94f57f5e6c8e8799dd3f9b936647f0b
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:03 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 25 Apr 2024 09:04:33 -07:00

perf/x86/msr: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181503.41614-1-tony.luck%40intel.com
---
 arch/x86/events/msr.c | 132 ++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 9e237b3..45b1866 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -2,7 +2,7 @@
 #include <linux/perf_event.h>
 #include <linux/sysfs.h>
 #include <linux/nospec.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include "probe.h"
 
 enum perf_msr_id {
@@ -43,75 +43,75 @@ static bool test_intel(int idx, void *data)
 	    boot_cpu_data.x86 != 6)
 		return false;
 
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_NEHALEM:
-	case INTEL_FAM6_NEHALEM_G:
-	case INTEL_FAM6_NEHALEM_EP:
-	case INTEL_FAM6_NEHALEM_EX:
-
-	case INTEL_FAM6_WESTMERE:
-	case INTEL_FAM6_WESTMERE_EP:
-	case INTEL_FAM6_WESTMERE_EX:
-
-	case INTEL_FAM6_SANDYBRIDGE:
-	case INTEL_FAM6_SANDYBRIDGE_X:
-
-	case INTEL_FAM6_IVYBRIDGE:
-	case INTEL_FAM6_IVYBRIDGE_X:
-
-	case INTEL_FAM6_HASWELL:
-	case INTEL_FAM6_HASWELL_X:
-	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_G:
-
-	case INTEL_FAM6_BROADWELL:
-	case INTEL_FAM6_BROADWELL_D:
-	case INTEL_FAM6_BROADWELL_G:
-	case INTEL_FAM6_BROADWELL_X:
-	case INTEL_FAM6_SAPPHIRERAPIDS_X:
-	case INTEL_FAM6_EMERALDRAPIDS_X:
-	case INTEL_FAM6_GRANITERAPIDS_X:
-	case INTEL_FAM6_GRANITERAPIDS_D:
-
-	case INTEL_FAM6_ATOM_SILVERMONT:
-	case INTEL_FAM6_ATOM_SILVERMONT_D:
-	case INTEL_FAM6_ATOM_AIRMONT:
-
-	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_GOLDMONT_D:
-	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
-	case INTEL_FAM6_ATOM_TREMONT_D:
-	case INTEL_FAM6_ATOM_TREMONT:
-	case INTEL_FAM6_ATOM_TREMONT_L:
-
-	case INTEL_FAM6_XEON_PHI_KNL:
-	case INTEL_FAM6_XEON_PHI_KNM:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_NEHALEM:
+	case INTEL_NEHALEM_G:
+	case INTEL_NEHALEM_EP:
+	case INTEL_NEHALEM_EX:
+
+	case INTEL_WESTMERE:
+	case INTEL_WESTMERE_EP:
+	case INTEL_WESTMERE_EX:
+
+	case INTEL_SANDYBRIDGE:
+	case INTEL_SANDYBRIDGE_X:
+
+	case INTEL_IVYBRIDGE:
+	case INTEL_IVYBRIDGE_X:
+
+	case INTEL_HASWELL:
+	case INTEL_HASWELL_X:
+	case INTEL_HASWELL_L:
+	case INTEL_HASWELL_G:
+
+	case INTEL_BROADWELL:
+	case INTEL_BROADWELL_D:
+	case INTEL_BROADWELL_G:
+	case INTEL_BROADWELL_X:
+	case INTEL_SAPPHIRERAPIDS_X:
+	case INTEL_EMERALDRAPIDS_X:
+	case INTEL_GRANITERAPIDS_X:
+	case INTEL_GRANITERAPIDS_D:
+
+	case INTEL_ATOM_SILVERMONT:
+	case INTEL_ATOM_SILVERMONT_D:
+	case INTEL_ATOM_AIRMONT:
+
+	case INTEL_ATOM_GOLDMONT:
+	case INTEL_ATOM_GOLDMONT_D:
+	case INTEL_ATOM_GOLDMONT_PLUS:
+	case INTEL_ATOM_TREMONT_D:
+	case INTEL_ATOM_TREMONT:
+	case INTEL_ATOM_TREMONT_L:
+
+	case INTEL_XEON_PHI_KNL:
+	case INTEL_XEON_PHI_KNM:
 		if (idx == PERF_MSR_SMI)
 			return true;
 		break;
 
-	case INTEL_FAM6_SKYLAKE_L:
-	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_SKYLAKE_X:
-	case INTEL_FAM6_KABYLAKE_L:
-	case INTEL_FAM6_KABYLAKE:
-	case INTEL_FAM6_COMETLAKE_L:
-	case INTEL_FAM6_COMETLAKE:
-	case INTEL_FAM6_ICELAKE_L:
-	case INTEL_FAM6_ICELAKE:
-	case INTEL_FAM6_ICELAKE_X:
-	case INTEL_FAM6_ICELAKE_D:
-	case INTEL_FAM6_TIGERLAKE_L:
-	case INTEL_FAM6_TIGERLAKE:
-	case INTEL_FAM6_ROCKETLAKE:
-	case INTEL_FAM6_ALDERLAKE:
-	case INTEL_FAM6_ALDERLAKE_L:
-	case INTEL_FAM6_ATOM_GRACEMONT:
-	case INTEL_FAM6_RAPTORLAKE:
-	case INTEL_FAM6_RAPTORLAKE_P:
-	case INTEL_FAM6_RAPTORLAKE_S:
-	case INTEL_FAM6_METEORLAKE:
-	case INTEL_FAM6_METEORLAKE_L:
+	case INTEL_SKYLAKE_L:
+	case INTEL_SKYLAKE:
+	case INTEL_SKYLAKE_X:
+	case INTEL_KABYLAKE_L:
+	case INTEL_KABYLAKE:
+	case INTEL_COMETLAKE_L:
+	case INTEL_COMETLAKE:
+	case INTEL_ICELAKE_L:
+	case INTEL_ICELAKE:
+	case INTEL_ICELAKE_X:
+	case INTEL_ICELAKE_D:
+	case INTEL_TIGERLAKE_L:
+	case INTEL_TIGERLAKE:
+	case INTEL_ROCKETLAKE:
+	case INTEL_ALDERLAKE:
+	case INTEL_ALDERLAKE_L:
+	case INTEL_ATOM_GRACEMONT:
+	case INTEL_RAPTORLAKE:
+	case INTEL_RAPTORLAKE_P:
+	case INTEL_RAPTORLAKE_S:
+	case INTEL_METEORLAKE:
+	case INTEL_METEORLAKE_L:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;

