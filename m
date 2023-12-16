Return-Path: <linux-kernel+bounces-1860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD028154E6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897D1B2283D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FABE654;
	Sat, 16 Dec 2023 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNJ6Xl5t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72187E;
	Sat, 16 Dec 2023 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d9d209c9bbso1067849a34.0;
        Fri, 15 Dec 2023 16:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702685831; x=1703290631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTxELzBwupC8Xz+32EFInaDy3vYRWVZIbpGqotXqvaA=;
        b=cNJ6Xl5tDMMMycN6t++A5HNZx2huslZClv3Hq3KTwfII62ADTGVkWmtmCuLqlT4eva
         QRpRPNetpOHcsoFsyunBF1Z1Tv8hP0jSD7O129VxnDvL9h/vskwf+PJBUglItxzi40ir
         rhwIQmX9jgb+DhcDxyoMec5wm7/tppaGGYHq9hBa/K2v3f2aR5RaJuh6TEA/0c8y5KpP
         fa7yma7jCPUrPmfrpQzUvDVt8fqtE9Tx4W4T/N5So/PXH50aRiLM4akcaL/wsh/EdQsQ
         7FkvBUV2Tfn5hhrupuPrmxMTBzLKA/vXWIBkw4Eb+bkHuzo3odHLD47xJk4EYDyEpCO2
         YAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702685831; x=1703290631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTxELzBwupC8Xz+32EFInaDy3vYRWVZIbpGqotXqvaA=;
        b=wEEbmxin+5kVBZNo+H9bNsUCDy1I/w+8KSm89AqynkbcNtr6fP3yoWp6fjKurrSocJ
         7MvsO+dvASFqo3Hg7MpzNZgDJqSXxoShsxCityWsE+1E8X3tiPBIfjCRySKBBa70V/1M
         aywj4BivR/jTYUIjkuMVpSJksqVZaEtwVdyqRLjMEnxiKPttI3QZt6p5MwDH7Qc7lomB
         aNFOle61DWGW9yUtcXgmkATCIv4GuRAaIo/NcZHcXeKeiAQxmbh5ttuPQDx/5VqV5SId
         hLfnuLJI5nAytXyuh8rEQNP81yx1bkHUR0IkQs03T+eQqkhmzOtUcM0yejYA9d5rRdu4
         BouA==
X-Gm-Message-State: AOJu0Ywv+547eXfqn26p1533omNQf/jyadTgDanlzzkpPE3EoyzTClwn
	FkxLtKkHqzX8Atwxgx75DUym77qM51I=
X-Google-Smtp-Source: AGHT+IEi6zKKvaYacGgV8Cs2ETmu5ZZZ8ce361Xvca0GAlbFjA+EQ5qlniJm3FgqCGFB4FZapiP51g==
X-Received: by 2002:a9d:76d7:0:b0:6d9:d36a:8cc0 with SMTP id p23-20020a9d76d7000000b006d9d36a8cc0mr11881486otl.28.1702685831493;
        Fri, 15 Dec 2023 16:17:11 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id ei39-20020a056a0080e700b006cbef269712sm14176124pfb.9.2023.12.15.16.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:17:11 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v4 1/5] gpiolib: cdev: relocate debounce_period_us from struct gpio_desc
