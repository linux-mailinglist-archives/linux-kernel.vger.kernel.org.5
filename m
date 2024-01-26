Return-Path: <linux-kernel+bounces-40446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C084283E08E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3D61C21A02
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7867A208CF;
	Fri, 26 Jan 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="pyMXfiTR"
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0D208CE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290782; cv=none; b=N/HHxwe2M8jTTxYte5lhk+nTMc4snNdsoTmz2H9NRVdna8wW86IXwzrsUHYjoSFkBao7H7KtPNqjiXvwnf1xYLPPnAlGjsxk9ZBvvkAs3043tDybOGFkHCI5cnEPakJ2//8UOdon+wdGI12SWOLZcnBjrFiIbrjNtFhhDKrQ0P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290782; c=relaxed/simple;
	bh=NtzCK/4hDIa/zGDxjv7HafqY3WVWwac1abbrbXKxChc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mU1SMwdTUCJUXr7JoaflCmDu2ZXb8kUnjZBG/CN8Fo09UrIe4J3wEvCk2hOfPgmP/KX0myO+xSyX2K/v0rF/lNKG0c7WK154UoxgWu1p+pAGjXIwu75nuOvPZPgA/v5Fs2jwUn2S05fYgP/kGWTO0cbhw91EXxFR2tuvJ2W+4Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=pyMXfiTR; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id TQAsrSdRSP2ORTQAsrUKfL; Fri, 26 Jan 2024 18:39:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1706290772;
	bh=TH7FdfylWPkqCfD39hxgrbVUxxZQts3LiSVUBjj2CHw=;
	h=From:To:Cc:Subject:Date;
	b=pyMXfiTRrkaf0oQAe0ENUYycF1gM6VQvvO8TC4rIqpM012Kh8VeIOYoNNbtzyDxbT
	 02S58fJ8qxEaCgYn6QRMQPZjbqZHlpc3XGAeTjxO6eP1U0q1F2PIlMCeut8xye0Dvf
	 FpY/h6xSfBynce5lJL4xedusi94CM7nYA4KKQPUQ1rotVSnC8yuOE8WSICcrsczxix
	 mZHqfzzzOL9hb4cDHZrVKNJ9q37lL2ggFHKsSokwHMV8fjwfmS6//UuRpKYIu1qBo9
	 0CCwh9gDRMLe8RDsmEqlKgcTWTFk2Tr4YN+j/XmFQ4pRw4cxKxAr3BxatbCNzQxMbK
	 GepDPoTfMFCTQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 26 Jan 2024 18:39:32 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Vaibhav Agarwal <vaibhav.sr@gmail.com>,
	Mark Greer <mgreer@animalcreek.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <vireshk@kernel.org>,
	"Bryan O'Donoghue" <pure.logic@nexus-software.ie>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Alex Elder <elder@linaro.org>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v2] staging: greybus: Remove usage of the deprecated ida_simple_xx() API
Date: Fri, 26 Jan 2024 18:39:05 +0100
Message-ID: <2e7bbdaf8a49abb1253390394b51779f63283587.1705350141.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range()/ida_alloc_max() is inclusive. So a -1 has been added when
needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Alex Elder <elder@linaro.org>
---
Changes in v2:
  - Fix a typo in the commit message
  - Add R-b tag
---
 drivers/staging/greybus/audio_manager.c  |  8 ++++----
 drivers/staging/greybus/authentication.c |  6 +++---
 drivers/staging/greybus/fw-download.c    |  7 +++----
 drivers/staging/greybus/fw-management.c  | 20 +++++++++-----------
 drivers/staging/greybus/gbphy.c          |  6 +++---
 drivers/staging/greybus/loopback.c       |  6 +++---
 drivers/staging/greybus/raw.c            |  6 +++---
 drivers/staging/greybus/vibrator.c       |  6 +++---
 8 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/greybus/audio_manager.c b/drivers/staging/greybus/audio_manager.c
