Return-Path: <linux-kernel+bounces-132378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89848993CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA752896D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C8D22616;
	Fri,  5 Apr 2024 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JM7dRz8s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B641C69E;
	Fri,  5 Apr 2024 03:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287517; cv=none; b=VwOE+JPP+6mqmKE8/MtSS53zEubQ+L3Gc6s4b9raWvUxaL9oDvxY7dDIIpVsGlX9q1VZskmGZFmcilsNjSn+iZpu9stU7mOqOJN9EW5cgcpm+DLA0eYGVpPZ7T+kLzxegCvHCXMmr0oJD9reTMNf7wvD6MHiROhRehVyLW6Ak1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287517; c=relaxed/simple;
	bh=bHHdCOZqXbgYmG6B4RYvVRb/VX16Z/JRQ3gWhdccBsc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHHWDxPQfINOVRmwa/tb/JeXH1qGqB7vD937FdEWkvf7lA3UciH9GG6X+xHblrtJaYjAmwqHVI9XmCCzOCvf5sD8dZ1B28FFh1Xdwkxq0S3z/NZ6cAzOKZp02NUXPxiI7T42KTTQa378DJJZCwiLDaBYgnc3nZWy3uzArHe70IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JM7dRz8s; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712287516; x=1743823516;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=bHHdCOZqXbgYmG6B4RYvVRb/VX16Z/JRQ3gWhdccBsc=;
  b=JM7dRz8sWvDm3pPqALeCS7WkNmyIrcW3Rmdlw7Wh0Ju5xLCy8xkzcqZ9
   UWRwiLGx9+6EROdMw98Z+gKh8/rgnvdGe8ZKq1Pa/f8pLukpJVz5KtcCr
   ypNSiXhGmM8y6e2DwfDg87AeCk3AbcFQsbQY+RtH/nTeUnwUSEEuv4QXU
   6Vt/8ocsVypiJ+q6ZoZYUwlUi5se0Ao9GENZ5U4CEguItuVqg4d0a9IQ4
   xbF4xKHmoIJB9/OFobZVErAdHN5LJPVnljEpwZR5pXUs4cLsCS3bsjb44
   9jLtxPQQoBp2zYI+HJQf7CA3YgG3PHTqb1UWpIzrHaqftQcvq0X9HxZdC
   w==;
X-CSE-ConnectionGUID: iIZtYh4oQl6eX+/cQdIz9g==
X-CSE-MsgGUID: HYRL9XX1QiqtvuzgGs+G5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25112464"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="25112464"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:14 -0700
X-CSE-ConnectionGUID: edggZg0PRXujahysEDSQBA==
X-CSE-MsgGUID: 6/mDPYQqTcqeXTFXbzs79A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18955983"
Received: from alexpabo-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.209.49.45])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:13 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V3 4/9] platform/x86/intel/sdsi: Add attribute to read the current meter state
Date: Thu,  4 Apr 2024 20:25:02 -0700
Message-Id: <20240405032507.2637311-5-david.e.box@linux.intel.com>
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

The meter_certificate file provides access to metering information that may
be attested but is only updated every 8 hours. Add new attribute,
meter_current, to allow reading an untested snapshot of the current values.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

V3 - no changes

V2 - make control_flags a parameter to be eventually passed to
     sdsi_mbox_cmd_read(). This removes the need for a lock which had been
     added to protect control_flags when it was a member of the private
     struct.

 drivers/platform/x86/intel/sdsi.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index bb3eaf5eb382..277e4f4b20ac 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -68,6 +68,7 @@
 #define CTRL_COMPLETE			BIT(6)
 #define CTRL_READY			BIT(7)
 #define CTRL_INBAND_LOCK		BIT(32)
+#define CTRL_METER_ENABLE_DRAM		BIT(33)
 #define CTRL_STATUS			GENMASK(15, 8)
 #define CTRL_PACKET_SIZE		GENMASK(31, 16)
 #define CTRL_MSG_SIZE			GENMASK(63, 48)
