Return-Path: <linux-kernel+bounces-92263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAFD871DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D451C2348F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77DA5BADE;
	Tue,  5 Mar 2024 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="JjfciFPR"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952FB5B681;
	Tue,  5 Mar 2024 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637939; cv=none; b=WNw05FE8mPLo8BwU3gRW2oIcbZoTwiKR1rnOs/vZSpozcdB92XYDxuXLclfNfLB2ivdrgSflH6yUwBz/xcBtOsfUezs9y6PSgsdnpToYHaMpvtZguNnlvltjbtJvlKfVuXKNbMNkOiZ5rfwx/t75Gwi9/+2jnPEjftin3n/JKhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637939; c=relaxed/simple;
	bh=5jdxcdryUPQt50XcmDbhimc56nx8adUKkG1k2JFyqX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVBAg+bZuo9X1w/Pu0KuQqnJ5WsyHeoi7Lnr/mAJhYAxPVoEbKoJmZ2Y17jgwbnitYlrFtl7YSXCZxBPs9GMEOrXU/iHpWEaKSz7FHwasDyeVsYcMkyXPB4jBTI6Qehh1ZmFKVyxoNEx5nPPvgu9FmFe5z24UONheis+hLBGato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=JjfciFPR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dd01ea35b5so15698485ad.0;
        Tue, 05 Mar 2024 03:25:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709637937; x=1710242737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rmH0p0BoItGRwrFW9LqJ5pvEbDOip4sy5bdoMO6KgV8=;
        b=bXB+u61+8WVR8tC6eEmcA8ywYeJnwTIP10XIqY24205BdVVGYIMe8EG1GIkE+5A7fi
         X9HSkIm7kV3E4lKeb6JHkVzmwqhiYim6iZYNw79vcsk95Qna7cNJa+Dj9aGw296XohXX
         3c2qDd65reT9VrjV7cg+K/z1CCkXZcRCY/Mmalnw3IneKwws0nWPzEwLy64ng45gDUwR
         4rSULmnd86zOtsJitMsRpSx5Yl9V2/q+FCk+FgU7+AEtuupS4eTMReNF0/PTLRGeuT6P
         vRbVAly2cz0/JZdkZt3Uog2B71q+syN+WlOL+yx/ZHJySCbOfSHc40vTDLhXrneXWSYR
         ty1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRPU3Npa5kA0K0TFsGtsXO7vm5c3T4r2aFGp1fxzyWs3rF0tFT2d/nU9X7tb/MoOQIILqVEKFMcQ3ux+VKy1Key0WOfVLnp/sJurNE
X-Gm-Message-State: AOJu0Yxxn3fv0zHY9eB/FDn/cZDovPGcWXpaGu2K2fMIg3enUOypCEIg
	udDtvdve9jH02yxbjsOMgUl+ZqIylav34vwffugsMKaUzehykbyU/LjEa1I8NNr8Qg==
X-Google-Smtp-Source: AGHT+IF2sYYr1hfNWL9HIGyRf+fqwHUBIuXhHwSjLYG+ifOjEx61TPyHKBOt8ZUL6DGDWQc5ZCrVpA==
X-Received: by 2002:a17:902:778f:b0:1db:3618:fed5 with SMTP id o15-20020a170902778f00b001db3618fed5mr1161034pll.53.1709637936991;
        Tue, 05 Mar 2024 03:25:36 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902d2d200b001dca3951a39sm10289044plc.81.2024.03.05.03.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:25:36 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709637934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmH0p0BoItGRwrFW9LqJ5pvEbDOip4sy5bdoMO6KgV8=;
	b=JjfciFPRYjm9xl6rUiLde6eaS+uxsTdCum7mWTAyJUKVoOx+5nsuD31VVH7enmpiWpdCLt
	zWmXhFhUov0FGG0zG9KoN2K1ig62Gj+ET6Z0K55PtD66eWeoB1igyldBVw1N5FhEXK+3AL
	0MR6AHn72RqxlswLRhRVvtgVUggT+j5mmP+Y5EQ2+vNSIahCuS55G+PP1iU5z+UcT0vR3y
	fcdgK2gPfE1dN51qu9CN+WZOedJpJrwHc9ek0yWcJIHYLmzNSfL1alCUsp4ZTsKfD8Qbio
	2ZBjMTV1akhwpBeJyP3bPEeOQ++7zSR11w8kkTqH6n8bfwyUcyOBa3WaRXK0vg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 08:25:20 -0300
