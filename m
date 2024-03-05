Return-Path: <linux-kernel+bounces-92432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687B872016
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5901C25460
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3A785C73;
	Tue,  5 Mar 2024 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="jerpBw7w"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117C85C66;
	Tue,  5 Mar 2024 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645197; cv=none; b=g9gUEEr4Gd2HWmFdlewApNiH5pC1euOmysd0sw0PcGq30xs21wsdjkSRt8akAySJ149uzNA44WMYT5MYvhOZGx4Q9VNVDBmsX7UxHmmehgYplB77GxrP+0dPPluxcGDTzu5KGCMtEPxCrXSu8W8Lw57JWWdBr6JuniCLBMNXWBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645197; c=relaxed/simple;
	bh=2EEnqmB5TIgpdWkzBN0rc4jY7UzdMAzOCkdrC/xG+o4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cpb+K7JBSD03xP+ehr1KfqB6e33Ukx/gQ4kNlo6AWyk4tFSJqgYzUOanHQ+xLKyDynU5IiZAUl/dCML87mKjbLRYR5Co37Gz7CxOlqPpRmOoUGqNM38nHwmfeCeGve4hj/Q8xlefK41Cv+Q/L7c3rHIAS2GtYLEDyCOlZE0J5jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=jerpBw7w; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d7232dcb3eso41488965ad.2;
        Tue, 05 Mar 2024 05:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709645196; x=1710249996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/uomTNW6tq+hyrTNAG5g2zGDC1DnWcLXlavN+iH9FRM=;
        b=Rt89Mv+Xov3QklPEo5rpnyZXtetSuhuY9uy8nf7jlm6A8HapDuruLxGEKkJOJDGS98
         FIAn4u3YMZ2zeROkcev6qOckrlygYS9cTr6TGR/z0vCqofkquawux7LZEDmTAy6jRX3n
         lF9DH0G22Rtu0e9USpGeU9WCL5gYckmYnthzwd44DLaaEdzVBtwff51afndJlY6sFgOl
         fGHq1N93L8+/Uqa+DDaUhZL5mO7nuSzMvmMrsCEFl7N0CdnBrM4IB5K4z7Od8IF7QFnA
         pJ4CknmeKlpPQAnUOIc36OJR4GQXJnYINlLNxAzX3scPGHrDbGQS2Ss3xOhpyPfysLIf
         zB+A==
X-Forwarded-Encrypted: i=1; AJvYcCWKaGYTI/EypuCZ2xIR+OZh6ZGXiHRa6HU+GquieugaMmJwZvLWDo+MQvgtLTvODLUK3L71buDTFmMR9KeIPs8xzDBdP04JUo29syCAa3aBfrZ9c75tUQAA/f+t8pSacT1gPJlP85I2D2w=
X-Gm-Message-State: AOJu0YxtW4vs4uNmlKiaeVE3fmhIKbbuB6+7Fd/RfLlJK7qgjngpD+Ll
	UgQsCSl8pVEca31EsojLp88RlE7pcz72I6iY6qv0wWF8HQQUqgeynoK8X+/AjURBbQ==
X-Google-Smtp-Source: AGHT+IExGzbYjgr3rMYTSsQMOwiWJgtTlcptZBnwe8v3yqdJAR7bTlZoOX9WMdE1+6vVYhB2Cxplqg==
X-Received: by 2002:a17:902:d4d1:b0:1d9:a647:5579 with SMTP id o17-20020a170902d4d100b001d9a6475579mr1949268plg.1.1709645195761;
        Tue, 05 Mar 2024 05:26:35 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id o5-20020a170902d4c500b001d8f6ae51aasm10472564plg.64.2024.03.05.05.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:26:35 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709645194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uomTNW6tq+hyrTNAG5g2zGDC1DnWcLXlavN+iH9FRM=;
	b=jerpBw7wmS3/Y579CuvLYlnksVBtVQz5mS12UX57G/0CgoM0fqT+tqJvACG2PZch9xshkb
	yw+mwCD9l5D9HTCqdNCuSp7OcfNL5gbcOMZSd9nW004DqTKAcvMIX7DBFuCcEsFBeLE58N
	/5MWDyHg6L5mxgLbQGBuNpnaV6n8WAtXmH1i1q5YNAbPLKuZ3Cq2XQQ8KEVIdUfLwaViDI
	mZiW1TSuWUSH34gulFxB6a1Ukk/x1qJDF3Fd+LQmJx7L82y/HKgdgpsOm9KxA+AI0+RCWx
	ioG88NNjby84LLMVKUn6RBhH9IpT18FYPcSVTdUxuMd3/Vx/ybojPJYxhrcKTg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 10:26:25 -0300
