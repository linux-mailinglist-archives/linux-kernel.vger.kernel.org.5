Return-Path: <linux-kernel+bounces-44942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C01842945
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FCD28548E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AAB13A27A;
	Tue, 30 Jan 2024 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hCZ6saHY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mGyOX15g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C43112FF75;
	Tue, 30 Jan 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631977; cv=none; b=F6HeUsO5Ugcoklmpo9UU5V0/YMEvfFKHYRZkv5a+M2/bEs+3q9jdM3JZfsyMx0TPZa6WhZ3n40J/tFBKB3XBmhSs0VFd2YeQpV+NwgF9eO5nn60te9zuu2QwGxptDf6LGWT1mBkd4sItzlsLcKhYpjWYmwZKNm3TGDZwsLz+FNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631977; c=relaxed/simple;
	bh=xa20NB2F9w/wmcamPU/neWsBd55VwfhonfzXIsCODfI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pJxtbou0Ci74mOcSs0mld+tdWhvz1llB5Fbj5esP/UIIK0p7wKWYEwaloRZvlQvpg8CShpLLzEoOXPsIDR8z7oQrw0IAh9hnfMqNIaNDfUnWy3In+9gkhr1t7t2kS9pkL6tVcUI84ugMREpZ33lh84A1Tkil9M8oOIBH6kBmiw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hCZ6saHY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mGyOX15g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631973;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHefnsd9D4gYX0qAxPmeOq8/AUrqApnE1/2yVtKtDLA=;
	b=hCZ6saHYA6y3Zsd5NXxtzwGzUET9QacqNfdOUt1tCO+tbv3SW4H5ptbP47LgaGWxtqSfZh
	V8B/K6k43g1Six52BKuv19DSNEVyis9IIk1olfGwFn7lS1rrAxwBNHK/USKOfIPt5VrFlM
	y5rsArfBJUYbD7LtiYxP9PoxW2+oh+e6EL0iyHZnR+eJ8azqUdtR0EYuIF+sRqhqRKQ+wD
	SIdeE50k5La7/d5eSZKio15W+sZBXBceqanyEJ8AWseJearIjH/qUM1IJmj2g6BjPfmw84
	nXd+NVmaOg7qP6h3/ku5KOz2vZytwR4jJZ2khTavotlbCn8Ousnb9yv3KL8Brg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631973;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHefnsd9D4gYX0qAxPmeOq8/AUrqApnE1/2yVtKtDLA=;
	b=mGyOX15gaqYFCfyOT/KoNVJvr3jwb8Ljph6ESWwQEUaLgnuXQT+ZwURmcSlmyQc4Jq2C3a
	hHTFjHghjZENj/Ag==
From: "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/speculation: Do not enable Automatic IBRS if
 SEV-SNP is enabled
Cc: Kim Phillips <kim.phillips@amd.com>, Michael Roth <michael.roth@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-3-michael.roth@amd.com>
References: <20240126041126.1927228-3-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663197187.398.15168561144334587796.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     acaa4b5c4c854b5009f4d4a5395b2609ad0f4937
Gitweb:        https://git.kernel.org/tip/acaa4b5c4c854b5009f4d4a5395b2609ad0f4937
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:02 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 17:19:01 +01:00

x86/speculation: Do not enable Automatic IBRS if SEV-SNP is enabled

Without SEV-SNP, Automatic IBRS protects only the kernel. But when
SEV-SNP is enabled, the Automatic IBRS protection umbrella widens to all
host-side code, including userspace. This protection comes at a cost:
reduced userspace indirect branch performance.

To avoid this performance loss, don't use Automatic IBRS on SEV-SNP
hosts and all back to retpolines instead.

  [ mdr: squash in changes from review discussion. ]

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lore.kernel.org/r/20240126041126.1927228-3-michael.roth@amd.com
---
 arch/x86/kernel/cpu/common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0b97bcd..9e35e27 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1355,8 +1355,13 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	/*
 	 * AMD's AutoIBRS is equivalent to Intel's eIBRS - use the Intel feature
 	 * flag and protect from vendor-specific bugs via the whitelist.
+	 *
+	 * Don't use AutoIBRS when SNP is enabled because it degrades host
+	 * userspace indirect branch performance.
 	 */
-	if ((ia32_cap & ARCH_CAP_IBRS_ALL) || cpu_has(c, X86_FEATURE_AUTOIBRS)) {
+	if ((ia32_cap & ARCH_CAP_IBRS_ALL) ||
+	    (cpu_has(c, X86_FEATURE_AUTOIBRS) &&
+	     !cpu_feature_enabled(X86_FEATURE_SEV_SNP))) {
 		setup_force_cpu_cap(X86_FEATURE_IBRS_ENHANCED);
 		if (!cpu_matches(cpu_vuln_whitelist, NO_EIBRS_PBRSB) &&
 		    !(ia32_cap & ARCH_CAP_PBRSB_NO))

