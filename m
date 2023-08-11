Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A845F779970
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbjHKVbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjHKVbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:31:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7A6E3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:31:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-317604e2bdfso530347f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691789460; x=1692394260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fjV6qKSF6aNL70MxX+nVDf7r3LoS4zwfiZud58N8lxc=;
        b=AaNF+/y4SX2q0WNz1yT4dUHwOt1rRk2oAzNVR0GvDyDxFhJ2WhhQWz0qJSTZt5+utQ
         L+4dPE4Qh0zw5MoPFpUhEgDoUQ37v+C562cTDZQb+wgAqpmXmv7dVS+J0kEfttrCSYIX
         6Ru5WaodIxdrbBULM8xJ0PGRJhqfkBhTtTnb7MQiEB3COROmQhEut7qEH7NBDMGPZegR
         ISFqwyzY0i+kzwMx+EqAVxHKvWLeRFnqB4+wuIZMk2j17LEQ5OQn29a2AQZSHlPtYXYq
         ei5j7491QP3r72CJa9YnVXDAilJ7CBReS7lKnwpdld6MhoHdPQcdHd7Dk5Dk52Hx4S4N
         7DWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691789460; x=1692394260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjV6qKSF6aNL70MxX+nVDf7r3LoS4zwfiZud58N8lxc=;
        b=W1OfvNipKE4eNms196zDAAffM9bCippjccq/5aUnu79mb2ydSLuXVze5QvjhBXbG53
         Aqe/xk/P3YOh+ruWWaqYamyo7xh9o+WlbW5K/YEzCtjsJtTW4giqWbM0IskN79f3QZud
         CfQ73u3SslBPDtVlW29ll/CDM9w2Hpcqw9VWgINDUZh6UUmzZRVYPPHuNSnQt7t9WlJu
         vO9dbxBw4SiDS4UMLxuRno0sMwYjSEgY8bmrmkHPv6uDo8fkY/PvnZ8dUVZlgl6VWoLv
         2a6wgzstFYRDVET2vMViVWeJPOgL6XI4dc9eqh7tnIuwdhrbIEFpETccR3izbGkoO8oq
         x7vg==
X-Gm-Message-State: AOJu0Yx5M1G1pak4Hf9FOJSb05tqyIUYXQa8L1Rb1YC64obFCeT9oC2v
        3s05bMDu5fInVGafzJ1OJWs=
X-Google-Smtp-Source: AGHT+IGuh1V61dsAgquTN1frOeUQBUfxzfV4OjiY1Gc7TL31Iv8ISDoSpke8s1RPk7D3pdnbVGFVfw==
X-Received: by 2002:adf:dd82:0:b0:2c7:1c72:699f with SMTP id x2-20020adfdd82000000b002c71c72699fmr2256290wrl.4.1691789459807;
        Fri, 11 Aug 2023 14:30:59 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5941000000b003141f96ed36sm6565083wri.0.2023.08.11.14.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 14:30:59 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     tomas.winkler@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mei: make mei_class a static const structure
Date:   Sat, 12 Aug 2023 01:30:52 +0400
Message-Id: <20230811213052.85044-1-ivan.orlov0322@gmail.com>
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
memory, move the mei_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Add extra new line after mei_class definition
- Simplify 'class_register' call error processing logic
- Remove redundant 'err' label in 'mei_init' function

 drivers/misc/mei/main.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 51876da3fd65..bb4e9eabda97 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -27,7 +27,10 @@
 #include "mei_dev.h"
 #include "client.h"
 
-static struct class *mei_class;
+static const struct class mei_class = {
+	.name = "mei",
+};
+
 static dev_t mei_devt;
 #define MEI_MAX_DEVS  MINORMASK
 static DEFINE_MUTEX(mei_minor_lock);
@@ -1115,7 +1118,7 @@ void mei_set_devstate(struct mei_device *dev, enum mei_dev_state state)
 
 	dev->dev_state = state;
 
-	clsdev = class_find_device_by_devt(mei_class, dev->cdev.dev);
+	clsdev = class_find_device_by_devt(&mei_class, dev->cdev.dev);
 	if (clsdev) {
 		sysfs_notify(&clsdev->kobj, NULL, "dev_state");
 		put_device(clsdev);
@@ -1232,7 +1235,7 @@ int mei_register(struct mei_device *dev, struct device *parent)
 		goto err_dev_add;
 	}
 
-	clsdev = device_create_with_groups(mei_class, parent, devno,
+	clsdev = device_create_with_groups(&mei_class, parent, devno,
 					   dev, mei_groups,
 					   "mei%d", dev->minor);
 
@@ -1264,7 +1267,7 @@ void mei_deregister(struct mei_device *dev)
 
 	mei_dbgfs_deregister(dev);
 
-	device_destroy(mei_class, devno);
+	device_destroy(&mei_class, devno);
 
 	mei_minor_free(dev);
 }
@@ -1274,12 +1277,9 @@ static int __init mei_init(void)
 {
 	int ret;
 
-	mei_class = class_create("mei");
-	if (IS_ERR(mei_class)) {
-		pr_err("couldn't create class\n");
-		ret = PTR_ERR(mei_class);
-		goto err;
-	}
+	ret = class_register(&mei_class);
+	if (ret)
+		return ret;
 
 	ret = alloc_chrdev_region(&mei_devt, 0, MEI_MAX_DEVS, "mei");
 	if (ret < 0) {
@@ -1298,15 +1298,14 @@ static int __init mei_init(void)
 err_chrdev:
 	unregister_chrdev_region(mei_devt, MEI_MAX_DEVS);
 err_class:
-	class_destroy(mei_class);
-err:
+	class_unregister(&mei_class);
 	return ret;
 }
 
 static void __exit mei_exit(void)
 {
 	unregister_chrdev_region(mei_devt, MEI_MAX_DEVS);
-	class_destroy(mei_class);
+	class_unregister(&mei_class);
 	mei_cl_bus_exit();
 }
 
-- 
2.34.1