index 9a3f7c034ab4..fa43d35bbcec 100644
--- a/drivers/staging/greybus/audio_manager.c
+++ b/drivers/staging/greybus/audio_manager.c
@@ -44,14 +44,14 @@ int gb_audio_manager_add(struct gb_audio_manager_module_descriptor *desc)
 	int id;
 	int err;
 
-	id = ida_simple_get(&module_id, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&module_id, GFP_KERNEL);
 	if (id < 0)
 		return id;
 
 	err = gb_audio_manager_module_create(&module, manager_kset,
 					     id, desc);
 	if (err) {
-		ida_simple_remove(&module_id, id);
+		ida_free(&module_id, id);
 		return err;
 	}
 
@@ -78,7 +78,7 @@ int gb_audio_manager_remove(int id)
 	list_del(&module->list);
 	kobject_put(&module->kobj);
 	up_write(&modules_rwsem);
-	ida_simple_remove(&module_id, id);
+	ida_free(&module_id, id);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gb_audio_manager_remove);
@@ -92,7 +92,7 @@ void gb_audio_manager_remove_all(void)
 
 	list_for_each_entry_safe(module, next, &modules_list, list) {
 		list_del(&module->list);
-		ida_simple_remove(&module_id, module->id);
+		ida_free(&module_id, module->id);
 		kobject_put(&module->kobj);
 	}
 
diff --git a/drivers/staging/greybus/authentication.c b/drivers/staging/greybus/authentication.c
index b67315641d18..d53e58f92e81 100644
--- a/drivers/staging/greybus/authentication.c
+++ b/drivers/staging/greybus/authentication.c
@@ -324,7 +324,7 @@ int gb_cap_connection_init(struct gb_connection *connection)
 	if (ret)
 		goto err_list_del;
 
-	minor = ida_simple_get(&cap_minors_map, 0, NUM_MINORS, GFP_KERNEL);
+	minor = ida_alloc_max(&cap_minors_map, NUM_MINORS - 1, GFP_KERNEL);
 	if (minor < 0) {
 		ret = minor;
 		goto err_connection_disable;
@@ -351,7 +351,7 @@ int gb_cap_connection_init(struct gb_connection *connection)
 err_del_cdev:
 	cdev_del(&cap->cdev);
 err_remove_ida:
-	ida_simple_remove(&cap_minors_map, minor);
+	ida_free(&cap_minors_map, minor);
 err_connection_disable:
 	gb_connection_disable(connection);
 err_list_del:
@@ -375,7 +375,7 @@ void gb_cap_connection_exit(struct gb_connection *connection)
 
 	device_destroy(&cap_class, cap->dev_num);
 	cdev_del(&cap->cdev);
-	ida_simple_remove(&cap_minors_map, MINOR(cap->dev_num));
+	ida_free(&cap_minors_map, MINOR(cap->dev_num));
 
 	/*
 	 * Disallow any new ioctl operations on the char device and wait for
diff --git a/drivers/staging/greybus/fw-download.c b/drivers/staging/greybus/fw-download.c
index 543692c567f9..2a5c6d1b049c 100644
--- a/drivers/staging/greybus/fw-download.c
+++ b/drivers/staging/greybus/fw-download.c
@@ -63,8 +63,7 @@ static void fw_req_release(struct kref *kref)
 	 * just hope that it never happens.
 	 */
 	if (!fw_req->timedout)
-		ida_simple_remove(&fw_req->fw_download->id_map,
-				  fw_req->firmware_id);
+		ida_free(&fw_req->fw_download->id_map, fw_req->firmware_id);
 
 	kfree(fw_req);
 }
