Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299297D9CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346281AbjJ0Pbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjJ0Pbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:31:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C90AAF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698420651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J/UFA7u/XXiPmDgo1cL607vFxp7ihV1o+SEyqiKodo8=;
        b=WLcdGcDUpKaw83tVy5nN3xK55KgJow/yxVoBmapeybme0VfmIZ+gcLp8uRbKR76tB4MwcP
        IzDHTd06vJ5bJRtp+BcrfAnprESxcMRGdYvzo1LE3+AGX3c2owo9O5X7NcplKOGHw9zqOi
        yzGJIVILevlBojAUVTIO1Jwlesw3zJo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-mX5ZNU_FMF2HoJCh-ZiGYw-1; Fri, 27 Oct 2023 11:29:42 -0400
X-MC-Unique: mX5ZNU_FMF2HoJCh-ZiGYw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66cfd45de06so27848536d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698420582; x=1699025382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/UFA7u/XXiPmDgo1cL607vFxp7ihV1o+SEyqiKodo8=;
        b=BU3SAtpKCT46jP9kERqs1mGUvefnSuIi2gA11obWYHqC+BRkPIy6iks2L2fXj8LWLn
         PzVMjlTaydlQwafEiJG4g8Cfs8I8dC4jB8BvSMAK6yK3ouUYe27R/fXEOwWBYbqSKxvs
         g5nXgZTITlpLEHJdeDN1kiJqKqGXkAUI2KKvL/sV0i5O2GxcfhRKNvqgBsLEzqGDc8x9
         ScJ1/sREK5uGN65d0a6ti2N6CTRG5wYLaes/dyEnB5J/g9h4JeSyhjk8RSLVnd96UaqP
         56QOKhM4iuN4Lrl113lJLIahakw7tI9aQM8U3gA8YDotMzjmcyZ622fK9rSiBs8gvvxA
         hdvQ==
X-Gm-Message-State: AOJu0YwSJcQrsZNLJCF/gIthsNoTATDOo+WWm9w9Ep2Oh6b3qJza44Dr
        T5MzGQ5Bi8GmyPHOI6z4CScGtnGHIf/2xZuo6pqP9dMKLkFkC9wKZNSZS3SuPqUvKp31x7AqQuv
        1QaPHhM+WDN8edU4ugI+Q8BM=
X-Received: by 2002:ad4:5967:0:b0:66d:6406:1301 with SMTP id eq7-20020ad45967000000b0066d64061301mr3464104qvb.20.1698420581921;
        Fri, 27 Oct 2023 08:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD9Epz9kEMnsy1wUN/xUndNfSWqDRJNS4eaHXxHkAvrvn5vu3+dm9wvm9JKKrowFf30f0iUw==
X-Received: by 2002:ad4:5967:0:b0:66d:6406:1301 with SMTP id eq7-20020ad45967000000b0066d64061301mr3464084qvb.20.1698420581621;
        Fri, 27 Oct 2023 08:29:41 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-31-107.cust.vodafonedsl.it. [2.34.31.107])
        by smtp.gmail.com with ESMTPSA id fc8-20020ad44f28000000b0066d32666a27sm691316qvb.66.2023.10.27.08.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:29:41 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] fpga: remove module reference counting from core components
Date:   Fri, 27 Oct 2023 17:29:27 +0200
Message-ID: <20231027152928.184012-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary module reference counting from the core components
of the subsystem. Low-level driver modules cannot be removed before
core modules since they use their exported symbols.

For more context, refer to this thread:
https://lore.kernel.org/linux-fpga/ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050

Other changes:

In  __fpga_bridge_get(): do a (missing ?) get_device() and bind the
image to the bridge only after the mutex has been acquired.

In __fpga_mgr_get(): do a get_device(). Currently, get_device() is
called when allocating an image in fpga_image_info_alloc().
However, since there are still two (of_)fpga_mgr_get() functions
exposed by the core, I think they should behave as expected.

