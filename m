Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD476AB25
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjHAIe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjHAIe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:34:26 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31371FCB;
        Tue,  1 Aug 2023 01:34:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68336d06620so5287545b3a.1;
        Tue, 01 Aug 2023 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690878861; x=1691483661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x7EH+V+tQH2G6HOrO62Pgevtf4uxnesUjbds2vmU5vM=;
        b=qd80RwmV5h9XSzApxlJS8sOIfTEZiUTmN1kEg5tVqPeuQp25abpILPVAnpxA87gOVJ
         zLgdAA80O/Prp4RmTtpn4D7lNZASxEklP495wcYyxacCr8eJAIQB9zU++x8ZOkYSrZbG
         O+/h3cduVxbWJflnpEKyPGBQcN2aOxsvn/7w40DpQeWJdqsMpJlnkD+nrm4FYuffVY4w
         95NhB+4M8b/CCpNuEHIMUH/edxFrJnCd75/YalYsyg14Avc+QpQpCsDAE+61F0eXvvbw
         2JNDb/RGI7kj3sP9dnbQLdpjCkunTufKqXQM26znjIAJcYrA7zJL+2N25thVyraqzHof
         ogGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690878861; x=1691483661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7EH+V+tQH2G6HOrO62Pgevtf4uxnesUjbds2vmU5vM=;
        b=FPwIrRBKOILeKlnrVB0vIdD+kenNP5noaKgAiE9Cf1Kv6KE80yrvkuFpK10BbRKt38
         m+mYdwwcZ5FW6TPwZSTPSLAfjUah647exCj1fwOHpGh+8Ipdfx1u9yntIrQSVoZW/V6d
         zu8fo5nCZURPioH46yhNY8hNyqKG3TPHxLoZcMoMnwzNAFBhIn2TxL1LAzUoburL1BT6
         YOht/KGVp7Fd5351sRO8Zx3x/W8nHqeYKkfA6oq6xt7/mKfABJKuR1b3S8mIMLhTB5ql
         I4KKYSTYrK7PWMQoOy8ZeklWSh57JsUwqCntXrC6lrJiBvAIUNX5YneGaZO0QqXHbXmB
         wwOg==
X-Gm-Message-State: ABy/qLaaVTjZL6lmu4eBSiEkK0F5aRHIWWnIWo+INJWEApPoxrSY0TGM
        oCavrI5/wff/WzydZ+hjqFY=
X-Google-Smtp-Source: APBJJlFOF+n8t3P2+gD7E1PdJe6Jigkn1YP6gXyl0ZTAe0wHJRkckB/zUP+6w29Wmq4xK/4h11++nw==
X-Received: by 2002:a05:6a20:9150:b0:138:64d4:b040 with SMTP id x16-20020a056a20915000b0013864d4b040mr15377097pzc.54.1690878860665;
        Tue, 01 Aug 2023 01:34:20 -0700 (PDT)
Received: from localhost.localdomain (199.180.119.18.16clouds.com. [199.180.119.18])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7880d000000b00640f51801e6sm7409612pfo.159.2023.08.01.01.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 01:34:20 -0700 (PDT)
From:   chengdong zhou <zhouscd@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, john@keeping.me.uk,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        chengdong zhou <zhouscd@gmail.com>
Subject: [PATCH v2] USB: gadget: Fix the function name error in sourcesink/loopback.
Date:   Tue,  1 Aug 2023 01:32:45 -0700
Message-Id: <20230801083244.165392-1-zhouscd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change function name from "source/sink" to "sourcesink".
Keep the usb_function_driver.name consistent with usb_function.name
for sourcesink and loopback.
Cleaned up some code to decouple the sourcesink and loopback.

If usb_function.name and usb_function_driver.name are not the same,
it will cause the function to be unable to be exported to userspace
by the USB config file system.

Signed-off-by: chengdong zhou <zhouscd@gmail.com>
---
 drivers/usb/gadget/function/f_loopback.c   | 13 +----------
 drivers/usb/gadget/function/f_sourcesink.c | 25 ++--------------------
 drivers/usb/gadget/function/g_zero.h       |  3 ---
 drivers/usb/gadget/legacy/zero.c           |  6 +++---
 4 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/drivers/usb/gadget/function/f_loopback.c b/drivers/usb/gadget/function/f_loopback.c
index ae41f556eb75..45f542b5ff55 100644
--- a/drivers/usb/gadget/function/f_loopback.c
+++ b/drivers/usb/gadget/function/f_loopback.c
@@ -583,16 +583,5 @@ static struct usb_function_instance *loopback_alloc_instance(void)
 
 	return  &lb_opts->func_inst;
 }
-DECLARE_USB_FUNCTION(Loopback, loopback_alloc_instance, loopback_alloc);
-
-int __init lb_modinit(void)
-{
-	return usb_function_register(&Loopbackusb_func);
-}
-
-void __exit lb_modexit(void)
-{
-	usb_function_unregister(&Loopbackusb_func);
-}
-
+DECLARE_USB_FUNCTION_INIT(loopback, loopback_alloc_instance, loopback_alloc);
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
index 6803cd60cc6d..f6d1c095aa2c 100644
--- a/drivers/usb/gadget/function/f_sourcesink.c
+++ b/drivers/usb/gadget/function/f_sourcesink.c
@@ -858,7 +858,7 @@ static struct usb_function *source_sink_alloc_func(
 	ss->bulk_qlen = ss_opts->bulk_qlen;
 	ss->iso_qlen = ss_opts->iso_qlen;
 
-	ss->function.name = "source/sink";
+	ss->function.name = "sourcesink";
 	ss->function.bind = sourcesink_bind;
 	ss->function.set_alt = sourcesink_set_alt;
 	ss->function.get_alt = sourcesink_get_alt;
@@ -1263,27 +1263,6 @@ static struct usb_function_instance *source_sink_alloc_inst(void)
 
 	return &ss_opts->func_inst;
 }
-DECLARE_USB_FUNCTION(SourceSink, source_sink_alloc_inst,
+DECLARE_USB_FUNCTION_INIT(sourcesink, source_sink_alloc_inst,
 		source_sink_alloc_func);
-
-static int __init sslb_modinit(void)
-{
-	int ret;
-
-	ret = usb_function_register(&SourceSinkusb_func);
-	if (ret)
-		return ret;
-	ret = lb_modinit();
-	if (ret)
-		usb_function_unregister(&SourceSinkusb_func);
-	return ret;
-}
-static void __exit sslb_modexit(void)
-{
-	usb_function_unregister(&SourceSinkusb_func);
-	lb_modexit();
-}
-module_init(sslb_modinit);
-module_exit(sslb_modexit);
-
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/gadget/function/g_zero.h b/drivers/usb/gadget/function/g_zero.h
index 98b8462ad538..c1ea28526c73 100644
--- a/drivers/usb/gadget/function/g_zero.h
+++ b/drivers/usb/gadget/function/g_zero.h
@@ -62,9 +62,6 @@ struct f_lb_opts {
 	int				refcnt;
 };
 
-void lb_modexit(void);
-int lb_modinit(void);
-
 /* common utilities */
 void disable_endpoints(struct usb_composite_dev *cdev,
 		struct usb_ep *in, struct usb_ep *out,
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

