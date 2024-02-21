Return-Path: <linux-kernel+bounces-75213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB0285E4CB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9311E286932
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4EE8527B;
	Wed, 21 Feb 2024 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bil1MwRf"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38B84A31
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537426; cv=none; b=k0vvAfJ8lTZZh4DiZKl8KhIdv4aid4rkQqRlRHamvGFh7a/LkcB3AbRzT5+kOooBjye8RwZP9aOCWPVeTMSDhESXajouGGP8iPCAlcBrcLJdhV5HU1sx+S2nf86Oq4MpJ2olYGPzSRiUCpkGnOzV2yoafuJFkxGzIjmL+syHwL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537426; c=relaxed/simple;
	bh=BNBjqX7rvO2nL76hA4F5JGtLYvI6neFoLoBb5g9OFPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBaKsuuVcGvklmHgsx21uKRFsDp+scZeYGegKqKS88aJ0GvHGwA3mxdFjeOVbFmrpBYK2QTfYAP0NS04M0ml8rVeg7UXnXrvTocO25hTxuoKmYksO+ePZu7mkwkM28+DsEQrWCYToouLOrPBI7IGU0+uzttwkDwQLYIdGEetcTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bil1MwRf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d93edfa76dso44582955ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708537423; x=1709142223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgXL/rlgnSxXHWfOCTE3l4Dg4Htkg3Doak5pgy6JQkU=;
        b=Bil1MwRfayAWB7jSBsIf5UdCS8KihJu9wl+xf7BvuQjm+xHpXQToNhJnxrGBYfoGu6
         e0ypo9Xd6MoP5DTMWqb7fcmFWlqX4DcppdcLNJTeQM3HdBnhP8QQvWq1rjzIvhBqDZyC
         X4dVukC7U6uu83R4z1gaGELnLHPXr8HCCgNxK0caipAWWrOW/kXpMZ1RNZwS8kQRbvi0
         IZj4mBmrhvLFighXWUaVk1L+27COiAD167D4ycBZ8x8p7Ag+6nEeN32MZLLw0xmGMlIr
         z3/MrXtSrX3Zb0koAn4O4jqWui5sW6ANNoYcNi/xoI3jSrfS+wf+hYymYBkTYm+lEsLq
         MnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537423; x=1709142223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HgXL/rlgnSxXHWfOCTE3l4Dg4Htkg3Doak5pgy6JQkU=;
        b=oF+jkh9sY7m3ic4PP/rqNxgdF23S7MZ37ZzSYc37X0IgA7nn06RNInfC1Kxr1SYKXL
         S13OHrV64cW0aVyp5uj2Zt5z1tKMGnAfCLzEBosMhby7jE/U9tOBekhOg9K3lS3khsRi
         Jh+Z5tRCiLG4gHklXi8sOPS5PqvnNPAuP+UgBwh70c3qnF6QpQfB7wKI1MdP6mUeXd+Y
         wXEpipDWPeiBW/7l4Da7izBA6icObOAroittf6wIk0gerE+ZE8jLaSHy/u+2Oe9t2jHF
         Vuwtt8DKNAD86tTdMQIqK6ijc3PL5I47oVFR4kGnEunGf4f5aKGfO8T/IDetJ5nKJGzD
         JWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+J6TwCx8iyeN34Xd23AfyQ9076zBUm8wwk+Xh5o2oTvtNtwTKl73w//lzNay24ctyhxgVQOfLFmBlIaUQLPiGoeSYY8g/3Ar4VMxU
X-Gm-Message-State: AOJu0YyI3w48BNkTEnIQ5XgXULl0bpLLwabdgpYs9gGgkNbaurtP8bXi
	acY/F+O5OGJQ9PRBG8kScTuhhstXbTUq9Qv4cypDXf0aTNrataTL
