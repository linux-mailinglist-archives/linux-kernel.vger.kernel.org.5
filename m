Return-Path: <linux-kernel+bounces-133570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C0089A5CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22A1B2263C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D182174EF3;
	Fri,  5 Apr 2024 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Xr4SZ/bs";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="fS1lE3rz"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9971C6A8;
	Fri,  5 Apr 2024 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712350008; cv=none; b=ewVUUa38hkcMyqIkEEB60ZXf8mtMGVvE4NdPgKVgi3FwRZw5KKk+DAeCmAwbT9P2kZZmhpL1OCiGZnlh1zTBGox2tqConGTnqPOF2bX375XCIcoXYMYNBji+atf450/dnaZJ/JjXY0L1wKvW4IufhGritrQrYA7h2Lf9dPVq1lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712350008; c=relaxed/simple;
	bh=uuPCN6wqFUOdJsAQfmaY5KY1dY6RxEX+pul1FeONIfU=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Y5SX2s1TF6o6mMAs/gbj6NjoXtKqt2gab3G94GMLULKitduCJjG6J+8b5bIyg1o8VML5Frio8P/b9NH8O7nLvjhVFVymK0lSPme3sW18rYeFC9frEFsxY6Et1mHPLFJbq4suRglsltox2LQYPYIEhlMhzbb1j8ZwPlHkyvY5ykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Xr4SZ/bs; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=fS1lE3rz; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1712350005;
	bh=uuPCN6wqFUOdJsAQfmaY5KY1dY6RxEX+pul1FeONIfU=;
	h=Message-ID:Subject:From:To:Date:From;
	b=Xr4SZ/bsJAr8F5x8879X59uod0seKQhjGbCptux+O+UXYlJNonJV2rvLz/TyaGgLO
	 z+udZli3cCye3wh85X4Hcq5wJMRXnAjLTw8KBS+Ni41QHLXiTXUj8QZF3EH5XyycWo
	 I0rJYiBZnKq//c8lRCFv17dtIR3FdpfwlCPb2C6Q=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1E72D12810B9;
	Fri,  5 Apr 2024 16:46:45 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id WI1CXITx1cSE; Fri,  5 Apr 2024 16:46:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1712350004;
	bh=uuPCN6wqFUOdJsAQfmaY5KY1dY6RxEX+pul1FeONIfU=;
	h=Message-ID:Subject:From:To:Date:From;
	b=fS1lE3rzRHfZ0FRWrgVdDo2Xl70qTSV4v8TFjiUwThMGhqWbrp6C8viTMFTXZxO+a
	 SgUyoZkkwkFBDcaoB627lxKaBPEmVZ0IEu2xKhiKn2oXMbsybxiL6O/H5/PIibu8Se
	 pOXHezZ6Y9ZlhCDGKXI1rcM7nS18Sy+f8kfyi3l4=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 667C31281086;
	Fri,  5 Apr 2024 16:46:44 -0400 (EDT)
Message-ID: <fa81207eef6f94b71de19640dec34fe6199c90d3.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.9-rc2
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Fri, 05 Apr 2024 16:46:42 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The most important is the libsas fix, which is a problem for DMA to a
kmalloc'd structure too small causing cache line interference.  The
other fixes (all in drivers) are mostly for allocation length fixes,
error leg unwinding, suspend races and a missing retry.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Arnd Bergmann (1):
      scsi: mylex: Fix sysfs buffer lengths

Li Nan (1):
      scsi: sd: Unregister device if device_add_disk() failed in sd_probe()

Peter Wang (2):
      scsi: ufs: core: Fix MCQ mode dev command timeout
      scsi: ufs: core: WLUN suspend dev/link state error recovery

Yihang Li (1):
      scsi: libsas: Align SMP request allocation to ARCH_DMA_MINALIGN


