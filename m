Return-Path: <linux-kernel+bounces-161951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9A18B53B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE392812B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD8A3D555;
	Mon, 29 Apr 2024 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qax9COK7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vw8PjUUo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD92C6B2;
	Mon, 29 Apr 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381326; cv=none; b=Bi4FG5J3SZ3/ury54pSwTLWRjteEi0wQJ9OuoNzxP7JD0iEfB59AbnBPrkX8IMqjT76J9/4WtVgAg3qqDvVuOmkfKMkyG1cyE/ukCPGM6CDgDLGCEjjcpNdMLY6gQwdnRW7Zxiemdg8lHnLGtaUsTFEiNfnx61BcadetPSsJXqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381326; c=relaxed/simple;
	bh=a+sczFimb/5C9+NvSf+2YhXCfYOKRKDXRltztQREnd8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=fN/6R/D9NnhfBIqD8i14QYPX4Q6YqPFuArecFHI1SQz2m5EAB8CexC11An4GAgBYHY1tLihYdRay8aLb457RMMG3GzbETVqNKALoACwkBVM+X1yzgRENqa3Hw8Kl5CsT2vRND9mDnbIUvbONCW8JdFKVVrSLMI/dixr+fvum4y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qax9COK7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vw8PjUUo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 09:01:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714381315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=58tYNnWmiz1o8ITV6x43tPibzrN4Iisn0nfoBt6Xs84=;
	b=qax9COK7jGXr4d5ku9eggKLxIfNugby4aWfN1IF5fmC5nAHSlZ4MhFtZCMjHwgFzSBtybB
	zY1BYEpHdNRq3tETQ7+zsdLkS46+DiyP0F/wUAuqpVekZokZHA5wDczBbqKqQycoiAUP+E
	uZZBHG5ISasQPZ4rI9BhhoDAt5S3gnc61wWJgUrNo7DCpD+zEvcQI/keJQT1NJp0YhOi6z
	YqZ+FAL9Z6EjwRVjCfgu22crQS8GgSg9OV+ZOX8DkpdinomDpYRq0kTUXuWmG8RFd9DkIQ
	1CvDBmNyciCs1wavo2siFvlt4ic84B/HcvQQFaJNjy5OA057PdYfEY+7bLglog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714381315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=58tYNnWmiz1o8ITV6x43tPibzrN4Iisn0nfoBt6Xs84=;
	b=Vw8PjUUoDbOwZNaAtKXFzHwpAS55ZQtPF3sL26tXS+NM7HQNJG3ZLoJx0n0kedoea8h3yO
	6nHILx7UueSeWgCQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/apic: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171438131527.10875.12640613409117703901.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     8fb5f44e5df42b0ba35f4a9c36c523cca22f357f
Gitweb:        https://git.kernel.org/tip/8fb5f44e5df42b0ba35f4a9c36c523cca22f357f
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:04 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Apr 2024 10:31:08 +02:00

x86/apic: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240424181504.41634-1-tony.luck%40intel.com
---
 arch/x86/kernel/apic/apic.c | 38 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index c342c4a..f76aaf5 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -497,32 +497,32 @@ static struct clock_event_device lapic_clockevent = {
 static DEFINE_PER_CPU(struct clock_event_device, lapic_events);
 
 static const struct x86_cpu_id deadline_match[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(HASWELL_X, X86_STEPPINGS(0x2, 0x2), 0x3a), /* EP */
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(HASWELL_X, X86_STEPPINGS(0x4, 0x4), 0x0f), /* EX */
+	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X, X86_STEPPINGS(0x2, 0x2), 0x3a), /* EP */
+	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X, X86_STEPPINGS(0x4, 0x4), 0x0f), /* EX */
 
-	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_X,	0x0b000020),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	0x0b000020),
 
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x2, 0x2), 0x00000011),
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x3, 0x3), 0x0700000e),
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x4, 0x4), 0x0f00000c),
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x5, 0x5), 0x0e000003),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x2, 0x2), 0x00000011),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x3, 0x3), 0x0700000e),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x4, 0x4), 0x0f00000c),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x5, 0x5), 0x0e000003),
 
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x3, 0x3), 0x01000136),
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x4, 0x4), 0x02000014),
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x5, 0xf), 0),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x3, 0x3), 0x01000136),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x4, 0x4), 0x02000014),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x5, 0xf), 0),
 
-	X86_MATCH_INTEL_FAM6_MODEL( HASWELL,		0x22),
-	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_L,		0x20),
-	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_G,		0x17),
+	X86_MATCH_VFM(INTEL_HASWELL,		0x22),
+	X86_MATCH_VFM(INTEL_HASWELL_L,		0x20),
+	X86_MATCH_VFM(INTEL_HASWELL_G,		0x17),
 
-	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL,		0x25),
-	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_G,	0x17),
+	X86_MATCH_VFM(INTEL_BROADWELL,		0x25),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,	0x17),
 
-	X86_MATCH_INTEL_FAM6_MODEL( SKYLAKE_L,		0xb2),
-	X86_MATCH_INTEL_FAM6_MODEL( SKYLAKE,		0xb2),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		0xb2),
+	X86_MATCH_VFM(INTEL_SKYLAKE,		0xb2),
 
-	X86_MATCH_INTEL_FAM6_MODEL( KABYLAKE_L,		0x52),
-	X86_MATCH_INTEL_FAM6_MODEL( KABYLAKE,		0x52),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		0x52),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		0x52),
 
 	{},
 };

