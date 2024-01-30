Return-Path: <linux-kernel+bounces-44939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1DC84293D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1ABA1C25D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D3012FF84;
	Tue, 30 Jan 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MDwEQXcP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8ZOshKE6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F5812CD83;
	Tue, 30 Jan 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631974; cv=none; b=Z1dYbTp1xmo6WnaJzBbcEqtoHcA6WD0UXLbTbDd59d2aJv8oiSqMSmyFM2UbY8KtUFJlLRFBQsQmABuKNQnbyPHtriNxH0PwJ+utIsl7/34UUfzbezkeomKS2OOjKdh+fOl1bdLhJ5GAYgiuwfPAjLuEHu/MFexN2qFrQ1ymEAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631974; c=relaxed/simple;
	bh=18lDJBL5Xbc+prq+OIpGIW2u67loPhttfD4CTewEB2E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=br+EBbIyPsL1rL3riakP38VXAPGd2eJdWb06tNFTgDvdebSRw0HNEZR6mFAgQdnBaqyK1OK5d4I4WxP633UZPZ5R9IGchWbji5EeTNiyFNjRxWOGygFhjyUkjOUxsB/UJJp4yBKf0AYGHKyaHCbcw1/VORvnJA5lP+FZDK6hSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MDwEQXcP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8ZOshKE6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqzTEgvH64oVRnXYxWwBGRSpE6bGKNbg1Gk+TGTGpV0=;
	b=MDwEQXcPCKbOOf+mkuIPSxnIVsj7pMsQ/aMUaz5JdtRQ1qWN255tqQkBmkEStYdUS1dJLW
	90AY1+j7D/pql0es9oFXqiOBqr7temsg0qoahB8rOUPqH3ppjnK1kBnHCJDCxCIb3vnv0P
	rMMYNs4OLhKM5hXuDSOptEo0bqhaBwdtc4R9uQMZhsNb5lSpEPCSha/QoFxI2XEFUU51zU
	zWM57kJjPe+sDonNLX7xOSeJDE42Sk6H9adWCvAy6lqoy4vFWkxE4nLLC0Hwgp4/9rvt+s
	SqAEl3NsKJ4SJ0u2MS1yKRRtJnfy2eXJIXCq1nYLgoG7WaKjxCWFvZ8iVYxQRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqzTEgvH64oVRnXYxWwBGRSpE6bGKNbg1Gk+TGTGpV0=;
	b=8ZOshKE6Q4rsBNzbqy2lpIjmuvsH6XpiyuAMgIJkkL2yhAW9bwZqqWGsvmbc6KYlTPfuHz
	mXbm4/aBlQNeVMDg==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/mtrr: Don't print errors if MtrrFixDramModEn is
 set when SNP enabled
Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-6-michael.roth@amd.com>
References: <20240126041126.1927228-6-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663197000.398.7586009633067703455.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     e3fd08afb7c350d5612f113eadfb4ebb6ed08deb
Gitweb:        https://git.kernel.org/tip/e3fd08afb7c350d5612f113eadfb4ebb6ed08deb
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:05 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 17:24:27 +01:00

x86/mtrr: Don't print errors if MtrrFixDramModEn is set when SNP enabled

SNP enabled platforms require the MtrrFixDramModeEn bit to be set across
all CPUs when SNP is enabled. Therefore, don't print error messages when
MtrrFixDramModeEn is set when bringing CPUs online.

Closes: https://lore.kernel.org/kvm/68b2d6bf-bce7-47f9-bebb-2652cc923ff9@linux.microsoft.com/
Reported-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-6-michael.roth@amd.com
---
 arch/x86/kernel/cpu/mtrr/generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index d352477..422a4dd 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -108,6 +108,9 @@ static inline void k8_check_syscfg_dram_mod_en(void)
 	      (boot_cpu_data.x86 >= 0x0f)))
 		return;
 
+	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return;
+
 	rdmsr(MSR_AMD64_SYSCFG, lo, hi);
 	if (lo & K8_MTRRFIXRANGE_DRAM_MODIFY) {
 		pr_err(FW_WARN "MTRR: CPU %u: SYSCFG[MtrrFixDramModEn]"

