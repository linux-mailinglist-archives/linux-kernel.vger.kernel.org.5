Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9D17CC1CA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjJQLbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjJQLbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:31:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5820EA;
        Tue, 17 Oct 2023 04:31:01 -0700 (PDT)
Date:   Tue, 17 Oct 2023 11:30:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697542258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8VsSLdFpc/PxeSRQjP+bqFWYb+ZOMba2A5yv3BN4Ntc=;
        b=dN9Hs9gc5eTj1DpWxdv/ygfF9Ca1bGFGDqbInmo9W7mCZcHMlwemY+q/F03T2K1KboC/P7
        pYHbi7YqyGjrqhTMEoequqLS22c0DWvZyKN/np8BVP2wcRrHG6eD/V8Uz0WPSipm5J1N2d
        6NLt69DyhOGDY7J8f+JruHEyvZeWs+ZrIQ6Q9RWzjDsLh73YHFnUC9KywwCgHUgxozwUPJ
        lSgdhijegRgZ2grmw75r9eWAW0MNXhtBOeEBZag8ab3MyDIwt4tErto6XriHd6EHs+3UVF
        3cEQn5oniYw/Ks6KcSyn2J+B/bQ6gUKwEzm+5fQk/D+dh/adybXh9NNQycFE/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697542258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8VsSLdFpc/PxeSRQjP+bqFWYb+ZOMba2A5yv3BN4Ntc=;
        b=Qw5Y5LAWf5581R0D5BpClUx2nMfCxL+W4QQ4hXAOQBdZ2gYvfYAzkKA1w5dgFOt7l+Pe+w
        ckVtLBK5f0dnwqAQ==
From:   "tip-bot2 for Cuda-Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/seqlock: Fix grammar in comment
Cc:     "Cuda-Chen" <clh960524@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231017053703.11312-1-clh960524@gmail.com>
References: <20231017053703.11312-1-clh960524@gmail.com>
MIME-Version: 1.0
Message-ID: <169754225791.3135.5867616537224142334.tip-bot2@tip-bot2>
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

Commit-ID:     184fdf9fc7ae6ae7155768faa48fc609d1a24b7e
Gitweb:        https://git.kernel.org/tip/184fdf9fc7ae6ae7155768faa48fc609d1a24b7e
Author:        Cuda-Chen <clh960524@gmail.com>
AuthorDate:    Tue, 17 Oct 2023 13:37:03 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Oct 2023 13:28:12 +02:00

locking/seqlock: Fix grammar in comment

The "neither writes before and after ..." for the description
of do_write_seqcount_end() should be "neither writes before nor after".

Signed-off-by: Cuda-Chen <clh960524@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231017053703.11312-1-clh960524@gmail.com
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 80f21d2..e92f9d5 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -584,7 +584,7 @@ static inline void do_write_seqcount_end(seqcount_t *s)
  * via WRITE_ONCE): a) to ensure the writes become visible to other threads
  * atomically, avoiding compiler optimizations; b) to document which writes are
  * meant to propagate to the reader critical section. This is necessary because
- * neither writes before and after the barrier are enclosed in a seq-writer
+ * neither writes before nor after the barrier are enclosed in a seq-writer
  * critical section that would ensure readers are aware of ongoing writes::
  *
  *	seqcount_t seq;
