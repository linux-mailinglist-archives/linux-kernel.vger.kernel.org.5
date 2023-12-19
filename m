Return-Path: <linux-kernel+bounces-4530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83390817EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5B71F246ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E4D15C4;
	Tue, 19 Dec 2023 00:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MML3A02N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988304401;
	Tue, 19 Dec 2023 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3ba2dc0f6b7so3205529b6e.2;
        Mon, 18 Dec 2023 16:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702946541; x=1703551341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ooghgr1fDqWLyt3pk3C0Om5Ff7dsrvFZTqH38TTdAWY=;
        b=MML3A02NBDC6GhcoSB+8kFp5rAUjEPVEKVPWJnGbT+OTMIQHfg+vPbva+5AOqXg/vW
         kaXGMGT5DKaEoU/xgag7xFzCilz4RTB/WGKQaCLtINA7/Dyos/YRQyKBQh7cuY+PtV7G
         TPLytpj9L7/l4sKoDdzCp72bMn+nSqO3adPspolgGYd/xC1zkQlJ5fAFy51JMc7om7Xf
         qOdU2/8jM/7+xGLOBIuh3kBQyMjXpdPrHeuxw1dyv+0Qw1ZyMMXJ5xvqvnecshUhLD9b
         BClzmSzUzSdN0R3DL/AuIt+4+Uay/ZIc80B1xiB8ou3ZXN4MIztBoLYu5MDOfgJie2au
         d3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702946541; x=1703551341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ooghgr1fDqWLyt3pk3C0Om5Ff7dsrvFZTqH38TTdAWY=;
        b=YIl7W9mL6m9DFwAul4vCuSjddPoohKjNXEmEcVEa9VP1wOLT8PeB4J4vg1Eu9ZWKkA
         9NbnV+w34ddW6QPieboC47gDdkTvW+mwEPMUkYat/L5YLCZkq53g5AGAG7qM6SLPZ6xL
         gR4ysVLJOSStLQSnV2KlQ4zUmT3DiEr+F24WnKMGspOrpxbRZWaX7sySm1U7uy07LHtT
         0on9ViM3L967ycFIXkIGyPmQHO79tFDJ/+91U18ecj1+dRwM+d1TUfkRHLFizNOE4wOB
         VuCBgWmvkPWf93nKhGHc5o3WwD9LsjPLQMv/ebhTMcc0B3Pn5x7QHuxUzPZoaw2kdvac
         P8qQ==
X-Gm-Message-State: AOJu0YyAAyI4PHteQIoie0RNWqWY9VWP7v2d2o2BMwuFQvH266fzLcR9
	aaqZc4dK8Dbr3MyAvrXFGTC9p770W/o=
X-Google-Smtp-Source: AGHT+IE2rzWSaJV8iVUEPBeNgysnq2nHGDlobtfNCTI2CKGnfJlemmWKyNczygbARhdi6h8xvuE/RQ==
X-Received: by 2002:a05:6808:1443:b0:3b9:f151:776e with SMTP id x3-20020a056808144300b003b9f151776emr22600796oiv.10.1702946541392;
        Mon, 18 Dec 2023 16:42:21 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a3f0900b0028ae3b5dde9sm173484pjc.12.2023.12.18.16.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:42:21 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v5 1/5] gpiolib: cdev: relocate debounce_period_us from struct gpio_desc
Date: Tue, 19 Dec 2023 08:41:54 +0800
Message-Id: <20231219004158.12405-2-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219004158.12405-1-warthog618@gmail.com>
References: <20231219004158.12405-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the debounce period for a requested line locally, rather than in
the debounce_period_us field in the gpiolib struct gpio_desc.

Add a global tree of lines containing supplemental line information
to make the debounce period available to be reported by the
GPIO_V2_GET_LINEINFO_IOCTL and the line change notifier.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 165 +++++++++++++++++++++++++++++++-----
 1 file changed, 142 insertions(+), 23 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 02ffda6c1e51..aecc4241b6c8 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -5,6 +5,7 @@
 #include <linux/bitmap.h>
 #include <linux/build_bug.h>
 #include <linux/cdev.h>
