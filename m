Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCC8777F09
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbjHJRWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbjHJRWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:22:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A3B2724;
        Thu, 10 Aug 2023 10:22:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fc03d990daso2119945e9.1;
        Thu, 10 Aug 2023 10:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691688135; x=1692292935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ESX8jAZRMo0gjvLYfMQ8jMxb77KHrwWoztuYb2u+dsY=;
        b=e/yYF4THhRcmCilKXIkRYuIV1pvoDaqrFyuy5PiV1+90ImFVpAQQA+lg9UsbAz/r7j
         T7TW0/9tHCSvgICKVq5IvKhI3BYOmKueCBomDK/0TPrejBMFUG1lxWSoCIEpX8CDYIpj
         fsbeuuhWakx0cFeb664MMW4gy5+oqcgeSp6s47WrONoM+tvPtQRaLjOcfV6gdW7pDmHw
         R+M9+P29DlnuZySw2j0sXMlXZRDwlian9Z7yk720qaBMUWypcRAsDoMcC84X4S2NcMoy
         KAAeKonENqS2JOA+wHWJ7DcKo0O48mqzdmiihxtlw/wXvtuGofKk2wkZcxvoFS8EWG2V
         gDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691688135; x=1692292935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESX8jAZRMo0gjvLYfMQ8jMxb77KHrwWoztuYb2u+dsY=;
        b=Nnaa0O9D4A+dDR3bvctuBxbDHEENuzyyIqcKXw/TUfw6K7BKnvNAEM9jABaVw1GFUS
         7f6G5j1esgY4byBOUjQlDenaS7xe2O1H6JRbxvqS08j/SGMF1LkcY/sdtUnxwmRArSwo
         eQw8LkczTKv13SNull/WwihvIxiDQ1Lomw1Ef+UAJgrJUkLaorHPj12GVMCSJ1zxkzA0
         SnthSQtGsTblB2cTp+BE7XkCwq4O448Wq6eQAY2lie7YU85iO7CRhKPEhvsNT7Jgud2M
         NaMt4IvPuDh/hyDaAh8M3xQX9e942HWI9ngP/Ixwewu4xcM7xXEOp5CnYa24dNzaS22B
         XXLg==
X-Gm-Message-State: AOJu0Yx+n5q/4v+6BxnHzBlu3wonTBvN2Ku4Y+YO15IgRwgl6P6+O7+7
        JRwmElnkVJZHVtkQN/TMnVg=
X-Google-Smtp-Source: AGHT+IFu1RAOJXDmfx4kwuxGMZInpyDN35zO5BtsiRvt7WC/lt+ON3GjrVuMdifN4zR4mk1eUMwM7g==
X-Received: by 2002:a05:600c:3c9e:b0:3fc:2d8:b1f2 with SMTP id bg30-20020a05600c3c9e00b003fc02d8b1f2mr2696831wmb.3.1691688135110;
        Thu, 10 Aug 2023 10:22:15 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b003144b95e1ecsm2715754wrp.93.2023.08.10.10.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:22:14 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 1/3] fpga: bridge: make fpga_bridge_class a static const structure
Date:   Thu, 10 Aug 2023 21:22:08 +0400
Message-Id: <20230810172210.6338-1-ivan.orlov0322@gmail.com>
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
memory, move the fpga_bridge_class structure to be declared at build
time placing it into read-only memory, instead of having to be
dynamically allocated at boot time.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/fpga/fpga-bridge.c | 106 ++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 54 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index a6c25dee9cc1..6e38ddaf16cf 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -14,7 +14,6 @@
 #include <linux/spinlock.h>
 
 static DEFINE_IDA(fpga_bridge_ida);
-static struct class *fpga_bridge_class;
 
 /* Lock for adding/removing bridges to linked lists*/
 static DEFINE_SPINLOCK(bridge_list_lock);
