Return-Path: <linux-kernel+bounces-139674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A96E8A065C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2977B257E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEF513BAD2;
	Thu, 11 Apr 2024 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjfRco/v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA613B5AC;
	Thu, 11 Apr 2024 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804347; cv=none; b=dcIVAGIFG0uxLYYe7x/Vxddbgj8Mu/74FqyWMeT9uHti7XsVIOKzXvVd263Fm9i7MtPXv6bPDs6AFRHPqHlJd1MXElxNshnGzoRcgky0ankEEB3lybJ3kjMDCS79Lq+hB5koz2oYWJBoIoFy4e50KFfrD3cNk8V0pbkz8LFJdg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804347; c=relaxed/simple;
	bh=GRI1Am+HDcV5E55/vhWAP9RGEcZZJJ8EcYGuMRnlwSA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDF7Tol91DGtB75W8nxf68Bfv8dd9rV0CAWhw5US5sClkPFn87fnsgDYjEjVEevVQNgXPea+3OnlYeJj7mw4aVONCY4qCgvhYy/qjZ/WvxSDBoKw4xk0xMVeRdfjOdHkcMj3RQ4KeRhKIsNMFEv0WDaw2HCEeO2xTVKVSNbDkpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjfRco/v; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712804346; x=1744340346;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=GRI1Am+HDcV5E55/vhWAP9RGEcZZJJ8EcYGuMRnlwSA=;
  b=ZjfRco/vM74nNm+qHjfuTZmrpICcQbd61QnCCPmAEneD0DuZB0vGHIzC
   q8Vx4JoyyFKaovnsJ248CSl3fxIc8lYkm6BXgN7FxFvfEIEzw975zAAZb
   wRoBH03xxBLxykhxjKdZrhCJTFrGAArLf3p6BFe8f0ShJue6PLQ1eDGg/
   zenUK34avdMPDgEepE8OsFpX6/1kkAZJKZgAY/3pHsczbVd1HSNrQrdiA
   4lfUIuw/LECCduW1QgreGSdLY6/jP66auZcfx5KAAhac7GOyTe6LDS1hr
   XR+tX97QB1zYzk06mVv9TWdNkBcQr1UXhkN6dqhOS2PeVZ+EgRyvQtc3p
   A==;
X-CSE-ConnectionGUID: NY3wKzC0SZG7yj/B6fmOHQ==
X-CSE-MsgGUID: Dr4FmPKUSH2B2s3oofsFJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8054666"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8054666"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:03 -0700
X-CSE-ConnectionGUID: A5/CQYxZRC+WnD8KgPKDbw==
X-CSE-MsgGUID: 9O4dcwW+RwO7j8KBw12Jcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="51730473"
Received: from karczmac-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.255.229.250])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:03 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V4 2/9] platform/x86/intel/sdsi: Combine read and write mailbox flows
Date: Wed, 10 Apr 2024 19:58:49 -0700
Message-Id: <20240411025856.2782476-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411025856.2782476-1-david.e.box@linux.intel.com>
References: <20240411025856.2782476-1-david.e.box@linux.intel.com>
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
V4 - no changes

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


