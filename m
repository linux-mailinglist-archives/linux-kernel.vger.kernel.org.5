Return-Path: <linux-kernel+bounces-76773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F63685FC4D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279B528BCE0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91A14C5B9;
	Thu, 22 Feb 2024 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pio1KZOA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j7/NqDai"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E91482E9;
	Thu, 22 Feb 2024 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615583; cv=none; b=c9zHV1PJw5SS1x3E2SkISxnUKbSYDZsxMICv7TnCkDiDaZPaM854R/VUBvBr4fj4LnfNbNK5mUVtGybhkNqxb2sXE4clAQ5pIgVUMKsgCRQLrcGVzPnPnRY0uyRMeBK8GnpKIV4W2ssHTS3+ah04AbRxcVujE7d2FTc7125G87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615583; c=relaxed/simple;
	bh=aBxShmCQnv+lCev5pCXP4qCrRRJuAJM27nBlLpFQVHk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OMnqgj+VUE4m+0Z3k4W5SJJVUMMj7yJYfgZVocte/cDxOGixU3CQ6xSnOghPVPxN6oVRiLTjBQaLuD3n67qJHs55uYYmHxFWQgXciPFBfPEGMDRCuZZnTz7k/9wvG9ccr/Lcprmky2Y7k1ByRd9kz/4ofhTkFOhOuloKGfU/qic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pio1KZOA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j7/NqDai; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 15:26:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708615580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJTZHbG3QoxvICbJJHJp3HSuehI6CNbyljf0NqiXkmw=;
	b=pio1KZOAScviyeJPCNLofRoXy3Hucy6klAexXAAwM9csJihs4yoigYYCPloQnd1xzWUbLy
	EYrf/ewxOgqr8vQ/Pt33DYpFKrc7oVS5qdfTJCsFKx2mOm2MCkzq0wRqjK55wiWcqaYtlo
	83DSlvOii/Ke9vR7pjSO/SV2CDebVOstyUb3NXk5ksy4NqUcOd/2uZsGvGJLS0YsMrP37f
	3gbPNJXTUMv7pYKbNufEi6dO2rdXihWSxCA81z//FXpen8a5lLtRZ8XPG8PnNrlHJxVVed
	e9zoLHWbB1+GjABMSWKdGKvmVSkKTIx9l3jRNkULJ0r37Wf8EkyggxQsHK+g2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708615580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJTZHbG3QoxvICbJJHJp3HSuehI6CNbyljf0NqiXkmw=;
	b=j7/NqDaiuaYazzBcL2R+owAzPQr3C/9TA1HyNx/uprwBbMyrO3WEs9jelIeykTMT3U9435
	MWilaW2oiLUf1oAw==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Remove lockdep annotation that triggers
 false positive
Cc: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <ZdUSwOM9UUNpw84Y@agluck-desk3>
References: <ZdUSwOM9UUNpw84Y@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170861557937.398.13612434980010892059.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     c0d848fcb09d80a5f48b99f85e448185125ef59f
Gitweb:        https://git.kernel.org/tip/c0d848fcb09d80a5f48b99f85e448185125ef59f
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 21 Feb 2024 12:23:06 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 22 Feb 2024 16:15:38 +01:00

x86/resctrl: Remove lockdep annotation that triggers false positive

get_domain_from_cpu() walks a list of domains to find the one that
contains the specified CPU. This needs to be protected against races
with CPU hotplug when the list is modified. It has recently gained
a lockdep annotation to check this.

The lockdep annotation causes false positives when called via IPI as the
lock is held, but by another process. Remove it.

  [ bp: Refresh it ontop of x86/cache. ]

Fixes: fb700810d30b ("x86/resctrl: Separate arch and fs resctrl locks")
Reported-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/ZdUSwOM9UUNpw84Y@agluck-desk3
---
 arch/x86/kernel/cpu/resctrl/core.c |  9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 8a4ef4f..83e4034 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -362,15 +362,6 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
 {
 	struct rdt_domain *d;
 
-	/*
-	 * Walking r->domains, ensure it can't race with cpuhp.
-	 * Because this is called via IPI by rdt_ctrl_update(), assertions
-	 * about locks this thread holds will lead to false positives. Check
-	 * someone is holding the CPUs lock.
-	 */
-	if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && IS_ENABLED(CONFIG_LOCKDEP))
-		WARN_ON_ONCE(!lockdep_is_cpus_held());
-
 	list_for_each_entry(d, &r->domains, list) {
 		/* Find the domain that contains this CPU */
 		if (cpumask_test_cpu(cpu, &d->cpu_mask))