X-Google-Smtp-Source: AGHT+IExW6oifPoWeE1GRJRQYPEhcWhoGqeqKW6sY56fM8nk5RVyaEEIdcSCBeLAJVcoEWPxL5KDoQ==
X-Received: by 2002:a17:902:db06:b0:1db:8fd6:915e with SMTP id m6-20020a170902db0600b001db8fd6915emr5812223plx.33.1708537423387;
        Wed, 21 Feb 2024 09:43:43 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001db693d89fdsm8329315plt.179.2024.02.21.09.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:43:42 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/7] workqueue: Implement disable/enable for (delayed) work items
Date: Wed, 21 Feb 2024 07:43:00 -1000
Message-ID: <20240221174333.700197-3-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221174333.700197-1-tj@kernel.org>
References: <20240221174333.700197-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While (delayed) work items could be flushed and canceled, there was no way
to prevent them from being queued in the future. While this didn't lead to
functional deficiencies, it sometimes required a bit more effort from the
workqueue users to e.g. sequence shutdown steps with more care.

Workqueue is currently in the process of replacing tasklet which does
support disabling and enabling. The feature is used relatively widely to,
for example, temporarily suppress main path while a control plane operation
(reset or config change) is in progress.

To enable easy conversion of tasklet users and as it seems like an inherent
useful feature, this patch implements disabling and enabling of work items.

- A work item carries 16bit disable count in work->data while not queued.
  The access to the count is synchronized by the PENDING bit like all other
  parts of work->data.

- If the count is non-zero, the work item cannot be queued. Any attempt to
  queue the work item fails and returns %false.

- disable_work[_sync](), enable_work(), disable_delayed_work[_sync]() and
  enable_delayed_work() are added.

v2: Lai noticed that queue_work_node() wasn't checking the disable count.
    Fixed. queue_rcu_work() is updated to trigger warning if the inner work
    item is disabled.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 include/linux/workqueue.h |  18 +++-
 kernel/workqueue.c        | 177 +++++++++++++++++++++++++++++++++++---
 2 files changed, 182 insertions(+), 13 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index e15fc77bf2e2..f25915e47efb 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -51,20 +51,23 @@ enum work_bits {
 	 * data contains off-queue information when !WORK_STRUCT_PWQ.
 	 *
 	 * MSB
-	 * [ pool ID ] [ OFFQ flags ] [ STRUCT flags ]
-	 *                 1 bit        4 or 5 bits
+	 * [ pool ID ] [ disable depth ] [ OFFQ flags ] [ STRUCT flags ]
+	 *                  16 bits          1 bit        4 or 5 bits
 	 */
 	WORK_OFFQ_FLAG_SHIFT	= WORK_STRUCT_FLAG_BITS,
 	WORK_OFFQ_CANCELING_BIT = WORK_OFFQ_FLAG_SHIFT,
 	WORK_OFFQ_FLAG_END,
 	WORK_OFFQ_FLAG_BITS	= WORK_OFFQ_FLAG_END - WORK_OFFQ_FLAG_SHIFT,
 
+	WORK_OFFQ_DISABLE_SHIFT	= WORK_OFFQ_FLAG_SHIFT + WORK_OFFQ_FLAG_BITS,
+	WORK_OFFQ_DISABLE_BITS	= 16,
+
 	/*
 	 * When a work item is off queue, the high bits encode off-queue flags
 	 * and the last pool it was on. Cap pool ID to 31 bits and use the
 	 * highest number to indicate that no pool is associated.
 	 */
-	WORK_OFFQ_POOL_SHIFT	= WORK_OFFQ_FLAG_SHIFT + WORK_OFFQ_FLAG_BITS,
+	WORK_OFFQ_POOL_SHIFT	= WORK_OFFQ_DISABLE_SHIFT + WORK_OFFQ_DISABLE_BITS,
 	WORK_OFFQ_LEFT		= BITS_PER_LONG - WORK_OFFQ_POOL_SHIFT,
 	WORK_OFFQ_POOL_BITS	= WORK_OFFQ_LEFT <= 31 ? WORK_OFFQ_LEFT : 31,
 };