@@ -95,6 +96,7 @@ enum sdsi_command {
 struct sdsi_mbox_info {
 	u64	*payload;
 	void	*buffer;
+	u64	control_flags;
 	int	size;
 };
 
@@ -250,7 +252,8 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 	control = FIELD_PREP(CTRL_EOM, 1) |
 		  FIELD_PREP(CTRL_SOM, 1) |
 		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
-		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
+		  FIELD_PREP(CTRL_PACKET_SIZE, info->size) |
+		  info->control_flags;
 	writeq(control, priv->control_addr);
 
 	return sdsi_mbox_poll(priv, info, data_size);
@@ -424,8 +427,8 @@ static ssize_t provision_cap_write(struct file *filp, struct kobject *kobj,
 static BIN_ATTR_WO(provision_cap, SDSI_SIZE_WRITE_MSG);
 
 static ssize_t
-certificate_read(u64 command, struct sdsi_priv *priv, char *buf, loff_t off,
-		 size_t count)
+certificate_read(u64 command, u64 control_flags, struct sdsi_priv *priv,
+		 char *buf, loff_t off, size_t count)
 {
 	struct sdsi_mbox_info info = {};
 	size_t size;
@@ -441,6 +444,7 @@ certificate_read(u64 command, struct sdsi_priv *priv, char *buf, loff_t off,
 
 	info.payload = &command;
 	info.size = sizeof(command);
+	info.control_flags = control_flags;
 
 	ret = mutex_lock_interruptible(&priv->mb_lock);
 	if (ret)
@@ -472,7 +476,7 @@ state_certificate_read(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct sdsi_priv *priv = dev_get_drvdata(dev);
 
-	return certificate_read(SDSI_CMD_READ_STATE, priv, buf, off, count);
+	return certificate_read(SDSI_CMD_READ_STATE, 0, priv, buf, off, count);
 }
 static BIN_ATTR_ADMIN_RO(state_certificate, SDSI_SIZE_READ_MSG);
 
@@ -484,10 +488,23 @@ meter_certificate_read(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct sdsi_priv *priv = dev_get_drvdata(dev);
 
-	return certificate_read(SDSI_CMD_READ_METER, priv, buf, off, count);
+	return certificate_read(SDSI_CMD_READ_METER, 0, priv, buf, off, count);
 }
 static BIN_ATTR_ADMIN_RO(meter_certificate, SDSI_SIZE_READ_MSG);
 
+static ssize_t
+meter_current_read(struct file *filp, struct kobject *kobj,
+		   struct bin_attribute *attr, char *buf, loff_t off,
+		   size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct sdsi_priv *priv = dev_get_drvdata(dev);
+
+	return certificate_read(SDSI_CMD_READ_METER, CTRL_METER_ENABLE_DRAM,
+				priv, buf, off, count);
+}
+static BIN_ATTR_ADMIN_RO(meter_current, SDSI_SIZE_READ_MSG);
+
 static ssize_t registers_read(struct file *filp, struct kobject *kobj,
 			      struct bin_attribute *attr, char *buf, loff_t off,
 			      size_t count)
@@ -518,6 +535,7 @@ static struct bin_attribute *sdsi_bin_attrs[] = {
 	&bin_attr_registers,
 	&bin_attr_state_certificate,
 	&bin_attr_meter_certificate,
+	&bin_attr_meter_current,
 	&bin_attr_provision_akc,
 	&bin_attr_provision_cap,
 	NULL
@@ -537,7 +555,7 @@ sdsi_battr_is_visible(struct kobject *kobj, struct bin_attribute *attr, int n)
 	if (!(priv->features & SDSI_FEATURE_SDSI))
 		return 0;
 
-	if (attr == &bin_attr_meter_certificate)
+	if (attr == &bin_attr_meter_certificate || attr == &bin_attr_meter_current)
 		return (priv->features & SDSI_FEATURE_METERING) ?
 				attr->attr.mode : 0;
 
-- 
2.34.1


