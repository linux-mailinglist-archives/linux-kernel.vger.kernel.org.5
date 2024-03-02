Return-Path: <linux-kernel+bounces-89516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FF186F16D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF452831FB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E2B364BE;
	Sat,  2 Mar 2024 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="mL8nYeAD"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B02BB1A;
	Sat,  2 Mar 2024 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398057; cv=none; b=CsllGP8C5NXPsTvXOOCS4ArfPCBnU561+u3LBGx+Dzgmx7p7ubLSn6MEOqw6RamzbwCQUtllJF/T1aGf8vKW0ZcK7e4qqS/QOonvpP4D/5F7KrkAczWJU5cVDg5xS00Jotz614eYGkLqMcpojTr+NwvzOBP3Xwwbw8Q3O/SQBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398057; c=relaxed/simple;
	bh=rlc4uufc3PtM/hoEPL10OKjaFHgvMNuVTywDQZGsyvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hoJXdVhOq0eKVPILS+x//6Ih3LH4plWXOWSS2YlWkK6c1H25gx61tbELw6zuczOSsDLVzwt9/DJXAHgrqz4TDVQz1fLc6uZZK0B6SGx75JNk23GDxvgmzL61ZUJg8T0D+EJgLbxIblToOYRxemM4RtrY9CIapfYdxaErnT1pSc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=mL8nYeAD; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c403dbf3adso205795739f.1;
        Sat, 02 Mar 2024 08:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709398054; x=1710002854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EIxIH/dP4WE4ZSIoHocSg2tr9v1M7GINqI1t7vtWcKE=;
        b=d6ir/tAOBC47VfehtTMX68EF3vVPN6zZe2yQW4FbUdsvcv2NKR5FuJ5w2drLun/mSH
         8a98u0e2mtsDQP0p9X7q53a+AJgRZqN/TmdWcFLEHXDMeHnrAoUgxbbs+BIm2t67/4M7
         WtucJpnuHt2Tf7YvylK4G8B0KpPWXdbIL2IsU0PpSJRQaxfa7mMOsXVDgi/+mQT5zPo/
         QsXrWABmonnaPtKeYyjlGapaGcbOY53I0j4mWroaGw8kDZ/u3C+1/C8Eo3agB0/4L7xT
         fcYGqH5G99CrplVlmF4yLJgHQf4kI+zTVg94B+yO1IYFFNIEqj7TsfFw/VYHP0NlJNSi
         U8Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVRkfkEnRujhJK1RxUjmGAoAzvnfG70D4LW77BU+dDyeweh3HtS4Bf7KomWoN+0zPdEerpCPbYKrHdc9Zo9+fdNFweMH38mzSNvfUHl
X-Gm-Message-State: AOJu0Yz6moZTcxhouTmErbU5FJnOGkf8M8RRNzHcSCwHN736PjSXFyYJ
	6odCZGYFiap0g9ydpw0o4HsalTqe9VuwRdY+yShQ5cO8BsFNcLhS
X-Google-Smtp-Source: AGHT+IH9A/LZfckMTPIlJHjoSAVFm8QxA4sruNR8pQW+9pmfexs502P6vVARjfmQPDf0tlLTRRlUXQ==
X-Received: by 2002:a05:6602:3705:b0:7c8:298:8c88 with SMTP id bh5-20020a056602370500b007c802988c88mr6063659iob.7.1709398054386;
        Sat, 02 Mar 2024 08:47:34 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id f22-20020a056638023600b00474506c900esm1397545jaq.145.2024.03.02.08.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 08:47:33 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709398052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EIxIH/dP4WE4ZSIoHocSg2tr9v1M7GINqI1t7vtWcKE=;
	b=mL8nYeAD2lk6N2ClmmOSOaO4aZy95VvHRavTznymRQsiG96lU7C/YkC8l9VPEjqI46nCVG
	DTSQ6ydWsj3Cq74fkuHbaKQqLcdWcavwwRV2E0AZhQXwhO9uYJIQ24OK98ozKF/3ILRJT5
	Zbxe4i3q07OoHyEyoX17m80cfZ20eEr/SM6nHLwWPUj5OEsUGHpFffdLKXm9SDUFd+BlfM
	aXsYxgR3UXiE4f5ecXjuA2NIEkbODNyBmI4WbKZzysAmVd8Z47+2NrosvJAHup1LmV9YjY
	zU9wfG/Rl1xJfbbUriQIWPQ7Su1TnB7nJsg5p0LZSNFgeA9zxN+OurPAsQk2EA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 02 Mar 2024 13:47:23 -0300
