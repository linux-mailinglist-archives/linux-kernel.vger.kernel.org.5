Return-Path: <linux-kernel+bounces-107088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8043C87F76F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130A11F23BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AC07C6C1;
	Tue, 19 Mar 2024 06:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="LtXaYeBB"
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64F4F895;
	Tue, 19 Mar 2024 06:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829954; cv=none; b=i+J3RvWoweo+fYwT8qpoMpoyckDQHX2iHyRHodweW6ZhxtU3ri8eVb3sqYsP9cPwYROPmi6TJ1vEpusnCo/WcYZhQWgxmCsOSc8liXqFJs1d6wvK47RrEFntxK4tXxyqbxCtGESHG/2ufcZ8gh69B+gFRo2PUfPolAk9X3x/jtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829954; c=relaxed/simple;
	bh=l4EGtJOYU2BZ1+ETyz/jemY9d6AOB2fByG/+zecyHN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5gXrJ9yeuqsyGQ236gBvdYf6WxPrPv4HJwJWbG+QPJp/NBIGe6sRyVFWEg0mEnefQjEWl4mPUZLTppBv30VhlRJgrSNZEYuBUvtDfY2F6nYv0WVKiVhB5U89H2n/A7bLsAFI6r5WvQfvofN1ELZEirOJ7Y/tABjMwI/UjV8EKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=LtXaYeBB; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829952; x=1742365952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l4EGtJOYU2BZ1+ETyz/jemY9d6AOB2fByG/+zecyHN4=;
  b=LtXaYeBBGfTQhRmThKLcGNo9AmfBvh+iY2ZhX6uHDxhXsbEKGhBgKBVw
   m3aNVAgnwL/Sy1QompTwsBWqhEEnXd2Fus+zscj3S6Udpx0cbuhbXypQE
   222qDoO7z9DSa9R2PLtrpc8eVkiXlmMJPtEuDOS4TEnnjpUfG8QBPiRD+
   B74TRQexIAbqv1hAgoFDO++w72pWiLG4Dc4TolQafk7rC+XBY+jJkaCLr
   viybmxM3FRQLu/UvHhdsT1L2C87xC0J/FLtcDBGUc6e0YJpQ0HWkFcFIT
   1NZPbIvjmjhc9LkXFe+H3OP3OOl0/bPFVcVWQflc23t63uR1Utok+40ap
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="152728480"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="152728480"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:30 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 318E714121D;
	Tue, 19 Mar 2024 15:32:27 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 54242B3C92;
	Tue, 19 Mar 2024 15:32:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E5A56228822;
	Tue, 19 Mar 2024 15:32:25 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 6F5101A006D;
	Tue, 19 Mar 2024 14:32:25 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Hannes Reinecke <hare@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 16/25] scsi: myrb,myrs: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:23 +0800
