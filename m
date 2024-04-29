Return-Path: <linux-kernel+bounces-161943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B2D8B53A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA341F21ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F0F224D6;
	Mon, 29 Apr 2024 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OB0t1lQH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bu3I0onS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E241B809;
	Mon, 29 Apr 2024 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381322; cv=none; b=jEGZN5qivENIn2KARoShvrbRQ052cLfWdGFi/gNJVwpDkA1g0UIXtZXjy3dZhi6J/nC9GnOAaBRHeT3vCtHdHrZLyX7a2Ka09IG9kaHtffYK+P5Mgz4z1gAJrbICztk/hSwtQ6aPUJZ7jggC+oRPmBQzxUKlwTM+5XPHC8F0WdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381322; c=relaxed/simple;
	bh=m14jT9Ag+9nCB15ehDow7xh/XFPhAMgkmSe1oKPWlzE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=roEFy2RPL7JcCeCHNQ7pVWX4RIRfmhHgJsgO9E7Pmd3YWqjIJzrB0jO3/MMz5FQVl9G+1ohcuHdYqBpMwt6TiGtcVlpBW2gh+/1Vv6g5igVX8dNJO5TcznvImQL3qp4xbZgIQZtIaHtPzS/F13gExIrouysNkoUYe1q9p5f5m2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OB0t1lQH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bu3I0onS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 09:01:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714381314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gF9dDL5aQhTN6PfG6pYk/MFqZifBiMHFKkWX/TGaBbo=;
	b=OB0t1lQHcVP8G5NtI/4ReWhDGjxi1jQm3btS5n4yjXOU8OJCDM+0Cfn73pUnFAkZV4KqjT
	ZrGZ2ZvLgtH3SWgYM7aKOvDbhYAbebTrA49vTjI08Jv3C9Zx1xHVCsLd8roc+CtSRbey9u
	oMEJICY5jux57TOwhLt+j1PDC7i2sFL7kBRbyhsb/29QeBn0TnaiO3b5N3ExTocy6Wa+xC
	YRP4knBFynBddPXCMQ3D/XOxSnSoSi5JmJJq6FgyjFolickg3d6abi2OP6ByBd0DppABAc
	aLriA0fYniv9wgsuWdhO7PvdYMbL5BQd3GMp0NwHhezEXqABj5pbbSWseUjW4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714381314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gF9dDL5aQhTN6PfG6pYk/MFqZifBiMHFKkWX/TGaBbo=;
	b=bu3I0onSRcLryzTRZvKbC4sRpWrXcvnQoiOegrC1jzv1+5m8/GdZNtx76ZoyuO+GPpA1q/
	yl7drkxz5D2HOfAg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171438131399.10875.3660444097799606539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     4db64279bc2b1c896fa8a99ae8f4b7aa943a4938
Gitweb:        https://git.kernel.org/tip/4db64279bc2b1c896fa8a99ae8f4b7aa943a4938
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:16 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Apr 2024 10:31:30 +02:00

x86/cpu: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

[ dhansen: vertically align macro and remove stray subject / ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240424181516.41887-1-tony.luck%40intel.com
---
 arch/x86/kernel/smpboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a581095..0c35207 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -438,9 +438,9 @@ static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  */
 
 static const struct x86_cpu_id intel_cod_cpu[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X, 0),	/* COD */
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X, 0),	/* COD */
-	X86_MATCH_INTEL_FAM6_MODEL(ANY, 1),		/* SNC */
+	X86_MATCH_VFM(INTEL_HASWELL_X,	 0),	/* COD */
+	X86_MATCH_VFM(INTEL_BROADWELL_X, 0),	/* COD */
+	X86_MATCH_VFM(INTEL_ANY,	 1),	/* SNC */
 	{}
 };
 

