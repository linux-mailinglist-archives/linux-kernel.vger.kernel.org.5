Return-Path: <linux-kernel+bounces-164959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E638B8575
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D79B20D74
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6924D13B;
	Wed,  1 May 2024 05:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdGwT+qQ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796164AEFD
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 05:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714543108; cv=none; b=qhx9ubVrgzXocd45MZvNR88xgtB+ap8/Tk339KsdytAov6eq7bqBN/GXSEadm5JraZnuxwKt/fq4kJo2DulmU3x3wlNRgFKBtrbWHKBR8tCDUNFXH3zJ14E/O5868DyNDN6muuxMgXRydJhQXo9kutT9j1CSSKUe3NxLffbmkEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714543108; c=relaxed/simple;
	bh=4emfBwO96KYMsWU61oZODbzHhWhy6ZisdIAcmsCUOIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jK1ZTiw2Y6mDcRE5janKx+FSjPuHllQVEcaaVn5DLVDC3JW+slVNaC3QFHc+2uyMdYCW/ameodKFKbjp5vUoQ3wDlPeO4Q8lG8xb1ew+WRdUe4LESppaiuqUm4dASf6Z+ggUhMD2o21DzUdkEbxe0xVOegBCecpQp8Xh5O0j5CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdGwT+qQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41adf3580dbso2520835e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 22:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714543104; x=1715147904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/g+7qEBif8mPR7xqwnagP1WMzR/BT9n5J7+cl3F+70o=;
        b=HdGwT+qQsUTByQPehzN/lqM4c5WJfjVSBqCvxjVeflxg4EJxYH33b9ZZsfKQFNeMZ/
         gXdBcuO0/5ziza2HIJ9yj2q0DuT1jVEQ/sq1RWs1ZPrkd//osVGzPo2HHUd4X4kxh66n
         9GJ39qsguUk55YHgfT1cd+HPzFKe4BmX+Ja7Hl/dIbcmnwPsbKiG6ErFkCQ/QCviIe8w
         b9wQCv6ypfolDTgWDzSZn3IdqdJLDICXAYg3Q6APae380LgsGBQsJRJCoTW8ssBu2EAg
         HCUhHtlDocblUBFyjwVqcOh+uXHo5QwRB9fGza0jhGiX5ySOpg/gXGttYC2bPPQYGa0A
         bO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714543104; x=1715147904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g+7qEBif8mPR7xqwnagP1WMzR/BT9n5J7+cl3F+70o=;
        b=ApZXNpqeSSl8JUsRNRwcC6gOYRuT4u6hX3J/at3YjRGRnXibgDC0Hp7JOKf8O8Ik2W
         hL8MYtuV4jNUi9Qmupy2h6h0FNaAVg89Jtp6YtSQJ1raCJQCMZFL0A8DQWWSmrllYAVt
         JAlSLB+zfmLVuWKc2xNv9jHSWyHY4bHVkzQm7bprvpLAsQzRK8aVEP0GlxAzgwAjIpP+
         w9EWhFNi/DbO3VeoSX7tQDoAE0phfhqwYzyAqKfW2CcMxY/IxwfUQvmAB7GPpu8DPgBL
         OqU3d9VPsoMrRoFIFViroup7e3ZHzMOpE4FeqQZo+NZKx9UbDyp24zWd+i0o5goLoR3r
         a68w==
X-Forwarded-Encrypted: i=1; AJvYcCXW0Z6y/68EW166sB2DMKv+8zIBQ5Mgn+HCtZEULllRYKq6B4yn8Cj7HXqTgP1igCQlFf+LbxKNaSJ6SsgelktSWqUQ/rcd1A9JxhR0
X-Gm-Message-State: AOJu0YwPGWQRe/dVZvhI8GPYVUwmKwtMPA6mgJgxmRrt/vSCCuU/vee1
	XXgjSYUhgEWiW+b7UuUc6wlYt8SG/dEpm7na1Yuvzwmg6gr8PI6u
