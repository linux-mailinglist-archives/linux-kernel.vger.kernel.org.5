Return-Path: <linux-kernel+bounces-161206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7CC8B48FC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F9C1F21CBA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 01:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36885A5F;
	Sun, 28 Apr 2024 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K2UCutB6"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E778364A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714266013; cv=none; b=o3Xdg1LchZbIGqlpQUBTODdW3uMGzbhywS3TcvLJkj79hkWyJdDfDXbDUSFiZxRfflhebW7svThl7yLZtr+CdFcGykpLCkBSxz7q581ig5S9Kg/fvQPPn9/fwOLjVekUhWzAymSQdt9fzRedYH1lTZHSlGbdznADz2Q1YzkH2eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714266013; c=relaxed/simple;
	bh=jHknUYvMTs/qmIX8gSVqBhO8YwAhP0j63afjH3jo+gw=;
	h=To:Cc:Message-Id:From:Subject:Date; b=m55qcKZ5yZvj2iP8zxXTwLU4ZSwKEXi8lcTH91nTL3j6e1QyPoMKFGmNQUl3Lem3AmHIphQfJ+egqhWpL72F0v8jYkTyzU8hZhPbQ0QJUkhXl6kE6VDCYSmLvPXO3/31ybZ4LVrWiX60b0X8UcFOr5b/kHsu6Ab8kH3FDWYMZi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K2UCutB6; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 944861800116;
	Sat, 27 Apr 2024 21:00:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 27 Apr 2024 21:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1714266008; x=1714352408; bh=lLPgP7wkBqHM0
	uInpzkEUajZ0JcLSbNkr/nAV3+Lc7k=; b=K2UCutB6KM5aPMTSl+CqRnH7mCtID
	GYjWNJYbOW6WbXqHrXQSsU9akozkf3BsdBGyCkjwBrsz4nxEVODj2+Yf831WKlXM
	4OYwc37BGUfridIZo2HDj4i5XZTBCArvAlOvjRptTMkpqAcmC7DSuPcjE4s+MXTd
	Z2OqtzqQ6JHORPwHoAi3gjmh/S6r5Ns/QhVwRu9ixrL+9pZtzFLCyBzMOvwV4qia
	THVIPkPooAkW2hkkuFy+nV0PlM4qiQIJRnACyvJs2z5cKxcBf07sDxLn5s2ceCUa
	l3SvRY/PQTIg853QGyBPBnIuKw9JMPyG9tPjPbtMjexDLS1/k/FtTGDDg==
X-ME-Sender: <xms:l58tZnRzJXb0lnDZTS2DneJyiu5tpzP1-V8v8DFAc89WOnIGfp32lg>
    <xme:l58tZox8kkJFHGzZ8KU5RhQq81zSVQJOKkrrgDHqWfhpuvF_0F6bOBQhZJfysq7Jl
    -HIKOCX4ohJhRRlbKM>
X-ME-Received: <xmr:l58tZs0ntSR4a14q9MyD_7RlyxluCE36tKL66ximBvybzx5-lLX4R0LueISCnkw5HDmECnYEjZmgEtm7m6PxLaOgVpmVxa8nOpU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtvddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehfffggeefveegvedtiefffeevuedtgefhueehieetffejfefggeevfeeuvdduleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:l58tZnCMwx7PGKM0FoEnf4PlTx05hz5sIMpyPwZFXC1PMfWcQfIvJQ>
    <xmx:l58tZggw85yMknl0eVtIFjgEIcrwAyqC2jQX-nVh01h23OkJ8SmzOQ>
    <xmx:l58tZro_-QgcgquskDQ0th1oUkCoi4vC3Hj8BoH1dDuafnKKqHy76A>
    <xmx:l58tZrjPdj8avur1PecYzs6-v0dmwskqsRljEq9XrkCEJse3qyuFuQ>
    <xmx:mJ8tZpsiQJhf0VB6CWhO4sOQWx2ixHmkRWQFbuq5eSdHDMZHuiZe6YJU>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Apr 2024 21:00:04 -0400 (EDT)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Michael Schmitz" <schmitzmic@gmail.com>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-Id: <1ed9c4c753395510c1a8df9c35e2ad4c31c90f95.1714265926.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] m68k: Handle put_user() faults more carefully
