Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C156279041E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351239AbjIAXlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351247AbjIAXlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:41:40 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C755F19A2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:41:01 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bd0425ad4fso1938226a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611658; x=1694216458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1eWAYznHaK0aWczuNWbSMuURPigxfjsQS0xy+Sev48=;
        b=WoMw4iXX9nxGE1tVZU9F2Ge6FK8Ku+RuiBQ+7DbcD6HIifU1uWt3nCVMCjZgaH8lTK
         fOLwpc6IzGKWMZMGJcqsG3C2QT7v7XkIEnUg+hczAtHSXJpxzxbvcYVGScV7+g09WeDc
         0R1y8FVwQsAEifEcxLjdQLmc9gfbFKP4C42X0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611658; x=1694216458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1eWAYznHaK0aWczuNWbSMuURPigxfjsQS0xy+Sev48=;
        b=jKCbeBclWd3MDWGPiu7jR6xeTfqaCFJoSyq0Uge1Ph3lIoWic0sbtmhToq4RR3lIsU
         ONEHvtZZKPdFaSjaZUBqayqGGmRjFW6hvD89JaAVuOVEE6jwriwI0jyFYBJwjMwqULrA
         CqyBoeyEg7SVC5RcRezXdo9Ru3C8qR9mKmPNOZZ+OelxD3iYoXfHl/k+YAp2CA58K/IE
         LiH7oCo7fIRY8aZeSSiwhBul0VobIEIGQVOa1w7dOYvnQZTYRr4H1GJNakGTwuVk28td
         VwZOugB7OiUs0OUigBq+qX3bqL2rUcJguaeCRJYjf9G8l0SQsLvyyaZjFj/xSH5Nh0vx
         1yEg==
X-Gm-Message-State: AOJu0Yzbrt/xs3XFTOB2vkfUgbI6NmOF3lvW/mutvhdw4Gs+I4lP1WpI
        atkP7+RkeawXV4f4yDpPnbGbIA==
X-Google-Smtp-Source: AGHT+IHWh0EZjB4sRwdO+sv2azBowUIC3rylFr9w/wT3XrqIi1O/kU8t1TW+RVuuA1jXai1FluM7wA==
X-Received: by 2002:a05:6870:e2d4:b0:1d0:f067:bf23 with SMTP id w20-20020a056870e2d400b001d0f067bf23mr4176763oad.25.1693611658361;
        Fri, 01 Sep 2023 16:40:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a1a4500b0026b4ca7f62csm3773488pjl.39.2023.09.01.16.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:40:56 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
        airlied@redhat.com, alexandre.torgue@foss.st.com, andrew@aj.id.au,
        daniel@ffwll.ch, emma@anholt.net, hdegoede@redhat.com,
        jfalempe@redhat.com, joel@jms.id.au, jyri.sarha@iki.fi,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, philippe.cornu@foss.st.com,
        raphael.gallais-pou@foss.st.com, tomi.valkeinen@ideasonboard.com,
        tzimmermann@suse.de, yannick.fertre@foss.st.com
Subject: [RFT PATCH 5/6] drm: Call drm_atomic_helper_shutdown() at shutdown/remove time for misc drivers
Date:   Fri,  1 Sep 2023 16:39:56 -0700
Message-ID: <20230901163944.RFT.5.I771eb4bd03d8772b19e7dcfaef3e2c167bce5846@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230901234015.566018-1-dianders@chromium.org>
References: <20230901234015.566018-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on grepping through the source code these drivers appear to be
missing a call to drm_atomic_helper_shutdown() at system shutdown time
and at driver remove (or unbind) time. Among other things, this means
that if a panel is in use that it won't be cleanly powered off at
system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart and at driver remove (or unbind) time comes
straight out of the kernel doc "driver instance overview" in
drm_drv.c.

A few notes about these fixes:
- I confirmed that these drivers were all DRIVER_MODESET type drivers,
  which I believe makes this relevant.
- I confirmed that these drivers were all DRIVER_ATOMIC.
- When adding drm_atomic_helper_shutdown() to the remove/unbind path,
  I added it after drm_kms_helper_poll_fini() when the driver had
  it. This seemed to be what other drivers did. If
  drm_kms_helper_poll_fini() wasn't there I added it straight after
  drm_dev_unregister().
