Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D4C76B212
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjHAKmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjHAKmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:42:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47008BF;
        Tue,  1 Aug 2023 03:42:49 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so43428025ad.1;
        Tue, 01 Aug 2023 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690886569; x=1691491369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7g8F/VnuKjDph5IVfFug3xwfi4jeRDr1XbbGu+XsgTg=;
        b=hXYhSKv8UVtd47xJjvcWwARFS3VulYo3lolZCEZIpvciXUmhWXzGpPTVXgO8eTNOYC
         i3pjhRJoKAErDncdIY7HkSmLXiolhBQ2p0YRWX/gGsF9dE34h3xrxIg7XiMkyO1gphIH
         to39Pts5gzxgJ5Aa1TtPIahljfcky+gDXlVSy3MILRCVz1Kd3KC+6djAHuKlVZGdy97/
         HYDY2umvqRP+iMzEtnoTsv0aL8ymFWH4UbQkdtS8qvNtL7dpgPJQ4FSyoPNJgT3gyRn5
         +1SkeMuHLBo9FvUzECQv5JxNLJmYhL7v+1XlW7zqhXyY3YDbQPY6mH7mYZDYGm+dr/ib
         DyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690886569; x=1691491369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7g8F/VnuKjDph5IVfFug3xwfi4jeRDr1XbbGu+XsgTg=;
        b=d9K1q8CXFleSlKxHmj5PBaJenIrnAFYD6TIsqBvwcl1D8N1KwolAQpRgnF20NL6MXy
         Pb16WOF0hT9Ze8Tpgf5Y2tyWl9pdkJYdLTrsw3uFwPxJVRY5XB6wIRaT9H7cSFzAeRyX
         7BcMMY4FGcPFilQrGx8WY7Xt2Uaa1BHYtQ0ZDhXzlx7YdzhwNkKtI3O+fkTkGaz3AW9x
         Cfil0leDz4CXsi3CNU91BTpFBXL/LVuOxJQtfOBhHgDCrg154RwFF8e4JC20CUgnoDbV
         qmZgt2TPPLLU6GuFDvPPlfIx6kTyZaMtwCpsG+kCQfTyhFPUM8gZMxeYco5NOgeSiMW7
         KEmw==
X-Gm-Message-State: ABy/qLbLluxPEa0Gle86Bkyg+9jiVz7QWVnVI+Zk+ieusGkf9aH5OAD/
        ZHhsgkz97rtdn0Z2FPdKKgc=
X-Google-Smtp-Source: APBJJlF+2UC1CLNyyzkCHz2ESE0SZusuA54LOKSYoqydC5IB6QI3Z24+yQJH6mwHyFihSdsqtfGpQw==
X-Received: by 2002:a17:902:da86:b0:1bc:2437:e54 with SMTP id j6-20020a170902da8600b001bc24370e54mr1902482plx.24.1690886568638;
        Tue, 01 Aug 2023 03:42:48 -0700 (PDT)
Received: from localhost.localdomain (199.180.119.18.16clouds.com. [199.180.119.18])
        by smtp.gmail.com with ESMTPSA id j17-20020a170902c3d100b001bb9b5e86b7sm4393340plj.91.2023.08.01.03.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 03:42:48 -0700 (PDT)
From:   chengdong zhou <zhouscd@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, john@keeping.me.uk,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        chengdong zhou <zhouscd@gmail.com>
Subject: [PATCH] USB: gadget: usb function sourcesink and loopback support usb configfs
Date:   Tue,  1 Aug 2023 03:42:23 -0700
Message-Id: <20230801104223.281275-1-zhouscd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently two issues that causes sourcesink and loopback to
fail to export to usb configfs:
1. usb_function.name does not match usb_function_driver.name
2. usb configfs does not support function name with '/'

So, we adjusted usb_function.name to "sourcesink" and "loopback",
and remove '/'

Signed-off-by: chengdong zhou <zhouscd@gmail.com>
---
 drivers/usb/gadget/function/f_loopback.c   |  6 +++---
 drivers/usb/gadget/function/f_sourcesink.c | 20 ++++++++++----------
 drivers/usb/gadget/legacy/zero.c           |  6 +++---
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/gadget/function/f_loopback.c b/drivers/usb/gadget/function/f_loopback.c
index ae41f556eb75..9900baa31c2d 100644
--- a/drivers/usb/gadget/function/f_loopback.c
+++ b/drivers/usb/gadget/function/f_loopback.c
@@ -583,16 +583,16 @@ static struct usb_function_instance *loopback_alloc_instance(void)
 
 	return  &lb_opts->func_inst;
 }
