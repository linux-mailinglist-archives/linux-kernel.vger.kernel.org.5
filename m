Return-Path: <linux-kernel+bounces-6474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D276A81996D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D111F22233
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA651D6BE;
	Wed, 20 Dec 2023 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfl1VrFi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C474C1CF88
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d2350636d6so4642409b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057146; x=1703661946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKjTA274kIUbd57lzfNvtH1IB2YvBjqY9x2It/BRGm0=;
        b=Bfl1VrFiOHQ4Cjqb88UKQUjEcO8c1NOypQraD64ne6V2dj0BG1masWRS5CYuYGT1l4
         Xwv9YEjStNCeCJ1rzNImUikQDQTnoUePBdG3OhF2BMDXadXshdRNfbnFTfCybmfiscPG
         qu2pV/ADVYEv05NAEaHImdGw7cZ9vkolbCvW6D3JLrMj8WAJAdAqt/dFMprCiBPrDw++
         eby0bDjY52SG1UVbFZHxq26BQKG/pMdziV8IxfzJGzH1mVjx2nhb3gLkpdNrp7l/neZK
         ZqKjVsXduR4hkXOgm7xl1hlQG7KSm/9yQ1gmnNKMCUvO/e4O7FuW+SwfsKyDxvjJZtzA
         ixXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057146; x=1703661946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xKjTA274kIUbd57lzfNvtH1IB2YvBjqY9x2It/BRGm0=;
        b=iiLpx6dBBMC9ZBKCmtFD/Vdhv7sbndvlVt0HKq7CwT0MTP5Uxbr8MqpoigZRIFE0nv
         h3b3NlBwVtv7rPNN73sEXL8AOFb3pQyBoSon8eUTP379XnHk/n5GMCCKE/s/WskgIs+9
         VYed8Gi7GVWAbqOswnBz++e6bwbOEk7FoRXexWLOnEyLl4LjG6MAcz5qPPSXQbEro1/k
         05z9FFpMn98amloDFCKbf8DW9Kb78aRuxkP87jURZ4R7trLTtuh4Um+dWcuDFtpKdklJ
         e4iF/I7bOj4GRQn7DRAZQO+ojwq8jrLb1nOVxxlJFURjymq6heIOmpDV/4IqThb9CxqN
         CECA==
X-Gm-Message-State: AOJu0YzeaZQdNMBjqdOapDLFFaBqvE8/8dXeEDj2X8fpxrwPyv6anf93
	2AYgcNwBqo7wD1pnEXFHIAs=
X-Google-Smtp-Source: AGHT+IHOCD267n3+HQQuA9jEjTnXO+8OVYx2ShJ/77dUMunOthFqwY96nouXMbtB7tXQY3SM2ma7Jg==
X-Received: by 2002:a05:6a00:80e7:b0:6d6:503a:d61e with SMTP id ei39-20020a056a0080e700b006d6503ad61emr4992106pfb.55.1703057146052;
        Tue, 19 Dec 2023 23:25:46 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id v6-20020a056a00148600b006d78009e561sm4964190pfu.56.2023.12.19.23.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:25:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/10] workqueue: Replace pwq_activate_inactive_work() with [__]pwq_activate_work()
Date: Wed, 20 Dec 2023 16:24:34 +0900
Message-ID: <20231220072529.1036099-4-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220072529.1036099-1-tj@kernel.org>
References: <20231220072529.1036099-1-tj@kernel.org>
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
index c6c90af89d3d..adec03e63d50 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1452,16 +1452,36 @@ static bool pwq_is_empty(struct pool_workqueue *pwq)
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
@@ -1469,7 +1489,7 @@ static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
 	struct work_struct *work = list_first_entry(&pwq->inactive_works,
 						    struct work_struct, entry);
 
-	pwq_activate_inactive_work(work);
+	pwq_activate_work(pwq, work);
 }
 
 /**
@@ -1607,8 +1627,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
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


