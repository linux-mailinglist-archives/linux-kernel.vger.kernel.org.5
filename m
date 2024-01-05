Return-Path: <linux-kernel+bounces-18109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF85825901
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68C62854AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2565935286;
	Fri,  5 Jan 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGlB60/O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DB13527E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704475465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AcCfcMHHiY1xTXjDETQi+ZV8peDXU9PZV5o5VdbUcHQ=;
	b=HGlB60/O7E0vOx515w4OQI7wjpbfKXxB3+J0B5LT+zEeKD1jH1NtKFCCk9UkgdEhWpSq+E
	fT17pvBJUOMxUmDeG0WzcH5mbUwcGH6Em2sEpBZooNCmQ4VJuv+UWPQbPmdNcmAjycMu/f
	Q2Xpnin4je05uvqm47D7FFb40cZ7MMk=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-CDbZ4FFOMDuPkuTEmrSCaw-1; Fri, 05 Jan 2024 12:24:24 -0500
X-MC-Unique: CDbZ4FFOMDuPkuTEmrSCaw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-203f9920bd9so490854fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 09:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704475463; x=1705080263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcCfcMHHiY1xTXjDETQi+ZV8peDXU9PZV5o5VdbUcHQ=;
        b=C921WsNervdfHYnh171GwHM2BFekTgdvPlEy3cnT4pZqzL6iiMepAJx3B4Ueq/PQlq
         Kvenmis17OaM60VzlNP8X2XLzw72nLPw9kC/UbpHrIJULLwVde15jw7cw++TOSKXCxhR
         b+Rhn2sNX7SjAYKHXhMZl/uaUbExilUAW9nLIOM538QtKZpJ1VLAaknf4BubCZiWXpNP
         O3AZrZXi4P7Nh/x+qHf0qxWwi7Q3xUzVKX7tEBULIGewQLao13kV6OSYFNDNVzqmsV/h
         SKSMXyB3LMzrT08MI955XlkbD7fhBq328UdNhgblUmxMu3VycPjOBLkFxjbQrnxNlsi1
         r8BA==
X-Gm-Message-State: AOJu0YzqlpB5s/j7q/1nu+RQQsGV791+T8DuGwwLajP6/uL00My4twYw
	kjZ6TRzjk+J7jX5K+amWbGtts2tElXaYrCkGH0q7GjGLLnNDsRR9vv/Ysv6LDCZtU0tgmO4PtVC
	ODdlikkReXgQbNdGkM2f0mESlxZ/pyZr00X7NwHLB
X-Received: by 2002:a05:6871:8a2:b0:205:c547:fa6c with SMTP id r34-20020a05687108a200b00205c547fa6cmr4932325oaq.4.1704475463451;
        Fri, 05 Jan 2024 09:24:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjzRlE7Iybtswflx60D1g0bfKqdl1Kcf5GIUUDSFjG04C5BzXoRzYM9sa3o3sJe5gVMnN7gg==
X-Received: by 2002:a05:6871:8a2:b0:205:c547:fa6c with SMTP id r34-20020a05687108a200b00205c547fa6cmr4932307oaq.4.1704475463104;
        Fri, 05 Jan 2024 09:24:23 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32d1:a900:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id l27-20020a05620a211b00b00781c8423ca1sm721994qkl.121.2024.01.05.09.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 09:24:22 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] drm/imx/dcss: have all init functions use devres
Date: Fri,  5 Jan 2024 18:24:04 +0100
Message-ID: <20240105172403.42951-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dcss currently allocates and ioremaps quite a few resources in its probe
function's call graph. Devres now provides convenient functions which
perform the same task but do the cleanup automatically.

Port all memory allocations and ioremap() calls to the devres
counterparts.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
This is a separate patch because it can be applied independently from my
other patch-series that applies the region-request for this driver.
---
 drivers/gpu/drm/imx/dcss/dcss-blkctl.c | 14 +++-----------
 drivers/gpu/drm/imx/dcss/dcss-ctxld.c  | 15 ++++-----------
 drivers/gpu/drm/imx/dcss/dcss-dev.c    | 11 ++---------
 drivers/gpu/drm/imx/dcss/dcss-dpr.c    | 25 ++++++-------------------
 drivers/gpu/drm/imx/dcss/dcss-drv.c    | 12 +++---------
 drivers/gpu/drm/imx/dcss/dcss-dtg.c    | 23 ++++-------------------
 drivers/gpu/drm/imx/dcss/dcss-scaler.c | 22 ++++------------------
 drivers/gpu/drm/imx/dcss/dcss-ss.c     | 11 +++--------
 8 files changed, 29 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-blkctl.c b/drivers/gpu/drm/imx/dcss/dcss-blkctl.c
