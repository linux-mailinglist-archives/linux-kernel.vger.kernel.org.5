Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4999D78E466
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345588AbjHaBbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbjHaBbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:31:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E8FCDA;
        Wed, 30 Aug 2023 18:31:32 -0700 (PDT)
Date:   Thu, 31 Aug 2023 01:31:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693445491;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z94ew/J80P9ncHGiVb0f28QqYos7fzdI+/LwyaUgeOU=;
        b=vWC6Ql1v5Rz5PvWp1sOA9yAMhtRmGG7EhMjO59eEJjDAz/g2uoDWvHqYFbc+O6BFcHdES0
        CHgh29HAgdcw80ylZ9cBFhMFPRMUzGJS1RC3r5qdfH9T7/DFvuNh2g4YheJzKHmjHXwV37
        xgZ4YrIb0z2Xd3EhNwsdhvLIdx+Hi1I29MYyi/5Tqu6QMVSs1eUhfiI4mFFAbD3T1VlKGs
        8oUBgownKolWAyhqFt0QdcFtc8NWHMAqhHL2DN3z65se61OOCDNby78AmD+8QxZKQjwXko
        AyojV1LMGAhK8b8M5d1kNRHbgmaipAQLMn2ND1OtAUcSBPlnw9HElc8pHRCziw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693445491;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z94ew/J80P9ncHGiVb0f28QqYos7fzdI+/LwyaUgeOU=;
        b=GWM0oZ17MboIrYSrlQyvNo1CEA3A60hanF9WsZTrq2JOIHYlahDQYs2KKa5onTSWZhU1zy
        nd0Ba25zqYdziDAw==
From:   "tip-bot2 for Tom Rix" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/loongson1: Set variable
 ls1x_timer_lock storage-class-specifier to static
Cc:     Tom Rix <trix@redhat.com>, Keguang Zhang <keguang.zhang@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230702133113.3438049-1-trix@redhat.com>
References: <20230702133113.3438049-1-trix@redhat.com>
MIME-Version: 1.0
Message-ID: <169344549074.27769.13641802860646483687.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bd0f3aac47e8f618ceae0120d7b989378a7c45f0
Gitweb:        https://git.kernel.org/tip/bd0f3aac47e8f618ceae0120d7b989378a7c45f0
Author:        Tom Rix <trix@redhat.com>
AuthorDate:    Sun, 02 Jul 2023 09:31:13 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 18 Aug 2023 12:13:03 +02:00

clocksource/drivers/loongson1: Set variable ls1x_timer_lock storage-class-specifier to static

smatch reports
drivers/clocksource/timer-loongson1-pwm.c:31:1: warning: symbol
  'ls1x_timer_lock' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
Acked-by: Keguang Zhang <keguang.zhang@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230702133113.3438049-1-trix@redhat.com
---
 drivers/clocksource/timer-loongson1-pwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-loongson1-pwm.c b/drivers/clocksource/timer-loongson1-pwm.c
index 6335fee..244d668 100644
--- a/drivers/clocksource/timer-loongson1-pwm.c
+++ b/drivers/clocksource/timer-loongson1-pwm.c
@@ -28,7 +28,7 @@
 
 #define CNTR_WIDTH		24
 
-DEFINE_RAW_SPINLOCK(ls1x_timer_lock);
+static DEFINE_RAW_SPINLOCK(ls1x_timer_lock);
 
 struct ls1x_clocksource {
 	void __iomem *reg_base;
