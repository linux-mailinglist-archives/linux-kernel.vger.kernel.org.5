Return-Path: <linux-kernel+bounces-12064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AEC81EF92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62B5CB22105
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB91F46539;
	Wed, 27 Dec 2023 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN/5vIBk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF70A4645C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3ea5cc137so41536835ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703688598; x=1704293398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ykeys9/b81hQucL41oKnYrH4NAgYOfGtA2bT2pIxo5Q=;
        b=NN/5vIBkuMEgYFRUg56ViHsz6i0CXAPj1jkWMWTSuL+MVuBz6am6ZAV3e7oJvLaErg
         i2ewoS4ZxSnC+Y0Wu3u1SSLWJVOokwbXmpWwjEjaP5Jo+Ktx4X9NYOcINEf4XRF69Vtk
         W1Z2c0acQF3t0I+/oF39onoQCFIxp3DSCuyVk/pppKBQi/v3pyxMD5FNmmhMPe6U+2wY
         xMAjioZHWbXo7QYk8y+ru/xjshGkCFLhdrAFlrtMxUDMpyBdo/cV6bz5n3PW5Bwng86A
         4ZxoCAsNKf+Wrm18b/cELUJCvw/KsPhEGbe0iIIOdjmNOICuQ0j+o9K/tmWNhicocZpW
         23kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688598; x=1704293398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ykeys9/b81hQucL41oKnYrH4NAgYOfGtA2bT2pIxo5Q=;
        b=LjBA3gYQfVdhc+IZjMsDlNIPLSW6mmAGAEiXiTPUgGrmOeDmW4yUY3062nyhV6bgYk
         d2kvjcggSewtlYXFIPrbNWDSRGPwBDXQ/FjwuKXXFag8E5pdFqNqsKQlGj4c+QX5Q3vB
         tiRVUcY0PfqYTBopNMp50Sk4JEd7B3/fDMOJUf+pKNf791ybk8ZDSKAyCFkjBR+7glf+
         ZZEjHOJMl+/y8VjTo6JZgSWQ79subfMDDsHJ197UoN8y+Rec/OB21NgI3/vOQTjAclDW
         KW0b1Cc5tY2ag3gRvvw3113AWR6+TIpTvn9LiBO/p6JnQ+gIIHdj5iNTN+D1nNuIjXrR
         Un1Q==
X-Gm-Message-State: AOJu0YxRxQk0w9i9aDSBVg5W+st+yLBACHjavbBEXyjAgitgeYu/Y70c
	0MD3u1oBuYHlYZbaxZ++V8ldL++DJqQ=
X-Google-Smtp-Source: AGHT+IHcTxjTwPjjGkbJJK3nbpQrTZXlHguLc+5SBzxWmI2Zv2rylsUjKPCPppedRvBEwAeyFRO5yA==
X-Received: by 2002:a17:902:ec92:b0:1d0:6ffe:9f5 with SMTP id x18-20020a170902ec9200b001d06ffe09f5mr8166768plg.83.1703688597875;
        Wed, 27 Dec 2023 06:49:57 -0800 (PST)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b001cfc1b931a9sm11995380pln.249.2023.12.27.06.49.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2023 06:49:57 -0800 (PST)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Naohiro.Aota@wdc.com,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 4/7] workqueue: Wrap common code into wq_adjust_pwqs_max_active()
Date: Wed, 27 Dec 2023 22:51:40 +0800
Message-Id: <20231227145143.2399-5-jiangshanlai@gmail.com>
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

There are 3 places using the same code, so wrap them into a common helper.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3347ba3a734f..e0101b2b5fa3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4190,6 +4190,16 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 }
 
+static void wq_adjust_pwqs_max_active(struct workqueue_struct *wq)
+{
+	struct pool_workqueue *pwq;
+
+	mutex_lock(&wq->mutex);
+	for_each_pwq(pwq, wq)
+		pwq_adjust_max_active(pwq);
+	mutex_unlock(&wq->mutex);
+}
+
 /* initialize newly allocated @pwq which is associated with @wq and @pool */
 static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 		     struct worker_pool *pool)
@@ -4700,7 +4710,6 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 {
 	va_list args;
 	struct workqueue_struct *wq;
-	struct pool_workqueue *pwq;
 
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
@@ -4761,14 +4770,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	 * list.
 	 */
 	mutex_lock(&wq_pool_mutex);
-
-	mutex_lock(&wq->mutex);
-	for_each_pwq(pwq, wq)
-		pwq_adjust_max_active(pwq);
-	mutex_unlock(&wq->mutex);
-
+	wq_adjust_pwqs_max_active(wq);
 	list_add_tail_rcu(&wq->list, &workqueues);
-
 	mutex_unlock(&wq_pool_mutex);
 
 	return wq;
@@ -5698,19 +5701,14 @@ EXPORT_SYMBOL_GPL(work_on_cpu_safe_key);
 void freeze_workqueues_begin(void)
 {
 	struct workqueue_struct *wq;
-	struct pool_workqueue *pwq;
 
 	mutex_lock(&wq_pool_mutex);
 
 	WARN_ON_ONCE(workqueue_freezing);
 	workqueue_freezing = true;
 
-	list_for_each_entry(wq, &workqueues, list) {
-		mutex_lock(&wq->mutex);
-		for_each_pwq(pwq, wq)
-			pwq_adjust_max_active(pwq);
-		mutex_unlock(&wq->mutex);
-	}
+	list_for_each_entry(wq, &workqueues, list)
+		wq_adjust_pwqs_max_active(wq);
 
 	mutex_unlock(&wq_pool_mutex);
 }
@@ -5773,7 +5771,6 @@ bool freeze_workqueues_busy(void)
 void thaw_workqueues(void)
 {
 	struct workqueue_struct *wq;
-	struct pool_workqueue *pwq;
 
 	mutex_lock(&wq_pool_mutex);
 
@@ -5783,12 +5780,8 @@ void thaw_workqueues(void)
 	workqueue_freezing = false;
 
 	/* restore max_active and repopulate worklist */
-	list_for_each_entry(wq, &workqueues, list) {
-		mutex_lock(&wq->mutex);
-		for_each_pwq(pwq, wq)
-			pwq_adjust_max_active(pwq);
-		mutex_unlock(&wq->mutex);
-	}
+	list_for_each_entry(wq, &workqueues, list)
+		wq_adjust_pwqs_max_active(wq);
 
 out_unlock:
 	mutex_unlock(&wq_pool_mutex);
-- 
2.19.1.6.gb485710b


