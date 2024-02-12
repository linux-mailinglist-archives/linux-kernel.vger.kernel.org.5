Return-Path: <linux-kernel+bounces-61464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 273DD8512B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D14A1C22C41
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CF139FD5;
	Mon, 12 Feb 2024 11:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PcJTRZt6"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF839ACB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738923; cv=none; b=qWTsMtSkYX+HZ+N5+gfH4bmgd3h6WhmMYWtHUlMAh5q+LhzIzbLIy0UF865pd/JSMTZs+KcPRrGyonZDtQ3tsEBY82/C6tJmHpebTLvJwjQn8mx5B5L7prjMGqvQ/l4UUqDqA0doMMr0Z5svTPe0zznTimRI8D9qgkr4NNEDj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738923; c=relaxed/simple;
	bh=FlfryTRGDdyF0z2mZ9UhX2PTECwgKYOqoLIQpD1+7dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Izwm1Mnr41xf7dtzOepP4w+H3kRKi3xdjlRY9p7o08SXZgXljJMPziDpHEeyguZX6x+XLV3rOY34AcqlJVyL8jgKzbumcFQVn4T4SMWtUqm2MQgQR3EdLMAJkah5m2QZ4T5svXPpcLgAA99CngFO8wzxd29LhFm+TuM3Qr6TuhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PcJTRZt6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3850ce741bso297240666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738918; x=1708343718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxG16Tl9aF75BCbOOBZ8CaUnNnP0NXfy2/Hg/yLLjHQ=;
        b=PcJTRZt6GGGIAANd3lTAduExFc2ysXm9nBYzGAgslwR8TId+FvMbIqYmMeFvuGNU2p
         44qiZnqpJXC7JBeOizSBHCmcWmerSNc9P3LJOPTtm1llmEI/8Ivlpx+r+mGaXrMQ+GCp
         0Xsyd+0a5P7YlkmQ3AC3PnsJnFF2LS0fG41Vv8NAdwLaE9nCMjVKeLu7Um7T86JoP4RG
         qioiorjCqzb3ma2OpPe929QtZDzt0w6lmbHTh8GIFwT4MOTj163wprnBJfSmxZwU16s5
         dSfy6ssVZuTw7aaG8xHMZi+bAT0mASac8eDu24UOj6/a0vqsHtdi1ndKR+PkzUqG/BTP
         AsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738918; x=1708343718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxG16Tl9aF75BCbOOBZ8CaUnNnP0NXfy2/Hg/yLLjHQ=;
        b=sBsrfcfQZp+xItfxGH6oHVJJ3azRrgLQQJCHjKw7XPOgkL63AXKoTcIlr1s437A6aN
         bfotVnG93cwfonMgpb3bLpvSs6v+/HzwIhS1pXB5lvUgti06BTG97tx9AEACqoowqQHB
         bKq9d7aW0kYj+AMnvcKHRotn9VueJx57n0M0LPpijPtKMJFyWcEIJF3pChq3IDb3JlBH
         H+ejnOJhWlrzg88e1NiX8zjSpdzXqd2XTquieIRCPK/dJjB2V6sF/rcMAKZVBcy3tirY
         0Xj9Maf2YGOq0KG32e+g8JPCB7gxTRJNV5ffhbrmGjjG8p9jVwKf0chzXbBwAa6blQTQ
         3KKA==
X-Gm-Message-State: AOJu0YwX8CmDMtJRshoxkt2PgQjZLlwOGII27SIKOPQGsWbjvXuB0c4m
	ZIp2SIF36vvy8pU+w3JyPkfj+xs4/LZf3QKvdQ0LSdGPjoe7uPQrq35/sM7YzIF9bnSGml/c7af
	h
X-Google-Smtp-Source: AGHT+IGe3lUyRiD8UJymwzSNmkcr7IKumxPfO6lDK9qGiL+oMouWosRBjcX7GOmDeKMtIYBq4906DA==
X-Received: by 2002:a17:906:4f01:b0:a3c:bb58:5cf3 with SMTP id t1-20020a1709064f0100b00a3cbb585cf3mr1081687eju.16.1707738918396;
        Mon, 12 Feb 2024 03:55:18 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:18 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 07/35] sysfs.h: move declarations to sysfs_types.h
