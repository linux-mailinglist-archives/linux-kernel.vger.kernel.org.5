Return-Path: <linux-kernel+bounces-167192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE08BA575
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A77E1F22B5F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADDF1BF2B;
	Fri,  3 May 2024 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXWCJImH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AC3F4FB;
	Fri,  3 May 2024 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714705056; cv=none; b=YMfDD/Fv+1N97vUm98dr8+zd0nSUiQZcciaLVJVCkG/5rgWtukzTEUavx/t2qlwJegG+8khVMQ9Hvl3xRBXM2I++H3xe/RqKE77ku07tpqpHoTMVXj3r7z5IiFcV2FeERWiQutLrg1nzqFv5t5a3vcazwzI3TRtxGZs6x58HyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714705056; c=relaxed/simple;
	bh=+GDVbMbQv6zlnk5/or4/AGb5I8MaOkuDHTVfuN81jSM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Qo9VNxK3rg18EccpnxzHfX9cM43eiTI1zPlBZWOhV+ihmig+AfYVEJuDXHRR4gE+ms19LDdGqWfwUeWbJ1D0civhwm3h+XL8SnKaZgsBpxe69P9EukCAB8NV01Rkq2UdFyYnYbXjeHhRtufmHjfsmHz3U2ocbRenMarHS6a3FO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXWCJImH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714705055; x=1746241055;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+GDVbMbQv6zlnk5/or4/AGb5I8MaOkuDHTVfuN81jSM=;
  b=aXWCJImHd4dhD9NiZLY9iAnL/3ABu4LX/TRkCgl5pF9/ZVlQmwuFZiD0
   9lLwGm8gxvSYSENGvlwKqr60Du+icWO6+3wb4P9eDwhMiGANLpdtzwt3Y
   SGyuhvzWRRgY8j5fX4whJonCkBCKmrIBOgFtCZ5a0f7mgjTnEDhtzavdm
   nenZUC1mrNeM8OimOE4OHUIjd+TJrJoTSjApM5uCW50gMTZmXaI18i14y
   nnJQQlzi4Qs9FoyzvotBh5QuCf3qJVkUJ7b3xo7Mi/eNosLRj3epZWhcF
   o6EjN1JCm0QGl1BA7UPmVaJ2aemyOdQnic46ENqf0SqXnvJQuVd9Sb6nE
   A==;
X-CSE-ConnectionGUID: SwHrv0fBRGKHhntEW4V10w==
X-CSE-MsgGUID: LrPPghpUTv+b+Okbu2WaMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10665243"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10665243"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 19:57:34 -0700
X-CSE-ConnectionGUID: y8+whhTHSEaiU2eRaivjLA==
X-CSE-MsgGUID: mU7cYB29SBS+4FmUbN70AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="58213937"
Received: from dnrajurk-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.209.33.137])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 19:57:34 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: linux-doc@vger.kernel.org,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/2] platform/x86/intel/sdsi: Add ioctl SPDM transport
Date: Thu,  2 May 2024 19:57:26 -0700
Message-Id: <20240503025727.10254-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel On Demand adds attestation and firmware measurement retrieval
services through use of the protocols defined the Security Protocols and
Data Measurement (SPDM) specification. SPDM messages exchanges are used to
authenticate On Demand hardware and to retrieve signed measurements of the
NVRAM state used to track feature provisioning and the NVRAM state used for
metering services. These allow software to verify the authenticity of the
On Demand hardware as well as the integrity of the reported silicon
configuration.

Add an ioctl interface for sending SPDM messages through the On Demand
mailbox. Provides commands to get a list of SPDM enabled devices, get the
message size limits for SPDM Requesters and Responders, and perform an SPDM
message exchange.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.0.1.pdf [1]
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   1 +
 drivers/platform/x86/intel/sdsi.c             | 210 +++++++++++++++++-
 include/uapi/linux/intel_sdsi.h               |  72 ++++++
 4 files changed, 283 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/intel_sdsi.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index c472423412bf..20dcc2dbcaf6 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -382,6 +382,7 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:mathieu.desnoyers@efficios.com>
 0xF8  all    arch/x86/include/uapi/asm/amd_hsmp.h                    AMD HSMP EPYC system management interface driver
                                                                      <mailto:nchatrad@amd.com>