- This patch deals with drivers using the component model in similar
  ways as the patch ("drm: Call drm_atomic_helper_shutdown() at
  shutdown time for misc drivers")
- These fixes rely on the patch ("drm/atomic-helper:
  drm_atomic_helper_shutdown(NULL) should be a noop") to simplify
  shutdown.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c |  7 +++++++
 drivers/gpu/drm/mgag200/mgag200_drv.c   |  8 ++++++++
 drivers/gpu/drm/pl111/pl111_drv.c       |  7 +++++++
 drivers/gpu/drm/stm/drv.c               |  7 +++++++
 drivers/gpu/drm/tilcdc/tilcdc_drv.c     | 11 ++++++++++-
 drivers/gpu/drm/tve200/tve200_drv.c     |  7 +++++++
 drivers/gpu/drm/vboxvideo/vbox_drv.c    | 10 ++++++++++
 7 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index d207b03f8357..78122b35a0cb 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -358,11 +358,18 @@ static void aspeed_gfx_remove(struct platform_device *pdev)
 	sysfs_remove_group(&pdev->dev.kobj, &aspeed_sysfs_attr_group);
 	drm_dev_unregister(drm);
 	aspeed_gfx_unload(drm);
+	drm_atomic_helper_shutdown(drm);
+}
+
+static void aspeed_gfx_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
 }
 
 static struct platform_driver aspeed_gfx_platform_driver = {
 	.probe		= aspeed_gfx_probe,
 	.remove_new	= aspeed_gfx_remove,
+	.shutdown	= aspeed_gfx_shutdown,
 	.driver = {
 		.name = "aspeed_gfx",
 		.of_match_table = aspeed_gfx_match,
diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index abddf37f0ea1..2fb18b782b05 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -10,6 +10,7 @@
 #include <linux/pci.h>
 
 #include <drm/drm_aperture.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_generic.h>
 #include <drm/drm_file.h>
@@ -278,6 +279,12 @@ static void mgag200_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
 	drm_dev_unregister(dev);
+	drm_atomic_helper_shutdown(dev);
+}
+
+static void mgag200_pci_shutdown(struct pci_dev *pdev)
+{
+	drm_atomic_helper_shutdown(pci_get_drvdata(pdev));
 }
 
 static struct pci_driver mgag200_pci_driver = {
@@ -285,6 +292,7 @@ static struct pci_driver mgag200_pci_driver = {
 	.id_table = mgag200_pciidlist,
 	.probe = mgag200_pci_probe,
 	.remove = mgag200_pci_remove,
+	.shutdown = mgag200_pci_shutdown,
 };
 
 drm_module_pci_driver_if_modeset(mgag200_pci_driver, mgag200_modeset);
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index ba3b5b5f0cdf..02e6b74d5016 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -323,12 +323,18 @@ static void pl111_amba_remove(struct amba_device *amba_dev)
 	struct pl111_drm_dev_private *priv = drm->dev_private;
 
 	drm_dev_unregister(drm);
+	drm_atomic_helper_shutdown(drm);
 	if (priv->panel)
 		drm_panel_bridge_remove(priv->bridge);
 	drm_dev_put(drm);
 	of_reserved_mem_device_release(dev);
 }
 
+static void pl111_amba_shutdown(struct amba_device *amba_dev)
+{
+	drm_atomic_helper_shutdown(amba_get_drvdata(amba_dev));
+}
+
 /*
  * This early variant lacks the 565 and 444 pixel formats.
  */
@@ -431,6 +437,7 @@ static struct amba_driver pl111_amba_driver __maybe_unused = {
 	},
 	.probe = pl111_amba_probe,
 	.remove = pl111_amba_remove,
+	.shutdown = pl111_amba_shutdown,
 	.id_table = pl111_id_table,
 };
 
diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index c68c831136c9..e8523abef27a 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -114,6 +114,7 @@ static void drv_unload(struct drm_device *ddev)
 	DRM_DEBUG("%s\n", __func__);
 
 	drm_kms_helper_poll_fini(ddev);
+	drm_atomic_helper_shutdown(ddev);
 	ltdc_unload(ddev);
 }
 
@@ -225,6 +226,11 @@ static void stm_drm_platform_remove(struct platform_device *pdev)
 	drm_dev_put(ddev);
 }
 