@@ -84,6 +83,53 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
 	return ERR_PTR(ret);
 }
 
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct fpga_bridge *bridge = to_fpga_bridge(dev);
+
+	return sprintf(buf, "%s\n", bridge->name);
+}
+
+static ssize_t state_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct fpga_bridge *bridge = to_fpga_bridge(dev);
+	int state = 1;
+
+	if (bridge->br_ops && bridge->br_ops->enable_show) {
+		state = bridge->br_ops->enable_show(bridge);
+		if (state < 0)
+			return state;
+	}
+
+	return sysfs_emit(buf, "%s\n", state ? "enabled" : "disabled");
+}
+
+static DEVICE_ATTR_RO(name);
+static DEVICE_ATTR_RO(state);
+
+static struct attribute *fpga_bridge_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_state.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(fpga_bridge);
+
+static void fpga_bridge_dev_release(struct device *dev)
+{
+	struct fpga_bridge *bridge = to_fpga_bridge(dev);
+
+	ida_free(&fpga_bridge_ida, bridge->dev.id);
+	kfree(bridge);
+}
+
+static const struct class fpga_bridge_class = {
+	.name = "fpga_bridge",
+	.dev_groups = fpga_bridge_groups,
+	.dev_release = fpga_bridge_dev_release,
+};
+
 /**
  * of_fpga_bridge_get - get an exclusive reference to an fpga bridge
  *
@@ -99,7 +145,7 @@ struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
 {
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(fpga_bridge_class, np);
+	dev = class_find_device_by_of_node(&fpga_bridge_class, np);
 	if (!dev)
 		return ERR_PTR(-ENODEV);
 
@@ -126,7 +172,7 @@ struct fpga_bridge *fpga_bridge_get(struct device *dev,
 {
 	struct device *bridge_dev;
 
-	bridge_dev = class_find_device(fpga_bridge_class, NULL, dev,
+	bridge_dev = class_find_device(&fpga_bridge_class, NULL, dev,
 				       fpga_bridge_dev_match);
 	if (!bridge_dev)
 		return ERR_PTR(-ENODEV);
@@ -281,39 +327,6 @@ int fpga_bridge_get_to_list(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_get_to_list);
 
-static ssize_t name_show(struct device *dev,
-			 struct device_attribute *attr, char *buf)
-{
-	struct fpga_bridge *bridge = to_fpga_bridge(dev);
-
-	return sprintf(buf, "%s\n", bridge->name);
-}
-
-static ssize_t state_show(struct device *dev,
-			  struct device_attribute *attr, char *buf)
-{
-	struct fpga_bridge *bridge = to_fpga_bridge(dev);
-	int state = 1;
-
-	if (bridge->br_ops && bridge->br_ops->enable_show) {
-		state = bridge->br_ops->enable_show(bridge);
-		if (state < 0)
-			return state;
-	}
-
-	return sysfs_emit(buf, "%s\n", state ? "enabled" : "disabled");
-}
-
-static DEVICE_ATTR_RO(name);
-static DEVICE_ATTR_RO(state);
-
-static struct attribute *fpga_bridge_attrs[] = {
-	&dev_attr_name.attr,
-	&dev_attr_state.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(fpga_bridge);
-
 /**
  * fpga_bridge_register - create and register an FPGA Bridge device
  * @parent:	FPGA bridge device from pdev
@@ -359,7 +372,7 @@ fpga_bridge_register(struct device *parent, const char *name,
 	bridge->priv = priv;
 
 	bridge->dev.groups = br_ops->groups;
-	bridge->dev.class = fpga_bridge_class;
+	bridge->dev.class = &fpga_bridge_class;
 	bridge->dev.parent = parent;
 	bridge->dev.of_node = parent->of_node;
 	bridge->dev.id = id;
@@ -407,29 +420,14 @@ void fpga_bridge_unregister(struct fpga_bridge *bridge)
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_unregister);
 
-static void fpga_bridge_dev_release(struct device *dev)
-{
-	struct fpga_bridge *bridge = to_fpga_bridge(dev);
-
-	ida_free(&fpga_bridge_ida, bridge->dev.id);
-	kfree(bridge);
-}
-
 static int __init fpga_bridge_dev_init(void)
 {
-	fpga_bridge_class = class_create("fpga_bridge");
-	if (IS_ERR(fpga_bridge_class))
-		return PTR_ERR(fpga_bridge_class);
-
-	fpga_bridge_class->dev_groups = fpga_bridge_groups;
-	fpga_bridge_class->dev_release = fpga_bridge_dev_release;
-
-	return 0;
+	return class_register(&fpga_bridge_class);
 }
 
 static void __exit fpga_bridge_dev_exit(void)
 {
-	class_destroy(fpga_bridge_class);
+	class_unregister(&fpga_bridge_class);
 	ida_destroy(&fpga_bridge_ida);
 }
 
-- 
2.34.1