+#include <linux/cleanup.h>
 #include <linux/compat.h>
 #include <linux/compiler.h>
 #include <linux/device.h>
@@ -21,6 +22,7 @@
 #include <linux/mutex.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/poll.h>
+#include <linux/rbtree.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/timekeeping.h>
@@ -461,6 +463,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 
 /**
  * struct line - contains the state of a requested line
+ * @node: to store the object in supinfo_tree if supplemental
  * @desc: the GPIO descriptor for this line.
  * @req: the corresponding line request
  * @irq: the interrupt triggered in response to events on this GPIO
@@ -473,6 +476,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
  * @line_seqno: the seqno for the current edge event in the sequence of
  * events for this line.
  * @work: the worker that implements software debouncing
+ * @debounce_period_us: the debounce period in microseconds
  * @sw_debounced: flag indicating if the software debouncer is active
  * @level: the current debounced physical level of the line
  * @hdesc: the Hardware Timestamp Engine (HTE) descriptor
@@ -481,6 +485,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
  * @last_seqno: the last sequence number before debounce period expires
  */
 struct line {
+	struct rb_node node;
 	struct gpio_desc *desc;
 	/*
 	 * -- edge detector specific fields --
@@ -514,6 +519,15 @@ struct line {
 	 * -- debouncer specific fields --
 	 */
 	struct delayed_work work;
+	/*
+	 * debounce_period_us is accessed by debounce_irq_handler() and
+	 * process_hw_ts() which are disabled when modified by
+	 * debounce_setup(), edge_detector_setup() or edge_detector_stop()
+	 * or can live with a stale version when updated by
+	 * edge_detector_update().
+	 * The modifying functions are themselves mutually exclusive.
+	 */
+	unsigned int debounce_period_us;
 	/*
 	 * sw_debounce is accessed by linereq_set_config(), which is the
 	 * only setter, and linereq_get_values(), which can live with a
@@ -546,6 +560,17 @@ struct line {
 #endif /* CONFIG_HTE */
 };
 
