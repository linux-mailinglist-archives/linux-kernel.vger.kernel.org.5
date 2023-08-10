Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03077803C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbjHJS1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjHJS1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:27:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8782E128
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:27:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe1f70a139so2486785e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691692056; x=1692296856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/HRKqqfzlybbOSlLJ2y7d/l9PH3nrC4QpibU3Ry59JA=;
        b=DmhIrHFgZRBrvUMQrLaQsE+A/oib1/Rah5i3/xO/CVnKDTQylJGYu7QL8tprTOd0qL
         T1MHPGbWF8ePz+gVLR0YDeEUk9ClDGVx27czwRh4H245Y3evfSLcskpOPjMXgbo3/sDl
         lc/pQ6M/VQrTRSccBl5iNCgsuAS7rOsSvdHV3yoLVQnyxYR6AXvVIDNNHHYA0NrpY2Fd
         Ww6tsQ20zjXMZqbDaDbV8OxeMspUFxFBh9naYI13JzTLAd5ouHGBx5raMWrzINIAo8hq
         tym55eEUJRF8LzX/Ax2uJJlV7tyCWbQKw9zlBkexROt/DU3J8zJ1N6h9YoSdM78lAouK
         cIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691692056; x=1692296856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HRKqqfzlybbOSlLJ2y7d/l9PH3nrC4QpibU3Ry59JA=;
        b=OnZ2UctJcrvqg4Axl/JDWusrqxvzRBr5XS//ekZo2e2n3cuPo8o3lwvDx2noS4e23b
         eipNcBvIo+3gMe6rP48ycDQEs7ZyXxNfx7xOLDIsLfYfa1J4TE5hpdxsXDmScj1rosmT
         Q9mWKulTvwLgMzyCyl22WI2usud8Oa/rYNrglBTpu3wOJkMAAvLjb7//qAROtKbOZJtI
         BZBHrY+/bxzyqy6w61v369WvAU/24itzMQ2rID2fB4r1uwFLvoIXPhfak4KrFSkMl8fj
         5twwoXVdz1aBqrLlZJC/Lkn7b960khGN7GksS1ow3j08LjZ71kiz95y5HMkauHDkFjZV
         kqIQ==
X-Gm-Message-State: AOJu0YzaAWd/YmP+y5UVZgBD7qTD0eaghYPftmim112B5kDQILazS4U2
        +eHS7H66U7jEj7SMbqyBzVE=
X-Google-Smtp-Source: AGHT+IEibejvfc77t/9JaX442UJZq0VD+yvsosvjwtAwuPVR2qDC5wNeR1uCkwBD6YuZ3RwBjvpQOA==
X-Received: by 2002:a05:600c:4f90:b0:3fe:4c2a:1d9 with SMTP id n16-20020a05600c4f9000b003fe4c2a01d9mr2853703wmq.4.1691692055573;
        Thu, 10 Aug 2023 11:27:35 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c025400b003fa98908014sm5872920wmj.8.2023.08.10.11.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:27:35 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     haver@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: genwqe: make class_genwqe a static const structure
Date:   Thu, 10 Aug 2023 22:27:11 +0400
Message-Id: <20230810182711.22664-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core allows for struct class to be in read-only
memory, move the class_genwqe structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time. Update the 'class_genwqe' field of the
'genwqe_dev' struct correspondingly.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/misc/genwqe/card_base.c | 49 +++++++++++++++++----------------
 drivers/misc/genwqe/card_base.h |  2 +-
 2 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index b03010810b89..224a7e97cbea 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -42,7 +42,7 @@ MODULE_VERSION(DRV_VERSION);
 MODULE_LICENSE("GPL");
 
 static char genwqe_driver_name[] = GENWQE_DEVNAME;
-static struct class *class_genwqe;
+
 static struct dentry *debugfs_genwqe;
 static struct genwqe_dev *genwqe_devices[GENWQE_CARD_NO_MAX];
 
