Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861637C7F73
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjJMIGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjJMIGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:06:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB22BE;
        Fri, 13 Oct 2023 01:06:13 -0700 (PDT)
Date:   Fri, 13 Oct 2023 08:06:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697184372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WVkVHSk6yXaW8A0Pth63XEOGYs5GXYV28ITDfyv0A3g=;
        b=OUXwZCKhYsuX9XtN67aBn/0Kx+I9i9KNzbqMYkzXSZl2I+rqhObKlcRwVb/pbsQHyNc10s
        JMRmYIxczpcLJg2ndK6SPx1Eve24zFcIwId7mPwT226bXCvG51MGTvzzQX0PNJCQbQLCt5
        EUqUwlYLzHzAlNQhpHuqndPhzxyv710cwBbvy3LS2/VrpnjA5yC4cKjCGbP5Jm+hZQpW1R
        LMH37nT4vy2qeOjSVqF0rKFHNianOCB+gXXL+wEmYeL++rb52iR1fJi9qknyosMGr3mjmX
        M685h4pB0MXGsUBLtxMEJDzSQGXornoPzWx4N/zxqdIzOmFrULNkNT45AwFr0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697184372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WVkVHSk6yXaW8A0Pth63XEOGYs5GXYV28ITDfyv0A3g=;
        b=1nKYlqZyyP6uo/odnEaeRqQowOi3UqcEx51ocaQbMa0ABsqAp2dIDjiE85poUic3uY/itQ
        5bSjKW22MGkkfuCA==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make PELT acronym definition searchable
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231012125824.1260774-1-mathieu.desnoyers@efficios.com>
References: <20231012125824.1260774-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <169718437144.3135.18167310232938119222.tip-bot2@tip-bot2>
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

Commit-ID:     1b8a955dd338dfbf39831d4687c25263e885a9cb
Gitweb:        https://git.kernel.org/tip/1b8a955dd338dfbf39831d4687c25263e885a9cb
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Thu, 12 Oct 2023 08:58:24 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 13 Oct 2023 09:56:30 +02:00

sched: Make PELT acronym definition searchable

The PELT acronym definition can be found right at the top of
kernel/sched/pelt.c (of course), but it cannot be found through use of

grep -r PELT kernel/sched/

Add the acronym "(PELT)" after "Per Entity Load Tracking" at the top of
the source file.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20231012125824.1260774-1-mathieu.desnoyers@efficios.com
---
 kernel/sched/pelt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 0f31076..63b6cf8 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Per Entity Load Tracking
+ * Per Entity Load Tracking (PELT)
  *
  *  Copyright (C) 2007 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
  *