Message-Id: <20240319063132.1588443-16-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240319063132.1588443-1-lizhijian@fujitsu.com>
References: <20240319063132.1588443-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28260.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28260.005
X-TMASE-Result: 10--4.285300-10.000000
X-TMASE-MatchedRID: GSiycdxM5vsbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/0swHSFcVJ6F31Af36gMaTQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/wmWvXEqQTm5wLkNMQzGl5B+Kr
	WCPbERPznpYPqS6jzxvFpiUsjOqVtpORapdxWmu2e0R3NAF/choR62RNvkvOv96X4NHK9fCPcwy
	VYGZr7I9kNGk0VfW+w9dnB5Mf9AazWs2YGWPbxrSs47mbT7SAQEa8g1x8eqF/xgxLWmrr87e9QK
	gtmmT7G4fRLMfglY9qIARNsBFTF+najGxrJsU4OeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8hxKpv
	EGAbTDtcfz+9wuQ+oOHlFnapd16lRoZ4ddQWWr+rnUHJcqmwEPrsXjQEwF8woVeFxQ9MsFb5OWK
	0WrsAiIkqNhtxgNbTw7XGexxnxSluMG6V02+QySir3tZId0WN+6klq53W5kJ9Gzq4huQVX
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() and scnprintf() will be converted as well if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: Hannes Reinecke <hare@kernel.org>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/myrb.c | 38 ++++++++++----------
 drivers/scsi/myrs.c | 88 ++++++++++++++++++++++-----------------------
 2 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index ca2e932dd9b7..06a5e6fb9f99 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1767,7 +1767,7 @@ static ssize_t raid_state_show(struct device *dev,
 	int ret;
 
 	if (!sdev->hostdata)
-		return snprintf(buf, 16, "Unknown\n");
+		return sysfs_emit(buf, "Unknown\n");
 
 	if (sdev->channel == myrb_logical_channel(sdev->host)) {
 		struct myrb_ldev_info *ldev_info = sdev->hostdata;
@@ -1775,10 +1775,10 @@ static ssize_t raid_state_show(struct device *dev,
 
 		name = myrb_devstate_name(ldev_info->state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = sysfs_emit(buf, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
-				       ldev_info->state);
+			ret = sysfs_emit(buf, "Invalid (%02X)\n",
+					 ldev_info->state);
 	} else {
 		struct myrb_pdev_state *pdev_info = sdev->hostdata;
 		unsigned short status;
@@ -1796,10 +1796,10 @@ static ssize_t raid_state_show(struct device *dev,
 		else
 			name = myrb_devstate_name(pdev_info->state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = sysfs_emit(buf, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
-				       pdev_info->state);
+			ret = sysfs_emit(buf, "Invalid (%02X)\n",
+					 pdev_info->state);
 	}
 	return ret;
 }
@@ -1886,11 +1886,11 @@ static ssize_t raid_level_show(struct device *dev,
 
 		name = myrb_raidlevel_name(ldev_info->raid_level);
 		if (!name)
-			return snprintf(buf, 32, "Invalid (%02X)\n",
-					ldev_info->state);
-		return snprintf(buf, 32, "%s\n", name);
+			return sysfs_emit(buf, "Invalid (%02X)\n",
+					  ldev_info->state);
+		return sysfs_emit(buf, "%s\n", name);
 	}
-	return snprintf(buf, 32, "Physical Drive\n");
+	return sysfs_emit(buf, "Physical Drive\n");
 }
 static DEVICE_ATTR_RO(raid_level);
 
@@ -1903,17 +1903,17 @@ static ssize_t rebuild_show(struct device *dev,
 	unsigned char status;
 
 	if (sdev->channel < myrb_logical_channel(sdev->host))
-		return snprintf(buf, 32, "physical device - not rebuilding\n");
+		return sysfs_emit(buf, "physical device - not rebuilding\n");
 
 	status = myrb_get_rbld_progress(cb, &rbld_buf);
 
 	if (rbld_buf.ldev_num != sdev->id ||
 	    status != MYRB_STATUS_SUCCESS)
-		return snprintf(buf, 32, "not rebuilding\n");
+		return sysfs_emit(buf, "not rebuilding\n");
 
-	return snprintf(buf, 32, "rebuilding block %u of %u\n",
-			rbld_buf.ldev_size - rbld_buf.blocks_left,
-			rbld_buf.ldev_size);
+	return sysfs_emit(buf, "rebuilding block %u of %u\n",
+			  rbld_buf.ldev_size - rbld_buf.blocks_left,
+			  rbld_buf.ldev_size);
 }
 
 static ssize_t rebuild_store(struct device *dev,
@@ -2140,7 +2140,7 @@ static ssize_t ctlr_num_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrb_hba *cb = shost_priv(shost);
 
-	return snprintf(buf, 20, "%u\n", cb->ctlr_num);
+	return sysfs_emit(buf, "%u\n", cb->ctlr_num);
 }
 static DEVICE_ATTR_RO(ctlr_num);
 
@@ -2150,7 +2150,7 @@ static ssize_t firmware_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrb_hba *cb = shost_priv(shost);
 
-	return snprintf(buf, 16, "%s\n", cb->fw_version);
+	return sysfs_emit(buf, "%s\n", cb->fw_version);
 }
 static DEVICE_ATTR_RO(firmware);
 
@@ -2160,7 +2160,7 @@ static ssize_t model_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrb_hba *cb = shost_priv(shost);
 
-	return snprintf(buf, 16, "%s\n", cb->model_name);
+	return sysfs_emit(buf, "%s\n", cb->model_name);
 }
 static DEVICE_ATTR_RO(model);
 
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index a1eec65a9713..5dda3b669ec1 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -939,7 +939,7 @@ static ssize_t raid_state_show(struct device *dev,
 	int ret;
 
 	if (!sdev->hostdata)
-		return snprintf(buf, 16, "Unknown\n");
+		return sysfs_emit(buf, "Unknown\n");
 
 	if (sdev->channel >= cs->ctlr_info->physchan_present) {
 		struct myrs_ldev_info *ldev_info = sdev->hostdata;
@@ -947,10 +947,10 @@ static ssize_t raid_state_show(struct device *dev,
 
 		name = myrs_devstate_name(ldev_info->dev_state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = sysfs_emit(buf, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
-				       ldev_info->dev_state);
+			ret = sysfs_emit(buf, "Invalid (%02X)\n",
+					 ldev_info->dev_state);
 	} else {
 		struct myrs_pdev_info *pdev_info;
 		const char *name;
@@ -958,10 +958,10 @@ static ssize_t raid_state_show(struct device *dev,
 		pdev_info = sdev->hostdata;
 		name = myrs_devstate_name(pdev_info->dev_state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = sysfs_emit(buf, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
-				       pdev_info->dev_state);
+			ret = sysfs_emit(buf, "Invalid (%02X)\n",
+					 pdev_info->dev_state);
 	}
 	return ret;
 }
@@ -1058,7 +1058,7 @@ static ssize_t raid_level_show(struct device *dev,
 	const char *name = NULL;
 
 	if (!sdev->hostdata)
-		return snprintf(buf, 16, "Unknown\n");
+		return sysfs_emit(buf, "Unknown\n");
 
 	if (sdev->channel >= cs->ctlr_info->physchan_present) {
 		struct myrs_ldev_info *ldev_info;
@@ -1066,13 +1066,13 @@ static ssize_t raid_level_show(struct device *dev,
 		ldev_info = sdev->hostdata;
 		name = myrs_raid_level_name(ldev_info->raid_level);
 		if (!name)
-			return snprintf(buf, 32, "Invalid (%02X)\n",
-					ldev_info->dev_state);
+			return sysfs_emit(buf, "Invalid (%02X)\n",
+					  ldev_info->dev_state);
 
 	} else
 		name = myrs_raid_level_name(MYRS_RAID_PHYSICAL);
 
-	return snprintf(buf, 32, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 static DEVICE_ATTR_RO(raid_level);
 
@@ -1086,7 +1086,7 @@ static ssize_t rebuild_show(struct device *dev,
 	unsigned char status;
 
 	if (sdev->channel < cs->ctlr_info->physchan_present)
-		return snprintf(buf, 32, "physical device - not rebuilding\n");
+		return sysfs_emit(buf, "physical device - not rebuilding\n");
 
 	ldev_info = sdev->hostdata;
 	ldev_num = ldev_info->ldev_num;
@@ -1098,11 +1098,11 @@ static ssize_t rebuild_show(struct device *dev,
 		return -EIO;
 	}
 	if (ldev_info->rbld_active) {
-		return snprintf(buf, 32, "rebuilding block %zu of %zu\n",
-				(size_t)ldev_info->rbld_lba,
-				(size_t)ldev_info->cfg_devsize);
+		return sysfs_emit(buf, "rebuilding block %zu of %zu\n",
+				  (size_t)ldev_info->rbld_lba,
+				  (size_t)ldev_info->cfg_devsize);
 	} else
-		return snprintf(buf, 32, "not rebuilding\n");
+		return sysfs_emit(buf, "not rebuilding\n");
 }
 
 static ssize_t rebuild_store(struct device *dev,
@@ -1190,7 +1190,7 @@ static ssize_t consistency_check_show(struct device *dev,
 	unsigned short ldev_num;
 
 	if (sdev->channel < cs->ctlr_info->physchan_present)
-		return snprintf(buf, 32, "physical device - not checking\n");
+		return sysfs_emit(buf, "physical device - not checking\n");
 
 	ldev_info = sdev->hostdata;
 	if (!ldev_info)
@@ -1198,11 +1198,11 @@ static ssize_t consistency_check_show(struct device *dev,
 	ldev_num = ldev_info->ldev_num;
 	myrs_get_ldev_info(cs, ldev_num, ldev_info);
 	if (ldev_info->cc_active)
-		return snprintf(buf, 32, "checking block %zu of %zu\n",
-				(size_t)ldev_info->cc_lba,
-				(size_t)ldev_info->cfg_devsize);
+		return sysfs_emit(buf, "checking block %zu of %zu\n",
+				  (size_t)ldev_info->cc_lba,
+				  (size_t)ldev_info->cfg_devsize);
 	else
-		return snprintf(buf, 32, "not checking\n");
+		return sysfs_emit(buf, "not checking\n");
 }
 
 static ssize_t consistency_check_store(struct device *dev,
@@ -1303,7 +1303,7 @@ static ssize_t serial_show(struct device *dev,
 
 	memcpy(serial, cs->ctlr_info->serial_number, 16);
 	serial[16] = '\0';
-	return snprintf(buf, 16, "%s\n", serial);
+	return sysfs_emit(buf, "%s\n", serial);
 }
 static DEVICE_ATTR_RO(serial);
 
@@ -1313,7 +1313,7 @@ static ssize_t ctlr_num_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);
 
-	return snprintf(buf, 20, "%d\n", cs->host->host_no);
+	return sysfs_emit(buf, "%d\n", cs->host->host_no);
 }
 static DEVICE_ATTR_RO(ctlr_num);
 
@@ -1361,22 +1361,22 @@ static ssize_t processor_show(struct device *dev,
 		}
 	}
 	if (first_processor && second_processor)
-		ret = snprintf(buf, 64, "1: %s (%s, %d cpus)\n"
-			       "2: %s (%s, %d cpus)\n",
-			       info->cpu[0].cpu_name,
-			       first_processor, info->cpu[0].cpu_count,
-			       info->cpu[1].cpu_name,
-			       second_processor, info->cpu[1].cpu_count);
+		ret = sysfs_emit(buf, "1: %s (%s, %d cpus)\n"
+				 "2: %s (%s, %d cpus)\n",
+				 info->cpu[0].cpu_name,
+				 first_processor, info->cpu[0].cpu_count,
+				 info->cpu[1].cpu_name,
+				 second_processor, info->cpu[1].cpu_count);
 	else if (first_processor && !second_processor)
-		ret = snprintf(buf, 64, "1: %s (%s, %d cpus)\n2: absent\n",
-			       info->cpu[0].cpu_name,
-			       first_processor, info->cpu[0].cpu_count);
+		ret = sysfs_emit(buf, "1: %s (%s, %d cpus)\n2: absent\n",
+				 info->cpu[0].cpu_name,
+				 first_processor, info->cpu[0].cpu_count);
 	else if (!first_processor && second_processor)
-		ret = snprintf(buf, 64, "1: absent\n2: %s (%s, %d cpus)\n",
-			       info->cpu[1].cpu_name,
-			       second_processor, info->cpu[1].cpu_count);
+		ret = sysfs_emit(buf, "1: absent\n2: %s (%s, %d cpus)\n",
+				 info->cpu[1].cpu_name,
+				 second_processor, info->cpu[1].cpu_count);
 	else
-		ret = snprintf(buf, 64, "1: absent\n2: absent\n");
+		ret = sysfs_emit(buf, "1: absent\n2: absent\n");
 
 	return ret;
 }
@@ -1388,7 +1388,7 @@ static ssize_t model_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);
 
-	return snprintf(buf, 28, "%s\n", cs->model_name);
+	return sysfs_emit(buf, "%s\n", cs->model_name);
 }
 static DEVICE_ATTR_RO(model);
 
@@ -1398,7 +1398,7 @@ static ssize_t ctlr_type_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);
 
-	return snprintf(buf, 4, "%d\n", cs->ctlr_info->ctlr_type);
+	return sysfs_emit(buf, "%d\n", cs->ctlr_info->ctlr_type);
 }
 static DEVICE_ATTR_RO(ctlr_type);
 
@@ -1408,7 +1408,7 @@ static ssize_t cache_size_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);
 
-	return snprintf(buf, 8, "%d MB\n", cs->ctlr_info->cache_size_mb);
+	return sysfs_emit(buf, "%d MB\n", cs->ctlr_info->cache_size_mb);
 }
 static DEVICE_ATTR_RO(cache_size);
 
@@ -1418,10 +1418,10 @@ static ssize_t firmware_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);
 
-	return snprintf(buf, 16, "%d.%02d-%02d\n",
-			cs->ctlr_info->fw_major_version,
-			cs->ctlr_info->fw_minor_version,
-			cs->ctlr_info->fw_turn_number);
+	return sysfs_emit(buf, "%d.%02d-%02d\n",
+			  cs->ctlr_info->fw_major_version,
+			  cs->ctlr_info->fw_minor_version,
+			  cs->ctlr_info->fw_turn_number);
 }
 static DEVICE_ATTR_RO(firmware);
 
@@ -1488,7 +1488,7 @@ static ssize_t disable_enclosure_messages_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);
 
-	return snprintf(buf, 3, "%d\n", cs->disable_enc_msg);
+	return sysfs_emit(buf, "%d\n", cs->disable_enc_msg);
 }
 
 static ssize_t disable_enclosure_messages_store(struct device *dev,
-- 
2.29.2


