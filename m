Return-Path: <linux-kernel+bounces-107097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C2187F782
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8895B1F24F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBBE7F469;
	Tue, 19 Mar 2024 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FPJwic9B"
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1073254777;
	Tue, 19 Mar 2024 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829958; cv=none; b=KUjgvV0/mTdCrRiFkeWH3+SPwCyzra1dEfsE+cACZCDNAgyO6WF3tNL0/+ce80f0R7lYk2aWvNnrDKFxDZMADhe7g+MMPuD+uNrImCS2Gpmvn90rPJ5YwHar/NCkPS3Rqqao4rinqnZn7+5Esx/gd94c9sg5D+UgqJsw7l9OeTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829958; c=relaxed/simple;
	bh=VFKpWK2fYqcVIskCECWYXfbxPxDq4I3pylCBnbs+BU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvJGIYvCvH7ZNv/fT6Ja992D8u/LYhR01EVY4hNoczK8jceM5HxvETgBf1ZDWa5V7sp6No5xIywXpnSuK4IhzjL3uCLXq2G5rXAv2Vfu6YsiFR8zTKlHuBnjhSb1ldbd91iAoiyVAQKrr15lCmKSGTBUxe/1nnsR/bwAaeLhi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FPJwic9B; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829954; x=1742365954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VFKpWK2fYqcVIskCECWYXfbxPxDq4I3pylCBnbs+BU4=;
  b=FPJwic9BCK0qwWvZ/KeGMkq3bwRVcAxWrmFI+bGEnKuUwCKsThzSBvGL
   wjc9x5cutonJp0yUDIT8TUpkjlsjL8Vxb/KRJpctxWOVZ4zY6dGhyAf/3
   gzPfPGudS/mhCv5dIxkJ6k1HnZZQ0sUqH6EtzMP3tG75aTL8skx+lRrqH
   eOnjbZbevaIdBiHx9FUsafDT6pW92OEjUDw+CFrWJQvSpm814mYg3j5Gu
   /0+cKHWM3N2UM0ExUUYOjFn033j9gsus8Sx3krD+g6UpWa74eSgN+Zc9T
   75/uOjxgFiuWhD/EhhYiW3kCoaOUTNO74P91h9KFqXT68rFApUSsRmmjo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="132006243"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="132006243"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:29 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 51439FBD95;
	Tue, 19 Mar 2024 15:32:28 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8EA472970B;
	Tue, 19 Mar 2024 15:32:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 22DE1227A9F;
	Tue, 19 Mar 2024 15:32:27 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id ADFC71A006B;
	Tue, 19 Mar 2024 14:32:26 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 20/25] scsi: core: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:27 +0800
Message-Id: <20240319063132.1588443-20-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--15.169400-10.000000
X-TMASE-MatchedRID: IVNJzyZeXh4bO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSArq
	oIZrVn1xKRMiWrlL6xlEFre7kn4QwEQ6/NLxw21ErOO5m0+0gEWQ3R4k5PTnB0Vj5gY98rDMs0A
	8Och09Bk2rNDhoFVtn0SV7CRnVQROKOHNhoftDjRcGHEV0WBxCvOXyw2JYKUpsoi2XrUn/Jn6Kd
	MrRsL14qtq5d3cxkNTNpc4k18MbtAIRXVZcClv+HlqEBvZ4TZNZ/JLwcGkQZ3FvoQlwXE6U=
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

CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/scsi_sysfs.c | 69 ++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 49dd34426d5e..2e9d93d0e770 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -163,7 +163,7 @@ show_##name (struct device *dev, struct device_attribute *attr, 	\
 	     char *buf)							\
 {									\
 	struct Scsi_Host *shost = class_to_shost(dev);			\
-	return snprintf (buf, 20, format_string, shost->field);		\
+	return sysfs_emit(buf, format_string, shost->field);		\
 }
 
 /*
@@ -228,7 +228,7 @@ show_shost_state(struct device *dev, struct device_attribute *attr, char *buf)
 	if (!name)
 		return -EINVAL;
 
-	return snprintf(buf, 20, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 /* DEVICE_ATTR(state) clashes with dev_attr_state for sdev */
@@ -241,12 +241,13 @@ show_shost_mode(unsigned int mode, char *buf)
 	ssize_t len = 0;
 
 	if (mode & MODE_INITIATOR)
-		len = sprintf(buf, "%s", "Initiator");
+		len = sysfs_emit(buf, "%s", "Initiator");
 
 	if (mode & MODE_TARGET)
