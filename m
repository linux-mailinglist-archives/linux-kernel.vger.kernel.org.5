Return-Path: <linux-kernel+bounces-111177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A26D8868C5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FEC288F32
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0598220B3D;
	Fri, 22 Mar 2024 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lNpO+KLo"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AFA1CA8F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098141; cv=none; b=GBNGEsoo3ZUh16qN63i02wGsgreL/Y1YU1guMKXA7J7XiFbpxX7rjiqHkS4XW8H2EpfBOuu/9x2hGGWOZxx87h/CVOSgN/yUjaLm1ZD3a0uSjJMvOGrFnJY851b5wa8s3Dw74ovjn1xf6dyo4xfjFGRpTbOlS97+Bvd+JoWMDSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098141; c=relaxed/simple;
	bh=E5xx8AkB9Uw1SS8lYXON8Luw5P4Ejh+PRnNPAv6XJ8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ozcoZX1GyHRueCKyqAjlxin/r7x5SJ/jZSfMEeS8NGWklzXIyD1vZS75CsRMZOKcxDZdKPelEsPpSo722+Af8r410PwvFx26OclJJQyPVDFX7HN+1yOq0e/CEExxH39OYBWzGn5vtQeBxiQbbJocmhVNdbJxuQfEF4GqiXGXBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lNpO+KLo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33edbc5932bso1049581f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711098137; x=1711702937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u5i9wDgrXUzVBoSu+pgmA4lE4ak8AYM/4b270iokrxM=;
        b=lNpO+KLotqumFr+XDt25CUOrdKsIJ0cOVbL3VSilJqg8srjydvPPNRLnBs/PL+d/q1
         aH0Jjjnm82E7EZhljDHX02W65vzCfbxs4/YZhm6489YLAbzPJ1mWJZbxhAMwt7u0zi2U
         z2AhxMo8uaKaTdtwGeG5bwtxVQzHBP94NfYY7NOAyflQ/Ti9Usgu9ypohnwbzQ5I+7ZR
         pnCLiAmlXk5p6dQ0ERYHNK2fQSLC/SiqyJszsUSKJeAbbJiidx4wxlfn4KYKTYl9ZiHS
         C8dWan3d5eNmbaxqHyvHXhqVeZ2uBCYB5fB7gAIHqHv9DBBH4vy/Eq/yjGsvuolG8n8K
         9gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711098137; x=1711702937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5i9wDgrXUzVBoSu+pgmA4lE4ak8AYM/4b270iokrxM=;
        b=h3e6bOH+IOHE6UL2hDORlyBtrV+xoIBhYK6ICjm+Q4mW8wn10PITKhXnFTGRoSvv7l
         ZI1MzpNhMzqQMijIGHcwOFEyEt0sWHkl2Krsa4ruSp09AhkXS9xUqoZGXklKDezQSCVE
         KdA5MDhoDDAKcjwgzOYwc/ymfQY4QKqIU9J18LfYkC/I/6z6lduTLumo9+VPgSWt0ODh
         d6U9ofmI6ddwcTz4hL9r+/t3Wu4zbySUl38JmT6kuOVfJ07JDs/otfwSA3IpyynS0Rvl
         AhBSp4quWSrRt16qdkYCQRGNOvSMqVWljxAJk1ZkQnWeeZWRBbo+Oyi0R66vSvBc8rME
         HmoA==
X-Forwarded-Encrypted: i=1; AJvYcCW9etqn8dl5WlSB6Mb+D9FqDc4Ed3USE1s3M69r8c2waZi4rSqOLT9o/aNwvnAF+wdkRU6rzvFeH1WvrpRJMDrR2T1oy2hGs/TXP03q
X-Gm-Message-State: AOJu0YzY7NoJWnse04ln1hommY9tcmTXStMLkauL2c4vwxSvtZcDf7qG
	oYEjoVMiaqJC0LLTSlHp8JBpmcB9POTQDa7omEfurhSgcHNIFBwpwDR4gbU4izg=
