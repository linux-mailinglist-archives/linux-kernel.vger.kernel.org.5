Return-Path: <linux-kernel+bounces-25134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FBB82C857
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991EF1C21B3C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9040F5681;
	Sat, 13 Jan 2024 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBg28VA5"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782EA4C90
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-598b8dd877dso944572eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705105763; x=1705710563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnpY5fI7XtUUv+TpugiugegGqHsa0VQ14Cm2fOBc3CE=;
        b=RBg28VA5ywPfn0upNTW+4pcm5WVITXRmkuFXIi4WI3k8PxF8hVW3E11NsksHQxTqUt
         Ug0XJQmNTQNFn18VeAknaxAUOHOsf9ZVcCuZXMMeQK615UTVK5Dr4qVmhR8sWKMfRL6I
         7f64EMeNNHXF2Q85vO6Kb5BZy08vjKrniNaFFP2y53/UW9OvapHu5+izmNkr7q5h5RRa
         A9RFLqanT2AU2YhsJn2lmvT4SMizTxLRF/PPp5aTovJWQa9sxqjU2VCj8beV0cFlR7+1
         ZHrfbWL5QjAvl+v9Rel+skndoYwVMnutetO5OxMCHRKqvf3iiHiN0+163T/ZqWbukI3I
         Bdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105763; x=1705710563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dnpY5fI7XtUUv+TpugiugegGqHsa0VQ14Cm2fOBc3CE=;
        b=vQdaqp/lIwVBCVHNyXYa4MAfpP2bmUhqMeDI1cKDN2m4ffsVLLQ2fgKo6qyqxr/98e
         ug0wMxPKAgmFNTvCWIUDIS3ncXbFRfwUEhHj62oOCfpuLJnqKkgwddocm6fC3eFJuQPC
         eUExm5D+QB+WH1XOd8hpTeDlmLU1eQBYkpObesEkUOSfM8Dwbcpli+bTdipDloA2mBYz
         lUqbAp3yk5sbsnsj1s2SLWVHf4yPIqi7a0JgAfvAk2fBVPEf6n+qDfIXeXStAkFYQN2Q
         PL4RSydqygD1mx9+hjzOvkaq1GVtFKC6HEEGb3NgRTW+C99S43Hkyg9onZ6VuIFHyYie
         p11w==
X-Gm-Message-State: AOJu0YwS3GE2qtBaZjrWaxwKClWunI82MqdxbiT3RzG5mwR/6rJCDegP
	tQ7lPzu7UaI2+QFeKwiBM7Q=
X-Google-Smtp-Source: AGHT+IEC+VFH1SBvsc3KSVWGYt6C045l9MDwquBTsK7B0/fqu6mRZ82V6XkRcc4HGSh7czyWLuU1WQ==
X-Received: by 2002:a05:6359:7402:b0:175:a9ce:e69a with SMTP id va2-20020a056359740200b00175a9cee69amr1987962rwb.40.1705105763287;
        Fri, 12 Jan 2024 16:29:23 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id i7-20020a639d07000000b005b7dd356f75sm3728840pgd.32.2024.01.12.16.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 16:29:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/9] workqueue: Make wq_adjust_max_active() round-robin pwqs while activating
Date: Fri, 12 Jan 2024 14:28:49 -1000
Message-ID: <20240113002911.406791-6-tj@kernel.org>
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

wq_adjust_max_active() needs to activate work items after max_active is
increased. Previously, it did that by visiting each pwq once activating all
that could be activated. While this makes sense with per-pwq nr_active,
nr_active will be shared across multiple pwqs for unbound wqs. Then, we'd
want to round-robin through pwqs to be fairer.

In preparation, this patch makes wq_adjust_max_active() round-robin pwqs
while activating. While the activation ordering changes, this shouldn't
cause user-noticeable behavior changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7eb1925087fd..f90f797e73a1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4700,7 +4700,7 @@ static int init_rescuer(struct workqueue_struct *wq)
  */
 static void wq_adjust_max_active(struct workqueue_struct *wq)
 {
-	struct pool_workqueue *pwq;
+	bool activated;
 
 	lockdep_assert_held(&wq->mutex);
 
@@ -4720,19 +4720,26 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 	 */
 	WRITE_ONCE(wq->max_active, wq->saved_max_active);
 
-	for_each_pwq(pwq, wq) {
-		unsigned long flags;
-
-		/* this function can be called during early boot w/ irq disabled */
-		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-
-		while (pwq_activate_first_inactive(pwq))
-			;
+	/*
+	 * Round-robin through pwq's activating the first inactive work item
+	 * until max_active is filled.
+	 */
+	do {
+		struct pool_workqueue *pwq;
 
-		kick_pool(pwq->pool);
+		activated = false;
+		for_each_pwq(pwq, wq) {
+			unsigned long flags;
 
-		raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
-	}
+			/* can be called during early boot w/ irq disabled */
+			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
+			if (pwq_activate_first_inactive(pwq)) {
+				activated = true;
+				kick_pool(pwq->pool);
+			}
+			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
+		}
+	} while (activated);
 }
 
 __printf(1, 4)
-- 
2.43.0


