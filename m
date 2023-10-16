Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798ED7CA776
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjJPMBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjJPMBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:01:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FA318D;
        Mon, 16 Oct 2023 04:54:54 -0700 (PDT)
Date:   Mon, 16 Oct 2023 11:54:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697457293;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E5AEwqyUaSQMprccmuBfMfzneA7Pcuh09art5K3UwP8=;
        b=2sWpf2ukZGRl516wJQKne6b8QUEcIHTly1YlLtqhrmGpp71DSQtW7ynUY5Jx+v9P7OtH9o
        +k/wZJB4fLYtMwSete9FlPEAfxVYvYXxSOE2krgVuZeLB6Lt0cU2MfoHqh8fb72Lf29pHc
        xcGjNkdwOfZ4inUqxjXIrZPQLoiY+Yh58ZEnG3PlBYZKiC1GjzpeHKxplJpQc4OUWi06gj
        RCtUGpTppycIm6FztTOjWO312O/e6rMxmq9d3kc8fOk4zFhK1yzV6RmbL7eUO2PR1qxMcE
        OGT6PWNZ3l9BoAoOIG904inKcwBFcpisVo3+h7ih+8zW8Tz+mPtHsCf6zkuvTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697457293;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E5AEwqyUaSQMprccmuBfMfzneA7Pcuh09art5K3UwP8=;
        b=Ih+QK2LXJdXmIfjsYySjHc/NU3QdTiresnrNdNvZEsqRJYbSQVvRq4VF10QNeTKNi2wTmG
        Na9HgORk7+oFlMAg==
From:   "tip-bot2 for Hou Wenlong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/head/64: Add missing __head annotation to
 startup_64_load_idt()
Cc:     Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cefcc5b5e18af880e415d884e072bf651c1fa7c34=2E16891?=
 =?utf-8?q?30310=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
References: =?utf-8?q?=3Cefcc5b5e18af880e415d884e072bf651c1fa7c34=2E168913?=
 =?utf-8?q?0310=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169745729291.3135.17224070349445193819.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     7f6874eddd81cb2ed784642a7a4321671e158ffe
Gitweb:        https://git.kernel.org/tip/7f6874eddd81cb2ed784642a7a4321671e158ffe
Author:        Hou Wenlong <houwenlong.hwl@antgroup.com>
AuthorDate:    Wed, 12 Jul 2023 11:30:06 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 16 Oct 2023 13:38:24 +02:00

x86/head/64: Add missing __head annotation to startup_64_load_idt()

This function is currently only used in the head code and is only called
from startup_64_setup_env(). Although it would be inlined by the
compiler, it would be better to mark it as __head too in case it doesn't.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/efcc5b5e18af880e415d884e072bf651c1fa7c34.1689130310.git.houwenlong.hwl@antgroup.com
---
 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index f41625d..f0efc22 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -588,7 +588,7 @@ static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
 }
 
 /* This runs while still in the direct mapping */
-static void startup_64_load_idt(unsigned long physbase)
+static void __head startup_64_load_idt(unsigned long physbase)
 {
 	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
 	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
