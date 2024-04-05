Return-Path: <linux-kernel+bounces-132376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C958993C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8021F25D3E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A8D21A0D;
	Fri,  5 Apr 2024 03:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sqrh8oeb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768F819BA3;
	Fri,  5 Apr 2024 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287516; cv=none; b=URuoBEKIwjk/onW34dfdnIYMjeCzX7aWZgbAkD8Mi8R4QB8MsHqJt28kRUXfcqpVbMDt1jKFw7xXun+Cx8EbGQybVUN8PjKeFHJ7Rjgk/VA3bXWugSkIRqHqAu0HNYc+6MyPRdmaE6m6d26ZLntNyRO5ZTXSD9bs30Hj+jLg0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287516; c=relaxed/simple;
	bh=+iKqhyKGkVXoEkYfsk73JGBa7Q1p8wyiM3+c4v3R6fM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPCISybpHfZZDZp2yw+FkTAMiYQvE+pu3GPetWqE7NeDOghiUJ8r7OBUaL4VeKAiLLwq4h2RogQIt/7nxr1OQsWG8U+Iohv1YiKxarscsHhQj1oqx7kEUNW8kqkqLnxsE/D1tZg664JyqDCQwo/v86O5V42ZBSnayBRYeDgDIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sqrh8oeb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712287515; x=1743823515;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+iKqhyKGkVXoEkYfsk73JGBa7Q1p8wyiM3+c4v3R6fM=;
  b=Sqrh8oebtLFv9W9Y4XsGJdK81yX2Ts97dZ6VgdiXom1J93CGNprWlvOi
   YoQRst0VPzIewbaQN9hDOcdOnu2eJ6mLEnA5zEVPR53KgZqdkPNlDR38k
   malIfAcpPsnUHWSs4wGv7fnS6iY4ya3zJymZS2lY8Kf9XKXoEwdktZv5g
   O8eCmJFURT2V/Z4Sv72rDmzgliy/qnNJXcw9EN7SmSzUGiXNnQgjV9RfS
   GQ07C4ylnK5aISCpAxMU1xzij8up4E5YnkGN5eD2tto7VJh1Kf3lfQJdo
   feQvsM6TJkp0QPCPflUkyBukQ2Hc78RoGAYCyn3NK3g21AB6RKGort1gV
   A==;
X-CSE-ConnectionGUID: p5ryTvHFTAK0T/qcu51pcg==
X-CSE-MsgGUID: 67E9NHJ9TAGOCl1uCl0pwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25112460"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="25112460"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:13 -0700
X-CSE-ConnectionGUID: 73q662uYQsKStkzF0PtXlg==
X-CSE-MsgGUID: algKtaajQR2V/A8Dn1EtMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18955981"
Received: from alexpabo-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.209.49.45])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:12 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V3 2/9] platform/x86/intel/sdsi: Combine read and write mailbox flows
Date: Thu,  4 Apr 2024 20:25:00 -0700
Message-Id: <20240405032507.2637311-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405032507.2637311-1-david.e.box@linux.intel.com>
References: <20240405032507.2637311-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current mailbox commands are either read-only or write-only and the
flow is different for each. New commands will need to send and receive
data. In preparation for these commands, create a common polling function
to handle sending data and receiving in the same transaction.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

V3 - no changes

V2 - In sdsi_cmd_read() remove unnecessary check for non-zero packet_size
     in do loop since the loop is exited earlier when packet_size is
     zero.

 drivers/platform/x86/intel/sdsi.c | 79 +++++++++++++++++--------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index a70c071de6e2..d80c2dc0ce71 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -15,6 +15,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -156,8 +157,8 @@ static int sdsi_status_to_errno(u32 status)
 	}
 }
 