@@ -104,6 +104,26 @@ static const struct pci_device_id genwqe_device_table[] = {
 
 MODULE_DEVICE_TABLE(pci, genwqe_device_table);
 
+/**
+ * genwqe_devnode() - Set default access mode for genwqe devices.
+ * @dev:	Pointer to device (unused)
+ * @mode:	Carrier to pass-back given mode (permissions)
+ *
+ * Default mode should be rw for everybody. Do not change default
+ * device name.
+ */
+static char *genwqe_devnode(const struct device *dev, umode_t *mode)
+{
+	if (mode)
+		*mode = 0666;
+	return NULL;
+}
+
+static const struct class class_genwqe = {
+	.name = GENWQE_DEVNAME,
+	.devnode = genwqe_devnode,
+};
+
 /**
  * genwqe_dev_alloc() - Create and prepare a new card descriptor
  *
@@ -126,7 +146,7 @@ static struct genwqe_dev *genwqe_dev_alloc(void)
 		return ERR_PTR(-ENOMEM);
 
 	cd->card_idx = i;
-	cd->class_genwqe = class_genwqe;
+	cd->class_genwqe = &class_genwqe;
 	cd->debugfs_genwqe = debugfs_genwqe;
 
 	/*
@@ -1339,21 +1359,6 @@ static struct pci_driver genwqe_driver = {
 	.err_handler = &genwqe_err_handler,
 };
 
-/**
- * genwqe_devnode() - Set default access mode for genwqe devices.
- * @dev:	Pointer to device (unused)
- * @mode:	Carrier to pass-back given mode (permissions)
- *
- * Default mode should be rw for everybody. Do not change default
- * device name.
- */
-static char *genwqe_devnode(const struct device *dev, umode_t *mode)
-{
-	if (mode)
-		*mode = 0666;
-	return NULL;
-}
-
 /**
  * genwqe_init_module() - Driver registration and initialization
  */
@@ -1361,14 +1366,12 @@ static int __init genwqe_init_module(void)
 {
 	int rc;
 
-	class_genwqe = class_create(GENWQE_DEVNAME);
-	if (IS_ERR(class_genwqe)) {
+	rc = class_register(&class_genwqe);
+	if (rc) {
 		pr_err("[%s] create class failed\n", __func__);
 		return -ENOMEM;
 	}
 
-	class_genwqe->devnode = genwqe_devnode;
-
 	debugfs_genwqe = debugfs_create_dir(GENWQE_DEVNAME, NULL);
 
 	rc = pci_register_driver(&genwqe_driver);
@@ -1381,7 +1384,7 @@ static int __init genwqe_init_module(void)
 
  err_out0:
 	debugfs_remove(debugfs_genwqe);
-	class_destroy(class_genwqe);
+	class_unregister(&class_genwqe);
 	return rc;
 }
 
@@ -1392,7 +1395,7 @@ static void __exit genwqe_exit_module(void)
 {
 	pci_unregister_driver(&genwqe_driver);
 	debugfs_remove(debugfs_genwqe);
-	class_destroy(class_genwqe);
+	class_unregister(&class_genwqe);
 }
 
 module_init(genwqe_init_module);
diff --git a/drivers/misc/genwqe/card_base.h b/drivers/misc/genwqe/card_base.h
index 0e902977d35f..d700266f2cd0 100644
--- a/drivers/misc/genwqe/card_base.h
+++ b/drivers/misc/genwqe/card_base.h
@@ -289,7 +289,7 @@ struct genwqe_dev {
 
 	/* char device */
 	dev_t  devnum_genwqe;		/* major/minor num card */
-	struct class *class_genwqe;	/* reference to class object */
+	const struct class *class_genwqe;	/* reference to class object */
 	struct device *dev;		/* for device creation */
 	struct cdev cdev_genwqe;	/* char device for card */
 
-- 
2.34.1

