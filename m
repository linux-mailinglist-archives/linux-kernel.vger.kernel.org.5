Return-Path: <linux-kernel+bounces-89517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8FE86F16F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7961C21094
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC200374CF;
	Sat,  2 Mar 2024 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="HDZjU+up"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D8F36AE5;
	Sat,  2 Mar 2024 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398060; cv=none; b=buDwW7uM3gnFdXoROFbmYkP//diclh4LLJqGMqiXPpgfNxWJs4IIg6B72OdOkUkAg6hRaW4A0wG6E15M9bM2KhGMup8rHuY7TwuUS3Xy6ifj0qxjrPkp4nPNu6abn04ATbUfqNiVNtgtJXZLH3zHMY0tLqX7hosCxnaejc9o6n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398060; c=relaxed/simple;
	bh=Ur7tQ/GmafWahw88FheukE1dyb8cRyzWLMsnOBV0c+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ND+bhf1gZGcQOVi2J9U2WgHsWpOHYF+zGNRt50QuGyExkxQAiBDNYt/stni6jH2bRUmHClPH8ivzRK2RSYmwQH5szGllrxppAuHlHgNJTmWnOzmvy77A2Me4CMO5SNSfmy7/lFIaEcFzG1rydi7jywSVYov61P9EvVzFetZ7lSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=HDZjU+up; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c7b8fb8ba6so193741839f.2;
        Sat, 02 Mar 2024 08:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709398057; x=1710002857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gjT/vbcRZfQ0R+BHS46IvecEsU2yDNeF1+wwArqnYU=;
        b=sbQ5nIjE2sSOlckGZdOc77ffrO8K2yHqG65TOmdqCebiKhPL/k0YCZQe+QOCyElnbY
         ZbnU4dyKJZLfphHio9tB3J9G1aK5mNGdRGQNkBxjZWMB7MHuzEZwJ+PuUVodrb3BmqS4
         FiCRfWrRAWzTc4nKPW/5fulhwp+H2zrRWqYz7L4faD1PD5jkAZxnf8Y+hzSr2ndbmo7v
         nq2k2hWOxz/GCVQKWY/E9gyLorLGbjJGBhAIj1bi4lyjA1EWlG/vSGUSbhPe0CuHG96M
         w8ua90WJ3ouTMFsyvtn78l442VdEgD8B5txNykXocq2JgjDxsZZAGmPRZRyk7dNxspnB
         hpfg==
X-Forwarded-Encrypted: i=1; AJvYcCW2RMKY9Gur4idX+PGKMRO52qgReh8qsz3sdggWzQVgVVceFwuzjDk32c+liTSdO1V7EHntEyBdcgT1vt8Z7KUtBbCipLRKQUlZZfMr
X-Gm-Message-State: AOJu0YwOjmQE0r8NJ2JG9d5tjDBkElJ/AVySvXssgbyiKS3mBARxnWyk
	kCH/kOE4pHJhOqXcp0M6K9hFln1EqCzOFBu+Syxesbdc1w+vKREe
X-Google-Smtp-Source: AGHT+IHY+ZsHcoT9iAkG9eZBjYef8sBy1HHG+JjNBVR2iiFcOT0AsNsY2fqVAukH6t4GEPK339+CBA==
X-Received: by 2002:a5e:9516:0:b0:7c8:3027:7685 with SMTP id r22-20020a5e9516000000b007c830277685mr2760816ioj.11.1709398057601;
        Sat, 02 Mar 2024 08:47:37 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id i20-20020a02cc54000000b00474d40f8381sm689845jaq.122.2024.03.02.08.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 08:47:37 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709398056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gjT/vbcRZfQ0R+BHS46IvecEsU2yDNeF1+wwArqnYU=;
	b=HDZjU+upECGkrm0g3EuHD57+MUWzSqGDqaJGL3ZLjg022f99gKfrCHBqFXm5SfOb3Fvn5K
	e9N2l4hTy6nGAArpBiy0Po0u3IihBMxgst8qpOOprcos1ld9/ArdxBA0Q2GWktqeoQIDuk
	mXoj3KhG+A1n+GRY4q86+NzZNcPVbgYh/xw0ymEpAxU6Dsx0LGXavx9ir4TwUZT8qi4yuW
	cz1xYT4riMkUHdDeR3jXz8dbuNMiv3xSPj2fHO1M4sHrbKp6NxqLY63p1R2vE5h5W/AYZC
	W25tpo3Zs5qSoo+BBcFdgRlORFBDWtIaoQvwhkbm1eGWMt63A+eEwUnkR7lgUA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 02 Mar 2024 13:47:24 -0300