Subject: [PATCH 2/6] s390: vmur: make vmur_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-s390-v1-2-c4ff1ec49ffd@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2737; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=5jdxcdryUPQt50XcmDbhimc56nx8adUKkG1k2JFyqX0=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5wEgWrJwe+gjxP9WvDL+0ojvNtDA64mICySo7
 xSYP/EzlK6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecBIAAKCRDJC4p8Y4ZY
 pg22EACyi6UUes77n6E4fr2mkom2tqDEec1RkKwNUURuzC4HBDC6Geb3LR9o0307UelSisCzwkv
 XPGY3Cn4jBPel+R925mDpqfDDBx0vj7rmxFVRr4GeirkLBHj9i3qngbRAzgE0y9s8YGE5nieBaa
 7JoqhNk296IITWhGqL3OrIsWGizyjoF3hkS5cfyy6LneSAfn4T5COeViP8rlkSEuGDsQIKm7DTH
 sT5SGVSPlqjtCSGNEQ3BjOANmjNerBEsZNvD6SwcKl6CljkoYAonuktWsHVfvNnIBOl5foEKfU2
 /5ITAFjXftwq6tbLVmFCK5tj+t0bzrhkkn1oDWbYL7FkphTO38gtIwUXPojXFS5NXKOW9xIMbYB
 58xkCvBkIUL5MeA1NKPIbG1PpNyomTtjsviS7LfIe0zKP/3w4wcyqg7U0yhuSXAx29fRIrXTVzD
 h/gbrrJSE3RS4E2OydAGUq28zXZanaWvYRtKZZEz24veioYuUlhvGbm/eq2vFTHmiYULhFxMGfN
 FRTyQNH6nZnZNp/e2WUwbWM7UD+0fdN5m7rgpOrKEoT/cb4TcWKZyRjl444+4cEAdbuf9QGtiiw
 C5gKUGFpUKW5v5hwjtcotep/ik5RhMRKRa1qwIPZswysZhAl5hbPgtQxPohpVP86aeJdK2Y7Eio
 XBYLX2tKaCTIX5g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the vmur_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/s390/char/vmur.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/char/vmur.c b/drivers/s390/char/vmur.c
index 1d17a83569ce..47bfb50f8eb1 100644
--- a/drivers/s390/char/vmur.c
+++ b/drivers/s390/char/vmur.c
@@ -48,7 +48,9 @@ MODULE_DESCRIPTION("s390 z/VM virtual unit record device driver");
 MODULE_LICENSE("GPL");
 
 static dev_t ur_first_dev_maj_min;
-static struct class *vmur_class;
+static const struct class vmur_class = {
+	.name = "vmur",
+};
 static struct debug_info *vmur_dbf;
 
 /* We put the device's record length (for writes) in the driver_info field */
@@ -912,7 +914,7 @@ static int ur_set_online(struct ccw_device *cdev)
 		goto fail_free_cdev;
 	}
 
-	urd->device = device_create(vmur_class, &cdev->dev,
+	urd->device = device_create(&vmur_class, &cdev->dev,
 				    urd->char_device->dev, NULL, "%s", node_id);
 	if (IS_ERR(urd->device)) {
 		rc = PTR_ERR(urd->device);
@@ -958,7 +960,7 @@ static int ur_set_offline_force(struct ccw_device *cdev, int force)
 		/* Work not run yet - need to release reference here */
 		urdev_put(urd);
 	}
-	device_destroy(vmur_class, urd->char_device->dev);
+	device_destroy(&vmur_class, urd->char_device->dev);
 	cdev_del(urd->char_device);
 	urd->char_device = NULL;
 	rc = 0;
@@ -1022,11 +1024,9 @@ static int __init ur_init(void)
 
 	debug_set_level(vmur_dbf, 6);
 
-	vmur_class = class_create("vmur");
-	if (IS_ERR(vmur_class)) {
-		rc = PTR_ERR(vmur_class);
+	rc = class_register(&vmur_class);
+	if (rc)
 		goto fail_free_dbf;
-	}
 
 	rc = ccw_driver_register(&ur_driver);
 	if (rc)
@@ -1046,7 +1046,7 @@ static int __init ur_init(void)
 fail_unregister_driver:
 	ccw_driver_unregister(&ur_driver);
 fail_class_destroy:
-	class_destroy(vmur_class);
+	class_unregister(&vmur_class);
 fail_free_dbf:
 	debug_unregister(vmur_dbf);
 	return rc;
@@ -1056,7 +1056,7 @@ static void __exit ur_exit(void)
 {
 	unregister_chrdev_region(ur_first_dev_maj_min, NUM_MINORS);
 	ccw_driver_unregister(&ur_driver);
-	class_destroy(vmur_class);
+	class_unregister(&vmur_class);
 	debug_unregister(vmur_dbf);
 	pr_info("%s unloaded.\n", ur_banner);
 }

-- 
2.43.0


