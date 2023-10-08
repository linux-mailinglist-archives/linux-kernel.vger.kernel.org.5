Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D267BCDC3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344611AbjJHKWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjJHKWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:22:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DDB9D;
        Sun,  8 Oct 2023 03:22:41 -0700 (PDT)
Date:   Sun, 08 Oct 2023 10:22:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696760559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RQ8CXIzdONq2HHeXMTEKjhbOGr0Vv4BDo04JkSJZsG4=;
        b=tQjWHfod7Qu9DywJJBOUFbAYDiDqfPPoXVLhpDHFf9vYWF6RMeqIWEYAz4iHC4G+0UDX93
        EBUssKAXWddXMS3M+MjVGYWdOXrCNrTRyll419Kdg6ecPCktgREdwR7eshUQdQc3+cTnRz
        b9k1mfqkX1GZlct5MwRys13KntzJ03CGLxe2NmqnOCBzTH9D/updqFIQ1hRJsMRMK6CN9H
        ZlQwk25vpMcz1vPwCx3isju8p1TVbnCnlRUiSD4Wpf02F4V8tHQvNdKZNMIztjEinTVzse
        hDjHAoQ1E1BJP3r0K01BWsxU7tvrGQN04NnG3sLTxu/ZFfks/xLwVfi2XQ8IKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696760559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RQ8CXIzdONq2HHeXMTEKjhbOGr0Vv4BDo04JkSJZsG4=;
        b=0EDofpKHNcpcZS8Z1ZrTdv7b0fBKN4u21QIEegof7nuBGikSsF2uHFy+GX04luxSEbyPhZ
        ZkjwFTXON4uprqDw==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Annotate 'struct rapl_pmus' with __counted_by
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231006201754.work.473-kees@kernel.org>
References: <20231006201754.work.473-kees@kernel.org>
MIME-Version: 1.0
Message-ID: <169676055888.3135.18089597086363215333.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a56d5551e1993ca84dd0c69df5a3d8223d13fb5f
Gitweb:        https://git.kernel.org/tip/a56d5551e1993ca84dd0c69df5a3d8223d13fb5f
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 06 Oct 2023 13:17:54 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Oct 2023 12:18:17 +02:00

perf/x86/rapl: Annotate 'struct rapl_pmus' with __counted_by

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS=y (for
array indexing) and CONFIG_FORTIFY_SOURCE=y (for strcpy/memcpy-family
functions).

Found with Coccinelle:

  https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]

Add __counted_by for 'struct rapl_pmus'.

No change in functionality intended.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/20231006201754.work.473-kees@kernel.org
---
 arch/x86/events/rapl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index c2c37fb..8d98d46 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -115,7 +115,7 @@ struct rapl_pmu {
 struct rapl_pmus {
 	struct pmu		pmu;
 	unsigned int		maxdie;
-	struct rapl_pmu		*pmus[];
+	struct rapl_pmu		*pmus[] __counted_by(maxdie);
 };
 
 enum rapl_unit_quirk {
