Return-Path: <linux-kernel+bounces-26987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E6F82E8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80255282FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA181CF91;
	Tue, 16 Jan 2024 04:52:39 +0000 (UTC)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920341BC4C;
	Tue, 16 Jan 2024 04:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="134244467"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="134244467"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:29 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 506E3E8BF5;
	Tue, 16 Jan 2024 13:52:27 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8723CBF3FF;
	Tue, 16 Jan 2024 13:52:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1C54E200A56FC;
	Tue, 16 Jan 2024 13:52:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id A8FBC1A0160;
	Tue, 16 Jan 2024 12:52:25 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 38/42]  drivers/scsi/scsi_transport_fc: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:47 +0800
Message-Id: <20240116045151.3940401-36-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--14.163000-10.000000
X-TMASE-MatchedRID: st9CF01730Y4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckMWl
	hj9iHeVpaAKUUskFh7lM0AWQBBcXdpRSkbxKeJc4LdBFrfY9r2n0swHSFcVJ6MC5DTEMxpeQfiq
	1gj2xET8vYRhsicUjm84WYLmQfXYmFZzhICPDv1x7wqPa+cm9aflSepWcgdLPx8BJ7uScK205Q+
	5OtQJCFZ4W5X99NcSot+ix2ebieZ2XBXaJoB9JZxRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7ulHD
	smna5gFayom1eEUsbjd0Un7L1Xkx+Kqq72Zh9LCPpCuffGH9zI=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/scsi_transport_fc.c:1123:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/scsi_transport_fc.c:1218:10-18: WARNING: please use sysfs_emit
> ./drivers/scsi/scsi_transport_fc.c:1286:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/scsi_transport_fc.c:1304:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/scsi_transport_fc.c:1665:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/scsi_transport_fc.c:1891:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/scsi_transport_fc.c:1915:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/scsi_transport_fc.c:1967:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/scsi_transport_fc.c:2000:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/scsi_transport_fc.c | 34 ++++++++++++++++----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index b04075f19445..3335c31772e1 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -1120,7 +1120,7 @@ show_fc_rport_supported_classes (struct device *dev,
 {
 	struct fc_rport *rport = transport_class_to_rport(dev);
 	if (rport->supported_classes == FC_COS_UNSPECIFIED)
-		return snprintf(buf, 20, "unspecified\n");
+		return sysfs_emit(buf, "unspecified\n");
 	return get_fc_cos_names(rport->supported_classes, buf);
 }
 static FC_DEVICE_ATTR(rport, supported_classes, S_IRUGO,
@@ -1215,21 +1215,21 @@ show_fc_rport_roles (struct device *dev, struct device_attribute *attr,
 					FC_WELLKNOWN_PORTID_MASK) {
 		switch (rport->port_id & FC_WELLKNOWN_ROLE_MASK) {
 		case FC_FPORT_PORTID:
-			return snprintf(buf, 30, "Fabric Port\n");
+			return sysfs_emit(buf, "Fabric Port\n");
 		case FC_FABCTLR_PORTID:
-			return snprintf(buf, 30, "Fabric Controller\n");
+			return sysfs_emit(buf, "Fabric Controller\n");
 		case FC_DIRSRVR_PORTID:
-			return snprintf(buf, 30, "Directory Server\n");
+			return sysfs_emit(buf, "Directory Server\n");
 		case FC_TIMESRVR_PORTID:
-			return snprintf(buf, 30, "Time Server\n");
+			return sysfs_emit(buf, "Time Server\n");
 		case FC_MGMTSRVR_PORTID:
-			return snprintf(buf, 30, "Management Server\n");
+			return sysfs_emit(buf, "Management Server\n");
 		default:
-			return snprintf(buf, 30, "Unknown Fabric Entity\n");
+			return sysfs_emit(buf, "Unknown Fabric Entity\n");
 		}
 	} else {
 		if (rport->roles == FC_PORT_ROLE_UNKNOWN)
-			return snprintf(buf, 20, "unknown\n");
+			return sysfs_emit(buf, "unknown\n");
 		return get_fc_port_roles_names(rport->roles, buf);
 	}
 }
@@ -1283,7 +1283,7 @@ show_fc_rport_port_state(struct device *dev,
 	if (!name)
 		return -EINVAL;
 
-	return snprintf(buf, 20, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 static FC_DEVICE_ATTR(rport, port_state, 0444 | 0200,
@@ -1301,8 +1301,8 @@ show_fc_rport_fast_io_fail_tmo (struct device *dev,
 	struct fc_rport *rport = transport_class_to_rport(dev);
 
 	if (rport->fast_io_fail_tmo == -1)
-		return snprintf(buf, 5, "off\n");
-	return snprintf(buf, 20, "%d\n", rport->fast_io_fail_tmo);
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n", rport->fast_io_fail_tmo);
 }
 
 static ssize_t
@@ -1662,7 +1662,7 @@ show_fc_vport_roles (struct device *dev, struct device_attribute *attr,
 	struct fc_vport *vport = transport_class_to_vport(dev);
 
 	if (vport->roles == FC_PORT_ROLE_UNKNOWN)
-		return snprintf(buf, 20, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");
 	return get_fc_port_roles_names(vport->roles, buf);
 }
 static FC_DEVICE_ATTR(vport, roles, S_IRUGO, show_fc_vport_roles, NULL);
@@ -1888,7 +1888,7 @@ show_fc_host_supported_classes (struct device *dev,
 	struct Scsi_Host *shost = transport_class_to_shost(dev);
 
 	if (fc_host_supported_classes(shost) == FC_COS_UNSPECIFIED)
-		return snprintf(buf, 20, "unspecified\n");
+		return sysfs_emit(buf, "unspecified\n");
 
 	return get_fc_cos_names(fc_host_supported_classes(shost), buf);
 }
@@ -1912,7 +1912,7 @@ show_fc_host_supported_speeds (struct device *dev,
 	struct Scsi_Host *shost = transport_class_to_shost(dev);
 
 	if (fc_host_supported_speeds(shost) == FC_PORTSPEED_UNKNOWN)
-		return snprintf(buf, 20, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");
 
 	return get_fc_port_speed_names(fc_host_supported_speeds(shost), buf);
 }
@@ -1964,7 +1964,7 @@ show_fc_host_speed (struct device *dev,
 		i->f->get_host_speed(shost);
 
 	if (fc_host_speed(shost) == FC_PORTSPEED_UNKNOWN)
-		return snprintf(buf, 20, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");
 
 	return get_fc_port_speed_names(fc_host_speed(shost), buf);
 }
@@ -1997,7 +1997,7 @@ show_fc_private_host_tgtid_bind_type(struct device *dev,
 	name = get_fc_tgtid_bind_type_name(fc_host_tgtid_bind_type(shost));
 	if (!name)
 		return -EINVAL;
-	return snprintf(buf, FC_BINDTYPE_MAX_NAMELEN, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 #define get_list_head_entry(pos, head, member) 		\
@@ -2106,7 +2106,7 @@ fc_stat_show(const struct device *dev, char *buf, unsigned long offset)
 	if (i->f->get_fc_host_stats) {
 		stats = (i->f->get_fc_host_stats)(shost);
 		if (stats)
-			ret = snprintf(buf, 20, "0x%llx\n",
+			ret = sysfs_emit(buf, "0x%llx\n",
 			      (unsigned long long)*(u64 *)(((u8 *) stats) + offset));
 	}
 	return ret;
-- 
2.29.2


