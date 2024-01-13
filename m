Return-Path: <linux-kernel+bounces-25132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877CC82C855
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963E01C20930
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C48633C8;
	Sat, 13 Jan 2024 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYO8gCIE"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730101849
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28ddd807e4bso1557218a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705105760; x=1705710560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hhgQ9Ba+csZn8AbWRJgO5krKNkBDc8AaTbCZOWymW4=;
        b=PYO8gCIEsIKdZSyWjLDawWHS2/HU608Uxsg5Ar8CRaiqMwKS6AQa/H7EpQIfjllDqt
         CUNuOzbaKWY3atJBNByWybmlql4GC4ML9hIfaL2YP8YQtuytPotSl/5W7vScgfxikk+r
         WIQIhjfmYQhCA0XGXQJr0naen51tw6Af5IGZZ2yMW+6BYteR/soaR1qXK4KTd2FI2JLj
         WP8SbAmCu72iJyVf3qWVEQR5Nd9m/+a4n1/zCX6nOb95E2M3SzdcC0AZ6cyMOcpQZbFm
         FJ/sdMcgZNL1CPNpLYv6fnHUQBrueYkabtE77siZJpmd3WRIk29Eh+Jw5ytsmdBiuRes
         JtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105760; x=1705710560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+hhgQ9Ba+csZn8AbWRJgO5krKNkBDc8AaTbCZOWymW4=;
        b=XeS28GyiQCMZsrVFavBjp/5jtfKefg6aAipe6JbhFajrsJVwmDssaF4pK6ucrWmmCy
         16MEwA2NP4rOhiGBVbDK2QxIQlSItvgmJW7F3DOuGaPHx3avY9ixlEJ5QN3PR/JSP+Bo
         7Ab9FyWWsXbMQCU09WhvOizVYd3Ab48R9M451+RlAFu8O8gDV8Kz7M5Rm5mTaUbJHhEf
         hRZY8diQWvfkWpJRq1OeUFfzpmIyZJL/scuyGDHSXhMxCR0G+OlPgsfA3t4+Ebbb0ZC8
         Jq6xKfBZKszH/RIE3JzDj+UoeoTZOuRzQweJdUQsatzjeefqH880cBTaPxIk7lWIdb1Y
         I2cw==
X-Gm-Message-State: AOJu0Yyz+EzRXxh3jv8UDDfAmhz/rz6VUav8PKadgsWCbdvoPskCMJbq
	9U7T0FXI0wCAmYxQeLULrzg=
X-Google-Smtp-Source: AGHT+IFTTg7X1xqUIY2cykkeMBxAdtqhd9WWP/U+qJ8h7xcvQV+ng5HsAvTfIcfMjmU45veRECbh8Q==
X-Received: by 2002:a17:90a:d142:b0:28d:9c3f:b234 with SMTP id t2-20020a17090ad14200b0028d9c3fb234mr2043966pjw.79.1705105759807;
        Fri, 12 Jan 2024 16:29:19 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id cz13-20020a17090ad44d00b0028c8a2a9c73sm4895613pjb.25.2024.01.12.16.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 16:29:19 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/9] workqueue: Replace pwq_activate_inactive_work() with [__]pwq_activate_work()
Date: Fri, 12 Jan 2024 14:28:47 -1000
Message-ID: <20240113002911.406791-4-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113002911.406791-1-tj@kernel.org>
References: <20240113002911.406791-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for unbound nr_active handling improvements, move work activation
part of pwq_activate_inactive_work() into __pwq_activate_work() and add
pwq_activate_work() which tests WORK_STRUCT_INACTIVE and updates nr_active.

pwq_activate_first_inactive() and try_to_grab_pending() are updated to use
pwq_activate_work(). The latter conversion is functionally identical. For
the former, this conversion adds an unnecessary WORK_STRUCT_INACTIVE
testing. This is temporary and will be removed by the next patch.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 09f0ec086726..2cd275b34df2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1461,16 +1461,36 @@ static bool pwq_is_empty(struct pool_workqueue *pwq)
 	return !pwq->nr_active && list_empty(&pwq->inactive_works);
 }
 
-static void pwq_activate_inactive_work(struct work_struct *work)
+static void __pwq_activate_work(struct pool_workqueue *pwq,
+				struct work_struct *work)
 {
-	struct pool_workqueue *pwq = get_work_pwq(work);
-
 	trace_workqueue_activate_work(work);
 	if (list_empty(&pwq->pool->worklist))
 		pwq->pool->watchdog_ts = jiffies;
 	move_linked_works(work, &pwq->pool->worklist, NULL);
 	__clear_bit(WORK_STRUCT_INACTIVE_BIT, work_data_bits(work));
+}
+
+/**
+ * pwq_activate_work - Activate a work item if inactive
+ * @pwq: pool_workqueue @work belongs to
+ * @work: work item to activate
+ *
+ * Returns %true if activated. %false if already active.
+ */
+static bool pwq_activate_work(struct pool_workqueue *pwq,
+			      struct work_struct *work)
+{
+	struct worker_pool *pool = pwq->pool;
+
+	lockdep_assert_held(&pool->lock);
+
+	if (!(*work_data_bits(work) & WORK_STRUCT_INACTIVE))
+		return false;
+
 	pwq->nr_active++;
+	__pwq_activate_work(pwq, work);
+	return true;
 }
 
 static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
@@ -1478,7 +1498,7 @@ static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
 	struct work_struct *work = list_first_entry(&pwq->inactive_works,
 						    struct work_struct, entry);
 
-	pwq_activate_inactive_work(work);
+	pwq_activate_work(pwq, work);
 }
 
 /**
@@ -1616,8 +1636,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 		 * management later on and cause stall.  Make sure the work
 		 * item is activated before grabbing.
 		 */
-		if (*work_data_bits(work) & WORK_STRUCT_INACTIVE)
-			pwq_activate_inactive_work(work);
+		pwq_activate_work(pwq, work);
 
 		list_del_init(&work->entry);
 		pwq_dec_nr_in_flight(pwq, *work_data_bits(work));
-- 
2.43.0