+/*
+ * a rbtree of the struct lines containing supplemental info.
+ * Used to populate gpio_v2_line_info with cdev specific fields not contained
+ * in the struct gpio_desc.
+ * A line is determined to contain supplemental information by
+ * line_has_supinfo().
+ */
+static struct rb_root supinfo_tree = RB_ROOT;
+/* covers supinfo_tree */
+static DEFINE_SPINLOCK(supinfo_lock);
+
 /**
  * struct linereq - contains the state of a userspace line request
  * @gdev: the GPIO device the line request pertains to
@@ -559,7 +584,8 @@ struct line {
  * this line request.  Note that this is not used when @num_lines is 1, as
  * the line_seqno is then the same and is cheaper to calculate.
  * @config_mutex: mutex for serializing ioctl() calls to ensure consistency
- * of configuration, particularly multi-step accesses to desc flags.
+ * of configuration, particularly multi-step accesses to desc flags and
+ * changes to supinfo status.
  * @lines: the lines held by this line request, with @num_lines elements.
  */
 struct linereq {
@@ -575,6 +601,103 @@ struct linereq {
 	struct line lines[] __counted_by(num_lines);
 };
 
+static void supinfo_insert(struct line *line)
+{
+	struct rb_node **new = &(supinfo_tree.rb_node), *parent = NULL;
+	struct line *entry;
+
+	guard(spinlock)(&supinfo_lock);
+
+	while (*new) {
+		entry = container_of(*new, struct line, node);
+
+		parent = *new;
+		if (line->desc < entry->desc) {
+			new = &((*new)->rb_left);
+		} else if (line->desc > entry->desc) {
+			new = &((*new)->rb_right);
+		} else {
+			/* this should never happen */
+			WARN(1, "duplicate line inserted");
+			return;
+		}
+	}
+
+	rb_link_node(&line->node, parent, new);
+	rb_insert_color(&line->node, &supinfo_tree);
+}
+
+static void supinfo_erase(struct line *line)
+{
+	guard(spinlock)(&supinfo_lock);
+
+	rb_erase(&line->node, &supinfo_tree);
+}
+
+static struct line *supinfo_find(struct gpio_desc *desc)
+{
+	struct rb_node *node = supinfo_tree.rb_node;
+	struct line *line;
+
+	while (node) {
+		line = container_of(node, struct line, node);
+		if (desc < line->desc)
+			node = node->rb_left;
+		else if (desc > line->desc)
+			node = node->rb_right;
+		else
+			return line;
+	}
+	return NULL;
+}
+
+static void supinfo_to_lineinfo(struct gpio_desc *desc,
+				struct gpio_v2_line_info *info)
+{
+	struct gpio_v2_line_attribute *attr;
+	struct line *line;
+
+	guard(spinlock)(&supinfo_lock);
+
+	line = supinfo_find(desc);
+	if (!line)
+		return;
+
+	attr = &info->attrs[info->num_attrs];
+	attr->id = GPIO_V2_LINE_ATTR_ID_DEBOUNCE;
+	attr->debounce_period_us = READ_ONCE(line->debounce_period_us);
+	info->num_attrs++;
+}
+
+static inline bool line_has_supinfo(struct line *line)
+{
+	return READ_ONCE(line->debounce_period_us);
+}
+
+/*
+ * Checks line_has_supinfo() before and after the change to avoid unnecessary
+ * supinfo_tree access.
+ * Called indirectly by linereq_create() or linereq_set_config() so line
+ * is already protected from concurrent changes.
+ */
+static void line_set_debounce_period(struct line *line,
+				     unsigned int debounce_period_us)
+{
+	bool was_suppl = line_has_supinfo(line);
+
+	WRITE_ONCE(line->debounce_period_us, debounce_period_us);
+
+	/* if supinfo status is unchanged then we're done */
+	if (line_has_supinfo(line) == was_suppl)
+		return;
+
+	/* supinfo status has changed, so update the tree */
+	if (was_suppl)
+		supinfo_erase(line);
+	else
+		supinfo_insert(line);
+}
+
 #define GPIO_V2_LINE_BIAS_FLAGS \
 	(GPIO_V2_LINE_FLAG_BIAS_PULL_UP | \
 	 GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN | \
@@ -723,7 +846,7 @@ static enum hte_return process_hw_ts(struct hte_ts_data *ts, void *p)
 		line->total_discard_seq++;
 		line->last_seqno = ts->seq;
 		mod_delayed_work(system_wq, &line->work,
-		  usecs_to_jiffies(READ_ONCE(line->desc->debounce_period_us)));
+		  usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
 	} else {
 		if (unlikely(ts->seq < line->line_seqno))
 			return HTE_CB_HANDLED;
@@ -864,7 +987,7 @@ static irqreturn_t debounce_irq_handler(int irq, void *p)
 	struct line *line = p;
 
 	mod_delayed_work(system_wq, &line->work,
-		usecs_to_jiffies(READ_ONCE(line->desc->debounce_period_us)));
+		usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
 
 	return IRQ_HANDLED;
 }
@@ -946,7 +1069,7 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 	/* try hardware */
 	ret = gpiod_set_debounce(line->desc, debounce_period_us);
 	if (!ret) {
-		WRITE_ONCE(line->desc->debounce_period_us, debounce_period_us);
+		line_set_debounce_period(line, debounce_period_us);
 		return ret;
 	}
 	if (ret != -ENOTSUPP)
@@ -1025,8 +1148,7 @@ static void edge_detector_stop(struct line *line)
 	cancel_delayed_work_sync(&line->work);
 	WRITE_ONCE(line->sw_debounced, 0);
 	WRITE_ONCE(line->edflags, 0);
-	if (line->desc)
-		WRITE_ONCE(line->desc->debounce_period_us, 0);
+	line_set_debounce_period(line, 0);
 	/* do not change line->level - see comment in debounced_value() */
 }
 
