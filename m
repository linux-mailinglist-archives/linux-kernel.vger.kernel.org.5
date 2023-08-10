Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5590F777F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjHJRW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjHJRWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:22:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C892733;
        Thu, 10 Aug 2023 10:22:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe247796ccso2345015e9.1;
        Thu, 10 Aug 2023 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691688138; x=1692292938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nm5CzUEsnxqhaEVu4VzCbvkfQqrKkziEtlUo4iZJpC8=;
        b=V05ckOHRS5w9+RSk3PTcklQxh9iiEp/YGMPAUsd0VbN1idJG1WJgX/LjRBxf6XMQ1F
         3FrYvc4gssnQusqAHEui1m7Mw2VRxbOBxRviuEOEJJDkyCf9ogrHJLt9G0UmkvzE4zp/
         LiCtJ9ZWzokkj/Sq/zQn6Al13OpBrkfJlCobByApT3ybJcByy1Mi0MjcWzrn7AXvaeV3
         TAt2zBSjVAsOMR/rGtTgBf5X7BDl/pfRs5bv7/wLbc4zozjW1B3oH8moLE5HnPJiCfTQ
         sSWA7t1ei6BCp6oZWffZ3ZcuUmD6xxLeXcjQDC0GOkkqPhm/+BzC0jkGpVOGbayu+npe
         l0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691688138; x=1692292938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nm5CzUEsnxqhaEVu4VzCbvkfQqrKkziEtlUo4iZJpC8=;
        b=gOesnmEI0Zqn1YdZheDtRHzg8ggTXNbbktmilau2eSxaRE36sWiMqy98ESsy/JR8mj
         DmZmNeVyCLOkBSQRoBuifSg2y3GPVHJbjZH49RxbZSm8fcUpJ3v6PY3yRN85LoeHdn2i
         UtHvfPC8+fp/S9Y5l/hpBxD/S5gAwWE2ScZCPFhsmS7FVo8EY/81Oq9UPDWDENgALNTH
         jMebZHdhoSJ1lezVzJAYtm4ilkljViOKE8xK5uZuzzGstWUyyROyyQsDC+zaWfcXBaLv
         IQAqg9zQ5QSjY4KBODxcm47rJjdCARvru9ue9J5bYQxnQuIeixrtZj/kVVd7UItYAzhd
         u/fA==
X-Gm-Message-State: AOJu0YxbVdSxl1Hdz1OHMQKDUIC/iuon3/zgelo/E+NYBkkx8Ji2Sfnq
        tkrnIptX435y6paraTqHHzg=
X-Google-Smtp-Source: AGHT+IHdMEGYvDD01uD6H3/hRGSeQWKfud6ga2tbleMEXnZZ3eRqiyTAqJllkJfXqkZHK0HQWs9eGQ==
X-Received: by 2002:a5d:4fc5:0:b0:317:3d35:b809 with SMTP id h5-20020a5d4fc5000000b003173d35b809mr2590542wrw.2.1691688137578;
        Thu, 10 Aug 2023 10:22:17 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b003144b95e1ecsm2715754wrp.93.2023.08.10.10.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:22:17 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 3/3] fpga: region: make fpga_region_class a static const structure
Date:   Thu, 10 Aug 2023 21:22:10 +0400
Message-Id: <20230810172210.6338-3-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810172210.6338-1-ivan.orlov0322@gmail.com>
References: <20230810172210.6338-1-ivan.orlov0322@gmail.com>
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
memory, move the fpga_region_class structure to be declared at build
time placing it into read-only memory, instead of having to be
dynamically allocated at boot time.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/fpga/fpga-region.c | 64 ++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index ccf6fdab1360..01cf4c2f83d1 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -16,21 +16,6 @@
 #include <linux/spinlock.h>
 
 static DEFINE_IDA(fpga_region_ida);
-static struct class *fpga_region_class;
-
-struct fpga_region *
-fpga_region_class_find(struct device *start, const void *data,
-		       int (*match)(struct device *, const void *))
-{
-	struct device *dev;
-
-	dev = class_find_device(fpga_region_class, start, data, match);
-	if (!dev)
-		return NULL;
-
-	return to_fpga_region(dev);
-}
-EXPORT_SYMBOL_GPL(fpga_region_class_find);
 
 /**
  * fpga_region_get - get an exclusive reference to an fpga region
@@ -179,6 +164,34 @@ static struct attribute *fpga_region_attrs[] = {
 };
 ATTRIBUTE_GROUPS(fpga_region);
 
+static void fpga_region_dev_release(struct device *dev)
+{
+	struct fpga_region *region = to_fpga_region(dev);
+
+	ida_free(&fpga_region_ida, region->dev.id);
+	kfree(region);
+}
+
+static const struct class fpga_region_class = {
+	.name = "fpga_region",
+	.dev_groups = fpga_region_groups,
+	.dev_release = fpga_region_dev_release,
+};
+
+struct fpga_region *
+fpga_region_class_find(struct device *start, const void *data,
+		       int (*match)(struct device *, const void *))
+{
+	struct device *dev;
+
+	dev = class_find_device(&fpga_region_class, start, data, match);
+	if (!dev)
+		return NULL;
+
+	return to_fpga_region(dev);
+}
+EXPORT_SYMBOL_GPL(fpga_region_class_find);
+
 /**
  * fpga_region_register_full - create and register an FPGA Region device
  * @parent: device parent
@@ -216,7 +229,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
 	mutex_init(&region->mutex);
 	INIT_LIST_HEAD(&region->bridge_list);
 
-	region->dev.class = fpga_region_class;
+	region->dev.class = &fpga_region_class;
 	region->dev.parent = parent;
 	region->dev.of_node = parent->of_node;
 	region->dev.id = id;
@@ -279,33 +292,18 @@ void fpga_region_unregister(struct fpga_region *region)
 }
 EXPORT_SYMBOL_GPL(fpga_region_unregister);
 
-static void fpga_region_dev_release(struct device *dev)
-{
-	struct fpga_region *region = to_fpga_region(dev);
-
-	ida_free(&fpga_region_ida, region->dev.id);
-	kfree(region);
-}
-
 /**
  * fpga_region_init - init function for fpga_region class
  * Creates the fpga_region class and registers a reconfig notifier.
  */
 static int __init fpga_region_init(void)
 {
-	fpga_region_class = class_create("fpga_region");
-	if (IS_ERR(fpga_region_class))
-		return PTR_ERR(fpga_region_class);
-
-	fpga_region_class->dev_groups = fpga_region_groups;
-	fpga_region_class->dev_release = fpga_region_dev_release;
-
-	return 0;
+	return class_register(&fpga_region_class);
 }
 
 static void __exit fpga_region_exit(void)
 {
-	class_destroy(fpga_region_class);
+	class_unregister(&fpga_region_class);
 	ida_destroy(&fpga_region_ida);
 }
 
-- 
2.34.1

