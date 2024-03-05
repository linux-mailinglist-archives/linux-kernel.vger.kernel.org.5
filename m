Return-Path: <linux-kernel+bounces-92262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0587E871DA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D351C23314
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4C85B674;
	Tue,  5 Mar 2024 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="YTaQZ8h/"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026B56758;
	Tue,  5 Mar 2024 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637935; cv=none; b=lBt6S1cs+FrTrsnZD8EFcTSTSRtNJvVoPXwR2PFdTktj6iVBXNJQNY8RQoPak0gR2ivN/myLz+PopxPTazow9UfK4T3zz31jkz5x/Bbq7NR99lxhqhcnRkmVked3NG86cx8Z55cuEiLsEf7Z/H8TKCgNj89Y7d+C8Iw7KFSqiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637935; c=relaxed/simple;
	bh=WGIFWYFh3hQ9VXnIJFPQZwA2uJuy2dcs4lEb7YsAaFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lWL5zXUIIw/RCP1oWOcA/0QUg32fgfWeTZTOQVCG+cTPTREJfB7KuYIWxHQGIYQTHD5WSivgvQzho9I9Nntq/Isjo/vgIrmNimpHlq+WLfAOhP+u3SAfNSjO8kqIxYT5lscgFeb7a78FBDowg2rhs1ofIuqlt8x6L7okrjvxXsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=YTaQZ8h/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e5eb3dd2f8so2032203b3a.2;
        Tue, 05 Mar 2024 03:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709637933; x=1710242733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrnOmqUduKVY9054SARMGgmju4czNVg1PR7unBKC3kc=;
        b=Ob8gJ5jlMw0+vNnAgvfkAOngZ65ChFVajuyNM3MeugsRJj7xvhhTDXMVGBn8LbZ9D7
         3+pkj5orhJ+XWSTqtw+wDpl5wsK9mdhJRAS4qWgQA6sz6/dMzeI3GyBGJMW0QfuIBNTw
         njNS7BdP0vq/bJAJkeDZIvRjMuZ2xjWVACuLRgZkY4VTB4tbJqf6RNtOoHUDQAl3WJXU
         4b4NoCEoEDLA+3C/0OCqHlprGKICDK5zPWmb4a+aIvVwtnmneVHqXZQufUvHdmdF2w/1
         nwhstYAyQJRKfb1tChckZjaUPACkWmJLAtvRGhavlXHJln9YFNknudLmjTilBMraU6Xo
         qG1g==
X-Forwarded-Encrypted: i=1; AJvYcCUjas7whmzOqiw2x9Px5JXWZCuMkrTkGGOq6sEs9p+F0Yub/WiT155R5YoUQyVF41QNmELrV+JfFdckwAEPqXi9tl689IJP2GWSWFe0
X-Gm-Message-State: AOJu0YzEpskQQYHkdTrvXvGL7fBEfJSKwfYcvrju5DZyNEzE2wHVbftJ
	KstgLBqbqDNtUXXFoBn1BwS04d8XnWtA28KJ7VSWDAhYlRuhLnS9hM3QRo4cCLAO3Q==
X-Google-Smtp-Source: AGHT+IFIJmVBoT+yA2CUePnH6wIFVqf0RfgtXJnODic5dsn7mvbhUl/zcLllowmj0IICA8AdqXJBOw==
X-Received: by 2002:aa7:88c1:0:b0:6e5:5425:d914 with SMTP id k1-20020aa788c1000000b006e55425d914mr12434691pff.2.1709637933258;
        Tue, 05 Mar 2024 03:25:33 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id i37-20020a631325000000b005dc36761ad1sm8200256pgl.33.2024.03.05.03.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:25:32 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709637931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DrnOmqUduKVY9054SARMGgmju4czNVg1PR7unBKC3kc=;
	b=YTaQZ8h/Vb/fXGX8im75NlizIO9ffQMZtKZjnokc8kyip/LVx8veYTs1MaW89ALt8V8sEp
	zx0Xe2Y4fcT8QumoUa3FprwVeP87a+PQPjafBap+us+ZvsYosTaQbKdUJxC7N6Zm5AQZ77
	Y8YiL25d1SmM4cBEUOSv7nHFAAJqB/ScDH/2rKcf3ad4otLBBYPr7FAYB+0YjyzHWxTNSr
	JctXmTCWEIYVs3icGC0H4sXYuWXPdeKtNiGPMbcGpmmO0/UNNTVjrWGTS4qSsfVrlu0e2d
	wdvaUuT82yjp+Vhl3h+KKd+XySb6Az90DMT/KTcRxe/3/NJY5A0GXErTwoPH2A==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 08:25:19 -0300
