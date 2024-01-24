Return-Path: <linux-kernel+bounces-36241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A058F839DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AFD1F2967E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C790D46B8;
	Wed, 24 Jan 2024 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="iIP0o2mv"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35073C3B;
	Wed, 24 Jan 2024 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057920; cv=none; b=tvXEZDjXhg6sPCmyCHBaVIsjhF/0E7gVv9LXi04XSlke4kMm8q6NUyoQUWJxPyMx7yT5Plf0+f74xzYy3UajY0wDWg5x9bV6XyJCFOnWrHZ87DLMcJPkTO3ivYFA4QRfY+pj506q3ufPZC18s9Na22zclEM+618VXUFm6ctIdc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057920; c=relaxed/simple;
	bh=0afrJ/uftX6Nq9Eow5vBIO/VvCEiQGqndgMtPqx2aco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m49nn17HmjhVVIbg+obWHJJ59/jV3TiyH99G15+Nm5VvcN47b1p1Fr0YIagKQ5QzSkNTc4mDp4ncfRQBkWQRDI87+ktVPOzfTi1TG+DYBczU64djNdLX8YK3BQjn9Nhbdon+TSbOq+BA77d9ASHjzQRh8QfGPidFnhJomAICXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=iIP0o2mv; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=oUXTx6PCjwpopSp5hsJS/fwxSNq/Qs+N3FA1Q73jh2c=; b=iIP0o2mvYtke4of5HpTYWx6VlE
	Sh6yOl5yvxhtSKUuhRSmREPdm5W47goV8nGyVpgZFxd+BCbGvztK6DtAcXympigwr/hYC+cZEY7gG
	46JY3WLXYoos5DnuH8XFmofKKt2/K1dqYo+mUQtElj7AlREQp2XRRQBcna6nPTspsNvV3VLNUDoCN
	NfU56VZYnkIr2i5lf1a7vNIV9zUSWuI6AKToCVrHafYPS9+Gzbigtu1y+5uTDuhHy/2LR3Eb0/t/k
	AysYzbjiv9g+Ynrv3lZYI9juC64FRlQxtaYV9+wV/NP4TKZGYymut8MfURH3t+Fj9Q79d/+/yhweu
	cM/3TTiA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSRLB-00DVeW-0r;
	Tue, 23 Jan 2024 18:42:05 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [RFC PATCH 1/9] ntsync: Introduce the ntsync driver and character device.
Date: Tue, 23 Jan 2024 18:40:20 -0600
Message-ID: <20240124004028.16826-2-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124004028.16826-1-zfigura@codeweavers.com>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntsync uses a misc device as the simplest and least intrusive uAPI interface.

Each file description on the device represents an isolated NT instance, intended
to correspond to a single NT virtual machine.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/Kconfig  |  9 ++++++++
 drivers/misc/Makefile |  1 +
 drivers/misc/ntsync.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 drivers/misc/ntsync.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4fb291f0bf7c..bdd8a71bd853 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -504,6 +504,15 @@ config OPEN_DICE
 	  measured boot flow. Userspace can use CDIs for remote attestation
 	  and sealing.
 
+config NTSYNC
+	tristate "NT synchronization primitive emulation"
+	help
+	  This module provides kernel support for emulation of Windows NT
+	  synchronization primitives. It is not a hardware driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ntsync.
+
 	  If unsure, say N.
 
 config VCPU_STALL_DETECTOR
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index ea6ea5bbbc9c..153a3f4837e8 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_PVPANIC)   	+= pvpanic/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
+obj-$(CONFIG_NTSYNC)		+= ntsync.o
 obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
 obj-$(CONFIG_GP_PCI1XXXX)	+= mchp_pci1xxxx/
diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
new file mode 100644
index 000000000000..9424c6210e51
--- /dev/null
+++ b/drivers/misc/ntsync.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ntsync.c - Kernel driver for NT synchronization primitives
+ *
+ * Copyright (C) 2021-2022 Elizabeth Figura
+ */
+
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+
+#define NTSYNC_NAME	"ntsync"
+
+static int ntsync_char_open(struct inode *inode, struct file *file)
+{
+	return nonseekable_open(inode, file);
+}
+
+static int ntsync_char_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
+			      unsigned long parm)
+{
+	switch (cmd) {
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+static const struct file_operations ntsync_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ntsync_char_open,
+	.release	= ntsync_char_release,
+	.unlocked_ioctl	= ntsync_char_ioctl,
+	.compat_ioctl	= ntsync_char_ioctl,
+	.llseek		= no_llseek,
+};
+
+static struct miscdevice ntsync_misc = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= NTSYNC_NAME,
+	.fops		= &ntsync_fops,
+};
+
+module_misc_device(ntsync_misc);
+
+MODULE_AUTHOR("Elizabeth Figura");
+MODULE_DESCRIPTION("Kernel driver for NT synchronization primitives");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("devname:" NTSYNC_NAME);
-- 
2.43.0