Subject: [PATCH 3/5] scsi: cxlflash: make cxlflash_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-class_cleanup-scsi-v1-3-b9096b990e27@marliere.net>
References: <20240302-class_cleanup-scsi-v1-0-b9096b990e27@marliere.net>
In-Reply-To: <20240302-class_cleanup-scsi-v1-0-b9096b990e27@marliere.net>
To: Doug Gilbert <dgilbert@interlog.com>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 "Manoj N. Kumar" <manoj@linux.ibm.com>, 
 "Matthew R. Ochs" <mrochs@linux.ibm.com>, 
 Uma Krishnan <ukrishn@linux.ibm.com>, 
 =?utf-8?q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2323; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=Ur7tQ/GmafWahw88FheukE1dyb8cRyzWLMsnOBV0c+c=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl41gd9rGrGXv5gTfccBoR92QdvsC7Zi6Yz55xg
 ktLqyzdf52JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeNYHQAKCRDJC4p8Y4ZY
 pv3pD/97WhbNloatg2mHaT3Ut8S1i2zJXNCWY5nwWRz1QnpZE6kJDNKriPsoOS8c7Ielbp5nifP
 FuvWPkkBZQXIfRGvCXT+iHB1hVeJtvFmcW0cpOFOb7HHybn4j6g/O1fLztMNSd1eC0kE6G2XkZD
 ywVh2QlUUFmYXxAGf8iWBwJnAlsisEAKtTEHiDfMH2ePdGN20USAkt4g5kq9q6zUMNm0YourEok
 nLjwtYYoz7z93089gWs8JfZsr3k4oGRh2+0SFXBjEYgbqslvxP7X46HGDorGBs+zwQ6G6amc+Ob
 lb2UymWVBcAnbKXtRB9fr8c/FGycRELhyB543eheOYNWoE31kGYIhY2uGwX2TQTLb4wix4XaOdN
 XorAXAkPGW6fLIvdmpkKBZH7fUxmV+isekpxricQiLCJlr14r/Hwq4AzD4qAwJK5rS/duduenq8
 1IT5W90mUjOqmwTYtdkb+1P9/Y5qXKJShjv48trjnq0lX5knLusHTtYuAwwmM9kIv721OzqkRAs
 jaPLQW5p0MN4SLqU3ANXCi2Q0DQxSBpElfJvG9/1OAvbSectAUkT2KYuUyHj1VhnBtLJMVtGIXc
 KWVWKlo42/CMBco9bwRusTvg0xzC3RCvBlfxSTziZCjHMVNUCoiHdsc5vJVd8O2ADGAGrTI88ms
 4y1Jf16bBYoxq+Q==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the cxlflash_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/scsi/cxlflash/main.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index debd36974119..e8382cc5cf23 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -28,7 +28,12 @@ MODULE_AUTHOR("Manoj N. Kumar <manoj@linux.vnet.ibm.com>");
 MODULE_AUTHOR("Matthew R. Ochs <mrochs@linux.vnet.ibm.com>");
 MODULE_LICENSE("GPL");
 
-static struct class *cxlflash_class;
+static char *cxlflash_devnode(const struct device *dev, umode_t *mode);
+static const struct class cxlflash_class = {
+	.name = "cxlflash",
+	.devnode = cxlflash_devnode,
+};
+
 static u32 cxlflash_major;
 static DECLARE_BITMAP(cxlflash_minor, CXLFLASH_MAX_ADAPTERS);
 
@@ -3602,7 +3607,7 @@ static int init_chrdev(struct cxlflash_cfg *cfg)
 		goto err1;
 	}
 
-	char_dev = device_create(cxlflash_class, NULL, devno,
+	char_dev = device_create(&cxlflash_class, NULL, devno,
 				 NULL, "cxlflash%d", minor);
 	if (IS_ERR(char_dev)) {
 		rc = PTR_ERR(char_dev);
@@ -3880,14 +3885,12 @@ static int cxlflash_class_init(void)
 
 	cxlflash_major = MAJOR(devno);
 
-	cxlflash_class = class_create("cxlflash");
-	if (IS_ERR(cxlflash_class)) {
-		rc = PTR_ERR(cxlflash_class);
+	rc = class_register(&cxlflash_class);
+	if (rc) {
 		pr_err("%s: class_create failed rc=%d\n", __func__, rc);
 		goto err;
 	}
 
-	cxlflash_class->devnode = cxlflash_devnode;
 out:
 	pr_debug("%s: returning rc=%d\n", __func__, rc);
 	return rc;
@@ -3903,7 +3906,7 @@ static void cxlflash_class_exit(void)
 {
 	dev_t devno = MKDEV(cxlflash_major, 0);
 
-	class_destroy(cxlflash_class);
+	class_unregister(&cxlflash_class);
 	unregister_chrdev_region(devno, CXLFLASH_MAX_ADAPTERS);
 }
 

-- 
2.43.0