index c9b54bb2692d..58e12ec65f80 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-blkctl.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-blkctl.c
@@ -41,15 +41,15 @@ void dcss_blkctl_cfg(struct dcss_blkctl *blkctl)
 int dcss_blkctl_init(struct dcss_dev *dcss, unsigned long blkctl_base)
 {
 	struct dcss_blkctl *blkctl;
+	struct device *dev = dcss->dev;
 
-	blkctl = kzalloc(sizeof(*blkctl), GFP_KERNEL);
+	blkctl = devm_kzalloc(dev, sizeof(*blkctl), GFP_KERNEL);
 	if (!blkctl)
 		return -ENOMEM;
 
-	blkctl->base_reg = ioremap(blkctl_base, SZ_4K);
+	blkctl->base_reg = devm_ioremap(dev, blkctl_base, SZ_4K);
 	if (!blkctl->base_reg) {
 		dev_err(dcss->dev, "unable to remap BLK CTRL base\n");
-		kfree(blkctl);
 		return -ENOMEM;
 	}
 
@@ -60,11 +60,3 @@ int dcss_blkctl_init(struct dcss_dev *dcss, unsigned long blkctl_base)
 
 	return 0;
 }
-
-void dcss_blkctl_exit(struct dcss_blkctl *blkctl)
-{
-	if (blkctl->base_reg)
-		iounmap(blkctl->base_reg);
-
-	kfree(blkctl);
-}
diff --git a/drivers/gpu/drm/imx/dcss/dcss-ctxld.c b/drivers/gpu/drm/imx/dcss/dcss-ctxld.c
index 3a84cb3209c4..444511d0f382 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-ctxld.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-ctxld.c
@@ -199,10 +199,11 @@ static int dcss_ctxld_alloc_ctx(struct dcss_ctxld *ctxld)
 
 int dcss_ctxld_init(struct dcss_dev *dcss, unsigned long ctxld_base)
 {
+	struct device *dev = dcss->dev;
 	struct dcss_ctxld *ctxld;
 	int ret;
 
-	ctxld = kzalloc(sizeof(*ctxld), GFP_KERNEL);
+	ctxld = devm_kzalloc(dev, sizeof(*ctxld), GFP_KERNEL);
 	if (!ctxld)
 		return -ENOMEM;
 
@@ -217,7 +218,7 @@ int dcss_ctxld_init(struct dcss_dev *dcss, unsigned long ctxld_base)
 		goto err;
 	}
 
-	ctxld->ctxld_reg = ioremap(ctxld_base, SZ_4K);
+	ctxld->ctxld_reg = devm_ioremap(dev, ctxld_base, SZ_4K);
 	if (!ctxld->ctxld_reg) {
 		dev_err(dcss->dev, "ctxld: unable to remap ctxld base\n");
 		ret = -ENOMEM;
@@ -226,18 +227,14 @@ int dcss_ctxld_init(struct dcss_dev *dcss, unsigned long ctxld_base)
 
 	ret = dcss_ctxld_irq_config(ctxld, to_platform_device(dcss->dev));
 	if (ret)
-		goto err_irq;
+		goto err;
 
 	dcss_ctxld_hw_cfg(ctxld);
 
 	return 0;
 
-err_irq:
-	iounmap(ctxld->ctxld_reg);
-
 err:
 	dcss_ctxld_free_ctx(ctxld);
-	kfree(ctxld);
 
 	return ret;
 }
@@ -246,11 +243,7 @@ void dcss_ctxld_exit(struct dcss_ctxld *ctxld)
 {
 	free_irq(ctxld->irq, ctxld);
 
-	if (ctxld->ctxld_reg)
-		iounmap(ctxld->ctxld_reg);
-
 	dcss_ctxld_free_ctx(ctxld);
-	kfree(ctxld);
 }
 
 static int dcss_ctxld_enable_locked(struct dcss_ctxld *ctxld)
diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
index efd3a998652d..d5a0bfaf458e 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
@@ -109,8 +109,6 @@ static int dcss_submodules_init(struct dcss_dev *dcss)
 	dcss_ctxld_exit(dcss->ctxld);
 
 ctxld_err:
-	dcss_blkctl_exit(dcss->blkctl);
-
 	dcss_clocks_disable(dcss);
 
 	return ret;
@@ -183,7 +181,7 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
 		return res;
 	}
 
-	dcss = kzalloc(sizeof(*dcss), GFP_KERNEL);
+	dcss = devm_kzalloc(dev, sizeof(*dcss), GFP_KERNEL);
 	if (!dcss)
 		return ERR_PTR(-ENOMEM);
 
@@ -194,7 +192,7 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
 	ret = dcss_clks_init(dcss);
 	if (ret) {
 		dev_err(dev, "clocks initialization failed\n");
-		goto err;
+		return ret;
 	}
 
 	dcss->of_port = of_graph_get_port_by_id(dev->of_node, 0);
@@ -226,9 +224,6 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
 clks_err:
 	dcss_clks_release(dcss);
 
-err:
-	kfree(dcss);
-
 	return ERR_PTR(ret);
 }
 
@@ -246,8 +241,6 @@ void dcss_dev_destroy(struct dcss_dev *dcss)
 	dcss_submodules_stop(dcss);
 
 	dcss_clks_release(dcss);
-
-	kfree(dcss);
 }
 
 static int dcss_dev_suspend(struct device *dev)
diff --git a/drivers/gpu/drm/imx/dcss/dcss-dpr.c b/drivers/gpu/drm/imx/dcss/dcss-dpr.c
index df9dab949bf2..d6b2ad5e6977 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dpr.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-dpr.c
@@ -125,7 +125,8 @@ static void dcss_dpr_write(struct dcss_dpr_ch *ch, u32 val, u32 ofs)
 	dcss_ctxld_write(dpr->ctxld, dpr->ctx_id, val, ch->base_ofs + ofs);
 }
 
-static int dcss_dpr_ch_init_all(struct dcss_dpr *dpr, unsigned long dpr_base)
+static int dcss_dpr_ch_init_all(struct device *dev, struct dcss_dpr *dpr,
+		unsigned long dpr_base)
 {
 	struct dcss_dpr_ch *ch;
 	int i;
@@ -135,7 +136,7 @@ static int dcss_dpr_ch_init_all(struct dcss_dpr *dpr, unsigned long dpr_base)
 
 		ch->base_ofs = dpr_base + i * 0x1000;
 
-		ch->base_reg = ioremap(ch->base_ofs, SZ_4K);
+		ch->base_reg = devm_ioremap(dev, ch->base_ofs, SZ_4K);
 		if (!ch->base_reg) {
 			dev_err(dpr->dev, "dpr: unable to remap ch %d base\n",
 				i);
@@ -154,8 +155,9 @@ static int dcss_dpr_ch_init_all(struct dcss_dpr *dpr, unsigned long dpr_base)
 int dcss_dpr_init(struct dcss_dev *dcss, unsigned long dpr_base)
 {
 	struct dcss_dpr *dpr;
+	struct device *dev = dcss->dev;
 
-	dpr = kzalloc(sizeof(*dpr), GFP_KERNEL);
+	dpr = devm_kzalloc(dev, sizeof(*dpr), GFP_KERNEL);
 	if (!dpr)
 		return -ENOMEM;
 
@@ -164,18 +166,8 @@ int dcss_dpr_init(struct dcss_dev *dcss, unsigned long dpr_base)
 	dpr->ctxld = dcss->ctxld;
 	dpr->ctx_id = CTX_SB_HP;
 
-	if (dcss_dpr_ch_init_all(dpr, dpr_base)) {
-		int i;
-
-		for (i = 0; i < 3; i++) {
-			if (dpr->ch[i].base_reg)
-				iounmap(dpr->ch[i].base_reg);
-		}
-
-		kfree(dpr);
-
+	if (dcss_dpr_ch_init_all(dev, dpr, dpr_base))
 		return -ENOMEM;
-	}
 
 	return 0;
 }
@@ -189,12 +181,7 @@ void dcss_dpr_exit(struct dcss_dpr *dpr)
 		struct dcss_dpr_ch *ch = &dpr->ch[ch_no];
 
 		dcss_writel(0, ch->base_reg + DCSS_DPR_SYSTEM_CTRL0);
-
-		if (ch->base_reg)
-			iounmap(ch->base_reg);
 	}
-
-	kfree(dpr);
 }
 
 static u32 dcss_dpr_x_pix_wide_adjust(struct dcss_dpr_ch *ch, u32 pix_wide,
diff --git a/drivers/gpu/drm/imx/dcss/dcss-drv.c b/drivers/gpu/drm/imx/dcss/dcss-drv.c
index b61cec0cc79d..bd3f9d58042c 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-drv.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-drv.c
@@ -51,15 +51,13 @@ static int dcss_drv_platform_probe(struct platform_device *pdev)
 
 	of_node_put(remote);
 
-	mdrv = kzalloc(sizeof(*mdrv), GFP_KERNEL);
+	mdrv = devm_kzalloc(dev, sizeof(*mdrv), GFP_KERNEL);
 	if (!mdrv)
 		return -ENOMEM;
 
 	mdrv->dcss = dcss_dev_create(dev, hdmi_output);
-	if (IS_ERR(mdrv->dcss)) {
-		err = PTR_ERR(mdrv->dcss);
-		goto err;
-	}
+	if (IS_ERR(mdrv->dcss))
+		return PTR_ERR(mdrv->dcss);
 
 	dev_set_drvdata(dev, mdrv);
 
@@ -75,8 +73,6 @@ static int dcss_drv_platform_probe(struct platform_device *pdev)
 dcss_shutoff:
 	dcss_dev_destroy(mdrv->dcss);
 
-err:
-	kfree(mdrv);
 	return err;
 }
 
