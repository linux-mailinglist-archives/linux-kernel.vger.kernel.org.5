Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB57B7209
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbjJCTvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240878AbjJCTvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:51:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B459FA1;
        Tue,  3 Oct 2023 12:51:18 -0700 (PDT)
Date:   Tue, 03 Oct 2023 19:51:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696362676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZXCjKAMJ43Hx8H2yxrjCWOCM50v4ZybjcsaCrgUcl6s=;
        b=xBxOwRqvn1zqhred2g4OZxj0ojfsvth4zakJRZ1s75XvsfRfFPGevfvoYJEF+ZLlQ9lc3v
        s+Wfb0R/YULEtN+j8NUw/Le6sSfiX9JUwkG5R1yigpegm+7NsG/Pahn5pno3LCxJGE5nvK
        DoZzbieOTRz22KJa3dAIrvQmzEcPnWXJi5w7+oD75JSspIn34GSOhDzI9B15aM0TAqZ2i1
        0ROTJSbMB104VMFC5C1NeLqNcA9W06KMJuucI6tt7rLiwxjZLdqZ2JM3sV3kupX7rnQM4I
        RxwQu2fntJ6rjnpTX+JuaU6qAImfncSyzeOUytMFg71YSMsaNAuGzGl4MERugg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696362676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZXCjKAMJ43Hx8H2yxrjCWOCM50v4ZybjcsaCrgUcl6s=;
        b=7bp6B8eJIcCtkEtCX48v/oz87RB/Txi8KtRRp2e3IAzy7PybQRDWn9l3UjLIqS+meyha6P
        fsVxg6WnUXhhYICg==
From:   "tip-bot2 for Ruan Jinjie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Use 'the fallthrough' pseudo-keyword
Cc:     Ruan Jinjie <ruanjinjie@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <169636267584.3135.4440528386397949914.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     758a74306f1076b50cb9872af18cb900bafd9497
Gitweb:        https://git.kernel.org/tip/758a74306f1076b50cb9872af18cb900bafd9497
Author:        Ruan Jinjie <ruanjinjie@huawei.com>
AuthorDate:    Tue, 01 Aug 2023 11:52:30 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 21:37:35 +02:00

objtool: Use 'the fallthrough' pseudo-keyword

Replace the existing /* fallthrough */ comments with the
new 'fallthrough' pseudo-keyword macro:

  https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 tools/objtool/arch/x86/decode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index c0f25d0..e327cd8 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -291,7 +291,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		switch (modrm_reg & 7) {
 		case 5:
 			imm = -imm;
-			/* fallthrough */
+			fallthrough;
 		case 0:
 			/* add/sub imm, %rsp */
 			ADD_OP(op) {
@@ -375,7 +375,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			break;
 		}
 
-		/* fallthrough */
+		fallthrough;
 	case 0x88:
 		if (!rex_w)
 			break;
@@ -656,7 +656,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			break;
 		}
 
-		/* fallthrough */
+		fallthrough;
 
 	case 0xca: /* retf */
 	case 0xcb: /* retf */