+0xFC  all    linux/intel_sdsi.h
 0xFD  all    linux/dm-ioctl.h
 0xFE  all    linux/isst_if.h
 ====  =====  ======================================================= ================================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 3fb0fa67576d..e3865e61f302 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11165,6 +11165,7 @@ INTEL SDSI DRIVER
 M:	David E. Box <david.e.box@linux.intel.com>
 S:	Supported
 F:	drivers/platform/x86/intel/sdsi.c
+F:	include/uapi/linux/intel_sdsi.h
 F:	tools/arch/x86/intel_sdsi/
 F:	tools/testing/selftests/drivers/sdsi/
 
diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 277e4f4b20ac..bab6df0521b4 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -11,9 +11,12 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/iopoll.h>
+#include <linux/intel_sdsi.h>
 #include <linux/kernel.h>
+#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/pci.h>
@@ -42,6 +45,7 @@
 
 #define SDSI_ENABLED_FEATURES_OFFSET	16
 #define SDSI_FEATURE_SDSI		BIT(3)
+#define SDSI_FEATURE_ATTESTATION	BIT(12)
 #define SDSI_FEATURE_METERING		BIT(26)
 
 #define SDSI_SOCKET_ID_OFFSET		64
@@ -91,6 +95,7 @@ enum sdsi_command {
 	SDSI_CMD_PROVISION_CAP		= 0x0008,
 	SDSI_CMD_READ_STATE		= 0x0010,
 	SDSI_CMD_READ_METER		= 0x0014,
+	SDSI_CMD_ATTESTATION		= 0x1012,
 };
 
 struct sdsi_mbox_info {
@@ -109,12 +114,14 @@ struct disc_table {
 struct sdsi_priv {
 	struct mutex		mb_lock;	/* Mailbox access lock */
 	struct device		*dev;
+	struct miscdevice	miscdev;
 	void __iomem		*control_addr;
 	void __iomem		*mbox_addr;
 	void __iomem		*regs_addr;
 	int			control_size;
 	int			maibox_size;
 	int			registers_size;
+	int			id;
 	u32			guid;
 	u32			features;
 };
@@ -582,6 +589,94 @@ static const struct attribute_group sdsi_group = {
 };
 __ATTRIBUTE_GROUPS(sdsi);
 
+/* SPDM transport  */
+static int sdsi_spdm_exchange(void *private, const void *request,
+			      size_t request_sz, void *response,
+			      size_t response_sz)
+{
+	struct sdsi_priv *priv = private;
+	struct sdsi_mbox_info info = {};
+	size_t spdm_msg_size, size;
+	int ret;
+
+	/*
+	 * For the attestation command, the mailbox write size is the sum of:
+	 *     Size of the SPDM request payload, padded for qword alignment
+	 *     8 bytes for the mailbox command
+	 *     8 bytes for the actual (non-padded) size of the SPDM request
+	 */
+	if (request_sz > (SDSI_SIZE_WRITE_MSG - (2 * sizeof(u64))))
+		return -EOVERFLOW;
+
+	info.size = round_up(request_sz, sizeof(u64)) + 2 * sizeof(u64);
+
+	u64 *payload __free(kfree) = kzalloc(info.size, GFP_KERNEL);
+	if (!payload)
+		return -ENOMEM;
+
+	memcpy(payload, request, request_sz);
+
+	/* The non-padded SPDM payload size is the 2nd-to-last qword */
+	payload[(info.size / sizeof(u64)) - 2] = request_sz;
+
+	/* Attestation mailbox command is the last qword of payload buffer */
+	payload[(info.size / sizeof(u64)) - 1] = SDSI_CMD_ATTESTATION;
+
+	info.payload = payload;
+	info.buffer = response;
+
+	ret = mutex_lock_interruptible(&priv->mb_lock);
+	if (ret)
+		return ret;
+	ret = sdsi_mbox_write(priv, &info, &size);
+	mutex_unlock(&priv->mb_lock);
+
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The read size is the sum of:
+	 *     Size of the SPDM response payload, padded for qword alignment
+	 *     8 bytes for the actual (non-padded) size of the SPDM payload
+	 */
+
+	if (size < sizeof(u64)) {
+		dev_err(priv->dev,
+			"Attestation error: Mailbox reply size, %ld, too small\n",
+			size);
+		return -EPROTO;
+	}
+
+	if (!IS_ALIGNED(size, sizeof(u64))) {
+		dev_err(priv->dev,
+			"Attestation error: Mailbox reply size, %ld, is not aligned\n",
+			size);
+		return -EPROTO;
+	}
+
+	/*
+	 * Get the SPDM response size from the last QWORD and check it fits
+	 * with no more than 7 bytes of padding
+	 */
+	spdm_msg_size = ((u64 *)info.buffer)[(size - sizeof(u64)) / sizeof(u64)];
+	if (!in_range(size - spdm_msg_size - sizeof(u64), 0, 8)) {
+		dev_err(priv->dev,
+			"Attestation error: Invalid SPDM response size, %ld\n",
+			spdm_msg_size);
+		return -EPROTO;
+	}
+
+	if (spdm_msg_size > response_sz) {
+		dev_err(priv->dev, "Attestation error: Expected response size %ld, got %ld\n",
+			 response_sz, spdm_msg_size);
+		return -EOVERFLOW;
+	}
+
+	memcpy(response, info.buffer, spdm_msg_size);
+
+	return spdm_msg_size;
+}
+
 static int sdsi_get_layout(struct sdsi_priv *priv, struct disc_table *table)
 {
 	switch (table->guid) {
@@ -649,6 +744,92 @@ static int sdsi_map_mbox_registers(struct sdsi_priv *priv, struct pci_dev *paren
 	return 0;
 }
 
+#define SDSI_SPDM_DRIVER_VERSION	1
+
+static int sdsi_spdm_get_info(struct sdsi_priv *priv,
+			      struct sdsi_spdm_info __user *argp)
+{
+	struct sdsi_spdm_info info;
+
+	info.driver_version = SDSI_SPDM_DRIVER_VERSION;
+	info.api_version = priv->guid;
+	info.dev_no = priv->id;
+	info.max_request_size = SDSI_SIZE_WRITE_MSG - (2 * sizeof(u64));
+	info.max_response_size = SDSI_SIZE_READ_MSG - (sizeof(u64));
+
+	if (copy_to_user(argp, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int sdsi_spdm_do_command(struct sdsi_priv *priv,
+				struct sdsi_spdm_command __user *argp)
+{
+	u32 req_size, rsp_size;
+
+	if (get_user(req_size, &argp->size))
+		return -EFAULT;
+
+	if (req_size < 4 || req_size > sizeof(struct sdsi_spdm_message))
+		return -EINVAL;
+
+	struct sdsi_spdm_message *request __free(kfree) =
+		kmalloc(req_size, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+
+	struct sdsi_spdm_command *response __free(kfree) =
+		kmalloc(SDSI_SIZE_READ_MSG, GFP_KERNEL);
+	if (!response)
+		return -ENOMEM;
+
+	if (copy_from_user(request, &argp->message, req_size))
+		return -EFAULT;
+
+	rsp_size = sdsi_spdm_exchange(priv, request, req_size, response,
+				      SDSI_SIZE_READ_MSG);
+	if (rsp_size < 4)
+		return rsp_size;
+
+	if (put_user(rsp_size, &argp->size))
+		return -EFAULT;
+
+	if (copy_to_user(&argp->message, response, rsp_size))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long sdsi_spdm_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct sdsi_priv *priv;
+	long ret = -ENOTTY;
+
+	priv = container_of(file->private_data, struct sdsi_priv, miscdev);
+
+	switch (cmd) {
+	case SDSI_IF_SPDM_INFO:
+		ret = sdsi_spdm_get_info(priv,
+				(struct sdsi_spdm_info __user *)arg);
+		break;
+	case SDSI_IF_SPDM_COMMAND:
+		ret = sdsi_spdm_do_command(priv,
+				(struct sdsi_spdm_command __user *)arg);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations sdsi_spdm_ops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = sdsi_spdm_ioctl,
+};
+
 static int sdsi_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
 {
 	struct intel_vsec_device *intel_cap_dev = auxdev_to_ivdev(auxdev);
@@ -663,6 +844,7 @@ static int sdsi_probe(struct auxiliary_device *auxdev, const struct auxiliary_de
 		return -ENOMEM;
 
 	priv->dev = &auxdev->dev;
+	priv->id = auxdev->id;
 	mutex_init(&priv->mb_lock);
 	auxiliary_set_drvdata(auxdev, priv);
 
@@ -686,9 +868,35 @@ static int sdsi_probe(struct auxiliary_device *auxdev, const struct auxiliary_de
 	if (ret)
 		return ret;
 
+	/* Attestation miscdevice */
+	if (priv->features & SDSI_FEATURE_ATTESTATION) {
+		priv->miscdev.name = kasprintf(GFP_KERNEL, "isdsi%d", priv->id);
+		if (!priv->miscdev.name)
+			return -ENOMEM;
+
+		priv->miscdev.minor = MISC_DYNAMIC_MINOR;
+		priv->miscdev.fops = &sdsi_spdm_ops;
+
+		ret = misc_register(&priv->miscdev);
+		if (!ret) {
+			kfree_const(priv->miscdev.name);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
+static void sdsi_remove(struct auxiliary_device *auxdev)
+{
+	struct sdsi_priv *priv = auxiliary_get_drvdata(auxdev);
+
+	if (priv->features & SDSI_FEATURE_ATTESTATION) {
+		misc_deregister(&priv->miscdev);
+		kfree_const(priv->miscdev.name);
+	}
+}
+
 static const struct auxiliary_device_id sdsi_aux_id_table[] = {
 	{ .name = "intel_vsec.sdsi" },
 	{}
@@ -701,7 +909,7 @@ static struct auxiliary_driver sdsi_aux_driver = {
 	},
 	.id_table	= sdsi_aux_id_table,
 	.probe		= sdsi_probe,
-	/* No remove. All resources are handled under devm */
+	.remove		= sdsi_remove,
 };
 module_auxiliary_driver(sdsi_aux_driver);
 
diff --git a/include/uapi/linux/intel_sdsi.h b/include/uapi/linux/intel_sdsi.h
new file mode 100644
index 000000000000..de9e7f6c44c5
--- /dev/null
+++ b/include/uapi/linux/intel_sdsi.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Intel On Demand (SDSi) Interface for SPDM based attestation.
+ * Copyright (c) 2019, Intel Corporation.
+ * All rights reserved.
+ *
+ * Author: David E. Box <david.e.box@linux.intel.com>
+ */
+
+#ifndef __SDSI_H
+#define __SDSI_H
+
+#include <linux/types.h>
+
+/**
+ * struct sdsi_spdm_info - Define platform information
+ * @api_version:	Version of the firmware document, which this driver
+ *			can communicate
+ * @driver_version:	Driver version, which will help user to send right
+ *			commands. Even if the firmware is capable, driver may
+ *			not be ready
+ * @dev_no:		Returns the auxiliary device number the corresponding
+ *			sdsi instance
+ * @max_request_size:	Returns the maximum allowed size for SPDM request
+ *			messages
+ * @max_response_size:	Returns the maximum size of an SPDM response message
+ *
+ * Used to return output of IOCTL SDSI_SPDM_INFO. This
+ * information can be used by the user space, to get the driver, firmware
+ * support and also number of commands to send in a single IOCTL request.
+ */
+struct sdsi_spdm_info {
+	__u32 api_version;
+	__u16 driver_version;
+	__u16 dev_no;
+	__u16 max_request_size;
+	__u16 max_response_size;
+};
+
+/**
+ * struct sdsi_spdm_message - The SPDM message sent and received from the device
+ * @spdm_version:		Supported SPDM version
+ * @request_response_code:	The SPDM message code for requests and responses
+ * @param1:			Parameter 1
+ * @param2:			Parameter 2
+ * @buffer:			SDPM message specific buffer
+ *
+ */
+struct sdsi_spdm_message {
+	__u8 spdm_version;
+	__u8 request_response_code;
+	__u8 param1;
+	__u8 param2;
+	__u8 buffer[4092];
+};
+
+/**
+ * struct sdsi_spdm_command - The SPDM command
+ * @ size:		The size of the SPDM message
+ * @ message:		The SPDM message
+ *
+ * Used to return output of IOCTL SDSI_SPDM_COMMAND.
+ */
+struct sdsi_spdm_command {
+	__u32 size;
+	struct sdsi_spdm_message message;
+};
+
+#define SDSI_IF_MAGIC		0xFC
+#define SDSI_IF_SPDM_INFO	_IOR(SDSI_IF_MAGIC, 0, struct sdsi_spdm_info *)
+#define SDSI_IF_SPDM_COMMAND	_IOWR(SDSI_IF_MAGIC, 1, struct sdsi_spdm_command *)
+#endif

base-commit: 36dc58c367149680bed334e83ec54728f980a96e
-- 
2.34.1


