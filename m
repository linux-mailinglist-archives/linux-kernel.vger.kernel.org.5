Return-Path: <linux-kernel+bounces-107087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC3687F76D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A14B8B22296
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED517C092;
	Tue, 19 Mar 2024 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="iLCdpJC1"
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E550263;
	Tue, 19 Mar 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829953; cv=none; b=HWHevLnZqtsMLPC0sYckg9O4K2dlCSr4lrzG3Yh1fWtZFJuv1136UJxE7JXNTSarQkXjpwS0EBjpMw+Lpg6sdxVk4g8sPAYS/SR8T8wnt1sHLaJK6dR1Zl/lgYID1vB5a2f+5iUuLJ5GAxFFqUH+YvzV1x8RpnP2XlCRcYJHNnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829953; c=relaxed/simple;
	bh=nZyfZZS2anfXFv69+y8nmBtqiJPKCJ5FHkiZs7WXN60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q8akbs6fpP3ngS9Duwr+0YRxm3j+zcR5s+d1ejoy3bTm/sJByFidXjfL7kewtn8oGURDxbEQjpc3SAeHzv0L1lPSkPY18f1B8tUC/IeYGjqiCxF8dPcr0NHvb+Z2KnEBjPg7M0hzSw0u7vBbPXTZkWnwtBxjcRlAINtVtjwmHws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=iLCdpJC1; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829951; x=1742365951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nZyfZZS2anfXFv69+y8nmBtqiJPKCJ5FHkiZs7WXN60=;
  b=iLCdpJC1t8eIUKTsyA6OrAiM4GVv7CgdD/anBWkNXzUQaxop8RRiOo//
   AfJF1fnKw1wMQRl3Y3eEBG5waa6zftO1uw5Sjv+AIWdOFR4eIorvZwEg4
   cHugGf6Q7qmPIdWwDhjBPIpAAoBxpNIi605HpM8WU4QsQkRU1wwsBoGgK
   AyfcfecwOoeHfObKI+E48u5rBxlpUPlmzFODtzZLY79z7PY4pAB3r/XbW
   bzZbCbu66eWGLNKUh/F2ppZQ1zTgWe8iJj3SuXzVGjDekYG5ojvwzl8wx
   rTd8+SxKKOppbEah8SRlRNmK/i6OW6ItqlK/I2U+xVX8Yzk2ZWkWf0uqt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="140310358"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="140310358"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:27 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id B4684D9F04;
	Tue, 19 Mar 2024 15:32:25 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id EA1BFD4241;
	Tue, 19 Mar 2024 15:32:24 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7A6E7200A7E3A;
	Tue, 19 Mar 2024 15:32:24 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E48201A006D;
	Tue, 19 Mar 2024 14:32:23 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 12/25] scsi: snic: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:19 +0800
Message-Id: <20240319063132.1588443-12-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--13.604400-10.000000
X-TMASE-MatchedRID: RKkR8WK0E1obO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u+49IoBojnioWluHEj++VqUhQ6
	YZNvnIb+Ekt/L8HtAJ785xNkZcrN2ePWEUnWb98FBDn6Fjq77jvioIsi7Sa0gwLkNMQzGl5B+Kr
	WCPbERPznpYPqS6jzxXnkq6nWMKnzGt2xdLsY3ZHzmmMD/HXF+NGYVVYIZ7j0GWfDd0b0zMaPFj
	JEFr+olwXCBO/GKkVqOhzOa6g8Krd/ayBsm1u+IQ0FGsEBH1RwTQPdH9Gpv0uXnYQFK4PLxGg6U
	Cv2vKWA=
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

CC: Karan Tilak Kumar <kartilak@cisco.com>
CC: Sesidhar Baddela <sebaddel@cisco.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/snic/snic_attrs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/snic/snic_attrs.c b/drivers/scsi/snic/snic_attrs.c
index 3ddbdbc3ded1..48bf82d042b4 100644
--- a/drivers/scsi/snic/snic_attrs.c
+++ b/drivers/scsi/snic/snic_attrs.c
@@ -13,7 +13,7 @@ snic_show_sym_name(struct device *dev,
 {
 	struct snic *snic = shost_priv(class_to_shost(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", snic->name);
+	return sysfs_emit(buf, "%s\n", snic->name);
 }
 
 static ssize_t
@@ -23,8 +23,7 @@ snic_show_state(struct device *dev,
 {
 	struct snic *snic = shost_priv(class_to_shost(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			snic_state_str[snic_get_state(snic)]);
+	return sysfs_emit(buf, "%s\n", snic_state_str[snic_get_state(snic)]);
 }
 
 static ssize_t
@@ -32,7 +31,7 @@ snic_show_drv_version(struct device *dev,
 		      struct device_attribute *attr,
 		      char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", SNIC_DRV_VERSION);
+	return sysfs_emit(buf, "%s\n", SNIC_DRV_VERSION);
 }
 
 static ssize_t
@@ -45,8 +44,8 @@ snic_show_link_state(struct device *dev,
 	if (snic->config.xpt_type == SNIC_DAS)
 		snic->link_status = svnic_dev_link_status(snic->vdev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			(snic->link_status) ? "Link Up" : "Link Down");
+	return sysfs_emit(buf, "%s\n",
+			  (snic->link_status) ? "Link Up" : "Link Down");
 }
 
 static DEVICE_ATTR(snic_sym_name, S_IRUGO, snic_show_sym_name, NULL);
-- 
2.29.2


