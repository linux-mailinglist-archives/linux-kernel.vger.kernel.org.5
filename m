Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94357AFDF3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjI0IOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjI0IOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:14:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBDC2D59;
        Wed, 27 Sep 2023 01:11:59 -0700 (PDT)
Date:   Wed, 27 Sep 2023 08:11:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695802315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F2YEJv2i0yEIX+nDdMm0jTyutLcuZK+A6tHuXZ9sFuo=;
        b=gYav+X/CT9oUiDukPAMDaUeAnQ/1zx7xd6BuGh0n3Ccql1f+MFwP0NMo5jMcPtCz7pW7r/
        CWiyYb9mJNtLyaxWpLvZry5ioWc0yA53uPS3j4QyZIlbPsuXMrKqzuyN73sSBcPMWZBBv7
        dmhRf/Eh8oyMc/yi6dveyweiGklTwg6eDrMQ7qDQBJD/4GcixRf/1LinOl4XDdGQMXKd6R
        ZEAUsyILAPmchOOOwHetyrsCjqyJI0BjZyWUeVwiFAwShb8l5TjLTKcPAVIiMmSc2FwaeA
        0tBCKBWtq7zS0HXi8inr0d+Qd9S+cUuBA4/7tBErjRZQZ5HJS66YAw/bThRziw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695802315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F2YEJv2i0yEIX+nDdMm0jTyutLcuZK+A6tHuXZ9sFuo=;
        b=QH8ZmU0adiZ6oDaGu6UpL2zA6Pkeq6usTO7PZ40XXhxKviBttOIkZI2bMMhh6VYQ0c5eQd
        n2a1qG+Ghcay42AQ==
From:   "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/entry: Fix typos in comments
Cc:     "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230926061319.1929127-1-xin@zytor.com>
References: <20230926061319.1929127-1-xin@zytor.com>
MIME-Version: 1.0
Message-ID: <169580231502.27769.3298035050053680158.tip-bot2@tip-bot2>
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

Commit-ID:     1882366217757d3549e48a833bf9a5799b172251
Gitweb:        https://git.kernel.org/tip/1882366217757d3549e48a833bf9a5799b172251
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Mon, 25 Sep 2023 23:13:19 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Sep 2023 10:05:04 +02:00

x86/entry: Fix typos in comments

Fix 2 typos in the comments.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://lore.kernel.org/r/20230926061319.1929127-1-xin@zytor.com
---
 arch/x86/entry/entry_64.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index fb8dd56..b940e92 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1163,8 +1163,8 @@ SYM_CODE_START(asm_exc_nmi)
 	 * anyway.
 	 *
 	 * To handle this case we do the following:
-	 *  Check the a special location on the stack that contains
-	 *  a variable that is set when NMIs are executing.
+	 *  Check a special location on the stack that contains a
+	 *  variable that is set when NMIs are executing.
 	 *  The interrupted task's stack is also checked to see if it
 	 *  is an NMI stack.
 	 *  If the variable is not set and the stack is not the NMI
@@ -1294,8 +1294,8 @@ SYM_CODE_START(asm_exc_nmi)
 	 * end_repeat_nmi, then we are a nested NMI.  We must not
 	 * modify the "iret" frame because it's being written by
 	 * the outer NMI.  That's okay; the outer NMI handler is
-	 * about to about to call exc_nmi() anyway, so we can just
-	 * resume the outer NMI.
+	 * about to call exc_nmi() anyway, so we can just resume
+	 * the outer NMI.
 	 */
 
 	movq	$repeat_nmi, %rdx