Date: Mon, 12 Feb 2024 12:54:32 +0100
Message-Id: <20240212115500.2078463-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212115500.2078463-1-max.kellermann@ionos.com>
References: <20240212115500.2078463-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By providing declarations in a lean header, we can reduce header
dependencies.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/firmware/dmi-sysfs.c    |  1 +
 drivers/firmware/memmap.c       |  1 +
 drivers/input/vivaldi-fmap.c    |  1 +
 include/linux/device/bus.h      |  2 +-
 include/linux/iio/buffer_impl.h |  3 +-
 include/linux/kobject.h         |  2 +-
 include/linux/module.h          |  2 +-
 include/linux/perf_event.h      |  2 +-
 include/linux/sysfs.h           | 63 +----------------------
 include/linux/sysfs_types.h     | 89 +++++++++++++++++++++++++++++++++
 include/linux/thermal.h         |  2 +-
 include/net/netdev_rx_queue.h   |  2 +-
 include/rdma/ib_sysfs.h         |  2 +-
 kernel/kheaders.c               |  1 +
 lib/kobject.c                   |  1 +
 mm/cma_sysfs.c                  |  1 +
 16 files changed, 105 insertions(+), 70 deletions(-)
 create mode 100644 include/linux/sysfs_types.h

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index b6a72128e818..158cc26a0331 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -25,6 +25,7 @@
 #include <linux/dmi.h>
 #include <linux/capability.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/list.h>
 #include <linux/io.h>
 #include <asm/dmi.h>
diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
index 4cf473815372..a188b204a012 100644
--- a/drivers/firmware/memmap.c
+++ b/drivers/firmware/memmap.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/mm.h>
 
 /*
diff --git a/drivers/input/vivaldi-fmap.c b/drivers/input/vivaldi-fmap.c
index 0d29ec014e2f..72845c0720f2 100644
--- a/drivers/input/vivaldi-fmap.c
+++ b/drivers/input/vivaldi-fmap.c
@@ -9,6 +9,7 @@
 #include <linux/input/vivaldi-fmap.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
 
 /**
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index bdd8ac64f629..a6fc75a825a3 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -16,7 +16,7 @@
 
 #include <linux/klist.h>
 #include <linux/pm.h>
-#include <linux/sysfs.h> // for struct attribute
+#include <linux/sysfs_types.h> // for struct attribute
 
 struct device_driver;
 struct device_node;
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 184f8c399854..df4cad6a8c8e 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -1,7 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _IIO_BUFFER_GENERIC_IMPL_H_
 #define _IIO_BUFFER_GENERIC_IMPL_H_
-#include <linux/sysfs.h>
+
+#include <linux/sysfs_types.h> // for struct attribute_group
 #include <linux/kref_types.h>
 
 #ifdef CONFIG_IIO_BUFFER
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index cd29809a05e4..462a2d604b03 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -18,7 +18,7 @@
 #include <linux/kobject_types.h>
 #include <linux/types.h>
 #include <linux/list.h>
-#include <linux/sysfs.h>
+#include <linux/sysfs_types.h> // for struct attribute
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/spinlock_types.h>
diff --git a/include/linux/module.h b/include/linux/module.h
index 426d3bdf83bb..ba3c0d129cb5 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -27,7 +27,7 @@
 #include <linux/tracepoint-defs.h>
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
-#include <linux/sysfs.h> // for struct attribute
+#include <linux/sysfs_types.h> // for struct attribute
 #include <linux/dynamic_debug.h>
 
 #include <linux/percpu.h>
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index eaf5d5f76e0e..b3aec977b0e4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -55,7 +55,7 @@ struct perf_guest_info_callbacks {
 #include <linux/static_key.h>
 #include <linux/jump_label_ratelimit.h>
 #include <linux/atomic.h>
-#include <linux/sysfs.h>
+#include <linux/sysfs_types.h>
 #include <linux/perf_regs.h>
 #include <linux/cgroup.h>
 #include <linux/refcount_types.h>
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 6fed6884d2e6..0500b023b5cc 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -13,6 +13,7 @@
 #ifndef _SYSFS_H_
 #define _SYSFS_H_
 
+#include <linux/sysfs_types.h>
 #include <linux/kernfs.h>
 #include <linux/kernel.h> // for VERIFY_OCTAL_PERMISSIONS()
 #include <linux/compiler.h>
@@ -23,16 +24,6 @@ struct kobject;
 struct module;
 struct bin_attribute;
 
-struct attribute {
-	const char		*name;
-	umode_t			mode;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	bool			ignore_lockdep:1;
-	struct lock_class_key	*key;
-	struct lock_class_key	skey;
-#endif
-};
-
 /**
  *	sysfs_attr_init - initialize a dynamically allocated sysfs attribute
  *	@attr: struct attribute to initialize
@@ -54,39 +45,6 @@ do {							\
 #define sysfs_attr_init(attr) do {} while (0)
 #endif
 
-/**
- * struct attribute_group - data structure used to declare an attribute group.
- * @name:	Optional: Attribute group name
- *		If specified, the attribute group will be created in
- *		a new subdirectory with this name.
- * @is_visible:	Optional: Function to return permissions associated with an
- *		attribute of the group. Will be called repeatedly for each
- *		non-binary attribute in the group. Only read/write
- *		permissions as well as SYSFS_PREALLOC are accepted. Must
- *		return 0 if an attribute is not visible. The returned value
- *		will replace static permissions defined in struct attribute.
- * @is_bin_visible:
- *		Optional: Function to return permissions associated with a
- *		binary attribute of the group. Will be called repeatedly
- *		for each binary attribute in the group. Only read/write
- *		permissions as well as SYSFS_PREALLOC are accepted. Must
- *		return 0 if a binary attribute is not visible. The returned
- *		value will replace static permissions defined in
- *		struct bin_attribute.
- * @attrs:	Pointer to NULL terminated list of attributes.
- * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
- *		Either attrs or bin_attrs or both must be provided.
- */
-struct attribute_group {
-	const char		*name;
-	umode_t			(*is_visible)(struct kobject *,
-					      struct attribute *, int);
-	umode_t			(*is_bin_visible)(struct kobject *,
-						  struct bin_attribute *, int);
-	struct attribute	**attrs;
-	struct bin_attribute	**bin_attrs;
-};
-
 /*
  * Use these macros to make defining attributes easier.
  * See include/linux/device.h for examples..
@@ -164,25 +122,6 @@ static const struct attribute_group _name##_group = {		\
 };								\
 __ATTRIBUTE_GROUPS(_name)
 
-struct file;
-struct vm_area_struct;
-struct address_space;
-
-struct bin_attribute {
-	struct attribute	attr;
-	size_t			size;
-	void			*private;
-	struct address_space *(*f_mapping)(void);
-	ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
-			char *, loff_t, size_t);
-	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
-			 char *, loff_t, size_t);
-	loff_t (*llseek)(struct file *, struct kobject *, struct bin_attribute *,
-			 loff_t, int);
-	int (*mmap)(struct file *, struct kobject *, struct bin_attribute *attr,
-		    struct vm_area_struct *vma);
-};
-
 /**
  *	sysfs_bin_attr_init - initialize a dynamically allocated bin_attribute
  *	@attr: struct bin_attribute to initialize
diff --git a/include/linux/sysfs_types.h b/include/linux/sysfs_types.h
new file mode 100644
index 000000000000..2840a1935ea1
--- /dev/null
+++ b/include/linux/sysfs_types.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * sysfs.h - definitions for the device driver filesystem
+ *
+ * Copyright (c) 2001,2002 Patrick Mochel
+ * Copyright (c) 2004 Silicon Graphics, Inc.
+ * Copyright (c) 2007 SUSE Linux Products GmbH
+ * Copyright (c) 2007 Tejun Heo <teheo@suse.de>
+ *
+ * Please see Documentation/filesystems/sysfs.rst for more information.
+ */
+
+#ifndef _SYSFS_TYPES_H_
+#define _SYSFS_TYPES_H_
+
+#include <linux/types.h>
+#include <linux/lockdep_types.h>
+
+struct kobject;
+struct module;
+struct bin_attribute;
+
+struct attribute {
+	const char		*name;
+	umode_t			mode;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	bool			ignore_lockdep:1;
+	struct lock_class_key	*key;
+	struct lock_class_key	skey;
+#endif
+};
+
+/**
+ * struct attribute_group - data structure used to declare an attribute group.
+ * @name:	Optional: Attribute group name
+ *		If specified, the attribute group will be created in
+ *		a new subdirectory with this name.
+ * @is_visible:	Optional: Function to return permissions associated with an
+ *		attribute of the group. Will be called repeatedly for each
+ *		non-binary attribute in the group. Only read/write
+ *		permissions as well as SYSFS_PREALLOC are accepted. Must
+ *		return 0 if an attribute is not visible. The returned value
+ *		will replace static permissions defined in struct attribute.
+ * @is_bin_visible:
+ *		Optional: Function to return permissions associated with a
+ *		binary attribute of the group. Will be called repeatedly
+ *		for each binary attribute in the group. Only read/write
+ *		permissions as well as SYSFS_PREALLOC are accepted. Must
+ *		return 0 if a binary attribute is not visible. The returned
+ *		value will replace static permissions defined in
+ *		struct bin_attribute.
+ * @attrs:	Pointer to NULL terminated list of attributes.
+ * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
+ *		Either attrs or bin_attrs or both must be provided.
+ */
+struct attribute_group {
+	const char		*name;
+	umode_t			(*is_visible)(struct kobject *,
+					      struct attribute *, int);
+	umode_t			(*is_bin_visible)(struct kobject *,
+						  struct bin_attribute *, int);
+	struct attribute	**attrs;
+	struct bin_attribute	**bin_attrs;
+};
+
+struct file;
+struct vm_area_struct;
+struct address_space;
+
+struct bin_attribute {
+	struct attribute	attr;
+	size_t			size;
+#ifdef __cplusplus
+	void			*private_;
+#else
+	void			*private;
+#endif
+	struct address_space *(*f_mapping)(void);
+	ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
+			char *, loff_t, size_t);
+	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
+			 char *, loff_t, size_t);
+	loff_t (*llseek)(struct file *, struct kobject *, struct bin_attribute *,
+			 loff_t, int);
+	int (*mmap)(struct file *, struct kobject *, struct bin_attribute *attr,
+		    struct vm_area_struct *vma);
+};
+
+#endif /* _SYSFS_TYPES_H_ */
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e0bdda259a29..14450673bd8b 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -12,7 +12,7 @@
 
 #include <linux/idr.h>
 #include <linux/device.h>
