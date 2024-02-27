Return-Path: <linux-kernel+bounces-82515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0288685AA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62280B21DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BFB4C80;
	Tue, 27 Feb 2024 01:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GGq6kkVn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pIfC1t8w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADF717F8;
	Tue, 27 Feb 2024 01:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996751; cv=none; b=E2ce0OJl4RIxJfHqcs2fUn3pYWnb5zBX+mLKQSfWW4zglVWZnQrQILWT3yM0MMW4emSD/iUCHvA79y66Hm1+UpdY4W6czOMZ6nvuXPDinqRDLfhLOKtkf+tizHAiRIKssm4y0WJx0k7l849fInJ5yvcsUkoqN50YvygAnu30Mfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996751; c=relaxed/simple;
	bh=ZD4BT/PchIrzJ5kXhkTjQJ2PhCearqf1xLE+6UKCOXc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ELONY7ib4JW7DiP9Pgw9GJ2cwnfnFjOhJ2OXyV+Ii3zqtpAzJVgaWxqxZQHKyZvWsCT6hZiR2Xs9k77uk44zFkwjFv+xCXiJkYrM67miRagH1ydSStA99UJA3qBtEbVzDe3vFOjlvEx/SNVxSXi6mKuMl5UX4N/n3HQSSmisVe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GGq6kkVn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pIfC1t8w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 01:19:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708996746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9x4Y/V10TNa0eZjEcvYgTWFz/9IHlJYX81BPVAL6Iao=;
	b=GGq6kkVnA74VoTCdqe9Pqop1xMlbryLpc1AFPmgBQR9DV4cTe1isJDy2V5xHOxaLGael7t
	GoWVBlJeOrU9vLeWU6bi80n9atgYjQVdhQFrliBLFwAzAMJ7OJjYcnxFfnSmffss3h/d5P
	d23O+N3K54LfmAM5/dc8tWqnWtHtoWKktTQT83Mz7wmMnLU0lw2Cxcdb0NNHkcvbVPjYcc
	q6rQ4czR3aIesMpZ/PtvmVPuvJPN+R6JRVIrW6XvDzSw9LLjwAIX/GCrI5lr2S6iju7w53
	ASb4FeD49EXqj35QPhW29u+KulZf7sCmUo7l/LIFI0a978yynNt32LiPuevcLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708996746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9x4Y/V10TNa0eZjEcvYgTWFz/9IHlJYX81BPVAL6Iao=;
	b=pIfC1t8wY1eZaDjCVhkY+jXHTTAFqf7Zs5J8kShfLRzeBvZC3NdAzek3LKqW/FQIvcra1f
	LXIPxu1Ss/nGFAAg==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Use fixed addressing for VERW operand
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170899674562.398.6398007479766564897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8009479ee919b9a91674f48050ccbff64eafedaa
Gitweb:        https://git.kernel.org/tip/8009479ee919b9a91674f48050ccbff64eafedaa
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Mon, 26 Feb 2024 15:52:33 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 26 Feb 2024 17:06:17 -08:00

x86/bugs: Use fixed addressing for VERW operand

The macro used for MDS mitigation executes VERW with relative
addressing for the operand. This was necessary in earlier versions of
the series. Now it is unnecessary and creates a problem for backports
on older kernels that don't support relocations in alternatives.
Relocation support was added by commit 270a69c4485d ("x86/alternative:
Support relocations in alternatives").  Also asm for fixed addressing
is much cleaner than relative RIP addressing.

Simplify the asm by using fixed addressing for VERW operand.

[ dhansen: tweak changelog ]

Closes: https://lore.kernel.org/lkml/20558f89-299b-472e-9a96-171403a83bd6@suse.com/
Fixes: baf8361e5455 ("x86/bugs: Add asm helpers for executing VERW")
Reported-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240226-verw-arg-fix-v1-1-7b37ee6fd57d%40linux.intel.com
---
 arch/x86/include/asm/nospec-branch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 2aa52ca..ab19c7f 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -323,7 +323,7 @@
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
 .macro CLEAR_CPU_BUFFERS
-	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
+	ALTERNATIVE "", __stringify(verw mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF
 .endm
 
 #else /* __ASSEMBLY__ */

