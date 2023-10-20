Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBCA7D0EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377213AbjJTLhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376988AbjJTLhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:37:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB1CD55;
        Fri, 20 Oct 2023 04:37:19 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801838;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2zLq86KiWPHZVtABoukh9mWUINF3BOdIexfBg+if48=;
        b=wdV5rTfcHJRKNV7y6Q7PlOX8zU0lfDAnmhqLP5g2jK2WaDzIbQYaEqAE0tpT4edmeqAlNu
        EJivVxBeuP0RDr4qr9/R6qxsWguyVrv6GESpcfX2vCWQc6a3tdntNADFijmq6mesAUXmL8
        JOqk2bES20oUWirJxmDb+OTaB8kmH+p4eAusAsmWN1ZCtyvbRF8hc/kJhJNc3k8Px4Tq7H
        8Wwl0Z38HjIc+BkIED9eVSr6DuV46EOL9EodFrHwzLPGn/YOKznK5i2vN+z98uJPxmi+Xi
        A0sCwTXDDbx7HUcklrkpNU83opXabnCtyw99pxMSAj2QZT8MZUW7WSgA/IXwjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801838;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2zLq86KiWPHZVtABoukh9mWUINF3BOdIexfBg+if48=;
        b=x3bihltNjOqw5ObeQi4pNOHojDTCID1EcqYukFxHCgxF2bgHw5az5xIwTJnqWwwDmMesM6
        2TgUgEpHhGBmfMDg==
From:   "tip-bot2 for Alexey Dobriyan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/callthunks: Delete unused "struct thunk_desc"
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
In-Reply-To: <843bf596-db67-4b33-a865-2bae4a4418e5@p183>
References: <843bf596-db67-4b33-a865-2bae4a4418e5@p183>
MIME-Version: 1.0
Message-ID: <169780183378.3135.13180464061966074283.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     321a145137653188b8bf9a6b6fc60e8ccb184392
Gitweb:        https://git.kernel.org/tip/321a145137653188b8bf9a6b6fc60e8ccb184392
Author:        Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate:    Sat, 14 Oct 2023 19:05:28 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 20 Oct 2023 12:58:48 +02:00

x86/callthunks: Delete unused "struct thunk_desc"

It looks like it was never used.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/843bf596-db67-4b33-a865-2bae4a4418e5@p183
---
 arch/x86/kernel/callthunks.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index faa9f22..e9ad518 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -48,11 +48,6 @@ EXPORT_SYMBOL_GPL(__x86_call_count);
 
 extern s32 __call_sites[], __call_sites_end[];
 
-struct thunk_desc {
-	void		*template;
-	unsigned int	template_size;
-};
-
 struct core_text {
 	unsigned long	base;
 	unsigned long	end;
