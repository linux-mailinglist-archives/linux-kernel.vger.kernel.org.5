Return-Path: <linux-kernel+bounces-107093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B19C87F779
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64723B225E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9F17D3E8;
	Tue, 19 Mar 2024 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Y0+aqU+L"
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC0537FE;
	Tue, 19 Mar 2024 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829956; cv=none; b=JEqYxkhg2CdwuFQiYQ77iEiwNQQAnZ7r+/eND4QrGEbyNXsbxGlHZcC1QzZzSmG13aF4a+QCJ8h/Y8vpdPig9hHx51Db1Wgag34ArJjQICPZ0dMzaNlvcOOFp7kx+RD2RQ/ECCOySmIwG3/osNSW/Qi/G3h4fSc0ugzK8K63bv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829956; c=relaxed/simple;
	bh=KyhrL8O+1ZlteCduBxYcQZM2gQ4cYRxZ9gcL4M6OS8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYzTt9updcu1E8ReBeXJCpXJevwZZIJulSN0aQaY1Mohdm6A2QPVJ+RV4VzpKVHhtbIuv9P5occjcvjkBa1gimpDgS0EeIrJ3nijxTF0Audo/zfcXUxU+MR3e6lp2sH823VxlTZ/PckVrps5EfsXv9Z5fPcO+MU276Tsu1X3yCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Y0+aqU+L; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829953; x=1742365953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KyhrL8O+1ZlteCduBxYcQZM2gQ4cYRxZ9gcL4M6OS8Q=;
  b=Y0+aqU+LJHt49aL1/xcpYAWzJ6cLa8AC1n76i0ew/4PlvHkwb9j6vyuH
   +jbQS+GnAdZYKO9CvI0ssSzk/bYBkKAhIxRr0brxtnJ2aWcCMgoOmDZQS
   BxsjeTcmcI6jrVQgt9iOVsZtA2WRLEC4XmgwN4B1iVn1zNQaQZYTet+Vj
   mVl+6JFlThkt/+RVhL4MTEkpVXPsYs0Il+/HAo/KMtuKRhXGUj4DHnbl6
   pAYdOGerPyAzpPG0Q34t7PYx/XV9zW7uZoHSymkGzzsvIAOX6HNhebTX/
   4vUhBNPDPWWAwETUI/cx4htEjhkQHCRtNhekceZLOeKK/rKuM68lzH9cs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="132006242"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="132006242"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:29 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0B43710A304;
	Tue, 19 Mar 2024 15:32:28 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 47E00D5E8C;
	Tue, 19 Mar 2024 15:32:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D418922881A;
	Tue, 19 Mar 2024 15:32:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 514971A006D;
	Tue, 19 Mar 2024 14:32:26 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	=?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 19/25] scsi: st: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:26 +0800
Message-Id: <20240319063132.1588443-19-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240319063132.1588443-1-lizhijian@fujitsu.com>
References: <20240319063132.1588443-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28260.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28260.005
X-TMASE-Result: 10--5.400200-10.000000
X-TMASE-MatchedRID: LFhZ4D3QpawbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSArq
	oIZrVn15fzUkBpc072fpJkaQdvaIFiRyRv3W9D/qncG1vVsfbQrzl8sNiWClKbKItl61J/yZkw8
	KdMzN86KrauXd3MZDV4qu80yg+pNdeiYiPoK9a6QzptACI27AvoDGfifSm6tT02iKjvNfbH
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

CC: "Kai Mäkisara" <Kai.Makisara@kolumbus.fi>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/st.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 338aa8c42968..998e5bb7a6a0 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4571,7 +4571,7 @@ defined_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct st_modedef *STm = dev_get_drvdata(dev);
 	ssize_t l = 0;
 
-	l = snprintf(buf, PAGE_SIZE, "%d\n", STm->defined);
+	l = sysfs_emit(buf, "%d\n", STm->defined);
 	return l;
 }
 static DEVICE_ATTR_RO(defined);
@@ -4583,7 +4583,7 @@ default_blksize_show(struct device *dev, struct device_attribute *attr,
 	struct st_modedef *STm = dev_get_drvdata(dev);
 	ssize_t l = 0;
 
-	l = snprintf(buf, PAGE_SIZE, "%d\n", STm->default_blksize);
+	l = sysfs_emit(buf, "%d\n", STm->default_blksize);
 	return l;
 }
 static DEVICE_ATTR_RO(default_blksize);
@@ -4597,7 +4597,7 @@ default_density_show(struct device *dev, struct device_attribute *attr,
 	char *fmt;
 
 	fmt = STm->default_density >= 0 ? "0x%02x\n" : "%d\n";
-	l = snprintf(buf, PAGE_SIZE, fmt, STm->default_density);
+	l = sysfs_emit(buf, fmt, STm->default_density);
 	return l;
 }
 static DEVICE_ATTR_RO(default_density);
