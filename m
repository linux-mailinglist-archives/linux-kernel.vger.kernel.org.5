Return-Path: <linux-kernel+bounces-107099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E4F87F784
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB1C28180C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D2C7F7C7;
	Tue, 19 Mar 2024 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kgMSsekE"
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176447CF39;
	Tue, 19 Mar 2024 06:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829959; cv=none; b=XFJW+JSJWrjpjlt1rjGZtsAKv0DzGXk0EEqZHXpeUDOMHuBBex7bk/PEKljXDBAdIWSQOrv5fPYLy6OQNpbY4zs45c6vEWq94y1/XrFub4en7PGotIBS+rlI2EmQP8cjVhUCEcqHo1apdPEsObp979EIc+Vxc6ldWpQ1sbnKVNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829959; c=relaxed/simple;
	bh=IbSVMgZx41kP9mucdGRkZ+TwMkWR19uh07az1NIR6E0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZNWG1PX2PX/BInT4pxm6vAi28NYaRtohglxDhFccnEHwLO3bQvvcdPj0MIh+nPTTKC2gxlJh+8GBHw0xR2rQuOTW6Y00EfcM08aI0VW/mz4sM1TDn+nBMqQB9ofIl0k6lCagoLx5cxDkVokOwJJoZ67nj6QnGDERoX6Sn2NNRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kgMSsekE; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829957; x=1742365957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IbSVMgZx41kP9mucdGRkZ+TwMkWR19uh07az1NIR6E0=;
  b=kgMSsekE9Mz8JC8Q8PDCaCpy+eTdYdtNNneBPMrSxBwhMVfw8d2BF74F
   A/0COCh9uZaeAlrZZNzIYyw9hNlsznVgspUrMoOWZAgt/z9IN6tSAYTsZ
   LwWjRMw+ruTYPH9FS9LG5P2xwMyRvR7pbdklRi7RTRmGCbgFxr5T1nyMl
   YOhRR4uC8SmyaEuhljlqss1TfkBquHv8fcB3KsyBeEzsdYzesEEjBBn5I
   FYuKUu/FS9UylxDiIJMouexLEun/NJ2ehzfVyyt5yM0wHnVWu+tdmm31Y
   V9nu+zlaXO/9viHDA7vuWH0fFXjGAx0F4WV6dPHQcvBJtQfZ+LWUo+n2n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="152971383"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="152971383"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:25 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 64992D4800;
	Tue, 19 Mar 2024 15:32:23 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 84366BF4B8;
	Tue, 19 Mar 2024 15:32:22 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 156AC2288DF;
	Tue, 19 Mar 2024 15:32:22 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 9FEB21A006E;
	Tue, 19 Mar 2024 14:32:21 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 06/25] scsi: fcoe: Convert sprintf() family to sysfs_emit() family (part 2)
Date: Tue, 19 Mar 2024 14:31:13 +0800
Message-Id: <20240319063132.1588443-6-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--9.144400-10.000000
X-TMASE-MatchedRID: pfKaEBrCt3IbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSArq
	oIZrVn10Bh0sVevfs+KARHumklBHdgNUdcYnHhO869emDs42ddJ1hCPLkD1Z0elQy/uI/kRRhBv
	WgZlX+84vM1YF6AJbbCCfuIMF6xLSAHAopEd76vDgB4GwJOR3Dpx/3g93ShNJLNK9Jps9Vaf+w/
	hpgGsH/X1yytYt1jVw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

This focuses on abused cases in macros

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
 drivers/scsi/fcoe/fcoe_sysfs.c | 82 +++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index 46a2f7f0669f..2baa1d6456fc 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -134,7 +134,7 @@ static int fcoe_fcf_set_dev_loss_tmo(struct fcoe_fcf_device *fcf,
 struct device_attribute device_attr_fcoe_##_prefix##_##_name =	\
 	__ATTR(_name, _mode, _show, _store)
 
-#define fcoe_ctlr_show_function(field, format_string, sz, cast)	\
+#define fcoe_ctlr_show_function(field, format_string, cast)	\
 static ssize_t show_fcoe_ctlr_device_##field(struct device *dev, \
 					    struct device_attribute *attr, \
 					    char *buf)			\
