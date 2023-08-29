Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F3278BDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbjH2FdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbjH2Fcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:32:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB30CC1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:32:27 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc3d94d40fso30713725ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693287146; x=1693891946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH6e/PDFX3J0yo9vZn0uCvm8FwvX/251scvS5l4WGCQ=;
        b=FdhT9fRBOFRjJrUeAuMpM9bqB8dz6ecrZz/QkAKojpSbvFqE7PdYSUR6XqNXWISkf4
         m8OyNyX0dJSF45eMyHzYLujUC6H0xXrqZgY/ruDdDNoKzNQwgnnyyBuBI1v2jkXhmwwx
         TL5dc+qM0slXwiFiOu1SmqGOh0ZHEARQGJDKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693287146; x=1693891946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH6e/PDFX3J0yo9vZn0uCvm8FwvX/251scvS5l4WGCQ=;
        b=ZwBOguK3y+6U5HaeztYvhc4WnB4aQOUxAS4gXmZjRyli92YMNkedi0YDo7YWgFrUOX
         Ai2X9tS+SgW9EVVgwIDjfZiWqkAMwaY09Q2G58M7VNudzTg2Fu5r4hYPmS7brgoGfWfX
         Hzoy0Ms24nTwZPujBJgKhuo64S++r8EbAFc016F+Yet+Yme1c7jiQupyNWE4MN3iy1gz
         MFVmhYTwMlO901z7vO2j+4q4GvlycqQcH3UgtQ/HFPRN1S9HcPKqKebkYzb+mr/23nPn
         qRWp+nX19Oob+WN0IjfD/knvfYRdj+5XfmPTxqKZNI3cEMJvW8p5U6gMJ7Vek8YVSKMm
         dv8A==
X-Gm-Message-State: AOJu0YwCmvTlUY3r1dqKj45AO5U0vGVvHOHTv0uyLNVUyvrlSmTI4f2B
        RGcQkb5Dzew2uwERytfSj3tf5w==
X-Google-Smtp-Source: AGHT+IFezZbao32Sth8G9Y+W8ekjiQQYamS+hSNT70TKkD7S/75DizVTlnq97IgsXaA2V7/WoMVgRg==
X-Received: by 2002:a17:902:dac4:b0:1be:eef7:98e0 with SMTP id q4-20020a170902dac400b001beeef798e0mr32233232plx.35.1693287146640;
        Mon, 28 Aug 2023 22:32:26 -0700 (PDT)
Received: from datalore.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902c38600b001bdccf6b8c9sm8420874plg.127.2023.08.28.22.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 22:32:26 -0700 (PDT)
From:   Brandon Pollack <brpol@chromium.org>
To:     marius.vlad@collabora.com, mairacanal@riseup.net,
        jshargo@chromium.org
Cc:     corbet@lwn.net, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, melissa.srw@gmail.com,
        mripard@kernel.org, rodrigosiqueiramelo@gmail.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mduggan@chromium.org,
        hirono@chromium.org, Brandon Pollack <brpol@chromium.org>
Subject: [PATCH v6 6/7] drm/vkms: Add a module param to enable/disable the default device
Date:   Tue, 29 Aug 2023 05:30:58 +0000
Message-ID: <20230829053201.423261-7-brpol@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230829053201.423261-1-brpol@chromium.org>
References: <20230829053201.423261-1-brpol@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Shargo <jshargo@chromium.org>

In many testing circumstances, we will want to just create a new device
and test against that. If we create a default device, it can be annoying
to have to manually select the new device instead of choosing the only
one that exists.

The param, enable_default, is defaulted to true to maintain backwards
compatibility.

Signed-off-by: Jim Shargo <jshargo@chromium.org>
Signed-off-by: Brandon Pollack <brpol@chromium.org>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 45 ++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 6e7f20681890..293bebf8e8ce 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -42,17 +42,26 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
+static bool enable_default_device = true;
+module_param_named(enable_default_device, enable_default_device, bool, 0444);
+MODULE_PARM_DESC(enable_default_device,
+		 "Enable/Disable creating the default device");
+
 static bool enable_cursor = true;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
-MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
+MODULE_PARM_DESC(enable_cursor,
+		 "Enable/Disable cursor support for the default device");
 
 static bool enable_writeback = true;
 module_param_named(enable_writeback, enable_writeback, bool, 0444);
-MODULE_PARM_DESC(enable_writeback, "Enable/Disable writeback connector support");
+MODULE_PARM_DESC(
+	enable_writeback,
+	"Enable/Disable writeback connector support for the default device");
 
 static bool enable_overlay;
 module_param_named(enable_overlay, enable_overlay, bool, 0444);
-MODULE_PARM_DESC(enable_overlay, "Enable/Disable overlay support");
+MODULE_PARM_DESC(enable_overlay,
+		 "Enable/Disable overlay support for the default device");
 
 DEFINE_DRM_GEM_FOPS(vkms_driver_fops);
 
@@ -99,6 +108,7 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	struct drm_device *dev = entry->dev;
 	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
 
+	seq_printf(m, "default_device=%d\n", enable_default_device);
 	seq_printf(m, "writeback=%d\n", vkmsdev->config.writeback);
 	seq_printf(m, "cursor=%d\n", vkmsdev->config.cursor);
 	seq_printf(m, "overlay=%d\n", vkmsdev->config.overlay);
@@ -297,10 +307,7 @@ void vkms_remove_device(struct vkms_device *vkms_device)
 static int __init vkms_init(void)
 {
 	int ret;
-	struct platform_device *pdev;
-	struct vkms_device_setup vkms_device_setup = {
-		.configfs = NULL,
-	};
+	struct platform_device *default_pdev = NULL;
 
 	ret = platform_driver_register(&vkms_platform_driver);
 	if (ret) {
@@ -308,19 +315,27 @@ static int __init vkms_init(void)
 		return ret;
 	}
 
-	pdev = platform_device_register_data(NULL, DRIVER_NAME, 0,
-					     &vkms_device_setup,
-					     sizeof(vkms_device_setup));
-	if (IS_ERR(pdev)) {
-		DRM_ERROR("Unable to register default vkms device\n");
-		platform_driver_unregister(&vkms_platform_driver);
-		return PTR_ERR(pdev);
+	if (enable_default_device) {
+		struct vkms_device_setup vkms_device_setup = {
+			.configfs = NULL,
+		};
+
+		default_pdev = platform_device_register_data(
+			NULL, DRIVER_NAME, 0, &vkms_device_setup,
+			sizeof(vkms_device_setup));
+		if (IS_ERR(default_pdev)) {
+			DRM_ERROR("Unable to register default vkms device\n");
+			platform_driver_unregister(&vkms_platform_driver);
+			return PTR_ERR(default_pdev);
+		}
 	}
 
 	ret = vkms_init_configfs();
 	if (ret) {
 		DRM_ERROR("Unable to initialize configfs\n");
-		platform_device_unregister(pdev);
+		if (default_pdev)
+			platform_device_unregister(default_pdev);
+
 		platform_driver_unregister(&vkms_platform_driver);
 	}
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