Subject: [PATCH 1/2] media: dvbdev: make dvb_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-media-v1-1-53e1538973cd@marliere.net>
References: <20240305-class_cleanup-media-v1-0-53e1538973cd@marliere.net>
In-Reply-To: <20240305-class_cleanup-media-v1-0-53e1538973cd@marliere.net>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Young <sean@mess.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2610; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=2EEnqmB5TIgpdWkzBN0rc4jY7UzdMAzOCkdrC/xG+o4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5x2DNHXMH+WsvYrtzME8gDyGqHFfmait7CMVf
 1/mOpqK7tGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecdgwAKCRDJC4p8Y4ZY
 ptV7D/9ZWGQJP3XhGWFggsdzeT+OnKJQNyaDjNr184adAoKk8UOVRTfiQm66GFHso1vzSQ21ygQ
 qmUy/sOSeEcP891r3WhsqeTg8puyfNFl2Y7REOKN1GVH22pVavVxci4sA3zuWTKHLwJRNoaq1Pq
 mtR9AFf5bAHX/UBaUcmJSkEknK0zwl+hnvetXRvGuluAmDEPlMazC5giHwrqjTVQZ4wws8K/gCp
 nGPJfPF/eYIL3xEMu7hds4LpO/QnUXtm/zHOF1xbfH89I3hatiBj/oQgPhC/LyaMZ8ak/8VoLpd
 TNa+Wg/y9FzRqxPS6QyQ4U1e8+O4ffc+Vm6fjHKNh9xN60bvFG26OhG+QgqZ2ZLEB9rsh0MaCGj
 LdmHMlL0Y94wvQXJxggXRsODR+VgguFfAwCvwg1IOjyAOSUkhu1SzFN+2CLx66DN3AJGLXcsh+d
 QzvWN+zrwwoJpsuiXLuDXbGBZLUPDlruOxq5DP7qCs5s+lcCx6as71tIfJK8ePPzn5hC+70f9ug
 BIhHdLf5yVnDdYPpUvirPdwrluwPIFLbg6MvyH/695zcZkymR0N2Q2RuTGalVb2XIH/d+l3JxD7
 CDGK8RlFHWqErv6lKJY5p0TVgITbXC3HnGV8msl8vxscwf3R9aBxrK8yIcMri0nPeRXjAgEvSWF
 E0UKtgE5JFpmkiQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the dvb_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/media/dvb-core/dvbdev.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 733d0bc4b4cc..dcbf68b00240 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -78,7 +78,13 @@ static const u8 minor_type[] = {
 #define MAX_DVB_MINORS		(DVB_MAX_ADAPTERS * 64)
 #endif
 
-static struct class *dvb_class;
+static int dvb_uevent(const struct device *dev, struct kobj_uevent_env *env);
+static char *dvb_devnode(const struct device *dev, umode_t *mode);
+static const struct class dvb_class = {
+	.name = "dvb",
+	.dev_uevent = dvb_uevent,
+	.devnode = dvb_devnode,
+};
 
 static struct dvb_device *dvb_minors[MAX_DVB_MINORS];
 static DECLARE_RWSEM(minor_rwsem);
@@ -561,7 +567,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		return ret;
 	}
 
-	clsdev = device_create(dvb_class, adap->device,
+	clsdev = device_create(&dvb_class, adap->device,
 			       MKDEV(DVB_MAJOR, minor),
 			       dvbdev, "dvb%d.%s%d", adap->num, dnames[type], id);
 	if (IS_ERR(clsdev)) {
@@ -600,7 +606,7 @@ void dvb_remove_device(struct dvb_device *dvbdev)
 
 	dvb_media_device_free(dvbdev);
 
-	device_destroy(dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
+	device_destroy(&dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
 
 	list_del(&dvbdev->list_head);
 }
@@ -1096,13 +1102,10 @@ static int __init init_dvbdev(void)
 		goto error;
 	}
 
-	dvb_class = class_create("dvb");
-	if (IS_ERR(dvb_class)) {
-		retval = PTR_ERR(dvb_class);
+	retval = class_register(&dvb_class);
+	if (retval != 0)
 		goto error;
-	}
-	dvb_class->dev_uevent = dvb_uevent;
-	dvb_class->devnode = dvb_devnode;
+
 	return 0;
 
 error:
@@ -1115,7 +1118,7 @@ static void __exit exit_dvbdev(void)
 {
 	struct dvbdevfops_node *node, *next;
 
-	class_destroy(dvb_class);
+	class_unregister(&dvb_class);
 	cdev_del(&dvb_device_cdev);
 	unregister_chrdev_region(MKDEV(DVB_MAJOR, 0), MAX_DVB_MINORS);
 

-- 
2.43.0