@@ -98,6 +101,7 @@ enum wq_misc_consts {
 /* Convenience constants - of type 'unsigned long', not 'enum'! */
 #define WORK_OFFQ_CANCELING	(1ul << WORK_OFFQ_CANCELING_BIT)
 #define WORK_OFFQ_FLAG_MASK	(((1ul << WORK_OFFQ_FLAG_BITS) - 1) << WORK_OFFQ_FLAG_SHIFT)
+#define WORK_OFFQ_DISABLE_MASK	(((1ul << WORK_OFFQ_DISABLE_BITS) - 1) << WORK_OFFQ_DISABLE_SHIFT)
 #define WORK_OFFQ_POOL_NONE	((1ul << WORK_OFFQ_POOL_BITS) - 1)
 #define WORK_STRUCT_NO_POOL	(WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT)
 #define WORK_STRUCT_PWQ_MASK	(~((1ul << WORK_STRUCT_PWQ_SHIFT) - 1))
@@ -556,6 +560,14 @@ extern bool flush_delayed_work(struct delayed_work *dwork);
 extern bool cancel_delayed_work(struct delayed_work *dwork);
 extern bool cancel_delayed_work_sync(struct delayed_work *dwork);
 
+extern bool disable_work(struct work_struct *work);
+extern bool disable_work_sync(struct work_struct *work);
+extern bool enable_work(struct work_struct *work);
+
+extern bool disable_delayed_work(struct delayed_work *dwork);
+extern bool disable_delayed_work_sync(struct delayed_work *dwork);
+extern bool enable_delayed_work(struct delayed_work *dwork);
+
 extern bool flush_rcu_work(struct rcu_work *rwork);
 
 extern void workqueue_set_max_active(struct workqueue_struct *wq,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 279be7d12e20..fc908958e54d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -98,6 +98,7 @@ enum worker_flags {
 
 enum work_cancel_flags {
 	WORK_CANCEL_DELAYED	= 1 << 0,	/* canceling a delayed_work */
+	WORK_CANCEL_DISABLE	= 1 << 1,	/* canceling to disable */
 };
 
 enum wq_internal_consts {
@@ -393,6 +394,7 @@ struct wq_pod_type {
 
 struct work_offq_data {
 	u32			pool_id;
+	u32			disable;
 	u32			flags;
 };
 
@@ -903,12 +905,15 @@ static void work_offqd_unpack(struct work_offq_data *offqd, unsigned long data)
 
 	offqd->pool_id = shift_and_mask(data, WORK_OFFQ_POOL_SHIFT,
 					WORK_OFFQ_POOL_BITS);
+	offqd->disable = shift_and_mask(data, WORK_OFFQ_DISABLE_SHIFT,
+					WORK_OFFQ_DISABLE_BITS);
 	offqd->flags = data & WORK_OFFQ_FLAG_MASK;
 }
 
 static unsigned long work_offqd_pack_flags(struct work_offq_data *offqd)
 {
-	return (unsigned long)offqd->flags;
+	return ((unsigned long)offqd->disable << WORK_OFFQ_DISABLE_SHIFT) |
+		((unsigned long)offqd->flags);
 }
 
 static bool work_is_canceling(struct work_struct *work)
@@ -2397,6 +2402,21 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	rcu_read_unlock();
 }
 
+static bool clear_pending_if_disabled(struct work_struct *work)
+{
+	unsigned long data = *work_data_bits(work);
+	struct work_offq_data offqd;
+
+	if (likely((data & WORK_STRUCT_PWQ) ||
+		   !(data & WORK_OFFQ_DISABLE_MASK)))
+		return false;
+
+	work_offqd_unpack(&offqd, data);
+	set_work_pool_and_clear_pending(work, offqd.pool_id,
+					work_offqd_pack_flags(&offqd));
+	return true;
+}
+
 /**
  * queue_work_on - queue work on specific cpu
  * @cpu: CPU number to execute work on
@@ -2419,7 +2439,8 @@ bool queue_work_on(int cpu, struct workqueue_struct *wq,
 
 	local_irq_save(irq_flags);
 
-	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
+	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)) &&
+	    !clear_pending_if_disabled(work)) {
 		__queue_work(cpu, wq, work);
 		ret = true;
 	}
@@ -2497,7 +2518,8 @@ bool queue_work_node(int node, struct workqueue_struct *wq,
 
 	local_irq_save(irq_flags);
 
-	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
+	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)) &&
+	    !clear_pending_if_disabled(work)) {
 		int cpu = select_numa_node_cpu(node);
 
 		__queue_work(cpu, wq, work);
@@ -2579,7 +2601,8 @@ bool queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 	/* read the comment in __queue_work() */
 	local_irq_save(irq_flags);
 
-	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
+	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)) &&
+	    !clear_pending_if_disabled(work)) {
 		__queue_delayed_work(cpu, wq, dwork, delay);
 		ret = true;
 	}