-static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
-			      size_t *data_size)
+static int sdsi_mbox_poll(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
+			  size_t *data_size)
 {
 	struct device *dev = priv->dev;
 	u32 total, loop, eom, status, message_size;
@@ -166,18 +167,10 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 
 	lockdep_assert_held(&priv->mb_lock);
 
-	/* Format and send the read command */
-	control = FIELD_PREP(CTRL_EOM, 1) |
-		  FIELD_PREP(CTRL_SOM, 1) |
-		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
-		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
-	writeq(control, priv->control_addr);
-
 	/* For reads, data sizes that are larger than the mailbox size are read in packets. */
 	total = 0;
 	loop = 0;
 	do {
-		void *buf = info->buffer + (SDSI_SIZE_MAILBOX * loop);
 		u32 packet_size;
 
 		/* Poll on ready bit */
@@ -195,6 +188,11 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 		if (ret)
 			break;
 
+		if (!packet_size) {
+			sdsi_complete_transaction(priv);
+			break;
+		}
+
 		/* Only the last packet can be less than the mailbox size. */
 		if (!eom && packet_size != SDSI_SIZE_MAILBOX) {
 			dev_err(dev, "Invalid packet size\n");
@@ -208,9 +206,13 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 			break;
 		}
 
-		sdsi_memcpy64_fromio(buf, priv->mbox_addr, round_up(packet_size, SDSI_SIZE_CMD));
+		if (info->buffer) {
+			void *buf = info->buffer + array_size(SDSI_SIZE_MAILBOX, loop);
 
-		total += packet_size;
+			sdsi_memcpy64_fromio(buf, priv->mbox_addr,
+					     round_up(packet_size, SDSI_SIZE_CMD));
+			total += packet_size;
+		}
 
 		sdsi_complete_transaction(priv);
 	} while (!eom && ++loop < MBOX_MAX_PACKETS);
@@ -230,16 +232,33 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 		dev_warn(dev, "Read count %u differs from expected count %u\n",
 			 total, message_size);
 
-	*data_size = total;
+	if (data_size)
+		*data_size = total;
 
 	return 0;
 }
 
-static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
+static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
+			      size_t *data_size)
+{
+	u64 control;
+
+	lockdep_assert_held(&priv->mb_lock);
+
+	/* Format and send the read command */
+	control = FIELD_PREP(CTRL_EOM, 1) |
+		  FIELD_PREP(CTRL_SOM, 1) |
+		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
+		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
+	writeq(control, priv->control_addr);
+
+	return sdsi_mbox_poll(priv, info, data_size);
+}
+
+static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
+			       size_t *data_size)
 {
 	u64 control;
-	u32 status;
-	int ret;
 
 	lockdep_assert_held(&priv->mb_lock);
 
@@ -256,20 +275,7 @@ static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *in
 		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
 	writeq(control, priv->control_addr);
 
-	/* Poll on ready bit */
-	ret = readq_poll_timeout(priv->control_addr, control, control & CTRL_READY,
-				 MBOX_POLLING_PERIOD_US, MBOX_TIMEOUT_US);
-
-	if (ret)
-		goto release_mbox;
-
-	status = FIELD_GET(CTRL_STATUS, control);
-	ret = sdsi_status_to_errno(status);
-
-release_mbox:
-	sdsi_complete_transaction(priv);
-
-	return ret;
+	return sdsi_mbox_poll(priv, info, data_size);
 }
 
 static int sdsi_mbox_acquire(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
@@ -313,7 +319,8 @@ static int sdsi_mbox_acquire(struct sdsi_priv *priv, struct sdsi_mbox_info *info
 	return ret;
 }
 
-static int sdsi_mbox_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
+static int sdsi_mbox_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
+			   size_t *data_size)
 {
 	int ret;
 
@@ -323,7 +330,7 @@ static int sdsi_mbox_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
 	if (ret)
 		return ret;
 
-	return sdsi_mbox_cmd_write(priv, info);
+	return sdsi_mbox_cmd_write(priv, info, data_size);
 }
 
 static int sdsi_mbox_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info, size_t *data_size)
@@ -342,7 +349,7 @@ static int sdsi_mbox_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info, s
 static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
 			      enum sdsi_command command)
 {
-	struct sdsi_mbox_info info;
+	struct sdsi_mbox_info info = {};
 	int ret;
 
 	if (count > (SDSI_SIZE_WRITE_MSG - SDSI_SIZE_CMD))
@@ -364,7 +371,9 @@ static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
 	ret = mutex_lock_interruptible(&priv->mb_lock);
 	if (ret)
 		goto free_payload;
-	ret = sdsi_mbox_write(priv, &info);
+
+	ret = sdsi_mbox_write(priv, &info, NULL);
+
 	mutex_unlock(&priv->mb_lock);
 
 free_payload:
@@ -408,7 +417,7 @@ static ssize_t
 certificate_read(u64 command, struct sdsi_priv *priv, char *buf, loff_t off,
 		 size_t count)
 {
-	struct sdsi_mbox_info info;
+	struct sdsi_mbox_info info = {};
 	size_t size;
 	int ret;
 
-- 
2.34.1