X-Google-Smtp-Source: AGHT+IE023D1Iv1Q7ddO39alUcgMqmHs3YtMWYZlcQIZY7g4Y+ViW6U0ooyZR0olZKu+FKjXlEINRQ==
X-Received: by 2002:adf:e512:0:b0:341:80ee:22fe with SMTP id j18-20020adfe512000000b0034180ee22femr994077wrm.50.1711098136679;
        Fri, 22 Mar 2024 02:02:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:62f4:4d42:b3de:afa7])
        by smtp.gmail.com with ESMTPSA id bq3-20020a5d5a03000000b0033e9f6997c7sm1117144wrb.66.2024.03.22.02.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:02:16 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	stable@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] gpio: cdev: sanitize the label before requesting the interrupt
Date: Fri, 22 Mar 2024 10:02:08 +0100
Message-Id: <20240322090209.13384-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

When an interrupt is requested, a procfs directory is created under
"/proc/irq/<irqnum>/<label>" where <label> is the string passed to one of
the request_irq() variants.

What follows is that the string must not contain the "/" character or
the procfs mkdir operation will fail. We don't have such constraints for
GPIO consumer labels which are used verbatim as interrupt labels for
GPIO irqs. We must therefore sanitize the consumer string before
requesting the interrupt.

Let's replace all "/" with ":".

Cc: stable@vger.kernel.org
Reported-by: Stefan Wahren <wahrenst@gmx.net>
Closes: https://lore.kernel.org/linux-gpio/39fe95cb-aa83-4b8b-8cab-63947a726754@gmx.net/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- use ':' as the delimiter instead of '-'
- return -ENOMEM if creating the label fails

 drivers/gpio/gpiolib-cdev.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f384fa278764..7a102ebac428 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1083,10 +1083,20 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 	return 0;
 }
 
+static inline char *make_irq_label(const char *orig)
+{
+	return kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
+}
+
+static inline void free_irq_label(const char *label)
+{
+	kfree(label);
+}
+
 static void edge_detector_stop(struct line *line)
 {
 	if (line->irq) {
-		free_irq(line->irq, line);
+		free_irq_label(free_irq(line->irq, line));
 		line->irq = 0;
 	}
 
@@ -1110,6 +1120,7 @@ static int edge_detector_setup(struct line *line,
 	unsigned long irqflags = 0;
 	u64 eflags;
 	int irq, ret;
+	char *label;
 
 	eflags = edflags & GPIO_V2_LINE_EDGE_FLAGS;
 	if (eflags && !kfifo_initialized(&line->req->events)) {
@@ -1146,11 +1157,17 @@ static int edge_detector_setup(struct line *line,
 			IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
 	irqflags |= IRQF_ONESHOT;
 
+	label = make_irq_label(line->req->label);
+	if (!label)
+		return -ENOMEM;
+
 	/* Request a thread to read the events */
 	ret = request_threaded_irq(irq, edge_irq_handler, edge_irq_thread,
-				   irqflags, line->req->label, line);
-	if (ret)
+				   irqflags, label, line);
+	if (ret) {
+		free_irq_label(label);
 		return ret;
+	}
 
 	line->irq = irq;
 	return 0;
@@ -1973,7 +1990,7 @@ static void lineevent_free(struct lineevent_state *le)
 		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
 						   &le->device_unregistered_nb);
 	if (le->irq)
-		free_irq(le->irq, le);
+		free_irq_label(free_irq(le->irq, le));
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
@@ -2114,6 +2131,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	int fd;
 	int ret;
 	int irq, irqflags = 0;
+	char *label;
 
 	if (copy_from_user(&eventreq, ip, sizeof(eventreq)))
 		return -EFAULT;
@@ -2198,12 +2216,18 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	if (ret)
 		goto out_free_le;
 
+	label = make_irq_label(le->label);
+	if (!label) {
+		ret = -ENOMEM;
+		goto out_free_le;
+	}
+
 	/* Request a thread to read the events */
 	ret = request_threaded_irq(irq,
 				   lineevent_irq_handler,
 				   lineevent_irq_thread,
 				   irqflags,
-				   le->label,
+				   label,
 				   le);
 	if (ret)
 		goto out_free_le;
-- 
2.40.1


