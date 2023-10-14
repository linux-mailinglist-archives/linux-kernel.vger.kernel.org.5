Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EED67C9717
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 00:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjJNWkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 18:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjJNWkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 18:40:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55400D6;
        Sat, 14 Oct 2023 15:40:37 -0700 (PDT)
Date:   Sat, 14 Oct 2023 22:40:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697323235;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=a+HMQisxfJN8kCZQ+kN/QA80dgdEzqffBqO13ivJvd8=;
        b=w+kGdM4QeePPkk5R2VXF/QNunRiRFDyZsFNqvbLdY4IUPj7lxNxKBuXGEv0oV3dzVzCvJH
        i1mt8uy93DSqFqLkPimq1uHx9CKBUii/Q9sD98a6kL6EJWgEFxKxtNM8UWZ2sA8WWJa1TX
        EKbYL4LipQHjWfT53UfSbFmnkw+xCAa45gGSs0dKOPtMeFrqqc95f9Pq9lszvtN6RtfF6F
        GhAsNiLkCv/LUCnRppSxBuaRZ+xsKPLVINf2ZlLXO2ObRCcE0usjgRXe0JbDAgRNfZH4VE
        eAbbqhnudZwvW9eGUBBr36hdLae+5ab5pjrjjw2A5/hM4CLhHjkVzdmiZpSBAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697323235;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=a+HMQisxfJN8kCZQ+kN/QA80dgdEzqffBqO13ivJvd8=;
        b=VLZ/diafTO0wa53DZwCdgg0f7neT2v85I7EtcUMjNih1hyWzOYoJWiJTdS49AK9hVSmk0A
        5L8GCqmNnUcEJBBw==
From:   "tip-bot2 for Alexey Dobriyan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/callthunks: Delete unused "struct thunk_desc"
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <169732323407.3135.7538979097197206726.tip-bot2@tip-bot2>
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

Commit-ID:     5f51ef7fe994a91dcae36119a83961f6b143371d
Gitweb:        https://git.kernel.org/tip/5f51ef7fe994a91dcae36119a83961f6b143371d
Author:        Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate:    Sat, 14 Oct 2023 19:05:28 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 15 Oct 2023 00:30:30 +02:00

x86/callthunks: Delete unused "struct thunk_desc"

It looks like it was never used.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
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