-#include <linux/sysfs.h>
+#include <linux/sysfs_types.h>
 #include <linux/workqueue_types.h>
 #include <uapi/linux/thermal.h>
 
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 4841ec031857..7122cb4b7e44 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -4,7 +4,7 @@
 
 #include <linux/kobject_types.h>
 #include <linux/netdevice.h>
-#include <linux/sysfs.h>
+#include <linux/sysfs_types.h>
 #include <net/xdp.h>
 
 /* This structure contains an instance of an RX queue. */
diff --git a/include/rdma/ib_sysfs.h b/include/rdma/ib_sysfs.h
index 3b77cfd74d9a..ece1b920c690 100644
--- a/include/rdma/ib_sysfs.h
+++ b/include/rdma/ib_sysfs.h
@@ -5,7 +5,7 @@
 #ifndef DEF_RDMA_IB_SYSFS_H
 #define DEF_RDMA_IB_SYSFS_H
 
-#include <linux/sysfs.h>
+#include <linux/sysfs_types.h>
 
 struct ib_device;
 
diff --git a/kernel/kheaders.c b/kernel/kheaders.c
index 42163c9e94e5..b48bd8a23cda 100644
--- a/kernel/kheaders.c
+++ b/kernel/kheaders.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/kobject.h>
 #include <linux/init.h>
+#include <linux/sysfs.h>
 
 /*
  * Define kernel_headers_data and kernel_headers_data_end, within which the
diff --git a/lib/kobject.c b/lib/kobject.c
index 48ba445604f8..f53564596438 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -22,6 +22,7 @@
 #include <linux/uidgid.h>
 #include <linux/workqueue.h>
 #include <linux/kref.h>
+#include <linux/sysfs.h>
 
 /**
  * kobject_namespace() - Return @kobj's namespace tag.
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
index f50db3973171..2c75ea0827c4 100644
--- a/mm/cma_sysfs.c
+++ b/mm/cma_sysfs.c
@@ -8,6 +8,7 @@
 #include <linux/cma.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 
 #include "cma.h"
 
-- 
2.39.2


