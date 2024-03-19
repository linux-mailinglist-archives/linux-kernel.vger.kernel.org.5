Return-Path: <linux-kernel+bounces-107106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774EB87F78E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CADA6B232AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DDE51C5F;
	Tue, 19 Mar 2024 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Zl35M1oK"
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13A851C36;
	Tue, 19 Mar 2024 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830018; cv=none; b=DT7C4zyqAyV3c62Xpn6AkweJt4Kuy/wcAgbZvwaqH/ZMVV72OAIzUEPzEPJ0ed+P4piodr0pS4kgXN+XKdwDVTGIbH4KH9aGA7YlrhXHqZzpvhCLP1gD03uUHddmiLXjoVa/yhXJ6uY08s18DfP0gbwNNL+/xe+bZEEMxIHgpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830018; c=relaxed/simple;
	bh=3fjkbwm+GFV0zHVgXSIa+B2drODRTgvxYFA/fjRfZIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ra1ZdydvPWPKG9QFA5cqTxCF2rN2N4N+LBp/9w5xEUOEcU1HD+zK0aLmBbBZcsDdf8yfqfCN/WZ/fsFN1QfbU/yHmU2Ai5bfRfFK60F5Rlby5+PV9kwofr2C5a/iod1QjzEJbyZwx8FrNLJRNd8ZK4XALbI9GcPEHke9co1G/uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Zl35M1oK; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710830015; x=1742366015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3fjkbwm+GFV0zHVgXSIa+B2drODRTgvxYFA/fjRfZIY=;
  b=Zl35M1oK6JmuNgiKVn5BAhMvjsuzGi/7ZNI3nlXlDP2n0lyy37rmURYx
   y64nYDd71dN/cpINuLbCGr27529tJSpgsUVY7PNe6bi69OOvObhen71aD
   O8UlOGTLddFpfp0/on+yTjWCb2MCoIPYITL1XOis+z7XJuPQE1hffDraa
   25+aROxXdZz8WBWWctZs4Dk22zKPGDw2EJ3wgX7d+3GwX3bNwmtkgLPQd
   X1H4wRSWD1YSKTl31UUF2OGQkd9cbWPDFnt06/MeDf+ecjyrcgZ5YPcyn
   yZzCKzWBxEk0snjIv/10qUP8whBgbuHMu5wE/HX/PoZH+L7o6beh9w1fG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="131490898"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="131490898"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:24 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 39084C6814;
	Tue, 19 Mar 2024 15:32:22 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 75891D7B8E;
	Tue, 19 Mar 2024 15:32:21 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0E5C7228824;
	Tue, 19 Mar 2024 15:32:21 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 917DA1A006E;
	Tue, 19 Mar 2024 14:32:20 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 03/25] scsi: arcmsr: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:10 +0800
Message-Id: <20240319063132.1588443-3-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--11.184600-10.000000
X-TMASE-MatchedRID: yLHOPqhdQyUbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSD3F
	7iC1Qm2iWQSYYFGzuMEi2pD9yuITpE/E3DK2t5CrNE9DxPih7lWQ3R4k5PTnAN76LiU8zntm9FC
	Qm2VpcRrmwoem/bBUiEVUa6bapFqJH0YXYnbGozFEUknJ/kEl7dB/CxWTRRu25FeHtsUoHuUoKW
	kqZNnE74Q9Cm69pQ6j+lD9KVs8ryIfUnPwjOTEo2RRIMOrvjaQ==
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
 drivers/scsi/arcmsr/arcmsr_attr.c | 40 ++++++++-----------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_attr.c b/drivers/scsi/arcmsr/arcmsr_attr.c
index baeb5e795690..3dfbe771e8b9 100644
--- a/drivers/scsi/arcmsr/arcmsr_attr.c
+++ b/drivers/scsi/arcmsr/arcmsr_attr.c
@@ -258,9 +258,7 @@ static ssize_t
 arcmsr_attr_host_driver_version(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE,
-			"%s\n",
-			ARCMSR_DRIVER_VERSION);
+	return sysfs_emit(buf, "%s\n", ARCMSR_DRIVER_VERSION);
 }
 
 static ssize_t
@@ -270,9 +268,7 @@ arcmsr_attr_host_driver_posted_cmd(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			atomic_read(&acb->ccboutstandingcount));
+	return sysfs_emit(buf, "%4d\n", atomic_read(&acb->ccboutstandingcount));
 }
 
 static ssize_t
@@ -282,9 +278,7 @@ arcmsr_attr_host_driver_reset(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->num_resets);
+	return sysfs_emit(buf, "%4d\n", acb->num_resets);
 }
 
 static ssize_t
@@ -294,9 +288,7 @@ arcmsr_attr_host_driver_abort(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->num_aborts);
+	return sysfs_emit(buf, "%4d\n", acb->num_aborts);
 }
 
 static ssize_t
@@ -306,9 +298,7 @@ arcmsr_attr_host_fw_model(struct device *dev, struct device_attribute *attr,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%s\n",
-			acb->firm_model);
+	return sysfs_emit(buf, "%s\n", acb->firm_model);
 }
 
 static ssize_t
@@ -319,9 +309,7 @@ arcmsr_attr_host_fw_version(struct device *dev,
 	struct AdapterControlBlock *acb =
 			(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%s\n",
-			acb->firm_version);
+	return sysfs_emit(buf, "%s\n", acb->firm_version);
 }
 
 static ssize_t
@@ -332,9 +320,7 @@ arcmsr_attr_host_fw_request_len(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_request_len);
+	return sysfs_emit(buf, "%4d\n", acb->firm_request_len);
 }
 
 static ssize_t
@@ -345,9 +331,7 @@ arcmsr_attr_host_fw_numbers_queue(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_numbers_queue);
+	return sysfs_emit(buf, "%4d\n", acb->firm_numbers_queue);
 }
 
 static ssize_t
@@ -358,9 +342,7 @@ arcmsr_attr_host_fw_sdram_size(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_sdram_size);
+	return sysfs_emit(buf, "%4d\n", acb->firm_sdram_size);
 }
 
 static ssize_t
@@ -371,9 +353,7 @@ arcmsr_attr_host_fw_hd_channels(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_hd_channels);
+	return sysfs_emit(buf, "%4d\n", acb->firm_hd_channels);
 }
 
 static DEVICE_ATTR(host_driver_version, S_IRUGO, arcmsr_attr_host_driver_version, NULL);
-- 
2.29.2