@@ -2652,7 +2675,12 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
 {
 	struct work_struct *work = &rwork->work;
 
-	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
+	/*
+	 * rcu_work can't be canceled or disabled. Warn if the user reached
+	 * inside @rwork and disabled the inner work.
+	 */
+	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)) &&
+	    !WARN_ON_ONCE(clear_pending_if_disabled(work))) {
 		rwork->wq = wq;
 		call_rcu_hurry(&rwork->rcu, rcu_work_rcufn);
 		return true;
@@ -4175,20 +4203,46 @@ bool flush_rcu_work(struct rcu_work *rwork)
 }
 EXPORT_SYMBOL(flush_rcu_work);
 
+static void work_offqd_disable(struct work_offq_data *offqd)
+{
+	const unsigned long max = (1lu << WORK_OFFQ_DISABLE_BITS) - 1;
+
+	if (likely(offqd->disable < max))
+		offqd->disable++;
+	else
+		WARN_ONCE(true, "workqueue: work disable count overflowed\n");
+}
+
+static void work_offqd_enable(struct work_offq_data *offqd)
+{
+	if (likely(offqd->disable > 0))
+		offqd->disable--;
+	else
+		WARN_ONCE(true, "workqueue: work disable count underflowed\n");
+}
+
 static bool __cancel_work(struct work_struct *work, u32 cflags)
 {
 	struct work_offq_data offqd;
 	unsigned long irq_flags;
 	int ret;
 
-	do {
-		ret = try_to_grab_pending(work, cflags, &irq_flags);
-	} while (unlikely(ret == -EAGAIN));
+	if (cflags & WORK_CANCEL_DISABLE) {
+		ret = work_grab_pending(work, cflags, &irq_flags);
+	} else {
+		do {
+			ret = try_to_grab_pending(work, cflags, &irq_flags);
+		} while (unlikely(ret == -EAGAIN));
 
-	if (unlikely(ret < 0))
-		return false;
+		if (unlikely(ret < 0))
+			return false;
+	}
 
 	work_offqd_unpack(&offqd, *work_data_bits(work));
+
+	if (cflags & WORK_CANCEL_DISABLE)
+		work_offqd_disable(&offqd);
+
 	set_work_pool_and_clear_pending(work, offqd.pool_id,
 					work_offqd_pack_flags(&offqd));
 	local_irq_restore(irq_flags);
@@ -4205,6 +4259,10 @@ static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
 	ret = work_grab_pending(work, cflags, &irq_flags);
 
 	work_offqd_unpack(&offqd, *work_data_bits(work));
+
+	if (cflags & WORK_CANCEL_DISABLE)
+		work_offqd_disable(&offqd);
+
 	offqd.flags |= WORK_OFFQ_CANCELING;
 	set_work_pool_and_keep_pending(work, offqd.pool_id,
 				       work_offqd_pack_flags(&offqd));
@@ -4304,6 +4362,105 @@ bool cancel_delayed_work_sync(struct delayed_work *dwork)
 }
 EXPORT_SYMBOL(cancel_delayed_work_sync);
 