@@ -87,8 +83,6 @@ static int dcss_drv_platform_remove(struct platform_device *pdev)
 	dcss_kms_detach(mdrv->kms);
 	dcss_dev_destroy(mdrv->dcss);
 
-	kfree(mdrv);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/imx/dcss/dcss-dtg.c b/drivers/gpu/drm/imx/dcss/dcss-dtg.c
index 30de00540f63..5c0f697587e6 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dtg.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-dtg.c
@@ -151,8 +151,9 @@ int dcss_dtg_init(struct dcss_dev *dcss, unsigned long dtg_base)
 {
 	int ret = 0;
 	struct dcss_dtg *dtg;
+	struct device *dev = dcss->dev;
 
-	dtg = kzalloc(sizeof(*dtg), GFP_KERNEL);
+	dtg = devm_kzalloc(dev, sizeof(*dtg), GFP_KERNEL);
 	if (!dtg)
 		return -ENOMEM;
 
@@ -160,11 +161,10 @@ int dcss_dtg_init(struct dcss_dev *dcss, unsigned long dtg_base)
 	dtg->dev = dcss->dev;
 	dtg->ctxld = dcss->ctxld;
 
-	dtg->base_reg = ioremap(dtg_base, SZ_4K);
+	dtg->base_reg = devm_ioremap(dev, dtg_base, SZ_4K);
 	if (!dtg->base_reg) {
 		dev_err(dcss->dev, "dtg: unable to remap dtg base\n");
-		ret = -ENOMEM;
-		goto err_ioremap;
+		return -ENOMEM;
 	}
 
 	dtg->base_ofs = dtg_base;
@@ -176,16 +176,6 @@ int dcss_dtg_init(struct dcss_dev *dcss, unsigned long dtg_base)
 		((dtg->alpha << DEFAULT_FG_ALPHA_POS) & DEFAULT_FG_ALPHA_MASK);
 
 	ret = dcss_dtg_irq_config(dtg, to_platform_device(dcss->dev));
-	if (ret)
-		goto err_irq;
-
-	return 0;
-
-err_irq:
-	iounmap(dtg->base_reg);
-
-err_ioremap:
-	kfree(dtg);
 
 	return ret;
 }
@@ -193,11 +183,6 @@ int dcss_dtg_init(struct dcss_dev *dcss, unsigned long dtg_base)
 void dcss_dtg_exit(struct dcss_dtg *dtg)
 {
 	free_irq(dtg->ctxld_kick_irq, dtg);
-
-	if (dtg->base_reg)
-		iounmap(dtg->base_reg);
-
-	kfree(dtg);
 }
 
 void dcss_dtg_sync_set(struct dcss_dtg *dtg, struct videomode *vm)