+static void stm_drm_platform_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
 static const struct of_device_id drv_dt_ids[] = {
 	{ .compatible = "st,stm32-ltdc"},
 	{ /* end node */ },
@@ -234,6 +240,7 @@ MODULE_DEVICE_TABLE(of, drv_dt_ids);
 static struct platform_driver stm_drm_platform_driver = {
 	.probe = stm_drm_platform_probe,
 	.remove_new = stm_drm_platform_remove,
+	.shutdown = stm_drm_platform_shutdown,
 	.driver = {
 		.name = "stm32-display",
 		.of_match_table = drv_dt_ids,
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index fe56beea3e93..8ebd7134ee21 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -175,6 +175,7 @@ static void tilcdc_fini(struct drm_device *dev)
 		drm_dev_unregister(dev);
 
 	drm_kms_helper_poll_fini(dev);
+	drm_atomic_helper_shutdown(dev);
 	tilcdc_irq_uninstall(dev);
 	drm_mode_config_cleanup(dev);
 
@@ -389,6 +390,7 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
 
 init_failed:
 	tilcdc_fini(ddev);
+	platform_set_drvdata(pdev, NULL);
 
 	return ret;
 }
@@ -537,7 +539,8 @@ static void tilcdc_unbind(struct device *dev)
 	if (!ddev->dev_private)
 		return;
 
-	tilcdc_fini(dev_get_drvdata(dev));
+	tilcdc_fini(ddev);
+	dev_set_drvdata(dev, NULL);
 }
 
 static const struct component_master_ops tilcdc_comp_ops = {
@@ -582,6 +585,11 @@ static int tilcdc_pdev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void tilcdc_pdev_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
 static const struct of_device_id tilcdc_of_match[] = {
 		{ .compatible = "ti,am33xx-tilcdc", },
 		{ .compatible = "ti,da850-tilcdc", },
@@ -592,6 +600,7 @@ MODULE_DEVICE_TABLE(of, tilcdc_of_match);
 static struct platform_driver tilcdc_platform_driver = {
 	.probe      = tilcdc_pdev_probe,
 	.remove     = tilcdc_pdev_remove,
+	.shutdown   = tilcdc_pdev_shutdown,
 	.driver     = {
 		.name   = "tilcdc",
 		.pm     = pm_sleep_ptr(&tilcdc_pm_ops),
diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 0bb56d063536..acce210e2554 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -242,6 +242,7 @@ static void tve200_remove(struct platform_device *pdev)
 	struct tve200_drm_dev_private *priv = drm->dev_private;
 
 	drm_dev_unregister(drm);
+	drm_atomic_helper_shutdown(drm);
 	if (priv->panel)
 		drm_panel_bridge_remove(priv->bridge);
 	drm_mode_config_cleanup(drm);
@@ -249,6 +250,11 @@ static void tve200_remove(struct platform_device *pdev)
 	drm_dev_put(drm);
 }
 
+static void tve200_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
 static const struct of_device_id tve200_of_match[] = {
 	{
 		.compatible = "faraday,tve200",
@@ -263,6 +269,7 @@ static struct platform_driver tve200_driver = {
 	},
 	.probe = tve200_probe,
 	.remove_new = tve200_remove,
+	.shutdown = tve200_shutdown,
 };
 drm_module_platform_driver(tve200_driver);
 
diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.c b/drivers/gpu/drm/vboxvideo/vbox_drv.c
index 4fee15c97c34..047b95812334 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_drv.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_drv.c
@@ -12,6 +12,7 @@
 #include <linux/vt_kern.h>
 
 #include <drm/drm_aperture.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_generic.h>
 #include <drm/drm_file.h>
@@ -97,11 +98,19 @@ static void vbox_pci_remove(struct pci_dev *pdev)
 	struct vbox_private *vbox = pci_get_drvdata(pdev);
 
 	drm_dev_unregister(&vbox->ddev);
+	drm_atomic_helper_shutdown(&vbox->ddev);
 	vbox_irq_fini(vbox);
 	vbox_mode_fini(vbox);
 	vbox_hw_fini(vbox);
 }
 
+static void vbox_pci_shutdown(struct pci_dev *pdev)
+{
+	struct vbox_private *vbox = pci_get_drvdata(pdev);
+
+	drm_atomic_helper_shutdown(&vbox->ddev);
+}
+
 static int vbox_pm_suspend(struct device *dev)
 {
 	struct vbox_private *vbox = dev_get_drvdata(dev);
@@ -165,6 +174,7 @@ static struct pci_driver vbox_pci_driver = {
 	.id_table = pciidlist,
 	.probe = vbox_pci_probe,
 	.remove = vbox_pci_remove,
+	.shutdown = vbox_pci_shutdown,
 	.driver.pm = pm_sleep_ptr(&vbox_pm_ops),
 };
 
-- 
2.42.0.283.g2d96d420d3-goog

