Return-Path: <linux-kernel+bounces-139677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 941738A0661
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2190C1F229FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7839C13BC32;
	Thu, 11 Apr 2024 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LV0KoV72"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F9413B7AB;
	Thu, 11 Apr 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804349; cv=none; b=f82wlghtnyLqyWIeDGsgaNNCdCoAi6wtBimAmDmbzGQgcmIngzElSwSTFwNt/q16Cfa456FkEx2w1qEkuEt+gKLMoDyzHggjJwG/5dtQn3etB+ZmnzAJmdfAyRTkZXIGLHClFqF1LN3HDnJm4krGGFUWWdS27MEzXodPULW2jac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804349; c=relaxed/simple;
	bh=myCBN7WnVhoxK1HClgR64flV58qecEVOIS7fjAYUa+U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iApnfOKvlZLX+z+UoP3QI3XX8BSfeYrSGjkgf2g8GBg7SfUguR4QGQCfdK223A5RyfuQE7Id172vv1NfJqYTe6cRlvYUE4NQgUQRsyOz+I1nubDjalQy9b43Xg+b0PuNMvNcXGtLhho2VSVVuxx0cgj9k6oCsExFl4PQGxjgpUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LV0KoV72; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712804348; x=1744340348;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=myCBN7WnVhoxK1HClgR64flV58qecEVOIS7fjAYUa+U=;
  b=LV0KoV72kdC4CeHK6S1ZU1Wm3F6IV7Mfp7pAsTIGfNYJ92bfozp+y+Pq
   DfOJgcGR4LxrhM6PO8ge38y6GbE0Xx4Q8UHgelt3MUtIs48a/MiLUIKnu
   QujU1sT4E6TvLHf2MQxneOsT8nJnuSYWAaTIBHa85nrkE9irOu1ZcMGbq
   tjnpAGOi020qf0Xyer5eq9qix6VRzHOso8eXBpgdcu99rRY11wHAlhZHI
   Oi0fvWNU6ZzGrqCUaIEO1UC3Oz47hCZpvO9I79BRnHOntqzexwGtoBnPg
   7r3hNpDy3qPxy7wSMjCHh/BhAo++eIQbn0ZzvaNf5hWh4TCA/X79dKpEG
   w==;
X-CSE-ConnectionGUID: fiNTKs/KRmiRmgHAevuqDw==
X-CSE-MsgGUID: 3vi7lzGLQl6SPgVmoWMH4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8054670"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8054670"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:04 -0700
X-CSE-ConnectionGUID: zXVoJt2wTJ2kYhMJjp/atQ==
X-CSE-MsgGUID: lP86P4obQWaq79w+x/WLHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="51730477"
Received: from karczmac-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.255.229.250])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:04 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V4 4/9] platform/x86/intel/sdsi: Add attribute to read the current meter state
Date: Wed, 10 Apr 2024 19:58:51 -0700
Message-Id: <20240411025856.2782476-5-david.e.box@linux.intel.com>
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

The meter_certificate file provides access to metering information that may
be attested but is only updated every 8 hours. Add new attribute,
meter_current, to allow reading an untested snapshot of the current values.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V4 - no changes

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


