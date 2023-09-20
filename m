Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D6C7A8286
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjITNAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbjITNAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:00:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CD0E0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:00:32 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695214831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FEN0BhuqjZqhEDf+FOtw52T7DMuMqlRIDkkJzR2wzcQ=;
        b=n5ASAvV/u55HBDf2oofn7SJSVt4NACRQ4ZGG9ObNqKhrQsvvso9Cta9Yb4/3EZ1GbWavz2
        6fHvXhuUC3B92VucaGvCWkF0UZit4KUiMArfhU3lrxr1PthD/eH6J5LGbaV+OtfKwe0yMn
        j6duGS5RxyCPh3GTQYZIW99eP9mKCzbFrbf0lHQW+dSv8SAP5UDd91xD2bvtagfV6XDyv2
        Fflx6DeTEinBlH6NqbBeqD3tTUtSAMhKaWJGOh/Jx1cQRcOyD4ix7SXnBWpAuMTxoNzJHZ
        n/Vzf04DMqw08kku/Q9v98CmL7SGwuwIBHA4br/s4K5n4izYxOvAvpnVdFT3Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695214831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FEN0BhuqjZqhEDf+FOtw52T7DMuMqlRIDkkJzR2wzcQ=;
        b=FLgH9lPFr2dsDOWsJLkE/eFh4FJGkZiwe2jzdi5JHFbTZoIOph0a9lef3GgOfDzSEeB9Je
        XERyljSm9dMsZeAg==
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] sched: Update reference to sched_debug.c
Date:   Wed, 20 Sep 2023 15:00:25 +0200
Message-Id: <20230920130025.412071-3-bigeasy@linutronix.de>
In-Reply-To: <20230920130025.412071-1-bigeasy@linutronix.de>
References: <20230920130025.412071-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit
   8a99b6833c884 ("sched: Move SCHED_DEBUG sysctl to debugfs")

The sched_debug interface moved from /proc to debugfs. The comment
mentions still the outdated proc interfaces.

Update the comment, point to the current location of the interface.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 132dfd1e6f475..5e34a8cb2c761 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -8,7 +8,7 @@
  */
=20
 /*
- * This allows printing both to /proc/sched_debug and
+ * This allows printing both to /sys/kernel/debug/sched/debug and
  * to the console
  */
 #define SEQ_printf(m, x...)			\
--=20
2.40.1