@@ -142,11 +142,11 @@ static ssize_t show_fcoe_ctlr_device_##field(struct device *dev, \
 	struct fcoe_ctlr_device *ctlr = dev_to_ctlr(dev);		\
 	if (ctlr->f->get_fcoe_ctlr_##field)				\
 		ctlr->f->get_fcoe_ctlr_##field(ctlr);			\
-	return snprintf(buf, sz, format_string,				\
-			cast fcoe_ctlr_##field(ctlr));			\
+	return sysfs_emit(buf, format_string,				\
+			  cast fcoe_ctlr_##field(ctlr));		\
 }
 
-#define fcoe_fcf_show_function(field, format_string, sz, cast)	\
+#define fcoe_fcf_show_function(field, format_string, cast)	\
 static ssize_t show_fcoe_fcf_device_##field(struct device *dev,	\
 					   struct device_attribute *attr, \
 					   char *buf)			\
@@ -155,55 +155,55 @@ static ssize_t show_fcoe_fcf_device_##field(struct device *dev,	\
 	struct fcoe_ctlr_device *ctlr = fcoe_fcf_dev_to_ctlr_dev(fcf);	\
 	if (ctlr->f->get_fcoe_fcf_##field)				\
 		ctlr->f->get_fcoe_fcf_##field(fcf);			\
-	return snprintf(buf, sz, format_string,				\
-			cast fcoe_fcf_##field(fcf));			\
+	return sysfs_emit(buf, format_string,				\
+			  cast fcoe_fcf_##field(fcf));			\
 }
 
-#define fcoe_ctlr_private_show_function(field, format_string, sz, cast)	\
+#define fcoe_ctlr_private_show_function(field, format_string, cast)	\
 static ssize_t show_fcoe_ctlr_device_##field(struct device *dev, \
 					    struct device_attribute *attr, \
 					    char *buf)			\
 {									\
 	struct fcoe_ctlr_device *ctlr = dev_to_ctlr(dev);		\
-	return snprintf(buf, sz, format_string, cast fcoe_ctlr_##field(ctlr)); \
+	return sysfs_emit(buf, format_string, cast fcoe_ctlr_##field(ctlr)); \
 }
 
-#define fcoe_fcf_private_show_function(field, format_string, sz, cast)	\
+#define fcoe_fcf_private_show_function(field, format_string, cast)	\
 static ssize_t show_fcoe_fcf_device_##field(struct device *dev,	\
 					   struct device_attribute *attr, \
 					   char *buf)			\
 {								\
 	struct fcoe_fcf_device *fcf = dev_to_fcf(dev);			\
-	return snprintf(buf, sz, format_string, cast fcoe_fcf_##field(fcf)); \
+	return sysfs_emit(buf, format_string, cast fcoe_fcf_##field(fcf)); \
 }
 
-#define fcoe_ctlr_private_rd_attr(field, format_string, sz)		\
-	fcoe_ctlr_private_show_function(field, format_string, sz, )	\
+#define fcoe_ctlr_private_rd_attr(field, format_string)		\
+	fcoe_ctlr_private_show_function(field, format_string, )	\
 	static FCOE_DEVICE_ATTR(ctlr, field, S_IRUGO,			\
 				show_fcoe_ctlr_device_##field, NULL)
 
-#define fcoe_ctlr_rd_attr(field, format_string, sz)			\
-	fcoe_ctlr_show_function(field, format_string, sz, )		\
+#define fcoe_ctlr_rd_attr(field, format_string)			\
+	fcoe_ctlr_show_function(field, format_string, )		\
 	static FCOE_DEVICE_ATTR(ctlr, field, S_IRUGO,			\
 				show_fcoe_ctlr_device_##field, NULL)
 
-#define fcoe_fcf_rd_attr(field, format_string, sz)			\
-	fcoe_fcf_show_function(field, format_string, sz, )		\
+#define fcoe_fcf_rd_attr(field, format_string)			\
+	fcoe_fcf_show_function(field, format_string, )		\
 	static FCOE_DEVICE_ATTR(fcf, field, S_IRUGO,			\
 				show_fcoe_fcf_device_##field, NULL)
 
-#define fcoe_fcf_private_rd_attr(field, format_string, sz)		\
-	fcoe_fcf_private_show_function(field, format_string, sz, )	\
+#define fcoe_fcf_private_rd_attr(field, format_string)		\
+	fcoe_fcf_private_show_function(field, format_string, )	\
 	static FCOE_DEVICE_ATTR(fcf, field, S_IRUGO,			\
 				show_fcoe_fcf_device_##field, NULL)
 
-#define fcoe_ctlr_private_rd_attr_cast(field, format_string, sz, cast)	\
-	fcoe_ctlr_private_show_function(field, format_string, sz, (cast)) \
+#define fcoe_ctlr_private_rd_attr_cast(field, format_string, cast)	\
+	fcoe_ctlr_private_show_function(field, format_string, (cast)) \
 	static FCOE_DEVICE_ATTR(ctlr, field, S_IRUGO,			\
 				show_fcoe_ctlr_device_##field, NULL)
 
-#define fcoe_fcf_private_rd_attr_cast(field, format_string, sz, cast)	\
-	fcoe_fcf_private_show_function(field, format_string, sz, (cast)) \
+#define fcoe_fcf_private_rd_attr_cast(field, format_string, cast)	\
+	fcoe_fcf_private_show_function(field, format_string, (cast)) \
 	static FCOE_DEVICE_ATTR(fcf, field, S_IRUGO,			\
 				show_fcoe_fcf_device_##field, NULL)
 
@@ -489,30 +489,30 @@ store_private_fcoe_ctlr_fcf_dev_loss_tmo(struct device *dev,
 	mutex_unlock(&ctlr->lock);
 	return count;
 }
-fcoe_ctlr_private_show_function(fcf_dev_loss_tmo, "%d\n", 20, );
+fcoe_ctlr_private_show_function(fcf_dev_loss_tmo, "%d\n", );
 static FCOE_DEVICE_ATTR(ctlr, fcf_dev_loss_tmo, S_IRUGO | S_IWUSR,
 			show_fcoe_ctlr_device_fcf_dev_loss_tmo,
 			store_private_fcoe_ctlr_fcf_dev_loss_tmo);
 
 /* Link Error Status Block (LESB) */
-fcoe_ctlr_rd_attr(link_fail, "%u\n", 20);
-fcoe_ctlr_rd_attr(vlink_fail, "%u\n", 20);
-fcoe_ctlr_rd_attr(miss_fka, "%u\n", 20);
-fcoe_ctlr_rd_attr(symb_err, "%u\n", 20);
-fcoe_ctlr_rd_attr(err_block, "%u\n", 20);
-fcoe_ctlr_rd_attr(fcs_error, "%u\n", 20);
-
-fcoe_fcf_private_rd_attr_cast(fabric_name, "0x%llx\n", 20, unsigned long long);
-fcoe_fcf_private_rd_attr_cast(switch_name, "0x%llx\n", 20, unsigned long long);
-fcoe_fcf_private_rd_attr(priority, "%u\n", 20);
-fcoe_fcf_private_rd_attr(fc_map, "0x%x\n", 20);
-fcoe_fcf_private_rd_attr(vfid, "%u\n", 20);
-fcoe_fcf_private_rd_attr(mac, "%pM\n", 20);
-fcoe_fcf_private_rd_attr(fka_period, "%u\n", 20);
-fcoe_fcf_rd_attr(selected, "%u\n", 20);
-fcoe_fcf_rd_attr(vlan_id, "%u\n", 20);
-
-fcoe_fcf_private_show_function(dev_loss_tmo, "%d\n", 20, )
+fcoe_ctlr_rd_attr(link_fail, "%u\n");
+fcoe_ctlr_rd_attr(vlink_fail, "%u\n");
+fcoe_ctlr_rd_attr(miss_fka, "%u\n");
+fcoe_ctlr_rd_attr(symb_err, "%u\n");
+fcoe_ctlr_rd_attr(err_block, "%u\n");
+fcoe_ctlr_rd_attr(fcs_error, "%u\n");
+
+fcoe_fcf_private_rd_attr_cast(fabric_name, "0x%llx\n", unsigned long long);
+fcoe_fcf_private_rd_attr_cast(switch_name, "0x%llx\n", unsigned long long);
+fcoe_fcf_private_rd_attr(priority, "%u\n");
+fcoe_fcf_private_rd_attr(fc_map, "0x%x\n");
+fcoe_fcf_private_rd_attr(vfid, "%u\n");
+fcoe_fcf_private_rd_attr(mac, "%pM\n");
+fcoe_fcf_private_rd_attr(fka_period, "%u\n");
+fcoe_fcf_rd_attr(selected, "%u\n");
+fcoe_fcf_rd_attr(vlan_id, "%u\n");
+
+fcoe_fcf_private_show_function(dev_loss_tmo, "%d\n", )
 static ssize_t
 store_fcoe_fcf_dev_loss_tmo(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
-- 
2.29.2


