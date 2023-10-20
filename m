Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955B97D0A47
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbjJTIJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbjJTIJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:09:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6864E8;
        Fri, 20 Oct 2023 01:09:55 -0700 (PDT)
Date:   Fri, 20 Oct 2023 08:09:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697789394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UPEvGpbNwJgVfjs/zEfGkPaGgx1rd7ziO+VrIH87IDY=;
        b=oWUf3lQVoJbGA1WBp8cr8HWmfKeMKWm2kKUhv91JXpTQ05iX3aNx3ZhYmh4k6H4ogkzAkF
        t82QCHqN3h0BIM5VnJY0dsp1tQWHccqyZKzpYjo0cQo1yrSE0paEq3Nf9iYV/CziCRuL4x
        v8i2EDTgJnYTfG4EfWUSxfCVihbr844kISyxZ3zXz19KMXzqIJ/wkJ0Xjzp8vZwDvvR5xG
        PgeXSms1NUKCU4xNc5v0BCdhklcu+UT3AKgwH5C5VaUOrzMs3L10Ir1Qv3iLa6h3Vc84HZ
        m+0nb3R/ewt24EY+Qwv1YZUpyri/K1lZiavtfnA04Sk0lC4hw2LfRAKzu4EdnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697789394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UPEvGpbNwJgVfjs/zEfGkPaGgx1rd7ziO+VrIH87IDY=;
        b=Yrcs53P8MiTymZPfPxptbZ80LQoEc17rbJrEIp2kY4yyI0+MfwJOGu6yptqL8KNsj1KxIr
        3PlItku92rOL1zDA==
From:   "tip-bot2 for Yiwei Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove unused 'curr' argument from
 pick_next_entity()
Cc:     Yiwei Lin <s921975628@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231020055617.42064-1-s921975628@gmail.com>
References: <20231020055617.42064-1-s921975628@gmail.com>
MIME-Version: 1.0
Message-ID: <169778939334.3135.9946072369314683656.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     950f26dc82bce4139f762e365843b0338ca6cbfe
Gitweb:        https://git.kernel.org/tip/950f26dc82bce4139f762e365843b0338ca6cbfe
Author:        Yiwei Lin <s921975628@gmail.com>
AuthorDate:    Fri, 20 Oct 2023 13:56:17 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 20 Oct 2023 10:00:55 +02:00

sched/fair: Remove unused 'curr' argument from pick_next_entity()

The 'curr' argument of pick_next_entity() has become unused after
the EEVDF changes.

[ mingo: Updated the changelog. ]

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231020055617.42064-1-s921975628@gmail.com
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 393d0dc..ebee058 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5256,7 +5256,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * 4) do not run the "skip" process, if something else is available
  */
 static struct sched_entity *
-pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
+pick_next_entity(struct cfs_rq *cfs_rq)
 {
 	/*
 	 * Enabling NEXT_BUDDY will affect latency but not fairness.
@@ -8160,7 +8160,7 @@ again:
 				goto again;
 		}
 
-		se = pick_next_entity(cfs_rq, curr);
+		se = pick_next_entity(cfs_rq);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
@@ -8223,7 +8223,7 @@ again:
 			}
 		}
 
-		se = pick_next_entity(cfs_rq, curr);
+		se = pick_next_entity(cfs_rq);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
@@ -8262,7 +8262,7 @@ simple:
 		put_prev_task(rq, prev);
 
 	do {
-		se = pick_next_entity(cfs_rq, NULL);
+		se = pick_next_entity(cfs_rq);
 		set_next_entity(cfs_rq, se);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
