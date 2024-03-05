Return-Path: <linux-kernel+bounces-92915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58161872816
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63A91F29A48
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9F0128823;
	Tue,  5 Mar 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSIk3nNi"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2719E86655;
	Tue,  5 Mar 2024 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668647; cv=none; b=J4jIlBBYDX/x4tNKohw86JxuRZav1oX54pne2tzZ3arFsASC4qtonNjs/7O7atb2Im7aRkmZ+H+uJDs+46AxGKwyGgQBx7UJWhVdzjGr1TSvS/pJ0dZ0l2DopU/9zZRv5w/jQyIjFKknMQ9mYsTVrjV1xlIumjTVxWTWVipFg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668647; c=relaxed/simple;
	bh=Tf02hoQl16ulLbLmEP49bOnvkajXwB0fzsbf6thcjWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fFpBASoRiNRCs/2Mbd1p+wdtloecsZgxMIwFnhckwbKpCaItmgM5/Vze6Yho9ie02IClxXW3MwgVjeUM/4FI5DBM07XiqlduYyy9SGGz9UWpuclf7YooYVrq1fCeHIuyOS474pKJBcL2oPi7gC+KP+zmySgFnqhuewRtZmvpgI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSIk3nNi; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5132010e5d1so1505814e87.0;
        Tue, 05 Mar 2024 11:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709668644; x=1710273444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LCfjpVRTkpgu1lCafQfXhP+gwqT7P5cckdXLDuP6tQ=;
        b=LSIk3nNiiZbY0pM47hNQFwdQdMk3nhk62/AP3SGj4XabIU1hvO6BxC2Bm43p2YiQsl
         1iAXqg3DY3XfmcDSPpTcz8PBqvg1d55kzyfG0cCZajcN3IO23O/c5faIf5yLNlPAP11B
         9wiXvvHMnvGwuN+T1ekoSVuH4BHFeUwUAMLCMC7Cm/xShCjwvdhfoTVfo6MjBrxY6PZj
         VzptsHlCroNvP2nbw2Ndn1uXmXzzZL0gTbCayNvJI+N/5nHNM0o7oE6OPgQKh6Y19UBt
         xUbW7KgIyyohbUP7C8ZNAvHmcSIhquTEF88pSmz3+8CMYEP3Z6kQ6d1NpeSZFs3TUje8
         b/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709668644; x=1710273444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LCfjpVRTkpgu1lCafQfXhP+gwqT7P5cckdXLDuP6tQ=;
        b=PiV2FZPgaKCkvsba5wwEOnOGF1KCW1ei0gFGqP2jYOUjBDSk1jxv6nAso7kVIPb5a9
         x7Pyu2kk9QBM+dSIKc7iPcp5hvFL1dwPgHujJwqcc67nNJvI/U9HI/8j8vPu8LbIZ8p2
         UxFomAcselp3AZiwB11OD6ZBlF+hIHTFpb/e3Yw+2JQcWdrfKtjZZl/e/qy2sKUAhyNl
         xwHfFgvGadaz0bEJjogYlCqRix98qrHIYAWn2wm2L5XLeiZxAyZ53ol3xaZ6P7BwRrZq
         HyDulwRnXCkM4+cRRMWEglc2VOuntZJSPKX3ixC5wiwrhLWzi4ymkMz+6bvLxUuXGw8A
         uPsw==
X-Forwarded-Encrypted: i=1; AJvYcCWI7M8RpMjIivJSJ2EUananM5IbNd8lV6zLrMHtrcEJEjh/Ohp8oIKKUAm/y1NpIwC9SXp6yeZ+76ywoOSxE02k6W0X9jf9pBpGqVJ5
X-Gm-Message-State: AOJu0YwEIvzQXs1VatJjMHPwTfeEPQxMUXlUYI2t+J3ihv22kQukJOuU
	+AUEC8E3jTob9WJb3ABiFyoXme5MukuzmLol4NbB7nKJNiGFC51k
