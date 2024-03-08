Return-Path: <linux-kernel+bounces-96985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E87D876419
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C416628384D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4CE56764;
	Fri,  8 Mar 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="J64+HuIP"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474C055E57;
	Fri,  8 Mar 2024 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899978; cv=none; b=PsXoYMOthFQhtml6VBnuCdKu3ZMYEbsJg/9VZuo8kdZwqHn+CL43aZViejFdtOk3V3JFLqwSFlyiuy5r2wAWzbWxokyABIFOw1tIkeqBp4NkVOzNAOMtmCEYnBiYKoU5zzwEJ7minqv9kIA+zQF/n/kJl0XICqAfGyGGARmNufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899978; c=relaxed/simple;
	bh=K2sCIAlU6dXk5ratr4Vv5OEgr6af+7vpwMRF89XMaYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PF3a6vdqR9P1G20Pp/1D+SMR4s4rd7rPsUY4nOOeVjo3+nXOaCQL0gSn9WBqXBU4w6BNrSSlcPCImSc7tUd6w72p8K2QVs4WQ38zgZXP6OcrpQn+4ONaww3kKjGd223fKO/uMxXyin3rDYQnPSghlBHyskQC6wnZe0r5LOHKktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=J64+HuIP; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e655a12c81so1621944b3a.1;
        Fri, 08 Mar 2024 04:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709899975; x=1710504775;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6o7+NY2dQ7MkSysTTxlBFTXs4hpEZRChFXdmrSC3bNU=;
        b=XGTDS6gKtqutu9iV5T3Ql5VzlrWjb7Arrk1nHLRidcxEgtcCtG5EL2mrYSHbLzu8on
         Chcl6a02N0mUtFD02kqfFUVho9d7h5k6IQD0/thzLrpNdPiT+SLm1+GlskJBPXLqFzA1
         l5fasZoOidp0wviv1WKjR+lr5t68ycnYSSYOEO30u76/Nd8buncXQowZyibMVWADZSgX
         hymryPowxhi9kiqnJEE2Yxg/1Th9dmyMVlV19NjC/j43KrpxR/OYGIKa4KxtyMtYV4N7
         OYelkwyNfrz7cJ0lC6a22PKA32jfUL+YV4JFQDpLwAaj1nXLtQEBiRklxJnwKcx9VB8I
         LAEg==
X-Forwarded-Encrypted: i=1; AJvYcCVGUbSjmDvrZJ3ju6HwkzD4pFWqzuKKlh20FgJX7S1uJYrz5Cqe+4deUR47fbO06Wig3XuEkzL2MaPmq/mp0FHUF6JKPn7/ZQ6ZoudL
X-Gm-Message-State: AOJu0YxnbVfXT62XAI3BhJ/vSysDeXjuQN4SkUuzilYPmzUBgjRmNiAZ
	P/Wr94CUooIKR7KfSjg2SdoZld09CwXTRhFcnff4nvvQazpmAd1I
X-Google-Smtp-Source: AGHT+IFBEJu0m/gXsSid5i1KOm+ANI8Pj+R4gkyVkj9EKHng9vTBwDLzP/m+KMVXIVH1efJ0nwkY5g==
X-Received: by 2002:a17:902:e5c9:b0:1dc:c8b3:9376 with SMTP id u9-20020a170902e5c900b001dcc8b39376mr76845plf.7.1709899975314;
        Fri, 08 Mar 2024 04:12:55 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b001d9d4375149sm16094710plg.215.2024.03.08.04.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 04:12:54 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709899973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6o7+NY2dQ7MkSysTTxlBFTXs4hpEZRChFXdmrSC3bNU=;
	b=J64+HuIPw1LXPn6yF1yJq5QwpYBGqgFFLdjInSVhKkoyn1Qe43pyQ+AVT/G3MBhSKjW5LK
	HOKpjaC8t4Hg/PBgS8EM0EGYDtzbYkVfjazuRBQizEI55Z1+w7q3ZCt3RGz5eLHoL8EJuX
	ZfVCcxHnMDbx/d/MBdHf9kqe++cMWMiFSdhRhkKQjqwKsEOxdse5qBjTqpg/1AWBWsPO+D
	KMuWJl9wXeT4N8k4LaGYidXFMhN8mW34c4Vzy5xIj3JR0+kbn0YIzY2hb5wAgy3eNu9yg7
	Ush6EFdY/QlXc99/XD8weFvMHTZESYsH+m5cxsa62q6TkNEUuKckD7bM1WNZdA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Fri, 08 Mar 2024 09:12:47 -0300
