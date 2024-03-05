Return-Path: <linux-kernel+bounces-92952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38CA872880
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B0F1F2C345
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6858A127B7D;
	Tue,  5 Mar 2024 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="bVCxnkPh"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01B8D27E;
	Tue,  5 Mar 2024 20:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670101; cv=none; b=RpgQ4l9/y9CWupJaUz9D0Lkwb5OxrDAynR7AS5fmkgmjEuA/NBexPsq8RK6HysCDT/lIJgb1pwqFmqBFbFXuVUyBzwYs6d0sQre1n0lYdnHe/vqSrWFRZQcWqyhQjh654etVSKe6mtuSk2ymZxr/INZ/fUY9UsDfJqEe7Psw5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670101; c=relaxed/simple;
	bh=mL6fEtV4dWTChRIioAI8WVMr3ESdzLnLOnDpYBV2TOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R8znpuxcx97jx0PzKJAa45jcJrOCF+fHe86Nr8uTDQi3zvQ/3baS9iRNGcHVIhiTbKZDbVbgnWffT17nX+/uaKJH4q6barqb6eFrwHoG/EV3kln4FwyNm2hI32O+thTfKiyW/HCQNeqBxaKRDQf0C5hajkUaSd9WTpqFb2YOP64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=bVCxnkPh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e56787e691so122110b3a.0;
        Tue, 05 Mar 2024 12:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709670099; x=1710274899;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fI7n1PPcQRS/z7Y+0uW1YEXs3Os4Jab/vlVX9n/14s=;
        b=iMYspoADpVLdA0BHlhZI0o6lFnlAmabVKAHGwiXIKVWz2x73vdJUQg2/BdPU9vTHE2
         ldLA0ZVoTWjq1O+5CHfIPnFii1Jrl1hZ57iJiSly9B5RwTJIui/zxS0troG6gGWOMkmr
         /0ZwiBpYqQQIRJvylD0yURcuws7aYUFZRGNqF8T3nJRWifWo4OHkJkcwNvE56vXwPcBz
         vjSFJ/GLr7R8NF0MX35iuv3W6OWUDrXj2ZolyiXPPXGsH7z8Qydo1pdOFoKDFJhhxYOT
         AoBmpeuzTx3eobX6hc4iXWL7vknhC9lCyLkFd4d7/j1vG9aQAxuz9FO3PE0/zthFSRls
         rfEA==
X-Forwarded-Encrypted: i=1; AJvYcCVGyZgiFtCBODopVa/9YIUaWC7mXQxMr9DeRigZhMpZpvzY9NGXi1Hu7azpbuq7MO06Us8J4LquM+5L+wL+irNd2qmn/CdBR7paadQw
X-Gm-Message-State: AOJu0YynTkyjW8FjRFf0hH96AYvdmT4KynD2wPwscVzfCIPfz95KAjGA
	+fO22Di5IPcvbRhVKD4fGIodO+YIkIQqHV+LqMZmUY8ubrLcoLlN
X-Google-Smtp-Source: AGHT+IHUHT+tHH2aFzEIfVJ1KU2MlsE5d6mLNfgPCr5AQGn6F8f/PX/FexxVhnrwEcNjipBoZK+xQQ==
X-Received: by 2002:a05:6a21:3989:b0:1a1:1f2f:cb36 with SMTP id ad9-20020a056a21398900b001a11f2fcb36mr3579636pzc.26.1709670099269;
        Tue, 05 Mar 2024 12:21:39 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id k19-20020a63ff13000000b005cfb6e7b0c7sm9753926pgi.39.2024.03.05.12.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 12:21:38 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709670097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1fI7n1PPcQRS/z7Y+0uW1YEXs3Os4Jab/vlVX9n/14s=;
	b=bVCxnkPhHL6GmYduWZxA8dusBqwu5W+3LH25CjETtIx8VbkcR/M/Jh2GBBLBTxtaqnykD2
	2mmTkYbrlK23waWi/I+IbvWb/eqZev1gxo2CqigGe/vN84g4kpvkIqh4v8PTMl9vso9k6g
	qxHIiyBrJTuWSXTWZwdLlvnd2ny0l/Qyd8x7pOiH3cTk0+McOAMoqFMFYDuedR10LiD4N6
	Ci+C/gg1W4LGkdMAI8Oa0eRrz3G4RstugHeI1tYLBIdMRU33ES60e1DsiuLvdrvd7BVyvz
	XAM01QsZfg7wv/J2FWbTDXDBIrfTkncRdeGhuTadrF8YoH/aQ6mEBuzF+EofIg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 17:21:33 -0300
Subject: [PATCH] bcachefs: chardev: make bch_chardev_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-bcachefs-v1-1-436196e25729@marliere.net>
X-B4-Tracking: v=1; b=H4sIAMx+52UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwNT3aTkxOSM1LRiXSPzRJOkJIskyzSTNCWg8oKi1LTMCrBR0bG1tQA
 SPO7vWgAAAA==