-DECLARE_USB_FUNCTION(Loopback, loopback_alloc_instance, loopback_alloc);
+DECLARE_USB_FUNCTION(loopback, loopback_alloc_instance, loopback_alloc);
 
 int __init lb_modinit(void)
 {
-	return usb_function_register(&Loopbackusb_func);
+	return usb_function_register(&loopbackusb_func);
 }
 
 void __exit lb_modexit(void)
 {
-	usb_function_unregister(&Loopbackusb_func);
+	usb_function_unregister(&loopbackusb_func);
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
index 6803cd60cc6d..fc879b785ed0 100644
--- a/drivers/usb/gadget/function/f_sourcesink.c
+++ b/drivers/usb/gadget/function/f_sourcesink.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * f_sourcesink.c - USB peripheral source/sink configuration driver
+ * f_sourcesink.c - USB peripheral sourcesink configuration driver
  *
  * Copyright (C) 2003-2008 David Brownell
  * Copyright (C) 2008 by Nokia Corporation
@@ -19,7 +19,7 @@
 #include "u_f.h"
 
 /*
- * SOURCE/SINK FUNCTION ... a primary testing vehicle for USB peripheral
+ * SOURCESINK FUNCTION ... a primary testing vehicle for USB peripheral
  * controller drivers.
  *
  * This just sinks bulk packets OUT to the peripheral and sources them IN
@@ -460,7 +460,7 @@ sourcesink_free_func(struct usb_function *f)
 	kfree(func_to_ss(f));
 }
 
-/* optionally require specific source/sink data patterns  */
+/* optionally require specific sourcesink data patterns  */
 static int check_read_data(struct f_sourcesink *ss, struct usb_request *req)
 {
 	unsigned		i;
@@ -818,14 +818,14 @@ static int sourcesink_setup(struct usb_function *f,
 
 	/* respond with data transfer or status phase? */
 	if (value >= 0) {
-		VDBG(c->cdev, "source/sink req%02x.%02x v%04x i%04x l%d\n",
+		VDBG(c->cdev, "sourcesink req%02x.%02x v%04x i%04x l%d\n",
 			ctrl->bRequestType, ctrl->bRequest,
 			w_value, w_index, w_length);
 		req->zero = 0;
 		req->length = value;
 		value = usb_ep_queue(c->cdev->gadget->ep0, req, GFP_ATOMIC);
 		if (value < 0)
-			ERROR(c->cdev, "source/sink response, err %d\n",
+			ERROR(c->cdev, "sourcesink response, err %d\n",
 					value);
 	}
 
@@ -858,7 +858,7 @@ static struct usb_function *source_sink_alloc_func(
 	ss->bulk_qlen = ss_opts->bulk_qlen;
 	ss->iso_qlen = ss_opts->iso_qlen;
 
-	ss->function.name = "source/sink";
+	ss->function.name = "sourcesink";
 	ss->function.bind = sourcesink_bind;
 	ss->function.set_alt = sourcesink_set_alt;
 	ss->function.get_alt = sourcesink_get_alt;
@@ -1263,24 +1263,24 @@ static struct usb_function_instance *source_sink_alloc_inst(void)
 
 	return &ss_opts->func_inst;
 }
-DECLARE_USB_FUNCTION(SourceSink, source_sink_alloc_inst,
+DECLARE_USB_FUNCTION(sourcesink, source_sink_alloc_inst,
 		source_sink_alloc_func);
 
 static int __init sslb_modinit(void)
 {
 	int ret;
 
-	ret = usb_function_register(&SourceSinkusb_func);
+	ret = usb_function_register(&sourcesinkusb_func);
 	if (ret)
 		return ret;
 	ret = lb_modinit();
 	if (ret)
-		usb_function_unregister(&SourceSinkusb_func);
+		usb_function_unregister(&sourcesinkusb_func);
 	return ret;
 }
 static void __exit sslb_modexit(void)
 {
-	usb_function_unregister(&SourceSinkusb_func);
+	usb_function_unregister(&sourcesinkusb_func);
 	lb_modexit();
 }
 module_init(sslb_modinit);
diff --git a/drivers/usb/gadget/legacy/zero.c b/drivers/usb/gadget/legacy/zero.c
index 23312a07efb4..0cddd20e54ff 100644
--- a/drivers/usb/gadget/legacy/zero.c
+++ b/drivers/usb/gadget/legacy/zero.c
@@ -222,7 +222,7 @@ static int ss_config_setup(struct usb_configuration *c,
 }
 
 static struct usb_configuration sourcesink_driver = {
-	.label                  = "source/sink",
+	.label                  = "sourcesink",
 	.setup                  = ss_config_setup,
 	.bConfigurationValue    = 3,
 	.bmAttributes           = USB_CONFIG_ATT_SELFPOWER,
@@ -282,7 +282,7 @@ static int zero_bind(struct usb_composite_dev *cdev)
 	autoresume_cdev = cdev;
 	timer_setup(&autoresume_timer, zero_autoresume, 0);
 
-	func_inst_ss = usb_get_function_instance("SourceSink");
+	func_inst_ss = usb_get_function_instance("sourcesink");
 	if (IS_ERR(func_inst_ss))
 		return PTR_ERR(func_inst_ss);
 
@@ -302,7 +302,7 @@ static int zero_bind(struct usb_composite_dev *cdev)
 		goto err_put_func_inst_ss;
 	}
 
-	func_inst_lb = usb_get_function_instance("Loopback");
+	func_inst_lb = usb_get_function_instance("loopback");
 	if (IS_ERR(func_inst_lb)) {
 		status = PTR_ERR(func_inst_lb);
 		goto err_put_func_ss;
-- 
2.25.1

