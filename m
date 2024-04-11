Return-Path: <linux-kernel+bounces-140444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDE58A14C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74CDEB20B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B53F2E3E8;
	Thu, 11 Apr 2024 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="GSIDfOnu";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="GSIDfOnu"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA05382;
	Thu, 11 Apr 2024 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839028; cv=none; b=oJjsQHrlEbkR9XDbMqPyEtLpjmfgbNeY3xHaP263Zhm6s99Kf+hjGP1Ru7Cbvr8AhRbu6k8aDKGkaXhud9RzBbjLkOf8yQfheY56SjeY1S1CZn16hEHPDfaRa08dVli0PHUSy2VzinsdmnIFTLnqcstfHFppPSNhg88n+sj9h40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839028; c=relaxed/simple;
	bh=n6j8zNMrwmiiRC69tMRLHWQzNA+exQtyre1IxHuHuMQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=SnKC6QQXq0mYBfQZCrKGQYsBhCxj2P4OyBuGp52fdLKH4hYF4nOzFjdY5zISxUosxCbMKCttSj9a1L2FNesDSfBKvVYlGXrQo/236ascCFlWi3nXyj+pfk+u6cb94GNu1hFVdORxuhJzjq2ERLQikn4QxEB6dd8C5jXnfzRmWYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=GSIDfOnu; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=GSIDfOnu; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1712839024;
	bh=n6j8zNMrwmiiRC69tMRLHWQzNA+exQtyre1IxHuHuMQ=;
	h=Message-ID:Subject:From:To:Date:From;
	b=GSIDfOnufc/dzaXWn/4LTxbwiNSoY6WqjsQLpQTZdDKQN+Mvdl2xq180s+G4L49CL
	 SnRXdxNeclxN4WA/2VuMrtOdOnaoQSxZJajQXez9Vk5SUun2ZOnKcyUD7yylDgZfxX
	 oOY1wln8L7fjeBt+X9YP36YUmwp2xZkZ5oxaD2MI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id B418D1287E36;
	Thu, 11 Apr 2024 08:37:04 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Rlcv9m6pWbHo; Thu, 11 Apr 2024 08:37:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1712839024;
	bh=n6j8zNMrwmiiRC69tMRLHWQzNA+exQtyre1IxHuHuMQ=;
	h=Message-ID:Subject:From:To:Date:From;
	b=GSIDfOnufc/dzaXWn/4LTxbwiNSoY6WqjsQLpQTZdDKQN+Mvdl2xq180s+G4L49CL
	 SnRXdxNeclxN4WA/2VuMrtOdOnaoQSxZJajQXez9Vk5SUun2ZOnKcyUD7yylDgZfxX
	 oOY1wln8L7fjeBt+X9YP36YUmwp2xZkZ5oxaD2MI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 020BE1287E28;
	Thu, 11 Apr 2024 08:37:03 -0400 (EDT)
Message-ID: <3151adf5a1e0566e930454aac1a7c60722f5c711.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.9-rc3
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Thu, 11 Apr 2024 08:37:02 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The most important fix is the sg one because the regression it fixes
(spurious warning and use after final put) is already backported to
stable.  The next biggest impact is the target fix for wrong
credentials used to load a module because it's affecting new kernels
installed on selinux based distributions.  The other three fixes are an
obvious off by one and SATA protocol issues.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Alexander Wetzel (1):
      scsi: sg: Avoid race in error handling & drop bogus warn

Dan Carpenter (1):
      scsi: qla2xxx: Fix off by one in qla_edif_app_getstats()

Maurizio Lombardi (1):
      scsi: target: Fix SELinux error when systemd-modules loads the target module

Xiang Chen (2):
      scsi: hisi_sas: Modify the deadline for ata_wait_after_reset()
      scsi: hisi_sas: Handle the NCQ error returned by D2H frame

