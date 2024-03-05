Return-Path: <linux-kernel+bounces-92265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09749871DAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4FC1C2351B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F191D5C609;
	Tue,  5 Mar 2024 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="LKMrYzZP"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24A5BAF2;
	Tue,  5 Mar 2024 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637945; cv=none; b=QDRBofV0Y6sqXtvPLvwg1wB20fe/LfljFT4fsB30yCuPp3dXH5k0OrFe/iypWxkKUHzEehCZJfgkqsymTvrbHLbnDRMIk85EslTrysiM5BLJMiG5KLzGgMiQYbi8EAPp161WDVng1k1dyWLuRsTNkt4zK1rU0h4b9Taf/CprKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637945; c=relaxed/simple;
	bh=6uzJm/imGg803v5QIcaycnL2wxC40fsPWSQzaCQLZxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e2ZAMTnTO9g37cF5wQt6MeKuopn4INiAOlc/UNEaLQ7mjBo1vMVxydqYL/s2s2OR8xXfxyQgIHmdePx1EtXJxA/p1l1+Zmj50QRwJkQ5JEs1undmJD2/Kv3W0kGqDEcth0O7jftioeDs1jSFYTFHqXu7ISo2TivcDwLs5mqqeDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=LKMrYzZP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc0e5b223eso47419515ad.1;
        Tue, 05 Mar 2024 03:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709637943; x=1710242743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lpu9eKZ9JGfXXjUBcqDRJO7/y2rbC5c+FnBAtWGE+HA=;
        b=r5Sss2vj60cngdZOcomhmTHTqhkXsSj2mpVxpi7lc0tEyLbgvWcpt9v/5j8LlN5AWT
         S8gcXWO+ahuCJoKs0X02UFUKM6L+KYTbvZYiCaUE1iILPFetaNi9TrD42M0RIdv4qhqi
         WcTIDHBMBDRCwDXUQ14cKDDzgk5YryqVgxI6bbQ7FoshTTDfJPlduyeOCdAj8926ixVe
         jLiRpaLgGkojcVdv2IWofPkw/rULW+jvmP/hCtqu1dZWxMBJbp9887elxCqUAzqSF8+h
         +DH4JSAAfTZqHyOX5BNMQXtO0Kr2TwKvNDbdy1jTDyomKMxJNDcRRt9+ji95t0n11dht
         YOyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaet1ErOC2GYQCGQauTwUWTjEsvz3GeQYPLPRodLXbH1p2JHM88rHUNj0fKAJ5AiV1faICoeVR9El0iqXjHHivgZzw76Y5NCV3WEgU
X-Gm-Message-State: AOJu0YxdReGsi6tNrVpERbgXfazViUzxbO7LBekivWFZDBKTL5OPqQhA
	Wre/KzxMIgi1hdqr7h73Zpk+dl59z+QKiE/jEK/awS+TiEm65maNB/8y/8cZ32mvKw==
X-Google-Smtp-Source: AGHT+IHzqm8sVuSg6jCxTmyUG2oJVBIjKYp2V1i94WEi9onBAmWc/EFCX3VXa8G8Q0fS/RkXv3NfXw==
X-Received: by 2002:a17:902:680f:b0:1dc:ea85:91d3 with SMTP id h15-20020a170902680f00b001dcea8591d3mr1524528plk.69.1709637942895;
        Tue, 05 Mar 2024 03:25:42 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b001dbbe6f1dc5sm10419499pln.40.2024.03.05.03.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:25:42 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709637941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpu9eKZ9JGfXXjUBcqDRJO7/y2rbC5c+FnBAtWGE+HA=;
	b=LKMrYzZPKI7QifP1FEG5KXjdlh5hHKxoKGH52wdWQIp/QEVwRNLifi0CvqLC9A7UuWvj3t
	cXbkYrvxDXuBi7sz3gq/O5JqLpepYsrmdLpN39akFAMI+WUtoVz/FniDdbkd4ZYItb/N/e
	9JafbgwLrJO5ATXHWevuTHfmiYOcX51fGijHDhSfVYZPNrmMCVMbitZdeURBrKcu8TAPui
	AqA0Srq9/RrgiUcYDvXs4Wwt6fJDUIKgSASefz2sCi+5J+vbxqbJB1Zi/8FaDbVqB75BU2
	vm8Thc9ZpE128SLfKyDXH5R4FoGbHO1xCZ1MUBx0mny9PsFbhKjUgPM2yzxWIw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 08:25:22 -0300
