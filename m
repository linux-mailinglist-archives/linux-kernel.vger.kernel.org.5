Return-Path: <linux-kernel+bounces-26985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8056482E8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CE61F2396E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C991CD07;
	Tue, 16 Jan 2024 04:52:38 +0000 (UTC)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F30D1B807;
	Tue, 16 Jan 2024 04:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="125556478"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="125556478"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:22 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1C695D9D92;
	Tue, 16 Jan 2024 13:52:20 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4E772D8AD7;
	Tue, 16 Jan 2024 13:52:19 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E598C6B4C6;
	Tue, 16 Jan 2024 13:52:18 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 701651A0160;
	Tue, 16 Jan 2024 12:52:18 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 17/42] drivers/scsi/aacraid: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:26 +0800
Message-Id: <20240116045151.3940401-15-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240116045151.3940401-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.005
X-TMASE-Result: 10--16.275400-10.000000
X-TMASE-MatchedRID: ebEStOsB1eE4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4beNXXhVTPU8LdBFrfY9r2n0swHSFcVJ6MC5DTEMxpeQfiq
	1gj2xET8qqtDuUtwyfKD8el0BdzuozYigC8AbwLLfSQNpZkETVAv/9UzFeXIT/GDEtaauvzvT6Z
	/7gOjQOMgfSosmpqsABlShLAm3Hw5ccQ8eam5EfRRFJJyf5BJeov6oNokdHvT6C0ePs7A07QKmA
	RN5PTKc
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/aacraid/linit.c:1299:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/aacraid/linit.c:1325:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/aacraid/linit.c:1332:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/aacraid/linit.c:561:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/aacraid/linit.c:588:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/aacraid/linit.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 68f4dbcfff49..f534f5d985f1 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -558,11 +558,10 @@ static ssize_t aac_show_raid_level(struct device *dev, struct device_attribute *
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct aac_dev *aac = (struct aac_dev *)(sdev->host->hostdata);
 	if (sdev_channel(sdev) != CONTAINER_CHANNEL)
-		return snprintf(buf, PAGE_SIZE, sdev->no_uld_attach
-		  ? "Hidden\n" :
+		return sysfs_emit(buf, sdev->no_uld_attacha ? "Hidden\n" :
 		  ((aac->jbod && (sdev->type == TYPE_DISK)) ? "JBOD\n" : ""));
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-	  get_container_type(aac->fsa_dev[sdev_id(sdev)].type));
+	return sysfs_emit(buf, "%s\n",
+			  get_container_type(aac->fsa_dev[sdev_id(sdev)].type));
 }
 
 static struct device_attribute aac_raid_level_attr = {
@@ -585,7 +584,7 @@ static ssize_t aac_show_unique_id(struct device *dev,
 	if (sdev_channel(sdev) == CONTAINER_CHANNEL)
 		memcpy(sn, aac->fsa_dev[sdev_id(sdev)].identifier, sizeof(sn));
 
-	return snprintf(buf, 16 * 2 + 2,
+	return sysfs_emit(buf,
 		"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X\n",
 		sn[0], sn[1], sn[2], sn[3],
 		sn[4], sn[5], sn[6], sn[7],
@@ -1296,7 +1295,7 @@ static ssize_t aac_show_driver_version(struct device *device,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", aac_driver_version);
+	return sysfs_emit(buf, "%s\n", aac_driver_version);
 }
 
 static ssize_t aac_show_serial_number(struct device *device,
@@ -1322,15 +1321,13 @@ static ssize_t aac_show_serial_number(struct device *device,
 static ssize_t aac_show_max_channel(struct device *device,
 				    struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-	  class_to_shost(device)->max_channel);
+	return sysfs_emit(buf, "%d\n", class_to_shost(device)->max_channel);
 }
 
 static ssize_t aac_show_max_id(struct device *device,
 			       struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-	  class_to_shost(device)->max_id);
+	return sysfs_emit(buf, "%d\n", class_to_shost(device)->max_id);
 }
 
 static ssize_t aac_store_reset_adapter(struct device *device,
-- 
2.29.2


