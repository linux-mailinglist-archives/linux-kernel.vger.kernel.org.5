Return-Path: <linux-kernel+bounces-26976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2169B82E8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DCF2B23085
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9691B96A;
	Tue, 16 Jan 2024 04:52:32 +0000 (UTC)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C848F12E72;
	Tue, 16 Jan 2024 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="146236950"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="146236950"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:29 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 480FAE8BFC;
	Tue, 16 Jan 2024 13:52:26 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 76700D9492;
	Tue, 16 Jan 2024 13:52:25 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 17D50200A7687;
	Tue, 16 Jan 2024 13:52:20 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id A2ABC1A015F;
	Tue, 16 Jan 2024 12:52:19 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 21/42] drivers/scsi/fcoe: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:30 +0800
Message-Id: <20240116045151.3940401-19-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--13.189000-10.000000
X-TMASE-MatchedRID: 1RpOuHOu+mY4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4dL4Vi2vvkbTrMZ+BqQt2NrBOVz0Jwcxl6vCrG0TnfVUg9x
	e4gtUJtpqw4mhfH/Cj8iWCtuAyviG5RabHzIDOgzNgrlT5Ajc7n0tCKdnhB589yM15V5aWpj6C0
	ePs7A07YnxgmBGuBcXu5Zf5rxVJ9Kns619g/0YwHLVeDbDQgLaXb5gFkYvCXU=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/fcoe/fcoe_sysfs.c:253:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/fcoe/fcoe_sysfs.c:268:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/fcoe/fcoe_sysfs.c:376:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Hannes Reinecke <hare@suse.de>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/fcoe/fcoe_sysfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index e17957f8085c..9705a579e0d0 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -250,7 +250,7 @@ static ssize_t show_fcf_state(struct device *dev,
 	name = get_fcoe_fcf_state_name(fcf->state);
 	if (!name)
 		return -EINVAL;
-	return snprintf(buf, FCOE_FCF_STATE_MAX_NAMELEN, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 static FCOE_DEVICE_ATTR(fcf, state, S_IRUGO, show_fcf_state, NULL);
 
@@ -265,8 +265,7 @@ static ssize_t show_ctlr_mode(struct device *dev,
 	name = get_fcoe_ctlr_mode_name(ctlr->mode);
 	if (!name)
 		return -EINVAL;
-	return snprintf(buf, FCOE_MAX_MODENAME_LEN,
-			"%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 static ssize_t store_ctlr_mode(struct device *dev,
@@ -373,8 +372,7 @@ static ssize_t show_ctlr_enabled_state(struct device *dev,
 	name = get_fcoe_ctlr_enabled_state_name(ctlr->enabled);
 	if (!name)
 		return -EINVAL;
-	return snprintf(buf, FCOE_CTLR_ENABLED_MAX_NAMELEN,
-			"%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 static FCOE_DEVICE_ATTR(ctlr, enabled, S_IRUGO | S_IWUSR,
-- 
2.29.2


