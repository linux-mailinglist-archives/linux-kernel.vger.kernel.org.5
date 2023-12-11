Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3ED80BEEF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjLKB4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 20:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKB4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 20:56:09 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB83E5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:56:15 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-35d396ae91fso17595305ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702259774; x=1702864574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0kLLsvsTVKPGR1aUZ5CxdQS0YxKVY+vVHvFwMxx0irc=;
        b=g4Oa9O5Hln/Gju5Cu4vz7WCEQ1kxg3vGsy9IWQQSeTqi9Xnu0dwpiB2nTmoTh9mehJ
         XSh6tnHHj3i1CibKkuOcOG2QKJy0WZkGcN/avk7RYBn8UC9oBbZHVN+1i+UqzyoI66a6
         sk8unpcGTfIkOfKNQFbsgjkanf5tY6d8qfSfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702259774; x=1702864574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kLLsvsTVKPGR1aUZ5CxdQS0YxKVY+vVHvFwMxx0irc=;
        b=DCSbu+lof0Eh48yKNzIhWWYF0OxDZNR1SPbZ7QbOyAqlNcW7whiT1JvRigeIjHw5i1
         fa2qa33XzS7a4Um4JtvmlCDX4GETxxv4fbajhcYiv86C2Y788Mbsj7CYH8PZ8ox/R1Nm
         S5t6850ox0bbBGrwS4yuLZDkGxbiSnbS3qmX1VHwioz6x3NNMM5eZExrRyv4AFBwNbpx
         Hp6rG0nAi5U+HkMsiTIoZlV9qjtgwiBK/pGstAW0gGhOIu7HdIL/D4lw3WQ8aUw6NRMo
         pPZO8zfN4qPG13CAq9NpuWMMC185oA5y1lMfeYll6tA5/6GmWW6PGQ4Uw0aj6VfGh4Hj
         Tk5Q==
X-Gm-Message-State: AOJu0YzB4rR7XqtGYZOHGF9si+WhW7QeZunnH+Dx6bTTLouvG6/7yksC
        w15ge8gUCYiPkU+t3G8HvYMLmlXmMiBsd+u7/4Y=
X-Google-Smtp-Source: AGHT+IGEpi2Ao8lqbCSALU9/7Mujq6xkLaKre4TBcEq1OUySc3xDXHgUE65n/8qQgl1T2EeISorClA==
X-Received: by 2002:a05:6e02:1689:b0:35d:59a2:331d with SMTP id f9-20020a056e02168900b0035d59a2331dmr6953090ila.33.1702259773949;
        Sun, 10 Dec 2023 17:56:13 -0800 (PST)
Received: from joelboxx5.c.googlers.com.com (74.120.171.34.bc.googleusercontent.com. [34.171.120.74])
        by smtp.gmail.com with ESMTPSA id t22-20020a02ab96000000b0046856360a07sm1669337jan.13.2023.12.10.17.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 17:56:13 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>, rcu@vger.kernel.org
Subject: [PATCH] srcu: Improvement comments about acceleration leak
Date:   Mon, 11 Dec 2023 01:56:05 +0000
Message-ID: <20231211015606.1067121-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comments added in commit 1ef990c4b36b ("srcu: No need to
advance/accelerate if no callback enqueued") are a bit confusing to me.
The comments are describing a scenario for code that was moved and is
no longer the way it was (snapshot after advancing). Improve the code
comments to reflect this and also document by acceleration can never
fail.

Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/srcutree.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0351a4e83529..051e149490d1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1234,11 +1234,20 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	if (rhp)
 		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
 	/*
-	 * The snapshot for acceleration must be taken _before_ the read of the
-	 * current gp sequence used for advancing, otherwise advancing may fail
-	 * and acceleration may then fail too.
+	 * It's crucial to capture the snapshot 's' for acceleration before
+	 * reading the current gp_seq that is used for advancing. This is
+	 * essential because if the acceleration snapshot is taken after a
+	 * failed advancement attempt, there's a risk that a grace period may
+	 * conclude and a new one may start in the interim. If the snapshot is
+	 * captured after this sequence of events, the acceleration snapshot 's'
+	 * could be excessively advanced, leading to acceleration failure.
+	 * In such a scenario, an 'acceleration leak' can occur, where new
+	 * callbacks become indefinitely stuck in the RCU_NEXT_TAIL segment.
+	 * Also note that encountering advancing failures is a normal
+	 * occurrence when the grace period for RCU_WAIT_TAIL is in progress.
 	 *
-	 * This could happen if:
+	 * To see this, consider the following events which occur if
+	 * rcu_seq_snap() were to be called after advance:
 	 *
 	 *  1) The RCU_WAIT_TAIL segment has callbacks (gp_num = X + 4) and the
 	 *     RCU_NEXT_READY_TAIL also has callbacks (gp_num = X + 8).
@@ -1264,6 +1273,13 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	if (rhp) {
 		rcu_segcblist_advance(&sdp->srcu_cblist,
 				      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
+		/*
+		 * Acceleration can never fail because the state of gp_seq used
+		 * for advancing is <= the state of gp_seq used for
+		 * acceleration. This means that RCU_NEXT_TAIL segment will
+		 * always be able to be emptied by the acceleration into the
+		 * RCU_NEXT_READY_TAIL or RCU_WAIT_TAIL segments.
+		 */
 		WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s));
 	}
 	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
-- 
2.43.0.472.g3155946c3a-goog

