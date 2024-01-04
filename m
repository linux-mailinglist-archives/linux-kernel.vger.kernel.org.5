Return-Path: <linux-kernel+bounces-16920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C6F82461C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C65B234E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA6325579;
	Thu,  4 Jan 2024 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLgQR20n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F418250F2;
	Thu,  4 Jan 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso747006e87.1;
        Thu, 04 Jan 2024 08:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704385517; x=1704990317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptdvZP3gB3Tmhzg2S9uP54DorDCDKViWWNLgg+oxUJQ=;
        b=BLgQR20nGKaLqBvls9aiIl50RDRq+NwTlGEwI8O2O6vpRWb/xjlHaF8y41Hz/H4h1c
         G8HuxtimpIvJTD8Q1IgGr2yamF1T6L+TKmbgf9Y+hKBytbX56i7gkWLzt2ikZLs5EJZQ
         5gXdb4ckoCfSweaNcXmu+iTorj5gxyi5ivlzurerjF5VesGsrcWWYuaTLUa5bRgNWbZa
         s1FBF5Z4juEEoGIhO+gd8VFj3lAeihBkn9QXRFfKyLP2NXb8utJJTnrnj3rr+EVeXdJh
         7fTN0SZnTo9yYSPsfu+hKMfbaZl0fmXL8KwSLtUY0qRvj8i+ufhEzWshFuVd0t9WoHMu
         xnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704385517; x=1704990317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptdvZP3gB3Tmhzg2S9uP54DorDCDKViWWNLgg+oxUJQ=;
        b=cFXL/9aUTBeAEXdvb5Tb2i6Ick5uFwNMmYq1fRjEGATWg2LKhn7ZL/ZKQeVoxS6KTt
         NcD6lv+I8nu63a4VzHAXyGtoo03QBi1TXzNA7IbaxDfj+PCMqApPbbVrtQJPbkNEVVQL
         YG+/LFuCJAYvwIeAHO1y7a/BaOqSJDngib1lVYrGypPtZZ00FjVIM+bX6B4DOG7zXZ2k
         U2s6Y3Aswb2OSG/fPn1swd+zvkqYBAyvja3f2JfoQNfGk1/rwexDDy5SG+VJEYBHAZUF
         yOfTMtLjp93FvHnNHmj8GDn6z0t5KTlHL9mKakAQ30+aafsmCjHOND6vdgDKH8Fp3ncS
         l0fg==
X-Gm-Message-State: AOJu0YztXmRpiDAIE+UYpAUkwBcPXHxkS1EwUU9Dpmw+/4m/BFFdfuZM
	p8o+FMyIUXxX3h1AbmgbRrY=
X-Google-Smtp-Source: AGHT+IH+R0vl+buUggFu0KrhIdvG9a+mwNGRgA4CDvApDdz/47X5XUUoQxGpG2OVPBU0HYezQ1+GXA==
X-Received: by 2002:ac2:5fad:0:b0:50e:6b54:6a61 with SMTP id s13-20020ac25fad000000b0050e6b546a61mr222086lfe.118.1704385516810;
        Thu, 04 Jan 2024 08:25:16 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id i5-20020a0565123e0500b0050e80d1e142sm2789252lfv.170.2024.01.04.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 08:25:16 -0800 (PST)
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
Subject: [PATCH v4 4/4] rcu: Support direct wake-up of synchronize_rcu() users
Date: Thu,  4 Jan 2024 17:25:10 +0100
Message-Id: <20240104162510.72773-5-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104162510.72773-1-urezki@gmail.com>
References: <20240104162510.72773-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a small enhancement which allows to do a
direct wake-up of synchronize_rcu() callers. It occurs after a
completion of grace period, thus by the gp-kthread.

Number of clients is limited by the hard-coded maximum allowed
threshold. The remaining part, if still exists is deferred to
a main worker.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 31 +++++++++++++++++++++++++++++--
 kernel/rcu/tree.h |  6 ++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 88a47a6a658e..96fe9cc122ca 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1642,7 +1642,8 @@ static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
  */
 static void rcu_sr_normal_gp_cleanup(void)
 {
-	struct llist_node *wait_tail;
+	struct llist_node *wait_tail, *next, *rcu;
+	int done = 0;
 
 	wait_tail = rcu_state.srs_wait_tail;
 	if (wait_tail == NULL)
@@ -1650,12 +1651,38 @@ static void rcu_sr_normal_gp_cleanup(void)
 
 	rcu_state.srs_wait_tail = NULL;
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_wait_tail);
+	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
+
+	/*
+	 * Process (a) and (d) cases. See an illustration. Apart of
+	 * that it handles the scenario when all clients are done,
+	 * wait-head is released if last. The worker is not kicked.
+	 */
+	llist_for_each_safe(rcu, next, wait_tail->next) {
+		if (rcu_sr_is_wait_head(rcu)) {
+			if (!rcu->next) {
+				rcu_sr_put_wait_head(rcu);
+				wait_tail->next = NULL;
+			} else {
+				wait_tail->next = rcu;
+			}
+
+			break;
+		}
+
+		rcu_sr_normal_complete(rcu);
+		// It can be last, update a next on this step.
+		wait_tail->next = next;
+
+		if (++done == SR_MAX_USERS_WAKE_FROM_GP)
+			break;
+	}
 
 	// concurrent sr_normal_gp_cleanup work might observe this update.
 	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
 
-	if (wait_tail)
+	if (wait_tail->next)
 		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4c35d7d37647..5d8b71a1caec 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -316,6 +316,12 @@ do {									\
 	__set_current_state(TASK_RUNNING);				\
 } while (0)
 
+/*
+ * A max threshold for synchronize_rcu() users which are
+ * awaken directly by the rcu_gp_kthread(). Left part is
+ * deferred to the main worker.
+ */
+#define SR_MAX_USERS_WAKE_FROM_GP 5
 #define SR_NORMAL_GP_WAIT_HEAD_MAX 5
 
 struct sr_wait_node {
-- 
2.39.2