@@ -4609,7 +4609,7 @@ default_compression_show(struct device *dev, struct device_attribute *attr,
 	struct st_modedef *STm = dev_get_drvdata(dev);
 	ssize_t l = 0;
 
-	l = snprintf(buf, PAGE_SIZE, "%d\n", STm->default_compression - 1);
+	l = sysfs_emit(buf, "%d\n", STm->default_compression - 1);
 	return l;
 }
 static DEVICE_ATTR_RO(default_compression);
@@ -4638,7 +4638,7 @@ options_show(struct device *dev, struct device_attribute *attr, char *buf)
 	options |= STp->immediate_filemark ? MT_ST_NOWAIT_EOF : 0;
 	options |= STp->sili ? MT_ST_SILI : 0;
 
-	l = snprintf(buf, PAGE_SIZE, "0x%08x\n", options);
+	l = sysfs_emit(buf, "0x%08x\n", options);
 	return l;
 }
 static DEVICE_ATTR_RO(options);
@@ -4656,7 +4656,7 @@ static ssize_t read_cnt_show(struct device *dev,
 {
 	struct st_modedef *STm = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%lld",
+	return sysfs_emit(buf, "%lld",
 		       (long long)atomic64_read(&STm->tape->stats->read_cnt));
 }
 static DEVICE_ATTR_RO(read_cnt);
@@ -4674,7 +4674,7 @@ static ssize_t read_byte_cnt_show(struct device *dev,
 {
 	struct st_modedef *STm = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%lld",
+	return sysfs_emit(buf, "%lld",
 		       (long long)atomic64_read(&STm->tape->stats->read_byte_cnt));
 }
 static DEVICE_ATTR_RO(read_byte_cnt);
@@ -4690,7 +4690,7 @@ static ssize_t read_ns_show(struct device *dev,
 {
 	struct st_modedef *STm = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%lld",
+	return sysfs_emit(buf, "%lld",
 		       (long long)atomic64_read(&STm->tape->stats->tot_read_time));
 }
 static DEVICE_ATTR_RO(read_ns);
@@ -4707,7 +4707,7 @@ static ssize_t write_cnt_show(struct device *dev,
 {
 	struct st_modedef *STm = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%lld",
+	return sysfs_emit(buf, "%lld",
 		       (long long)atomic64_read(&STm->tape->stats->write_cnt));
 }
 static DEVICE_ATTR_RO(write_cnt);
@@ -4724,7 +4724,7 @@ static ssize_t write_byte_cnt_show(struct device *dev,
 {
 	struct st_modedef *STm = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%lld",
+	return sysfs_emit(buf, "%lld",
 		       (long long)atomic64_read(&STm->tape->stats->write_byte_cnt));
 }
 static DEVICE_ATTR_RO(write_byte_cnt);
@@ -4741,7 +4741,7 @@ static ssize_t write_ns_show(struct device *dev,
 {
 	struct st_modedef *STm = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%lld",
+	return sysfs_emit(buf, "%lld",
 		       (long long)atomic64_read(&STm->tape->stats->tot_write_time));
 }
 static DEVICE_ATTR_RO(write_ns);
@@ -4759,7 +4759,7 @@ static ssize_t in_flight_show(struct device *dev,
 {
 	struct st_modedef *STm = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%lld",
+	return sysfs_emit(buf, "%lld",
 		       (long long)atomic64_read(&STm->tape->stats->in_flight));
 }
 static DEVICE_ATTR_RO(in_flight);
@@ -4779,7 +4779,7 @@ static ssize_t io_ns_show(struct device *dev,
 {
 	struct st_modedef *STm = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%lld",
+	return sysfs_emit(buf, "%lld",
 		       (long long)atomic64_read(&STm->tape->stats->tot_io_time));
 }
 static DEVICE_ATTR_RO(io_ns);
@@ -4798,7 +4798,7 @@ static ssize_t other_cnt_show(struct device *dev,
 {
 	struct st_modedef *STm = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%lld",
+	return sysfs_emit(buf, "%lld",
 		       (long long)atomic64_read(&STm->tape->stats->other_cnt));
 }
 static DEVICE_ATTR_RO(other_cnt);
@@ -4816,7 +4816,7 @@ static ssize_t resid_cnt_show(struct device *dev,
 {
 	struct st_modedef *STm = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%lld",
+	return sysfs_emit(buf, "%lld",
 		       (long long)atomic64_read(&STm->tape->stats->resid_cnt));
 }
 static DEVICE_ATTR_RO(resid_cnt);
-- 
2.29.2