In fpga_region_get() / fpga_region_put(): call get_device() before
acquiring the mutex and put_device() after having released the mutex
to avoid races.

Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 24 +++++++-----------------
 drivers/fpga/fpga-mgr.c    |  8 +-------
 drivers/fpga/fpga-region.c | 14 ++++----------
 3 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index a024be2b84e2..3bcc9c9849c5 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -58,30 +58,21 @@ EXPORT_SYMBOL_GPL(fpga_bridge_disable);
 static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
 					     struct fpga_image_info *info)
 {
-	struct fpga_bridge *bridge;
-	int ret = -ENODEV;
-
-	bridge = to_fpga_bridge(dev);
+	struct fpga_bridge *bridge = to_fpga_bridge(dev);
 
-	bridge->info = info;
+	get_device(dev);
 
 	if (!mutex_trylock(&bridge->mutex)) {
-		ret = -EBUSY;
-		goto err_dev;
+		dev_dbg(dev, "%s: FPGA Bridge already in use\n", __func__);
+		put_device(dev);
+		return ERR_PTR(-EBUSY);
 	}
 
-	if (!try_module_get(dev->parent->driver->owner))
-		goto err_ll_mod;
+	bridge->info = info;
 
 	dev_dbg(&bridge->dev, "get\n");
 
 	return bridge;
-
-err_ll_mod:
-	mutex_unlock(&bridge->mutex);
-err_dev:
-	put_device(dev);
-	return ERR_PTR(ret);
 }
 
 /**
@@ -93,7 +84,7 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
  * Return:
  * * fpga_bridge struct pointer if successful.
  * * -EBUSY if someone already has a reference to the bridge.
- * * -ENODEV if @np is not an FPGA Bridge or can't take parent driver refcount.
+ * * -ENODEV if @np is not an FPGA Bridge.
  */
 struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
 				       struct fpga_image_info *info)
@@ -146,7 +137,6 @@ void fpga_bridge_put(struct fpga_bridge *bridge)
 	dev_dbg(&bridge->dev, "put\n");
 
 	bridge->info = NULL;
-	module_put(bridge->dev.parent->driver->owner);
 	mutex_unlock(&bridge->mutex);
 	put_device(&bridge->dev);
 }
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 06651389c592..6c355eafd18f 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -670,14 +670,9 @@ static struct fpga_manager *__fpga_mgr_get(struct device *dev)
 
 	mgr = to_fpga_manager(dev);
 
-	if (!try_module_get(dev->parent->driver->owner))
-		goto err_dev;
+	get_device(&mgr->dev);
 
 	return mgr;
-
-err_dev:
-	put_device(dev);
-	return ERR_PTR(-ENODEV);
 }
 
 static int fpga_mgr_dev_match(struct device *dev, const void *data)
@@ -727,7 +722,6 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
  */
 void fpga_mgr_put(struct fpga_manager *mgr)
 {
-	module_put(mgr->dev.parent->driver->owner);
 	put_device(&mgr->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_put);
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index b364a929425c..c299956cafdc 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -41,22 +41,17 @@ EXPORT_SYMBOL_GPL(fpga_region_class_find);
  * Return:
  * * fpga_region struct if successful.
  * * -EBUSY if someone already has a reference to the region.
- * * -ENODEV if can't take parent driver module refcount.
  */
 static struct fpga_region *fpga_region_get(struct fpga_region *region)
 {
 	struct device *dev = &region->dev;
 
+	get_device(dev);
+
 	if (!mutex_trylock(&region->mutex)) {
 		dev_dbg(dev, "%s: FPGA Region already in use\n", __func__);
-		return ERR_PTR(-EBUSY);
-	}
-
-	get_device(dev);
-	if (!try_module_get(dev->parent->driver->owner)) {
 		put_device(dev);
-		mutex_unlock(&region->mutex);
-		return ERR_PTR(-ENODEV);
+		return ERR_PTR(-EBUSY);
 	}
 
 	dev_dbg(dev, "get\n");
@@ -75,9 +70,8 @@ static void fpga_region_put(struct fpga_region *region)
 
 	dev_dbg(dev, "put\n");
 
-	module_put(dev->parent->driver->owner);
-	put_device(dev);
 	mutex_unlock(&region->mutex);
+	put_device(dev);
 }
 
 /**
-- 
2.41.0