Subject: [PATCH 2/5] scsi: pmcraid: make pmcraid_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-class_cleanup-scsi-v1-2-b9096b990e27@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3047; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=rlc4uufc3PtM/hoEPL10OKjaFHgvMNuVTywDQZGsyvw=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl41gcgcXPauwcMwcivousgucxCY3RKlSytTHfr
 WJeH+nqr1KJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeNYHAAKCRDJC4p8Y4ZY
 pnPWEACTmPuE8CaT+BVJaxp20vvGyFmz+woXDXlRcLmwZQFBfigeYCJZfDiEgy7opaqrPKVSLkd
 j9bCQ3p58rGUmFOWIiYyRhnrx63JN7wBtgFOVsas+IGEBz9cF4Manuv0e+DXaa7tvEBHcpYEu+h
 r8o6/bVuSIHq1a9XWDhUtlurep1BhI5BzH+I9i7Cewz6Yie4eYNJqeoxvzxxT7aVfJU69RgxAy2
 3jIOjfuX370sAOXXb+Y9YaKr+DBfPtF0w1hZWW3NvUVjo6IysGgr2WLoxOFGTNU2fNicKLI5bMb
 dyqQscsnCPm18gKOZZ81dVy3hfdicuw9R3z6x43gwuUk753M0cnVXYqCkfI5g3PkSQhfK+XlgUr
 65UStiHtAvLqyeRLrDJXZS0aToKbIwhiGUxx1sQgHSDb/nhCl4Aim/XN0imc3HFTxNxmvIBjR3j
 OLKmn8TyLoHcUymKgMStQlvFoOuDpIHDTHm5jgX5Bjmp8Wr1fwwr44luVMjd+56eDnVVuATQXJp
 qp5ZxlvdTM8yeF1Q36ZrkTGgYZ6J1KfD5OzR4UxD1pDgQLer+pCHy77k5k82LKfyM23ydJF1cmX
 1kgcGZiYjujKQqAVkAedaRLpog2wyRuOdZGrwvc36nOJRIJMzdric8fCuKvishjTlyfLl5HncFt
 MlZ3fzF3qXKTDHw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the pmcraid_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/scsi/pmcraid.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index e8bcc3a88732..0614b7e366b7 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -61,7 +61,9 @@ static atomic_t pmcraid_adapter_count = ATOMIC_INIT(0);
  * pmcraid_minor - minor number(s) to use
  */
 static unsigned int pmcraid_major;
-static struct class *pmcraid_class;
+static const struct class pmcraid_class = {
+	.name = PMCRAID_DEVFILE,
+};
 static DECLARE_BITMAP(pmcraid_minor, PMCRAID_MAX_ADAPTERS);
 
 /*
@@ -4723,7 +4725,7 @@ static int pmcraid_setup_chrdev(struct pmcraid_instance *pinstance)
 	if (error)
 		pmcraid_release_minor(minor);
 	else
-		device_create(pmcraid_class, NULL, MKDEV(pmcraid_major, minor),
+		device_create(&pmcraid_class, NULL, MKDEV(pmcraid_major, minor),
 			      NULL, "%s%u", PMCRAID_DEVFILE, minor);
 	return error;
 }
@@ -4739,7 +4741,7 @@ static int pmcraid_setup_chrdev(struct pmcraid_instance *pinstance)
 static void pmcraid_release_chrdev(struct pmcraid_instance *pinstance)
 {
 	pmcraid_release_minor(MINOR(pinstance->cdev.dev));
-	device_destroy(pmcraid_class,
+	device_destroy(&pmcraid_class,
 		       MKDEV(pmcraid_major, MINOR(pinstance->cdev.dev)));
 	cdev_del(&pinstance->cdev);
 }
@@ -5390,10 +5392,10 @@ static int __init pmcraid_init(void)
 	}
 
 	pmcraid_major = MAJOR(dev);
-	pmcraid_class = class_create(PMCRAID_DEVFILE);
 
-	if (IS_ERR(pmcraid_class)) {
-		error = PTR_ERR(pmcraid_class);
+	error = class_register(&pmcraid_class);
+
+	if (error) {
 		pmcraid_err("failed to register with sysfs, error = %x\n",
 			    error);
 		goto out_unreg_chrdev;
@@ -5402,7 +5404,7 @@ static int __init pmcraid_init(void)
 	error = pmcraid_netlink_init();
 
 	if (error) {
-		class_destroy(pmcraid_class);
+		class_unregister(&pmcraid_class);
 		goto out_unreg_chrdev;
 	}
 
@@ -5413,7 +5415,7 @@ static int __init pmcraid_init(void)
 
 	pmcraid_err("failed to register pmcraid driver, error = %x\n",
 		     error);
-	class_destroy(pmcraid_class);
+	class_unregister(&pmcraid_class);
 	pmcraid_netlink_release();
 
 out_unreg_chrdev:
@@ -5432,7 +5434,7 @@ static void __exit pmcraid_exit(void)
 	unregister_chrdev_region(MKDEV(pmcraid_major, 0),
 				 PMCRAID_MAX_ADAPTERS);
 	pci_unregister_driver(&pmcraid_driver);
-	class_destroy(pmcraid_class);
+	class_unregister(&pmcraid_class);
 }
 
 module_init(pmcraid_init);

-- 
2.43.0