and the diffstat:

 drivers/scsi/libsas/sas_expander.c |  2 +-
 drivers/scsi/myrb.c                | 20 ++++++++++----------
 drivers/scsi/myrs.c                | 24 ++++++++++++------------
 drivers/scsi/sd.c                  |  2 +-
 drivers/ufs/core/ufshcd.c          |  9 +++++++--
 5 files changed, 31 insertions(+), 26 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 5c261005b74e..f6e6db8b8aba 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -135,7 +135,7 @@ static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
 
 static inline void *alloc_smp_req(int size)
 {
-	u8 *p = kzalloc(size, GFP_KERNEL);
+	u8 *p = kzalloc(ALIGN(size, ARCH_DMA_MINALIGN), GFP_KERNEL);
 	if (p)
 		p[0] = SMP_REQUEST;
 	return p;
diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index ca2e932dd9b7..f684eb5e0489 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1775,9 +1775,9 @@ static ssize_t raid_state_show(struct device *dev,
 
 		name = myrb_devstate_name(ldev_info->state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       ldev_info->state);
 	} else {
 		struct myrb_pdev_state *pdev_info = sdev->hostdata;
@@ -1796,9 +1796,9 @@ static ssize_t raid_state_show(struct device *dev,
 		else
 			name = myrb_devstate_name(pdev_info->state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       pdev_info->state);
 	}
 	return ret;
@@ -1886,11 +1886,11 @@ static ssize_t raid_level_show(struct device *dev,
 
 		name = myrb_raidlevel_name(ldev_info->raid_level);
 		if (!name)
-			return snprintf(buf, 32, "Invalid (%02X)\n",
+			return snprintf(buf, 64, "Invalid (%02X)\n",
 					ldev_info->state);
-		return snprintf(buf, 32, "%s\n", name);
+		return snprintf(buf, 64, "%s\n", name);
 	}
-	return snprintf(buf, 32, "Physical Drive\n");
+	return snprintf(buf, 64, "Physical Drive\n");
 }
 static DEVICE_ATTR_RO(raid_level);
 
@@ -1903,15 +1903,15 @@ static ssize_t rebuild_show(struct device *dev,
 	unsigned char status;
 
 	if (sdev->channel < myrb_logical_channel(sdev->host))
-		return snprintf(buf, 32, "physical device - not rebuilding\n");
+		return snprintf(buf, 64, "physical device - not rebuilding\n");
 
 	status = myrb_get_rbld_progress(cb, &rbld_buf);
 
 	if (rbld_buf.ldev_num != sdev->id ||
 	    status != MYRB_STATUS_SUCCESS)
-		return snprintf(buf, 32, "not rebuilding\n");
+		return snprintf(buf, 64, "not rebuilding\n");
 
-	return snprintf(buf, 32, "rebuilding block %u of %u\n",
+	return snprintf(buf, 64, "rebuilding block %u of %u\n",
 			rbld_buf.ldev_size - rbld_buf.blocks_left,
 			rbld_buf.ldev_size);
 }
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index a1eec65a9713..e824be9d9bbb 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -947,9 +947,9 @@ static ssize_t raid_state_show(struct device *dev,
 
 		name = myrs_devstate_name(ldev_info->dev_state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       ldev_info->dev_state);
 	} else {
 		struct myrs_pdev_info *pdev_info;
@@ -958,9 +958,9 @@ static ssize_t raid_state_show(struct device *dev,
 		pdev_info = sdev->hostdata;
 		name = myrs_devstate_name(pdev_info->dev_state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       pdev_info->dev_state);
 	}
 	return ret;
@@ -1066,13 +1066,13 @@ static ssize_t raid_level_show(struct device *dev,
 		ldev_info = sdev->hostdata;
 		name = myrs_raid_level_name(ldev_info->raid_level);
 		if (!name)
-			return snprintf(buf, 32, "Invalid (%02X)\n",
+			return snprintf(buf, 64, "Invalid (%02X)\n",
 					ldev_info->dev_state);
 
 	} else
 		name = myrs_raid_level_name(MYRS_RAID_PHYSICAL);
 
-	return snprintf(buf, 32, "%s\n", name);
+	return snprintf(buf, 64, "%s\n", name);
 }
 static DEVICE_ATTR_RO(raid_level);
 
@@ -1086,7 +1086,7 @@ static ssize_t rebuild_show(struct device *dev,
 	unsigned char status;
 
 	if (sdev->channel < cs->ctlr_info->physchan_present)
-		return snprintf(buf, 32, "physical device - not rebuilding\n");
+		return snprintf(buf, 64, "physical device - not rebuilding\n");
 
 	ldev_info = sdev->hostdata;
 	ldev_num = ldev_info->ldev_num;
@@ -1098,11 +1098,11 @@ static ssize_t rebuild_show(struct device *dev,
 		return -EIO;
 	}
 	if (ldev_info->rbld_active) {
-		return snprintf(buf, 32, "rebuilding block %zu of %zu\n",
+		return snprintf(buf, 64, "rebuilding block %zu of %zu\n",
 				(size_t)ldev_info->rbld_lba,
 				(size_t)ldev_info->cfg_devsize);
 	} else
-		return snprintf(buf, 32, "not rebuilding\n");
+		return snprintf(buf, 64, "not rebuilding\n");
 }
 
 static ssize_t rebuild_store(struct device *dev,
@@ -1190,7 +1190,7 @@ static ssize_t consistency_check_show(struct device *dev,
 	unsigned short ldev_num;
 
 	if (sdev->channel < cs->ctlr_info->physchan_present)
-		return snprintf(buf, 32, "physical device - not checking\n");
+		return snprintf(buf, 64, "physical device - not checking\n");
 
 	ldev_info = sdev->hostdata;
 	if (!ldev_info)
@@ -1198,11 +1198,11 @@ static ssize_t consistency_check_show(struct device *dev,
 	ldev_num = ldev_info->ldev_num;
 	myrs_get_ldev_info(cs, ldev_num, ldev_info);
 	if (ldev_info->cc_active)
-		return snprintf(buf, 32, "checking block %zu of %zu\n",
+		return snprintf(buf, 64, "checking block %zu of %zu\n",
 				(size_t)ldev_info->cc_lba,
 				(size_t)ldev_info->cfg_devsize);
 	else
-		return snprintf(buf, 32, "not checking\n");
+		return snprintf(buf, 64, "not checking\n");
 }
 
 static ssize_t consistency_check_store(struct device *dev,
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 3cf898670290..58fdf679341d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3920,7 +3920,7 @@ static int sd_probe(struct device *dev)
 
 	error = device_add_disk(dev, gd, NULL);
 	if (error) {
-		put_device(&sdkp->disk_dev);
+		device_unregister(&sdkp->disk_dev);
 		put_disk(gd);
 		goto out;
 	}
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index e30fd125988d..a0f8e930167d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3217,7 +3217,9 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 
 		/* MCQ mode */
 		if (is_mcq_enabled(hba)) {
-			err = ufshcd_clear_cmd(hba, lrbp->task_tag);
+			/* successfully cleared the command, retry if needed */
+			if (ufshcd_clear_cmd(hba, lrbp->task_tag) == 0)
+				err = -EAGAIN;
 			hba->dev_cmd.complete = NULL;
 			return err;
 		}
@@ -9791,7 +9793,10 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 
 	/* UFS device & link must be active before we enter in this function */
 	if (!ufshcd_is_ufs_dev_active(hba) || !ufshcd_is_link_active(hba)) {
-		ret = -EINVAL;
+		/*  Wait err handler finish or trigger err recovery */
+		if (!ufshcd_eh_in_progress(hba))
+			ufshcd_force_error_recovery(hba);
+		ret = -EBUSY;
 		goto enable_scaling;
 	}
 