X-Google-Smtp-Source: AGHT+IHigmJfE4bms7fFQLqB00ZMh8tMjho2to1zq5vHuyOr7UbnT9ROnyp1AmJDdTM8RHVpzf4q6w==
X-Received: by 2002:a05:6512:220f:b0:513:549a:1a67 with SMTP id h15-20020a056512220f00b00513549a1a67mr1995802lfu.4.1709668642729;
        Tue, 05 Mar 2024 11:57:22 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id cf10-20020a056512280a00b005133fa4bc1asm1394437lfb.211.2024.03.05.11.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 11:57:22 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/2] rcu: Do not release a wait-head from a GP kthread
Date: Tue,  5 Mar 2024 20:57:19 +0100
Message-Id: <20240305195720.42687-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a below race by not releasing a wait-head from the
GP-kthread as it can lead for reusing it whereas a worker
can still access it thus execute newly added callbacks too
early.

CPU 0                              CPU 1
-----                              -----

// wait_tail == HEAD1
rcu_sr_normal_gp_cleanup() {
    // has passed SR_MAX_USERS_WAKE_FROM_GP
    wait_tail->next = next;
    // done_tail = HEAD1
    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
    queue_work() {
        test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
        __queue_work()
    }
}

                               set_work_pool_and_clear_pending()
                               rcu_sr_normal_gp_cleanup_work() {
// new GP, wait_tail == HEAD2
rcu_sr_normal_gp_cleanup() {
    // executes all completion, but stop at HEAD1
    wait_tail->next = HEAD1;
    // done_tail = HEAD2
    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
    queue_work() {
        test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
        __queue_work()
    }
}
                                 // done = HEAD2
                                 done = smp_load_acquire(&rcu_state.srs_done_tail);
                                 // head = HEAD1
                                 head = done->next;
                                 done->next = NULL;
                                 llist_for_each_safe() {
                                 // completes all callbacks, release HEAD1
                                 }
                               }
                               // Process second queue
                               set_work_pool_and_clear_pending()
                               rcu_sr_normal_gp_cleanup_work() {
                               // done = HEAD2
                               done = smp_load_acquire(&rcu_state.srs_done_tail);

// new GP, wait_tail == HEAD3
rcu_sr_normal_gp_cleanup() {
    // Finds HEAD2 with ->next == NULL at the end
    rcu_sr_put_wait_head(HEAD2)
    ...

// A few more GPs later
rcu_sr_normal_gp_init() {
     HEAD2 = rcu_sr_get_wait_head();
     llist_add(HEAD2, &rcu_state.srs_next);
                               // head == rcu_state.srs_next
                               head = done->next;
                               done->next = NULL;
                               llist_for_each_safe() {
                                // EXECUTE CALLBACKS TOO EARLY!!!
                                }
                               }

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() users")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 31f3a61f9c38..475647620b12 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1656,21 +1656,11 @@ static void rcu_sr_normal_gp_cleanup(void)
 	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
 
 	/*
-	 * Process (a) and (d) cases. See an illustration. Apart of
-	 * that it handles the scenario when all clients are done,
-	 * wait-head is released if last. The worker is not kicked.
+	 * Process (a) and (d) cases. See an illustration.
 	 */
 	llist_for_each_safe(rcu, next, wait_tail->next) {
-		if (rcu_sr_is_wait_head(rcu)) {
-			if (!rcu->next) {
-				rcu_sr_put_wait_head(rcu);
-				wait_tail->next = NULL;
-			} else {
-				wait_tail->next = rcu;
-			}
-
+		if (rcu_sr_is_wait_head(rcu))
 			break;
-		}
 
 		rcu_sr_normal_complete(rcu);
 		// It can be last, update a next on this step.
@@ -1684,8 +1674,12 @@ static void rcu_sr_normal_gp_cleanup(void)
 	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
 
-	if (wait_tail->next)
-		queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
+	/*
+	 * We schedule a work in order to perform a final processing
+	 * of outstanding users(if still left) and releasing wait-heads
+	 * added by rcu_sr_normal_gp_init() call.
+	 */
+	queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
 }
 
 /*
-- 
2.39.2


