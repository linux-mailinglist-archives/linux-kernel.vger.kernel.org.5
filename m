Return-Path: <linux-kernel+bounces-46922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CEE844664
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0CE1F2175C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB9F12F5A7;
	Wed, 31 Jan 2024 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGcTu6Tl"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA0412DDB9
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723049; cv=none; b=hruSEhmcV/TtJrAHcZFIymSoTVWm3VrbKJbRpJ88rOuEDTsdfGOS1/0QRvWFF8d7s25LEAGiOj5LHkBJeoQKpZEFGeFiUKqQSPtkgJ1IXxSqa850McEJPMsuMz6aZFKvfddQiYbzyv4kfgSi6/r9dUSTWCTv/NGV3RIem9ArW3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723049; c=relaxed/simple;
	bh=/DSW7L5OGPzDoGMA8pPtVJvjUJ9Qv0Fcto0wMyEt2mY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beqL63jg9RwdbSZyoRzPq7rP8aZrm69U7cnkypLg6AwSoK2pSon1wX0Fg0DB/AfgHB9PNybADXaEnQb7/Ns0OaRMQGtWrjWbZ3vr93Sq6TQ/jQtEC6VjoxNG7Fw3ZIxLXfo/RiWWkkL9syl9/2GVyx5azeO2DXafd2bamghPtlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DGcTu6Tl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f15762840so29190a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706723045; x=1707327845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WcHu0BYfrrt6l6mr9lRenbRkMitnIQPl7dRpqtgNOc=;
        b=DGcTu6TlBbDveqT1lPOYXMciX8PlBskyZUmhCz8xFTvZpLy034e1Mu9ZZ8FcO1hzsM
         RFvYsKCAuuscnoWVRYlSfBbfBuA37A1FDYpJylBakYWd5j7OImLAKjFjqljamdFngBRw
         VNbTZjrKuJcSgvKN7lvE6j5i2AxXq4cQYG9+PebwkI8ns2wmF4WN+6Skx59CFEwZeVNZ
         DqIsg02KqQ9zQeKWxCzj1NPRAA65XsjnrTjMpddrPJy1SVPolEffiOsoJMcIyWD9i1kJ
         cYwziir2R5ndDufP9PjNhD8Dk9Pe7tLN8MY2uLtQwdWJRuEFMiRQrR4XEufYXKNZ/CqK
         GHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706723045; x=1707327845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WcHu0BYfrrt6l6mr9lRenbRkMitnIQPl7dRpqtgNOc=;
        b=VgHd6z8qxFbijD6emYa0E1vKuSUZYoiyn268WZmgyct6/dHDph1PoEV87CEGaHkD2P
         6Y2yF56tVOLqp7k75qCgD4b/Gm5q/b+HkHqO3R1kUA2LYQYN/fgKs3BYEkndU8W7iSCf
         e6H3MX+xqdpC1r2iYr09tKBYiLHKPpc+gyYiTQzjMC4/jYxS2TVuuD0lwp1vsEoHVN/r
         y3fr1b2kOaN04A3S2M03S0cXsb/qf3SU9cDt7WfqKX2OZ73NF68kMninKDj9RnBvC25p
         ASlhQ/3n7TJlMQPi9a3nkLy8amYTiWKbl5Qm5JKWUmtqEegXw5GqGUVED3NB3g8d1u6C
         f3TA==
X-Gm-Message-State: AOJu0Ywb9szDbpZf0VBk3vTIQHojDiDSnxO+zOv9Vy4P8OAkkymdPgA6
	ZEeUq2IBS9rfJB5Y64rclz0A6L5C38Ab7hVEcFr0R9GFkLUcNwk5pAbifdxyjqSOEWOnN9LoGlC
	s
X-Google-Smtp-Source: AGHT+IG5QSruOO5vbmL0jNwrvcR+xfh3XqbZqVvnRVUq5XhPauxJl5fXKPXhn3V32TFAGf5JZqnilA==
X-Received: by 2002:a05:6402:1850:b0:55e:e838:a20e with SMTP id v16-20020a056402185000b0055ee838a20emr1622696edy.25.1706723044579;
        Wed, 31 Jan 2024 09:44:04 -0800 (PST)
