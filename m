Return-Path: <linux-kernel+bounces-56938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6201B84D197
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86531F2325F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C00132C0C;
	Wed,  7 Feb 2024 18:43:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6D0127B53
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331407; cv=none; b=sTEc2loMOfcKBs5v/K3mA0ZkTP+wa5XmXyL8ua4FZEQkwB1/uqhYfQcuEj7tibu4/Q1vdv3eIFkJn8s05ZAQsoRqIZ4eKS9WnXZqq665cCUAFffeHqL4QUossLpqDM6ojk8c+7XFkKny2gB9bxJJKToOEbm2voFTpAh9BC2uxQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331407; c=relaxed/simple;
	bh=1f9SjqEJ981z82qsp+A5Bg52oPFT/FITs+AmF47LZUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5orUyM2/ZUpolL+gkAA5wyaEyTy7lN3RuJquarX9Lcwa91fUWVpNtX3mxsgjCHO5+V4I/9knytzwLPacACGy3XRxqiXXQWAn5LSosNYN0alwLwzpiPL6MyYLIPn1BQv9SKxFYKGTS7J7AjDiqlzWUua+GpWvQZ+IxpoGxQROoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt4-0007PO-4K; Wed, 07 Feb 2024 19:43:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt3-0054XC-Iu; Wed, 07 Feb 2024 19:43:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt3-00HRsD-1c;
	Wed, 07 Feb 2024 19:43:09 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/32] media: usb/msi2500: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:22 +0100
Message-ID:  <d4dc8acc3c4105b9093e97f6337a81d11e6d30ae.1707324794.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3953; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1f9SjqEJ981z82qsp+A5Bg52oPFT/FITs+AmF47LZUI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86eyQiko4JVdjBa6qFmafT4vAq8x7fcZ2pyw 1ExWCiBMeeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOngAKCRCPgPtYfRL+ TksqCACokwYzPuYI6erNFFLbU3dYc2XSf8xz/Hanw9kE101+EY626A7Vx+WCfJ9alTu3kMISGfP xiqAQOGuw4HRpfKl55qLkulXeJRjtE1OrMObeeY4ksxEq8SAEVCJ7OfBNx1+uA26YBI/wjMzfyp wJ6V41Y4lh1v99L0wE/96K7ktzRqHwuMpp08WJVWeXQamoMg5IQ4EHPjVyyC+ccTVXcbCJw+FQj GbTbHY7bnvZ4itjqdrL9pKLCwhdts2m0qkYTPZB+nfPpQkWJYtmVhjD+awMgyZQdj6O1CsdB9lk xMoBncb2lHzI1eOWhFfcvaWLw7iBWtM9j61KHs5Gq4w7PM+4
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
this driver.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/media/usb/msi2500/msi2500.c | 38 ++++++++++++++---------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
index 9759996ee6a4..5138486abfa0 100644
--- a/drivers/media/usb/msi2500/msi2500.c
+++ b/drivers/media/usb/msi2500/msi2500.c
@@ -107,7 +107,7 @@ struct msi2500_dev {
 	struct video_device vdev;
 	struct v4l2_device v4l2_dev;
 	struct v4l2_subdev *v4l2_subdev;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 
 	/* videobuf2 queue and queued buffers list */
 	struct vb2_queue vb_queue;
@@ -574,7 +574,7 @@ static void msi2500_disconnect(struct usb_interface *intf)
 	dev->udev = NULL;
 	v4l2_device_disconnect(&dev->v4l2_dev);
 	video_unregister_device(&dev->vdev);
-	spi_unregister_master(dev->master);
+	spi_unregister_controller(dev->ctlr);
 	mutex_unlock(&dev->v4l2_lock);
 	mutex_unlock(&dev->vb_queue_lock);
 
@@ -1136,10 +1136,10 @@ static void msi2500_video_release(struct v4l2_device *v)
 	kfree(dev);
 }
 
-static int msi2500_transfer_one_message(struct spi_master *master,
+static int msi2500_transfer_one_message(struct spi_controller *ctlr,
 					struct spi_message *m)
 {
-	struct msi2500_dev *dev = spi_master_get_devdata(master);
+	struct msi2500_dev *dev = spi_controller_get_devdata(ctlr);
 	struct spi_transfer *t;
 	int ret = 0;
 	u32 data;
@@ -1154,7 +1154,7 @@ static int msi2500_transfer_one_message(struct spi_master *master,
 	}
 
 	m->status = ret;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(ctlr);
 	return ret;
 }
 
@@ -1163,7 +1163,7 @@ static int msi2500_probe(struct usb_interface *intf,
 {
 	struct msi2500_dev *dev;
 	struct v4l2_subdev *sd;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	int ret;
 	static struct spi_board_info board_info = {
 		.modalias		= "msi001",
@@ -1220,30 +1220,30 @@ static int msi2500_probe(struct usb_interface *intf,
 	}
 
 	/* SPI master adapter */
-	master = spi_alloc_master(dev->dev, 0);
-	if (master == NULL) {
+	ctlr = spi_alloc_master(dev->dev, 0);
+	if (ctlr == NULL) {
 		ret = -ENOMEM;
 		goto err_unregister_v4l2_dev;
 	}
 
-	dev->master = master;
-	master->bus_num = -1;
-	master->num_chipselect = 1;
-	master->transfer_one_message = msi2500_transfer_one_message;
-	spi_master_set_devdata(master, dev);
-	ret = spi_register_master(master);
+	dev->ctlr = ctlr;
+	ctlr->bus_num = -1;
+	ctlr->num_chipselect = 1;
+	ctlr->transfer_one_message = msi2500_transfer_one_message;
+	spi_controller_set_devdata(ctlr, dev);
+	ret = spi_register_controller(ctlr);
 	if (ret) {
-		spi_master_put(master);
+		spi_controller_put(ctlr);
 		goto err_unregister_v4l2_dev;
 	}
 
 	/* load v4l2 subdevice */
-	sd = v4l2_spi_new_subdev(&dev->v4l2_dev, master, &board_info);
+	sd = v4l2_spi_new_subdev(&dev->v4l2_dev, ctlr, &board_info);
 	dev->v4l2_subdev = sd;
 	if (sd == NULL) {
 		dev_err(dev->dev, "cannot get v4l2 subdevice\n");
 		ret = -ENODEV;
-		goto err_unregister_master;
+		goto err_unregister_controller;
 	}
 
 	/* Register controls */
@@ -1276,8 +1276,8 @@ static int msi2500_probe(struct usb_interface *intf,
 	return 0;
 err_free_controls:
 	v4l2_ctrl_handler_free(&dev->hdl);
-err_unregister_master:
-	spi_unregister_master(dev->master);
+err_unregister_controller:
+	spi_unregister_controller(dev->ctlr);
 err_unregister_v4l2_dev:
 	v4l2_device_unregister(&dev->v4l2_dev);
 err_free_mem:
-- 
2.43.0


