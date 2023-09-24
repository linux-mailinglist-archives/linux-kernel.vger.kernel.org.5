Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D4E7AC79C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 12:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjIXKkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 06:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjIXKkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 06:40:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C015100;
        Sun, 24 Sep 2023 03:40:16 -0700 (PDT)
Date:   Sun, 24 Sep 2023 10:40:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695552015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fT6iTXbOHGfCjfaGt+1WCThYSn0gcCFJToGGpaQ5K74=;
        b=G0LbBYFVICUFsrdU5v+tbadO9WEMUZVMcXarsZ2ud9VTSfBiHE8YDO4hoD3RSEXS2/+FAq
        vgAMNjfGbQGawNYSncCeM3QnS9oL4TKFbURG7cS3bKY1YW1gQNuPWn0gUofAIh3L4C6Yah
        iM3kjbeMvYrUHntsFFPNs8jvn9qiBh4cvG9xVC3+UGgHFaxYUWPjyXB63BM6t7UseFtHK8
        Du170ptkRYYDhXtstRxrAdY/NPgpIq67YuC7WoD4u7E2dWBHMxrlY9Qea8+bYD+juTfF3l
        vJ34+C7XOFKAV030KrayHK6Mbh04OjdtHL7Perp8aAmJMe118rYziagBUMBqEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695552015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fT6iTXbOHGfCjfaGt+1WCThYSn0gcCFJToGGpaQ5K74=;
        b=A3xfMTfxE+VcZK5OQ4LUUOA1JEKZ+kQDmj352wo0zdzH1RZxohl65Rc6xuMUbzITC+E4rh
        GaKcRXTyCHcY+pCg==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Annotate struct
 uv_rtc_timer_head with __counted_by
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230922175151.work.118-kees@kernel.org>
References: <20230922175151.work.118-kees@kernel.org>
MIME-Version: 1.0
Message-ID: <169555201447.27769.7624440543285631039.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     d9a01959d9c954c8fe1d132b52401b0e219e37f6
Gitweb:        https://git.kernel.org/tip/d9a01959d9c954c8fe1d132b52401b0e219e37f6
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 22 Sep 2023 10:51:51 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 24 Sep 2023 12:02:58 +02:00

x86/platform/uv: Annotate struct uv_rtc_timer_head with __counted_by

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

Found with Coccinelle:

  https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Add __counted_by for struct uv_rtc_timer_head.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/20230922175151.work.118-kees@kernel.org
---
 arch/x86/platform/uv/uv_time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index 54663f3..ff5afc8 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -53,7 +53,7 @@ struct uv_rtc_timer_head {
 	struct {
 		int	lcpu;		/* systemwide logical cpu number */
 		u64	expires;	/* next timer expiration for this cpu */
-	} cpu[];
+	} cpu[] __counted_by(ncpus);
 };
 
 /*