Date: Sun, 28 Apr 2024 10:58:46 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Running 'stress-ng --sysbadaddr -1' on my MC68040 system immediately
produces an oops:

    Unable to handle kernel access at virtual address f1c422fb
    Oops: 00000000
    Modules linked in:
    PC: [<00005a1a>] do_040writeback1+0xae/0x160
    SR: 2010  SP: 96087dc2  a2: 01500000
    d0: 00000000    d1: 014e8000    d2: 00000081    d3: 00000000
    d4: 00000481    d5: c043dfff    a0: 014e8000    a1: 00632fd5
    Process stress-ng (pid: 221, task=1b729d30)
    Frame format=7 eff addr=014e9eb8 ssw=0c81 faddr=c043dfff
    wb 1 stat/addr/data: 0001 00000481 c043dfff
    wb 2 stat/addr/data: 0081 c043dfff 2f746d70
    wb 3 stat/addr/data: 0005 014e9ed4 2f746d70
    push data: c043dfff 800daa70 00000000 014e9f1c
    Stack from 014e9ed4:
      2f740000 8017c000 014e9f10 00006830 00000081 c043dfff 2f746d70 2f746d70
      0081a000 00000400 c043dfff 800daa70 c043dfff 80016a20 00000003 014e9f88
      000026c8 014e9f1c 00000001 2f746d70 0081a000 00000400 c043dfff 0081afff
      c043dfff 01500000 00000001 ffffffff 00000000 20000046 41d67008 014e9f58
      04810005 00810045 c043dfff 014e9f84 2f746d70 c043dfff 2f746d70 c043dfff
      80016a20 8017c000 00000000 0081affb 00000005 014e9fc4 00128bc6 c043dfff
    Call Trace: [<00006830>] buserr_c+0x510/0x698
      [<000026c8>] buserr+0x20/0x28
      [<00128bc6>] sys_getcwd+0xc8/0x15a
      [<000027a2>] syscall+0x8/0xc
      [<0008800d>] sanity_check_segment_list+0x17/0x11e

    Code: 000c 0e90 1800 220f 0281 ffff e000 2041 <2228> 0008 0281 00ff
          ff00 67a4 6026 4280 122e 0013 206e 000c 0e10 1800 220f 0281

The cause is a deliberately misaligned access in the 'bad_end_addr' test
case in the 'sysbadaddr' stressor. The location being accessed here,
0xc043dfff, was contrived to span the boundary between a r/w anonymous page
and an unmapped page. The address was then passed to the getcwd syscall
which faulted in copy_to_user().

The fault for the mapped page appears to be handled okay -- up until
do_040writeback1() called put_user() which produced a second fault due to
the unmapped page.

Michael Schmitz helpfully deciphered the oops and explained the exception
processing leading up to it.

    "regs->pc does point to the PC in the format 7 frame which is the PC
    the fault was detected at, but not (in case of a writeback fault)
    the PC of the faulting instruction [that is, MOVES.L].

    "The writeback would still cross the page boundary, and fault if the
    unmapped page still isn't present. We would not see the PC of the
    movesl in that case, and fail to find the PC in the exception
    table."

One solution is to add a NOP instruction after the MOVES.L to flush the
pipeline and take the fault. That way, the PC value in the exception frame
becomes dependable so the exception table works.

Theoretically, there seems to be another bug in the existing code. If
the instruction following the MOVES faulted, then after the fixup,
execution would resume at the instruction which caused the fault. This
appears to be a loop. After this patch, that cannot happen.

Cc: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-and-tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---

So far this has only been tested on Motorola 68030 and 68040 systems
and still needs testing on the other MMU-enabled processors.

I don't know whether or not get_user() has the same problem. Hence this
patch is confined to put_user().

No change since RFC patch.
---
 arch/m68k/include/asm/uaccess.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/include/asm/uaccess.h b/arch/m68k/include/asm/uaccess.h
index 64914872a5c9..44e52d8323e5 100644
--- a/arch/m68k/include/asm/uaccess.h
+++ b/arch/m68k/include/asm/uaccess.h
@@ -31,11 +31,12 @@
 #define __put_user_asm(inst, res, x, ptr, bwl, reg, err) \
 asm volatile ("\n"					\
 	"1:	"inst"."#bwl"	%2,%1\n"		\
-	"2:\n"						\
+	"2:	nop\n"					\
+	"3:\n"						\
 	"	.section .fixup,\"ax\"\n"		\
 	"	.even\n"				\
 	"10:	moveq.l	%3,%0\n"			\
-	"	jra 2b\n"				\
+	"	jra 3b\n"				\
 	"	.previous\n"				\
 	"\n"						\
 	"	.section __ex_table,\"a\"\n"		\
@@ -53,11 +54,12 @@ do {								\
 	asm volatile ("\n"					\
 		"1:	"inst".l %2,(%1)+\n"			\
 		"2:	"inst".l %R2,(%1)\n"			\
-		"3:\n"						\
+		"3:	nop\n"					\
+		"4:\n"						\
 		"	.section .fixup,\"ax\"\n"		\
 		"	.even\n"				\
 		"10:	movel %3,%0\n"				\
-		"	jra 3b\n"				\
+		"	jra 4b\n"				\
 		"	.previous\n"				\
 		"\n"						\
 		"	.section __ex_table,\"a\"\n"		\
-- 
2.39.3


