Return-Path: <linux-kernel+bounces-125790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B6A892C21
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E8C1F22971
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F9A3BBFC;
	Sat, 30 Mar 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VJZkH5zw";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VJZkH5zw"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E942AF13;
	Sat, 30 Mar 2024 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711819817; cv=none; b=bLsD6P4btQ6XO/JCFLygCJPcimnm1hlxXgyyyHXeN8k/mG9xXujOthp+o48lhQEPLKGuySUa6g1eRxnd00/M5+kH47Ies6qwWzZsMgJBIM9HLaiCYdN+dn9MoN5liTii8wc2SqtKFVC4lfxd2QI9wHij7dI8U5cVYnzH8ZbQ+tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711819817; c=relaxed/simple;
	bh=eXmM1BjTzwsjubgaRiLGp7A4zEONigqOcYtpXlJxidc=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=mogP7ss4Dac7XUB4TG+GV7wGZogdeJWPGGIVnIAQ4TE7IUGO7B2TIi8d0atnifA/nH7SNd7m5NrFVRBni7GfHvuuXrtVRJZ0du9o1eT0m/3jKwdvUWDilhNIcC1OXlRzR5/zE7KtdTrn+EMsuPV5wX3AT5AhdFcni2S8H8siHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=VJZkH5zw; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=VJZkH5zw; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1711819811;
	bh=eXmM1BjTzwsjubgaRiLGp7A4zEONigqOcYtpXlJxidc=;
	h=Message-ID:Subject:From:To:Date:From;
	b=VJZkH5zwMJSlDf+PoDLmq084sYL1itubsi6vqLjrUwMvO5iF0jtlSFnhqGsqM0LDX
	 I3GRnxEIyuvMabhoeMruk+gvNrRJWYFjremShL4y5zwLnxFmn8ZyMevgxc+oM2mVjm
	 hhUSOt+WQj0BFZjFqFCQ+/5pJlf+5KB9EkbgnOvg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C34E61287842;
	Sat, 30 Mar 2024 13:30:11 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id f1wH_yfbjY6y; Sat, 30 Mar 2024 13:30:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1711819811;
	bh=eXmM1BjTzwsjubgaRiLGp7A4zEONigqOcYtpXlJxidc=;
	h=Message-ID:Subject:From:To:Date:From;
	b=VJZkH5zwMJSlDf+PoDLmq084sYL1itubsi6vqLjrUwMvO5iF0jtlSFnhqGsqM0LDX
	 I3GRnxEIyuvMabhoeMruk+gvNrRJWYFjremShL4y5zwLnxFmn8ZyMevgxc+oM2mVjm
	 hhUSOt+WQj0BFZjFqFCQ+/5pJlf+5KB9EkbgnOvg=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D194E12877D1;
	Sat, 30 Mar 2024 13:30:10 -0400 (EDT)
Message-ID: <c2a8563efc26259bb0a852f5b781e3dd303e7a3d.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.9-rc1
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Sat, 30 Mar 2024 13:30:09 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fully half this pull is updates to lpfc and qla2xxx which got committed
just as the merge window opened.  A sizeable fraction of the driver
updates are simple bug fixes (and lock reworks for bug fixes in the
case of lpfc), so rather than splitting the few actual enhancements
out, we're just adding the drivers to the -rc1 pull.  The enhancements
for lpfc are log message removals, copyright updates and three patches
redefining types.  For qla2xxx it's just removing a debug message on
module removal and the manufacturer detail update.

The two major fixes are the sg teardown race and a core error leg
problem with the procfs directory not being removed if we destroy a
created host that never got to the running state.  The rest are minor
fixes and constifications.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Alexander Wetzel (1):
      scsi: sg: Avoid sg device teardown race

Bikash Hazarika (1):
      scsi: qla2xxx: Update manufacturer detail

Colin Ian King (1):
      scsi: target: iscsi: Remove unused variable xfer_len

Damien Le Moal (1):
      scsi: sd: Fix TCG OPAL unlock on system resume

Dmitry Baryshkov (1):
      scsi: ufs: qcom: Provide default cycles_in_1us value

Guilherme G. Piccoli (1):
      scsi: core: Fix unremoved procfs host directory regression

Justin Tee (12):
      scsi: lpfc: Copyright updates for 14.4.0.1 patches
      scsi: lpfc: Update lpfc version to 14.4.0.1
      scsi: lpfc: Define types in a union for generic void *context3 ptr
      scsi: lpfc: Define lpfc_dmabuf type for ctx_buf ptr
      scsi: lpfc: Define lpfc_nodelist type for ctx_ndlp ptr
      scsi: lpfc: Use a dedicated lock for ras_fwlog state
      scsi: lpfc: Release hbalock before calling lpfc_worker_wake_up()
      scsi: lpfc: Replace hbalock with ndlp lock in lpfc_nvme_unregister_port()
      scsi: lpfc: Update lpfc_ramp_down_queue_handler() logic
      scsi: lpfc: Remove IRQF_ONESHOT flag from threaded IRQ handling
      scsi: lpfc: Move NPIV's transport unregistration to after resource clean up
      scsi: lpfc: Remove unnecessary log message in queuecommand path

Muhammad Usama Anjum (2):
      scsi: lpfc: Correct size for cmdwqe/rspwqe for memset()
      scsi: lpfc: Correct size for wqe for memset()

Nilesh Javali (1):
      scsi: qla2xxx: Update version to 10.02.09.200-k

Peter Wang (1):
      scsi: ufs: core: Add config_scsi_dev vops comment

Quinn Tran (6):
      scsi: qla2xxx: Delay I/O Abort on PCI error
      scsi: qla2xxx: Fix command flush on cable pull
      scsi: qla2xxx: NVME|FCP prefer flag not being honored
      scsi: qla2xxx: Split FCE|EFT trace control
      scsi: qla2xxx: Fix N2N stuck connection
      scsi: qla2xxx: Prevent command send on chip reset

Ricardo B. Marliere (5):
      scsi: st: Make st_sysfs_class constant
      scsi: ch: Make ch_sysfs_class constant
      scsi: cxlflash: Make cxlflash_class constant
      scsi: pmcraid: Make pmcraid_class constant
      scsi: sg: Make sg_sysfs_class constant

Rohit Ner (1):
      scsi: ufs: core: Fix MCQ MAC configuration

Saurav Kashyap (4):
      scsi: bnx2fc: Remove spin_lock_bh while releasing resources after upload
      scsi: qla2xxx: Change debug message during driver unload
      scsi: qla2xxx: Fix double free of fcport
      scsi: qla2xxx: Fix double free of the ha->vp_map pointer

Shin'ichiro Kawasaki (1):
      scsi: mpi3mr: Avoid memcpy field-spanning write WARNING

Xingui Yang (2):
      scsi: libsas: Fix disk not being scanned in after being removed
      scsi: libsas: Add a helper sas_get_sas_addr_and_dev_type()

And the diffstat:

 drivers/ata/libata-eh.c                  |   5 +-
 drivers/ata/libata-scsi.c                |   9 +++
 drivers/scsi/bnx2fc/bnx2fc_tgt.c         |   2 -
 drivers/scsi/ch.c                        |  20 ++---
 drivers/scsi/cxlflash/main.c             |  17 ++--
 drivers/scsi/hosts.c                     |   7 +-
 drivers/scsi/libsas/sas_expander.c       |  51 ++++++++----
 drivers/scsi/lpfc/lpfc.h                 |   2 +-
 drivers/scsi/lpfc/lpfc_attr.c            |   4 +-
 drivers/scsi/lpfc/lpfc_bsg.c             |  40 +++++-----
 drivers/scsi/lpfc/lpfc_debugfs.c         |  12 +--
 drivers/scsi/lpfc/lpfc_els.c             |  45 +++++------
 drivers/scsi/lpfc/lpfc_hbadisc.c         |  33 ++++----
 drivers/scsi/lpfc/lpfc_init.c            |  13 ++--
 drivers/scsi/lpfc/lpfc_mbox.c            |  30 +++-----
 drivers/scsi/lpfc/lpfc_nportdisc.c       |  12 +--
 drivers/scsi/lpfc/lpfc_nvme.c            |   4 +-
 drivers/scsi/lpfc/lpfc_nvmet.c           |   2 +-
 drivers/scsi/lpfc/lpfc_scsi.c            |  23 +-----
 drivers/scsi/lpfc/lpfc_sli.c             |  99 ++++++++++++------------
 drivers/scsi/lpfc/lpfc_sli.h             |  30 ++++++--
 drivers/scsi/lpfc/lpfc_sli4.h            |   7 +-
 drivers/scsi/lpfc/lpfc_version.h         |   2 +-
 drivers/scsi/lpfc/lpfc_vport.c           |  10 +--
 drivers/scsi/mpi3mr/mpi3mr_app.c         |   2 +-
 drivers/scsi/pmcraid.c                   |  20 ++---
 drivers/scsi/qla2xxx/qla_attr.c          |  14 +++-
 drivers/scsi/qla2xxx/qla_def.h           |   2 +-
 drivers/scsi/qla2xxx/qla_gbl.h           |   2 +-
 drivers/scsi/qla2xxx/qla_init.c          | 128 ++++++++++++++++---------------
 drivers/scsi/qla2xxx/qla_iocb.c          |  68 ++++++++++------
 drivers/scsi/qla2xxx/qla_mbx.c           |   2 +-
 drivers/scsi/qla2xxx/qla_os.c            |   3 +-
 drivers/scsi/qla2xxx/qla_target.c        |  10 +++
 drivers/scsi/qla2xxx/qla_version.h       |   4 +-
 drivers/scsi/scsi_scan.c                 |  34 ++++++++
 drivers/scsi/sd.c                        |  23 +++++-
 drivers/scsi/sg.c                        |  22 +++---
 drivers/scsi/st.c                        |   4 +-
 drivers/target/iscsi/iscsi_target_erl1.c |   3 +-
 drivers/ufs/core/ufs-mcq.c               |   2 +-
 drivers/ufs/host/ufs-qcom.c              |   6 +-
 include/linux/libata.h                   |   1 +
 include/scsi/scsi_driver.h               |   1 +
 include/scsi/scsi_host.h                 |   1 +
 include/uapi/scsi/scsi_bsg_mpi3mr.h      |   2 +-
 include/ufs/ufshcd.h                     |   1 +
 47 files changed, 479 insertions(+), 355 deletions(-)

With full diff below.

James

---

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b0d6e69c4a5b..214b935c2ced 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -712,8 +712,10 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 				ehc->saved_ncq_enabled |= 1 << devno;
 
 			/* If we are resuming, wake up the device */
-			if (ap->pflags & ATA_PFLAG_RESUMING)
+			if (ap->pflags & ATA_PFLAG_RESUMING) {
+				dev->flags |= ATA_DFLAG_RESUMING;
 				ehc->i.dev_action[devno] |= ATA_EH_SET_ACTIVE;
+			}
 		}
 	}
 
@@ -3169,6 +3171,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 	return 0;
 
  err:
+	dev->flags &= ~ATA_DFLAG_RESUMING;
 	*r_failed_dev = dev;
 	return rc;
 }
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0a0f483124c3..2f4c58837641 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4730,6 +4730,7 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 	struct ata_link *link;
 	struct ata_device *dev;
 	unsigned long flags;
+	bool do_resume;
 	int ret = 0;
 
 	mutex_lock(&ap->scsi_scan_mutex);
@@ -4751,7 +4752,15 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 			if (scsi_device_get(sdev))
 				continue;
 
+			do_resume = dev->flags & ATA_DFLAG_RESUMING;
+
 			spin_unlock_irqrestore(ap->lock, flags);
+			if (do_resume) {
+				ret = scsi_resume_device(sdev);
+				if (ret == -EWOULDBLOCK)
+					goto unlock;
+				dev->flags &= ~ATA_DFLAG_RESUMING;
+			}
 			ret = scsi_rescan_device(sdev);
 			scsi_device_put(sdev);
 			spin_lock_irqsave(ap->lock, flags);
diff --git a/drivers/scsi/bnx2fc/bnx2fc_tgt.c b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
index 2c246e80c1c4..d91659811eb3 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_tgt.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
@@ -833,7 +833,6 @@ static void bnx2fc_free_session_resc(struct bnx2fc_hba *hba,
 
 	BNX2FC_TGT_DBG(tgt, "Freeing up session resources\n");
 
-	spin_lock_bh(&tgt->cq_lock);
 	ctx_base_ptr = tgt->ctx_base;
 	tgt->ctx_base = NULL;
 
@@ -889,7 +888,6 @@ static void bnx2fc_free_session_resc(struct bnx2fc_hba *hba,
 				    tgt->sq, tgt->sq_dma);
 		tgt->sq = NULL;
 	}
-	spin_unlock_bh(&tgt->cq_lock);
 
 	if (ctx_base_ptr)
 		iounmap(ctx_base_ptr);
diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index 1befcd5b2a0f..fa07a6f54003 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -102,7 +102,9 @@ do {									\
 
 #define MAX_RETRIES   1
 
-static struct class * ch_sysfs_class;
+static const struct class ch_sysfs_class = {
+	.name = "scsi_changer",
+};
 
 typedef struct {
 	struct kref         ref;
@@ -930,7 +932,7 @@ static int ch_probe(struct device *dev)
 	mutex_init(&ch->lock);
 	kref_init(&ch->ref);
 	ch->device = sd;
-	class_dev = device_create(ch_sysfs_class, dev,
+	class_dev = device_create(&ch_sysfs_class, dev,
 				  MKDEV(SCSI_CHANGER_MAJOR, ch->minor), ch,
 				  "s%s", ch->name);
 	if (IS_ERR(class_dev)) {
@@ -955,7 +957,7 @@ static int ch_probe(struct device *dev)
 
 	return 0;
 destroy_dev:
-	device_destroy(ch_sysfs_class, MKDEV(SCSI_CHANGER_MAJOR, ch->minor));
+	device_destroy(&ch_sysfs_class, MKDEV(SCSI_CHANGER_MAJOR, ch->minor));
 put_device:
 	scsi_device_put(sd);
 remove_idr:
@@ -974,7 +976,7 @@ static int ch_remove(struct device *dev)
 	dev_set_drvdata(dev, NULL);
 	spin_unlock(&ch_index_lock);
 
-	device_destroy(ch_sysfs_class, MKDEV(SCSI_CHANGER_MAJOR,ch->minor));
+	device_destroy(&ch_sysfs_class, MKDEV(SCSI_CHANGER_MAJOR, ch->minor));
 	scsi_device_put(ch->device);
 	kref_put(&ch->ref, ch_destroy);
 	return 0;
@@ -1003,11 +1005,9 @@ static int __init init_ch_module(void)
 	int rc;
 
 	printk(KERN_INFO "SCSI Media Changer driver v" VERSION " \n");
-        ch_sysfs_class = class_create("scsi_changer");
-        if (IS_ERR(ch_sysfs_class)) {
-		rc = PTR_ERR(ch_sysfs_class);
+	rc = class_register(&ch_sysfs_class);
+	if (rc)
 		return rc;
-        }
 	rc = register_chrdev(SCSI_CHANGER_MAJOR,"ch",&changer_fops);
 	if (rc < 0) {
 		printk("Unable to get major %d for SCSI-Changer\n",
@@ -1022,7 +1022,7 @@ static int __init init_ch_module(void)
  fail2:
 	unregister_chrdev(SCSI_CHANGER_MAJOR, "ch");
  fail1:
-	class_destroy(ch_sysfs_class);
+	class_unregister(&ch_sysfs_class);
 	return rc;
 }
 
@@ -1030,7 +1030,7 @@ static void __exit exit_ch_module(void)
 {
 	scsi_unregister_driver(&ch_template.gendrv);
 	unregister_chrdev(SCSI_CHANGER_MAJOR, "ch");
-	class_destroy(ch_sysfs_class);
+	class_unregister(&ch_sysfs_class);
 	idr_destroy(&ch_index_idr);
 }
 
diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index debd36974119..e8382cc5cf23 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -28,7 +28,12 @@ MODULE_AUTHOR("Manoj N. Kumar <manoj@linux.vnet.ibm.com>");
 MODULE_AUTHOR("Matthew R. Ochs <mrochs@linux.vnet.ibm.com>");
 MODULE_LICENSE("GPL");
 
-static struct class *cxlflash_class;
+static char *cxlflash_devnode(const struct device *dev, umode_t *mode);
+static const struct class cxlflash_class = {
+	.name = "cxlflash",
+	.devnode = cxlflash_devnode,
+};
+
 static u32 cxlflash_major;
 static DECLARE_BITMAP(cxlflash_minor, CXLFLASH_MAX_ADAPTERS);
 
@@ -3602,7 +3607,7 @@ static int init_chrdev(struct cxlflash_cfg *cfg)
 		goto err1;
 	}
 
-	char_dev = device_create(cxlflash_class, NULL, devno,
+	char_dev = device_create(&cxlflash_class, NULL, devno,
 				 NULL, "cxlflash%d", minor);
 	if (IS_ERR(char_dev)) {
 		rc = PTR_ERR(char_dev);
@@ -3880,14 +3885,12 @@ static int cxlflash_class_init(void)
 
 	cxlflash_major = MAJOR(devno);
 
-	cxlflash_class = class_create("cxlflash");
-	if (IS_ERR(cxlflash_class)) {
-		rc = PTR_ERR(cxlflash_class);
+	rc = class_register(&cxlflash_class);
+	if (rc) {
 		pr_err("%s: class_create failed rc=%d\n", __func__, rc);
 		goto err;
 	}
 
-	cxlflash_class->devnode = cxlflash_devnode;
 out:
 	pr_debug("%s: returning rc=%d\n", __func__, rc);
 	return rc;
@@ -3903,7 +3906,7 @@ static void cxlflash_class_exit(void)
 {
 	dev_t devno = MKDEV(cxlflash_major, 0);
 
-	class_destroy(cxlflash_class);
+	class_unregister(&cxlflash_class);
 	unregister_chrdev_region(devno, CXLFLASH_MAX_ADAPTERS);
 }
 
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 4f495a41ec4a..2d92549e5243 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -353,12 +353,13 @@ static void scsi_host_dev_release(struct device *dev)
 
 	if (shost->shost_state == SHOST_CREATED) {
 		/*
-		 * Free the shost_dev device name here if scsi_host_alloc()
-		 * and scsi_host_put() have been called but neither
+		 * Free the shost_dev device name and remove the proc host dir
+		 * here if scsi_host_{alloc,put}() have been called but neither
 		 * scsi_host_add() nor scsi_remove_host() has been called.
 		 * This avoids that the memory allocated for the shost_dev
-		 * name is leaked.
+		 * name as well as the proc dir structure are leaked.
 		 */
+		scsi_proc_hostdir_rm(shost->hostt);
 		kfree(dev_name(&shost->shost_dev));
 	}
 
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index a2204674b680..5c261005b74e 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1621,6 +1621,16 @@ int sas_discover_root_expander(struct domain_device *dev)
 
 /* ---------- Domain revalidation ---------- */
 
+static void sas_get_sas_addr_and_dev_type(struct smp_disc_resp *disc_resp,
+					  u8 *sas_addr,
+					  enum sas_device_type *type)
+{
+	memcpy(sas_addr, disc_resp->disc.attached_sas_addr, SAS_ADDR_SIZE);
+	*type = to_dev_type(&disc_resp->disc);
+	if (*type == SAS_PHY_UNUSED)
+		memset(sas_addr, 0, SAS_ADDR_SIZE);
+}
+
 static int sas_get_phy_discover(struct domain_device *dev,
 				int phy_id, struct smp_disc_resp *disc_resp)
 {
@@ -1674,13 +1684,8 @@ int sas_get_phy_attached_dev(struct domain_device *dev, int phy_id,
 		return -ENOMEM;
 
 	res = sas_get_phy_discover(dev, phy_id, disc_resp);
-	if (res == 0) {
-		memcpy(sas_addr, disc_resp->disc.attached_sas_addr,
-		       SAS_ADDR_SIZE);
-		*type = to_dev_type(&disc_resp->disc);
-		if (*type == 0)
-			memset(sas_addr, 0, SAS_ADDR_SIZE);
-	}
+	if (res == 0)
+		sas_get_sas_addr_and_dev_type(disc_resp, sas_addr, type);
 	kfree(disc_resp);
 	return res;
 }
@@ -1940,6 +1945,7 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 	struct expander_device *ex = &dev->ex_dev;
 	struct ex_phy *phy = &ex->ex_phy[phy_id];
 	enum sas_device_type type = SAS_PHY_UNUSED;
+	struct smp_disc_resp *disc_resp;
 	u8 sas_addr[SAS_ADDR_SIZE];
 	char msg[80] = "";
 	int res;
@@ -1951,33 +1957,41 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 		 SAS_ADDR(dev->sas_addr), phy_id, msg);
 
 	memset(sas_addr, 0, SAS_ADDR_SIZE);
-	res = sas_get_phy_attached_dev(dev, phy_id, sas_addr, &type);
+	disc_resp = alloc_smp_resp(DISCOVER_RESP_SIZE);
+	if (!disc_resp)
+		return -ENOMEM;
+
+	res = sas_get_phy_discover(dev, phy_id, disc_resp);
 	switch (res) {
 	case SMP_RESP_NO_PHY:
 		phy->phy_state = PHY_NOT_PRESENT;
 		sas_unregister_devs_sas_addr(dev, phy_id, last);
-		return res;
+		goto out_free_resp;
 	case SMP_RESP_PHY_VACANT:
 		phy->phy_state = PHY_VACANT;
 		sas_unregister_devs_sas_addr(dev, phy_id, last);
-		return res;
+		goto out_free_resp;
 	case SMP_RESP_FUNC_ACC:
 		break;
 	case -ECOMM:
 		break;
 	default:
-		return res;
+		goto out_free_resp;
 	}
 
+	if (res == 0)
+		sas_get_sas_addr_and_dev_type(disc_resp, sas_addr, &type);
+
 	if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM)) {
 		phy->phy_state = PHY_EMPTY;
 		sas_unregister_devs_sas_addr(dev, phy_id, last);
 		/*
-		 * Even though the PHY is empty, for convenience we discover
-		 * the PHY to update the PHY info, like negotiated linkrate.
+		 * Even though the PHY is empty, for convenience we update
+		 * the PHY info, like negotiated linkrate.
 		 */
-		sas_ex_phy_discover(dev, phy_id);
-		return res;
+		if (res == 0)
+			sas_set_ex_phy(dev, phy_id, disc_resp);
+		goto out_free_resp;
 	} else if (SAS_ADDR(sas_addr) == SAS_ADDR(phy->attached_sas_addr) &&
 		   dev_type_flutter(type, phy->attached_dev_type)) {
 		struct domain_device *ata_dev = sas_ex_to_ata(dev, phy_id);
@@ -1989,7 +2003,7 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 			action = ", needs recovery";
 		pr_debug("ex %016llx phy%02d broadcast flutter%s\n",
 			 SAS_ADDR(dev->sas_addr), phy_id, action);
-		return res;
+		goto out_free_resp;
 	}
 
 	/* we always have to delete the old device when we went here */
@@ -1998,7 +2012,10 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 		SAS_ADDR(phy->attached_sas_addr));
 	sas_unregister_devs_sas_addr(dev, phy_id, last);
 
-	return sas_discover_new(dev, phy_id);
+	res = sas_discover_new(dev, phy_id);
+out_free_resp:
+	kfree(disc_resp);
+	return res;
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 30d20d37554f..98ca7df003ef 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1333,7 +1333,6 @@ struct lpfc_hba {
 	struct timer_list fabric_block_timer;
 	unsigned long bit_flags;
 	atomic_t num_rsrc_err;
-	atomic_t num_cmd_success;
 	unsigned long last_rsrc_error_time;
 	unsigned long last_ramp_down_time;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
@@ -1438,6 +1437,7 @@ struct lpfc_hba {
 	struct timer_list inactive_vmid_poll;
 
 	/* RAS Support */
+	spinlock_t ras_fwlog_lock; /* do not take while holding another lock */
 	struct lpfc_ras_fwlog ras_fwlog;
 
 	uint32_t iocb_cnt;
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 365c7e96070b..3c534b3cfe91 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -5865,9 +5865,9 @@ lpfc_ras_fwlog_buffsize_set(struct lpfc_hba  *phba, uint val)
 	if (phba->cfg_ras_fwlog_func != PCI_FUNC(phba->pcidev->devfn))
 		return -EINVAL;
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	state = phba->ras_fwlog.state;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	if (state == REG_INPROGRESS) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_SLI, "6147 RAS Logging "
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index d80e6e81053b..529df1768fa8 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -2513,7 +2513,7 @@ static int lpfcdiag_loop_self_reg(struct lpfc_hba *phba, uint16_t *rpi)
 		return -ENOMEM;
 	}
 
-	dmabuff = (struct lpfc_dmabuf *)mbox->ctx_buf;
+	dmabuff = mbox->ctx_buf;
 	mbox->ctx_buf = NULL;
 	mbox->ctx_ndlp = NULL;
 	status = lpfc_sli_issue_mbox_wait(phba, mbox, LPFC_MBOX_TMO);
@@ -3169,10 +3169,10 @@ lpfc_bsg_diag_loopback_run(struct bsg_job *job)
 	}
 
 	cmdwqe = &cmdiocbq->wqe;
-	memset(cmdwqe, 0, sizeof(union lpfc_wqe));
+	memset(cmdwqe, 0, sizeof(*cmdwqe));
 	if (phba->sli_rev < LPFC_SLI_REV4) {
 		rspwqe = &rspiocbq->wqe;
-		memset(rspwqe, 0, sizeof(union lpfc_wqe));
+		memset(rspwqe, 0, sizeof(*rspwqe));
 	}
 
 	INIT_LIST_HEAD(&head);
@@ -3376,7 +3376,7 @@ lpfc_bsg_issue_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmboxq)
 	unsigned long flags;
 	uint8_t *pmb, *pmb_buf;
 
-	dd_data = pmboxq->ctx_ndlp;
+	dd_data = pmboxq->ctx_u.dd_data;
 
 	/*
 	 * The outgoing buffer is readily referred from the dma buffer,
@@ -3553,7 +3553,7 @@ lpfc_bsg_issue_mbox_ext_handle_job(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmboxq)
 	struct lpfc_sli_config_mbox *sli_cfg_mbx;
 	uint8_t *pmbx;
 
-	dd_data = pmboxq->ctx_buf;
+	dd_data = pmboxq->ctx_u.dd_data;
 
 	/* Determine if job has been aborted */
 	spin_lock_irqsave(&phba->ct_ev_lock, flags);
@@ -3940,7 +3940,7 @@ lpfc_bsg_sli_cfg_read_cmd_ext(struct lpfc_hba *phba, struct bsg_job *job,
 	pmboxq->mbox_cmpl = lpfc_bsg_issue_read_mbox_ext_cmpl;
 
 	/* context fields to callback function */
-	pmboxq->ctx_buf = dd_data;
+	pmboxq->ctx_u.dd_data = dd_data;
 	dd_data->type = TYPE_MBOX;
 	dd_data->set_job = job;
 	dd_data->context_un.mbox.pmboxq = pmboxq;
@@ -4112,7 +4112,7 @@ lpfc_bsg_sli_cfg_write_cmd_ext(struct lpfc_hba *phba, struct bsg_job *job,
 		pmboxq->mbox_cmpl = lpfc_bsg_issue_write_mbox_ext_cmpl;
 
 		/* context fields to callback function */
-		pmboxq->ctx_buf = dd_data;
+		pmboxq->ctx_u.dd_data = dd_data;
 		dd_data->type = TYPE_MBOX;
 		dd_data->set_job = job;
 		dd_data->context_un.mbox.pmboxq = pmboxq;
@@ -4460,7 +4460,7 @@ lpfc_bsg_write_ebuf_set(struct lpfc_hba *phba, struct bsg_job *job,
 		pmboxq->mbox_cmpl = lpfc_bsg_issue_write_mbox_ext_cmpl;
 
 		/* context fields to callback function */
-		pmboxq->ctx_buf = dd_data;
+		pmboxq->ctx_u.dd_data = dd_data;
 		dd_data->type = TYPE_MBOX;
 		dd_data->set_job = job;
 		dd_data->context_un.mbox.pmboxq = pmboxq;
@@ -4747,7 +4747,7 @@ lpfc_bsg_issue_mbox(struct lpfc_hba *phba, struct bsg_job *job,
 	if (mbox_req->inExtWLen || mbox_req->outExtWLen) {
 		from = pmbx;
 		ext = from + sizeof(MAILBOX_t);
-		pmboxq->ctx_buf = ext;
+		pmboxq->ext_buf = ext;
 		pmboxq->in_ext_byte_len =
 			mbox_req->inExtWLen * sizeof(uint32_t);
 		pmboxq->out_ext_byte_len =
@@ -4875,7 +4875,7 @@ lpfc_bsg_issue_mbox(struct lpfc_hba *phba, struct bsg_job *job,
 	pmboxq->mbox_cmpl = lpfc_bsg_issue_mbox_cmpl;
 
 	/* setup context field to pass wait_queue pointer to wake function */
-	pmboxq->ctx_ndlp = dd_data;
+	pmboxq->ctx_u.dd_data = dd_data;
 	dd_data->type = TYPE_MBOX;
 	dd_data->set_job = job;
 	dd_data->context_un.mbox.pmboxq = pmboxq;
@@ -5070,12 +5070,12 @@ lpfc_bsg_get_ras_config(struct bsg_job *job)
 		bsg_reply->reply_data.vendor_reply.vendor_rsp;
 
 	/* Current logging state */
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	if (ras_fwlog->state == ACTIVE)
 		ras_reply->state = LPFC_RASLOG_STATE_RUNNING;
 	else
 		ras_reply->state = LPFC_RASLOG_STATE_STOPPED;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	ras_reply->log_level = phba->ras_fwlog.fw_loglevel;
 	ras_reply->log_buff_sz = phba->cfg_ras_fwlog_buffsize;
@@ -5132,13 +5132,13 @@ lpfc_bsg_set_ras_config(struct bsg_job *job)
 
 	if (action == LPFC_RASACTION_STOP_LOGGING) {
 		/* Check if already disabled */
-		spin_lock_irq(&phba->hbalock);
+		spin_lock_irq(&phba->ras_fwlog_lock);
 		if (ras_fwlog->state != ACTIVE) {
-			spin_unlock_irq(&phba->hbalock);
+			spin_unlock_irq(&phba->ras_fwlog_lock);
 			rc = -ESRCH;
 			goto ras_job_error;
 		}
-		spin_unlock_irq(&phba->hbalock);
+		spin_unlock_irq(&phba->ras_fwlog_lock);
 
 		/* Disable logging */
 		lpfc_ras_stop_fwlog(phba);
@@ -5149,10 +5149,10 @@ lpfc_bsg_set_ras_config(struct bsg_job *job)
 		 * FW-logging with new log-level. Return status
 		 * "Logging already Running" to caller.
 		 **/
-		spin_lock_irq(&phba->hbalock);
+		spin_lock_irq(&phba->ras_fwlog_lock);
 		if (ras_fwlog->state != INACTIVE)
 			action_status = -EINPROGRESS;
-		spin_unlock_irq(&phba->hbalock);
+		spin_unlock_irq(&phba->ras_fwlog_lock);
 
 		/* Enable logging */
 		rc = lpfc_sli4_ras_fwlog_init(phba, log_level,
@@ -5268,13 +5268,13 @@ lpfc_bsg_get_ras_fwlog(struct bsg_job *job)
 		goto ras_job_error;
 
 	/* Logging to be stopped before reading */
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	if (ras_fwlog->state == ACTIVE) {
-		spin_unlock_irq(&phba->hbalock);
+		spin_unlock_irq(&phba->ras_fwlog_lock);
 		rc = -EINPROGRESS;
 		goto ras_job_error;
 	}
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	if (job->request_len <
 	    sizeof(struct fc_bsg_request) +
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index ab5af10c8a16..a2d2b02b3418 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -2194,12 +2194,12 @@ static int lpfc_debugfs_ras_log_data(struct lpfc_hba *phba,
 
 	memset(buffer, 0, size);
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	if (phba->ras_fwlog.state != ACTIVE) {
-		spin_unlock_irq(&phba->hbalock);
+		spin_unlock_irq(&phba->ras_fwlog_lock);
 		return -EINVAL;
 	}
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	list_for_each_entry_safe(dmabuf, next,
 				 &phba->ras_fwlog.fwlog_buff_list, list) {
@@ -2250,13 +2250,13 @@ lpfc_debugfs_ras_log_open(struct inode *inode, struct file *file)
 	int size;
 	int rc = -ENOMEM;
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	if (phba->ras_fwlog.state != ACTIVE) {
-		spin_unlock_irq(&phba->hbalock);
+		spin_unlock_irq(&phba->ras_fwlog_lock);
 		rc = -EINVAL;
 		goto out;
 	}
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	if (check_mul_overflow(LPFC_RAS_MIN_BUFF_POST_SIZE,
 			       phba->cfg_ras_fwlog_buffsize, &size))
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 28e56542e072..f7c28dc73bf6 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -4437,23 +4437,23 @@ lpfc_els_retry_delay(struct timer_list *t)
 	unsigned long flags;
 	struct lpfc_work_evt  *evtp = &ndlp->els_retry_evt;
 
+	/* Hold a node reference for outstanding queued work */
+	if (!lpfc_nlp_get(ndlp))
+		return;
+
 	spin_lock_irqsave(&phba->hbalock, flags);
 	if (!list_empty(&evtp->evt_listp)) {
 		spin_unlock_irqrestore(&phba->hbalock, flags);
+		lpfc_nlp_put(ndlp);
 		return;
 	}
 
-	/* We need to hold the node by incrementing the reference
-	 * count until the queued work is done
-	 */
-	evtp->evt_arg1  = lpfc_nlp_get(ndlp);
-	if (evtp->evt_arg1) {
-		evtp->evt = LPFC_EVT_ELS_RETRY;
-		list_add_tail(&evtp->evt_listp, &phba->work_list);
-		lpfc_worker_wake_up(phba);
-	}
+	evtp->evt_arg1 = ndlp;
+	evtp->evt = LPFC_EVT_ELS_RETRY;
+	list_add_tail(&evtp->evt_listp, &phba->work_list);
 	spin_unlock_irqrestore(&phba->hbalock, flags);
-	return;
+
+	lpfc_worker_wake_up(phba);
 }
 
 /**
@@ -7238,7 +7238,7 @@ lpfc_get_rdp_info(struct lpfc_hba *phba, struct lpfc_rdp_context *rdp_context)
 		goto rdp_fail;
 	mbox->vport = rdp_context->ndlp->vport;
 	mbox->mbox_cmpl = lpfc_mbx_cmpl_rdp_page_a0;
-	mbox->ctx_ndlp = (struct lpfc_rdp_context *)rdp_context;
+	mbox->ctx_u.rdp = rdp_context;
 	rc = lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT);
 	if (rc == MBX_NOT_FINISHED) {
 		lpfc_mbox_rsrc_cleanup(phba, mbox, MBOX_THD_UNLOCKED);
@@ -7290,7 +7290,7 @@ int lpfc_get_sfp_info_wait(struct lpfc_hba *phba,
 		mbox->in_ext_byte_len = DMP_SFF_PAGE_A0_SIZE;
 		mbox->out_ext_byte_len = DMP_SFF_PAGE_A0_SIZE;
 		mbox->mbox_offset_word = 5;
-		mbox->ctx_buf = virt;
+		mbox->ext_buf = virt;
 	} else {
 		bf_set(lpfc_mbx_memory_dump_type3_length,
 		       &mbox->u.mqe.un.mem_dump_type3, DMP_SFF_PAGE_A0_SIZE);
@@ -7298,7 +7298,6 @@ int lpfc_get_sfp_info_wait(struct lpfc_hba *phba,
 		mbox->u.mqe.un.mem_dump_type3.addr_hi = putPaddrHigh(mp->phys);
 	}
 	mbox->vport = phba->pport;
-	mbox->ctx_ndlp = (struct lpfc_rdp_context *)rdp_context;
 
 	rc = lpfc_sli_issue_mbox_wait(phba, mbox, 30);
 	if (rc == MBX_NOT_FINISHED) {
@@ -7307,7 +7306,7 @@ int lpfc_get_sfp_info_wait(struct lpfc_hba *phba,
 	}
 
 	if (phba->sli_rev == LPFC_SLI_REV4)
-		mp = (struct lpfc_dmabuf *)(mbox->ctx_buf);
+		mp = mbox->ctx_buf;
 	else
 		mp = mpsave;
 
@@ -7350,7 +7349,7 @@ int lpfc_get_sfp_info_wait(struct lpfc_hba *phba,
 		mbox->in_ext_byte_len = DMP_SFF_PAGE_A2_SIZE;
 		mbox->out_ext_byte_len = DMP_SFF_PAGE_A2_SIZE;
 		mbox->mbox_offset_word = 5;
-		mbox->ctx_buf = virt;
+		mbox->ext_buf = virt;
 	} else {
 		bf_set(lpfc_mbx_memory_dump_type3_length,
 		       &mbox->u.mqe.un.mem_dump_type3, DMP_SFF_PAGE_A2_SIZE);
@@ -7358,7 +7357,6 @@ int lpfc_get_sfp_info_wait(struct lpfc_hba *phba,
 		mbox->u.mqe.un.mem_dump_type3.addr_hi = putPaddrHigh(mp->phys);
 	}
 
-	mbox->ctx_ndlp = (struct lpfc_rdp_context *)rdp_context;
 	rc = lpfc_sli_issue_mbox_wait(phba, mbox, 30);
 	if (bf_get(lpfc_mqe_status, &mbox->u.mqe)) {
 		rc = 1;
@@ -7500,9 +7498,9 @@ lpfc_els_lcb_rsp(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	int rc;
 
 	mb = &pmb->u.mb;
-	lcb_context = (struct lpfc_lcb_context *)pmb->ctx_ndlp;
+	lcb_context = pmb->ctx_u.lcb;
 	ndlp = lcb_context->ndlp;
-	pmb->ctx_ndlp = NULL;
+	memset(&pmb->ctx_u, 0, sizeof(pmb->ctx_u));
 	pmb->ctx_buf = NULL;
 
 	shdr = (union lpfc_sli4_cfg_shdr *)
@@ -7642,7 +7640,7 @@ lpfc_sli4_set_beacon(struct lpfc_vport *vport,
 	lpfc_sli4_config(phba, mbox, LPFC_MBOX_SUBSYSTEM_COMMON,
 			 LPFC_MBOX_OPCODE_SET_BEACON_CONFIG, len,
 			 LPFC_SLI4_MBX_EMBED);
-	mbox->ctx_ndlp = (void *)lcb_context;
+	mbox->ctx_u.lcb = lcb_context;
 	mbox->vport = phba->pport;
 	mbox->mbox_cmpl = lpfc_els_lcb_rsp;
 	bf_set(lpfc_mbx_set_beacon_port_num, &mbox->u.mqe.un.beacon_config,
@@ -8639,9 +8637,9 @@ lpfc_els_rsp_rls_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	mb = &pmb->u.mb;
 
 	ndlp = pmb->ctx_ndlp;
-	rxid = (uint16_t)((unsigned long)(pmb->ctx_buf) & 0xffff);
-	oxid = (uint16_t)(((unsigned long)(pmb->ctx_buf) >> 16) & 0xffff);
-	pmb->ctx_buf = NULL;
+	rxid = (uint16_t)(pmb->ctx_u.ox_rx_id & 0xffff);
+	oxid = (uint16_t)((pmb->ctx_u.ox_rx_id >> 16) & 0xffff);
+	memset(&pmb->ctx_u, 0, sizeof(pmb->ctx_u));
 	pmb->ctx_ndlp = NULL;
 
 	if (mb->mbxStatus) {
@@ -8745,8 +8743,7 @@ lpfc_els_rcv_rls(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	mbox = mempool_alloc(phba->mbox_mem_pool, GFP_ATOMIC);
 	if (mbox) {
 		lpfc_read_lnk_stat(phba, mbox);
-		mbox->ctx_buf = (void *)((unsigned long)
-					 (ox_id << 16 | ctx));
+		mbox->ctx_u.ox_rx_id = ox_id << 16 | ctx;
 		mbox->ctx_ndlp = lpfc_nlp_get(ndlp);
 		if (!mbox->ctx_ndlp)
 			goto node_err;
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index a7a2309a629f..e42fa9c822b5 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -257,7 +257,9 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 		if (evtp->evt_arg1) {
 			evtp->evt = LPFC_EVT_DEV_LOSS;
 			list_add_tail(&evtp->evt_listp, &phba->work_list);
+			spin_unlock_irqrestore(&phba->hbalock, iflags);
 			lpfc_worker_wake_up(phba);
+			return;
 		}
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
 	} else {
@@ -275,10 +277,7 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 			lpfc_disc_state_machine(vport, ndlp, NULL,
 						NLP_EVT_DEVICE_RM);
 		}
-
 	}
-
-	return;
 }
 
 /**
@@ -3429,7 +3428,7 @@ static void
 lpfc_mbx_cmpl_read_sparam(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	MAILBOX_t *mb = &pmb->u.mb;
-	struct lpfc_dmabuf *mp = (struct lpfc_dmabuf *)pmb->ctx_buf;
+	struct lpfc_dmabuf *mp = pmb->ctx_buf;
 	struct lpfc_vport  *vport = pmb->vport;
 	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
 	struct serv_parm *sp = &vport->fc_sparam;
@@ -3737,7 +3736,7 @@ lpfc_mbx_cmpl_read_topology(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	struct lpfc_mbx_read_top *la;
 	struct lpfc_sli_ring *pring;
 	MAILBOX_t *mb = &pmb->u.mb;
-	struct lpfc_dmabuf *mp = (struct lpfc_dmabuf *)(pmb->ctx_buf);
+	struct lpfc_dmabuf *mp = pmb->ctx_buf;
 	uint8_t attn_type;
 
 	/* Unblock ELS traffic */
@@ -3851,8 +3850,8 @@ void
 lpfc_mbx_cmpl_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	struct lpfc_vport  *vport = pmb->vport;
-	struct lpfc_dmabuf *mp = (struct lpfc_dmabuf *)pmb->ctx_buf;
-	struct lpfc_nodelist *ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
+	struct lpfc_dmabuf *mp = pmb->ctx_buf;
+	struct lpfc_nodelist *ndlp = pmb->ctx_ndlp;
 
 	/* The driver calls the state machine with the pmb pointer
 	 * but wants to make sure a stale ctx_buf isn't acted on.
@@ -4066,7 +4065,7 @@ lpfc_create_static_vport(struct lpfc_hba *phba)
 		 * the dump routine is a single-use construct.
 		 */
 		if (pmb->ctx_buf) {
-			mp = (struct lpfc_dmabuf *)pmb->ctx_buf;
+			mp = pmb->ctx_buf;
 			lpfc_mbuf_free(phba, mp->virt, mp->phys);
 			kfree(mp);
 			pmb->ctx_buf = NULL;
@@ -4089,7 +4088,7 @@ lpfc_create_static_vport(struct lpfc_hba *phba)
 
 		if (phba->sli_rev == LPFC_SLI_REV4) {
 			byte_count = pmb->u.mqe.un.mb_words[5];
-			mp = (struct lpfc_dmabuf *)pmb->ctx_buf;
+			mp = pmb->ctx_buf;
 			if (byte_count > sizeof(struct static_vport_info) -
 					offset)
 				byte_count = sizeof(struct static_vport_info)
@@ -4169,7 +4168,7 @@ lpfc_mbx_cmpl_fabric_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	struct lpfc_vport *vport = pmb->vport;
 	MAILBOX_t *mb = &pmb->u.mb;
-	struct lpfc_nodelist *ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
+	struct lpfc_nodelist *ndlp = pmb->ctx_ndlp;
 
 	pmb->ctx_ndlp = NULL;
 
@@ -4307,7 +4306,7 @@ void
 lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	MAILBOX_t *mb = &pmb->u.mb;
-	struct lpfc_nodelist *ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
+	struct lpfc_nodelist *ndlp = pmb->ctx_ndlp;
 	struct lpfc_vport *vport = pmb->vport;
 	int rc;
 
@@ -4431,7 +4430,7 @@ lpfc_mbx_cmpl_fc_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	struct lpfc_vport *vport = pmb->vport;
 	MAILBOX_t *mb = &pmb->u.mb;
-	struct lpfc_nodelist *ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
+	struct lpfc_nodelist *ndlp = pmb->ctx_ndlp;
 
 	pmb->ctx_ndlp = NULL;
 	if (mb->mbxStatus) {
@@ -5174,7 +5173,7 @@ lpfc_nlp_logo_unreg(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	struct lpfc_vport  *vport = pmb->vport;
 	struct lpfc_nodelist *ndlp;
 
-	ndlp = (struct lpfc_nodelist *)(pmb->ctx_ndlp);
+	ndlp = pmb->ctx_ndlp;
 	if (!ndlp)
 		return;
 	lpfc_issue_els_logo(vport, ndlp, 0);
@@ -5496,7 +5495,7 @@ lpfc_cleanup_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	if ((mb = phba->sli.mbox_active)) {
 		if ((mb->u.mb.mbxCommand == MBX_REG_LOGIN64) &&
 		   !(mb->mbox_flag & LPFC_MBX_IMED_UNREG) &&
-		   (ndlp == (struct lpfc_nodelist *)mb->ctx_ndlp)) {
+		   (ndlp == mb->ctx_ndlp)) {
 			mb->ctx_ndlp = NULL;
 			mb->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
 		}
@@ -5507,7 +5506,7 @@ lpfc_cleanup_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	list_for_each_entry(mb, &phba->sli.mboxq_cmpl, list) {
 		if ((mb->u.mb.mbxCommand != MBX_REG_LOGIN64) ||
 			(mb->mbox_flag & LPFC_MBX_IMED_UNREG) ||
-			(ndlp != (struct lpfc_nodelist *)mb->ctx_ndlp))
+			(ndlp != mb->ctx_ndlp))
 			continue;
 
 		mb->ctx_ndlp = NULL;
@@ -5517,7 +5516,7 @@ lpfc_cleanup_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	list_for_each_entry_safe(mb, nextmb, &phba->sli.mboxq, list) {
 		if ((mb->u.mb.mbxCommand == MBX_REG_LOGIN64) &&
 		   !(mb->mbox_flag & LPFC_MBX_IMED_UNREG) &&
-		    (ndlp == (struct lpfc_nodelist *)mb->ctx_ndlp)) {
+		    (ndlp == mb->ctx_ndlp)) {
 			list_del(&mb->list);
 			lpfc_mbox_rsrc_cleanup(phba, mb, MBOX_THD_LOCKED);
 
@@ -6357,7 +6356,7 @@ void
 lpfc_mbx_cmpl_fdmi_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	MAILBOX_t *mb = &pmb->u.mb;
-	struct lpfc_nodelist *ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
+	struct lpfc_nodelist *ndlp = pmb->ctx_ndlp;
 	struct lpfc_vport    *vport = pmb->vport;
 
 	pmb->ctx_ndlp = NULL;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 88b2e57d90c2..f7a0aa3625f4 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -460,7 +460,7 @@ lpfc_config_port_post(struct lpfc_hba *phba)
 		return -EIO;
 	}
 
-	mp = (struct lpfc_dmabuf *)pmb->ctx_buf;
+	mp = pmb->ctx_buf;
 
 	/* This dmabuf was allocated by lpfc_read_sparam. The dmabuf is no
 	 * longer needed.  Prevent unintended ctx_buf access as the mbox is
@@ -2217,7 +2217,7 @@ lpfc_handle_latt(struct lpfc_hba *phba)
 	/* Cleanup any outstanding ELS commands */
 	lpfc_els_flush_all_cmd(phba);
 	psli->slistat.link_event++;
-	lpfc_read_topology(phba, pmb, (struct lpfc_dmabuf *)pmb->ctx_buf);
+	lpfc_read_topology(phba, pmb, pmb->ctx_buf);
 	pmb->mbox_cmpl = lpfc_mbx_cmpl_read_topology;
 	pmb->vport = vport;
 	/* Block ELS IOCBs until we have processed this mbox command */
@@ -5454,7 +5454,7 @@ lpfc_sli4_async_link_evt(struct lpfc_hba *phba,
 	phba->sli.slistat.link_event++;
 
 	/* Create lpfc_handle_latt mailbox command from link ACQE */
-	lpfc_read_topology(phba, pmb, (struct lpfc_dmabuf *)pmb->ctx_buf);
+	lpfc_read_topology(phba, pmb, pmb->ctx_buf);
 	pmb->mbox_cmpl = lpfc_mbx_cmpl_read_topology;
 	pmb->vport = phba->pport;
 
@@ -6347,7 +6347,7 @@ lpfc_sli4_async_fc_evt(struct lpfc_hba *phba, struct lpfc_acqe_fc_la *acqe_fc)
 	phba->sli.slistat.link_event++;
 
 	/* Create lpfc_handle_latt mailbox command from link ACQE */
-	lpfc_read_topology(phba, pmb, (struct lpfc_dmabuf *)pmb->ctx_buf);
+	lpfc_read_topology(phba, pmb, pmb->ctx_buf);
 	pmb->mbox_cmpl = lpfc_mbx_cmpl_read_topology;
 	pmb->vport = phba->pport;
 
@@ -7705,6 +7705,9 @@ lpfc_setup_driver_resource_phase1(struct lpfc_hba *phba)
 				"NVME" : " "),
 			(phba->nvmet_support ? "NVMET" : " "));
 
+	/* ras_fwlog state */
+	spin_lock_init(&phba->ras_fwlog_lock);
+
 	/* Initialize the IO buffer list used by driver for SLI3 SCSI */
 	spin_lock_init(&phba->scsi_buf_list_get_lock);
 	INIT_LIST_HEAD(&phba->lpfc_scsi_buf_list_get);
@@ -13055,7 +13058,7 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 		rc = request_threaded_irq(eqhdl->irq,
 					  &lpfc_sli4_hba_intr_handler,
 					  &lpfc_sli4_hba_intr_handler_th,
-					  IRQF_ONESHOT, name, eqhdl);
+					  0, name, eqhdl);
 		if (rc) {
 			lpfc_printf_log(phba, KERN_WARNING, LOG_INIT,
 					"0486 MSI-X fast-path (%d) "
diff --git a/drivers/scsi/lpfc/lpfc_mbox.c b/drivers/scsi/lpfc/lpfc_mbox.c
index f7c41958036b..e98f1c2b2220 100644
--- a/drivers/scsi/lpfc/lpfc_mbox.c
+++ b/drivers/scsi/lpfc/lpfc_mbox.c
@@ -102,7 +102,7 @@ lpfc_mbox_rsrc_cleanup(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox,
 {
 	struct lpfc_dmabuf *mp;
 
-	mp = (struct lpfc_dmabuf *)mbox->ctx_buf;
+	mp = mbox->ctx_buf;
 	mbox->ctx_buf = NULL;
 
 	/* Release the generic BPL buffer memory.  */
@@ -204,10 +204,8 @@ lpfc_dump_mem(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb, uint16_t offset,
 		uint16_t region_id)
 {
 	MAILBOX_t *mb;
-	void *ctx;
 
 	mb = &pmb->u.mb;
-	ctx = pmb->ctx_buf;
 
 	/* Setup to dump VPD region */
 	memset(pmb, 0, sizeof (LPFC_MBOXQ_t));
@@ -219,7 +217,6 @@ lpfc_dump_mem(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb, uint16_t offset,
 	mb->un.varDmp.word_cnt = (DMP_RSP_SIZE / sizeof (uint32_t));
 	mb->un.varDmp.co = 0;
 	mb->un.varDmp.resp_offset = 0;
-	pmb->ctx_buf = ctx;
 	mb->mbxOwner = OWN_HOST;
 	return;
 }
@@ -236,11 +233,8 @@ void
 lpfc_dump_wakeup_param(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	MAILBOX_t *mb;
-	void *ctx;
 
 	mb = &pmb->u.mb;
-	/* Save context so that we can restore after memset */
-	ctx = pmb->ctx_buf;
 
 	/* Setup to dump VPD region */
 	memset(pmb, 0, sizeof(LPFC_MBOXQ_t));
@@ -254,7 +248,6 @@ lpfc_dump_wakeup_param(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	mb->un.varDmp.word_cnt = WAKE_UP_PARMS_WORD_SIZE;
 	mb->un.varDmp.co = 0;
 	mb->un.varDmp.resp_offset = 0;
-	pmb->ctx_buf = ctx;
 	return;
 }
 
@@ -372,7 +365,7 @@ lpfc_read_topology(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb,
 	/* Save address for later completion and set the owner to host so that
 	 * the FW knows this mailbox is available for processing.
 	 */
-	pmb->ctx_buf = (uint8_t *)mp;
+	pmb->ctx_buf = mp;
 	mb->mbxOwner = OWN_HOST;
 	return (0);
 }
@@ -1816,7 +1809,7 @@ lpfc_sli4_mbox_cmd_free(struct lpfc_hba *phba, struct lpfcMboxq *mbox)
 	}
 	/* Reinitialize the context pointers to avoid stale usage. */
 	mbox->ctx_buf = NULL;
-	mbox->context3 = NULL;
+	memset(&mbox->ctx_u, 0, sizeof(mbox->ctx_u));
 	kfree(mbox->sge_array);
 	/* Finally, free the mailbox command itself */
 	mempool_free(mbox, phba->mbox_mem_pool);
@@ -2366,8 +2359,7 @@ lpfc_mbx_cmpl_rdp_link_stat(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 {
 	MAILBOX_t *mb;
 	int rc = FAILURE;
-	struct lpfc_rdp_context *rdp_context =
-			(struct lpfc_rdp_context *)(mboxq->ctx_ndlp);
+	struct lpfc_rdp_context *rdp_context = mboxq->ctx_u.rdp;
 
 	mb = &mboxq->u.mb;
 	if (mb->mbxStatus)
@@ -2385,9 +2377,8 @@ lpfc_mbx_cmpl_rdp_link_stat(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 static void
 lpfc_mbx_cmpl_rdp_page_a2(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox)
 {
-	struct lpfc_dmabuf *mp = (struct lpfc_dmabuf *)mbox->ctx_buf;
-	struct lpfc_rdp_context *rdp_context =
-			(struct lpfc_rdp_context *)(mbox->ctx_ndlp);
+	struct lpfc_dmabuf *mp = mbox->ctx_buf;
+	struct lpfc_rdp_context *rdp_context = mbox->ctx_u.rdp;
 
 	if (bf_get(lpfc_mqe_status, &mbox->u.mqe))
 		goto error_mbox_free;
@@ -2401,7 +2392,7 @@ lpfc_mbx_cmpl_rdp_page_a2(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox)
 	/* Save the dma buffer for cleanup in the final completion. */
 	mbox->ctx_buf = mp;
 	mbox->mbox_cmpl = lpfc_mbx_cmpl_rdp_link_stat;
-	mbox->ctx_ndlp = (struct lpfc_rdp_context *)rdp_context;
+	mbox->ctx_u.rdp = rdp_context;
 	if (lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT) == MBX_NOT_FINISHED)
 		goto error_mbox_free;
 
@@ -2416,9 +2407,8 @@ void
 lpfc_mbx_cmpl_rdp_page_a0(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox)
 {
 	int rc;
-	struct lpfc_dmabuf *mp = (struct lpfc_dmabuf *)(mbox->ctx_buf);
-	struct lpfc_rdp_context *rdp_context =
-			(struct lpfc_rdp_context *)(mbox->ctx_ndlp);
+	struct lpfc_dmabuf *mp = mbox->ctx_buf;
+	struct lpfc_rdp_context *rdp_context = mbox->ctx_u.rdp;
 
 	if (bf_get(lpfc_mqe_status, &mbox->u.mqe))
 		goto error;
@@ -2448,7 +2438,7 @@ lpfc_mbx_cmpl_rdp_page_a0(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox)
 	mbox->u.mqe.un.mem_dump_type3.addr_hi = putPaddrHigh(mp->phys);
 
 	mbox->mbox_cmpl = lpfc_mbx_cmpl_rdp_page_a2;
-	mbox->ctx_ndlp = (struct lpfc_rdp_context *)rdp_context;
+	mbox->ctx_u.rdp = rdp_context;
 	rc = lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT);
 	if (rc == MBX_NOT_FINISHED)
 		goto error;
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 8e425be7c7c9..c4172791c267 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -300,7 +300,7 @@ lpfc_defer_plogi_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *login_mbox)
 	int rc;
 
 	ndlp = login_mbox->ctx_ndlp;
-	save_iocb = login_mbox->context3;
+	save_iocb = login_mbox->ctx_u.save_iocb;
 
 	if (mb->mbxStatus == MBX_SUCCESS) {
 		/* Now that REG_RPI completed successfully,
@@ -640,7 +640,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	if (!login_mbox->ctx_ndlp)
 		goto out;
 
-	login_mbox->context3 = save_iocb; /* For PLOGI ACC */
+	login_mbox->ctx_u.save_iocb = save_iocb; /* For PLOGI ACC */
 
 	spin_lock_irq(&ndlp->lock);
 	ndlp->nlp_flag |= (NLP_ACC_REGLOGIN | NLP_RCV_PLOGI);
@@ -682,8 +682,8 @@ lpfc_mbx_cmpl_resume_rpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 	struct lpfc_nodelist *ndlp;
 	uint32_t cmd;
 
-	elsiocb = (struct lpfc_iocbq *)mboxq->ctx_buf;
-	ndlp = (struct lpfc_nodelist *)mboxq->ctx_ndlp;
+	elsiocb = mboxq->ctx_u.save_iocb;
+	ndlp = mboxq->ctx_ndlp;
 	vport = mboxq->vport;
 	cmd = elsiocb->drvrTimeout;
 
@@ -1875,7 +1875,7 @@ lpfc_rcv_logo_reglogin_issue(struct lpfc_vport *vport,
 	/* cleanup any ndlp on mbox q waiting for reglogin cmpl */
 	if ((mb = phba->sli.mbox_active)) {
 		if ((mb->u.mb.mbxCommand == MBX_REG_LOGIN64) &&
-		   (ndlp == (struct lpfc_nodelist *)mb->ctx_ndlp)) {
+		   (ndlp == mb->ctx_ndlp)) {
 			ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
 			lpfc_nlp_put(ndlp);
 			mb->ctx_ndlp = NULL;
@@ -1886,7 +1886,7 @@ lpfc_rcv_logo_reglogin_issue(struct lpfc_vport *vport,
 	spin_lock_irq(&phba->hbalock);
 	list_for_each_entry_safe(mb, nextmb, &phba->sli.mboxq, list) {
 		if ((mb->u.mb.mbxCommand == MBX_REG_LOGIN64) &&
-		   (ndlp == (struct lpfc_nodelist *)mb->ctx_ndlp)) {
+		   (ndlp == mb->ctx_ndlp)) {
 			ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
 			lpfc_nlp_put(ndlp);
 			list_del(&mb->list);
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 09c53b85bcb8..c5792eaf3f64 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2616,9 +2616,9 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		/* No concern about the role change on the nvme remoteport.
 		 * The transport will update it.
 		 */
-		spin_lock_irq(&vport->phba->hbalock);
+		spin_lock_irq(&ndlp->lock);
 		ndlp->fc4_xpt_flags |= NVME_XPT_UNREG_WAIT;
-		spin_unlock_irq(&vport->phba->hbalock);
+		spin_unlock_irq(&ndlp->lock);
 
 		/* Don't let the host nvme transport keep sending keep-alives
 		 * on this remoteport. Vport is unloading, no recovery. The
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 8258b771bd00..561ced5503c6 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1586,7 +1586,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 		wqe = &nvmewqe->wqe;
 
 		/* Initialize WQE */
-		memset(wqe, 0, sizeof(union lpfc_wqe));
+		memset(wqe, 0, sizeof(*wqe));
 
 		ctx_buf->iocbq->cmd_dmabuf = NULL;
 		spin_lock(&phba->sli4_hba.sgl_list_lock);
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index c0038eaae7b0..4a6e5223a224 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -167,11 +167,10 @@ lpfc_ramp_down_queue_handler(struct lpfc_hba *phba)
 	struct Scsi_Host  *shost;
 	struct scsi_device *sdev;
 	unsigned long new_queue_depth;
-	unsigned long num_rsrc_err, num_cmd_success;
+	unsigned long num_rsrc_err;
 	int i;
 
 	num_rsrc_err = atomic_read(&phba->num_rsrc_err);
-	num_cmd_success = atomic_read(&phba->num_cmd_success);
 
 	/*
 	 * The error and success command counters are global per
@@ -186,20 +185,16 @@ lpfc_ramp_down_queue_handler(struct lpfc_hba *phba)
 		for (i = 0; i <= phba->max_vports && vports[i] != NULL; i++) {
 			shost = lpfc_shost_from_vport(vports[i]);
 			shost_for_each_device(sdev, shost) {
-				new_queue_depth =
-					sdev->queue_depth * num_rsrc_err /
-					(num_rsrc_err + num_cmd_success);
-				if (!new_queue_depth)
-					new_queue_depth = sdev->queue_depth - 1;
+				if (num_rsrc_err >= sdev->queue_depth)
+					new_queue_depth = 1;
 				else
 					new_queue_depth = sdev->queue_depth -
-								new_queue_depth;
+						num_rsrc_err;
 				scsi_change_queue_depth(sdev, new_queue_depth);
 			}
 		}
 	lpfc_destroy_vport_work_array(phba, vports);
 	atomic_set(&phba->num_rsrc_err, 0);
-	atomic_set(&phba->num_cmd_success, 0);
 }
 
 /**
@@ -5336,16 +5331,6 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 		}
 		err = lpfc_bg_scsi_prep_dma_buf(phba, lpfc_cmd);
 	} else {
-		if (vport->phba->cfg_enable_bg) {
-			lpfc_printf_vlog(vport,
-					 KERN_INFO, LOG_SCSI_CMD,
-					 "9038 BLKGRD: rcvd PROT_NORMAL cmd: "
-					 "x%x reftag x%x cnt %u pt %x\n",
-					 cmnd->cmnd[0],
-					 scsi_prot_ref_tag(cmnd),
-					 scsi_logical_block_count(cmnd),
-					 (cmnd->cmnd[1]>>5));
-		}
 		err = lpfc_scsi_prep_dma_buf(phba, lpfc_cmd);
 	}
 
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 1f8a9b5945cb..a028e008dd1e 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -1217,9 +1217,9 @@ lpfc_set_rrq_active(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 	empty = list_empty(&phba->active_rrq_list);
 	list_add_tail(&rrq->list, &phba->active_rrq_list);
 	phba->hba_flag |= HBA_RRQ_ACTIVE;
+	spin_unlock_irqrestore(&phba->hbalock, iflags);
 	if (empty)
 		lpfc_worker_wake_up(phba);
-	spin_unlock_irqrestore(&phba->hbalock, iflags);
 	return 0;
 out:
 	spin_unlock_irqrestore(&phba->hbalock, iflags);
@@ -2830,7 +2830,7 @@ lpfc_sli_wake_mbox_wait(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmboxq)
 	 */
 	pmboxq->mbox_flag |= LPFC_MBX_WAKE;
 	spin_lock_irqsave(&phba->hbalock, drvr_flag);
-	pmbox_done = (struct completion *)pmboxq->context3;
+	pmbox_done = pmboxq->ctx_u.mbox_wait;
 	if (pmbox_done)
 		complete(pmbox_done);
 	spin_unlock_irqrestore(&phba->hbalock, drvr_flag);
@@ -2885,7 +2885,7 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	if (!test_bit(FC_UNLOADING, &phba->pport->load_flag) &&
 	    pmb->u.mb.mbxCommand == MBX_REG_LOGIN64 &&
 	    !pmb->u.mb.mbxStatus) {
-		mp = (struct lpfc_dmabuf *)pmb->ctx_buf;
+		mp = pmb->ctx_buf;
 		if (mp) {
 			pmb->ctx_buf = NULL;
 			lpfc_mbuf_free(phba, mp->virt, mp->phys);
@@ -2914,12 +2914,12 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	}
 
 	if (pmb->u.mb.mbxCommand == MBX_REG_LOGIN64) {
-		ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
+		ndlp = pmb->ctx_ndlp;
 		lpfc_nlp_put(ndlp);
 	}
 
 	if (pmb->u.mb.mbxCommand == MBX_UNREG_LOGIN) {
-		ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
+		ndlp = pmb->ctx_ndlp;
 
 		/* Check to see if there are any deferred events to process */
 		if (ndlp) {
@@ -2952,7 +2952,7 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 	/* This nlp_put pairs with lpfc_sli4_resume_rpi */
 	if (pmb->u.mb.mbxCommand == MBX_RESUME_RPI) {
-		ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
+		ndlp = pmb->ctx_ndlp;
 		lpfc_nlp_put(ndlp);
 	}
 
@@ -5819,7 +5819,7 @@ lpfc_sli4_read_fcoe_params(struct lpfc_hba *phba)
 		goto out_free_mboxq;
 	}
 
-	mp = (struct lpfc_dmabuf *)mboxq->ctx_buf;
+	mp = mboxq->ctx_buf;
 	rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_POLL);
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_MBOX | LOG_SLI,
@@ -6849,9 +6849,9 @@ lpfc_ras_stop_fwlog(struct lpfc_hba *phba)
 {
 	struct lpfc_ras_fwlog *ras_fwlog = &phba->ras_fwlog;
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	ras_fwlog->state = INACTIVE;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	/* Disable FW logging to host memory */
 	writel(LPFC_CTL_PDEV_CTL_DDL_RAS,
@@ -6894,9 +6894,9 @@ lpfc_sli4_ras_dma_free(struct lpfc_hba *phba)
 		ras_fwlog->lwpd.virt = NULL;
 	}
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	ras_fwlog->state = INACTIVE;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 }
 
 /**
@@ -6998,9 +6998,9 @@ lpfc_sli4_ras_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		goto disable_ras;
 	}
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	ras_fwlog->state = ACTIVE;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 	mempool_free(pmb, phba->mbox_mem_pool);
 
 	return;
@@ -7032,9 +7032,9 @@ lpfc_sli4_ras_fwlog_init(struct lpfc_hba *phba,
 	uint32_t len = 0, fwlog_buffsize, fwlog_entry_count;
 	int rc = 0;
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	ras_fwlog->state = INACTIVE;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	fwlog_buffsize = (LPFC_RAS_MIN_BUFF_POST_SIZE *
 			  phba->cfg_ras_fwlog_buffsize);
@@ -7095,9 +7095,9 @@ lpfc_sli4_ras_fwlog_init(struct lpfc_hba *phba,
 	mbx_fwlog->u.request.lwpd.addr_lo = putPaddrLow(ras_fwlog->lwpd.phys);
 	mbx_fwlog->u.request.lwpd.addr_hi = putPaddrHigh(ras_fwlog->lwpd.phys);
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	ras_fwlog->state = REG_INPROGRESS;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 	mbox->vport = phba->pport;
 	mbox->mbox_cmpl = lpfc_sli4_ras_mbox_cmpl;
 
@@ -8766,7 +8766,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 
 	mboxq->vport = vport;
 	rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_POLL);
-	mp = (struct lpfc_dmabuf *)mboxq->ctx_buf;
+	mp = mboxq->ctx_buf;
 	if (rc == MBX_SUCCESS) {
 		memcpy(&vport->fc_sparam, mp->virt, sizeof(struct serv_parm));
 		rc = 0;
@@ -9548,8 +9548,8 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 		}
 
 		/* Copy the mailbox extension data */
-		if (pmbox->in_ext_byte_len && pmbox->ctx_buf) {
-			lpfc_sli_pcimem_bcopy(pmbox->ctx_buf,
+		if (pmbox->in_ext_byte_len && pmbox->ext_buf) {
+			lpfc_sli_pcimem_bcopy(pmbox->ext_buf,
 					      (uint8_t *)phba->mbox_ext,
 					      pmbox->in_ext_byte_len);
 		}
@@ -9562,10 +9562,10 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 				= MAILBOX_HBA_EXT_OFFSET;
 
 		/* Copy the mailbox extension data */
-		if (pmbox->in_ext_byte_len && pmbox->ctx_buf)
+		if (pmbox->in_ext_byte_len && pmbox->ext_buf)
 			lpfc_memcpy_to_slim(phba->MBslimaddr +
 				MAILBOX_HBA_EXT_OFFSET,
-				pmbox->ctx_buf, pmbox->in_ext_byte_len);
+				pmbox->ext_buf, pmbox->in_ext_byte_len);
 
 		if (mbx->mbxCommand == MBX_CONFIG_PORT)
 			/* copy command data into host mbox for cmpl */
@@ -9688,9 +9688,9 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 			lpfc_sli_pcimem_bcopy(phba->mbox, mbx,
 						MAILBOX_CMD_SIZE);
 			/* Copy the mailbox extension data */
-			if (pmbox->out_ext_byte_len && pmbox->ctx_buf) {
+			if (pmbox->out_ext_byte_len && pmbox->ext_buf) {
 				lpfc_sli_pcimem_bcopy(phba->mbox_ext,
-						      pmbox->ctx_buf,
+						      pmbox->ext_buf,
 						      pmbox->out_ext_byte_len);
 			}
 		} else {
@@ -9698,9 +9698,9 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 			lpfc_memcpy_from_slim(mbx, phba->MBslimaddr,
 						MAILBOX_CMD_SIZE);
 			/* Copy the mailbox extension data */
-			if (pmbox->out_ext_byte_len && pmbox->ctx_buf) {
+			if (pmbox->out_ext_byte_len && pmbox->ext_buf) {
 				lpfc_memcpy_from_slim(
-					pmbox->ctx_buf,
+					pmbox->ext_buf,
 					phba->MBslimaddr +
 					MAILBOX_HBA_EXT_OFFSET,
 					pmbox->out_ext_byte_len);
@@ -11373,18 +11373,18 @@ lpfc_sli_post_recovery_event(struct lpfc_hba *phba,
 	unsigned long iflags;
 	struct lpfc_work_evt  *evtp = &ndlp->recovery_evt;
 
+	/* Hold a node reference for outstanding queued work */
+	if (!lpfc_nlp_get(ndlp))
+		return;
+
 	spin_lock_irqsave(&phba->hbalock, iflags);
 	if (!list_empty(&evtp->evt_listp)) {
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
+		lpfc_nlp_put(ndlp);
 		return;
 	}
 
-	/* Incrementing the reference count until the queued work is done. */
-	evtp->evt_arg1  = lpfc_nlp_get(ndlp);
-	if (!evtp->evt_arg1) {
-		spin_unlock_irqrestore(&phba->hbalock, iflags);
-		return;
-	}
+	evtp->evt_arg1 = ndlp;
 	evtp->evt = LPFC_EVT_RECOVER_PORT;
 	list_add_tail(&evtp->evt_listp, &phba->work_list);
 	spin_unlock_irqrestore(&phba->hbalock, iflags);
@@ -13262,9 +13262,9 @@ lpfc_sli_issue_mbox_wait(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmboxq,
 	/* setup wake call as IOCB callback */
 	pmboxq->mbox_cmpl = lpfc_sli_wake_mbox_wait;
 
-	/* setup context3 field to pass wait_queue pointer to wake function  */
+	/* setup ctx_u field to pass wait_queue pointer to wake function  */
 	init_completion(&mbox_done);
-	pmboxq->context3 = &mbox_done;
+	pmboxq->ctx_u.mbox_wait = &mbox_done;
 	/* now issue the command */
 	retval = lpfc_sli_issue_mbox(phba, pmboxq, MBX_NOWAIT);
 	if (retval == MBX_BUSY || retval == MBX_SUCCESS) {
@@ -13272,7 +13272,7 @@ lpfc_sli_issue_mbox_wait(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmboxq,
 					    msecs_to_jiffies(timeout * 1000));
 
 		spin_lock_irqsave(&phba->hbalock, flag);
-		pmboxq->context3 = NULL;
+		pmboxq->ctx_u.mbox_wait = NULL;
 		/*
 		 * if LPFC_MBX_WAKE flag is set the mailbox is completed
 		 * else do not free the resources.
@@ -13813,10 +13813,10 @@ lpfc_sli_sp_intr_handler(int irq, void *dev_id)
 					lpfc_sli_pcimem_bcopy(mbox, pmbox,
 							MAILBOX_CMD_SIZE);
 					if (pmb->out_ext_byte_len &&
-						pmb->ctx_buf)
+						pmb->ext_buf)
 						lpfc_sli_pcimem_bcopy(
 						phba->mbox_ext,
-						pmb->ctx_buf,
+						pmb->ext_buf,
 						pmb->out_ext_byte_len);
 				}
 				if (pmb->mbox_flag & LPFC_MBX_IMED_UNREG) {
@@ -13830,10 +13830,8 @@ lpfc_sli_sp_intr_handler(int irq, void *dev_id)
 						pmbox->un.varWords[0], 0);
 
 					if (!pmbox->mbxStatus) {
-						mp = (struct lpfc_dmabuf *)
-							(pmb->ctx_buf);
-						ndlp = (struct lpfc_nodelist *)
-							pmb->ctx_ndlp;
+						mp = pmb->ctx_buf;
+						ndlp = pmb->ctx_ndlp;
 
 						/* Reg_LOGIN of dflt RPI was
 						 * successful. new lets get
@@ -14340,8 +14338,8 @@ lpfc_sli4_sp_handle_mbox_event(struct lpfc_hba *phba, struct lpfc_mcqe *mcqe)
 				      mcqe_status,
 				      pmbox->un.varWords[0], 0);
 		if (mcqe_status == MB_CQE_STATUS_SUCCESS) {
-			mp = (struct lpfc_dmabuf *)(pmb->ctx_buf);
-			ndlp = (struct lpfc_nodelist *)pmb->ctx_ndlp;
+			mp = pmb->ctx_buf;
+			ndlp = pmb->ctx_ndlp;
 
 			/* Reg_LOGIN of dflt RPI was successful. Mark the
 			 * node as having an UNREG_LOGIN in progress to stop
@@ -19823,14 +19821,15 @@ lpfc_sli4_remove_rpis(struct lpfc_hba *phba)
  * lpfc_sli4_resume_rpi - Remove the rpi bitmask region
  * @ndlp: pointer to lpfc nodelist data structure.
  * @cmpl: completion call-back.
- * @arg: data to load as MBox 'caller buffer information'
+ * @iocbq: data to load as mbox ctx_u information
  *
  * This routine is invoked to remove the memory region that
  * provided rpi via a bitmask.
  **/
 int
 lpfc_sli4_resume_rpi(struct lpfc_nodelist *ndlp,
-	void (*cmpl)(struct lpfc_hba *, LPFC_MBOXQ_t *), void *arg)
+		     void (*cmpl)(struct lpfc_hba *, LPFC_MBOXQ_t *),
+		     struct lpfc_iocbq *iocbq)
 {
 	LPFC_MBOXQ_t *mboxq;
 	struct lpfc_hba *phba = ndlp->phba;
@@ -19859,7 +19858,7 @@ lpfc_sli4_resume_rpi(struct lpfc_nodelist *ndlp,
 	lpfc_resume_rpi(mboxq, ndlp);
 	if (cmpl) {
 		mboxq->mbox_cmpl = cmpl;
-		mboxq->ctx_buf = arg;
+		mboxq->ctx_u.save_iocb = iocbq;
 	} else
 		mboxq->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
 	mboxq->ctx_ndlp = ndlp;
@@ -20676,7 +20675,7 @@ lpfc_sli4_get_config_region23(struct lpfc_hba *phba, char *rgn23_data)
 	if (lpfc_sli4_dump_cfg_rg23(phba, mboxq))
 		goto out;
 	mqe = &mboxq->u.mqe;
-	mp = (struct lpfc_dmabuf *)mboxq->ctx_buf;
+	mp = mboxq->ctx_buf;
 	rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_POLL);
 	if (rc)
 		goto out;
@@ -21035,7 +21034,7 @@ lpfc_cleanup_pending_mbox(struct lpfc_vport *vport)
 			(mb->u.mb.mbxCommand == MBX_REG_VPI))
 			mb->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
 		if (mb->u.mb.mbxCommand == MBX_REG_LOGIN64) {
-			act_mbx_ndlp = (struct lpfc_nodelist *)mb->ctx_ndlp;
+			act_mbx_ndlp = mb->ctx_ndlp;
 
 			/* This reference is local to this routine.  The
 			 * reference is removed at routine exit.
@@ -21064,7 +21063,7 @@ lpfc_cleanup_pending_mbox(struct lpfc_vport *vport)
 
 			mb->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
 			if (mb->u.mb.mbxCommand == MBX_REG_LOGIN64) {
-				ndlp = (struct lpfc_nodelist *)mb->ctx_ndlp;
+				ndlp = mb->ctx_ndlp;
 				/* Unregister the RPI when mailbox complete */
 				mb->mbox_flag |= LPFC_MBX_IMED_UNREG;
 				restart_loop = 1;
@@ -21084,7 +21083,7 @@ lpfc_cleanup_pending_mbox(struct lpfc_vport *vport)
 	while (!list_empty(&mbox_cmd_list)) {
 		list_remove_head(&mbox_cmd_list, mb, LPFC_MBOXQ_t, list);
 		if (mb->u.mb.mbxCommand == MBX_REG_LOGIN64) {
-			ndlp = (struct lpfc_nodelist *)mb->ctx_ndlp;
+			ndlp = mb->ctx_ndlp;
 			mb->ctx_ndlp = NULL;
 			if (ndlp) {
 				spin_lock(&ndlp->lock);
diff --git a/drivers/scsi/lpfc/lpfc_sli.h b/drivers/scsi/lpfc/lpfc_sli.h
index c911a39cb46b..cf7c42ec0306 100644
--- a/drivers/scsi/lpfc/lpfc_sli.h
+++ b/drivers/scsi/lpfc/lpfc_sli.h
@@ -1,7 +1,7 @@
 /*******************************************************************
  * This file is part of the Emulex Linux Device Driver for         *
  * Fibre Channel Host Bus Adapters.                                *
- * Copyright (C) 2017-2023 Broadcom. All Rights Reserved. The term *
+ * Copyright (C) 2017-2024 Broadcom. All Rights Reserved. The term *
  * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.     *
  * Copyright (C) 2004-2016 Emulex.  All rights reserved.           *
  * EMULEX and SLI are trademarks of Emulex.                        *
@@ -182,11 +182,29 @@ typedef struct lpfcMboxq {
 		struct lpfc_mqe mqe;
 	} u;
 	struct lpfc_vport *vport; /* virtual port pointer */
-	void *ctx_ndlp;		  /* an lpfc_nodelist pointer */
-	void *ctx_buf;		  /* an lpfc_dmabuf pointer */
-	void *context3;           /* a generic pointer.  Code must
-				   * accommodate the actual datatype.
-				   */
+	struct lpfc_nodelist *ctx_ndlp;	/* caller ndlp pointer */
+	struct lpfc_dmabuf *ctx_buf;	/* caller buffer information */
+	void *ext_buf;			/* extended buffer for extended mbox
+					 * cmds.  Not a generic pointer.
+					 * Use for storing virtual address.
+					 */
+
+	/* Pointers that are seldom used during mbox execution, but require
+	 * a saved context.
+	 */
+	union {
+		unsigned long ox_rx_id;		/* Used in els_rsp_rls_acc */
+		struct lpfc_rdp_context *rdp;	/* Used in get_rdp_info */
+		struct lpfc_lcb_context *lcb;	/* Used in set_beacon */
+		struct completion *mbox_wait;	/* Used in issue_mbox_wait */
+		struct bsg_job_data *dd_data;	/* Used in bsg_issue_mbox_cmpl
+						 * and
+						 * bsg_issue_mbox_ext_handle_job
+						 */
+		struct lpfc_iocbq *save_iocb;	/* Used in defer_plogi_acc and
+						 * lpfc_mbx_cmpl_resume_rpi
+						 */
+	} ctx_u;
 
 	void (*mbox_cmpl) (struct lpfc_hba *, struct lpfcMboxq *);
 	uint8_t mbox_flag;
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index 2541a8fba093..c1e9ec0243ba 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -1,7 +1,7 @@
 /*******************************************************************
  * This file is part of the Emulex Linux Device Driver for         *
  * Fibre Channel Host Bus Adapters.                                *
- * Copyright (C) 2017-2023 Broadcom. All Rights Reserved. The term *
+ * Copyright (C) 2017-2024 Broadcom. All Rights Reserved. The term *
  * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.     *
  * Copyright (C) 2009-2016 Emulex.  All rights reserved.           *
  * EMULEX and SLI are trademarks of Emulex.                        *
@@ -1118,8 +1118,9 @@ void lpfc_sli4_free_rpi(struct lpfc_hba *, int);
 void lpfc_sli4_remove_rpis(struct lpfc_hba *);
 void lpfc_sli4_async_event_proc(struct lpfc_hba *);
 void lpfc_sli4_fcf_redisc_event_proc(struct lpfc_hba *);
-int lpfc_sli4_resume_rpi(struct lpfc_nodelist *,
-			void (*)(struct lpfc_hba *, LPFC_MBOXQ_t *), void *);
+int lpfc_sli4_resume_rpi(struct lpfc_nodelist *ndlp,
+			 void (*cmpl)(struct lpfc_hba *, LPFC_MBOXQ_t *),
+			 struct lpfc_iocbq *iocbq);
 void lpfc_sli4_els_xri_abort_event_proc(struct lpfc_hba *phba);
 void lpfc_sli4_nvme_pci_offline_aborted(struct lpfc_hba *phba,
 					struct lpfc_io_buf *lpfc_ncmd);
diff --git a/drivers/scsi/lpfc/lpfc_version.h b/drivers/scsi/lpfc/lpfc_version.h
index 56f5889dbaf9..915f2f11fb55 100644
--- a/drivers/scsi/lpfc/lpfc_version.h
+++ b/drivers/scsi/lpfc/lpfc_version.h
@@ -20,7 +20,7 @@
  * included with this package.                                     *
  *******************************************************************/
 
-#define LPFC_DRIVER_VERSION "14.4.0.0"
+#define LPFC_DRIVER_VERSION "14.4.0.1"
 #define LPFC_DRIVER_NAME		"lpfc"
 
 /* Used for SLI 2/3 */
diff --git a/drivers/scsi/lpfc/lpfc_vport.c b/drivers/scsi/lpfc/lpfc_vport.c
index 0f79840b9498..4439167a5188 100644
--- a/drivers/scsi/lpfc/lpfc_vport.c
+++ b/drivers/scsi/lpfc/lpfc_vport.c
@@ -166,7 +166,7 @@ lpfc_vport_sparm(struct lpfc_hba *phba, struct lpfc_vport *vport)
 		}
 	}
 
-	mp = (struct lpfc_dmabuf *)pmb->ctx_buf;
+	mp = pmb->ctx_buf;
 	memcpy(&vport->fc_sparam, mp->virt, sizeof (struct serv_parm));
 	memcpy(&vport->fc_nodename, &vport->fc_sparam.nodeName,
 	       sizeof (struct lpfc_name));
@@ -674,10 +674,6 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 	lpfc_free_sysfs_attr(vport);
 	lpfc_debugfs_terminate(vport);
 
-	/* Remove FC host to break driver binding. */
-	fc_remove_host(shost);
-	scsi_remove_host(shost);
-
 	/* Send the DA_ID and Fabric LOGO to cleanup Nameserver entries. */
 	ndlp = lpfc_findnode_did(vport, Fabric_DID);
 	if (!ndlp)
@@ -721,6 +717,10 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 
 skip_logo:
 
+	/* Remove FC host to break driver binding. */
+	fc_remove_host(shost);
+	scsi_remove_host(shost);
+
 	lpfc_cleanup(vport);
 
 	/* Remove scsi host now.  The nodes are cleaned up. */
diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 0380996b5ad2..55d590b91947 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -1644,7 +1644,7 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 	if ((mpirep_offset != 0xFF) &&
 	    drv_bufs[mpirep_offset].bsg_buf_len) {
 		drv_buf_iter = &drv_bufs[mpirep_offset];
-		drv_buf_iter->kern_buf_len = (sizeof(*bsg_reply_buf) - 1 +
+		drv_buf_iter->kern_buf_len = (sizeof(*bsg_reply_buf) +
 					   mrioc->reply_sz);
 		bsg_reply_buf = kzalloc(drv_buf_iter->kern_buf_len, GFP_KERNEL);
 
diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index e8bcc3a88732..0614b7e366b7 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -61,7 +61,9 @@ static atomic_t pmcraid_adapter_count = ATOMIC_INIT(0);
  * pmcraid_minor - minor number(s) to use
  */
 static unsigned int pmcraid_major;
-static struct class *pmcraid_class;
+static const struct class pmcraid_class = {
+	.name = PMCRAID_DEVFILE,
+};
 static DECLARE_BITMAP(pmcraid_minor, PMCRAID_MAX_ADAPTERS);
 
 /*
@@ -4723,7 +4725,7 @@ static int pmcraid_setup_chrdev(struct pmcraid_instance *pinstance)
 	if (error)
 		pmcraid_release_minor(minor);
 	else
-		device_create(pmcraid_class, NULL, MKDEV(pmcraid_major, minor),
+		device_create(&pmcraid_class, NULL, MKDEV(pmcraid_major, minor),
 			      NULL, "%s%u", PMCRAID_DEVFILE, minor);
 	return error;
 }
@@ -4739,7 +4741,7 @@ static int pmcraid_setup_chrdev(struct pmcraid_instance *pinstance)
 static void pmcraid_release_chrdev(struct pmcraid_instance *pinstance)
 {
 	pmcraid_release_minor(MINOR(pinstance->cdev.dev));
-	device_destroy(pmcraid_class,
+	device_destroy(&pmcraid_class,
 		       MKDEV(pmcraid_major, MINOR(pinstance->cdev.dev)));
 	cdev_del(&pinstance->cdev);
 }
@@ -5390,10 +5392,10 @@ static int __init pmcraid_init(void)
 	}
 
 	pmcraid_major = MAJOR(dev);
-	pmcraid_class = class_create(PMCRAID_DEVFILE);
 
-	if (IS_ERR(pmcraid_class)) {
-		error = PTR_ERR(pmcraid_class);
+	error = class_register(&pmcraid_class);
+
+	if (error) {
 		pmcraid_err("failed to register with sysfs, error = %x\n",
 			    error);
 		goto out_unreg_chrdev;
@@ -5402,7 +5404,7 @@ static int __init pmcraid_init(void)
 	error = pmcraid_netlink_init();
 
 	if (error) {
-		class_destroy(pmcraid_class);
+		class_unregister(&pmcraid_class);
 		goto out_unreg_chrdev;
 	}
 
@@ -5413,7 +5415,7 @@ static int __init pmcraid_init(void)
 
 	pmcraid_err("failed to register pmcraid driver, error = %x\n",
 		     error);
-	class_destroy(pmcraid_class);
+	class_unregister(&pmcraid_class);
 	pmcraid_netlink_release();
 
 out_unreg_chrdev:
@@ -5432,7 +5434,7 @@ static void __exit pmcraid_exit(void)
 	unregister_chrdev_region(MKDEV(pmcraid_major, 0),
 				 PMCRAID_MAX_ADAPTERS);
 	pci_unregister_driver(&pmcraid_driver);
-	class_destroy(pmcraid_class);
+	class_unregister(&pmcraid_class);
 }
 
 module_init(pmcraid_init);
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 44449c70a375..76eeba435fd0 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2741,7 +2741,13 @@ qla2x00_dev_loss_tmo_callbk(struct fc_rport *rport)
 		return;
 
 	if (unlikely(pci_channel_offline(fcport->vha->hw->pdev))) {
-		qla2x00_abort_all_cmds(fcport->vha, DID_NO_CONNECT << 16);
+		/* Will wait for wind down of adapter */
+		ql_dbg(ql_dbg_aer, fcport->vha, 0x900c,
+		    "%s pci offline detected (id %06x)\n", __func__,
+		    fcport->d_id.b24);
+		qla_pci_set_eeh_busy(fcport->vha);
+		qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24,
+		    0, WAIT_TARGET);
 		return;
 	}
 }
@@ -2763,7 +2769,11 @@ qla2x00_terminate_rport_io(struct fc_rport *rport)
 	vha = fcport->vha;
 
 	if (unlikely(pci_channel_offline(fcport->vha->hw->pdev))) {
-		qla2x00_abort_all_cmds(fcport->vha, DID_NO_CONNECT << 16);
+		/* Will wait for wind down of adapter */
+		ql_dbg(ql_dbg_aer, fcport->vha, 0x900b,
+		    "%s pci offline detected (id %06x)\n", __func__,
+		    fcport->d_id.b24);
+		qla_pci_set_eeh_busy(vha);
 		qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24,
 			0, WAIT_TARGET);
 		return;
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index deb642607deb..2f49baf131e2 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -82,7 +82,7 @@ typedef union {
 #include "qla_nvme.h"
 #define QLA2XXX_DRIVER_NAME	"qla2xxx"
 #define QLA2XXX_APIDEV		"ql2xapidev"
-#define QLA2XXX_MANUFACTURER	"Marvell Semiconductor, Inc."
+#define QLA2XXX_MANUFACTURER	"Marvell"
 
 /*
  * We have MAILBOX_REGISTER_COUNT sized arrays in a few places,
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 09cb9413670a..7309310d2ab9 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -44,7 +44,7 @@ extern int qla2x00_fabric_login(scsi_qla_host_t *, fc_port_t *, uint16_t *);
 extern int qla2x00_local_device_login(scsi_qla_host_t *, fc_port_t *);
 
 extern int qla24xx_els_dcmd_iocb(scsi_qla_host_t *, int, port_id_t);
-extern int qla24xx_els_dcmd2_iocb(scsi_qla_host_t *, int, fc_port_t *, bool);
+extern int qla24xx_els_dcmd2_iocb(scsi_qla_host_t *, int, fc_port_t *);
 extern void qla2x00_els_dcmd2_free(scsi_qla_host_t *vha,
 				   struct els_plogi *els_plogi);
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index a314cfc5b263..8377624d76c9 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1193,8 +1193,12 @@ int qla24xx_async_gnl(struct scsi_qla_host *vha, fc_port_t *fcport)
 	return rval;
 
 done_free_sp:
-	/* ref: INIT */
-	kref_put(&sp->cmd_kref, qla2x00_sp_release);
+	/*
+	 * use qla24xx_async_gnl_sp_done to purge all pending gnl request.
+	 * kref_put is call behind the scene.
+	 */
+	sp->u.iocb_cmd.u.mbx.in_mb[0] = MBS_COMMAND_ERROR;
+	qla24xx_async_gnl_sp_done(sp, QLA_COMMAND_ERROR);
 	fcport->flags &= ~(FCF_ASYNC_SENT);
 done:
 	fcport->flags &= ~(FCF_ASYNC_ACTIVE);
@@ -2665,6 +2669,40 @@ qla83xx_nic_core_fw_load(scsi_qla_host_t *vha)
 	return rval;
 }
 
+static void qla_enable_fce_trace(scsi_qla_host_t *vha)
+{
+	int rval;
+	struct qla_hw_data *ha = vha->hw;
+
+	if (ha->fce) {
+		ha->flags.fce_enabled = 1;
+		memset(ha->fce, 0, fce_calc_size(ha->fce_bufs));
+		rval = qla2x00_enable_fce_trace(vha,
+		    ha->fce_dma, ha->fce_bufs, ha->fce_mb, &ha->fce_bufs);
+
+		if (rval) {
+			ql_log(ql_log_warn, vha, 0x8033,
+			    "Unable to reinitialize FCE (%d).\n", rval);
+			ha->flags.fce_enabled = 0;
+		}
+	}
+}
+
+static void qla_enable_eft_trace(scsi_qla_host_t *vha)
+{
+	int rval;
+	struct qla_hw_data *ha = vha->hw;
+
+	if (ha->eft) {
+		memset(ha->eft, 0, EFT_SIZE);
+		rval = qla2x00_enable_eft_trace(vha, ha->eft_dma, EFT_NUM_BUFFERS);
+
+		if (rval) {
+			ql_log(ql_log_warn, vha, 0x8034,
+			    "Unable to reinitialize EFT (%d).\n", rval);
+		}
+	}
+}
 /*
 * qla2x00_initialize_adapter
 *      Initialize board.
@@ -3668,9 +3706,8 @@ qla24xx_chip_diag(scsi_qla_host_t *vha)
 }
 
 static void
-qla2x00_init_fce_trace(scsi_qla_host_t *vha)
+qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
 {
-	int rval;
 	dma_addr_t tc_dma;
 	void *tc;
 	struct qla_hw_data *ha = vha->hw;
@@ -3699,27 +3736,17 @@ qla2x00_init_fce_trace(scsi_qla_host_t *vha)
 		return;
 	}
 
-	rval = qla2x00_enable_fce_trace(vha, tc_dma, FCE_NUM_BUFFERS,
-					ha->fce_mb, &ha->fce_bufs);
-	if (rval) {
-		ql_log(ql_log_warn, vha, 0x00bf,
-		       "Unable to initialize FCE (%d).\n", rval);
-		dma_free_coherent(&ha->pdev->dev, FCE_SIZE, tc, tc_dma);
-		return;
-	}
-
 	ql_dbg(ql_dbg_init, vha, 0x00c0,
 	       "Allocated (%d KB) for FCE...\n", FCE_SIZE / 1024);
 
-	ha->flags.fce_enabled = 1;
 	ha->fce_dma = tc_dma;
 	ha->fce = tc;
+	ha->fce_bufs = FCE_NUM_BUFFERS;
 }
 
 static void
-qla2x00_init_eft_trace(scsi_qla_host_t *vha)
+qla2x00_alloc_eft_trace(scsi_qla_host_t *vha)
 {
-	int rval;
 	dma_addr_t tc_dma;
 	void *tc;
 	struct qla_hw_data *ha = vha->hw;
@@ -3744,14 +3771,6 @@ qla2x00_init_eft_trace(scsi_qla_host_t *vha)
 		return;
 	}
 
-	rval = qla2x00_enable_eft_trace(vha, tc_dma, EFT_NUM_BUFFERS);
-	if (rval) {
-		ql_log(ql_log_warn, vha, 0x00c2,
-		       "Unable to initialize EFT (%d).\n", rval);
-		dma_free_coherent(&ha->pdev->dev, EFT_SIZE, tc, tc_dma);
-		return;
-	}
-
 	ql_dbg(ql_dbg_init, vha, 0x00c3,
 	       "Allocated (%d KB) EFT ...\n", EFT_SIZE / 1024);
 
@@ -3759,13 +3778,6 @@ qla2x00_init_eft_trace(scsi_qla_host_t *vha)
 	ha->eft = tc;
 }
 
-static void
-qla2x00_alloc_offload_mem(scsi_qla_host_t *vha)
-{
-	qla2x00_init_fce_trace(vha);
-	qla2x00_init_eft_trace(vha);
-}
-
 void
 qla2x00_alloc_fw_dump(scsi_qla_host_t *vha)
 {
@@ -3820,10 +3832,10 @@ qla2x00_alloc_fw_dump(scsi_qla_host_t *vha)
 		if (ha->tgt.atio_ring)
 			mq_size += ha->tgt.atio_q_length * sizeof(request_t);
 
-		qla2x00_init_fce_trace(vha);
+		qla2x00_alloc_fce_trace(vha);
 		if (ha->fce)
 			fce_size = sizeof(struct qla2xxx_fce_chain) + FCE_SIZE;
-		qla2x00_init_eft_trace(vha);
+		qla2x00_alloc_eft_trace(vha);
 		if (ha->eft)
 			eft_size = EFT_SIZE;
 	}
@@ -4253,7 +4265,6 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 	struct qla_hw_data *ha = vha->hw;
 	struct device_reg_2xxx __iomem *reg = &ha->iobase->isp;
 	unsigned long flags;
-	uint16_t fw_major_version;
 	int done_once = 0;
 
 	if (IS_P3P_TYPE(ha)) {
@@ -4320,7 +4331,6 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 					goto failed;
 
 enable_82xx_npiv:
-				fw_major_version = ha->fw_major_version;
 				if (IS_P3P_TYPE(ha))
 					qla82xx_check_md_needed(vha);
 				else
@@ -4349,12 +4359,11 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 				if (rval != QLA_SUCCESS)
 					goto failed;
 
-				if (!fw_major_version && !(IS_P3P_TYPE(ha)))
-					qla2x00_alloc_offload_mem(vha);
-
 				if (ql2xallocfwdump && !(IS_P3P_TYPE(ha)))
 					qla2x00_alloc_fw_dump(vha);
 
+				qla_enable_fce_trace(vha);
+				qla_enable_eft_trace(vha);
 			} else {
 				goto failed;
 			}
@@ -7487,12 +7496,12 @@ qla2x00_abort_isp_cleanup(scsi_qla_host_t *vha)
 int
 qla2x00_abort_isp(scsi_qla_host_t *vha)
 {
-	int rval;
 	uint8_t        status = 0;
 	struct qla_hw_data *ha = vha->hw;
 	struct scsi_qla_host *vp, *tvp;
 	struct req_que *req = ha->req_q_map[0];
 	unsigned long flags;
+	fc_port_t *fcport;
 
 	if (vha->flags.online) {
 		qla2x00_abort_isp_cleanup(vha);
@@ -7561,6 +7570,15 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 			       "ISP Abort - ISP reg disconnect post nvmram config, exiting.\n");
 			return status;
 		}
+
+		/* User may have updated [fcp|nvme] prefer in flash */
+		list_for_each_entry(fcport, &vha->vp_fcports, list) {
+			if (NVME_PRIORITY(ha, fcport))
+				fcport->do_prli_nvme = 1;
+			else
+				fcport->do_prli_nvme = 0;
+		}
+
 		if (!qla2x00_restart_isp(vha)) {
 			clear_bit(RESET_MARKER_NEEDED, &vha->dpc_flags);
 
@@ -7581,31 +7599,7 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 
 			if (IS_QLA81XX(ha) || IS_QLA8031(ha))
 				qla2x00_get_fw_version(vha);
-			if (ha->fce) {
-				ha->flags.fce_enabled = 1;
-				memset(ha->fce, 0,
-				    fce_calc_size(ha->fce_bufs));
-				rval = qla2x00_enable_fce_trace(vha,
-				    ha->fce_dma, ha->fce_bufs, ha->fce_mb,
-				    &ha->fce_bufs);
-				if (rval) {
-					ql_log(ql_log_warn, vha, 0x8033,
-					    "Unable to reinitialize FCE "
-					    "(%d).\n", rval);
-					ha->flags.fce_enabled = 0;
-				}
-			}
 
-			if (ha->eft) {
-				memset(ha->eft, 0, EFT_SIZE);
-				rval = qla2x00_enable_eft_trace(vha,
-				    ha->eft_dma, EFT_NUM_BUFFERS);
-				if (rval) {
-					ql_log(ql_log_warn, vha, 0x8034,
-					    "Unable to reinitialize EFT "
-					    "(%d).\n", rval);
-				}
-			}
 		} else {	/* failed the ISP abort */
 			vha->flags.online = 1;
 			if (test_bit(ISP_ABORT_RETRY, &vha->dpc_flags)) {
@@ -7655,6 +7649,14 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 				atomic_inc(&vp->vref_count);
 				spin_unlock_irqrestore(&ha->vport_slock, flags);
 
+				/* User may have updated [fcp|nvme] prefer in flash */
+				list_for_each_entry(fcport, &vp->vp_fcports, list) {
+					if (NVME_PRIORITY(ha, fcport))
+						fcport->do_prli_nvme = 1;
+					else
+						fcport->do_prli_nvme = 0;
+				}
+
 				qla2x00_vp_abort_isp(vp);
 
 				spin_lock_irqsave(&ha->vport_slock, flags);
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index df90169f8244..0b41e8a06602 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2587,6 +2587,33 @@ void
 qla2x00_sp_release(struct kref *kref)
 {
 	struct srb *sp = container_of(kref, struct srb, cmd_kref);
+	struct scsi_qla_host *vha = sp->vha;
+
+	switch (sp->type) {
+	case SRB_CT_PTHRU_CMD:
+		/* GPSC & GFPNID use fcport->ct_desc.ct_sns for both req & rsp */
+		if (sp->u.iocb_cmd.u.ctarg.req &&
+			(!sp->fcport ||
+			 sp->u.iocb_cmd.u.ctarg.req != sp->fcport->ct_desc.ct_sns)) {
+			dma_free_coherent(&vha->hw->pdev->dev,
+			    sp->u.iocb_cmd.u.ctarg.req_allocated_size,
+			    sp->u.iocb_cmd.u.ctarg.req,
+			    sp->u.iocb_cmd.u.ctarg.req_dma);
+			sp->u.iocb_cmd.u.ctarg.req = NULL;
+		}
+		if (sp->u.iocb_cmd.u.ctarg.rsp &&
+			(!sp->fcport ||
+			 sp->u.iocb_cmd.u.ctarg.rsp != sp->fcport->ct_desc.ct_sns)) {
+			dma_free_coherent(&vha->hw->pdev->dev,
+			    sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
+			    sp->u.iocb_cmd.u.ctarg.rsp,
+			    sp->u.iocb_cmd.u.ctarg.rsp_dma);
+			sp->u.iocb_cmd.u.ctarg.rsp = NULL;
+		}
+		break;
+	default:
+		break;
+	}
 
 	sp->free(sp);
 }
@@ -2610,7 +2637,8 @@ static void qla2x00_els_dcmd_sp_free(srb_t *sp)
 {
 	struct srb_iocb *elsio = &sp->u.iocb_cmd;
 
-	kfree(sp->fcport);
+	if (sp->fcport)
+		qla2x00_free_fcport(sp->fcport);
 
 	if (elsio->u.els_logo.els_logo_pyld)
 		dma_free_coherent(&sp->vha->hw->pdev->dev, DMA_POOL_SIZE,
@@ -2692,7 +2720,7 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 	 */
 	sp = qla2x00_get_sp(vha, fcport, GFP_KERNEL);
 	if (!sp) {
-		kfree(fcport);
+		qla2x00_free_fcport(fcport);
 		ql_log(ql_log_info, vha, 0x70e6,
 		 "SRB allocation failed\n");
 		return -ENOMEM;
@@ -2723,6 +2751,7 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 	if (!elsio->u.els_logo.els_logo_pyld) {
 		/* ref: INIT */
 		kref_put(&sp->cmd_kref, qla2x00_sp_release);
+		qla2x00_free_fcport(fcport);
 		return QLA_FUNCTION_FAILED;
 	}
 
@@ -2747,6 +2776,7 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 	if (rval != QLA_SUCCESS) {
 		/* ref: INIT */
 		kref_put(&sp->cmd_kref, qla2x00_sp_release);
+		qla2x00_free_fcport(fcport);
 		return QLA_FUNCTION_FAILED;
 	}
 
@@ -3012,7 +3042,7 @@ static void qla2x00_els_dcmd2_sp_done(srb_t *sp, int res)
 
 int
 qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
-    fc_port_t *fcport, bool wait)
+			fc_port_t *fcport)
 {
 	srb_t *sp;
 	struct srb_iocb *elsio = NULL;
@@ -3027,8 +3057,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 	if (!sp) {
 		ql_log(ql_log_info, vha, 0x70e6,
 		 "SRB allocation failed\n");
-		fcport->flags &= ~FCF_ASYNC_ACTIVE;
-		return -ENOMEM;
+		goto done;
 	}
 
 	fcport->flags |= FCF_ASYNC_SENT;
@@ -3037,9 +3066,6 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 	ql_dbg(ql_dbg_io, vha, 0x3073,
 	       "%s Enter: PLOGI portid=%06x\n", __func__, fcport->d_id.b24);
 
-	if (wait)
-		sp->flags = SRB_WAKEUP_ON_COMP;
-
 	sp->type = SRB_ELS_DCMD;
 	sp->name = "ELS_DCMD";
 	sp->fcport = fcport;
@@ -3055,7 +3081,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 
 	if (!elsio->u.els_plogi.els_plogi_pyld) {
 		rval = QLA_FUNCTION_FAILED;
-		goto out;
+		goto done_free_sp;
 	}
 
 	resp_ptr = elsio->u.els_plogi.els_resp_pyld =
@@ -3064,7 +3090,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 
 	if (!elsio->u.els_plogi.els_resp_pyld) {
 		rval = QLA_FUNCTION_FAILED;
-		goto out;
+		goto done_free_sp;
 	}
 
 	ql_dbg(ql_dbg_io, vha, 0x3073, "PLOGI %p %p\n", ptr, resp_ptr);
@@ -3080,7 +3106,6 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 
 	if (els_opcode == ELS_DCMD_PLOGI && DBELL_ACTIVE(vha)) {
 		struct fc_els_flogi *p = ptr;
-
 		p->fl_csp.sp_features |= cpu_to_be16(FC_SP_FT_SEC);
 	}
 
@@ -3089,10 +3114,11 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 	    (uint8_t *)elsio->u.els_plogi.els_plogi_pyld,
 	    sizeof(*elsio->u.els_plogi.els_plogi_pyld));
 
-	init_completion(&elsio->u.els_plogi.comp);
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
-		rval = QLA_FUNCTION_FAILED;
+		fcport->flags |= FCF_LOGIN_NEEDED;
+		set_bit(RELOGIN_NEEDED, &vha->dpc_flags);
+		goto done_free_sp;
 	} else {
 		ql_dbg(ql_dbg_disc, vha, 0x3074,
 		    "%s PLOGI sent, hdl=%x, loopid=%x, to port_id %06x from port_id %06x\n",
@@ -3100,21 +3126,15 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 		    fcport->d_id.b24, vha->d_id.b24);
 	}
 
-	if (wait) {
-		wait_for_completion(&elsio->u.els_plogi.comp);
-
-		if (elsio->u.els_plogi.comp_status != CS_COMPLETE)
-			rval = QLA_FUNCTION_FAILED;
-	} else {
-		goto done;
-	}
+	return rval;
 
-out:
-	fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
+done_free_sp:
 	qla2x00_els_dcmd2_free(vha, &elsio->u.els_plogi);
 	/* ref: INIT */
 	kref_put(&sp->cmd_kref, qla2x00_sp_release);
 done:
+	fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
+	qla2x00_set_fcport_disc_state(fcport, DSC_DELETED);
 	return rval;
 }
 
@@ -3918,7 +3938,7 @@ qla2x00_start_sp(srb_t *sp)
 		return -EAGAIN;
 	}
 
-	pkt = __qla2x00_alloc_iocbs(sp->qpair, sp);
+	pkt = qla2x00_alloc_iocbs_ready(sp->qpair, sp);
 	if (!pkt) {
 		rval = -EAGAIN;
 		ql_log(ql_log_warn, vha, 0x700c,
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 21ec32b4fb28..0cd6f3e14882 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -194,7 +194,7 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 	if (ha->flags.purge_mbox || chip_reset != ha->chip_reset ||
 	    ha->flags.eeh_busy) {
 		ql_log(ql_log_warn, vha, 0xd035,
-		       "Error detected: purge[%d] eeh[%d] cmd=0x%x, Exiting.\n",
+		       "Purge mbox: purge[%d] eeh[%d] cmd=0x%x, Exiting.\n",
 		       ha->flags.purge_mbox, ha->flags.eeh_busy, mcp->mb[0]);
 		rval = QLA_ABORTED;
 		goto premature_exit;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index dd674378f2f3..1e2f52210f60 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4602,6 +4602,7 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 	ha->init_cb_dma = 0;
 fail_free_vp_map:
 	kfree(ha->vp_map);
+	ha->vp_map = NULL;
 fail:
 	ql_log(ql_log_fatal, NULL, 0x0030,
 	    "Memory allocation failure.\n");
@@ -5583,7 +5584,7 @@ qla2x00_do_work(struct scsi_qla_host *vha)
 			break;
 		case QLA_EVT_ELS_PLOGI:
 			qla24xx_els_dcmd2_iocb(vha, ELS_DCMD_PLOGI,
-			    e->u.fcport.fcport, false);
+			    e->u.fcport.fcport);
 			break;
 		case QLA_EVT_SA_REPLACE:
 			rc = qla24xx_issue_sa_replace_iocb(vha, e);
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 2ef2dbac0db2..d7551b1443e4 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1062,6 +1062,16 @@ void qlt_free_session_done(struct work_struct *work)
 		    "%s: sess %p logout completed\n", __func__, sess);
 	}
 
+	/* check for any straggling io left behind */
+	if (!(sess->flags & FCF_FCP2_DEVICE) &&
+	    qla2x00_eh_wait_for_pending_commands(sess->vha, sess->d_id.b24, 0, WAIT_TARGET)) {
+		ql_log(ql_log_warn, vha, 0x3027,
+		    "IO not return. Resetting.\n");
+		set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
+		qla2xxx_wake_dpc(vha);
+		qla2x00_wait_for_chip_reset(vha);
+	}
+
 	if (sess->logo_ack_needed) {
 		sess->logo_ack_needed = 0;
 		qla24xx_async_notify_ack(vha, sess,
diff --git a/drivers/scsi/qla2xxx/qla_version.h b/drivers/scsi/qla2xxx/qla_version.h
index d903563e969e..7627fd807bc3 100644
--- a/drivers/scsi/qla2xxx/qla_version.h
+++ b/drivers/scsi/qla2xxx/qla_version.h
@@ -6,9 +6,9 @@
 /*
  * Driver version
  */
-#define QLA2XXX_VERSION      "10.02.09.100-k"
+#define QLA2XXX_VERSION      "10.02.09.200-k"
 
 #define QLA_DRIVER_MAJOR_VER	10
 #define QLA_DRIVER_MINOR_VER	2
 #define QLA_DRIVER_PATCH_VER	9
-#define QLA_DRIVER_BETA_VER	100
+#define QLA_DRIVER_BETA_VER	200
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 8d06475de17a..ffd7e7e72933 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1642,6 +1642,40 @@ int scsi_add_device(struct Scsi_Host *host, uint channel,
 }
 EXPORT_SYMBOL(scsi_add_device);
 
+int scsi_resume_device(struct scsi_device *sdev)
+{
+	struct device *dev = &sdev->sdev_gendev;
+	int ret = 0;
+
+	device_lock(dev);
+
+	/*
+	 * Bail out if the device or its queue are not running. Otherwise,
+	 * the rescan may block waiting for commands to be executed, with us
+	 * holding the device lock. This can result in a potential deadlock
+	 * in the power management core code when system resume is on-going.
+	 */
+	if (sdev->sdev_state != SDEV_RUNNING ||
+	    blk_queue_pm_only(sdev->request_queue)) {
+		ret = -EWOULDBLOCK;
+		goto unlock;
+	}
+
+	if (dev->driver && try_module_get(dev->driver->owner)) {
+		struct scsi_driver *drv = to_scsi_driver(dev->driver);
+
+		if (drv->resume)
+			ret = drv->resume(dev);
+		module_put(dev->driver->owner);
+	}
+
+unlock:
+	device_unlock(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(scsi_resume_device);
+
 int scsi_rescan_device(struct scsi_device *sdev)
 {
 	struct device *dev = &sdev->sdev_gendev;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index ccff8f2e2e75..3cf898670290 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4108,7 +4108,21 @@ static int sd_suspend_runtime(struct device *dev)
 	return sd_suspend_common(dev, true);
 }
 
-static int sd_resume(struct device *dev, bool runtime)
+static int sd_resume(struct device *dev)
+{
+	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+
+	sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
+
+	if (opal_unlock_from_suspend(sdkp->opal_dev)) {
+		sd_printk(KERN_NOTICE, sdkp, "OPAL unlock failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int sd_resume_common(struct device *dev, bool runtime)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
 	int ret;
@@ -4124,7 +4138,7 @@ static int sd_resume(struct device *dev, bool runtime)
 	sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
 	ret = sd_start_stop_device(sdkp, 1);
 	if (!ret) {
-		opal_unlock_from_suspend(sdkp->opal_dev);
+		sd_resume(dev);
 		sdkp->suspended = false;
 	}
 
@@ -4143,7 +4157,7 @@ static int sd_resume_system(struct device *dev)
 		return 0;
 	}
 
-	return sd_resume(dev, false);
+	return sd_resume_common(dev, false);
 }
 
 static int sd_resume_runtime(struct device *dev)
@@ -4170,7 +4184,7 @@ static int sd_resume_runtime(struct device *dev)
 				  "Failed to clear sense data\n");
 	}
 
-	return sd_resume(dev, true);
+	return sd_resume_common(dev, true);
 }
 
 static const struct dev_pm_ops sd_pm_ops = {
@@ -4193,6 +4207,7 @@ static struct scsi_driver sd_template = {
 		.pm		= &sd_pm_ops,
 	},
 	.rescan			= sd_rescan,
+	.resume			= sd_resume,
 	.init_command		= sd_init_command,
 	.uninit_command		= sd_uninit_command,
 	.done			= sd_done,
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 86210e4dd0d3..386981c6976a 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1424,7 +1424,9 @@ static const struct file_operations sg_fops = {
 	.llseek = no_llseek,
 };
 
-static struct class *sg_sysfs_class;
+static const struct class sg_sysfs_class = {
+	.name = "scsi_generic"
+};
 
 static int sg_sysfs_valid = 0;
 
@@ -1526,7 +1528,7 @@ sg_add_device(struct device *cl_dev)
 	if (sg_sysfs_valid) {
 		struct device *sg_class_member;
 
-		sg_class_member = device_create(sg_sysfs_class, cl_dev->parent,
+		sg_class_member = device_create(&sg_sysfs_class, cl_dev->parent,
 						MKDEV(SCSI_GENERIC_MAJOR,
 						      sdp->index),
 						sdp, "%s", sdp->name);
@@ -1616,7 +1618,7 @@ sg_remove_device(struct device *cl_dev)
 	read_unlock_irqrestore(&sdp->sfd_lock, iflags);
 
 	sysfs_remove_link(&scsidp->sdev_gendev.kobj, "generic");
-	device_destroy(sg_sysfs_class, MKDEV(SCSI_GENERIC_MAJOR, sdp->index));
+	device_destroy(&sg_sysfs_class, MKDEV(SCSI_GENERIC_MAJOR, sdp->index));
 	cdev_del(sdp->cdev);
 	sdp->cdev = NULL;
 
@@ -1687,11 +1689,9 @@ init_sg(void)
 				    SG_MAX_DEVS, "sg");
 	if (rc)
 		return rc;
-        sg_sysfs_class = class_create("scsi_generic");
-        if ( IS_ERR(sg_sysfs_class) ) {
-		rc = PTR_ERR(sg_sysfs_class);
+	rc = class_register(&sg_sysfs_class);
+	if (rc)
 		goto err_out;
-        }
 	sg_sysfs_valid = 1;
 	rc = scsi_register_interface(&sg_interface);
 	if (0 == rc) {
@@ -1700,7 +1700,7 @@ init_sg(void)
 #endif				/* CONFIG_SCSI_PROC_FS */
 		return 0;
 	}
-	class_destroy(sg_sysfs_class);
+	class_unregister(&sg_sysfs_class);
 	register_sg_sysctls();
 err_out:
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0), SG_MAX_DEVS);
@@ -1715,7 +1715,7 @@ exit_sg(void)
 	remove_proc_subtree("scsi/sg", NULL);
 #endif				/* CONFIG_SCSI_PROC_FS */
 	scsi_unregister_interface(&sg_interface);
-	class_destroy(sg_sysfs_class);
+	class_unregister(&sg_sysfs_class);
 	sg_sysfs_valid = 0;
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0),
 				 SG_MAX_DEVS);
@@ -2207,6 +2207,7 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 {
 	struct sg_fd *sfp = container_of(work, struct sg_fd, ew.work);
 	struct sg_device *sdp = sfp->parentdp;
+	struct scsi_device *device = sdp->device;
 	Sg_request *srp;
 	unsigned long iflags;
 
@@ -2232,8 +2233,9 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 			"sg_remove_sfp: sfp=0x%p\n", sfp));
 	kfree(sfp);
 
-	scsi_device_put(sdp->device);
+	WARN_ON_ONCE(kref_read(&sdp->d_ref) != 1);
 	kref_put(&sdp->d_ref, sg_device_destroy);
+	scsi_device_put(device);
 	module_put(THIS_MODULE);
 }
 
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 338aa8c42968..5a9bcf8e0792 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -87,7 +87,7 @@ static int try_rdio = 1;
 static int try_wdio = 1;
 static int debug_flag;
 
-static struct class st_sysfs_class;
+static const struct class st_sysfs_class;
 static const struct attribute_group *st_dev_groups[];
 static const struct attribute_group *st_drv_groups[];
 
@@ -4438,7 +4438,7 @@ static void scsi_tape_release(struct kref *kref)
 	return;
 }
 
-static struct class st_sysfs_class = {
+static const struct class st_sysfs_class = {
 	.name = "scsi_tape",
 	.dev_groups = st_dev_groups,
 };
diff --git a/drivers/target/iscsi/iscsi_target_erl1.c b/drivers/target/iscsi/iscsi_target_erl1.c
index 679720021183..d9a6242264b7 100644
--- a/drivers/target/iscsi/iscsi_target_erl1.c
+++ b/drivers/target/iscsi/iscsi_target_erl1.c
@@ -583,7 +583,7 @@ int iscsit_dataout_datapduinorder_no_fbit(
 	struct iscsi_pdu *pdu)
 {
 	int i, send_recovery_r2t = 0, recovery = 0;
-	u32 length = 0, offset = 0, pdu_count = 0, xfer_len = 0;
+	u32 length = 0, offset = 0, pdu_count = 0;
 	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_pdu *first_pdu = NULL;
 
@@ -596,7 +596,6 @@ int iscsit_dataout_datapduinorder_no_fbit(
 			if (cmd->pdu_list[i].seq_no == pdu->seq_no) {
 				if (!first_pdu)
 					first_pdu = &cmd->pdu_list[i];
-				xfer_len += cmd->pdu_list[i].length;
 				pdu_count++;
 			} else if (pdu_count)
 				break;
diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 8db81f1a12d5..768bf87cd80d 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -94,7 +94,7 @@ void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds)
 
 	val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
 	val &= ~MCQ_CFG_MAC_MASK;
-	val |= FIELD_PREP(MCQ_CFG_MAC_MASK, max_active_cmds);
+	val |= FIELD_PREP(MCQ_CFG_MAC_MASK, max_active_cmds - 1);
 	ufshcd_writel(hba, val, REG_UFS_MCQ_CFG);
 }
 EXPORT_SYMBOL_GPL(ufshcd_mcq_config_mac);
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 8d68bd21ae73..06859e17b67b 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1210,8 +1210,10 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up)
 
 	list_for_each_entry(clki, head, list) {
 		if (!IS_ERR_OR_NULL(clki->clk) &&
-			!strcmp(clki->name, "core_clk_unipro")) {
-			if (is_scale_up)
+		    !strcmp(clki->name, "core_clk_unipro")) {
+			if (!clki->max_freq)
+				cycles_in_1us = 150; /* default for backwards compatibility */
+			else if (is_scale_up)
 				cycles_in_1us = ceil(clki->max_freq, (1000 * 1000));
 			else
 				cycles_in_1us = ceil(clk_get_rate(clki->clk), (1000 * 1000));
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 26d68115afb8..324d792e7c78 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -107,6 +107,7 @@ enum {
 
 	ATA_DFLAG_NCQ_PRIO_ENABLED = (1 << 20), /* Priority cmds sent to dev */
 	ATA_DFLAG_CDL_ENABLED	= (1 << 21), /* cmd duration limits is enabled */
+	ATA_DFLAG_RESUMING	= (1 << 22),  /* Device is resuming */
 	ATA_DFLAG_DETACH	= (1 << 24),
 	ATA_DFLAG_DETACHED	= (1 << 25),
 	ATA_DFLAG_DA		= (1 << 26), /* device supports Device Attention */
diff --git a/include/scsi/scsi_driver.h b/include/scsi/scsi_driver.h
index 4ce1988b2ba0..f40915d2ecee 100644
--- a/include/scsi/scsi_driver.h
+++ b/include/scsi/scsi_driver.h
@@ -12,6 +12,7 @@ struct request;
 struct scsi_driver {
 	struct device_driver	gendrv;
 
+	int (*resume)(struct device *);
 	void (*rescan)(struct device *);
 	blk_status_t (*init_command)(struct scsi_cmnd *);
 	void (*uninit_command)(struct scsi_cmnd *);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index b259d42a1e1a..129001f600fc 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -767,6 +767,7 @@ scsi_template_proc_dir(const struct scsi_host_template *sht);
 #define scsi_template_proc_dir(sht) NULL
 #endif
 extern void scsi_scan_host(struct Scsi_Host *);
+extern int scsi_resume_device(struct scsi_device *sdev);
 extern int scsi_rescan_device(struct scsi_device *sdev);
 extern void scsi_remove_host(struct Scsi_Host *);
 extern struct Scsi_Host *scsi_host_get(struct Scsi_Host *);
diff --git a/include/uapi/scsi/scsi_bsg_mpi3mr.h b/include/uapi/scsi/scsi_bsg_mpi3mr.h
index c72ce387286a..30a5c1a59376 100644
--- a/include/uapi/scsi/scsi_bsg_mpi3mr.h
+++ b/include/uapi/scsi/scsi_bsg_mpi3mr.h
@@ -382,7 +382,7 @@ struct mpi3mr_bsg_in_reply_buf {
 	__u8	mpi_reply_type;
 	__u8	rsvd1;
 	__u16	rsvd2;
-	__u8	reply_buf[1];
+	__u8	reply_buf[];
 };
 
 /**
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index cb2afcebbdf5..a35e12f8e68b 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -328,6 +328,7 @@ struct ufs_pwr_mode_info {
  * @op_runtime_config: called to config Operation and runtime regs Pointers
  * @get_outstanding_cqs: called to get outstanding completion queues
  * @config_esi: called to config Event Specific Interrupt
+ * @config_scsi_dev: called to configure SCSI device parameters
  */
 struct ufs_hba_variant_ops {
 	const char *name;