X-Google-Smtp-Source: AGHT+IGJCUIqro86kQurFCU6caq5ig2KEytK2bF/pzFVHgp+d2XWxjj6e0kfwlNkecFADTjHECxnWg==
X-Received: by 2002:a05:600c:4e8e:b0:41c:2334:fffd with SMTP id f14-20020a05600c4e8e00b0041c2334fffdmr1433112wmq.9.1714543104181;
        Tue, 30 Apr 2024 22:58:24 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:737b:ef00:e314:db5d:b033:4fc2])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d5107000000b0034c61e211a5sm12451390wrt.63.2024.04.30.22.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 22:58:23 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com,
	dan.carpenter@linaro.org,
	krzysztof.kozlowski@linaro.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: pi433: Use class_create instead of class_register.
Date: Wed,  1 May 2024 08:58:19 +0300
Message-Id: <20240501055820.603272-2-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501055820.603272-1-ikobh7@gmail.com>
References: <20240501055820.603272-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of a higher level API.
Reduce global memory allocation from struct class to pointer size.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 31aeabb1f153..c8c1d296184b 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -59,9 +59,7 @@ static DEFINE_MUTEX(minor_lock); /* Protect idr accesses */
 static struct dentry *root_dir;	/* debugfs root directory for the driver */
 
 /* mainly for udev to create /dev/pi433 */
-static const struct class pi433_class = {
-	.name = "pi433",
-};
+static const struct class *pi433_class;
 
 /*
  * tx config is instance specific
@@ -1263,7 +1261,7 @@ static int pi433_probe(struct spi_device *spi)
 
 	/* create device */
 	pi433->devt = MKDEV(MAJOR(pi433_devt), pi433->minor);
-	pi433->dev = device_create(&pi433_class,
+	pi433->dev = device_create(pi433_class,
 				   &spi->dev,
 				   pi433->devt,
 				   pi433,
@@ -1319,7 +1317,7 @@ static int pi433_probe(struct spi_device *spi)
 cdev_failed:
 	kthread_stop(pi433->tx_task_struct);
 send_thread_failed:
-	device_destroy(&pi433_class, pi433->devt);
+	device_destroy(pi433_class, pi433->devt);
 device_create_failed:
 	pi433_free_minor(pi433);
 minor_failed:
@@ -1346,7 +1344,7 @@ static void pi433_remove(struct spi_device *spi)
 
 	kthread_stop(pi433->tx_task_struct);
 
-	device_destroy(&pi433_class, pi433->devt);
+	device_destroy(pi433_class, pi433->devt);
 
 	cdev_del(pi433->cdev);
 
@@ -1401,9 +1399,11 @@ static int __init pi433_init(void)
 	if (status < 0)
 		return status;
 
-	status = class_register(&pi433_class);
-	if (status)
+	pi433_class = class_create("pi433");
+	if (IS_ERR(pi433_class)) {
+		status = PTR_ERR(pi433_class);
 		goto unreg_chrdev;
+	}
 
 	root_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
@@ -1415,7 +1415,7 @@ static int __init pi433_init(void)
 
 unreg_class_and_remove_dbfs:
 	debugfs_remove(root_dir);
-	class_unregister(&pi433_class);
+	class_destroy(pi433_class);
 unreg_chrdev:
 	unregister_chrdev(MAJOR(pi433_devt), pi433_spi_driver.driver.name);
 	return status;
@@ -1427,7 +1427,7 @@ static void __exit pi433_exit(void)
 {
 	spi_unregister_driver(&pi433_spi_driver);
 	debugfs_remove(root_dir);
-	class_unregister(&pi433_class);
+	class_destroy(pi433_class);
 	unregister_chrdev(MAJOR(pi433_devt), pi433_spi_driver.driver.name);
 }
 module_exit(pi433_exit);

base-commit: 75ff53c44f5e151d21d949416633b56e56160124
prerequisite-patch-id: 91943193af2fea74182be67fb583235a3fbeb77b
prerequisite-patch-id: 2cad031ba6a0782a67ab1645ff034a8be65c2e76
prerequisite-patch-id: 1a852ed8f9d133aec7c651fd9007e59e39c55fb7
-- 
2.34.1


