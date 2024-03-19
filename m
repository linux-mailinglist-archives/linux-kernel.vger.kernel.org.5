Return-Path: <linux-kernel+bounces-107094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6855A87F778
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4EE280209
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2F17D3E4;
	Tue, 19 Mar 2024 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="OakVmdOt"
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB29537FC;
	Tue, 19 Mar 2024 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829956; cv=none; b=czOfmgnDJbsi601T1DNuzWUDNGIhs3nu6YXa9of1eJrUfkuv6wf4nvjN2qaY3QOJwMwEwh4m1n243ZMosob5cLx/x0ik9C4HzLJLf/UCBFClR/upRe8zc+R5OHwldWZVpjpEbxcKUmqawEXG3aDP00lgBlp29+WsuDQnL4GY1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829956; c=relaxed/simple;
	bh=g/F/uSB80Kmdz2xmcZ9fhA6lsdgQP0M3skp+uddabjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q+zNO7BmQ8sYf/Rc8n0tKg7YT2oQ9H4OW8WgaygOLgdtadWnngtgZHMJ2sTdck7oOOASoL7CyasvDu54lbF3iElMaDKzcyB8l1JDe/r2pGT6l18G17J60wg8Krn7rXTmn6BZEa0lf4Pxwvr2fDYb66lAKX8EZO9mlhx6zny3Heg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=OakVmdOt; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829954; x=1742365954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g/F/uSB80Kmdz2xmcZ9fhA6lsdgQP0M3skp+uddabjw=;
  b=OakVmdOteelyhTVYj+N8DiKtv96F4lbN+qIvWOEr9mBBuypCcQmBVHLb
   dWNuJLI8erE9DL2ZCsivQjkvQHaghft1fQ6xk6KI07Mvon2iAxj7OvZhz
   WN1QJS1bE59M8OcQj8fgddf32CvDfQumeUmYBvIO+LzueDon5NHCboR2B
   XICC3O7tbiOtnMvRmxpCbG2Z+GN3TSSl7gZNp+ec8hUB7xbeI0E1QGq2E
   vZi5hokg6lKi5mQKk/2anGpX5sT1gQM0VyEwO2wfVn9ZwHRDO/euwCp7m
   TFMW77Z3QApnM1KVV2Qa5aytqcJ5Ifm5DOmb5RyasRZbTW6svmLTsGAau
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="152971378"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="152971378"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:24 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id F167B141218;
	Tue, 19 Mar 2024 15:32:21 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 310D9BF4B8;
	Tue, 19 Mar 2024 15:32:21 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id BE4C420093269;
	Tue, 19 Mar 2024 15:32:20 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 4AE611A006D;
	Tue, 19 Mar 2024 14:32:20 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 02/25] scsi: aic94xx: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:09 +0800
Message-Id: <20240319063132.1588443-2-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--7.640100-10.000000
X-TMASE-MatchedRID: pfKaEBrCt3IbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSArq
	oIZrVn15fzUkBpc0721RVFWxUguUH+0jQufZU6FIDCiwMF64/BEOqYpzM+g1kYiM67YVe6ChhBv
	WgZlX+84vM1YF6AJbbCCfuIMF6xLSAHAopEd76vphClXDiKKk8nzRrxP+Bp1zE3Xi452DCPieKR
	5xnjQ+4nnWiTJUlIYg==
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
 drivers/scsi/aic94xx/aic94xx_init.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 8a3340d8d7ad..39d1617834de 100644
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
-- 
2.29.2


