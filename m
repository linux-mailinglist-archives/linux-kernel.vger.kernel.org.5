Return-Path: <linux-kernel+bounces-97397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1882E8769FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 833CFB214AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725D357884;
	Fri,  8 Mar 2024 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izCSQZNy"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8624495CC;
	Fri,  8 Mar 2024 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919259; cv=none; b=rKgWZAI2dK1i4T/2gvXuIvkD6FAfA8tskQ5MAEf424oqMlz7b3BTkUNw86Ig38c7jlD3DTDfb3UDsvcSB8s2H0WupqA3YPAJVfarOh4WzJkN5sGjDzy5MHcpeOuijhN58GUvxAr/yxWs6Hh9+NXe2yux+H4SPjyBO0vydPsjWmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919259; c=relaxed/simple;
	bh=pUOWqKH8F0AZqFoW5l76mY0as9X0NZxjquxwH8plNXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IczVtfMs4eLOzQ4osQUncfq4OhXDoI6uCJbyM3Bi9qu/LEu0NzDBFJ1zTfea3pXwbn+5DRZRCivkgl3ScH0WoP3eqILZeZsWYllOmzb33w/gPVnJ2PhajIeN7sgyc3G9qAx6ZC0oz1ynmRlG8nDxcCV5pfhn6kpIRhvxJAs9v2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izCSQZNy; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51331634948so3198585e87.0;
        Fri, 08 Mar 2024 09:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709919256; x=1710524056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJXBLMujukXP0aFm/GcWV39azCd58NyPFINXJlQ3LLY=;
        b=izCSQZNya9ere1OjKW/lmF537VUYhHimpqfXsF0HHZv+oYu2FdiE/V6jtJIfwj6L4g
         Lax3FHt9gKDVERiU7za0z2/whO+VV8KMOoOrfDzkztgj6YpAI3SI6msADsjFPO/K9P85
         vtrGNWd25aTnSSYySKwmIpbFLMb6nk/Q5tIiDo8r9oZt51YczpFtp4qyuLzvhqvW3L42
         3QfLCvHTpGgA2HzymPClOL+tae5c3B9krG6IhNwKJ5Lf3mXr+NFtujIGvEXFRYT4+Wvr
         ezNmm5ke277EIn1LgWP2IlBwSac/cKSxupBIH3XCETv7WAsCHvXkhLasI+FfCtjTudgH
         adrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709919256; x=1710524056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJXBLMujukXP0aFm/GcWV39azCd58NyPFINXJlQ3LLY=;
        b=ebvycSz3b6sjOVieP6JK7aibjQ6uwv001h7Eskea/o/3h/r3D4UfNvDq2zOkvnMCY1
         7EYhSurRAcfwlQdMe1NDDstfcVwOscbC1OJ2g5JdA9Icr9D7zahhLVV4Z+WM73a6EILw
         tJU9shUD0egaBU+E9/pm3S+7t3iTlDaguxqwmAwpGDkynkov6ptBg0gDfbVpC1Umupjl
         lBweUe4M4S//h/WNgXKyhfYrfKHHpe/Ot5ru3qC8/qgdSDw+6yjazxXDMHDsVatxKZAw
         zY+8WnRuD5YigsCCw/UW2y46HH9hoCeAy0oPfqafo4/pH4+BX57JnFrDTDWAdQHIhxEQ
         5xdg==
X-Forwarded-Encrypted: i=1; AJvYcCWNITypfRTnS29aneGIOrz6zMnPYB2sV7SRVjw8Yc1McQbSXQrnnx2snlyV+96dTdmmOZcnNCdvj/RO3oCKczgFmbyVnOWZnBdv3cFy
X-Gm-Message-State: AOJu0YxzE+UDqoiqFPAYk1vS0LzABjWCXpWwfmLAGsZzP7V788H6ZklG
	4bnYM49RTJslM0XyEesPNJ7Jw9tEdStCHwv0z71pfeb9GNC0SZNy
X-Google-Smtp-Source: AGHT+IEHRrZfsLAXmwfC0TLEfea+DaUlZDiB/BZsG73+jVdIprdrukbUYpmRDwzyTfT6rFZfayKehA==
X-Received: by 2002:a05:6512:3194:b0:513:4965:8d4e with SMTP id i20-20020a056512319400b0051349658d4emr352641lfe.26.1709919256044;
        Fri, 08 Mar 2024 09:34:16 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id a23-20020a195f57000000b0051333e2f55dsm3150504lfj.159.2024.03.08.09.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:34:15 -0800 (PST)
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
Subject: [PATCH v6 4/6] rcu: Support direct wake-up of synchronize_rcu() users
Date: Fri,  8 Mar 2024 18:34:07 +0100
Message-Id: <20240308173409.335345-5-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308173409.335345-1-urezki@gmail.com>
References: <20240308173409.335345-1-urezki@gmail.com>
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
 kernel/rcu/tree.c | 32 ++++++++++++++++++++++++++++++--
 kernel/rcu/tree.h |  6 ++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index dcc1764e8fad..063200613444 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1672,7 +1672,8 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
  */
 static void rcu_sr_normal_gp_cleanup(void)
 {
-	struct llist_node *wait_tail;
+	struct llist_node *wait_tail, *next, *rcu;
+	int done = 0;
 
 	wait_tail = rcu_state.srs_wait_tail;
 	if (wait_tail == NULL)
@@ -1680,12 +1681,39 @@ static void rcu_sr_normal_gp_cleanup(void)
 
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
 
-	schedule_work(&rcu_state.srs_cleanup_work);
+	if (wait_tail->next)
+		schedule_work(&rcu_state.srs_cleanup_work);
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b942b9437438..2832787cee1d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -315,6 +315,12 @@ do {									\
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