@@ -1051,7 +1173,7 @@ static int edge_detector_setup(struct line *line,
 		ret = debounce_setup(line, debounce_period_us);
 		if (ret)
 			return ret;
-		WRITE_ONCE(line->desc->debounce_period_us, debounce_period_us);
+		line_set_debounce_period(line, debounce_period_us);
 	}
 
 	/* detection disabled or sw debouncer will provide edge detection */
@@ -1093,12 +1215,12 @@ static int edge_detector_update(struct line *line,
 			gpio_v2_line_config_debounce_period(lc, line_idx);
 
 	if ((active_edflags == edflags) &&
-	    (READ_ONCE(line->desc->debounce_period_us) == debounce_period_us))
+	    (READ_ONCE(line->debounce_period_us) == debounce_period_us))
 		return 0;
 
 	/* sw debounced and still will be...*/
 	if (debounce_period_us && READ_ONCE(line->sw_debounced)) {
-		WRITE_ONCE(line->desc->debounce_period_us, debounce_period_us);
+		line_set_debounce_period(line, debounce_period_us);
 		return 0;
 	}
 
@@ -1573,6 +1695,7 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 
 static void linereq_free(struct linereq *lr)
 {
+	struct line *line;
 	unsigned int i;
 
 	if (lr->device_unregistered_nb.notifier_call)
@@ -1580,10 +1703,14 @@ static void linereq_free(struct linereq *lr)
 						   &lr->device_unregistered_nb);
 
 	for (i = 0; i < lr->num_lines; i++) {
-		if (lr->lines[i].desc) {
-			edge_detector_stop(&lr->lines[i]);
-			gpiod_free(lr->lines[i].desc);
-		}
+		line = &lr->lines[i];
+		if (!line->desc)
+			continue;
+
+		edge_detector_stop(line);
+		if (line_has_supinfo(line))
+			supinfo_erase(line);
+		gpiod_free(line->desc);
 	}
 	kfifo_free(&lr->events);
 	kfree(lr->label);
@@ -2274,8 +2401,6 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	struct gpio_chip *gc = desc->gdev->chip;
 	bool ok_for_pinctrl;
 	unsigned long flags;
-	u32 debounce_period_us;
-	unsigned int num_attrs = 0;
 
 	memset(info, 0, sizeof(*info));
 	info->offset = gpio_chip_hwgpio(desc);
@@ -2341,14 +2466,6 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	else if (test_bit(FLAG_EVENT_CLOCK_HTE, &desc->flags))
 		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE;
 
-	debounce_period_us = READ_ONCE(desc->debounce_period_us);
-	if (debounce_period_us) {
-		info->attrs[num_attrs].id = GPIO_V2_LINE_ATTR_ID_DEBOUNCE;
-		info->attrs[num_attrs].debounce_period_us = debounce_period_us;
-		num_attrs++;
-	}
-	info->num_attrs = num_attrs;
-
 	spin_unlock_irqrestore(&gpio_lock, flags);
 }
 
@@ -2455,6 +2572,7 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 			return -EBUSY;
 	}
 	gpio_desc_to_lineinfo(desc, &lineinfo);
+	supinfo_to_lineinfo(desc, &lineinfo);
 
 	if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
 		if (watch)
@@ -2545,6 +2663,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	chg.event_type = action;
 	chg.timestamp_ns = ktime_get_ns();
 	gpio_desc_to_lineinfo(desc, &chg.info);
+	supinfo_to_lineinfo(desc, &chg.info);
 
 	ret = kfifo_in_spinlocked(&cdev->events, &chg, 1, &cdev->wait.lock);
 	if (ret)
-- 
2.39.2


