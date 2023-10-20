Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A7D7D0A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376472AbjJTICQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376452AbjJTICG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:02:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64FDD55;
        Fri, 20 Oct 2023 01:02:03 -0700 (PDT)
Date:   Fri, 20 Oct 2023 08:02:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697788922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XBMo7rgZjOKemXx2HDqbfU2Qr3lejJI9GwbU6UPbrPA=;
        b=FQZpn6+N0Tl1OafU3xH3c8/1mfGoF/YvjvLQkmYsprLZW5yvWwTALuqUdwh9OirmzdTrY1
        Z9AOBeBUmrQUEgNcGfdFBVoGssit51EKZxsqa7yh2whihfz5hN4vbMReTOFCyWLdbKVxXD
        0ejuC+7daaRV6e8HgmxNx45LUY5dwpQt6bsZ4nkUb/TvPj0/pcBPEtXmcSLEtwQtNOgOl2
        oPlrTuK+0AZJVx3LRxMibx00TKYX9eeq3G+dCTBpRzlezE26ZD9x3KawShhoGdpO4OtKyp
        dPrP4L/bxBQKLL+ZQNFcxo0n1HEvGBcXhUXmQsqa2SGoJUq7VZsBzTrPLZqRhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697788922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XBMo7rgZjOKemXx2HDqbfU2Qr3lejJI9GwbU6UPbrPA=;
        b=wHvEWka/rOK8A4Soy/ut4gUysk8vYw5MQikk2606TgXuu6wmhL+SYC9nhHY1z6UI/FfpjK
        H0zX4qP7lVlJQeAw==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/nohz: Update comments about NEWILB_KICK
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231020014031.919742-2-joel@joelfernandes.org>
References: <20231020014031.919742-2-joel@joelfernandes.org>
MIME-Version: 1.0
Message-ID: <169778892143.3135.5766512330437156531.tip-bot2@tip-bot2>
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

Commit-ID:     fb064e5ae1657595c090ebbc5b15787a3ef603e9
Gitweb:        https://git.kernel.org/tip/fb064e5ae1657595c090ebbc5b15787a3ef603e9
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Fri, 20 Oct 2023 01:40:27 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 20 Oct 2023 09:56:21 +02:00

sched/nohz: Update comments about NEWILB_KICK

How ILB is triggered without IPIs is cryptic. Out of mercy for future
code readers, document it in code comments.

The comments are derived from a discussion with Vincent in a past
review.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231020014031.919742-2-joel@joelfernandes.org
---
 kernel/sched/fair.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9ae2208..8c486ff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12005,8 +12005,19 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 }
 
 /*
- * Check if we need to run the ILB for updating blocked load before entering
- * idle state.
+ * Check if we need to directly run the ILB for updating blocked load before
+ * entering idle state. Here we run ILB directly without issuing IPIs.
+ *
+ * Note that when this function is called, the tick may not yet be stopped on
+ * this CPU yet. nohz.idle_cpus_mask is updated only when tick is stopped and
+ * cleared on the next busy tick. In other words, nohz.idle_cpus_mask updates
+ * don't align with CPUs enter/exit idle to avoid bottlenecks due to high idle
+ * entry/exit rate (usec). So it is possible that _nohz_idle_balance() is
+ * called from this function on (this) CPU that's not yet in the mask. That's
+ * OK because the goal of nohz_run_idle_balance() is to run ILB only for
+ * updating the blocked load of already idle CPUs without waking up one of
+ * those idle CPUs and outside the preempt disable / irq off phase of the local
+ * cpu about to enter idle, because it can take a long time.
  */
 void nohz_run_idle_balance(int cpu)
 {
