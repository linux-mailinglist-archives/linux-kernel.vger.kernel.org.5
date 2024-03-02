Return-Path: <linux-kernel+bounces-89514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C4C86F16A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9B628320E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4A22BB10;
	Sat,  2 Mar 2024 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Upd2qR4P"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB222F14;
	Sat,  2 Mar 2024 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398053; cv=none; b=LVJKcvtkbu9oROr7PokWUqwoCMKMZ3BBA+wQrWHus+C20td9mQQIUp19e1TzSpM6u6nAsvFSS2QVFWNCIHCPaNDs9g5YhWStFUHYHa1Y8EGeIaEtln9uei0mnkJu85yUu73G0Hxa6y7GvSqyxMHDLd9ZYD1u2/M9thauy4nnDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398053; c=relaxed/simple;
	bh=5fFFl+NQvKIKgg15BuOC5SNCW60DHjH9gv71w7SxkWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMob70jiD+wUvBJgQ0n3BeFBDNe7wC1Hg1KbPxTo5YmIY2Yo9uRSZrhddkQNnPwlrqvlYD3xOiGf0spmNEfGBGICpasNp1lrj/IMK6FlTtka3q5D7w8TG94Y9dEqsuRKUq5xzWCzW9VcZ3Lt8R14GoiedbiIwEkFXZCCGuQG5CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Upd2qR4P; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c835b36e9dso16845139f.3;
        Sat, 02 Mar 2024 08:47:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709398051; x=1710002851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VKp49xShFivIZ3FSVYH7CTAL/TfZjGtj5hihj2WnRpY=;
        b=UWLMp9nGZQYzpvdMM2zyrpkrh88U19TZuTxk0yFUgMj5sILuztkui34zbgg0IB/SgY
         p1JP2+OLgoiSGEnyIpNvfDsolPx2pkdKvcfuiTagQlF8uLLEwHXE98HDGumosyQUvllp
         IX7Jt4dNRJ5Az2sKLRAjmmaRH+c7OOyl7cEb148gNKkxEC8pWuC7QY4lHN7SyuvrtBXb
         jxwIvvOeTt3jtqMDnSrtDRr9xCLUcF6HRviKssYw7/PkRVMK00I8WZFSTb2Q/Tewgift
         5x9aVfTJwiZ/g2Tri/fjrpUZ5VD7C/0Uxh2Tcu3tPwyeAfe8DlZ/cp4BbRIexOhCH9Uy
         E4Fg==
X-Forwarded-Encrypted: i=1; AJvYcCW5meGs67klaA8A3kRy+eTnFtR61LAazBbXLzybeintVxp/quxtdpSbRgo0uxtw2W3+NLmuDXekfkF/PifqhuQLy8HK3gbhD4O32l93
X-Gm-Message-State: AOJu0YzHJLi2s0lfiLf7VnRtbVR1JvYVvGBY28QTaodD0KJRJKUPejrC
	Gx1U6ajZ1zZj/xxhk9KAxmQ2zwltGuj2SsdSWq1pZBEpiSnWn+iV
X-Google-Smtp-Source: AGHT+IEp2RDU3Zd9t11xhj78W40lqahskTWojefoSXhk8+kyTEU8UOQRJGdPPdJy8RDxESofWyUcjA==
X-Received: by 2002:a5e:c702:0:b0:7c8:2bb3:ebb4 with SMTP id f2-20020a5ec702000000b007c82bb3ebb4mr3145859iop.6.1709398051264;
        Sat, 02 Mar 2024 08:47:31 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id g10-20020a02b70a000000b00474558a20a3sm1385930jam.140.2024.03.02.08.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 08:47:30 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709398049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKp49xShFivIZ3FSVYH7CTAL/TfZjGtj5hihj2WnRpY=;
	b=Upd2qR4Pnm++Aph61tfJnBVo5fGiwg5YIqJqx+nygIMq2XZlIGT7HHyUKX/6BPfTaywNNR
	MqpdPzIGwPHCi+mRGFMtdtnuFR2SFSDq5iGla+YzDcnukgQRlKv950pbHLJsR7LA/No6QP
	jFJJL2iavDe/DvHMSuGkGrRspFOmCljLMAEstqoK5/4vwpWPssbL1KdVJkdCikYnvQu0Ay
	ZX1MAK5FEMoliNEOzOcBo/xyyNGlI0mwJ7WST+hwnYu5vsdnTIcHXJypJSQmijWiv7D9xS
	mURMKfnDKEAEEc3mFgL6h4eF8IhFxWlyDtd8W57W4WdIi+jSAcs5kF9mrabN9g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 02 Mar 2024 13:47:22 -0300