Subject: [PATCH v2] bcachefs: chardev: make bch_chardev_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-bcachefs-v2-1-3e84c845055e@marliere.net>
X-B4-Tracking: v=1; b=H4sIAL4A62UC/23MQQ7CIBCF4as0sxYDlLbiynuYLgAHmUSpgYZoG
 u4udu3yf3n5NsiYCDOcuw0SFsq0xBby0IELJt6R0a01SC4V7/nArDMuoM9MTkZZe7LaKw/t/kr
 o6b1T17l1oLwu6bPLRfzWP0gRTDDVj0KPKIdJ6svTpAdhwmPEFeZa6xf0xh6jowAAAA==
To: Kent Overstreet <kent.overstreet@linux.dev>, 
 Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hongbo Li <lihongbo22@huawei.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3348; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=K2sCIAlU6dXk5ratr4Vv5OEgr6af+7vpwMRF89XMaYU=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl6wDBHcpFMUWrsbq8OZSINLnfyVLs1ZsmFSIOt
 X0eqOY8jkyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZesAwQAKCRDJC4p8Y4ZY
 poZcEACrCm1DrTpffhSMz45nWyULhbZuxUB44yhj+rBzxvuC1bdxtZTZJZJs+PvI0oPDgX9Gqee
 1AiHIlbk2zjKT4gZAUT+qNGBEOe8kpI/z1IZ7fgdXjMnU1bQnQZfkczQxkw+BMcLsEnd6e9b+1x
 o6EG02mGj+tjMcKTw40lUdzC7PPs5JH3Ai4nMRsXAZ+Mshbz4Ao4flVqEstTC4+OaRjN8P4LXOC
 11Em7aSmlmKn05SktoRXdePNktwV3tzzFveOLBalpSF/mmzuCy7twRCBMVXZUKD7CAHNfkZQEyL
 iX1yKITREn3GeCdm8s9qK4diTskAFq0OCJJFughPaRn+wlYNb7BTMJFrE9X1m4GdM3PxtqH/15X
 G3biqC3KUINOtG4oE76Xuear3hlZyLyUt+30Z764J6X0ziJQFTb+2cnjDGFv8Ti7OwpkcaHzWcc
 PONZGw68NH/APdE+f7+abOJckuYCuoHFCmETs7ud4qxx2VAoub6yu0Gl+otbGUi9w8Td01mRKXp
 HPL201nmB7J5b9O96EhUJwr6qP0IltpLBUpqqH6VjF8t3WnCZltADX01mRu6Ye3gfD1iLNkk7Ne
 jeksoBsn2+RsvF+pf0pzXsKitEtMYrG/n+BBZtFirXw54Pwgi/7XZIfNUjd5n4bA7yzVQ+xLPgI
 NVX5XIxEP/Ri8VQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the bch_chardev_class structure to be declared at build
time placing it into read-only memory, instead of having to be dynamically
allocated at boot time. Also, correctly clean up after failing paths in
bch2_chardev_init().

Cc: Hongbo Li <lihongbo22@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Changes in v2:
- Used "free the last thing" pattern in bch2_chardev_init().
- Link to v1: https://lore.kernel.org/r/20240305-bcachefs-v1-1-436196e25729@marliere.net
---
 fs/bcachefs/chardev.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
index 226b39c17667..dc09f547dae6 100644
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
@@ -968,32 +970,39 @@ int bch2_fs_chardev_init(struct bch_fs *c)
 
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
+		goto major_out;
 
-	bch_chardev = device_create(bch_chardev_class, NULL,
+	bch_chardev = device_create(&bch_chardev_class, NULL,
 				    MKDEV(bch_chardev_major, U8_MAX),
 				    NULL, "bcachefs-ctl");
-	if (IS_ERR(bch_chardev))
-		return PTR_ERR(bch_chardev);
+	if (IS_ERR(bch_chardev)) {
+		ret = PTR_ERR(bch_chardev);
+		goto class_out;
+	}
 
 	return 0;
+
+class_out:
+	class_unregister(&bch_chardev_class);
+major_out:
+	unregister_chrdev(bch_chardev_major, "bcachefs-ctl");
+	return ret;
 }
 
 #endif /* NO_BCACHEFS_CHARDEV */

---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240305-bcachefs-27a4bb8b9f4f

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