Subject: [PATCH 1/6] s390: zcrypt: make zcrypt_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-s390-v1-1-c4ff1ec49ffd@marliere.net>
References: <20240305-class_cleanup-s390-v1-0-c4ff1ec49ffd@marliere.net>
In-Reply-To: <20240305-class_cleanup-s390-v1-0-c4ff1ec49ffd@marliere.net>
To: Harald Freudenberger <freude@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4118; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=WGIFWYFh3hQ9VXnIJFPQZwA2uJuy2dcs4lEb7YsAaFs=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5wEgURe+g1tpepus6BzVvP0vk980i/IPWroJI
 /59/F/MGSeJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecBIAAKCRDJC4p8Y4ZY
 pogPEACmO8SwFAnU9wgtOI41rvLzi7JyoS05P4lm/jj4lLxAXflnBrnaP8JNAxjMlk0RXAZfm5C
 vOP/xbV/3LPfLKsB3OKbToIBBtsGPHkpKJPUROzM0YnwZl0fGWjox+y2SqBg8VjKlnTMtEw6tsy
 A0/Gx6ZtWQgO9Q6v0dC2Jsx+Aq/dxhpXZ3oiACwCHZxAxDl8MwgL8RDIoUjEty+vkEDmteadAZR
 KflNPnXrhAWy4RobwDHBAqjOXRlzjUNCJi/Fnpt31FcO7N8ffoIR7NyU2/3S5OyaRnDnvjpePHH
 wZNTqZKe9/SW5pgRF/VRl0v3SZv/yZiOSmwxU65ZD9RUMEfGmuT1Q1LGYLzS26kwbMvkj3hcsqh
 4ndSJIGFAceQewVfCd/X14p5lKmgXVqAwd6x+jh2qrrgFUrJ8EkmM74YrBNz2oIU975U47xs1Gx
 rWjLPcTf165B7R4tyxz6zllhGseEPStyo/egzD59BN8SVzQtdieAN2B7L24niXmWGYVt6nLZBO1
 RHQooqtjYrVs83DQv5GNRAzMia6UcaCBkWtLBWARj0bN63esCldbtSQi1nTcMvYjZ4c4CjpXbZ6
 Sydfhv8zFnoTW91a4Ab6c8DSIswcR1stpmwUAutB4EHPjPC5k6/OBcxHQ5YMV/K/zSRfTS90/Fc
 jSWA0BeBaz4/TUQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the zcrypt_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/s390/crypto/zcrypt_api.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index e8742757085b..d0358bb6ccf2 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -116,7 +116,11 @@ EXPORT_SYMBOL(zcrypt_msgtype);
 
 struct zcdn_device;
 
-static struct class *zcrypt_class;
+static void zcdn_device_release(struct device *dev);
+static const struct class zcrypt_class = {
+	.name = ZCRYPT_NAME,
+	.dev_release = zcdn_device_release,
+};
 static dev_t zcrypt_devt;
 static struct cdev zcrypt_cdev;
 
@@ -139,7 +143,7 @@ static int zcdn_destroy(const char *name);
  */
 static inline struct zcdn_device *find_zcdndev_by_name(const char *name)
 {
-	struct device *dev = class_find_device_by_name(zcrypt_class, name);
+	struct device *dev = class_find_device_by_name(&zcrypt_class, name);
 
 	return dev ? to_zcdn_dev(dev) : NULL;
 }
@@ -151,7 +155,7 @@ static inline struct zcdn_device *find_zcdndev_by_name(const char *name)
  */
 static inline struct zcdn_device *find_zcdndev_by_devt(dev_t devt)
 {
-	struct device *dev = class_find_device_by_devt(zcrypt_class, devt);
+	struct device *dev = class_find_device_by_devt(&zcrypt_class, devt);
 
 	return dev ? to_zcdn_dev(dev) : NULL;
 }
@@ -405,7 +409,7 @@ static int zcdn_create(const char *name)
 		goto unlockout;
 	}
 	zcdndev->device.release = zcdn_device_release;
-	zcdndev->device.class = zcrypt_class;
+	zcdndev->device.class = &zcrypt_class;
 	zcdndev->device.devt = devt;
 	zcdndev->device.groups = zcdn_dev_attr_groups;
 	if (name[0])
@@ -2067,12 +2071,9 @@ static int __init zcdn_init(void)
 	int rc;
 
 	/* create a new class 'zcrypt' */
-	zcrypt_class = class_create(ZCRYPT_NAME);
-	if (IS_ERR(zcrypt_class)) {
-		rc = PTR_ERR(zcrypt_class);
+	rc = class_register(&zcrypt_class);
+	if (rc)
 		goto out_class_create_failed;
-	}
-	zcrypt_class->dev_release = zcdn_device_release;
 
 	/* alloc device minor range */
 	rc = alloc_chrdev_region(&zcrypt_devt,
@@ -2088,35 +2089,35 @@ static int __init zcdn_init(void)
 		goto out_cdev_add_failed;
 
 	/* need some class specific sysfs attributes */
-	rc = class_create_file(zcrypt_class, &class_attr_zcdn_create);
+	rc = class_create_file(&zcrypt_class, &class_attr_zcdn_create);
 	if (rc)
 		goto out_class_create_file_1_failed;
-	rc = class_create_file(zcrypt_class, &class_attr_zcdn_destroy);
+	rc = class_create_file(&zcrypt_class, &class_attr_zcdn_destroy);
 	if (rc)
 		goto out_class_create_file_2_failed;
 
 	return 0;
 
 out_class_create_file_2_failed:
-	class_remove_file(zcrypt_class, &class_attr_zcdn_create);
+	class_remove_file(&zcrypt_class, &class_attr_zcdn_create);
 out_class_create_file_1_failed:
 	cdev_del(&zcrypt_cdev);
 out_cdev_add_failed:
 	unregister_chrdev_region(zcrypt_devt, ZCRYPT_MAX_MINOR_NODES);
 out_alloc_chrdev_failed:
-	class_destroy(zcrypt_class);
+	class_unregister(&zcrypt_class);
 out_class_create_failed:
 	return rc;
 }
 
 static void zcdn_exit(void)
 {
-	class_remove_file(zcrypt_class, &class_attr_zcdn_create);
-	class_remove_file(zcrypt_class, &class_attr_zcdn_destroy);
+	class_remove_file(&zcrypt_class, &class_attr_zcdn_create);
+	class_remove_file(&zcrypt_class, &class_attr_zcdn_destroy);
 	zcdn_destroy_all();
 	cdev_del(&zcrypt_cdev);
 	unregister_chrdev_region(zcrypt_devt, ZCRYPT_MAX_MINOR_NODES);
-	class_destroy(zcrypt_class);
+	class_unregister(&zcrypt_class);
 }
 
 /*

-- 
2.43.0


