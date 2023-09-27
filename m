Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB637AFDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjI0IOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjI0INo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:13:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6BC10D2;
        Wed, 27 Sep 2023 01:11:58 -0700 (PDT)
Date:   Wed, 27 Sep 2023 08:11:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695802316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anBIMX9rLdyTWTzEQKQtKINs44DkgVwTkIyn5z1kY9U=;
        b=kp5WwD3zr+r2W4ZfnLFyXo03lwv8weqRuhLiQI8BKTdkms32k1nzOiIB0L5z6F/cmeRdXS
        XoxeBFxOcvywP2K7ck+xqHrrBX8vq2Oj2gU/OEaXAY2vNkmpNgz7LFuw7rjIV31SxGZI24
        igd18Ql04FqElVTHHYpwMq9tvcqAgoqcEKyh4FBWose2c58kHFsoL+YXCdn7unCZa4AqX5
        0FIbT0O0ALaA5x2rRKWOHdDBTSmE8sQhtMUmpmYo0P0pArvW0Hfojt8TK9SDDpF7yum8On
        iP1WFKn619h5lyq6RPP7AwDay7Nzg4Cb9RVa5v15CIHKO/CJIMY3zPQPe598wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695802316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anBIMX9rLdyTWTzEQKQtKINs44DkgVwTkIyn5z1kY9U=;
        b=o5Upo1nIJOmCtFIuOvhkdGMK7yjXjMDIpgJP/p9TCBiYfEmKfhxQiEhUhFgIX38IVlH4/e
        HdwUPerc27td4cDA==
From:   "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/entry: Remove unused argument %rsi passed to exc_nmi()
Cc:     "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230926061319.1929127-1-xin@zytor.com>
References: <20230926061319.1929127-1-xin@zytor.com>
MIME-Version: 1.0
Message-ID: <169580231566.27769.3338218292814732836.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     da4aff622a7ae424a0292d7288744692fca34319
Gitweb:        https://git.kernel.org/tip/da4aff622a7ae424a0292d7288744692fca34319
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Mon, 25 Sep 2023 23:13:19 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Sep 2023 10:04:54 +02:00

x86/entry: Remove unused argument %rsi passed to exc_nmi()

exc_nmi() only takes one argument of type struct pt_regs *, but
asm_exc_nmi() calls it with 2 arguments. The second one passed
in %rsi seems to be a leftover, so simply remove it.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://lore.kernel.org/r/20230926061319.1929127-1-xin@zytor.com
---
 arch/x86/entry/entry_64.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 43606de..fb8dd56 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1237,7 +1237,6 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	movq	%rsp, %rdi
-	movq	$-1, %rsi
 	call	exc_nmi
 
 	/*
@@ -1451,7 +1450,6 @@ end_repeat_nmi:
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi
-	movq	$-1, %rsi
 	call	exc_nmi
 
 	/* Always restore stashed SPEC_CTRL value (see paranoid_entry) */
