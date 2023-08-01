Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4FC76A812
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 06:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjHAEzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 00:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHAEz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 00:55:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD3E10F0;
        Mon, 31 Jul 2023 21:55:28 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2681223aaacso3345527a91.0;
        Mon, 31 Jul 2023 21:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690865728; x=1691470528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xm+NQg63nei7eSygCGRvfNU1X/Ez/FEbkTbiDrAjRXc=;
        b=fumgTrisajvYGWBKltv4U12/ivqioC94+AVlzPGDlQTPklivkFo4cICciZJXedvy7F
         daaW+Okh+FfR02DuSzKrXn8emgIXnRw6uACKQF2jR61AQeNxcm8kmdmIGQe4//zV6FXT
         EKdySqNNJNg8XUF9f2Hc6W8hPZtGjGwJXBW9Ut8B6BaUIs5CGvAOZ7eYIq88xmFOYzxD
         nvHKoPFoobgLvd1kQSGZaFL+jRaXQUjkiHu3HwMegkxq+p1LkdqrkRVxsSAgrJ4ZnPln
         m3gR55tMq6jrg0NIHUaRh+uqRNVFT+bKr3BLZGYZjmP8RkluUGO6xAibAxuWDxwZPUMm
         2G6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690865728; x=1691470528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xm+NQg63nei7eSygCGRvfNU1X/Ez/FEbkTbiDrAjRXc=;
        b=TMzRZQ+NEqILKvMHTsCeMNXqaW0BwJQX1BQM8IAYvnzv/6ORGFPstlnU9R8pER4Cro
         vlmKRbVOnbarroTT3IGzk04t5GhvyDZnu3ELnCkH7rY2S9F7CyBhofGezyXmKt9tYaJu
         pNUNVxneZ3PbpP9eyMoTQD+tUl0FaJWQ8BC3XACxB8LNWajLxthuVbOfcS4YNlJHV+BP
         P3Ih+8XXKyUM7zk2jZAIcXFQUcVipB6dKcf+GWKyvUBc76Y49tekHUj2iHmGryw5lsJU
         e7wcFscAZNxLNfB6QIyeFx/3iUTkR8mpVf0KwcNO+LlpIza5aqnJMt6qzihbb1msDqaV
         lkpQ==
X-Gm-Message-State: ABy/qLYTmFqtlcgNtp8G7S5uRDIF17gD2L7b7n5FasV8FCCvol+PMIEg
        fABdiHUf5nt/Q8KgXtoznGs=
X-Google-Smtp-Source: APBJJlHtuYUJSuXxEP0N8UIPKfYl+Roqonwn80qc1IHczfRRE3eIDkuHxzm+m/DnHDSr81P6UDlXSA==
X-Received: by 2002:a17:90b:3b8a:b0:268:8ff2:5c0d with SMTP id pc10-20020a17090b3b8a00b002688ff25c0dmr13113769pjb.17.1690865728032;
        Mon, 31 Jul 2023 21:55:28 -0700 (PDT)
Received: from localhost.localdomain (199.180.119.18.16clouds.com. [199.180.119.18])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001aaecc0b6ffsm9417843pll.160.2023.07.31.21.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 21:55:27 -0700 (PDT)
From:   zhouscd <zhouscd@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, john@keeping.me.uk,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouscd <zhouscd@gmail.com>
Subject: [PATCH] USB: gadget: Fix the function name error in sourcesink/loopback.
Date:   Mon, 31 Jul 2023 21:54:49 -0700
Message-Id: <20230801045449.156348-1-zhouscd@gmail.com>
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

Inconsistent function names can cause the USB config FS not work.

Signed-off-by: zhouscd <zhouscd@gmail.com>
---
 drivers/usb/gadget/function/f_loopback.c   | 13 +----------
 drivers/usb/gadget/function/f_sourcesink.c | 25 ++--------------------
 drivers/usb/gadget/function/g_zero.h       |  3 ---
 3 files changed, 3 insertions(+), 38 deletions(-)

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
-- 
2.25.1

