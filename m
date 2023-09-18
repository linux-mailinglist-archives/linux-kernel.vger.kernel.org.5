Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1357A5418
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjIRU2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjIRU15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:27:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A62F119;
        Mon, 18 Sep 2023 13:27:51 -0700 (PDT)
Date:   Mon, 18 Sep 2023 20:27:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695068868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXarTd7h80pS9CevpZMD+Q39jLm42otwbryQ+NFoxm8=;
        b=LwQJy4qkqEKR6+ZPWu5lebiuYZMwKZLUhomkqmaBvg67XvOlaRgItuPUbyZQGTP/fhx3oQ
        PgoRLZcvdqEjmr39jF+IsS0HzZZUOTL4ES3vVSG5oq8gHDCHxV7/kuxRK8NuQ4Zsu9OyjN
        0paVD3ykH41sb7iOwLRFCq1+Sw0HGv6hok/9R6LV54Jht/Ob+zfzRgERfDp4w/lih7hrPc
        mBDp9viMV8Sxmf44wpf2r6CrZBTxMJNhbb24ZfQBkIckdk+xX4tj3K0s4GUnfrWdmnb1pR
        LQgCwb2WK3MUDurx7qrfO1wb10/L3JneZuDAIoKI7gife3gLCMZWdk94GnDELw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695068868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXarTd7h80pS9CevpZMD+Q39jLm42otwbryQ+NFoxm8=;
        b=knPUmm2d/PvPmZoNd/aBVmRTglWkwa5v5eMbqgsLfq1lfRceV0pSWgN8OZHHL/V7PkQzGE
        6Xsu2J3ncqBU5rDA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockref/x86: Enable
 ARCH_USE_CMPXCHG_LOCKREF for X86_CMPXCHG64
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230918184050.9180-1-ubizjak@gmail.com>
References: <20230918184050.9180-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169506886746.27769.14933126685918343806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a432b7c0cf420dbf2448c6bda6a6697afbb153d5
Gitweb:        https://git.kernel.org/tip/a432b7c0cf420dbf2448c6bda6a6697afbb153d5
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 18 Sep 2023 20:40:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 18 Sep 2023 22:18:32 +02:00

locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF for X86_CMPXCHG64

The following commit:

  bc08b449ee14 ("lockref: implement lockless reference count updates using cmpxchg()")

enabled lockless reference count updates using cmpxchg() only for x86_64,
and left x86_32 behind due to inability to detect support for
cmpxchg8b instruction.

Nowadays, we can use CONFIG_X86_CMPXCHG64 for this purpose. Also,
by using try_cmpxchg64() instead of cmpxchg64() in the CMPXCHG_LOOP macro,
the compiler actually produces sane code, improving the
lockref_get_not_zero() main loop from:

  eb:	8d 48 01             	lea    0x1(%eax),%ecx
  ee:	85 c0                	test   %eax,%eax
  f0:	7e 2f                	jle    121 <lockref_get_not_zero+0x71>
  f2:	8b 44 24 10          	mov    0x10(%esp),%eax
  f6:	8b 54 24 14          	mov    0x14(%esp),%edx
  fa:	8b 74 24 08          	mov    0x8(%esp),%esi
  fe:	f0 0f c7 0e          	lock cmpxchg8b (%esi)
 102:	8b 7c 24 14          	mov    0x14(%esp),%edi
 106:	89 c1                	mov    %eax,%ecx
 108:	89 c3                	mov    %eax,%ebx
 10a:	8b 74 24 10          	mov    0x10(%esp),%esi
 10e:	89 d0                	mov    %edx,%eax
 110:	31 fa                	xor    %edi,%edx
 112:	31 ce                	xor    %ecx,%esi
 114:	09 f2                	or     %esi,%edx
 116:	75 58                	jne    170 <lockref_get_not_zero+0xc0>

to:

 350:	8d 4f 01             	lea    0x1(%edi),%ecx
 353:	85 ff                	test   %edi,%edi
 355:	7e 79                	jle    3d0 <lockref_get_not_zero+0xb0>
 357:	f0 0f c7 0e          	lock cmpxchg8b (%esi)
 35b:	75 53                	jne    3b0 <lockref_get_not_zero+0x90>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20230918184050.9180-1-ubizjak@gmail.com
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfaba..1379603 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -28,7 +28,6 @@ config X86_64
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_PER_VMA_LOCK
-	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
@@ -118,6 +117,7 @@ config X86
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_USE_BUILTIN_BSWAP
+	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