And the diffstat:

 drivers/scsi/hisi_sas/hisi_sas_main.c  |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 10 +++++++++-
 drivers/scsi/qla2xxx/qla_edif.c        |  2 +-
 drivers/scsi/sg.c                      | 18 ++++++++++--------
 drivers/target/target_core_configfs.c  | 12 ++++++++++++
 5 files changed, 33 insertions(+), 11 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 097dfe4b620d..35f8e00850d6 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1797,7 +1797,7 @@ static int hisi_sas_debug_I_T_nexus_reset(struct domain_device *device)
 	if (dev_is_sata(device)) {
 		struct ata_link *link = &device->sata_dev.ap->link;
 
-		rc = ata_wait_after_reset(link, HISI_SAS_WAIT_PHYUP_TIMEOUT,
+		rc = ata_wait_after_reset(link, jiffies + HISI_SAS_WAIT_PHYUP_TIMEOUT,
 					  smp_ata_check_ready_type);
 	} else {
 		msleep(2000);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 7d2a33514538..34f96cc35342 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2244,7 +2244,15 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
 		if ((dw0 & CMPLT_HDR_RSPNS_XFRD_MSK) &&
 		    (sipc_rx_err_type & RX_FIS_STATUS_ERR_MSK)) {
-			ts->stat = SAS_PROTO_RESPONSE;
+			if (task->ata_task.use_ncq) {
+				struct domain_device *device = task->dev;
+				struct hisi_sas_device *sas_dev = device->lldd_dev;
+
+				sas_dev->dev_status = HISI_SAS_DEV_NCQ_ERR;
+				slot->abort = 1;
+			} else {
+				ts->stat = SAS_PROTO_RESPONSE;
+			}
 		} else if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
 			ts->residual = trans_tx_fail_type;
 			ts->stat = SAS_DATA_UNDERRUN;
diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index 26e6b3e3af43..dcde55c8ee5d 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -1100,7 +1100,7 @@ qla_edif_app_getstats(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 
 		list_for_each_entry_safe(fcport, tf, &vha->vp_fcports, list) {
 			if (fcport->edif.enable) {
-				if (pcnt > app_req.num_ports)
+				if (pcnt >= app_req.num_ports)
 					break;
 
 				app_reply->elem[pcnt].rekey_count =
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 386981c6976a..baf870a03ecf 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -285,6 +285,7 @@ sg_open(struct inode *inode, struct file *filp)
 	int dev = iminor(inode);
 	int flags = filp->f_flags;
 	struct request_queue *q;
+	struct scsi_device *device;
 	Sg_device *sdp;
 	Sg_fd *sfp;
 	int retval;
@@ -301,11 +302,12 @@ sg_open(struct inode *inode, struct file *filp)
 
 	/* This driver's module count bumped by fops_get in <linux/fs.h> */
 	/* Prevent the device driver from vanishing while we sleep */
-	retval = scsi_device_get(sdp->device);
+	device = sdp->device;
+	retval = scsi_device_get(device);
 	if (retval)
 		goto sg_put;
 
-	retval = scsi_autopm_get_device(sdp->device);
+	retval = scsi_autopm_get_device(device);
 	if (retval)
 		goto sdp_put;
 
@@ -313,7 +315,7 @@ sg_open(struct inode *inode, struct file *filp)
 	 * check if O_NONBLOCK. Permits SCSI commands to be issued
 	 * during error recovery. Tread carefully. */
 	if (!((flags & O_NONBLOCK) ||
-	      scsi_block_when_processing_errors(sdp->device))) {
+	      scsi_block_when_processing_errors(device))) {
 		retval = -ENXIO;
 		/* we are in error recovery for this device */
 		goto error_out;
@@ -344,7 +346,7 @@ sg_open(struct inode *inode, struct file *filp)
 
 	if (sdp->open_cnt < 1) {  /* no existing opens */
 		sdp->sgdebug = 0;
-		q = sdp->device->request_queue;
+		q = device->request_queue;
 		sdp->sg_tablesize = queue_max_segments(q);
 	}
 	sfp = sg_add_sfp(sdp);
@@ -370,10 +372,11 @@ sg_open(struct inode *inode, struct file *filp)
 error_mutex_locked:
 	mutex_unlock(&sdp->open_rel_lock);
 error_out:
-	scsi_autopm_put_device(sdp->device);
+	scsi_autopm_put_device(device);
 sdp_put:
-	scsi_device_put(sdp->device);
-	goto sg_put;
+	kref_put(&sdp->d_ref, sg_device_destroy);
+	scsi_device_put(device);
+	return retval;
 }
 
 /* Release resources associated with a successful sg_open()
@@ -2233,7 +2236,6 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 			"sg_remove_sfp: sfp=0x%p\n", sfp));
 	kfree(sfp);
 
-	WARN_ON_ONCE(kref_read(&sdp->d_ref) != 1);
 	kref_put(&sdp->d_ref, sg_device_destroy);
 	scsi_device_put(device);
 	module_put(THIS_MODULE);
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index c1fbcdd16182..c40217f44b1b 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3672,6 +3672,8 @@ static int __init target_core_init_configfs(void)
 {
 	struct configfs_subsystem *subsys = &target_core_fabrics;
 	struct t10_alua_lu_gp *lu_gp;
+	struct cred *kern_cred;
+	const struct cred *old_cred;
 	int ret;
 
 	pr_debug("TARGET_CORE[0]: Loading Generic Kernel Storage"
@@ -3748,11 +3750,21 @@ static int __init target_core_init_configfs(void)
 	if (ret < 0)
 		goto out;
 
+	/* We use the kernel credentials to access the target directory */
+	kern_cred = prepare_kernel_cred(&init_task);
+	if (!kern_cred) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	old_cred = override_creds(kern_cred);
 	target_init_dbroot();
+	revert_creds(old_cred);
+	put_cred(kern_cred);
 
 	return 0;
 
 out:
+	target_xcopy_release_pt();
 	configfs_unregister_subsystem(subsys);
 	core_dev_release_virtual_lun0();
 	rd_module_exit();


