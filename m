Return-Path: <linux-kernel+bounces-6270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7525F819692
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D71A288B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2E1883C;
	Wed, 20 Dec 2023 01:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHOx7Wc4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4A1401F;
	Wed, 20 Dec 2023 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35f519f3ea9so23483325ab.3;
        Tue, 19 Dec 2023 17:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703037131; x=1703641931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y9g7c+vuEkFBYBNDHkeNbZIyU4v51PaB2WVpgjrMac=;
        b=kHOx7Wc4j0VJnI/QyJ8DLOySMk6QJSzTB/TWw4AW0f5Ld/r7YXjpYk2vpptXjofGFD
         m6jQzt5sOiLJpX7eULgn96ozNL6OaLG5+fwwU+f5O4c4/OHzv++h4YMHw6oDskXpVkMa
         /bidtSG5I6sjHQKTdFEMhFwBbc+YDgkUBOZVn0OcEboLcN2lCIBUbKwuSTjC6iuVaNt/
         n8jG+Kn3E2+TNNtmuP6CejX6md+7hWb/kBLWZQx0ZPL855iaBstjE8VSUwE7MviT2eJA
         cIl6FZdPD/nomD3eAdNtApJcrrCnd1IfdUA0WqmHLyX5wlIoWLNHu8Q7JmSOXBx0iZR3
         H/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703037131; x=1703641931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Y9g7c+vuEkFBYBNDHkeNbZIyU4v51PaB2WVpgjrMac=;
        b=iMFusXCjdv/q8g70uIAdcQj2+ZZegUHKi5o/ycMDVtfveAFoIgZIcKyGFvSxn0b6kn
         rbCYh4GGSUbfEcQh7q/RaNmpvX9XjDBZgktMvjT6yOxoIX9qoZSbyvB6hKbr/geSSzoR
         BCD+GodN9D0y3zhzKJhbHc20oxRRmyVKDSEdShwRmjNbGF4mr4soSXLly1z1xzc8i3wi
         MTBgl7GdVCOVSrrmM2U7Iem+K8aRTzw6XzEvZX6W41t+MbDu04rGK2hK2d0Sf9w5YBhW
         bvhH2b3EynSZ9+Jr3EOySNVxq2C3Wfq19svU/rs0D+XhJZ/PaXYkeMqqGDYy2oSy0vUb
         qK/g==
X-Gm-Message-State: AOJu0YxCs7Wp+k9keOpJ8vRohpUUs3Y9iBXJKaYUZD90RP//vAXfcywk
	zPSYzpA0DIVzytwH9WT73ZfwU7dFZHA=
X-Google-Smtp-Source: AGHT+IFzrJwtCyqYapTBFPRdx+Ll2pTmHpjpIWEhw8WJ5H+95UFj1rovoefo650NwPpAy2Tfgc3r4g==
X-Received: by 2002:a92:ca4a:0:b0:35c:e547:d759 with SMTP id q10-20020a92ca4a000000b0035ce547d759mr20146233ilo.12.1703037130920;
        Tue, 19 Dec 2023 17:52:10 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id c17-20020a631c51000000b005b92e60cf57sm20133208pgm.56.2023.12.19.17.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 17:52:10 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 4/4] gpiolib: cdev: replace locking wrappers for gpio_device with guards
Date: Wed, 20 Dec 2023 09:51:06 +0800
Message-Id: <20231220015106.16732-5-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220015106.16732-1-warthog618@gmail.com>
References: <20231220015106.16732-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the wrapping functions that inhibit removal of the gpio_device
with equivalent guard macros.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 195 ++++++++++--------------------------
 1 file changed, 52 insertions(+), 143 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 5b07578e3bfa..77ecf308ef39 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -65,44 +65,20 @@ typedef long (*ioctl_fn)(struct file *, unsigned int, unsigned long);
 typedef ssize_t (*read_fn)(struct file *, char __user *,
 			   size_t count, loff_t *);
 