+/**
+ * disable_work - Disable and cancel a work item
+ * @work: work item to disable
+ *
+ * Disable @work by incrementing its disable count and cancel it if currently
+ * pending. As long as the disable count is non-zero, any attempt to queue @work
+ * will fail and return %false. The maximum supported disable depth is 2 to the
+ * power of %WORK_OFFQ_DISABLE_BITS, currently 65536.
+ *
+ * Must be called from a sleepable context. Returns %true if @work was pending,
+ * %false otherwise.
+ */
+bool disable_work(struct work_struct *work)
+{
+	return __cancel_work(work, WORK_CANCEL_DISABLE);
+}
+EXPORT_SYMBOL_GPL(disable_work);
+
+/**
+ * disable_work_sync - Disable, cancel and drain a work item
+ * @work: work item to disable
+ *
+ * Similar to disable_work() but also wait for @work to finish if currently
+ * executing.
+ *
+ * Must be called from a sleepable context. Returns %true if @work was pending,
+ * %false otherwise.
+ */
+bool disable_work_sync(struct work_struct *work)
+{
+	return __cancel_work_sync(work, WORK_CANCEL_DISABLE);
+}
+EXPORT_SYMBOL_GPL(disable_work_sync);
+
+/**
+ * enable_work - Enable a work item
+ * @work: work item to enable
+ *
+ * Undo disable_work[_sync]() by decrementing @work's disable count. @work can
+ * only be queued if its disable count is 0.
+ *
+ * Must be called from a sleepable context. Returns %true if the disable count
+ * reached 0. Otherwise, %false.
+ */
+bool enable_work(struct work_struct *work)
+{
+	struct work_offq_data offqd;
+	unsigned long irq_flags;
+
+	work_grab_pending(work, 0, &irq_flags);
+
+	work_offqd_unpack(&offqd, *work_data_bits(work));
+	work_offqd_enable(&offqd);
+	set_work_pool_and_clear_pending(work, offqd.pool_id,
+					work_offqd_pack_flags(&offqd));
+	local_irq_enable();
+
+	return !offqd.disable;
+}
+EXPORT_SYMBOL_GPL(enable_work);
+
+/**
+ * disable_delayed_work - Disable and cancel a delayed work item
+ * @dwork: delayed work item to disable
+ *
+ * disable_work() for delayed work items.
+ */
+bool disable_delayed_work(struct delayed_work *dwork)
+{
+	return __cancel_work(&dwork->work,
+			     WORK_CANCEL_DELAYED | WORK_CANCEL_DISABLE);
+}
+EXPORT_SYMBOL_GPL(disable_delayed_work);
+
+/**
+ * disable_delayed_work_sync - Disable, cancel and drain a delayed work item
+ * @dwork: delayed work item to disable
+ *
+ * disable_work_sync() for delayed work items.
+ */
+bool disable_delayed_work_sync(struct delayed_work *dwork)
+{
+	return __cancel_work_sync(&dwork->work,
+				  WORK_CANCEL_DELAYED | WORK_CANCEL_DISABLE);
+}
+EXPORT_SYMBOL_GPL(disable_delayed_work_sync);
+
+/**
+ * enable_delayed_work - Enable a delayed work item
+ * @dwork: delayed work item to enable
+ *
+ * enable_work() for delayed work items.
+ */
+bool enable_delayed_work(struct delayed_work *dwork)
+{
+	return enable_work(&dwork->work);
+}
+EXPORT_SYMBOL_GPL(enable_delayed_work);
+
 /**
  * schedule_on_each_cpu - execute a function synchronously on each online CPU
  * @func: the function to call
-- 
2.43.2


