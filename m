Return-Path: <linux-kernel+bounces-26964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF5C82E8A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE531F23865
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7377612B9E;
	Tue, 16 Jan 2024 04:52:27 +0000 (UTC)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EDA125B6;
	Tue, 16 Jan 2024 04:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="146510848"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="146510848"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:22 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 51F1DD9DA5;
	Tue, 16 Jan 2024 13:52:20 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 93B33D3F08;
	Tue, 16 Jan 2024 13:52:19 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2DE116B4C8;
	Tue, 16 Jan 2024 13:52:19 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id C1C471A0070;
	Tue, 16 Jan 2024 12:52:18 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 18/42] drivers/scsi/aic94xx: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:27 +0800
Message-Id: <20240116045151.3940401-16-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--14.280700-10.000000
X-TMASE-MatchedRID: Jy5kObkVr+g4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4TBF7stuNMMxTuctSpiuWyUUi4Ehat05499RlPzeVuQQyL5
	QmWOgMfCndn/LfNMv39UVRVsVILlB/tI0Ln2VOhSAwosDBeuPwRDqmKczPoNZEEYpOvie10n4ft
	7I4VD5pTqKm/4qdbn8gDLqnrRlXrZ8nn9tnqel2DsAVzN+Ov/sufUwsBq17glF6e34HbuhxCIJj
	M9P5nz1poVOrOUhhFgu1NHftySvFw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/aic94xx/aic94xx_init.c:267:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/aic94xx/aic94xx_init.c:276:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/aic94xx/aic94xx_init.c:284:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/aic94xx/aic94xx_init.c:455:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/aic94xx/aic94xx_init.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 8a3340d8d7ad..b006e852c40c 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -264,8 +264,7 @@ static ssize_t asd_show_dev_rev(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct asd_ha_struct *asd_ha = dev_to_asd_ha(dev);
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			asd_dev_rev[asd_ha->revision_id]);
+	return sysfs_emit(buf, "%s\n", asd_dev_rev[asd_ha->revision_id]);
 }
 static DEVICE_ATTR(aic_revision, S_IRUGO, asd_show_dev_rev, NULL);
 
@@ -273,7 +272,7 @@ static ssize_t asd_show_dev_bios_build(struct device *dev,
 				       struct device_attribute *attr,char *buf)
 {
 	struct asd_ha_struct *asd_ha = dev_to_asd_ha(dev);
-	return snprintf(buf, PAGE_SIZE, "%d\n", asd_ha->hw_prof.bios.bld);
+	return sysfs_emit(buf, "%d\n", asd_ha->hw_prof.bios.bld);
 }
 static DEVICE_ATTR(bios_build, S_IRUGO, asd_show_dev_bios_build, NULL);
 
@@ -281,7 +280,7 @@ static ssize_t asd_show_dev_pcba_sn(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct asd_ha_struct *asd_ha = dev_to_asd_ha(dev);
-	return snprintf(buf, PAGE_SIZE, "%s\n", asd_ha->hw_prof.pcba_sn);
+	return sysfs_emit(buf, "%s\n", asd_ha->hw_prof.pcba_sn);
 }
 static DEVICE_ATTR(pcba_sn, S_IRUGO, asd_show_dev_pcba_sn, NULL);
 
@@ -452,9 +451,9 @@ static ssize_t asd_show_update_bios(struct device *dev,
 	if (asd_ha->bios_status != FLASH_IN_PROGRESS)
 		asd_ha->bios_status = FLASH_OK;
 
-	return snprintf(buf, PAGE_SIZE, "status=%x %s\n",
-			flash_error_table[i].err_code,
-			flash_error_table[i].reason);
+	return sysfs_emit(buf, "status=%x %s\n",
+			  flash_error_table[i].err_code,
+			  flash_error_table[i].reason);
 }
 
 static DEVICE_ATTR(update_bios, S_IRUGO|S_IWUSR,
@@ -937,7 +936,7 @@ static int asd_scan_finished(struct Scsi_Host *shost, unsigned long time)
 
 static ssize_t version_show(struct device_driver *driver, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", ASD_DRIVER_VERSION);
+	return sysfs_emit(buf, "%s\n", ASD_DRIVER_VERSION);
 }
 static DRIVER_ATTR_RO(version);
 
-- 
2.29.2