-		len += sprintf(buf + len, "%s%s", len ? ", " : "", "Target");
+		len += sysfs_emit_at(buf, len, "%s%s",
+				     len ? ", " : "", "Target");
 
-	len += sprintf(buf + len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 
 	return len;
 }
@@ -274,7 +275,7 @@ show_shost_active_mode(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 
 	if (shost->active_mode == MODE_UNKNOWN)
-		return snprintf(buf, 20, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");
 	else
 		return show_shost_mode(shost->active_mode, buf);
 }
@@ -324,8 +325,8 @@ show_shost_eh_deadline(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 
 	if (shost->eh_deadline == -1)
-		return snprintf(buf, strlen("off") + 2, "off\n");
-	return sprintf(buf, "%u\n", shost->eh_deadline / HZ);
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%u\n", shost->eh_deadline / HZ);
 }
 
 static ssize_t
@@ -382,14 +383,14 @@ static ssize_t
 show_host_busy(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
-	return snprintf(buf, 20, "%d\n", scsi_host_busy(shost));
+	return sysfs_emit(buf, "%d\n", scsi_host_busy(shost));
 }
 static DEVICE_ATTR(host_busy, S_IRUGO, show_host_busy, NULL);
 
 static ssize_t
 show_use_blk_mq(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "1\n");
+	return sysfs_emit(buf, "1\n");
 }
 static DEVICE_ATTR(use_blk_mq, S_IRUGO, show_use_blk_mq, NULL);
 
@@ -399,7 +400,7 @@ show_nr_hw_queues(struct device *dev, struct device_attribute *attr, char *buf)
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct blk_mq_tag_set *tag_set = &shost->tag_set;
 
-	return snprintf(buf, 20, "%d\n", tag_set->nr_hw_queues);
+	return sysfs_emit(buf, "%d\n", tag_set->nr_hw_queues);
 }
 static DEVICE_ATTR(nr_hw_queues, S_IRUGO, show_nr_hw_queues, NULL);
 
