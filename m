Return-Path: <linux-kernel+bounces-152858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 220328AC54E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDD41F21FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83B4D5B0;
	Mon, 22 Apr 2024 07:16:46 +0000 (UTC)
Received: from mail-m3293.qiye.163.com (mail-m3293.qiye.163.com [220.197.32.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D09252F9A;
	Mon, 22 Apr 2024 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770206; cv=none; b=X09yOVSe4UroAE1C6lcybbD6V68ucmbUtrNSxHZy/wWAf7Y774VdUlUAGUQW+LfGs2BP4yhauGAw+OCEhMroLKz1bsOH+gI6RdOGiRN0LybQ2ytYbUFgQctcEx3oQzm5QZMLQlO7u0dPvpU1Atm+hZkP/Nmovr1wXD1UBKowtCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770206; c=relaxed/simple;
	bh=TUHE9KihomjQT+4gHHlt9TTtEQswCTrpD973kNSu7jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kmY89WGkZUTsF/pjh3AFCZjfmxPUafqp+s8dkWFI4uoIH5jibg2pqep2bl4E7rl7RrSBqhoRG6UgSL5sIrV1uzr123OgXQyQp4PE5jpVykgqWXEcqMqKATZcd4On2qEKYMB5MbyTEt6R7jDWBvHWAL22CS11PTEOYsROFEqoKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from ubuntu-22-04.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id C5801860221;
	Mon, 22 Apr 2024 15:16:15 +0800 (CST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: dan.j.williams@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang.linux@gmail.com>
Subject: [PATCH 7/7] cbd: add related sysfs files in transport register
Date: Mon, 22 Apr 2024 07:16:06 +0000
Message-Id: <20240422071606.52637-8-dongsheng.yang@easystack.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSUseVk5LSUMdSEtCTUMYTlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f04a99e1c023ckunmc5801860221
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NiI6Mhw4Lzc0ShwQITYRCy0j
	CDUKCjlVSlVKTEpITExLSkxNTk5DVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBTUlLQjcG

From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>

When a transport is registered, a corresponding file is created for each
area within the transport in the sysfs, including "cbd_hosts",
"cbd_backends", "cbd_blkdevs", and "cbd_channels".

Through these sysfs files, we can examine the information of each entity
and thereby understand the relationships between them. This allows us to
further understand the current operational status of the transport.

For example, by examining "cbd_hosts", we can find all the hosts
currently using the transport. We can also determine which host each
backend is running on by looking at the "host_id" in "cbd_backends".
Similarly, by examining "cbd_blkdevs", we can determine which host each
blkdev is running on, and through the "mapped_id", we can know the name
of the cbd device to which the blkdev is mapped. Additionally, by
looking at "cbd_channels", we can determine which blkdev and backend are
connected through each channel by examining the "blkdev_id" and
"backend_id".

Signed-off-by: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
---
 drivers/block/cbd/cbd_transport.c | 101 +++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/block/cbd/cbd_transport.c b/drivers/block/cbd/cbd_transport.c
index 75b9d34218fc..0e917d72b209 100644
--- a/drivers/block/cbd/cbd_transport.c
+++ b/drivers/block/cbd/cbd_transport.c
@@ -1,8 +1,91 @@
 #include <linux/pfn_t.h>
-
 #include "cbd_internal.h"
 
 #define CBDT_OBJ(OBJ, OBJ_SIZE)							\
+extern struct device_type cbd_##OBJ##_type;					\
+extern struct device_type cbd_##OBJ##s_type;					\
+										\
+static int cbd_##OBJ##s_init(struct cbd_transport *cbdt) 			\
+{ 										\
+	struct cbd_##OBJ##s_device *devs; 					\
+	struct cbd_##OBJ##_device *cbd_dev;					\
+	struct device *dev;							\
+	int i; 									\
+	int ret;								\
+										\
+	u32 memsize = struct_size(devs, OBJ##_devs,				\
+			cbdt->transport_info->OBJ##_num);			\
+	devs = kzalloc(memsize, GFP_KERNEL);					\
+	if (!devs) {								\
+	    return -ENOMEM;							\
+	}									\
+										\
+	dev = &devs->OBJ##s_dev;						\
+	device_initialize(dev);							\
+	device_set_pm_not_required(dev);					\
+	dev_set_name(dev, "cbd_" #OBJ "s");					\
+	dev->parent = &cbdt->device;						\
+	dev->type = &cbd_##OBJ##s_type;						\
+	ret = device_add(dev);							\
+	if (ret) {								\
+		goto devs_free;							\
+	}									\
+										\
+	for (i = 0; i < cbdt->transport_info->OBJ##_num; i++) {			\
+		cbd_dev = &devs->OBJ##_devs[i];					\
+		dev = &cbd_dev->dev;						\
+										\
+		cbd_dev->cbdt = cbdt;						\
+		cbd_dev->OBJ##_info = cbdt_get_##OBJ##_info(cbdt, i);		\
+		device_initialize(dev);						\
+		device_set_pm_not_required(dev);				\
+		dev_set_name(dev, #OBJ "%u", i);				\
+		dev->parent = &devs->OBJ##s_dev;				\
+		dev->type = &cbd_##OBJ##_type;					\
+										\
+		ret = device_add(dev);						\
+		if (ret) {							\
+			i--;							\
+			goto del_device;					\
+		}								\
+	}									\
+	cbdt->cbd_##OBJ##s_dev = devs;						\
+										\
+    	return 0;								\
+del_device:									\
+	for (; i >= 0; i--) {							\
+		cbd_dev = &devs->OBJ##_devs[i];					\
+		dev = &cbd_dev->dev;						\
+		device_del(dev);						\
+	}									\
+devs_free:									\
+	kfree(devs);								\
+	return ret;								\
+}										\
+										\
+static void cbd_##OBJ##s_exit(struct cbd_transport *cbdt)			\
+{										\
+	struct cbd_##OBJ##s_device *devs = cbdt->cbd_##OBJ##s_dev;		\
+	struct device *dev;							\
+	int i;									\
+										\
+	if (!devs)								\
+		return;								\
+										\
+	for (i = 0; i < cbdt->transport_info->OBJ##_num; i++) {			\
+		struct cbd_##OBJ##_device *cbd_dev = &devs->OBJ##_devs[i];	\
+		dev = &cbd_dev->dev;						\
+										\
+		device_del(dev);						\
+	}									\
+										\
+	device_del(&devs->OBJ##s_dev);						\
+										\
+	kfree(devs);								\
+	cbdt->cbd_##OBJ##s_dev = NULL;						\
+										\
+	return;									\
+}										\
 										\
 static inline struct cbd_##OBJ##_info						\
 *__get_##OBJ##_info(struct cbd_transport *cbdt, u32 id)				\
@@ -588,6 +671,11 @@ int cbdt_unregister(u32 tid)
 	}
 	mutex_unlock(&cbdt->lock);
 
+	cbd_blkdevs_exit(cbdt);
+	cbd_channels_exit(cbdt);
+	cbd_backends_exit(cbdt);
+	cbd_hosts_exit(cbdt);
+
 	cbd_host_unregister(cbdt);
 	device_unregister(&cbdt->device);
 	cbdt_dax_release(cbdt);
@@ -647,9 +735,20 @@ int cbdt_register(struct cbdt_register_options *opts)
 		goto dev_unregister;
 	}
 
+	if (cbd_hosts_init(cbdt) || cbd_backends_init(cbdt) ||
+	    cbd_channels_init(cbdt) || cbd_blkdevs_init(cbdt)) {
+		ret = -ENOMEM;
+		goto devs_exit;
+	}
+
 	return 0;
 
 devs_exit:
+	cbd_blkdevs_exit(cbdt);
+	cbd_channels_exit(cbdt);
+	cbd_backends_exit(cbdt);
+	cbd_hosts_exit(cbdt);
+
 	cbd_host_unregister(cbdt);
 dev_unregister:
 	device_unregister(&cbdt->device);
-- 
2.34.1


