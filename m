Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E38B790B6A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 11:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbjICJyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 05:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjICJyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 05:54:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDA5F1;
        Sun,  3 Sep 2023 02:54:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31aec0a1a8bso274591f8f.0;
        Sun, 03 Sep 2023 02:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693734876; x=1694339676; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gchhapWHDBqd6QMRFxPcPK/oyG75NIUSsqZ/Cg1KbbA=;
        b=VMvOCV+Fh7n4NxrTzZ1tsYxK/MxMGsl7znA/pOocaUZHHTethbtcAuJhREq2pSHeAI
         sgqW/aCy2BHhCy5uytLJ4+PIjKqYFtM2+VCZf/jEc3mElX2eNWBC1p4KRXX8+ncRJzIP
         w+/+IZJXvFpWMRxULD9ImTf0J5MiRvQ4YSnSjznazDl2MvSA/4gdTFfLeFscPlduTUbw
         YsvfihjNSY/3UnoSXS2Y2g7N9Rj9YTIuHARhx6p53V+KJr5u1HTSKvwxNW+ePWkKA5en
         fIshGn+Z73lh/Q/X/7l9QnjwvwOiTfjz2YjRW31Sw8K9qZ8lu2oxL/2YdGEKDFc95I3G
         MgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693734876; x=1694339676;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gchhapWHDBqd6QMRFxPcPK/oyG75NIUSsqZ/Cg1KbbA=;
        b=b4kBhZXa59VSEQ8U+rIEWdDwzj0PgddT2i1a0zMksmh6Rltr6dggJBgFasirIUoxy2
         sgDAXtRQDzZPFhG6RcUt4EJGmtvZTE82gC3s5cyxQpEcd+MBqB/POytpfHg4/scx9jzO
         UxVD4X9+SG7IDtkaP6lPVi4d5lo63cap7X525X80iYFpvsxV/8kavdfk1WTQg57qVdEt
         en37IT6Whp9H6wDEv383zT6hiw3Oay+cUDxHOAolDAeFu7b3vv9z0dbVEeziw1F5yv6o
         g15nOH3S2TtBhE0CvVMq+Oyxsu6OVkRSy/bfUYDZxOoTy6ii/EwG4DEt4pEtEb6LULVf
         IfWw==
X-Gm-Message-State: AOJu0YzxD6kj8cVcR+13DAZBK+Qyp5Qv9Xg0g5tMCzYRtRfx40JVwXlQ
        GEeHUpV1z/Yq74mrtXRXByi2o3fIjAA9PgSE
X-Google-Smtp-Source: AGHT+IELsiCnevuE+RQMgYYDfYMoHSRRZ038CeNJy/2AcfK8VYpPlLaHAkAY/Lp8S/3ZsORaLuT0Wg==
X-Received: by 2002:a5d:5182:0:b0:319:7b59:8d09 with SMTP id k2-20020a5d5182000000b003197b598d09mr7586523wrv.25.1693734875613;
        Sun, 03 Sep 2023 02:54:35 -0700 (PDT)
Received: from localhost.localdomain ([113.203.244.138])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c214c00b003fbe791a0e8sm10646715wml.0.2023.09.03.02.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 02:54:35 -0700 (PDT)
From:   fasih0001@gmail.com
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fasih <fasih0001@gmail.com>
Subject: [PATCH] uvc_driver: Error Fix in the file drivers/media/usb/uvc/uvc_driver.c
Date:   Sun,  3 Sep 2023 14:54:31 +0500
Message-Id: <20230903095431.28711-1-fasih0001@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fasih <fasih0001@gmail.com>

Error fix for the line 2429 and 2430, The error message indicated that "Macros with complex values should be enclosed in parentheses".
This typically means that the macro is defined in a way that involves complex expressions or compound literals,
and the preprocessor requires them to be enclosed in parentheses for clarity and proper evaluation.
To address this error and comply with the requirement to enclose complex values in parentheses,
you should wrap the entire expression inside an extra set of parentheses.

Signed-off-by: Syed Muhammad Fasih Ul Hassan <fasih0001@gmail.com>

--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2095,6 +2095,8 @@ static int uvc_probe(struct usb_interface *intf,
        int function;
        int ret;

+       pr_info("I changed uvcvideo driver in the Linux Kernel\n");
+
        /* Allocate memory for the device and initialize it. */
        dev = kzalloc(sizeof(*dev), GFP_KERNEL);
        if (dev == NULL)
@@ -2417,9 +2419,9 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
        .quirks = UVC_QUIRK_FORCE_Y8,
 };

-#define UVC_INFO_QUIRK(q) (kernel_ulong_t)&(struct uvc_device_info){.quirks = q}
-#define UVC_INFO_META(m) (kernel_ulong_t)&(struct uvc_device_info) \
-       {.meta_format = m}
+#define UVC_INFO_QUIRK(q) ((kernel_ulong_t)&(struct uvc_device_info){.quirks = q})
+#define UVC_INFO_META(m) ((kernel_ulong_t)&(struct uvc_device_info) \
+       {.meta_format = m})
---
 drivers/media/usb/uvc/uvc_driver.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 08fcd2ffa727..42d42b211094 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2095,6 +2095,8 @@ static int uvc_probe(struct usb_interface *intf,
 	int function;
 	int ret;
 
+	pr_info("I changed uvcvideo driver in the Linux Kernel\n");
+
 	/* Allocate memory for the device and initialize it. */
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (dev == NULL)
@@ -2417,9 +2419,16 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
 	.quirks = UVC_QUIRK_FORCE_Y8,
 };
 
-#define UVC_INFO_QUIRK(q) (kernel_ulong_t)&(struct uvc_device_info){.quirks = q}
-#define UVC_INFO_META(m) (kernel_ulong_t)&(struct uvc_device_info) \
-	{.meta_format = m}
+/* For line 2429 and 2430, The error message indicated that "Macros with complex values should be enclosed in parentheses".
+ * This typically means that the macro is defined in a way that involves complex expressions or compound literals,
+ * and the preprocessor requires them to be enclosed in parentheses for clarity and proper evaluation.
+ * To address this error and comply with the requirement to enclose complex values in parentheses,
+ * you should wrap the entire expression inside an extra set of parentheses like that:
+ * #define UVC_INFO_QUIRK(q) ((kernel_ulong_t)&(struct uvc_device_info){.quirks = q})
+ */
+#define UVC_INFO_QUIRK(q) ((kernel_ulong_t)&(struct uvc_device_info){.quirks = q})
+#define UVC_INFO_META(m) ((kernel_ulong_t)&(struct uvc_device_info) \
+	{.meta_format = m})
 
 /*
  * The Logitech cameras listed below have their interface class set to
-- 
2.17.1

