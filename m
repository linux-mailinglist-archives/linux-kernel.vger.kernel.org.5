Return-Path: <linux-kernel+bounces-107098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7FD87F780
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E457B22BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96FC7EF17;
	Tue, 19 Mar 2024 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bweHafBJ"
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FBD7CF30;
	Tue, 19 Mar 2024 06:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829959; cv=none; b=SfHo/cy5qtdzQ6t6QPTvaQPiCtlyhigIcFmqL1nGFn4x3iwmwW+Bytu3tGll98hH0HHGKKyv8m5O9toz3UJJ0qxEVqPQhbtOgcwKXqIHHSE8RCygy30XsRiCUC2TCAubvaNgXDPuzWP5/KBu2Xgcr3q2og2ErnAjD5qFeCplPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829959; c=relaxed/simple;
	bh=It5Zxc5LZMCakogfZklJFik4nouNeq8Wa514XlZZazY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pJAlbmbQyhtW28+85ZShyPwcjcB1Ac6WGGnTZ6vjtN1uweJ3QRuLZRBUeo/8ghwRQC9f0rYtZVj8V91EuLfsznbjSD/El+yTJEleZbn5n4oJ3xp2ze2CoLz/rDQoKOIrIkJzMDatledQXKONB+YR2kz6bJNLFLyiOQh3HuMAEMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bweHafBJ; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829956; x=1742365956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=It5Zxc5LZMCakogfZklJFik4nouNeq8Wa514XlZZazY=;
  b=bweHafBJ/vVIb3+NeJauw5o1A6jyk9w33iXRN/82a69hwNesO+17Umsb
   nIoxwCfCIRKui1+YAL/OFcyIx9eIlwU0N4I+dxS0HzM0vPWZGTQwoDlmK
   rUizw6uiXlFOv/Pv5pjNsGJnp3WHdSykVkdgqMg/4dgV9ypaw3DQC7Vnj
   cDvsw2YsFQvE3k6Yw7kupHbVxyKbx+1c0RlrgJZACVWPOJplvrw8/TGvi
   lHDmnRmPwlWIdifkjNUbC8u93krm/CCZjKCpCOcGD9bgZ5VNmPV6WB7PA
   z+Zca5W6rygJ/jGRyMjdMHofsiHqTcg5cl2yfUlGgwYkMLKEdn4MjYNlt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="132006246"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="132006246"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:30 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 35BBB2A0DF9;
	Tue, 19 Mar 2024 15:32:29 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 769D8D7B7E;
	Tue, 19 Mar 2024 15:32:28 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 038D0202C976A;
	Tue, 19 Mar 2024 15:32:27 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 8AFFD1A006B;
	Tue, 19 Mar 2024 14:32:27 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 23/25] scsi: scsi_transport_sas: Convert sprintf() family to sysfs_emit() family (part 1)
Date: Tue, 19 Mar 2024 14:31:30 +0800
Message-Id: <20240319063132.1588443-23-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--9.676400-10.000000
X-TMASE-MatchedRID: 6n1zk+md1nUbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/2BKRtg9pHEawLkNMQzGl5B+Kr
	WCPbERPznpYPqS6jzxXnkq6nWMKnxgNUdcYnHhO3aNJ/iTxXCafS0Ip2eEHnz3IzXlXlpamPoLR
	4+zsDTtD12T7q2dIUvhAYNECNeotsQTOF4spdICumJCBGjERTgkI5TbtbsRyA==
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
 drivers/scsi/scsi_transport_sas.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index d704c484a251..baf2aaf361d2 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
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
@@ -1177,7 +1177,7 @@ show_sas_rphy_device_type(struct device *dev,
 	struct sas_rphy *rphy = transport_class_to_rphy(dev);
 
 	if (!rphy->identify.device_type)
-		return snprintf(buf, 20, "none\n");
+		return sysfs_emit(buf, "none\n");
 	return get_sas_device_type_names(
 			rphy->identify.device_type, buf);
 }
@@ -1199,7 +1199,7 @@ show_sas_rphy_enclosure_identifier(struct device *dev,
 	error = i->f->get_enclosure_identifier(rphy, &identifier);
 	if (error)
 		return error;
-	return sprintf(buf, "0x%llx\n", (unsigned long long)identifier);
+	return sysfs_emit(buf, "0x%llx\n", (unsigned long long)identifier);
 }
 
 static SAS_DEVICE_ATTR(rphy, enclosure_identifier, S_IRUGO,
@@ -1218,7 +1218,7 @@ show_sas_rphy_bay_identifier(struct device *dev,
 	val = i->f->get_bay_identifier(rphy);
 	if (val < 0)
 		return val;
-	return sprintf(buf, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 
 static SAS_DEVICE_ATTR(rphy, bay_identifier, S_IRUGO,
-- 
2.29.2


