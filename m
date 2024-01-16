Return-Path: <linux-kernel+bounces-26983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6A282E8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B8F1C225F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E953F1C698;
	Tue, 16 Jan 2024 04:52:36 +0000 (UTC)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625AB1BDEC;
	Tue, 16 Jan 2024 04:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="125018789"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="125018789"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:29 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id A7B63CD6C9;
	Tue, 16 Jan 2024 13:52:27 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id D9AA4E399F;
	Tue, 16 Jan 2024 13:52:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 662DA200A571F;
	Tue, 16 Jan 2024 13:52:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id EFEB91A015F;
	Tue, 16 Jan 2024 12:52:25 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 39/42] drivers/scsi/scsi_transport_sas: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:48 +0800
Message-Id: <20240116045151.3940401-37-lizhijian@fujitsu.com>
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
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.004
X-TMASE-Result: 10--13.295400-10.000000
X-TMASE-MatchedRID: i5zBIT546Mc4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckMWl
	hj9iHeVpaAKUUskFh7lM0AWQBBcXdpRSkbxKeJc4LdBFrfY9r2n0swHSFcVJ6MC5DTEMxpeQfiq
	1gj2xET8vYRhsicUjm84WYLmQfXYmFZzhICPDv1zG+nS24MzHeYLsLasl5ROhGxDxAG8HwlajxY
	yRBa/qJcFwgTvxipFajoczmuoPCq0jBQdKBu5x0pM1psEbuF0oCH/EL7jOrLmY5A5H1uU0A5WO1
	L73K6pf
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/scsi_transport_sas.c:1180:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/scsi_transport_sas.c:525:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/scsi_transport_sas.c:572:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/scsi_transport_sas.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index d704c484a251..f679034e1048 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -427,7 +427,7 @@ show_sas_phy_##name(struct device *dev, 				\
 {									\
 	struct sas_phy *phy = transport_class_to_phy(dev);		\
 									\
-	return snprintf(buf, 20, format_string, cast phy->field);	\
+	return sysfs_emit(buf, format_string, cast phy->field);	\
 }
 
 #define sas_phy_simple_attr(field, name, format_string, type)		\
@@ -442,7 +442,7 @@ show_sas_phy_##name(struct device *dev, 				\
 	struct sas_phy *phy = transport_class_to_phy(dev);		\
 									\
 	if (!phy->field)						\
-		return snprintf(buf, 20, "none\n");			\
+		return sysfs_emit(buf, "none\n");			\
 	return get_sas_protocol_names(phy->field, buf);		\
 }
 
@@ -507,7 +507,7 @@ show_sas_phy_##field(struct device *dev, 				\
 	error = i->f->get_linkerrors ? i->f->get_linkerrors(phy) : 0;	\
 	if (error)							\
 		return error;						\
-	return snprintf(buf, 20, "%u\n", phy->field);			\
+	return sysfs_emit(buf, "%u\n", phy->field);			\
 }
 
 #define sas_phy_linkerror_attr(field)					\
@@ -522,7 +522,7 @@ show_sas_device_type(struct device *dev,
 	struct sas_phy *phy = transport_class_to_phy(dev);
 
 	if (!phy->identify.device_type)
-		return snprintf(buf, 20, "none\n");
+		return sysfs_emit(buf, "none\n");
 	return get_sas_device_type_names(phy->identify.device_type, buf);
 }
 static DEVICE_ATTR(device_type, S_IRUGO, show_sas_device_type, NULL);
@@ -569,7 +569,7 @@ show_sas_phy_enable(struct device *dev, struct device_attribute *attr,
 {
 	struct sas_phy *phy = transport_class_to_phy(dev);
 
-	return snprintf(buf, 20, "%d\n", phy->enabled);
+	return sysfs_emit(buf, "%d\n", phy->enabled);
 }
 
 static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR, show_sas_phy_enable,
@@ -798,7 +798,7 @@ show_sas_port_##name(struct device *dev, 				\
 {									\
 	struct sas_port *port = transport_class_to_sas_port(dev);	\
 									\
-	return snprintf(buf, 20, format_string, cast port->field);	\
+	return sysfs_emit(buf, format_string, cast port->field);	\
 }
 
 #define sas_port_simple_attr(field, name, format_string, type)		\
@@ -1145,7 +1145,7 @@ show_sas_rphy_##name(struct device *dev, 				\
 {									\
 	struct sas_rphy *rphy = transport_class_to_rphy(dev);		\
 									\
-	return snprintf(buf, 20, format_string, cast rphy->field);	\
+	return sysfs_emit(buf, format_string, cast rphy->field);	\
 }
 
 #define sas_rphy_simple_attr(field, name, format_string, type)		\
@@ -1161,7 +1161,7 @@ show_sas_rphy_##name(struct device *dev, 				\
 	struct sas_rphy *rphy = transport_class_to_rphy(dev);		\
 									\
 	if (!rphy->field)					\
-		return snprintf(buf, 20, "none\n");			\
+		return sysfs_emit(buf, "none\n");			\
 	return get_sas_protocol_names(rphy->field, buf);	\
 }
 
@@ -1177,7 +1177,7 @@ show_sas_rphy_device_type(struct device *dev,
 	struct sas_rphy *rphy = transport_class_to_rphy(dev);
 
 	if (!rphy->identify.device_type)
-		return snprintf(buf, 20, "none\n");
+		return sysfs_emit(buf, "none\n");
 	return get_sas_device_type_names(
 			rphy->identify.device_type, buf);
 }
@@ -1280,7 +1280,7 @@ show_sas_end_dev_##name(struct device *dev, 				\
 	struct sas_rphy *rphy = transport_class_to_rphy(dev);		\
 	struct sas_end_device *rdev = rphy_to_end_device(rphy);		\
 									\
-	return snprintf(buf, 20, format_string, cast rdev->field);	\
+	return sysfs_emit(buf, format_string, cast rdev->field);	\
 }
 
 #define sas_end_dev_simple_attr(field, name, format_string, type)	\
@@ -1309,7 +1309,7 @@ show_sas_expander_##name(struct device *dev, 				\
 	struct sas_rphy *rphy = transport_class_to_rphy(dev);		\
 	struct sas_expander_device *edev = rphy_to_expander_device(rphy); \
 									\
-	return snprintf(buf, 20, format_string, cast edev->field);	\
+	return sysfs_emit(buf, format_string, cast edev->field);	\
 }
 
 #define sas_expander_simple_attr(field, name, format_string, type)	\
-- 
2.29.2


