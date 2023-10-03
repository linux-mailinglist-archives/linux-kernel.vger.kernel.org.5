Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD307B6AD3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbjJCNpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjJCNpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:45:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D74EAB;
        Tue,  3 Oct 2023 06:45:29 -0700 (PDT)
Date:   Tue, 03 Oct 2023 13:45:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696340726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VZ16lJZp2GcZbyxe8LA5HOa8XPXLW36KpKHUXqtXlSY=;
        b=3yVNPx61a2Y9WVV2+CP+p1flXJHfsO1gwC9k4DX047l4KnCm8LC7Qqjv5risT9GXm4c/Dg
        H8KTU7Rm823/cDBL/0yVMUcSa2oMsLVcmStSyxAmMmWG4ngJ/UMtioNlsmYSM0v+yYx+Tf
        LlNL7SeV5xrUyb7O96/1Qfj0GQe9ivDCTHYuFmA3TJ9Nd1kYPz9w7llYin27hU08DoCejR
        J2oWbhfh4o9qZw2X0s5J8B1ISxcorVz+F/kCDxjdqFQewWVV9FJfEcj47lCMbD5OYI4Eyi
        tqecBpikgOkrDQc69Fj4/tc27vepUGVg3eBnfXiGph6jbPF2RZjMGaUsCNlQuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696340726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VZ16lJZp2GcZbyxe8LA5HOa8XPXLW36KpKHUXqtXlSY=;
        b=nERqZSbR+/ohXIlGKvhhN21wZOK5HUEwFI3M2l0993NLoxmPVlwhuA4sSnYEkwns2+5T+h
        kBzHBP8UHRj+x2Cg==
From:   "tip-bot2 for GUO Zihua" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/sev: Make boot_ghcb_page[] static
Cc:     GUO Zihua <guozihua@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <169634072599.3135.3729990591785308336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     bfb32e2008e278507bd93bff91662422d9cda9da
Gitweb:        https://git.kernel.org/tip/bfb32e2008e278507bd93bff91662422d9cda9da
Author:        GUO Zihua <guozihua@huawei.com>
AuthorDate:    Wed, 02 Aug 2023 10:14:36 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 15:31:27 +02:00

x86/sev: Make boot_ghcb_page[] static

boot_ghcb_page is not used by any other file, so make it static.

This also resolves sparse warning:

  arch/x86/boot/compressed/sev.c:28:13: warning: symbol 'boot_ghcb_page' was not declared. Should it be static?

Signed-off-by: GUO Zihua <guozihua@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/boot/compressed/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index dc8c876..ba4868f 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -25,7 +25,7 @@
 #include "error.h"
 #include "../msr.h"
 
-struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
+static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
 struct ghcb *boot_ghcb;
 
 /*
