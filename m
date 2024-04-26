Return-Path: <linux-kernel+bounces-160548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9919A8B3F03
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01603B2269D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789C917279C;
	Fri, 26 Apr 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jIHwp0rF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E3/K1pE5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CB216F8FB;
	Fri, 26 Apr 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155137; cv=none; b=Pi9CR5689JcXLCGzxjsTPrFrmJgqYdqd5wWsm5Xep4fad9Kb7DTtwe6uqE1NIf/u2aS3P+zla+eLzPYkt+oyJesqoATkKhviet+GeExYhB8JX2e6hBb9/jeFXaVPqaQ+dRjYQ/SzuTIu1LMnBgr4ijJUS0Qr5dAwVJIrGvwJRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155137; c=relaxed/simple;
	bh=/P7MfTAlOkoCL2TJqZpojc6Jy5X+VVo52LZ4BaCkiCE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=sB3DAsqCJStYDE9epb249u/jVY+WhjbL/s8FELxPdxn5S8kRA2OvjrqRvkCDf9VAeYmed8Md6/jLS+pET8Jh5Pi+0iCdQaJIrDWFMsP9qICtMGFx0PYd2r6JGi1DXzFwDMlaJMMw94VVYLZoaNrqfrNexOjNluO/qL7DeSFscxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jIHwp0rF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E3/K1pE5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Apr 2024 18:12:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fc1GrO0BYXxDgAEiOy4PdaY1Zm6pp4jRnSgh4FJwF2Q=;
	b=jIHwp0rFDyPpSBtw7et9M7/P8HmeFDZ7A1QNiu+ONgyi5xkGLkrbxLwbyjofEsmqswb/V0
	SU7bvtK7uhxiQz4JzxKwV2ISkX0MyR7ScqAKu0LUovcbMpfQrHmh1D4z5hM2SVPcl09K4s
	5njtdctAFSJFxwa8NtfYxSO2otr7FIrcKWEhewT5pTD5Kg4NQyYPjTSk4PUijTa6i6PTTv
	7wPbakxqiPHvP98hem6e+m/OKRCQmu+Plu1EaJZd2yxGLg2y4ErrbdG/H3wDGluWjTDdFN
	GtMrx1PFNTSdZa9DFv+eaM2GCgjQdW1k41W4UtVAEVa3+0X7oFxaKItyJ2C0uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fc1GrO0BYXxDgAEiOy4PdaY1Zm6pp4jRnSgh4FJwF2Q=;
	b=E3/K1pE5Fmwo+Y7ayX3b/knhxlzeIbNh/mOXUfdBJ1MwqEeAoWLtKZ2zkQJ2pBptdMMNg5
	046lP3cPXHrBTXAw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171415513152.10875.6741484193923117142.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     34304acb329073722a2fc4859489b83a0b870753
Gitweb:        https://git.kernel.org/tip/34304acb329073722a2fc4859489b83a0b870753
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:11 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 26 Apr 2024 08:49:24 -07:00

x86/cpu: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181511.41753-1-tony.luck%40intel.com
---
 arch/x86/kernel/cpu/match.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 2243083..8651643 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -25,7 +25,7 @@
  * asm/cpu_device_id.h contains a set of useful macros which are shortcuts
  * for various common selections. The above can be shortened to:
  *
- * X86_MATCH_INTEL_FAM6_MODEL(BROADWELL, NULL);
+ * X86_MATCH_VFM(INTEL_BROADWELL, NULL);
  *
  * Arrays used to match for this should also be declared using
  * MODULE_DEVICE_TABLE(x86cpu, ...)