@@ -589,7 +590,7 @@ sdev_show_##field (struct device *dev, struct device_attribute *attr,	\
 {									\
 	struct scsi_device *sdev;					\
 	sdev = to_scsi_device(dev);					\
-	return snprintf (buf, 20, format_string, sdev->field);		\
+	return sysfs_emit(buf, format_string, sdev->field);		\
 }									\
 
 /*
@@ -677,7 +678,7 @@ sdev_show_device_busy(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%d\n", scsi_device_busy(sdev));
+	return sysfs_emit(buf, "%d\n", scsi_device_busy(sdev));
 }
 static DEVICE_ATTR(device_busy, S_IRUGO, sdev_show_device_busy, NULL);
 
@@ -686,7 +687,7 @@ sdev_show_device_blocked(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%d\n", atomic_read(&sdev->device_blocked));
+	return sysfs_emit(buf, "%d\n", atomic_read(&sdev->device_blocked));
 }
 static DEVICE_ATTR(device_blocked, S_IRUGO, sdev_show_device_blocked, NULL);
 
@@ -698,7 +699,7 @@ sdev_show_timeout (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%d\n", sdev->request_queue->rq_timeout / HZ);
+	return sysfs_emit(buf, "%d\n", sdev->request_queue->rq_timeout / HZ);
 }
 
 static ssize_t
@@ -719,7 +720,7 @@ sdev_show_eh_timeout(struct device *dev, struct device_attribute *attr, char *bu
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%u\n", sdev->eh_timeout / HZ);
+	return sysfs_emit(buf, "%u\n", sdev->eh_timeout / HZ);
 }
 
 static ssize_t
@@ -855,7 +856,7 @@ show_state_field(struct device *dev, struct device_attribute *attr, char *buf)
 	if (!name)
 		return -EINVAL;
 
-	return snprintf(buf, 20, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 static DEVICE_ATTR(state, S_IRUGO | S_IWUSR, show_state_field, store_state_field);
@@ -870,7 +871,7 @@ show_queue_type_field(struct device *dev, struct device_attribute *attr,
 	if (sdev->simple_tags)
 		name = "simple";
 
-	return snprintf(buf, 20, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 static ssize_t
@@ -950,7 +951,7 @@ static ssize_t
 show_iostat_counterbits(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
-	return snprintf(buf, 20, "%d\n", (int)sizeof(atomic_t) * 8);
+	return sysfs_emit(buf, "%d\n", (int)sizeof(atomic_t) * 8);
 }
 
 static DEVICE_ATTR(iocounterbits, S_IRUGO, show_iostat_counterbits, NULL);
@@ -962,7 +963,7 @@ show_iostat_##field(struct device *dev, struct device_attribute *attr,	\
 {									\
 	struct scsi_device *sdev = to_scsi_device(dev);			\
 	unsigned long long count = atomic_read(&sdev->field);		\
-	return snprintf(buf, 20, "0x%llx\n", count);			\
+	return sysfs_emit(buf, "0x%llx\n", count);			\
 }									\
 static DEVICE_ATTR(field, S_IRUGO, show_iostat_##field, NULL)
 
@@ -976,7 +977,7 @@ sdev_show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf (buf, 20, SCSI_DEVICE_MODALIAS_FMT "\n", sdev->type);
+	return sysfs_emit(buf, SCSI_DEVICE_MODALIAS_FMT "\n", sdev->type);
 }
 static DEVICE_ATTR(modalias, S_IRUGO, sdev_show_modalias, NULL);
 
@@ -987,7 +988,7 @@ sdev_show_evt_##name(struct device *dev, struct device_attribute *attr,	\
 {									\
 	struct scsi_device *sdev = to_scsi_device(dev);			\
 	int val = test_bit(SDEV_EVT_##Cap_name, sdev->supported_events);\
-	return snprintf(buf, 20, "%d\n", val);				\
+	return sysfs_emit(buf, "%d\n", val);				\
 }
 
 #define DECLARE_EVT_STORE(name, Cap_name)				\
@@ -1089,14 +1090,14 @@ sdev_show_blacklist(struct device *dev, struct device_attribute *attr,
 			name = sdev_bflags_name[i];
 
 		if (name)
-			len += scnprintf(buf + len, PAGE_SIZE - len,
-					 "%s%s", len ? " " : "", name);
+			len += sysfs_emit_at(buf, len,
+					     "%s%s", len ? " " : "", name);
 		else
-			len += scnprintf(buf + len, PAGE_SIZE - len,
-					 "%sINVALID_BIT(%d)", len ? " " : "", i);
+			len += sysfs_emit_at(buf, len,
+					"%sINVALID_BIT(%d)", len ? " " : "", i);
 	}
 	if (len)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
+		len += sysfs_emit_at(buf, len, "\n");
 	return len;
 }
 static DEVICE_ATTR(blacklist, S_IRUGO, sdev_show_blacklist, NULL);
@@ -1109,9 +1110,9 @@ sdev_show_dh_state(struct device *dev, struct device_attribute *attr,
 	struct scsi_device *sdev = to_scsi_device(dev);
 
 	if (!sdev->handler)
-		return snprintf(buf, 20, "detached\n");
+		return sysfs_emit(buf, "detached\n");
 
-	return snprintf(buf, 20, "%s\n", sdev->handler->name);
+	return sysfs_emit(buf, "%s\n", sdev->handler->name);
 }
 
 static ssize_t
@@ -1169,7 +1170,7 @@ sdev_show_access_state(struct device *dev,
 	access_state = (sdev->access_state & SCSI_ACCESS_STATE_MASK);
 	access_state_name = scsi_access_state_name(access_state);
 
-	return sprintf(buf, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 		       access_state_name ? access_state_name : "unknown");
 }
 static DEVICE_ATTR(access_state, S_IRUGO, sdev_show_access_state, NULL);
@@ -1185,9 +1186,9 @@ sdev_show_preferred_path(struct device *dev,
 		return -EINVAL;
 
 	if (sdev->access_state & SCSI_ACCESS_STATE_PREFERRED)
-		return sprintf(buf, "1\n");
+		return sysfs_emit(buf, "1\n");
 	else
-		return sprintf(buf, "0\n");
+		return sysfs_emit(buf, "0\n");
 }
 static DEVICE_ATTR(preferred_path, S_IRUGO, sdev_show_preferred_path, NULL);
 #endif
@@ -1199,8 +1200,8 @@ sdev_show_queue_ramp_up_period(struct device *dev,
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%u\n",
-			jiffies_to_msecs(sdev->queue_ramp_up_period));
+	return sysfs_emit(buf, "%u\n",
+			  jiffies_to_msecs(sdev->queue_ramp_up_period));
 }
 
 static ssize_t
-- 
2.29.2