diff --git a/drivers/gpu/drm/imx/dcss/dcss-scaler.c b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
index 47852b9dd5ea..3dbd0ed68ac1 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-scaler.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
@@ -302,7 +302,7 @@ static int dcss_scaler_ch_init_all(struct dcss_scaler *scl,
 
 		ch->base_ofs = scaler_base + i * 0x400;
 
-		ch->base_reg = ioremap(ch->base_ofs, SZ_4K);
+		ch->base_reg = devm_ioremap(dev, ch->base_ofs, SZ_4K);
 		if (!ch->base_reg) {
 			dev_err(scl->dev, "scaler: unable to remap ch base\n");
 			return -ENOMEM;
@@ -317,8 +317,9 @@ static int dcss_scaler_ch_init_all(struct dcss_scaler *scl,
 int dcss_scaler_init(struct dcss_dev *dcss, unsigned long scaler_base)
 {
 	struct dcss_scaler *scaler;
+	struct device *dev = dcss->dev;
 
-	scaler = kzalloc(sizeof(*scaler), GFP_KERNEL);
+	scaler = devm_kzalloc(dev, sizeof(*scaler), GFP_KERNEL);
 	if (!scaler)
 		return -ENOMEM;
 
@@ -327,18 +328,8 @@ int dcss_scaler_init(struct dcss_dev *dcss, unsigned long scaler_base)
 	scaler->ctxld = dcss->ctxld;
 	scaler->ctx_id = CTX_SB_HP;
 
-	if (dcss_scaler_ch_init_all(scaler, scaler_base)) {
-		int i;
-
-		for (i = 0; i < 3; i++) {
-			if (scaler->ch[i].base_reg)
-				iounmap(scaler->ch[i].base_reg);
-		}
-
-		kfree(scaler);
-
+	if (dcss_scaler_ch_init_all(dev, scaler, scaler_base))
 		return -ENOMEM;
-	}
 
 	return 0;
 }
@@ -351,12 +342,7 @@ void dcss_scaler_exit(struct dcss_scaler *scl)
 		struct dcss_scaler_ch *ch = &scl->ch[ch_no];
 
 		dcss_writel(0, ch->base_reg + DCSS_SCALER_CTRL);
-
-		if (ch->base_reg)
-			iounmap(ch->base_reg);
 	}
-
-	kfree(scl);
 }
 
 void dcss_scaler_ch_enable(struct dcss_scaler *scl, int ch_num, bool en)
diff --git a/drivers/gpu/drm/imx/dcss/dcss-ss.c b/drivers/gpu/drm/imx/dcss/dcss-ss.c
index 8ddf08da911b..0a8320adc302 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-ss.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-ss.c
@@ -82,8 +82,9 @@ static void dcss_ss_write(struct dcss_ss *ss, u32 val, u32 ofs)
 int dcss_ss_init(struct dcss_dev *dcss, unsigned long ss_base)
 {
 	struct dcss_ss *ss;
+	struct device *dev = dcss->dev;
 
-	ss = kzalloc(sizeof(*ss), GFP_KERNEL);
+	ss = devm_kzalloc(dev, sizeof(*ss), GFP_KERNEL);
 	if (!ss)
 		return -ENOMEM;
 
@@ -91,10 +92,9 @@ int dcss_ss_init(struct dcss_dev *dcss, unsigned long ss_base)
 	ss->dev = dcss->dev;
 	ss->ctxld = dcss->ctxld;
 
-	ss->base_reg = ioremap(ss_base, SZ_4K);
+	ss->base_reg = devm_ioremap(dev, ss_base, SZ_4K);
 	if (!ss->base_reg) {
 		dev_err(dcss->dev, "ss: unable to remap ss base\n");
-		kfree(ss);
 		return -ENOMEM;
 	}
 
@@ -108,11 +108,6 @@ void dcss_ss_exit(struct dcss_ss *ss)
 {
 	/* stop SS */
 	dcss_writel(0, ss->base_reg + DCSS_SS_SYS_CTRL);
-
-	if (ss->base_reg)
-		iounmap(ss->base_reg);
-
-	kfree(ss);
 }
 
 void dcss_ss_subsam_set(struct dcss_ss *ss)
-- 
2.43.0