@@ -171,7 +170,7 @@ static struct fw_request *find_firmware(struct fw_download *fw_download,
 		return ERR_PTR(-ENOMEM);
 
 	/* Allocate ids from 1 to 255 (u8-max), 0 is an invalid id */
-	ret = ida_simple_get(&fw_download->id_map, 1, 256, GFP_KERNEL);
+	ret = ida_alloc_range(&fw_download->id_map, 1, 255, GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(fw_download->parent,
 			"failed to allocate firmware id (%d)\n", ret);
@@ -212,7 +211,7 @@ static struct fw_request *find_firmware(struct fw_download *fw_download,
 	return fw_req;
 
 err_free_id:
-	ida_simple_remove(&fw_download->id_map, fw_req->firmware_id);
+	ida_free(&fw_download->id_map, fw_req->firmware_id);
 err_free_req:
 	kfree(fw_req);
 
diff --git a/drivers/staging/greybus/fw-management.c b/drivers/staging/greybus/fw-management.c
index 93137a3c4907..3054f084d777 100644
--- a/drivers/staging/greybus/fw-management.c
+++ b/drivers/staging/greybus/fw-management.c
@@ -165,7 +165,7 @@ static int fw_mgmt_load_and_validate_operation(struct fw_mgmt *fw_mgmt,
 	}
 
 	/* Allocate ids from 1 to 255 (u8-max), 0 is an invalid id */
-	ret = ida_simple_get(&fw_mgmt->id_map, 1, 256, GFP_KERNEL);
+	ret = ida_alloc_range(&fw_mgmt->id_map, 1, 255, GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(fw_mgmt->parent, "failed to allocate request id (%d)\n",
 			ret);
@@ -180,8 +180,7 @@ static int fw_mgmt_load_and_validate_operation(struct fw_mgmt *fw_mgmt,
 				GB_FW_MGMT_TYPE_LOAD_AND_VALIDATE_FW, &request,
 				sizeof(request), NULL, 0);
 	if (ret) {
-		ida_simple_remove(&fw_mgmt->id_map,
-				  fw_mgmt->intf_fw_request_id);
+		ida_free(&fw_mgmt->id_map, fw_mgmt->intf_fw_request_id);
 		fw_mgmt->intf_fw_request_id = 0;
 		dev_err(fw_mgmt->parent,
 			"load and validate firmware request failed (%d)\n",
@@ -220,7 +219,7 @@ static int fw_mgmt_interface_fw_loaded_operation(struct gb_operation *op)
 		return -ENODEV;
 	}
 
-	ida_simple_remove(&fw_mgmt->id_map, fw_mgmt->intf_fw_request_id);
+	ida_free(&fw_mgmt->id_map, fw_mgmt->intf_fw_request_id);
 	fw_mgmt->intf_fw_request_id = 0;
 	fw_mgmt->intf_fw_status = request->status;
 	fw_mgmt->intf_fw_major = le16_to_cpu(request->major);
@@ -316,7 +315,7 @@ static int fw_mgmt_backend_fw_update_operation(struct fw_mgmt *fw_mgmt,
 	}
 
 	/* Allocate ids from 1 to 255 (u8-max), 0 is an invalid id */
-	ret = ida_simple_get(&fw_mgmt->id_map, 1, 256, GFP_KERNEL);
+	ret = ida_alloc_range(&fw_mgmt->id_map, 1, 255, GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(fw_mgmt->parent, "failed to allocate request id (%d)\n",
 			ret);
@@ -330,8 +329,7 @@ static int fw_mgmt_backend_fw_update_operation(struct fw_mgmt *fw_mgmt,
 				GB_FW_MGMT_TYPE_BACKEND_FW_UPDATE, &request,
 				sizeof(request), NULL, 0);
 	if (ret) {
-		ida_simple_remove(&fw_mgmt->id_map,
-				  fw_mgmt->backend_fw_request_id);
+		ida_free(&fw_mgmt->id_map, fw_mgmt->backend_fw_request_id);
 		fw_mgmt->backend_fw_request_id = 0;
 		dev_err(fw_mgmt->parent,
 			"backend %s firmware update request failed (%d)\n", tag,
@@ -369,7 +367,7 @@ static int fw_mgmt_backend_fw_updated_operation(struct gb_operation *op)
 		return -ENODEV;
 	}
 
-	ida_simple_remove(&fw_mgmt->id_map, fw_mgmt->backend_fw_request_id);
+	ida_free(&fw_mgmt->id_map, fw_mgmt->backend_fw_request_id);
 	fw_mgmt->backend_fw_request_id = 0;
 	fw_mgmt->backend_fw_status = request->status;
 
@@ -617,7 +615,7 @@ int gb_fw_mgmt_connection_init(struct gb_connection *connection)
 	if (ret)
 		goto err_list_del;
 
-	minor = ida_simple_get(&fw_mgmt_minors_map, 0, NUM_MINORS, GFP_KERNEL);
+	minor = ida_alloc_max(&fw_mgmt_minors_map, NUM_MINORS - 1, GFP_KERNEL);
 	if (minor < 0) {
 		ret = minor;
 		goto err_connection_disable;
@@ -645,7 +643,7 @@ int gb_fw_mgmt_connection_init(struct gb_connection *connection)
 err_del_cdev:
 	cdev_del(&fw_mgmt->cdev);
 err_remove_ida:
-	ida_simple_remove(&fw_mgmt_minors_map, minor);
+	ida_free(&fw_mgmt_minors_map, minor);
 err_connection_disable:
 	gb_connection_disable(connection);
 err_list_del:
@@ -669,7 +667,7 @@ void gb_fw_mgmt_connection_exit(struct gb_connection *connection)
 
 	device_destroy(&fw_mgmt_class, fw_mgmt->dev_num);
 	cdev_del(&fw_mgmt->cdev);
-	ida_simple_remove(&fw_mgmt_minors_map, MINOR(fw_mgmt->dev_num));
+	ida_free(&fw_mgmt_minors_map, MINOR(fw_mgmt->dev_num));
 
 	/*
 	 * Disallow any new ioctl operations on the char device and wait for
diff --git a/drivers/staging/greybus/gbphy.c b/drivers/staging/greybus/gbphy.c
index 6a7d8cf2a1eb..93b74a236ab1 100644
--- a/drivers/staging/greybus/gbphy.c
+++ b/drivers/staging/greybus/gbphy.c
@@ -46,7 +46,7 @@ static void gbphy_dev_release(struct device *dev)
 {
 	struct gbphy_device *gbphy_dev = to_gbphy_dev(dev);
 
-	ida_simple_remove(&gbphy_id, gbphy_dev->id);
+	ida_free(&gbphy_id, gbphy_dev->id);
 	kfree(gbphy_dev);
 }
 
@@ -225,13 +225,13 @@ static struct gbphy_device *gb_gbphy_create_dev(struct gb_bundle *bundle,
 	int retval;
 	int id;
 
-	id = ida_simple_get(&gbphy_id, 1, 0, GFP_KERNEL);
+	id = ida_alloc_min(&gbphy_id, 1, GFP_KERNEL);
 	if (id < 0)
 		return ERR_PTR(id);
 
 	gbphy_dev = kzalloc(sizeof(*gbphy_dev), GFP_KERNEL);
 	if (!gbphy_dev) {
-		ida_simple_remove(&gbphy_id, id);
+		ida_free(&gbphy_id, id);
 		return ERR_PTR(-ENOMEM);
 	}
 
diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index d7b39f3bb652..bb33379b5297 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -1028,7 +1028,7 @@ static int gb_loopback_probe(struct gb_bundle *bundle,
 	gb->file = debugfs_create_file(name, S_IFREG | 0444, gb_dev.root, gb,
 				       &gb_loopback_dbgfs_latency_fops);
 
-	gb->id = ida_simple_get(&loopback_ida, 0, 0, GFP_KERNEL);
+	gb->id = ida_alloc(&loopback_ida, GFP_KERNEL);
 	if (gb->id < 0) {
 		retval = gb->id;
 		goto out_debugfs_remove;
@@ -1079,7 +1079,7 @@ static int gb_loopback_probe(struct gb_bundle *bundle,
 out_connection_disable:
 	gb_connection_disable(connection);
 out_ida_remove:
-	ida_simple_remove(&loopback_ida, gb->id);
+	ida_free(&loopback_ida, gb->id);
 out_debugfs_remove:
 	debugfs_remove(gb->file);
 out_connection_destroy:
@@ -1121,7 +1121,7 @@ static void gb_loopback_disconnect(struct gb_bundle *bundle)
 	spin_unlock_irqrestore(&gb_dev.lock, flags);
 
 	device_unregister(gb->dev);
-	ida_simple_remove(&loopback_ida, gb->id);
+	ida_free(&loopback_ida, gb->id);
 
 	gb_connection_destroy(gb->connection);
 	kfree(gb);
diff --git a/drivers/staging/greybus/raw.c b/drivers/staging/greybus/raw.c
index b9c6eff7cdc1..836d35e5fa85 100644
--- a/drivers/staging/greybus/raw.c
+++ b/drivers/staging/greybus/raw.c
@@ -181,7 +181,7 @@ static int gb_raw_probe(struct gb_bundle *bundle,
 	raw->connection = connection;
 	greybus_set_drvdata(bundle, raw);
 
-	minor = ida_simple_get(&minors, 0, 0, GFP_KERNEL);
+	minor = ida_alloc(&minors, GFP_KERNEL);
 	if (minor < 0) {
 		retval = minor;
 		goto error_connection_destroy;
@@ -214,7 +214,7 @@ static int gb_raw_probe(struct gb_bundle *bundle,
 	gb_connection_disable(connection);
 
 error_remove_ida:
-	ida_simple_remove(&minors, minor);
+	ida_free(&minors, minor);
 
 error_connection_destroy:
 	gb_connection_destroy(connection);
@@ -235,7 +235,7 @@ static void gb_raw_disconnect(struct gb_bundle *bundle)
 	device_destroy(&raw_class, raw->dev);
 	cdev_del(&raw->cdev);
 	gb_connection_disable(connection);
-	ida_simple_remove(&minors, MINOR(raw->dev));
+	ida_free(&minors, MINOR(raw->dev));
 	gb_connection_destroy(connection);
 
 	mutex_lock(&raw->list_lock);
diff --git a/drivers/staging/greybus/vibrator.c b/drivers/staging/greybus/vibrator.c
index 227e18d92a95..89bef8045549 100644
--- a/drivers/staging/greybus/vibrator.c
+++ b/drivers/staging/greybus/vibrator.c
@@ -153,7 +153,7 @@ static int gb_vibrator_probe(struct gb_bundle *bundle,
 	 * there is a "real" device somewhere in the kernel for this, but I
 	 * can't find it at the moment...
 	 */
-	vib->minor = ida_simple_get(&minors, 0, 0, GFP_KERNEL);
+	vib->minor = ida_alloc(&minors, GFP_KERNEL);
 	if (vib->minor < 0) {
 		retval = vib->minor;
 		goto err_connection_disable;
@@ -173,7 +173,7 @@ static int gb_vibrator_probe(struct gb_bundle *bundle,
 	return 0;
 
 err_ida_remove:
-	ida_simple_remove(&minors, vib->minor);
+	ida_free(&minors, vib->minor);
 err_connection_disable:
 	gb_connection_disable(connection);
 err_connection_destroy:
@@ -197,7 +197,7 @@ static void gb_vibrator_disconnect(struct gb_bundle *bundle)
 		turn_off(vib);
 
 	device_unregister(vib->dev);
-	ida_simple_remove(&minors, vib->minor);
+	ida_free(&minors, vib->minor);
 	gb_connection_disable(vib->connection);
 	gb_connection_destroy(vib->connection);
 	kfree(vib);
-- 
2.43.0


