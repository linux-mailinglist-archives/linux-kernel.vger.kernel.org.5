Return-Path: <linux-kernel+bounces-76410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C196985F6F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795FE282283
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCAC446DE;
	Thu, 22 Feb 2024 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IgzfUFSE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="crDvkCQj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578E541775;
	Thu, 22 Feb 2024 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601470; cv=none; b=kO1jj3BiwjV/l36OF+aHSd/2htjR2etKTRhmc++M/d9bRopfqZaPmKiggOBNhBO41IcuGT18xj0y85ulNZQScAzJNPOCNkhStIjJU0dIRAZIxZr/Iv2Y2L7wJ+Giv2qKPrFife7kL0k7k7Mo6Mfd7VSHwPUNj9tfeKD5bk8/IWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601470; c=relaxed/simple;
	bh=y5OXnARYeFusvY6Or6+wIPXGBavk21Ik9v+34dOOtNg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I0G+6fT01/C6daE8RlsekT2XAIDXOTBtsSZzzA80KLhTkXQ1ktu1wjFaZ3FRXGp1ooICzSAXfAjZJ600BVy1xUjeVKwwibATfqitVArFqdQhdnW/WeuLDPat6MIBF05uOilEGG34Som0i7olq02xK1h2YzHvd5/J+S95eQc2MFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IgzfUFSE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=crDvkCQj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 11:31:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708601467;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RfBkxluRutbE/Lh/+wGlGRl086YIN4Xh8dFpPaGgW3I=;
	b=IgzfUFSEayCI69hmyk+7yPPDMH05xS6xUdHBd1SUAidNAVigpRfPDV9+27CO/fOzxJAc0Y
	XO1aSpNe3TncMDaSMmUoJYWF4wztO/jjJG9MAdjz09BSsawBVglPpZvLLIaioALb6hiTE9
	G95lIBqJlIaJZP/YZHvwNMiJ4XdE0h05hcQ7fwxsDjO154o73VojzrG7zyEP+uN7ZeYcjL
	/yFtGjJgVcfYPhEl/ZMCPGLZeGP/k305MGDtCe7j3K1GTXV1oU31dzRQH4WaJqtNgfObf8
	kmep1u6jCzLiaLUyO7jA4YZI+xpRHQZdgUS5SRtRfsN6sO3SQ+oqEJW+zL4ukg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708601467;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RfBkxluRutbE/Lh/+wGlGRl086YIN4Xh8dFpPaGgW3I=;
	b=crDvkCQjjzWTmaSTkr8ctT57V/YVizwaNe54z0uy+bo7aSDAtQbeV+6SLMYS/xUT7frf3g
	vx0/U9fyXjBWNuBQ==
From: "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/insn: Directly assign x86_64 state in insn_init()
Cc: Nikolay Borisov <nik.borisov@suse.com>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240222111636.2214523-3-nik.borisov@suse.com>
References: <20240222111636.2214523-3-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170860146647.398.7255494884182148282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     07a5d4bcbf8e70a430431991f185eb29e74ae533
Gitweb:        https://git.kernel.org/tip/07a5d4bcbf8e70a430431991f185eb29e74ae533
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Thu, 22 Feb 2024 13:16:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 22 Feb 2024 12:23:27 +01:00

x86/insn: Directly assign x86_64 state in insn_init()

No point in checking again as this was already done by the caller.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240222111636.2214523-3-nik.borisov@suse.com
---
 arch/x86/lib/insn.c       | 2 +-
 tools/arch/x86/lib/insn.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 3946bdc..1bb155a 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -71,7 +71,7 @@ void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
 	insn->kaddr = kaddr;
 	insn->end_kaddr = kaddr + buf_len;
 	insn->next_byte = kaddr;
-	insn->x86_64 = x86_64 ? 1 : 0;
+	insn->x86_64 = x86_64;
 	insn->opnd_bytes = 4;
 	if (x86_64)
 		insn->addr_bytes = 8;
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 5d81924..ada4b4a 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -71,7 +71,7 @@ void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
 	insn->kaddr = kaddr;
 	insn->end_kaddr = kaddr + buf_len;
 	insn->next_byte = kaddr;
-	insn->x86_64 = x86_64 ? 1 : 0;
+	insn->x86_64 = x86_64;
 	insn->opnd_bytes = 4;
 	if (x86_64)
 		insn->addr_bytes = 8;

