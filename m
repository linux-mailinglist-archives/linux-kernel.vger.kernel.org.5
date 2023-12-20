Return-Path: <linux-kernel+bounces-6476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B981996F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C841287B12
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D64200D3;
	Wed, 20 Dec 2023 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQcBxp6s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDDB1F609
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so25716675ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057152; x=1703661952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anrryp97YGhOq8gAQ2mcF1ZfJH3qgk5A1LSz7iukQ8A=;
        b=hQcBxp6sQaK5dKgP7l42/QcZl81T0u2af8aU4F+d6ZagrQEheIwF9YRJ19d+GiZjzG
         yP59lz/Kq3TS2aG8ECzNr5xiJXquio23I2Jxf7QzRpr4G3XXsTBhmM1kZA7Us9Hrbxs8
         np0aMA3d/DjH5EcngB3yseVeB7Hum58gUbYS7+bIFpQMPYtX99l/218Ijz/gtxO9KRUY
         mlo8MLq7z25RNoJ7RkMw6p92BIo5uLHRjwMzYK31bT7UV4RdQ50/AhMfRRS1PwL5zr8W
         FpgOamd7JAdC/f3N8k76BtRf3gxUbIjrpgk7rwdYLLSch8AkLtd795dQJgtszy8wkm2J
         KQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057152; x=1703661952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=anrryp97YGhOq8gAQ2mcF1ZfJH3qgk5A1LSz7iukQ8A=;
        b=dBtUusW6Ypu0tlskElQ4J/Fiz5Q8kAQOXT3oI7ROdFgbe80c0jrwhoVZWdWSFbtL7Q
         NZOyUmL0FISA/Du1jJZ7cRBNTXrZguOGdC5g+jxHffKLY1SZ+zrGfwsD5rVpErlwkP2O
         YZye/6OtEFnD6nleH4TNZ/d5edsp6/hxmFvtKIwGYucRgdUMPR4i5Mv13tWPh/CeN8Yx
         GhaXG4ouE+Ec7I7XJlFhhxVbXBg5rYL/F2VVfj+yZznyVEEyutc14O2K1gZAX1Dux8fS
         UgYpL+qy54aIRcEgwRdCSO5YZC0t5sKzyi5JL+1Y3JWCM/BnAxqWKgrD+LREnSGkY7wU
         bJoA==
X-Gm-Message-State: AOJu0YzDkZdGn70MKH5Y3V4DFdIdG+Y/GuWKsAAmLgmiqm4anpcUruMm
	Ud1ZX940e0XfH6eFiSBosYE=
X-Google-Smtp-Source: AGHT+IH07Ao6NZ5PkKOM0K3iDebYrp+paNrpJ7gc40NaqDmdqCWIISUr87c5W166aHOnTGBRIccW8A==
X-Received: by 2002:a17:902:ec88:b0:1d3:e53e:865d with SMTP id x8-20020a170902ec8800b001d3e53e865dmr1171747plg.109.1703057152575;
        Tue, 19 Dec 2023 23:25:52 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001d0c3328a63sm22228411plh.66.2023.12.19.23.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:25:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/10] workqueue: Make wq_adjust_max_active() round-robin pwqs while activating
Date: Wed, 20 Dec 2023 16:24:36 +0900
Message-ID: <20231220072529.1036099-6-tj@kernel.org>
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
index 21bd4e4351f7..143c0b31505e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4699,7 +4699,7 @@ static int init_rescuer(struct workqueue_struct *wq)
  */
 static void wq_adjust_max_active(struct workqueue_struct *wq)
 {
-	struct pool_workqueue *pwq;
+	bool activated;
 
 	lockdep_assert_held(&wq->mutex);
 
@@ -4713,19 +4713,26 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 
 	wq->max_active = wq->saved_max_active;
 
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