-static __poll_t call_poll_locked(struct file *file,
-				 struct poll_table_struct *wait,
-				 struct gpio_device *gdev, poll_fn func)
-{
-	__poll_t ret;
-
-	down_read(&gdev->sem);
-	ret = func(file, wait);
-	up_read(&gdev->sem);
-
-	return ret;
-}
-
-static long call_ioctl_locked(struct file *file, unsigned int cmd,
-			      unsigned long arg, struct gpio_device *gdev,
-			      ioctl_fn func)
-{
-	long ret;
+DEFINE_CLASS(_read_sem_guard,
+	     struct rw_semaphore *,
+	     up_read(_T),
+	     ({
+		down_read(sem);
+		sem;
+	     }),
+	     struct rw_semaphore *sem);
 
-	down_read(&gdev->sem);
-	ret = func(file, cmd, arg);
-	up_read(&gdev->sem);
+/* guard that downs a rw_semaphore while in scope */
+#define read_sem_guard(sem) CLASS(_read_sem_guard, _sem)(sem)
 
-	return ret;
-}
-
-static ssize_t call_read_locked(struct file *file, char __user *buf,
-				size_t count, loff_t *f_ps,
-				struct gpio_device *gdev, read_fn func)
-{
-	ssize_t ret;
-
-	down_read(&gdev->sem);
-	ret = func(file, buf, count, f_ps);
-	up_read(&gdev->sem);
-
-	return ret;
-}
+/* guard on the gpio_device sem to inhibit device removal while in use */
+#define gdev_guard(gdev) read_sem_guard(gdev->sem)
 
 /*
  * GPIO line handle management
@@ -238,8 +214,8 @@ static long linehandle_set_config(struct linehandle_state *lh,
 	return 0;
 }
 
-static long linehandle_ioctl_unlocked(struct file *file, unsigned int cmd,
-				      unsigned long arg)
+static long linehandle_ioctl(struct file *file, unsigned int cmd,
+			     unsigned long arg)
 {
 	struct linehandle_state *lh = file->private_data;
 	void __user *ip = (void __user *)arg;
@@ -248,6 +224,8 @@ static long linehandle_ioctl_unlocked(struct file *file, unsigned int cmd,
 	unsigned int i;
 	int ret;
 
+	gdev_guard(&lh->gdev);
+
 	if (!lh->gdev->chip)
 		return -ENODEV;
 
@@ -297,15 +275,6 @@ static long linehandle_ioctl_unlocked(struct file *file, unsigned int cmd,
 	}
 }
 
-static long linehandle_ioctl(struct file *file, unsigned int cmd,
-			     unsigned long arg)
-{
-	struct linehandle_state *lh = file->private_data;
-
-	return call_ioctl_locked(file, cmd, arg, lh->gdev,
-				 linehandle_ioctl_unlocked);
-}
-
 #ifdef CONFIG_COMPAT
 static long linehandle_ioctl_compat(struct file *file, unsigned int cmd,
 				    unsigned long arg)
@@ -1564,12 +1533,14 @@ static long linereq_set_config(struct linereq *lr, void __user *ip)
 	return 0;
 }
 
-static long linereq_ioctl_unlocked(struct file *file, unsigned int cmd,
-				   unsigned long arg)
+static long linereq_ioctl(struct file *file, unsigned int cmd,
+			  unsigned long arg)
 {
 	struct linereq *lr = file->private_data;
 	void __user *ip = (void __user *)arg;
 
+	gdev_guard(&lr->gdev);
+
 	if (!lr->gdev->chip)
 		return -ENODEV;
 
@@ -1585,15 +1556,6 @@ static long linereq_ioctl_unlocked(struct file *file, unsigned int cmd,
 	}
 }
 
-static long linereq_ioctl(struct file *file, unsigned int cmd,
-			  unsigned long arg)
-{
-	struct linereq *lr = file->private_data;
-
-	return call_ioctl_locked(file, cmd, arg, lr->gdev,
-				 linereq_ioctl_unlocked);
-}
-
 #ifdef CONFIG_COMPAT
 static long linereq_ioctl_compat(struct file *file, unsigned int cmd,
 				 unsigned long arg)
@@ -1602,12 +1564,14 @@ static long linereq_ioctl_compat(struct file *file, unsigned int cmd,
 }
 #endif
 
-static __poll_t linereq_poll_unlocked(struct file *file,
-				      struct poll_table_struct *wait)
+static __poll_t linereq_poll(struct file *file,
+			     struct poll_table_struct *wait)
 {
 	struct linereq *lr = file->private_data;
 	__poll_t events = 0;
 
+	gdev_guard(&lr->gdev);
+
 	if (!lr->gdev->chip)
 		return EPOLLHUP | EPOLLERR;
 
@@ -1620,22 +1584,16 @@ static __poll_t linereq_poll_unlocked(struct file *file,
 	return events;
 }
 
-static __poll_t linereq_poll(struct file *file,
-			     struct poll_table_struct *wait)
-{
-	struct linereq *lr = file->private_data;
-
-	return call_poll_locked(file, wait, lr->gdev, linereq_poll_unlocked);
-}
-
-static ssize_t linereq_read_unlocked(struct file *file, char __user *buf,
-				     size_t count, loff_t *f_ps)
+static ssize_t linereq_read(struct file *file, char __user *buf,
+			    size_t count, loff_t *f_ps)
 {
 	struct linereq *lr = file->private_data;
 	struct gpio_v2_line_event le;
 	ssize_t bytes_read = 0;
 	int ret;
 
+	gdev_guard(&lr->gdev);
+
 	if (!lr->gdev->chip)
 		return -ENODEV;
 
@@ -1677,15 +1635,6 @@ static ssize_t linereq_read_unlocked(struct file *file, char __user *buf,
 	return bytes_read;
 }
 
-static ssize_t linereq_read(struct file *file, char __user *buf,
-			    size_t count, loff_t *f_ps)
-{
-	struct linereq *lr = file->private_data;
-
-	return call_read_locked(file, buf, count, f_ps, lr->gdev,
-				linereq_read_unlocked);
-}
-
 static void linereq_free(struct linereq *lr)
 {
 	struct line *line;
@@ -1938,12 +1887,14 @@ struct lineevent_state {
 	(GPIOEVENT_REQUEST_RISING_EDGE | \
 	GPIOEVENT_REQUEST_FALLING_EDGE)
 
-static __poll_t lineevent_poll_unlocked(struct file *file,
-					struct poll_table_struct *wait)
+static __poll_t lineevent_poll(struct file *file,
+			       struct poll_table_struct *wait)
 {
 	struct lineevent_state *le = file->private_data;
 	__poll_t events = 0;
 
+	gdev_guard(&le->gdev);
+
 	if (!le->gdev->chip)
 		return EPOLLHUP | EPOLLERR;
 
@@ -1955,14 +1906,6 @@ static __poll_t lineevent_poll_unlocked(struct file *file,
 	return events;
 }
 
-static __poll_t lineevent_poll(struct file *file,
-			       struct poll_table_struct *wait)
-{
-	struct lineevent_state *le = file->private_data;
-
-	return call_poll_locked(file, wait, le->gdev, lineevent_poll_unlocked);
-}
-
 static int lineevent_unregistered_notify(struct notifier_block *nb,
 					 unsigned long action, void *data)
 {
@@ -1979,8 +1922,8 @@ struct compat_gpioeevent_data {
 	u32		id;
 };
 
-static ssize_t lineevent_read_unlocked(struct file *file, char __user *buf,
-				       size_t count, loff_t *f_ps)
+static ssize_t lineevent_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *f_ps)
 {
 	struct lineevent_state *le = file->private_data;
 	struct gpioevent_data ge;
@@ -1988,6 +1931,8 @@ static ssize_t lineevent_read_unlocked(struct file *file, char __user *buf,
 	ssize_t ge_size;
 	int ret;
 
+	gdev_guard(&le->gdev);
+
 	if (!le->gdev->chip)
 		return -ENODEV;
 
@@ -2042,15 +1987,6 @@ static ssize_t lineevent_read_unlocked(struct file *file, char __user *buf,
 	return bytes_read;
 }
 
-static ssize_t lineevent_read(struct file *file, char __user *buf,
-			      size_t count, loff_t *f_ps)
-{
-	struct lineevent_state *le = file->private_data;
-
-	return call_read_locked(file, buf, count, f_ps, le->gdev,
-				lineevent_read_unlocked);
-}
-
 static void lineevent_free(struct lineevent_state *le)
 {
 	if (le->device_unregistered_nb.notifier_call)
@@ -2071,13 +2007,15 @@ static int lineevent_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static long lineevent_ioctl_unlocked(struct file *file, unsigned int cmd,
-				     unsigned long arg)
+static long lineevent_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
 {
 	struct lineevent_state *le = file->private_data;
 	void __user *ip = (void __user *)arg;
 	struct gpiohandle_data ghd;
 
+	gdev_guard(&le->gdev);
+
 	if (!le->gdev->chip)
 		return -ENODEV;
 
@@ -2103,15 +2041,6 @@ static long lineevent_ioctl_unlocked(struct file *file, unsigned int cmd,
 	return -EINVAL;
 }
 
-static long lineevent_ioctl(struct file *file, unsigned int cmd,
-			    unsigned long arg)
-{
-	struct lineevent_state *le = file->private_data;
-
-	return call_ioctl_locked(file, cmd, arg, le->gdev,
-				 lineevent_ioctl_unlocked);
-}
-
 #ifdef CONFIG_COMPAT
 static long lineevent_ioctl_compat(struct file *file, unsigned int cmd,
 				   unsigned long arg)
@@ -2671,12 +2600,14 @@ static int gpio_device_unregistered_notify(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static __poll_t lineinfo_watch_poll_unlocked(struct file *file,
-					     struct poll_table_struct *pollt)
+static __poll_t lineinfo_watch_poll(struct file *file,
+				    struct poll_table_struct *pollt)
 {
 	struct gpio_chardev_data *cdev = file->private_data;
 	__poll_t events = 0;
 
+	gdev_guard(&cdev->gdev);
+
 	if (!cdev->gdev->chip)
 		return EPOLLHUP | EPOLLERR;
 
@@ -2689,17 +2620,8 @@ static __poll_t lineinfo_watch_poll_unlocked(struct file *file,
 	return events;
 }
 
-static __poll_t lineinfo_watch_poll(struct file *file,
-				    struct poll_table_struct *pollt)
-{
-	struct gpio_chardev_data *cdev = file->private_data;
-
-	return call_poll_locked(file, pollt, cdev->gdev,
-				lineinfo_watch_poll_unlocked);
-}
-
-static ssize_t lineinfo_watch_read_unlocked(struct file *file, char __user *buf,
-					    size_t count, loff_t *off)
+static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
+				   size_t count, loff_t *off)
 {
 	struct gpio_chardev_data *cdev = file->private_data;
 	struct gpio_v2_line_info_changed event;
@@ -2707,6 +2629,8 @@ static ssize_t lineinfo_watch_read_unlocked(struct file *file, char __user *buf,
 	int ret;
 	size_t event_size;
 
+	gdev_guard(&cdev->gdev);
+
 	if (!cdev->gdev->chip)
 		return -ENODEV;
 
@@ -2769,15 +2693,6 @@ static ssize_t lineinfo_watch_read_unlocked(struct file *file, char __user *buf,
 	return bytes_read;
 }
 
-static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
-				   size_t count, loff_t *off)
-{
-	struct gpio_chardev_data *cdev = file->private_data;
-
-	return call_read_locked(file, buf, count, off, cdev->gdev,
-				lineinfo_watch_read_unlocked);
-}
-
 /**
  * gpio_chrdev_open() - open the chardev for ioctl operations
  * @inode: inode for this chardev
@@ -2791,17 +2706,15 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	struct gpio_chardev_data *cdev;
 	int ret = -ENOMEM;
 
-	down_read(&gdev->sem);
+	gdev_guard(&gdev);
 
 	/* Fail on open if the backing gpiochip is gone */
-	if (!gdev->chip) {
-		ret = -ENODEV;
-		goto out_unlock;
-	}
+	if (!gdev->chip)
+		return -ENODEV;
 
 	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
-		goto out_unlock;
+		return -ENODEV;
 
 	cdev->watched_lines = bitmap_zalloc(gdev->chip->ngpio, GFP_KERNEL);
 	if (!cdev->watched_lines)
@@ -2830,8 +2743,6 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	if (ret)
 		goto out_unregister_device_notifier;
 
-	up_read(&gdev->sem);
-
 	return ret;
 
 out_unregister_device_notifier:
@@ -2845,8 +2756,6 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	bitmap_free(cdev->watched_lines);
 out_free_cdev:
 	kfree(cdev);
-out_unlock:
-	up_read(&gdev->sem);
 	return ret;
 }
 
-- 
2.39.2


