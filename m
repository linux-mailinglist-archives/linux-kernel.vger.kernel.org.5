Return-Path: <linux-kernel+bounces-6473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F6781996C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3CC1C212F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4989B1CAB3;
	Wed, 20 Dec 2023 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faqLeylt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1BE1A5B3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cd870422c8so1420851a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057143; x=1703661943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4Aa1zFAX25+F+derZRZ6AIVdw3+YQ1yR66ZRdHnhqs=;
        b=faqLeyltzNmK7dSdVZ7rjIDxQNr+6zk0HWxk8Y8ng+0KFbn2nZn2uouDQyHyrzWCVH
         itglQ5tRFTtFGALuw2rowxP2Jnz/Cws0bGuQYKo29ghSPW2M9QcXmVhv9jkCOAH/Z7zW
         5fSLv7vgtTePCe9vO94KfKY14SGetqCMFMf5hSoJrc71pdWE91c0qtbpCMnJ+DkrfqoF
         3qbO/kOaQiYZ2OHHmEymcL4E94VfXbVjkNzFX/+hWo6jL8KABmXX5awH+nq4RmcQ9d0d
         TGP0XIjGzGSA7PaOmbX8OrzEbZAJPU87lRjG34xNTgtEpSyl7JWcAQmTYEDzlgLRnhXU
         edqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057143; x=1703661943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g4Aa1zFAX25+F+derZRZ6AIVdw3+YQ1yR66ZRdHnhqs=;
        b=d4OD6mXewl9xVn5jjla9aqel5HX25A0ZEU+1QSOIYWSRXzzOmKBxBwKof7HkgAYhdK
         ABlytRnH+5/Kj6T41WQ6kC6re6Xx6Lp4jhJifUd2HwDgS3UXJn5wazli7KZuKXUB9vcR
         6J9G+Vb2q7dSp81VHqAgHo1xOLYbah8CSnw3feorFYalSJlfzi+LhjgrOZXYHilEEDK5
         epXSrwbQVK7npBqoYlyc1oVvl60IBgYRFSjoXUugsKLV/HkqWSaMvexpfwf5RnOdlJCp
         0X73ySU8LWg0sNbddHAsZV0QfxYW48NIQlJ3418mUoy9Hs14cMlw4WMKZzoz/fTceMgG
         IgmQ==
X-Gm-Message-State: AOJu0Yy6ZAinj8A/cMD8tT5SMG5jFVt8f4dq0jBjb6ZU8LU1lK9gzMG0
	ePVWzNGVcVXrfpqL1x+I6AA=
X-Google-Smtp-Source: AGHT+IFVoB3ov1+I0cEzKswGlwFDoYXzpplhzh7OcAoLHXcJ9C+iBl7UsoR7atRqyx1e6ROP8BG+rg==
X-Received: by 2002:a17:902:d2cb:b0:1d0:4cb8:4510 with SMTP id n11-20020a170902d2cb00b001d04cb84510mr12247770plc.50.1703057143432;
        Tue, 19 Dec 2023 23:25:43 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b001d38410aa13sm9247446plg.192.2023.12.19.23.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:25:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/10] workqueue: Factor out pwq_is_empty()
Date: Wed, 20 Dec 2023 16:24:33 +0900
Message-ID: <20231220072529.1036099-3-tj@kernel.org>
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

"!pwq->nr_active && list_empty(&pwq->inactive_works)" test is repeated
multiple times. Let's factor it out into pwq_is_empty().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0e5dbeeb5778..c6c90af89d3d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1447,6 +1447,11 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
 	}
 }
 
+static bool pwq_is_empty(struct pool_workqueue *pwq)
+{
+	return !pwq->nr_active && list_empty(&pwq->inactive_works);
+}
+
 static void pwq_activate_inactive_work(struct work_struct *work)
 {
 	struct pool_workqueue *pwq = get_work_pwq(work);
@@ -3310,7 +3315,7 @@ void drain_workqueue(struct workqueue_struct *wq)
 		bool drained;
 
 		raw_spin_lock_irq(&pwq->pool->lock);
-		drained = !pwq->nr_active && list_empty(&pwq->inactive_works);
+		drained = pwq_is_empty(pwq);
 		raw_spin_unlock_irq(&pwq->pool->lock);
 
 		if (drained)
@@ -4760,7 +4765,7 @@ static bool pwq_busy(struct pool_workqueue *pwq)
 
 	if ((pwq != pwq->wq->dfl_pwq) && (pwq->refcnt > 1))
 		return true;
-	if (pwq->nr_active || !list_empty(&pwq->inactive_works))
+	if (!pwq_is_empty(pwq))
 		return true;
 
 	return false;
@@ -5197,7 +5202,7 @@ void show_one_workqueue(struct workqueue_struct *wq)
 	unsigned long flags;
 
 	for_each_pwq(pwq, wq) {
-		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+		if (!pwq_is_empty(pwq)) {
 			idle = false;
 			break;
 		}
@@ -5209,7 +5214,7 @@ void show_one_workqueue(struct workqueue_struct *wq)
 
 	for_each_pwq(pwq, wq) {
 		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+		if (!pwq_is_empty(pwq)) {
 			/*
 			 * Defer printing to avoid deadlocks in console
 			 * drivers that queue work while holding locks
-- 
2.43.0


