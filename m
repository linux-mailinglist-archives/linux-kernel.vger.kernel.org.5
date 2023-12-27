Return-Path: <linux-kernel+bounces-12067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1E281EF95
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A743FB20482
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E090147F58;
	Wed, 27 Dec 2023 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajXoVreg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E997847F4D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cd5cdba609so3954685a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703688612; x=1704293412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBhAD2KkbriEp2qNC+ghO6AuutHK13Eu3XnJAL8S1+o=;
        b=ajXoVregn/SHzWsoS+oENP/XcxH1cNJ/lhGGiGn+u8OoZ6nZhZdeu0Y+3ZsbwkCtAa
         FfsQHWn1kNFAWkcaKbR2AUYoiz+eG0bvc/X5VRz2iIAe/H4ksDuK8S3HGca5+mzKC6SQ
         lck+4mY2rwWqx4i4JckP4cC48rTklsRxyMp+5HToR0zOuUrQndWcRQw56RSxRkPdjo3q
         STaqbgPbxNcsj9flTvZg/QWhfV4pta7C8m+vMjXJybcHwr/JDnjpjeKR293koDQ9J6nb
         XlEAFmIxfwk4bse4Ktv8psX6HsmDdyhtF02sG9Tq0xT/uozeeoGRVehR7FRqtLouiVnZ
         xy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688612; x=1704293412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBhAD2KkbriEp2qNC+ghO6AuutHK13Eu3XnJAL8S1+o=;
        b=Q8Y+cmxAmCWtW/AteV0y/tBCmL9ajbPBnaKF9IQBTFX8on8sx+ZXXB6woQYyO7UWF2
         1f3IyAshWhrIrezuF4o7sAG9axyUz6fMuvSLTLa4N6itZ1ZjqVOE0X2PHBMCUjtcLgqx
         Z4hoYUQXufEpyfiMjH4PK7bWdYJiN+mm213ekVh2ebWJivKyPV+180xV6eMCT+ie1KS1
         ryp7GHq51EUj1WtOnp8x7HpdVhiSj1SZ5QrIgvgF+Ybd889ObfzCnY7msvs0xG3fV50E
         NRymNhx4euPINAhhYlHF2kOX5p0B/50CSGFe30XikQmLGZy4og4gWw3mQsm4TL4tXRBB
         Nrcw==
X-Gm-Message-State: AOJu0YzcO+jCuEt3tO3mT4bCRBustoUdyb/npowYxLgGbpwJAkgWmD5e
	Vn/JuhLeF0nB1DBEm++Ijo4tD1x3CV0=
X-Google-Smtp-Source: AGHT+IEKVvwlf1bFhDODYLApQeMtBwkhw43sIPpWdIdPa1YiE1pczTAvikL0QjsZI/5Hv8dk2/k35A==
X-Received: by 2002:a05:6a21:99a9:b0:196:16b0:b7b3 with SMTP id ve41-20020a056a2199a900b0019616b0b7b3mr1480281pzb.78.1703688612010;
        Wed, 27 Dec 2023 06:50:12 -0800 (PST)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a001ac600b006d9a48882f7sm7651268pfv.118.2023.12.27.06.50.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2023 06:50:11 -0800 (PST)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Naohiro.Aota@wdc.com,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 7/7] workqueue: Rename wq->saved_max_active to wq->max_active
Date: Wed, 27 Dec 2023 22:51:43 +0800
Message-Id: <20231227145143.2399-8-jiangshanlai@gmail.com>
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

The name max_active is clearer.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 382c53f89cb4..0458545642f7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -298,7 +298,7 @@ struct workqueue_struct {
 	struct worker		*rescuer;	/* MD: rescue worker */
 
 	int			nr_drainers;	/* WQ: drain in progress */
-	int			saved_max_active; /* WQ: saved max_active */
+	int			max_active;	/* WQ: percpu or total max_active */
 	int			min_active;	/* WQ: pwq min_active */
 
 	struct workqueue_attrs	*unbound_attrs;	/* PW: only for unbound wqs */
@@ -3376,7 +3376,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 	 * forward progress.
 	 */
 	if (!from_cancel &&
-	    (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer)) {
+	    (pwq->wq->max_active == 1 || pwq->wq->rescuer)) {
 		lock_map_acquire(&pwq->wq->lockdep_map);
 		lock_map_release(&pwq->wq->lockdep_map);
 	}
@@ -4159,17 +4159,17 @@ static int pwq_calculate_max_active(struct pool_workqueue *pwq)
 		return 0;
 
 	if (!(pwq->wq->flags & WQ_UNBOUND))
-		return pwq->wq->saved_max_active;
+		return pwq->wq->max_active;
 
 	pwq_nr_online_cpus = cpumask_weight_and(pwq->pool->attrs->__pod_cpumask, cpu_online_mask);
-	max_active = DIV_ROUND_UP(pwq->wq->saved_max_active * pwq_nr_online_cpus, num_online_cpus());
+	max_active = DIV_ROUND_UP(pwq->wq->max_active * pwq_nr_online_cpus, num_online_cpus());
 
 	/*
 	 * To guarantee forward progress regardless of online CPU distribution,
 	 * the concurrency limit on every pwq is guaranteed to be equal to or
 	 * greater than wq->min_active.
 	 */
-	return clamp(max_active, pwq->wq->min_active, pwq->wq->saved_max_active);
+	return clamp(max_active, pwq->wq->min_active, pwq->wq->max_active);
 }
 
 /**
@@ -4177,7 +4177,7 @@ static int pwq_calculate_max_active(struct pool_workqueue *pwq)
  * @pwq: target pool_workqueue
  *
  * If @pwq isn't freezing, set @pwq->max_active to the associated
- * workqueue's saved_max_active and activate inactive work items
+ * workqueue's max_active and activate inactive work items
  * accordingly.  If @pwq is freezing, clear @pwq->max_active to zero.
  */
 static void pwq_adjust_max_active(struct pool_workqueue *pwq)
@@ -4186,7 +4186,7 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 	int max_active = pwq_calculate_max_active(pwq);
 	unsigned long flags;
 
-	/* for @wq->saved_max_active */
+	/* for @wq->max_active */
 	lockdep_assert_held(&wq->mutex);
 
 	/* fast exit if unchanged */
@@ -4761,7 +4761,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	/* init wq */
 	wq->flags = flags;
-	wq->saved_max_active = max_active;
+	wq->max_active = max_active;
 	wq->min_active = min(max_active, WQ_DFL_MIN_ACTIVE);
 	mutex_init(&wq->mutex);
 	atomic_set(&wq->nr_pwqs_to_flush, 0);
@@ -4935,7 +4935,7 @@ void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 	mutex_lock(&wq->mutex);
 
 	wq->flags &= ~__WQ_ORDERED;
-	wq->saved_max_active = max_active;
+	wq->max_active = max_active;
 	wq->min_active = min(wq->min_active, max_active);
 
 	for_each_pwq(pwq, wq)
@@ -5990,7 +5990,7 @@ static ssize_t max_active_show(struct device *dev,
 {
 	struct workqueue_struct *wq = dev_to_wq(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", wq->saved_max_active);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", wq->max_active);
 }
 
 static ssize_t max_active_store(struct device *dev,
-- 
2.19.1.6.gb485710b


