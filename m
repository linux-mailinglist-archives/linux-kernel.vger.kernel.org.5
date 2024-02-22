Return-Path: <linux-kernel+bounces-77474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94FD8605D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0991C215BF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F718050;
	Thu, 22 Feb 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KH9Q4mCu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZXXEV2bc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6117BBE;
	Thu, 22 Feb 2024 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708642015; cv=none; b=nM5p0q1R6NyeNjsPXF62h9xdAwkziMVpmqz7V24KMW4RlbGYsPQ19Tf2E43qSjBDYQ3+esvvSxOHgccnkHhUqDPu5/YNoF4xnbiFLOOWpS8vtLvaN6MTbg3iqCnd46xGJc6C4E4hmfD5jAKSxh9B4Z+JKw2ceH+3SiaRcTECZKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708642015; c=relaxed/simple;
	bh=jxUAoPY4buWx8x3wTgrDsWe+Yni+xI8fxg2cmerm4/k=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=mgYrTiGtPHl5e5GnSvdkFbY/hUYSvTarvOjj/L6sSTydnhna6ms5UfRthsx2Rgnx+vebFcvEJXMeiuhHnjTAa2wSLNn9sAU9//CnnatAtF5vpqS1pER6luO1Lqj7sUsLVq3Iw0d7kIH4pBXN7CiSeIs9HVKg14VWCrjUoHEkS4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KH9Q4mCu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZXXEV2bc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 22:46:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708642010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GIBmASRFKgbqXpLppJ9htzyrvj+vvzswJFnQGxDsbGY=;
	b=KH9Q4mCuFermHP4Z4c537BOQTpK9vFl2fdFsyBp2oTztj6Kuf1/3Rzaflpt4FRKzuObOkR
	5sfrxzOb3F+kyJKI5cn4kqTrHtE9UTxHbT+4YMu0z+6oTC28Ki1LTwhGpTcRbSHeXs3bDn
	ImovSkdSD66ebPTSQInUFi41Z7BxBiNbJv7i1GQeevle5w72YPULlSdd3/MTSAWwVXTpGN
	DPYD7YeALFDoVS15R3TESLz63Fa2ziNguI4QsjJ8eep89mksnbkzO+Dg0mxNZzxM2CHyzn
	33rKOi3iNMxyWVUkgrGcoboKAyzBxfmfod/Qm4Vdyc8vsP7bFna/akLAEYxp6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708642010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GIBmASRFKgbqXpLppJ9htzyrvj+vvzswJFnQGxDsbGY=;
	b=ZXXEV2bc4BvzWw/hyGduraFCbm2uUjhFTFfWSDIx2VwRgoNNiXa1hXnJde1scSBXVuPmDP
	49juRYCEpnmvSKCQ==
From: "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/cpa: Warn for set_memory_XXcrypted() VMM fails
Cc: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170864200980.398.6769219282784108170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     82ace185017fbbe48342bf7d8a9fd795f9c711cd
Gitweb:        https://git.kernel.org/tip/82ace185017fbbe48342bf7d8a9fd795f9c711cd
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 22 Jan 2024 10:40:03 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 22 Feb 2024 14:25:41 -08:00

x86/mm/cpa: Warn for set_memory_XXcrypted() VMM fails

On TDX it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to take
care to handle these errors to avoid returning decrypted (shared) memory to
the page allocator, which could lead to functional or security issues.
In terms of security, the problematic case is guest PTEs mapping the
shared alias GFNs, since the VMM has control of the shared mapping in the
EPT/NPT.

Such conversion errors may herald future system instability, but are
temporarily survivable with proper handling in the caller. The kernel
traditionally makes every effort to keep running, but it is expected that
some coco guests may prefer to play it safe security-wise, and panic in
this case. To accommodate both cases, warn when the arch breakouts for
converting memory at the VMM layer return an error to CPA. Security focused
users can rely on panic_on_warn to defend against bugs in the callers. Some
VMMs are not known to behave in the troublesome way, so users that would
like to terminate on any unusual behavior by the VMM around this will be
covered as well.

Since the arch breakouts host the logic for handling coco implementation
specific errors, an error returned from them means that the set_memory()
call is out of options for handling the error internally. Make this the
condition to warn about.

It is possible that very rarely these functions could fail due to guest
memory pressure (in the case of failing to allocate a huge page when
splitting a page table). Don't warn in this case because it is a lot less
likely to indicate an attack by the host and it is not clear which
set_memory() calls should get the same treatment. That corner should be
addressed by future work that considers the more general problem and not
just papers over a single set_memory() variant.

Suggested-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/all/20240122184003.129104-1-rick.p.edgecombe%40intel.com
---
 arch/x86/mm/pat/set_memory.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index e9b448d..47af381 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2153,7 +2153,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 
 	/* Notify hypervisor that we are about to set/clr encryption attribute. */
 	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
-		return -EIO;
+		goto vmm_fail;
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2166,13 +2166,20 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	 */
 	cpa_flush(&cpa, 0);
 
+	if (ret)
+		return ret;
+
 	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
-	if (!ret) {
-		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
-			ret = -EIO;
-	}
+	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
+		goto vmm_fail;
 
-	return ret;
+	return 0;
+
+vmm_fail:
+	WARN_ONCE(1, "CPA VMM failure to convert memory (addr=%p, numpages=%d) to %s.\n",
+		  (void *)addr, numpages, enc ? "private" : "shared");
+
+	return -EIO;
 }
 
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)