Subject: [PATCH 4/6] s390: tape: make tape_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-s390-v1-4-c4ff1ec49ffd@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2407; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=6uzJm/imGg803v5QIcaycnL2wxC40fsPWSQzaCQLZxI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5wEhJ7eCqSFl2hmoQHNCEzs8Mnm6IP4sEcw5/
 tJb/CoBiTmJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecBIQAKCRDJC4p8Y4ZY
 ppcYD/9GQSO1a6ryaAgMfQT8scaDhaUjqIjLZgSIvZOF5Zmudryc66QOehHiWGovmqSXBT2Zdic
 FpHrLMDbhkacghCfqcVbRhdFbVMzB9ydLdUQADo2kcU0AvtrKxfEdZD6rcSxJE4zIlOBk0VBMAu
 H2rJvjFHmskJVhzfX03S+3slH0xY/w8jZhnik7O1MydF1SBsVGI54pYnEAs9gNeaGNKGSDkj5So
 HQD6wj7qHycfLUxj5cnkCIBV7+l2D30a6wcfcsZXVjrYdDrXXc0smybnExMiLF5Bc8tnnSEDO7E
 grIyg2fHoEHVcCvzDYFdEX4WoCZTql0SenhxRtxArtIjldASoOpYLTAH7H0JHf8ZBqKVZssp7QR
 qegFKi5TP2pjRh0Nd1o+4FZXQGRaHjIVLM5tuYFdUyOvtVm69iu3FLPv7YewitOaHF5NCoohotv
 ESi97kCM+EOJECZeukRU5YJa/39lhTFbZlYpijYduxS+mWVldxIg4nqFWCnOnW7tYXIbB2ATsli
 aA5mQhoTbmJbtN+Ga3qO9W6sKxmjaLBzr8++CKdnCeXCYCcD1XYsxKhwZWB6kQ9UfztaALgatJ7
 7PDWmzsvzkWZOdIfgCq2DtcMy3ylzYblLFuXmCGglyi8IqgUQQtWSsugpY1YFUezGuXHH4A0iez
 IT/+6JsSeIdIB3A==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the tape_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/s390/char/tape_class.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
index 277a0f903d11..eae362bbfbb5 100644
--- a/drivers/s390/char/tape_class.c
+++ b/drivers/s390/char/tape_class.c
@@ -22,7 +22,9 @@ MODULE_DESCRIPTION(
 );
 MODULE_LICENSE("GPL");
 
-static struct class *tape_class;
+static const struct class tape_class = {
+	.name = "tape390",
+};
 
 /*
  * Register a tape device and return a pointer to the cdev structure.
@@ -74,7 +76,7 @@ struct tape_class_device *register_tape_dev(
 	if (rc)
 		goto fail_with_cdev;
 
-	tcd->class_device = device_create(tape_class, device,
+	tcd->class_device = device_create(&tape_class, device,
 					  tcd->char_device->dev, NULL,
 					  "%s", tcd->device_name);
 	rc = PTR_ERR_OR_ZERO(tcd->class_device);
@@ -91,7 +93,7 @@ struct tape_class_device *register_tape_dev(
 	return tcd;
 
 fail_with_class_device:
-	device_destroy(tape_class, tcd->char_device->dev);
+	device_destroy(&tape_class, tcd->char_device->dev);
 
 fail_with_cdev:
 	cdev_del(tcd->char_device);
@@ -107,7 +109,7 @@ void unregister_tape_dev(struct device *device, struct tape_class_device *tcd)
 {
 	if (tcd != NULL && !IS_ERR(tcd)) {
 		sysfs_remove_link(&device->kobj, tcd->mode_name);
-		device_destroy(tape_class, tcd->char_device->dev);
+		device_destroy(&tape_class, tcd->char_device->dev);
 		cdev_del(tcd->char_device);
 		kfree(tcd);
 	}
@@ -117,15 +119,12 @@ EXPORT_SYMBOL(unregister_tape_dev);
 
 static int __init tape_init(void)
 {
-	tape_class = class_create("tape390");
-
-	return 0;
+	return class_register(&tape_class);
 }
 
 static void __exit tape_exit(void)
 {
-	class_destroy(tape_class);
-	tape_class = NULL;
+	class_unregister(&tape_class);
 }
 
 postcore_initcall(tape_init);

-- 
2.43.0


