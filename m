Return-Path: <linux-kernel+bounces-161952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D348B53B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B781F2101F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EC93D0B3;
	Mon, 29 Apr 2024 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yLqcCnSe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d1qDZYW3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208362C69C;
	Mon, 29 Apr 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381326; cv=none; b=FBQ4hXpDB6eVwoK3v/U9gw82SHozzW9xEa4Z+0awGV5aSlt49QMdp8lwhusq2wPLh3lwpwJXHt92+QA4odQI1YBCUE4XNAkxVc8anP26t2nZmFjgYiG0mPiDlDNiyg5LV/CB1psywtOyXeCN1tLq28ZNpxyffix6ZYdsKjwbPqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381326; c=relaxed/simple;
	bh=1jB4+6xBSUvt40mKxhoDG9YV6pf5z6PjWdnpw44olh8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=o+43ydsxNLvziVJHIiooP6hEg09WrepEd5zUh/uzEG+cr4XvCiJ3qdhtKC5qjZEQZ1z9DpVWzwmPHyp/ng1rNXHp17h4t1Zq7HUuTgZA1ni2DIVPzqJJQxKgatgwLpCXvNNeUgz8mm+jiOhoNg2d7TVvW+zzOqMuG4vAZ+YlnGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yLqcCnSe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d1qDZYW3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 09:01:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714381315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zKn5lFj3UR+9eC2hMYtOmHR7asN/pEhekjCm25XpOcA=;
	b=yLqcCnSemYcbahm31gn5dCxUMBeqhAQp7SCHwyQVBwMMiBjDPeH02xsAV+xSk3zlA3TKdl
	jP9V0vaSqQDVLou3E3pUDqq50JZ8gAZeMdy1jFEYltKFW9WP/YBn8KTrw7V4nzYp1IGnQK
	W7RwO7qAprijtxN/B/XsbLHdfw3R+vfmrkpl/Oo4aXsQc3xgy7ofhfAaZcdl8EUjQxQx8Q
	SFjj17I8bOXhlXa1WLdHXS5ZZb4FPVmfuwETPaAydoS/XfMFtqYe/zV69cDwAZLMp8HJIs
	OAzOaoc1oQh0CT2P+mC2WoUCXG+9qvxOdF8KGzPDOErVABk3FloZOObRb6IydQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714381315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zKn5lFj3UR+9eC2hMYtOmHR7asN/pEhekjCm25XpOcA=;
	b=d1qDZYW3Ko9G7BiB35zrPXCK8YChq+3/oy8pqZpoBYelxkjicC13fT94ZxC1Ft+mhgmlcv
	a7rjCddogWgtlpAA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/aperfmperf: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171438131510.10875.6021681558326247766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d32bc2111c7383ccef1edc8b343cd10e2e5fdb0b
Gitweb:        https://git.kernel.org/tip/d32bc2111c7383ccef1edc8b343cd10e2e5fdb0b
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:05 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Apr 2024 10:31:12 +02:00

x86/aperfmperf: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240424181505.41654-1-tony.luck%40intel.com
---
 arch/x86/kernel/cpu/aperfmperf.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index fdbb5f0..f9a8c7b 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -124,25 +124,24 @@ static bool __init slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 	return true;
 }
 
-#define X86_MATCH(model)					\
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
-		INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
+#define X86_MATCH(vfm)						\
+	X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_APERFMPERF, NULL)
 
 static const struct x86_cpu_id has_knl_turbo_ratio_limits[] __initconst = {
-	X86_MATCH(XEON_PHI_KNL),
-	X86_MATCH(XEON_PHI_KNM),
+	X86_MATCH(INTEL_XEON_PHI_KNL),
+	X86_MATCH(INTEL_XEON_PHI_KNM),
 	{}
 };
 
 static const struct x86_cpu_id has_skx_turbo_ratio_limits[] __initconst = {
-	X86_MATCH(SKYLAKE_X),
+	X86_MATCH(INTEL_SKYLAKE_X),
 	{}
 };
 
 static const struct x86_cpu_id has_glm_turbo_ratio_limits[] __initconst = {
-	X86_MATCH(ATOM_GOLDMONT),
-	X86_MATCH(ATOM_GOLDMONT_D),
-	X86_MATCH(ATOM_GOLDMONT_PLUS),
+	X86_MATCH(INTEL_ATOM_GOLDMONT),
+	X86_MATCH(INTEL_ATOM_GOLDMONT_D),
+	X86_MATCH(INTEL_ATOM_GOLDMONT_PLUS),
 	{}
 };
 

