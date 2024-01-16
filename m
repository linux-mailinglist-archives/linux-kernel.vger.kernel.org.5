Return-Path: <linux-kernel+bounces-26975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4A682E8B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042EE1F21083
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501BD1B942;
	Tue, 16 Jan 2024 04:52:32 +0000 (UTC)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698A711185;
	Tue, 16 Jan 2024 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="146090994"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="146090994"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:22 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 02402D7AE4;
	Tue, 16 Jan 2024 13:52:20 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id ECDD3C1D78;
	Tue, 16 Jan 2024 13:52:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8FD5C6B4C7;
	Tue, 16 Jan 2024 13:52:18 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1CBC11A015F;
	Tue, 16 Jan 2024 12:52:18 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 16/42] drivers/scsi/53c700: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:25 +0800
Message-Id: <20240116045151.3940401-14-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--8.081000-10.000000
X-TMASE-MatchedRID: CncXHiplHCc4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4dL4Vi2vvkbTrMZ+BqQt2NrBOVz0Jwcxl6vCrG0TnfVUg9x
	e4gtUJtpqw4mhfH/Cj3QJpsmqtg2cHxPMjOKY7A/+HHE8LDNSg8RB0bsfrpPIfiAqrjYtFiQaiK
	q3Gb1595xakd0mtD8VYl3SnqFqQXdCWGMoSnhDBX7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/53c700.c:2074:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/53c700.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 857be0f3ae5b..85439e976143 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -2071,7 +2071,7 @@ NCR_700_show_active_tags(struct device *dev, struct device_attribute *attr, char
 {
 	struct scsi_device *SDp = to_scsi_device(dev);
 
-	return snprintf(buf, 20, "%d\n", NCR_700_get_depth(SDp));
+	return sysfs_emit(buf, "%d\n", NCR_700_get_depth(SDp));
 }
 
 static struct device_attribute NCR_700_active_tags_attr = {
-- 
2.29.2


