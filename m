Return-Path: <linux-kernel+bounces-107095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF1787F77F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5F5281F10
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867057EEFF;
	Tue, 19 Mar 2024 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ANLP1RxT"
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0542253813;
	Tue, 19 Mar 2024 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829956; cv=none; b=My+OvVUW9GAa+kHqY2vGCZm/qD63mpwDdNOSG85SXQZ23E8w9iklOv7rIohfMEBP+RPDMUkSN4A7QTnxn56fBIz+xF+pbEOzNYpQX0Z6Mwob4WZocwopg4ZeQXVbqc3mEyRKTw5ZAR55wCh7ftZftVZEIh2AyzcYRQIhcPr54Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829956; c=relaxed/simple;
	bh=ZZwfBq58lOo0qbSS2ix7UcSEpSP7RIoFTyDOAnZBzUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oNIz2rC0FCPZshQ0sIxFmRMCc4FIITQDc3FAOl/BvynzjQnHOHGblJO4y9iGmunfVRJL71wzD4z2QodPNkvU/qaaavn4pC2yftNYcnJzpi+weH3ocBZYyYAslPrAUGHLgLeIvaM2QqJncEazF/tEL8cMBR1ydIWQeFQM2/N6r5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ANLP1RxT; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829954; x=1742365954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZZwfBq58lOo0qbSS2ix7UcSEpSP7RIoFTyDOAnZBzUQ=;
  b=ANLP1RxTEghGGhcXp1U0iA2Xh1OUvpl/BxlS+zauPtZhRmxhFo4JaFJp
   E4dHYquXI/NGh/ZVsuJd7fmZckwyR4ryvmWNx25Yitbf6OXUw91Vh0hKR
   zulL0EDLlsXjlfT/BJY/FcvFipuUQOVvDVjeW21TbIZMjmqkij58WpaSO
   6D/MBJJSFWWAWtKpNBl3Ph0QaeGsGkxPIvv9T4KjlurY9D2gFPhWqyb3o
   w2MgBnuWxP+NmlabsTaUHkE8g2td+0cRZUJjjdAjRm7Y6U3WVyYfM64hl
   mmyxEMYgJPlonQcvHr0kLFRC0PGEQlBQbkJF7RwnRFkVCgJ5PH+qqwaG3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="140310363"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="140310363"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:30 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 742D7D4805;
	Tue, 19 Mar 2024 15:32:28 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id AA7C8BF4B7;
	Tue, 19 Mar 2024 15:32:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 472E0227ABA;
	Tue, 19 Mar 2024 15:32:27 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id F14851A006E;
	Tue, 19 Mar 2024 14:32:26 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 21/25] scsi: scsi_transport_fc: Convert sprintf() family to sysfs_emit() family (part 1)
Date: Tue, 19 Mar 2024 14:31:28 +0800
Message-Id: <20240319063132.1588443-21-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--11.924400-10.000000
X-TMASE-MatchedRID: yLHOPqhdQyUbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/2BKRtg9pHEawLkNMQzGl5B+Kr
	WCPbERPznpYPqS6jzxXnkq6nWMKnzODTJNlBAw6AXtykVcrvpNmZiw53dqSN///os1Fav+xrfb6
	KcK2lmLexIBjF6bqxGjPXfA/IMu+5H0YXYnbGozFEUknJ/kEl7dB/CxWTRRu25FeHtsUoHu5Wbu
	/jwBRoelu+DxdpZgrjrmCnSPLeFBDseBWySHnpwfwV6sBPR0lg==
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