To: Kent Overstreet <kent.overstreet@linux.dev>, 
 Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2730; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=mL6fEtV4dWTChRIioAI8WVMr3ESdzLnLOnDpYBV2TOw=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl537O34rw+Kc2CHNrIkd5UEsovB7PcG8xybS9v
 mGB38YCN2iJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZed+zgAKCRDJC4p8Y4ZY
 pvYaEAC1QirLZS5BzwnEiGj16OUo2/vNFZ5T8+cy/r8nKNFv4aO9Rtt48JCr+lUJPffYxhvQ30t
 Yqd6phY0czQqtZg2uyf/7XYfNxnqymUPo+GlKapqs3H9EtMAriiKK7FaXq5w+ZgWWTWhYvolr+n
 9SoEJ8XO4yis3El/NHFTyE/g2clDoaw3EuGF98gPMpEO/s8wQJZTA+8rLCu30KJSKuNUTEBzoZk
 SBH1+mKM6SgHqPrCCgOnbXHRdxHJUKiemVuS4twJtobA9HP9Oyoh1axjVjfcggyZWHS4SZaXYwE
 xbiONqGH/us+kAGsaxzX0hLW/okGeBPfEf/fzU3cAzESR3SpJaucqYpXPbe5gD/Kn8dtt0cei8Y
 EeptkOXd7ksQCAMuglQVaQoARGecpJiHG1m9R0rBG5IUEdqx/VT6KM6psAstjtyDsJSODjjC7oe
 9aipOf24GwTWuRgFpOt0PD5bJqQFQwPZtM3p6+4DbPf0eg1M2ldjENSGz+wVYbPalE4s4CidKII
 dPmRmWtciTk1K2VMSpUyCJU+rqPEh6OaddK2JDM/EM6Nf/+gQ3xEZNJOAOplK1/Xh7XuUBhTGl4
 LVwHAHGZRKKoJy99hR/hQyT1DcEgJ3j8r1HgPKMPF9S1X5uxu4eATis7xs4aLPFpjTrhXIi9sq+
 fyVghRsonZFtP8Q==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the bch_chardev_class structure to be declared at build
time placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 fs/bcachefs/chardev.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
index 226b39c17667..af587453fd3d 100644
--- a/fs/bcachefs/chardev.c
+++ b/fs/bcachefs/chardev.c
@@ -940,7 +940,9 @@ static const struct file_operations bch_chardev_fops = {
 };
 
 static int bch_chardev_major;
-static struct class *bch_chardev_class;
+static const struct class bch_chardev_class = {
+	.name = "bcachefs",
+};
 static struct device *bch_chardev;
 
 void bch2_fs_chardev_exit(struct bch_fs *c)
@@ -957,7 +959,7 @@ int bch2_fs_chardev_init(struct bch_fs *c)
 	if (c->minor < 0)
 		return c->minor;
 
-	c->chardev = device_create(bch_chardev_class, NULL,
+	c->chardev = device_create(&bch_chardev_class, NULL,
 				   MKDEV(bch_chardev_major, c->minor), c,
 				   "bcachefs%u-ctl", c->minor);
 	if (IS_ERR(c->chardev))
@@ -968,26 +970,25 @@ int bch2_fs_chardev_init(struct bch_fs *c)
 
 void bch2_chardev_exit(void)
 {
-	if (!IS_ERR_OR_NULL(bch_chardev_class))
-		device_destroy(bch_chardev_class,
-			       MKDEV(bch_chardev_major, U8_MAX));
-	if (!IS_ERR_OR_NULL(bch_chardev_class))
-		class_destroy(bch_chardev_class);
+	device_destroy(&bch_chardev_class, MKDEV(bch_chardev_major, U8_MAX));
+	class_unregister(&bch_chardev_class);
 	if (bch_chardev_major > 0)
 		unregister_chrdev(bch_chardev_major, "bcachefs");
 }
 
 int __init bch2_chardev_init(void)
 {
+	int ret;
+
 	bch_chardev_major = register_chrdev(0, "bcachefs-ctl", &bch_chardev_fops);
 	if (bch_chardev_major < 0)
 		return bch_chardev_major;
 
-	bch_chardev_class = class_create("bcachefs");
-	if (IS_ERR(bch_chardev_class))
-		return PTR_ERR(bch_chardev_class);
+	ret = class_register(&bch_chardev_class);
+	if (ret)
+		return ret;
 
-	bch_chardev = device_create(bch_chardev_class, NULL,
+	bch_chardev = device_create(&bch_chardev_class, NULL,
 				    MKDEV(bch_chardev_major, U8_MAX),
 				    NULL, "bcachefs-ctl");
 	if (IS_ERR(bch_chardev))

---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240305-bcachefs-27a4bb8b9f4f

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