Received: from localhost.localdomain (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id o11-20020a056402444b00b0055d3d1653b3sm5712985edb.31.2024.01.31.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 09:44:04 -0800 (PST)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Wed, 31 Jan 2024 18:43:45 +0100
Message-Id: <20240131174347.510961-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131174347.510961-1-jens.wiklander@linaro.org>
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A number of storage technologies support a specialised hardware
partition designed to be resistant to replay attacks. The underlying
HW protocols differ but the operations are common. The RPMB partition
cannot be accessed via standard block layer, but by a set of specific
RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
partition provides authenticated and replay protected access, hence
suitable as a secure storage.

The initial aim of this patch is to provide a simple RPMB Driver which
can be accessed by the optee driver to facilitate early RPMB access to
OP-TEE OS (secure OS) during the boot time.

A TEE device driver can claim the RPMB interface, for example, via
class_interface_register() or rpmb_dev_find_device(). The RPMB driver
provides a callback to route RPMB frames to the RPMB device accessible
via rpmb_route_frames().

The detailed operation of implementing the access is left to the TEE
device driver itself.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 MAINTAINERS              |   7 ++
 drivers/misc/Kconfig     |   9 ++
 drivers/misc/Makefile    |   1 +
 drivers/misc/rpmb-core.c | 247 +++++++++++++++++++++++++++++++++++++++
 include/linux/rpmb.h     | 184 +++++++++++++++++++++++++++++
 5 files changed, 448 insertions(+)
 create mode 100644 drivers/misc/rpmb-core.c
 create mode 100644 include/linux/rpmb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8999497011a2..e83152c42499 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19012,6 +19012,13 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de2-rotate.yaml
 F:	drivers/media/platform/sunxi/sun8i-rotate/
 
+RPMB SUBSYSTEM
+M:	Jens Wiklander <jens.wiklander@linaro.org>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/misc/rpmb-core.c
+F:	include/linux/rpmb.h
+
 RPMSG TTY DRIVER
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
 L:	linux-remoteproc@vger.kernel.org
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4fb291f0bf7c..891aa5763666 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -104,6 +104,15 @@ config PHANTOM
 	  If you choose to build module, its name will be phantom. If unsure,
 	  say N here.
 
+config RPMB
+	tristate "RPMB partition interface"
+	help
+	  Unified RPMB unit interface for RPMB capable devices such as eMMC and
+	  UFS. Provides interface for in kernel security controllers to access
+	  RPMB unit.
+
+	  If unsure, select N.
+
 config TIFM_CORE
 	tristate "TI Flash Media interface support"
 	depends on PCI
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index ea6ea5bbbc9c..8af058ad1df4 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_LKDTM)		+= lkdtm/
 obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
 obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
 obj-$(CONFIG_PHANTOM)		+= phantom.o
+obj-$(CONFIG_RPMB)		+= rpmb-core.o
 obj-$(CONFIG_QCOM_COINCELL)	+= qcom-coincell.o
 obj-$(CONFIG_QCOM_FASTRPC)	+= fastrpc.o
 obj-$(CONFIG_SENSORS_BH1770)	+= bh1770glc.o
diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
new file mode 100644
index 000000000000..a3c289051687
--- /dev/null
+++ b/drivers/misc/rpmb-core.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved.
+ * Copyright(c) 2021 - 2024 Linaro Ltd.
+ */
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/rpmb.h>
+#include <linux/slab.h>
+
+static DEFINE_IDA(rpmb_ida);
+static DEFINE_MUTEX(rpmb_mutex);
+
+/**
+ * rpmb_dev_get() - increase rpmb device ref counter
+ * @rdev: rpmb device
+ */
+struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
+{
+	if (rdev)
+		get_device(&rdev->dev);
+	return rdev;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_get);
+
+/**
+ * rpmb_dev_put() - decrease rpmb device ref counter
+ * @rdev: rpmb device
+ */
+void rpmb_dev_put(struct rpmb_dev *rdev)
+{
+	if (rdev)
+		put_device(&rdev->dev);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_put);
+
+/**
+ * rpmb_route_frames() - route rpmb frames to rpmb device
+ * @rdev:	rpmb device
+ * @req:	rpmb request frames
+ * @req_len:	length of rpmb request frames in bytes
+ * @rsp:	rpmb response frames
+ * @rsp_len:	length of rpmb response frames in bytes
+ *
+ * @return < 0 on failure
+ */
+int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
+		      unsigned int req_len, u8 *rsp, unsigned int rsp_len)
+{
+	struct rpmb_frame *frm = (struct rpmb_frame *)req;
+	u16 req_type;
+	bool write;
+
+	if (!req || req_len < sizeof(*frm) || !rsp || !rsp_len)
+		return -EINVAL;
+
+	req_type = be16_to_cpu(frm->req_resp);
+	switch (req_type) {
+	case RPMB_PROGRAM_KEY:
+		if (req_len != sizeof(struct rpmb_frame) ||
+		    rsp_len != sizeof(struct rpmb_frame))
+			return -EINVAL;
+		write = true;
+		break;
+	case RPMB_GET_WRITE_COUNTER:
+		if (req_len != sizeof(struct rpmb_frame) ||
+		    rsp_len != sizeof(struct rpmb_frame))
+			return -EINVAL;
+		write = false;
+		break;
+	case RPMB_WRITE_DATA:
+		if (req_len % sizeof(struct rpmb_frame) ||
+		    rsp_len != sizeof(struct rpmb_frame))
+			return -EINVAL;
+		write = true;
+		break;
+	case RPMB_READ_DATA:
+		if (req_len != sizeof(struct rpmb_frame) ||
+		    rsp_len % sizeof(struct rpmb_frame))
+			return -EINVAL;
+		write = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rdev->ops->route_frames(rdev->dev.parent, write,
+				       req, req_len, rsp, rsp_len);
+}
+EXPORT_SYMBOL_GPL(rpmb_route_frames);
+
+static void rpmb_dev_release(struct device *dev)
+{
+	struct rpmb_dev *rdev = to_rpmb_dev(dev);
+
+	rdev->ops->put_resources(rdev->dev.parent);
+	mutex_lock(&rpmb_mutex);
+	ida_simple_remove(&rpmb_ida, rdev->id);
+	mutex_unlock(&rpmb_mutex);
+	kfree(rdev->dev_id);
+	kfree(rdev);
+}
+
+struct class rpmb_class = {
+	.name = "rpmb",
+	.dev_release = rpmb_dev_release,
+};
+EXPORT_SYMBOL(rpmb_class);
+
+/**
+ * rpmb_dev_find_device() - return first matching rpmb device
+ * @data: data for the match function
+ * @match: the matching function
+ *
+ * @returns a matching rpmb device or NULL on failure
+ */
+struct rpmb_dev *rpmb_dev_find_device(const void *data,
+				      const struct rpmb_dev *start,
+				      int (*match)(struct device *dev,
+						   const void *data))
+{
+	struct device *dev;
+	const struct device *start_dev = NULL;
+
+	if (start)
+		start_dev = &start->dev;
+	dev = class_find_device(&rpmb_class, start_dev, data, match);
+
+	return dev ? to_rpmb_dev(dev) : NULL;
+}
+
+/**
+ * rpmb_dev_unregister() - unregister RPMB partition from the RPMB subsystem
+ * @rdev: the rpmb device to unregister
+ *
+ * @returns < 0 on failure
+ */
+int rpmb_dev_unregister(struct rpmb_dev *rdev)
+{
+	if (!rdev)
+		return -EINVAL;
+
+	device_del(&rdev->dev);
+
+	rpmb_dev_put(rdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_unregister);
+
+/**
+ * rpmb_dev_register - register RPMB partition with the RPMB subsystem
+ * @dev: storage device of the rpmb device
+ * @target: RPMB target/region within the physical device
+ * @ops: device specific operations
+ *
+ * While registering the RPMB partition get references to needed resources
+ * with the @ops->get_resources() callback and extracts needed devices
+ * information while needed resources are available.
+ *
+ * @returns a pointer to a 'struct rpmb_dev' or an ERR_PTR on failure
+ */
+struct rpmb_dev *rpmb_dev_register(struct device *dev,
+				   const struct rpmb_ops *ops)
+{
+	struct rpmb_dev *rdev;
+	int id;
+	int ret;
+
+	if (!dev || !ops || !ops->get_resources ||
+	    !ops->put_resources || !ops->route_frames ||
+	    !ops->set_dev_info)
+		return ERR_PTR(-EINVAL);
+
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&rpmb_mutex);
+	id = ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
+	mutex_unlock(&rpmb_mutex);
+	if (id < 0) {
+		ret = id;
+		goto exit;
+	}
+
+	rdev->ops = ops;
+	rdev->id = id;
+
+	dev_set_name(&rdev->dev, "rpmb%d", id);
+	rdev->dev.class = &rpmb_class;
+	rdev->dev.parent = dev;
+
+	ret = ops->set_dev_info(dev, rdev);
+	if (ret)
+		goto exit;
+
+	ret = device_register(&rdev->dev);
+	if (ret)
+		goto exit;
+
+	ops->get_resources(rdev->dev.parent);
+
+	dev_dbg(&rdev->dev, "registered device\n");
+
+	return rdev;
+
+exit:
+	if (id >= 0) {
+		mutex_lock(&rpmb_mutex);
+		ida_simple_remove(&rpmb_ida, id);
+		mutex_unlock(&rpmb_mutex);
+	}
+	kfree(rdev);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_register);
+
+static int __init rpmb_init(void)
+{
+	int rc;
+
+	rc = class_register(&rpmb_class);
+	if (rc) {
+		pr_err("couldn't create class\n");
+		return rc;
+	}
+	ida_init(&rpmb_ida);
+	return 0;
+}
+
+static void __exit rpmb_exit(void)
+{
+	ida_destroy(&rpmb_ida);
+	class_unregister(&rpmb_class);
+}
+
+subsys_initcall(rpmb_init);
+module_exit(rpmb_exit);
+
+MODULE_AUTHOR("Jens Wiklander <jens.wiklander@linaro.org>");
+MODULE_DESCRIPTION("RPMB class");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
new file mode 100644
index 000000000000..45073513264a
--- /dev/null
+++ b/include/linux/rpmb.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Intel Corp. All rights reserved
+ * Copyright (C) 2021-2022 Linaro Ltd
+ */
+#ifndef __RPMB_H__
+#define __RPMB_H__
+
+#include <linux/types.h>
+#include <linux/device.h>
+
+/**
+ * struct rpmb_frame - rpmb frame as defined by specs
+ *
+ * @stuff        : stuff bytes
+ * @key_mac      : The authentication key or the message authentication
+ *                 code (MAC) depending on the request/response type.
+ *                 The MAC will be delivered in the last (or the only)
+ *                 block of data.
+ * @data         : Data to be written or read by signed access.
+ * @nonce        : Random number generated by the host for the requests
+ *                 and copied to the response by the RPMB engine.
+ * @write_counter: Counter value for the total amount of the successful
+ *                 authenticated data write requests made by the host.
+ * @addr         : Address of the data to be programmed to or read
+ *                 from the RPMB. Address is the serial number of
+ *                 the accessed block (half sector 256B).
+ * @block_count  : Number of blocks (half sectors, 256B) requested to be
+ *                 read/programmed.
+ * @result       : Includes information about the status of the write counter
+ *                 (valid, expired) and result of the access made to the RPMB.
+ * @req_resp     : Defines the type of request and response to/from the memory.
+ */
+struct rpmb_frame {
+	u8     stuff[196];
+	u8     key_mac[32];
+	u8     data[256];
+	u8     nonce[16];
+	__be32 write_counter;
+	__be16 addr;
+	__be16 block_count;
+	__be16 result;
+	__be16 req_resp;
+} __packed;
+
+#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication Key */
+#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter */
+#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition */
+#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition */
+#define RPMB_RESULT_READ       0x5    /* Read result request  (Internal) */
+
+#define RPMB_REQ2RESP(_OP) ((_OP) << 8)
+#define RPMB_RESP2REQ(_OP) ((_OP) >> 8)
+
+/**
+ * enum rpmb_op_result - rpmb operation results
+ *
+ * @RPMB_ERR_OK      : operation successful
+ * @RPMB_ERR_GENERAL : general failure
+ * @RPMB_ERR_AUTH    : mac doesn't match or ac calculation failure
+ * @RPMB_ERR_COUNTER : counter doesn't match or counter increment failure
+ * @RPMB_ERR_ADDRESS : address out of range or wrong address alignment
+ * @RPMB_ERR_WRITE   : data, counter, or result write failure
+ * @RPMB_ERR_READ    : data, counter, or result read failure
+ * @RPMB_ERR_NO_KEY  : authentication key not yet programmed
+ *
+ * @RPMB_ERR_COUNTER_EXPIRED:  counter expired
+ */
+enum rpmb_op_result {
+	RPMB_ERR_OK      = 0x0000,
+	RPMB_ERR_GENERAL = 0x0001,
+	RPMB_ERR_AUTH    = 0x0002,
+	RPMB_ERR_COUNTER = 0x0003,
+	RPMB_ERR_ADDRESS = 0x0004,
+	RPMB_ERR_WRITE   = 0x0005,
+	RPMB_ERR_READ    = 0x0006,
+	RPMB_ERR_NO_KEY  = 0x0007,
+
+	RPMB_ERR_COUNTER_EXPIRED = 0x0080
+};
+
+/**
+ * enum rpmb_type - type of underlaying storage technology
+ *
+ * @RPMB_TYPE_EMMC  : emmc (JESD84-B50.1)
+ * @RPMB_TYPE_UFS   : UFS (JESD220)
+ * @RPMB_TYPE_NVME  : NVM Express
+ */
+enum rpmb_type {
+	RPMB_TYPE_EMMC,
+	RPMB_TYPE_UFS,
+	RPMB_TYPE_NVME,
+};
+
+/**
+ * struct rpmb_dev - device which can support RPMB partition
+ *
+ * @dev              : device
+ * @id               : device id;
+ * @ops              : operation exported by rpmb
+ * @dev_id           : unique device identifier read from the hardware
+ * @dev_id_len       : length of unique device identifier
+ * @reliable_wr_count: number of sectors that can be written in one access
+ * @capacity         : capacity of the device in units of 128K
+ */
+struct rpmb_dev {
+	struct device dev;
+	int id;
+	const struct rpmb_ops *ops;
+	u8 *dev_id;
+	size_t dev_id_len;
+	u16 reliable_wr_count;
+	u16 capacity;
+};
+
+#define to_rpmb_dev(x) container_of((x), struct rpmb_dev, dev)
+
+/**
+ * struct rpmb_ops - RPMB ops to be implemented by underlying block device
+ *
+ * @type          : block device type
+ * @get_resources : gets references to needed resources in rpmb_dev_register()
+ * @put_resources : puts references from resources in rpmb_dev_release()
+ * @route_frames  : routes frames to and from the RPMB device
+ * @get_dev_info  : extracts device info from the RPMB device
+ */
+struct rpmb_ops {
+	enum rpmb_type type;
+	void (*get_resources)(struct device *dev);
+	void (*put_resources)(struct device *dev);
+	int (*set_dev_info)(struct device *dev, struct rpmb_dev *rdev);
+	int (*route_frames)(struct device *dev, bool write,
+			    u8 *req, unsigned int req_len,
+			    u8 *resp, unsigned int resp_len);
+};
+
+#if IS_ENABLED(CONFIG_RPMB)
+struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
+void rpmb_dev_put(struct rpmb_dev *rdev);
+struct rpmb_dev *rpmb_dev_find_device(const void *data,
+				      const struct rpmb_dev *start,
+				      int (*match)(struct device *dev,
+						   const void *data));
+struct rpmb_dev *rpmb_dev_register(struct device *dev,
+				   const struct rpmb_ops *ops);
+int rpmb_dev_unregister(struct rpmb_dev *rdev);
+
+int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
+		      unsigned int req_len, u8 *resp, unsigned int resp_len);
+#else
+static inline struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
+{
+	return NULL;
+}
+
+static inline void rpmb_dev_put(struct rpmb_dev *rdev) { }
+
+static inline struct rpmb_dev *
+rpmb_dev_find_device(const void *data, const struct rpmb_dev *start,
+		     int (*match)(struct device *dev, const void *data))
+{
+	return NULL;
+}
+
+static inline struct rpmb_dev *
+rpmb_dev_register(struct device *dev, const struct rpmb_ops *ops)
+{
+	return NULL;
+}
+
+static inline int rpmb_dev_unregister(struct rpmb_dev *dev)
+{
+	return 0;
+}
+
+static inline int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
+				    unsigned int req_len, u8 *resp,
+				    unsigned int resp_len)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_RPMB */
+
+#endif /* __RPMB_H__ */
-- 
2.34.1


