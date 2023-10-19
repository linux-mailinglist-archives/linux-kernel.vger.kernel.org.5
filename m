Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167287CF445
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345104AbjJSJqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345120AbjJSJqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:46:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B6618A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:46:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32d569e73acso6613490f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697708787; x=1698313587; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRx1mkVglneWbuJK9kNyXtkB1fOLyzTlVO5RVNlJSBQ=;
        b=YmTQeyNZ3/xDbNn8ypD7OmPH/LxfLpNkoukXoA8w5vfMZvpjFPjAurYIg6JpWFiujQ
         7vmmiGFsuG3HkluhXidGP3MLpUdCzLmb3FivFZPdIZCl7XXvzTIMumkwJpqa18uaPS11
         jkLimHSpmSB+lE0iKqHM2/pRYYRi36BILceK4yyrSTN21R9pK+W3W7cU1Q12j7nRcWFt
         cll/Jnk0ENrOC8l6iK1V7uQggE76AwtkVHSvpIhF1eNm9P/bNCr0RMSAeWUBRIUMjzSz
         zGvzjmThI2imtLHqJ0KNMYLmSmdoxhkJ578yB5lrdcRrZpZqgIDMwXLI3z7gr9rQtcal
         M+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697708787; x=1698313587;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRx1mkVglneWbuJK9kNyXtkB1fOLyzTlVO5RVNlJSBQ=;
        b=EXFu5oBJnnjlVLBorkcyxkMqljJXTtzgRaqW/tdtozofdUK7JL1pIMEm/VprvLeWEc
         t4TCCni9BKDOZdaNrFxElQn9GFMnCbLr8xO9s1uhDU2f9TBQGD6Nu+2C/BnaY8I6lO2J
         UyuU7v4StTSOVEWu1zV5E3pzjh9wUdEVgt1XhUXloTEtbkx9f5YQ5B+8Zf/hlBVA07vd
         7n6eOEBv4VzqRtt9e/HIy/mWVNr1rjsvw/XfJyRF+MLofRf+QfjAgZDcs0vLTE0cKCJC
         oN4hOzTVrVHr77DJBQRRhFpCbaNGTUsaLlYA9JUfi8r72DoyTCKK+P4sawA11pGE8H0p
         49Bg==
X-Gm-Message-State: AOJu0Yzy59wtu0prJtO/maKTagjUW8b4/a8VG7d4PxHYN1ENF8W6b86s
        5N5gaOJ1PW8iR8RntqpNPovUPvYh1cd93A==
X-Google-Smtp-Source: AGHT+IGxB1FMUpt94hkLPb+IgHxMb75FtIbTeRjZ2Ps6cGpdt9zcWAj00kVdOOdisWuxCLN/pV4J8g==
X-Received: by 2002:a5d:4444:0:b0:32d:857c:d546 with SMTP id x4-20020a5d4444000000b0032d857cd546mr1125114wrr.64.1697708786837;
        Thu, 19 Oct 2023 02:46:26 -0700 (PDT)
Received: from lab-ubuntu ([41.90.66.104])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d6a41000000b0032d9efeccd8sm4064810wrw.51.2023.10.19.02.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 02:46:26 -0700 (PDT)
Date:   Thu, 19 Oct 2023 12:46:23 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vc04_services: remove empty functions
Message-ID: <ZTD677iqMkRPxT27@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions vchiq_debugfs_init(), vchiq_debugfs_deinit(),
vchiq_debugfs_add_instance(), and vchiq_debugfs_remove_instance()
are declared and defined but contains no code or statements.
They do nothing.

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
 .../interface/vchiq_arm/vchiq_arm.c              |  3 ---
 .../interface/vchiq_arm/vchiq_debugfs.c          | 16 ----------------
 .../interface/vchiq_arm/vchiq_debugfs.h          |  8 --------
 .../interface/vchiq_arm/vchiq_dev.c              |  4 ----
 4 files changed, 31 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index eef9c8c06e66..b802d1ecc8f6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1806,8 +1806,6 @@ static int vchiq_probe(struct platform_device *pdev)
 	if (err)
 		goto failed_platform_init;
 
-	vchiq_debugfs_init();
-
 	vchiq_log_info(vchiq_arm_log_level,
 		       "vchiq: platform initialised - version %d (min %d)",
 		       VCHIQ_VERSION, VCHIQ_VERSION_MIN);
@@ -1838,7 +1836,6 @@ static void vchiq_remove(struct platform_device *pdev)
 {
 	vchiq_device_unregister(bcm2835_audio);
 	vchiq_device_unregister(bcm2835_camera);
-	vchiq_debugfs_deinit();
 	vchiq_deregister_chrdev();
 }
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index dc667afd1f8c..7e45076e5ebd 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -228,20 +228,4 @@ void vchiq_debugfs_deinit(void)
 
 #else /* CONFIG_DEBUG_FS */
 
-void vchiq_debugfs_init(void)
-{
-}
-
-void vchiq_debugfs_deinit(void)
-{
-}
-
-void vchiq_debugfs_add_instance(struct vchiq_instance *instance)
-{
-}
-
-void vchiq_debugfs_remove_instance(struct vchiq_instance *instance)
-{
-}
-
 #endif /* CONFIG_DEBUG_FS */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
index e9bf055a4ca9..76424473c32b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
@@ -10,12 +10,4 @@ struct vchiq_debugfs_node {
 	struct dentry *dentry;
 };
 
-void vchiq_debugfs_init(void);
-
-void vchiq_debugfs_deinit(void);
-
-void vchiq_debugfs_add_instance(struct vchiq_instance *instance);
-
-void vchiq_debugfs_remove_instance(struct vchiq_instance *instance);
-
 #endif /* VCHIQ_DEBUGFS_H */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 841e1a535642..953f39f537a8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -1185,8 +1185,6 @@ static int vchiq_open(struct inode *inode, struct file *file)
 	instance->state = state;
 	instance->pid = current->tgid;
 
-	vchiq_debugfs_add_instance(instance);
-
 	init_completion(&instance->insert_event);
 	init_completion(&instance->remove_event);
 	mutex_init(&instance->completion_mutex);
@@ -1297,8 +1295,6 @@ static int vchiq_release(struct inode *inode, struct file *file)
 
 	free_bulk_waiter(instance);
 
-	vchiq_debugfs_remove_instance(instance);
-
 	kfree(instance);
 	file->private_data = NULL;
 
-- 
2.34.1

