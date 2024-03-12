Return-Path: <linux-kernel+bounces-100462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12AE8797D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFC228A4BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059BA7C6F0;
	Tue, 12 Mar 2024 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HmE1VX0q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hmMjoab8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50377C6D2;
	Tue, 12 Mar 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257989; cv=none; b=Uu1KLO2kvPd4VG6n6HrKYF0lTaUysdyjs3SOikGGgUSAkoSb3G4TIAD6Ai2YgRM8n3yu4JKxJEpHZsk+IkDCm+N5wh5S70m6p9BIO4+3F/Fq2p7PnhI+zCPtvX8aF9bcnQ15UmJPwhMq5DVgEhXBBc1CD5FamtqWxjnh96NWlx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257989; c=relaxed/simple;
	bh=57D5IAmOzO+bKJrdsCy/GFSoHV0KU4Bf7lhBQ0v9IfE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=kyp1kNvjma8AXWZOke/V1dp0HPO0r2nGvmHt5a/ty/jwrDCvFLwNHcxI8zOulOV9/sm8LTeXyO4phqJLQuxn8fikgsNYh7RBEuCN2aYQ3c13Mt/1uJSHranF7qcI3rqxYPvRTOMqj6Da3Q1u4of7KrgJdPH4SK5k1IvhpO7H+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HmE1VX0q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hmMjoab8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 15:39:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710257986;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xDNKIL2HfUl0ClGAEkjyAwQtbUUBTePppgCTo5zkaAQ=;
	b=HmE1VX0qpFN2QwoJ1jOBWwbQoqP6ntX+ezqlZQskG1NLB9BNJ0Ycv9HqOhxxweMQD/DVBt
	tn5nxx/QWWfq9qGD5cDK/YswnBptKpl1NeTVB0JFn5WiK7bEEkJTGrS3yG76kKg6HA73He
	EKaUtzJul2h0IvawBbkhOyJYbMVtKQY1m7e3XoNZijHicOhA2YxRgwRGV87nZOYieuGMqq
	Yl9IHeaWVJ2J2XvXN7/tDO//SUZU6l+FMkqp3+rSri/4WG7tTOin/sjKCaGOCTNpeziJty
	N1CO6WB9vYKKA0GHnd9vAzZlNB8CCb94qJrLFKgYUBVBKfIaf9zkAuiaNtgz2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710257986;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xDNKIL2HfUl0ClGAEkjyAwQtbUUBTePppgCTo5zkaAQ=;
	b=hmMjoab8uyMzMnW7ZpmIhMfo+fhIsBDkeHr7xp+XWnO2q6fNSgB2zj7fpZt4ftxOT11ISg
	d7cBBZJIot8DtyBQ==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] Revert "x86/bugs: Use fixed addressing for VERW operand"
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171025798510.398.15036721545498357985.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     532a0c57d7ff75e8f07d4e25cba4184989e2a241
Gitweb:        https://git.kernel.org/tip/532a0c57d7ff75e8f07d4e25cba4184989e2a241
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Tue, 12 Mar 2024 07:27:57 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 12 Mar 2024 08:33:51 -07:00

Revert "x86/bugs: Use fixed addressing for VERW operand"

This was reverts commit 8009479ee919b9a91674f48050ccbff64eafedaa.

It was originally in x86/urgent, but was deemed wrong so got zapped.
But in the meantime, x86/urgent had been merged into x86/apic to
resolve a conflict.  I didn't notice the merge so didn't zap it
from x86/apic and it managed to make it up with the x86/apic
material.

The reverted commit is known to cause some KASAN problems.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/include/asm/nospec-branch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index ab19c7f..2aa52ca 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -323,7 +323,7 @@
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
 .macro CLEAR_CPU_BUFFERS
-	ALTERNATIVE "", __stringify(verw mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF
+	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
 .endm
 
 #else /* __ASSEMBLY__ */

