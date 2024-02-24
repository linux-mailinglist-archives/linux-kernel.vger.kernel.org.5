Return-Path: <linux-kernel+bounces-79419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E028621C9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2751C223CA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834EC611B;
	Sat, 24 Feb 2024 01:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="HzKxfk6U";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="HzKxfk6U"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5DE4A12;
	Sat, 24 Feb 2024 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737526; cv=none; b=IPfBzbitzEpeDFho2qJbaOXrNoBGHrAlnZd1wfeSzEIppkhfmFTijcBGEv4Pn5HPL5OJKNowNQupRECej9bzrvgyNcTY965pen2KzSNIM1d0g60pSmzyocIAoKfowCibuQv179GZhTxs5THmbkwjN7QZfbqYmL//z7O699EnrZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737526; c=relaxed/simple;
	bh=OoiF4g7JAzOBMP/NU8Ao3yW0ND2PQL/4/8HHrCWZBVI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=AKNPUTsw0X7Wk3eEGsMdYRYDuNTwTkipoBLWmGDcZEzXax+i9VMFZL3RlIvwFYdshBNSQemVGqq7h+xpoilkTLb4E+T1y5YaA802hFeFM5U7JfE0uYWQnBSy2RvUQv/GDKOxJd4CMOCZKBJUBZoYYTqW+KBgOTMnTulUN4d+KZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=HzKxfk6U; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=HzKxfk6U; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708737523;
	bh=OoiF4g7JAzOBMP/NU8Ao3yW0ND2PQL/4/8HHrCWZBVI=;
	h=Message-ID:Subject:From:To:Date:From;
	b=HzKxfk6UXE8KG28o7uijmJdh+tk7GOd0GhaDNmhJVrosxkBgtbn0JInCf9r9kdPpl
	 lWvSTvMYM12QM/UxTwG0advNNeAFc1goQKKYw8/06ghaYwTxcTg2miF3MIFs/0wgJU
	 LyrCWL7Y9lhMH/fH+SJWb9feaZKYkipAkORx1Oe8=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9530E1285E09;
	Fri, 23 Feb 2024 20:18:43 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id FZXE4fgdfPWY; Fri, 23 Feb 2024 20:18:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708737523;
	bh=OoiF4g7JAzOBMP/NU8Ao3yW0ND2PQL/4/8HHrCWZBVI=;
	h=Message-ID:Subject:From:To:Date:From;
	b=HzKxfk6UXE8KG28o7uijmJdh+tk7GOd0GhaDNmhJVrosxkBgtbn0JInCf9r9kdPpl
	 lWvSTvMYM12QM/UxTwG0advNNeAFc1goQKKYw8/06ghaYwTxcTg2miF3MIFs/0wgJU
	 LyrCWL7Y9lhMH/fH+SJWb9feaZKYkipAkORx1Oe8=