Subject: [PATCH 1/5] scsi: sg: make sg_sysfs_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-class_cleanup-scsi-v1-1-b9096b990e27@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2750; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=5fFFl+NQvKIKgg15BuOC5SNCW60DHjH9gv71w7SxkWk=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl41gcO4omM5O9dpvOdRQNcf0ToXQGw1Slh668i
 1BBGJ1CLI+JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeNYHAAKCRDJC4p8Y4ZY
 pkfFEACCudsWo/MlDFnP2LfTWScW1Wxiezy5M1HYiFJB72XHRkqW9Ih8+tJdSV0q3G/aNhFtDlL
 nYjrXoxe/dwTMZbMZq8ryWsy4S1B7ubqN8OlfyWMe/agHgguYY/NiuGBaZGFaOeINChw1oJo+2/
 t/Gk4ki7BYwfHh5TYuJPYxkjNyJsszsZiU/uNNg0itso0u4I46AqU3tnqJYCz051k+wcuylxEiN
 4YnSVUc3tezYRscFAhmKgZo6uOQev/h/V82teVD7eShaIiifMetP6IrxjRfkIgl6dEsD+yzWsVB
 mfR+tEIWZa/rZqCp5BXeXMLB4TV4A/jpH26Q5z/N/XMuMxuidZePw8Nv/k1Ja+PGGS2eZJpUipi
 g7opERg54T02As/Rqjb0mK6GiqWUj3MOa/vfYLx5raPBpSEzQsNItqpPBDgytSXsWTyFQGm4Kqv
 RcNIkXcmUIKhs8wbx8C9YMU43liBagiTHicukYgr2WkjKs2tk91f6MvVLSirq6EsS71+vsxKa2J
 MxzfLRInj5j6c8UeMMhCOIlKFd3a28593zLZO7lbWd5xDoFHlWeqqsIGHZFPcZko86CpUk3myhg
 GZmPb5JTxAOSrGoOqbd1bgU6IgFcUfZBOzushN8tylwA0I5lcrUQHfBLQkWe8x+Jc8kA3pVSTkk
 I323B26ftPh/ZYQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the sg_sysfs_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/scsi/sg.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 86210e4dd0d3..6ef6256246df 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1424,7 +1424,9 @@ static const struct file_operations sg_fops = {
 	.llseek = no_llseek,
 };
 
-static struct class *sg_sysfs_class;
+static const struct class sg_sysfs_class = {
+	.name = "scsi_generic"
+};
 
 static int sg_sysfs_valid = 0;
 
@@ -1526,7 +1528,7 @@ sg_add_device(struct device *cl_dev)
 	if (sg_sysfs_valid) {
 		struct device *sg_class_member;
 
-		sg_class_member = device_create(sg_sysfs_class, cl_dev->parent,
+		sg_class_member = device_create(&sg_sysfs_class, cl_dev->parent,
 						MKDEV(SCSI_GENERIC_MAJOR,
 						      sdp->index),
 						sdp, "%s", sdp->name);
@@ -1616,7 +1618,7 @@ sg_remove_device(struct device *cl_dev)
 	read_unlock_irqrestore(&sdp->sfd_lock, iflags);
 
 	sysfs_remove_link(&scsidp->sdev_gendev.kobj, "generic");
-	device_destroy(sg_sysfs_class, MKDEV(SCSI_GENERIC_MAJOR, sdp->index));
+	device_destroy(&sg_sysfs_class, MKDEV(SCSI_GENERIC_MAJOR, sdp->index));
 	cdev_del(sdp->cdev);
 	sdp->cdev = NULL;
 
@@ -1687,11 +1689,9 @@ init_sg(void)
 				    SG_MAX_DEVS, "sg");
 	if (rc)
 		return rc;
-        sg_sysfs_class = class_create("scsi_generic");
-        if ( IS_ERR(sg_sysfs_class) ) {
-		rc = PTR_ERR(sg_sysfs_class);
+	rc = class_register(&sg_sysfs_class);
+	if (rc)
 		goto err_out;
-        }
 	sg_sysfs_valid = 1;
 	rc = scsi_register_interface(&sg_interface);
 	if (0 == rc) {
@@ -1700,7 +1700,7 @@ init_sg(void)
 #endif				/* CONFIG_SCSI_PROC_FS */
 		return 0;
 	}
-	class_destroy(sg_sysfs_class);
+	class_unregister(&sg_sysfs_class);
 	register_sg_sysctls();
 err_out:
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0), SG_MAX_DEVS);
@@ -1715,7 +1715,7 @@ exit_sg(void)
 	remove_proc_subtree("scsi/sg", NULL);
 #endif				/* CONFIG_SCSI_PROC_FS */
 	scsi_unregister_interface(&sg_interface);
-	class_destroy(sg_sysfs_class);
+	class_unregister(&sg_sysfs_class);
 	sg_sysfs_valid = 0;
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0),
 				 SG_MAX_DEVS);

-- 
2.43.0


