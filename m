Return-Path: <linux-kernel+bounces-81344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3C0867487
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95BCCB25B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661C26087A;
	Mon, 26 Feb 2024 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j3W/T6T3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CPPddy4G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFBA605A4;
	Mon, 26 Feb 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949571; cv=none; b=ooR20DtiywrCDpcgPsVrBFm8XG9OdTbYa46+nOJNb3yz6T7VXx5VXsXvYP2j6xHrdastIK82//mEyoFSnjFOmMGhzlf5YTFajbIH1Leb3rWMsevkfZjCq+0uR288Fd+q7S7Q7XHMUdPDdT6Cq5G/htCJs3N+oAG2JgasPGVJn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949571; c=relaxed/simple;
	bh=M3zALqseM1xjDZx+ABhJazwOHjpUTiVSF2sLLX/zrZc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MqFaEYkRf2gCQyulIx1N0eHlYR7IY4CIlCwr0YdgUNwCwcmpdjl1RPqQcGnv5pj1GqeZNIqN1D8i/exfgajPVSkEqHVfzX/PTriDcLvtH9pdWqqXlTmEd4VG46pAi1elhA24oxondOa+lNvLp6ysBO9Y2cBj+MYSPvBuOm5vTuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j3W/T6T3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CPPddy4G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 12:12:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708949567;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06BzHTpbA/22NpYtuS1jT3qMyjxhGzvHErj1VnfhLOc=;
	b=j3W/T6T3qmgcT6NuBU/TMyN/59caj/kDoI+vd2ItnyO9+sNnnYUuKo6xwktZfWx+NeraW4
	DHpocK4tuZUJeWJ/hIBfVIfsrvCzy90jBGMCFacuO9Ixr3PblDGIcvxsh6QOiMaLpF9HE+
	AM7Rr5pIjllijwTp6dqn1JAl/XgItvj/fa6anvSuzn3R90UaAzCVY2wqbKFRZyxKjbb2hZ
	bUyTnt00HLKvQKh07wR1WZZX3EdyuHkbKP6RDazav2ayurc+/A0gDw46Dst3k9dlOe+m36
	oRoJ+u9Rej/djZwu8APS4qyuAaSIrjq1+Wx724NBkQoEzfCLCShuS2igF4sDnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708949567;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06BzHTpbA/22NpYtuS1jT3qMyjxhGzvHErj1VnfhLOc=;
	b=CPPddy4GBvmkuchGpQ3XAcetsXnaeApV7DnX2yAZtvy3HKHmAHK7i1hAwCVZkfUMXmV59n
	Z+7ZasEvnS0OW5AQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/64: Use RIP_REL_REF() to assign 'phys_base'
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240221113506.2565718-20-ardb+git@google.com>
References: <20240221113506.2565718-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170894956714.398.18401706511421124908.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     d9ec1158056bedb6da8f4e02de30d300914b31f8
Gitweb:        https://git.kernel.org/tip/d9ec1158056bedb6da8f4e02de30d300914b31f8
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 21 Feb 2024 12:35:09 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 26 Feb 2024 12:58:35 +01:00

x86/boot/64: Use RIP_REL_REF() to assign 'phys_base'

'phys_base' is assigned from code that executes from a 1:1 mapping so it
cannot use a plain access from C. Replace the use of fixup_pointer()
with RIP_REL_REF(), which is better and simpler.

While at it, move the assignment to before the addition of the SME mask
so there is no need to subtract it again, and drop the unnecessary
addition ('phys_base' is statically initialized to 0x0)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240221113506.2565718-20-ardb+git@google.com
---
 arch/x86/kernel/head64.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 1d6865e..f98f5b6 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -192,6 +192,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * and the address I am actually running at.
 	 */
 	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
+	RIP_REL_REF(phys_base) = load_delta;
 
 	/* Is the address not 2M aligned? */
 	if (load_delta & ~PMD_MASK)
@@ -301,12 +302,6 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	for (; i < PTRS_PER_PMD; i++)
 		pmd[i] &= ~_PAGE_PRESENT;
 
-	/*
-	 * Fixup phys_base - remove the memory encryption mask to obtain
-	 * the true physical address.
-	 */
-	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
-
 	return sme_postprocess_startup(bp, pmd);
 }
 