Received: from [10.0.15.72] (unknown [49.231.15.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 729C51285D66;
	Fri, 23 Feb 2024 20:18:41 -0500 (EST)
Message-ID: <7717849f3c8a7f8d257ecdeab3da860d91616e78.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.8-rc5
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Sat, 24 Feb 2024 08:18:35 +0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Six fixes: the four driver ones are pretty trivial.  The larger two
core changes are to try to fix various USB attached devices which have
somewhat eccentric ways of handling the VPD and other mode pages which
necessitate multiple revalidates (that were removed in the interests of
efficiency) and updating the heuristic for supported VPD pages.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Dan Carpenter (1):
      scsi: ufs: Uninitialized variable in ufshcd_devfreq_target()

Don Brace (1):
      scsi: smartpqi: Fix disable_managed_interrupts

Martin K. Petersen (2):
      scsi: core: Consult supported VPD page list prior to fetching page
      scsi: sd: usb_storage: uas: Access media prior to querying device properties

Naohiro Aota (1):
      scsi: target: pscsi: Fix bio_put() for error case

Randy Dunlap (1):
      scsi: jazz_esp: Only build if SCSI core is builtin

And the diffstat:

 drivers/scsi/Kconfig                  |  2 +-
 drivers/scsi/scsi.c                   | 22 ++++++++++++++++++++--
 drivers/scsi/sd.c                     | 26 +++++++++++++++++++++++++-
 drivers/scsi/smartpqi/smartpqi_init.c |  5 ++++-
 drivers/target/target_core_pscsi.c    |  9 ++++++---
 drivers/ufs/core/ufshcd.c             |  2 +-
 drivers/usb/storage/scsiglue.c        |  7 +++++++
 drivers/usb/storage/uas.c             |  7 +++++++
 include/scsi/scsi_device.h            |  5 +----
 9 files changed, 72 insertions(+), 13 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index addac7fbe37b..9ce27092729c 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1270,7 +1270,7 @@ source "drivers/scsi/arm/Kconfig"
 
 config JAZZ_ESP
 	bool "MIPS JAZZ FAS216 SCSI support"
-	depends on MACH_JAZZ && SCSI
+	depends on MACH_JAZZ && SCSI=y
 	select SCSI_SPI_ATTRS
 	help
 	  This is the driver for the onboard SCSI host adapter of MIPS Magnum
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 76d369343c7a..8cad9792a562 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -328,21 +328,39 @@ static int scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
 	return result + 4;
 }
 
+enum scsi_vpd_parameters {
+	SCSI_VPD_HEADER_SIZE = 4,
+	SCSI_VPD_LIST_SIZE = 36,
+};
+
 static int scsi_get_vpd_size(struct scsi_device *sdev, u8 page)
 {
-	unsigned char vpd_header[SCSI_VPD_HEADER_SIZE] __aligned(4);
+	unsigned char vpd[SCSI_VPD_LIST_SIZE] __aligned(4);
 	int result;
 
 	if (sdev->no_vpd_size)
 		return SCSI_DEFAULT_VPD_LEN;
 
+	/*
+	 * Fetch the supported pages VPD and validate that the requested page
+	 * number is present.
+	 */
+	if (page != 0) {
+		result = scsi_vpd_inquiry(sdev, vpd, 0, sizeof(vpd));
+		if (result < SCSI_VPD_HEADER_SIZE)
+			return 0;
+
+		result -= SCSI_VPD_HEADER_SIZE;
+		if (!memchr(&vpd[SCSI_VPD_HEADER_SIZE], page, result))
+			return 0;
+	}
 	/*
 	 * Fetch the VPD page header to find out how big the page
 	 * is. This is done to prevent problems on legacy devices
 	 * which can not handle allocation lengths as large as
 	 * potentially requested by the caller.
 	 */
-	result = scsi_vpd_inquiry(sdev, vpd_header, page, sizeof(vpd_header));
+	result = scsi_vpd_inquiry(sdev, vpd, page, SCSI_VPD_HEADER_SIZE);
 	if (result < 0)
 		return 0;
 
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 0833b3e6aa6e..bdd0acf7fa3c 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3407,6 +3407,24 @@ static bool sd_validate_opt_xfer_size(struct scsi_disk *sdkp,
 	return true;
 }
 
+static void sd_read_block_zero(struct scsi_disk *sdkp)
+{
+	unsigned int buf_len = sdkp->device->sector_size;
+	char *buffer, cmd[10] = { };
+
+	buffer = kmalloc(buf_len, GFP_KERNEL);
+	if (!buffer)
+		return;
+
+	cmd[0] = READ_10;
+	put_unaligned_be32(0, &cmd[2]); /* Logical block address 0 */
+	put_unaligned_be16(1, &cmd[7]);	/* Transfer 1 logical block */
+
+	scsi_execute_cmd(sdkp->device, cmd, REQ_OP_DRV_IN, buffer, buf_len,
+			 SD_TIMEOUT, sdkp->max_retries, NULL);
+	kfree(buffer);
+}
+
 /**
  *	sd_revalidate_disk - called the first time a new disk is seen,
  *	performs disk spin up, read_capacity, etc.
@@ -3446,7 +3464,13 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	 */
 	if (sdkp->media_present) {
 		sd_read_capacity(sdkp, buffer);
-
+		/*
+		 * Some USB/UAS devices return generic values for mode pages
+		 * until the media has been accessed. Trigger a READ operation
+		 * to force the device to populate mode pages.
+		 */
+		if (sdp->read_before_ms)
+			sd_read_block_zero(sdkp);
 		/*
 		 * set the default to rotational.  All non-rotational devices
 		 * support the block characteristics VPD page, which will
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index ceff1ec13f9e..385180c98be4 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6533,8 +6533,11 @@ static void pqi_map_queues(struct Scsi_Host *shost)
 {
 	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
 
-	blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
+	if (!ctrl_info->disable_managed_interrupts)
+		return blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
 			      ctrl_info->pci_dev, 0);
+	else
+		return blk_mq_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT]);
 }
 
 static inline bool pqi_is_tape_changer_device(struct pqi_scsi_dev *device)
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 41b7489d37ce..ed4fd22eac6e 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -907,12 +907,15 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 
 	return 0;
 fail:
-	if (bio)
-		bio_put(bio);
+	if (bio) {
+		bio_uninit(bio);
+		kfree(bio);
+	}
 	while (req->bio) {
 		bio = req->bio;
 		req->bio = bio->bi_next;
-		bio_put(bio);
+		bio_uninit(bio);
+		kfree(bio);
 	}
 	req->biotail = NULL;
 	return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index d77b25b79ae3..3b89c9d4aa40 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1469,7 +1469,7 @@ static int ufshcd_devfreq_target(struct device *dev,
 	int ret = 0;
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	ktime_t start;
-	bool scale_up, sched_clk_scaling_suspend_work = false;
+	bool scale_up = false, sched_clk_scaling_suspend_work = false;
 	struct list_head *clk_list = &hba->clk_list_head;
 	struct ufs_clk_info *clki;
 	unsigned long irq_flags;
diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index c54e9805da53..12cf9940e5b6 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -179,6 +179,13 @@ static int slave_configure(struct scsi_device *sdev)
 		 */
 		sdev->use_192_bytes_for_3f = 1;
 
+		/*
+		 * Some devices report generic values until the media has been
+		 * accessed. Force a READ(10) prior to querying device
+		 * characteristics.
+		 */
+		sdev->read_before_ms = 1;
+
 		/*
 		 * Some devices don't like MODE SENSE with page=0x3f,
 		 * which is the command used for checking if a device
diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 9707f53cfda9..71ace274761f 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -878,6 +878,13 @@ static int uas_slave_configure(struct scsi_device *sdev)
 	if (devinfo->flags & US_FL_CAPACITY_HEURISTICS)
 		sdev->guess_capacity = 1;
 
+	/*
+	 * Some devices report generic values until the media has been
+	 * accessed. Force a READ(10) prior to querying device
+	 * characteristics.
+	 */
+	sdev->read_before_ms = 1;
+
 	/*
 	 * Some devices don't like MODE SENSE with page=0x3f,
 	 * which is the command used for checking if a device
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 5ec1e71a09de..c38f4fe5e64c 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -100,10 +100,6 @@ struct scsi_vpd {
 	unsigned char	data[];
 };
 
-enum scsi_vpd_parameters {
-	SCSI_VPD_HEADER_SIZE = 4,
-};
-
 struct scsi_device {
 	struct Scsi_Host *host;
 	struct request_queue *request_queue;
@@ -208,6 +204,7 @@ struct scsi_device {
 	unsigned use_10_for_rw:1; /* first try 10-byte read / write */
 	unsigned use_10_for_ms:1; /* first try 10-byte mode sense/select */
 	unsigned set_dbd_for_ms:1; /* Set "DBD" field in mode sense */
+	unsigned read_before_ms:1;	/* perform a READ before MODE SENSE */
 	unsigned no_report_opcodes:1;	/* no REPORT SUPPORTED OPERATION CODES */
 	unsigned no_write_same:1;	/* no WRITE SAME command */
 	unsigned use_16_for_rw:1; /* Use read/write(16) over read/write(10) */


