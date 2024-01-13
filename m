Return-Path: <linux-kernel+bounces-25131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D6982C854
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20721C21D55
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316D71FBB;
	Sat, 13 Jan 2024 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wps0y6pm"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831C7FE
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3607bb6596aso30160535ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705105758; x=1705710558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KbphVddvsQLOwwdUUEscYJQFAo6iH5QxS0p47xTmJU=;
        b=Wps0y6pmUln1CJQP2qeL8iANC6TALObk6N8pwB8BADYXmcpOKsKzykxTqp59+SF/A8
         Uz3h8SA0gVe9FzurhHKu9jn0n455UiDT1vqEVj3cUlsMMPStUlsk2I2gSatApe7kPanE
         natc3zBP256Gcb5Xii8YGKoknS+4aOUoPJcxsqfVYV2BBBpRMjh3kVaC3069Dk/6amxi
         0vu8otoaMdAaudiG5P08Az+kln2IbZUQRPHePc5e4dTRctk8oWaLf+G7s7SPrNDCknjI
         sIXJJfwXPoURAgBWcL8iSLtuDdXjarf2jiCdvyfU+GnYQaCRZVjhpWT7Dv0gO9wDCONj
         0ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105758; x=1705710558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3KbphVddvsQLOwwdUUEscYJQFAo6iH5QxS0p47xTmJU=;
        b=AvScGb5VbaG93R//zwkliInYdezdtMycIDrrJ6deJSfSJGMAwqb7H/yenzLWVLe+NI
         HRHx2bspB3bkLDOEJGv4ncTnF62ldmcQ0cLp9I8W1TWexM2Z9UhlkVta4OJPGye5czz6
         CBdsXkzPn/+sttVaDqXZt2Lpzg0lMmEHBCyfc5jFUgBdRDp/VvaOk0phxqCFxI4xVaYA
         0EmxCiAVrmOCL9pvSCS9z9DQcPYf2kQty3wS7UPqI0aFjC1hq5eoWVZVcIzgX7hcTGaw
         WE45MwDxELCVm0K3QQsyibe5penkXmQU6/IVbmHbEPx7Cc/lwYZIxCWK7VkqHX5fwstX
         gCFA==
X-Gm-Message-State: AOJu0YwCKqPLda/JOth+KFnaOSkEJkmre7StQaDO9znjvcvkym8MMAl3
	BxqQrZxcmUA4rpBAXJ2QR3U=
X-Google-Smtp-Source: AGHT+IFCLedGH2j2W7/j5IcPYhhfMPDFclC6Dit1AhuZ7d1/ZQ9DKr3hN0MQPm7J8kkx12VBpnSoXw==
X-Received: by 2002:a05:6e02:3891:b0:35d:51c3:78b0 with SMTP id cn17-20020a056e02389100b0035d51c378b0mr2556366ilb.27.1705105758121;
        Fri, 12 Jan 2024 16:29:18 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902c1ca00b001d492055303sm3724175plc.279.2024.01.12.16.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 16:29:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/9] workqueue: Factor out pwq_is_empty()
Date: Fri, 12 Jan 2024 14:28:46 -1000
Message-ID: <20240113002911.406791-3-tj@kernel.org>
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

"!pwq->nr_active && list_empty(&pwq->inactive_works)" test is repeated
multiple times. Let's factor it out into pwq_is_empty().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8bf1d143e911..09f0ec086726 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1456,6 +1456,11 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
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
@@ -3325,7 +3330,7 @@ void drain_workqueue(struct workqueue_struct *wq)
 		bool drained;
 
 		raw_spin_lock_irq(&pwq->pool->lock);
-		drained = !pwq->nr_active && list_empty(&pwq->inactive_works);
+		drained = pwq_is_empty(pwq);
 		raw_spin_unlock_irq(&pwq->pool->lock);
 
 		if (drained)
@@ -4768,7 +4773,7 @@ static bool pwq_busy(struct pool_workqueue *pwq)
 
 	if ((pwq != pwq->wq->dfl_pwq) && (pwq->refcnt > 1))
 		return true;
-	if (pwq->nr_active || !list_empty(&pwq->inactive_works))
+	if (!pwq_is_empty(pwq))
 		return true;
 
 	return false;
@@ -5205,7 +5210,7 @@ void show_one_workqueue(struct workqueue_struct *wq)
 	unsigned long flags;
 
 	for_each_pwq(pwq, wq) {
-		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+		if (!pwq_is_empty(pwq)) {
 			idle = false;
 			break;
 		}
@@ -5217,7 +5222,7 @@ void show_one_workqueue(struct workqueue_struct *wq)
 
 	for_each_pwq(pwq, wq) {
 		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+		if (!pwq_is_empty(pwq)) {
 			/*
 			 * Defer printing to avoid deadlocks in console
 			 * drivers that queue work while holding locks
-- 
2.43.0


