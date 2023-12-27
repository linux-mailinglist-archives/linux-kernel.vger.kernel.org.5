Return-Path: <linux-kernel+bounces-12063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D8981EF91
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA411C20BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653AF46445;
	Wed, 27 Dec 2023 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF771chD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91DB4643A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d427518d52so23302385ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703688594; x=1704293394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEkOlw6eKaiG2LU3fXepVKKsRgGZTje8n42JsBJJYDI=;
        b=WF771chDp+6AOt7o9/GeMsCo77s+GKRaYP6fpNgXyn/03IgZzPaYYN9lsxdpDsxoZE
         yTT7YaYZbGfHbyEwQTxdH8DIFQHwEXMR5AH+CPfTpxH/Dri/fUaBYZ6kbOziGgVkhWZP
         tGYe1rIdhdpLJRdHDXGjJpigK1GttrVFWcdoBy9aNnRFMjoUTA64ff54AiAkQeHVl/57
         HRPcy1Xg2fSGBGOpODQ3trJ7ZH1IwPOlZ8mUuc+v5MmSJmvYYMcqLu904VMdSNBOsh5U
         BymMMvZPPTNGC9tQkWB6ZwWk8T/ErPf5gH6SAz9FWY9C3eMp2Xbv2lnVqLqKcH8coIrF
         UBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688594; x=1704293394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEkOlw6eKaiG2LU3fXepVKKsRgGZTje8n42JsBJJYDI=;
        b=H54VYtQ+Utq7RaSPFVae2pIRW4r9qOIDqsBZC9U7ZGbDuuPuumxe8AM5y0g6cdVVDm
         6lU80f3ocxU93J/DVqcS6gW4zCYcZLCKIDz1CUsK7/xbtaxIB7nkLsOWfWjy/ae8y5Ar
         L4S60xn7MLiszrpcn7exZJP28Sx2P1xfXoOfIgVLGHIvG22MRM7a1vw9vsKQH6lKTHXQ
         MAC7oeRc19y+Z2qxwcz9GNdoGHbOppuhuL+x71HLesXyZDteafrY7qA2LkFqcRH8oqjP
         W/jCaPVbCxDqPBHOHCJRuRxzE0iGztH/ootfD4ZbU5ml+SyJd8vL5t3mH2L5N3d/tqHe
         5+LA==
X-Gm-Message-State: AOJu0Yyw9wute9xtu5AOAwfhOOtDjJFWEyuHl+3WBY/nOJP2qiZlNoq5
	nsMFghOfnqHG1HqQHMJcoxBBrN6N+5g=
X-Google-Smtp-Source: AGHT+IHMdNlH0PkgFshshrYxah0QlCi/NG+epxLHJDp5aHBWD29Rbgf5ZWxnqwfgsrJ9xAlWetXsSg==
X-Received: by 2002:a17:902:6846:b0:1d4:81bc:a2c2 with SMTP id f6-20020a170902684600b001d481bca2c2mr1093014pln.2.1703688593655;
        Wed, 27 Dec 2023 06:49:53 -0800 (PST)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id ix9-20020a170902f80900b001cff026df52sm12148249plb.221.2023.12.27.06.49.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2023 06:49:53 -0800 (PST)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Naohiro.Aota@wdc.com,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 3/7] workqueue: Add pwq_calculate_max_active()
Date: Wed, 27 Dec 2023 22:51:39 +0800
Message-Id: <20231227145143.2399-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20231227145143.2399-1-jiangshanlai@gmail.com>
References: <20231227145143.2399-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Abstract the code of calculating max_active from pwq_adjust_max_active()
into pwq_calculate_max_active() to make the logic clearer.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1f52685498f1..3347ba3a734f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4136,6 +4136,25 @@ static void pwq_release_workfn(struct kthread_work *work)
 	}
 }
 
+/**
+ * pwq_calculate_max_active - Determine max_active to use
+ * @pwq: pool_workqueue of interest
+ *
+ * Determine the max_active @pwq should use.
+ */
+static int pwq_calculate_max_active(struct pool_workqueue *pwq)
+{
+	/*
+	 * During [un]freezing, the caller is responsible for ensuring
+	 * that pwq_adjust_max_active() is called at least once after
+	 * @workqueue_freezing is updated and visible.
+	 */
+	if ((pwq->wq->flags & WQ_FREEZABLE) && workqueue_freezing)
+		return 0;
+
+	return pwq->wq->saved_max_active;
+}
+
 /**
  * pwq_adjust_max_active - update a pwq's max_active to the current setting
  * @pwq: target pool_workqueue
@@ -4147,35 +4166,26 @@ static void pwq_release_workfn(struct kthread_work *work)
 static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 {
 	struct workqueue_struct *wq = pwq->wq;
-	bool freezable = wq->flags & WQ_FREEZABLE;
+	int max_active = pwq_calculate_max_active(pwq);
 	unsigned long flags;
 
 	/* for @wq->saved_max_active */
 	lockdep_assert_held(&wq->mutex);
 
-	/* fast exit for non-freezable wqs */
-	if (!freezable && pwq->max_active == wq->saved_max_active)
+	/* fast exit if unchanged */
+	if (pwq->max_active == max_active)
 		return;
 
 	/* this function can be called during early boot w/ irq disabled */
 	raw_spin_lock_irqsave(&pwq->pool->lock, flags);
 
-	/*
-	 * During [un]freezing, the caller is responsible for ensuring that
-	 * this function is called at least once after @workqueue_freezing
-	 * is updated and visible.
-	 */
-	if (!freezable || !workqueue_freezing) {
-		pwq->max_active = wq->saved_max_active;
+	pwq->max_active = max_active;
 
-		while (!list_empty(&pwq->inactive_works) &&
-		       pwq->nr_active < pwq->max_active)
-			pwq_activate_first_inactive(pwq);
+	while (!list_empty(&pwq->inactive_works) &&
+	       pwq->nr_active < pwq->max_active)
+		pwq_activate_first_inactive(pwq);
 
-		kick_pool(pwq->pool);
-	} else {
-		pwq->max_active = 0;
-	}
+	kick_pool(pwq->pool);
 
 	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 }
-- 
2.19.1.6.gb485710b