Date: Sat, 16 Dec 2023 08:16:48 +0800
Message-Id: <20231216001652.56276-2-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231216001652.56276-1-warthog618@gmail.com>
References: <20231216001652.56276-1-warthog618@gmail.com>
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
 drivers/gpio/gpiolib-cdev.c | 154 ++++++++++++++++++++++++++++++------
 1 file changed, 132 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 02ffda6c1e51..47197f6339c4 100644
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
+ * line_is_supplemental().
+ */
+static struct rb_root supinfo_tree = RB_ROOT;
+/* covers supinfo_tree */
+static DEFINE_SPINLOCK(supinfo_lock);
+
 /**
  * struct linereq - contains the state of a userspace line request
  * @gdev: the GPIO device the line request pertains to
@@ -575,6 +600,95 @@ struct linereq {
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
+static inline bool line_is_supplemental(struct line *line)
+{
+	return READ_ONCE(line->debounce_period_us);
+}
+
+static void line_set_debounce_period(struct line *line,
+				     unsigned int debounce_period_us)
+{
+	bool was_suppl = line_is_supplemental(line);
+
+	WRITE_ONCE(line->debounce_period_us, debounce_period_us);
+
+	if (line_is_supplemental(line) == was_suppl)
+		return;
+
+	if (was_suppl)
+		supinfo_erase(line);
+	else
+		supinfo_insert(line);
+}
+
 #define GPIO_V2_LINE_BIAS_FLAGS \
 	(GPIO_V2_LINE_FLAG_BIAS_PULL_UP | \
 	 GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN | \
@@ -723,7 +837,7 @@ static enum hte_return process_hw_ts(struct hte_ts_data *ts, void *p)
 		line->total_discard_seq++;
 		line->last_seqno = ts->seq;
 		mod_delayed_work(system_wq, &line->work,
-		  usecs_to_jiffies(READ_ONCE(line->desc->debounce_period_us)));
+		  usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
 	} else {
 		if (unlikely(ts->seq < line->line_seqno))
 			return HTE_CB_HANDLED;
@@ -864,7 +978,7 @@ static irqreturn_t debounce_irq_handler(int irq, void *p)
 	struct line *line = p;
 
 	mod_delayed_work(system_wq, &line->work,
-		usecs_to_jiffies(READ_ONCE(line->desc->debounce_period_us)));
+		usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
 
 	return IRQ_HANDLED;
 }
@@ -946,7 +1060,7 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 	/* try hardware */
 	ret = gpiod_set_debounce(line->desc, debounce_period_us);
 	if (!ret) {
-		WRITE_ONCE(line->desc->debounce_period_us, debounce_period_us);
+		line_set_debounce_period(line, debounce_period_us);
 		return ret;
 	}
 	if (ret != -ENOTSUPP)
@@ -1025,8 +1139,7 @@ static void edge_detector_stop(struct line *line)
 	cancel_delayed_work_sync(&line->work);
 	WRITE_ONCE(line->sw_debounced, 0);
 	WRITE_ONCE(line->edflags, 0);
-	if (line->desc)
-		WRITE_ONCE(line->desc->debounce_period_us, 0);
+	line_set_debounce_period(line, 0);
 	/* do not change line->level - see comment in debounced_value() */
 }
 
@@ -1051,7 +1164,7 @@ static int edge_detector_setup(struct line *line,
 		ret = debounce_setup(line, debounce_period_us);
 		if (ret)
 			return ret;
-		WRITE_ONCE(line->desc->debounce_period_us, debounce_period_us);
+		line_set_debounce_period(line, debounce_period_us);
 	}
 
 	/* detection disabled or sw debouncer will provide edge detection */
@@ -1093,12 +1206,12 @@ static int edge_detector_update(struct line *line,
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
 
@@ -1573,6 +1686,7 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 
 static void linereq_free(struct linereq *lr)
 {
+	struct line *line;
 	unsigned int i;
 
 	if (lr->device_unregistered_nb.notifier_call)
@@ -1580,10 +1694,14 @@ static void linereq_free(struct linereq *lr)
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
+		if (line_is_supplemental(line))
+			supinfo_erase(line);
+		gpiod_free(line->desc);
 	}
 	kfifo_free(&lr->events);
 	kfree(lr->label);
@@ -2274,8 +2392,6 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	struct gpio_chip *gc = desc->gdev->chip;
 	bool ok_for_pinctrl;
 	unsigned long flags;
-	u32 debounce_period_us;
-	unsigned int num_attrs = 0;
 
 	memset(info, 0, sizeof(*info));
 	info->offset = gpio_chip_hwgpio(desc);
@@ -2341,14 +2457,6 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
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
 
@@ -2455,6 +2563,7 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 			return -EBUSY;
 	}
 	gpio_desc_to_lineinfo(desc, &lineinfo);
+	supinfo_to_lineinfo(desc, &lineinfo);
 
 	if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
 		if (watch)
@@ -2545,6 +2654,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	chg.event_type = action;
 	chg.timestamp_ns = ktime_get_ns();
 	gpio_desc_to_lineinfo(desc, &chg.info);
+	supinfo_to_lineinfo(desc, &chg.info);
 
 	ret = kfifo_in_spinlocked(&cdev->events, &chg, 1, &cdev->wait.lock);
 	if (ret)
-- 
2.39.2


