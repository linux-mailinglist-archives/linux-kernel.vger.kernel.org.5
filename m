Return-Path: <linux-kernel+bounces-815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CED7814697
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA0C1F2185E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8545C2D7BB;
	Fri, 15 Dec 2023 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pkSaAkRS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD72288B0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33638e7f71aso268174f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702638952; x=1703243752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmK/5nuUWtg26bIJFH0hmWM12krrxgYPI0mvhBQxbPw=;
        b=pkSaAkRS468gg7MmxYF2SS/UBFcjkJYFsuz9m3UGBSEP0DPAYyyUPt3uJEjWi+oSYK
         SLZ9dnrH2EjZ3cY9EoPvGLIIxN7iPjfMfdCQLnmMyYt6OBWqoskcYcQGSSwLpjnfaZib
         Nwaror9+2YtBjjndpzCOjc2XvLOGckG60YpdHUEpsd+jvd7NNMKUUKFnANCg7So68w+a
         XwqL3qlkIgqwNICzcghixeyMXOnze+PAwHZYlIKPOPbAolNaVl0NDOL2u+JHfx5uDtlD
         /mIgw588GgYeif1tkGWvEiaxz0RAlLTIoa572dGpzcLhaD2qDkGOmXrBxLxgk386+MEk
         +YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638952; x=1703243752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmK/5nuUWtg26bIJFH0hmWM12krrxgYPI0mvhBQxbPw=;
        b=tpZMHE3FjtaIQxNlfMkNk32x0cipBzRxETF0LX0bSHT9Iz7fnpXIly7sMEhrACVgDE
         2+yOuD45j4oTsvtAHIs74kw/E8gWSoeR/+FJAtj0BomkxPsgq6SWDIfKIX5+KEX6uJr0
         Q8Jpkld+nRPpOZhBP/dK8E9xZViRW2IFL2lG7r8GkaV4DRNpFjpBtAbT/GIk1PvNsIEC
         8UkBHt/09qMwMI39SGcwtJ1xX6qVn1q/yV/rdsFt7E/O1XpzJhA+o42fdO3mqOsXm6ZK
         VqzcdFFp3Lz31QNch59Q66AKeAMRDxsySmEr9rusL5JCp3Tfkm+2TaLzYmcEfFTjN3YK
         pIMA==
X-Gm-Message-State: AOJu0YwBSn9Drw6r+CeqEp2ZgO/VQwdk7EBXFiBs/1V0qr7er3tAnEJv
	wgxRfD0UTeCT0WRlgSbqHjwJnA==
X-Google-Smtp-Source: AGHT+IEVwBKmKafiW/au5HaFWbxp8yXc6riJyPyhAmYsbZPI6nT1nci51m498qID6TEp+LrKlYqEOw==
X-Received: by 2002:a5d:5148:0:b0:336:42d2:97f3 with SMTP id u8-20020a5d5148000000b0033642d297f3mr1791890wrt.70.1702638951760;
        Fri, 15 Dec 2023 03:15:51 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g13-20020a056000118d00b003333d46a9e8sm18511497wrx.56.2023.12.15.03.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:15:51 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/10] nvmem: core: Rework layouts to become regular devices
Date: Fri, 15 Dec 2023 11:15:32 +0000
Message-Id: <20231215111536.316972-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
References: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=23023; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=tPvJLoCIlEgWCe6a8N4xtAXSZXfLBGril3r8Injwa24=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlfDVXm0HoQFMLYvdkXWZo8W/kK/7S0jR5f+0B0 p6zzgsh1pCJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZXw1VwAKCRB6of1ZxzRV N/prCACZZM02UA4UgsdNZh0E8CFFbxigOp5dhGpAkqRS8i+QNlwocKiPd5sYcNVuDg7gOavlRy7 esXRPa5nTT5SzJ0PoUXO7y5kXWxekEeqG6SueStyJTZX5z0oBcOj8VpgeYVyv5z3A8suaxf3uoK tYLHoEAoHP10KP5wJfigesaEtVY8rqpIWVOHAgIQoZlBv2l/nMPIHs4aiBpK8QLpfx+uJKIy70K 6yZbztBOHbd5+pPxSiyPZ3MiXc7ZcXM32P6XvwCcThDnS0QhJy8w8hcmHZGCcP/qj7GerxL5+o1 kV4llB5bM1t5V/tvCDOBZfQXWzT8WP1dWX8qDvis9TmPRyzJ
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

Current layout support was initially written without modules support in
mind. When the requirement for module support rose, the existing base
was improved to adopt modularization support, but kind of a design flaw
was introduced. With the existing implementation, when a storage device
registers into NVMEM, the core tries to hook a layout (if any) and
populates its cells immediately. This means, if the hardware description
expects a layout to be hooked up, but no driver was provided for that,
the storage medium will fail to probe and try later from
scratch. Even if we consider that the hardware description shall be
correct, we could still probe the storage device (especially if it
contains the rootfs).

One way to overcome this situation is to consider the layouts as
devices, and leverage the native notifier mechanism. When a new NVMEM
device is registered, we can populate its nvmem-layout child, if any,
and wait for the matching to be done in order to get the cells (the
waiting can be easily done with the NVMEM notifiers). If the layout
driver is compiled as a module, it should automatically be loaded. This
way, there is no strong order to enforce, any NVMEM device creation
or NVMEM layout driver insertion will be observed as a new event which
may lead to the creation of additional cells, without disturbing the
probes with costly (and sometimes endless) deferrals.

In order to achieve that goal we create a new bus for the nvmem-layouts
with minimal logic to match nvmem-layout devices with nvmem-layout
drivers. All this infrastructure code is created in the layouts.c file.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig            |   1 +
 drivers/nvmem/Makefile           |   2 +
 drivers/nvmem/core.c             | 170 ++++++++++----------------
 drivers/nvmem/internals.h        |  21 ++++
 drivers/nvmem/layouts.c          | 201 +++++++++++++++++++++++++++++++
 drivers/nvmem/layouts/Kconfig    |   8 ++
 drivers/nvmem/layouts/onie-tlv.c |  24 +++-
 drivers/nvmem/layouts/sl28vpd.c  |  24 +++-
 include/linux/nvmem-provider.h   |  38 +++---
 9 files changed, 354 insertions(+), 135 deletions(-)
 create mode 100644 drivers/nvmem/layouts.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 5bc9c4874fe3..283134498fbc 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig NVMEM
 	bool "NVMEM Support"
+	imply NVMEM_LAYOUTS
 	help
 	  Support for NVMEM(Non Volatile Memory) devices like EEPROM, EFUSES...
 
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 423baf089515..cdd01fbf1313 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -5,6 +5,8 @@
 
 obj-$(CONFIG_NVMEM)		+= nvmem_core.o
 nvmem_core-y			:= core.o
+obj-$(CONFIG_NVMEM_LAYOUTS)	+= nvmem_layouts.o
+nvmem_layouts-y			:= layouts.o
 obj-y				+= layouts/
 
 # Devices
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index a885713d6b4b..4c2154ddf8a7 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -55,9 +55,6 @@ static LIST_HEAD(nvmem_lookup_list);
 
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
-static DEFINE_SPINLOCK(nvmem_layout_lock);
-static LIST_HEAD(nvmem_layouts);
-
 static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
 			    void *val, size_t bytes)
 {
@@ -740,97 +737,22 @@ static int nvmem_add_cells_from_fixed_layout(struct nvmem_device *nvmem)
 	return err;
 }
 
-int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner)
+int nvmem_layout_register(struct nvmem_layout *layout)
 {
-	layout->owner = owner;
-
-	spin_lock(&nvmem_layout_lock);
-	list_add(&layout->node, &nvmem_layouts);
-	spin_unlock(&nvmem_layout_lock);
-
-	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_LAYOUT_ADD, layout);
+	if (!layout->add_cells)
+		return -EINVAL;
 
-	return 0;
+	/* Populate the cells */
+	return layout->add_cells(&layout->nvmem->dev, layout->nvmem);
 }
-EXPORT_SYMBOL_GPL(__nvmem_layout_register);
+EXPORT_SYMBOL_GPL(nvmem_layout_register);
 
 void nvmem_layout_unregister(struct nvmem_layout *layout)
 {
-	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_LAYOUT_REMOVE, layout);
-
-	spin_lock(&nvmem_layout_lock);
-	list_del(&layout->node);
-	spin_unlock(&nvmem_layout_lock);
+	/* Keep the API even with an empty stub in case we need it later */
 }
 EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
 
-static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
-{
-	struct device_node *layout_np;
-	struct nvmem_layout *l, *layout = ERR_PTR(-EPROBE_DEFER);
-
-	layout_np = of_nvmem_layout_get_container(nvmem);
-	if (!layout_np)
-		return NULL;
-
-	/* Fixed layouts don't have a matching driver */
-	if (of_device_is_compatible(layout_np, "fixed-layout")) {
-		of_node_put(layout_np);
-		return NULL;
-	}
-
-	/*
-	 * In case the nvmem device was built-in while the layout was built as a
-	 * module, we shall manually request the layout driver loading otherwise
-	 * we'll never have any match.
-	 */
-	of_request_module(layout_np);
-
-	spin_lock(&nvmem_layout_lock);
-
-	list_for_each_entry(l, &nvmem_layouts, node) {
-		if (of_match_node(l->of_match_table, layout_np)) {
-			if (try_module_get(l->owner))
-				layout = l;
-
-			break;
-		}
-	}
-
-	spin_unlock(&nvmem_layout_lock);
-	of_node_put(layout_np);
-
-	return layout;
-}
-
-static void nvmem_layout_put(struct nvmem_layout *layout)
-{
-	if (layout)
-		module_put(layout->owner);
-}
-
-static int nvmem_add_cells_from_layout(struct nvmem_device *nvmem)
-{
-	struct nvmem_layout *layout = nvmem->layout;
-	int ret;
-
-	if (layout && layout->add_cells) {
-		ret = layout->add_cells(&nvmem->dev, nvmem);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-#if IS_ENABLED(CONFIG_OF)
-struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
-{
-	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
-}
-EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
-#endif
-
 const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 					struct nvmem_layout *layout)
 {
@@ -838,7 +760,7 @@ const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 	const struct of_device_id *match;
 
 	layout_np = of_nvmem_layout_get_container(nvmem);
-	match = of_match_node(layout->of_match_table, layout_np);
+	match = of_match_node(layout->dev.driver->of_match_table, layout_np);
 
 	return match ? match->data : NULL;
 }
@@ -950,19 +872,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_put_device;
 	}
 
-	/*
-	 * If the driver supplied a layout by config->layout, the module
-	 * pointer will be NULL and nvmem_layout_put() will be a noop.
-	 */
-	nvmem->layout = config->layout ?: nvmem_layout_get(nvmem);
-	if (IS_ERR(nvmem->layout)) {
-		rval = PTR_ERR(nvmem->layout);
-		nvmem->layout = NULL;
-
-		if (rval == -EPROBE_DEFER)
-			goto err_teardown_compat;
-	}
-
 	if (config->cells) {
 		rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
 		if (rval)
@@ -983,24 +892,24 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
-	rval = nvmem_add_cells_from_layout(nvmem);
-	if (rval)
-		goto err_remove_cells;
-
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
 
 	rval = device_add(&nvmem->dev);
 	if (rval)
 		goto err_remove_cells;
 
+	rval = nvmem_populate_layout(nvmem);
+	if (rval)
+		goto err_remove_dev;
+
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 
 	return nvmem;
 
+err_remove_dev:
+	device_del(&nvmem->dev);
 err_remove_cells:
 	nvmem_device_remove_all_cells(nvmem);
-	nvmem_layout_put(nvmem->layout);
-err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
 err_put_device:
@@ -1022,7 +931,7 @@ static void nvmem_device_release(struct kref *kref)
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 
 	nvmem_device_remove_all_cells(nvmem);
-	nvmem_layout_put(nvmem->layout);
+	nvmem_destroy_layout(nvmem);
 	device_unregister(&nvmem->dev);
 }
 
@@ -1324,6 +1233,12 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 	return cell;
 }
 
+static void nvmem_layout_module_put(struct nvmem_device *nvmem)
+{
+	if (nvmem->layout && nvmem->layout->dev.driver)
+		module_put(nvmem->layout->dev.driver->owner);
+}
+
 #if IS_ENABLED(CONFIG_OF)
 static struct nvmem_cell_entry *
 nvmem_find_cell_entry_by_node(struct nvmem_device *nvmem, struct device_node *np)
@@ -1342,6 +1257,18 @@ nvmem_find_cell_entry_by_node(struct nvmem_device *nvmem, struct device_node *np
 	return cell;
 }
 
+static int nvmem_layout_module_get_optional(struct nvmem_device *nvmem)
+{
+	if (!nvmem->layout)
+		return 0;
+
+	if (!nvmem->layout->dev.driver ||
+	    !try_module_get(nvmem->layout->dev.driver->owner))
+		return -EPROBE_DEFER;
+
+	return 0;
+}
+
 /**
  * of_nvmem_cell_get() - Get a nvmem cell from given device node and cell id
  *
@@ -1404,16 +1331,29 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 		return ERR_CAST(nvmem);
 	}
 
+	ret = nvmem_layout_module_get_optional(nvmem);
+	if (ret) {
+		of_node_put(cell_np);
+		__nvmem_device_put(nvmem);
+		return ERR_PTR(ret);
+	}
+
 	cell_entry = nvmem_find_cell_entry_by_node(nvmem, cell_np);
 	of_node_put(cell_np);
 	if (!cell_entry) {
 		__nvmem_device_put(nvmem);
-		return ERR_PTR(-ENOENT);
+		nvmem_layout_module_put(nvmem);
+		if (nvmem->layout)
+			return ERR_PTR(-EPROBE_DEFER);
+		else
+			return ERR_PTR(-ENOENT);
 	}
 
 	cell = nvmem_create_cell(cell_entry, id, cell_index);
-	if (IS_ERR(cell))
+	if (IS_ERR(cell)) {
 		__nvmem_device_put(nvmem);
+		nvmem_layout_module_put(nvmem);
+	}
 
 	return cell;
 }
@@ -1527,6 +1467,7 @@ void nvmem_cell_put(struct nvmem_cell *cell)
 
 	kfree(cell);
 	__nvmem_device_put(nvmem);
+	nvmem_layout_module_put(nvmem);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_put);
 
@@ -2104,11 +2045,22 @@ EXPORT_SYMBOL_GPL(nvmem_dev_name);
 
 static int __init nvmem_init(void)
 {
-	return bus_register(&nvmem_bus_type);
+	int ret;
+
+	ret = bus_register(&nvmem_bus_type);
+	if (ret)
+		return ret;
+
+	ret = nvmem_layout_bus_register();
+	if (ret)
+		bus_unregister(&nvmem_bus_type);
+
+	return ret;
 }
 
 static void __exit nvmem_exit(void)
 {
+	nvmem_layout_bus_unregister();
 	bus_unregister(&nvmem_bus_type);
 }
 
diff --git a/drivers/nvmem/internals.h b/drivers/nvmem/internals.h
index 893553fbdf51..4946456c76c7 100644
--- a/drivers/nvmem/internals.h
+++ b/drivers/nvmem/internals.h
@@ -34,4 +34,25 @@ struct nvmem_device {
 	void *priv;
 };
 
+#if IS_ENABLED(CONFIG_OF)
+int nvmem_layout_bus_register(void);
+void nvmem_layout_bus_unregister(void);
+int nvmem_populate_layout(struct nvmem_device *nvmem);
+void nvmem_destroy_layout(struct nvmem_device *nvmem);
+#else /* CONFIG_OF */
+static inline int nvmem_layout_bus_register(void)
+{
+	return 0;
+}
+
+static inline void nvmem_layout_bus_unregister(void) {}
+
+static inline int nvmem_populate_layout(struct nvmem_device *nvmem)
+{
+	return 0;
+}
+
+static inline void nvmem_destroy_layout(struct nvmem_device *nvmem) { }
+#endif /* CONFIG_OF */
+
 #endif  /* ifndef _LINUX_NVMEM_INTERNALS_H */
diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
new file mode 100644
index 000000000000..6a6aa58369ff
--- /dev/null
+++ b/drivers/nvmem/layouts.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMEM layout bus handling
+ *
+ * Copyright (C) 2023 Bootlin
+ * Author: Miquel Raynal <miquel.raynal@bootlin.com
+ */
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+
+#include "internals.h"
+
+#define to_nvmem_layout_driver(drv) \
+	(container_of((drv), struct nvmem_layout_driver, driver))
+#define to_nvmem_layout_device(_dev) \
+	container_of((_dev), struct nvmem_layout, dev)
+
+static int nvmem_layout_bus_match(struct device *dev, struct device_driver *drv)
+{
+	return of_driver_match_device(dev, drv);
+}
+
+static int nvmem_layout_bus_probe(struct device *dev)
+{
+	struct nvmem_layout_driver *drv = to_nvmem_layout_driver(dev->driver);
+	struct nvmem_layout *layout = to_nvmem_layout_device(dev);
+
+	if (!drv->probe || !drv->remove)
+		return -EINVAL;
+
+	return drv->probe(layout);
+}
+
+static void nvmem_layout_bus_remove(struct device *dev)
+{
+	struct nvmem_layout_driver *drv = to_nvmem_layout_driver(dev->driver);
+	struct nvmem_layout *layout = to_nvmem_layout_device(dev);
+
+	return drv->remove(layout);
+}
+
+static struct bus_type nvmem_layout_bus_type = {
+	.name		= "nvmem-layout",
+	.match		= nvmem_layout_bus_match,
+	.probe		= nvmem_layout_bus_probe,
+	.remove		= nvmem_layout_bus_remove,
+};
+
+int nvmem_layout_driver_register(struct nvmem_layout_driver *drv)
+{
+	drv->driver.bus = &nvmem_layout_bus_type;
+
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(nvmem_layout_driver_register);
+
+void nvmem_layout_driver_unregister(struct nvmem_layout_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(nvmem_layout_driver_unregister);
+
+static void nvmem_layout_release_device(struct device *dev)
+{
+	struct nvmem_layout *layout = to_nvmem_layout_device(dev);
+
+	of_node_put(layout->dev.of_node);
+	kfree(layout);
+}
+
+static int nvmem_layout_create_device(struct nvmem_device *nvmem,
+				      struct device_node *np)
+{
+	struct nvmem_layout *layout;
+	struct device *dev;
+	int ret;
+
+	layout = kzalloc(sizeof(*layout), GFP_KERNEL);
+	if (!layout)
+		return -ENOMEM;
+
+	/* Create a bidirectional link */
+	layout->nvmem = nvmem;
+	nvmem->layout = layout;
+
+	/* Device model registration */
+	dev = &layout->dev;
+	device_initialize(dev);
+	dev->parent = &nvmem->dev;
+	dev->bus = &nvmem_layout_bus_type;
+	dev->release = nvmem_layout_release_device;
+	dev->coherent_dma_mask = DMA_BIT_MASK(32);
+	dev->dma_mask = &dev->coherent_dma_mask;
+	device_set_node(dev, of_fwnode_handle(of_node_get(np)));
+	of_device_make_bus_id(dev);
+	of_msi_configure(dev, dev->of_node);
+
+	ret = device_add(dev);
+	if (ret) {
+		put_device(dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id of_nvmem_layout_skip_table[] = {
+	{ .compatible = "fixed-layout", },
+	{}
+};
+
+static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
+				     struct device_node *layout_dn)
+{
+	int ret;
+
+	/* Make sure it has a compatible property */
+	if (!of_get_property(layout_dn, "compatible", NULL)) {
+		pr_debug("%s() - skipping %pOF, no compatible prop\n",
+			 __func__, layout_dn);
+		return 0;
+	}
+
+	/* Fixed layouts are parsed manually somewhere else for now */
+	if (of_match_node(of_nvmem_layout_skip_table, layout_dn)) {
+		pr_debug("%s() - skipping %pOF node\n", __func__, layout_dn);
+		return 0;
+	}
+
+	if (of_node_check_flag(layout_dn, OF_POPULATED_BUS)) {
+		pr_debug("%s() - skipping %pOF, already populated\n",
+			 __func__, layout_dn);
+
+		return 0;
+	}
+
+	/* NVMEM layout buses expect only a single device representing the layout */
+	ret = nvmem_layout_create_device(nvmem, layout_dn);
+	if (ret)
+		return ret;
+
+	of_node_set_flag(layout_dn, OF_POPULATED_BUS);
+
+	return 0;
+}
+
+struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
+{
+	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+}
+EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
+
+/*
+ * Returns the number of devices populated, 0 if the operation was not relevant
+ * for this nvmem device, an error code otherwise.
+ */
+int nvmem_populate_layout(struct nvmem_device *nvmem)
+{
+	struct device_node *layout_dn;
+	int ret;
+
+	layout_dn = of_nvmem_layout_get_container(nvmem);
+	if (!layout_dn)
+		return 0;
+
+	/* Populate the layout device */
+	device_links_supplier_sync_state_pause();
+	ret = nvmem_layout_bus_populate(nvmem, layout_dn);
+	device_links_supplier_sync_state_resume();
+
+	of_node_put(layout_dn);
+	return ret;
+}
+
+void nvmem_destroy_layout(struct nvmem_device *nvmem)
+{
+	struct device *dev;
+
+	if (!nvmem->layout)
+		return;
+
+	dev = &nvmem->layout->dev;
+	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
+	device_unregister(dev);
+}
+
+int nvmem_layout_bus_register(void)
+{
+	return bus_register(&nvmem_layout_bus_type);
+}
+
+void nvmem_layout_bus_unregister(void)
+{
+	bus_unregister(&nvmem_layout_bus_type);
+}
diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 7ff1ee1c1f05..9c6e672fc350 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -1,5 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
+config NVMEM_LAYOUTS
+	bool
+	depends on OF
+
+if NVMEM_LAYOUTS
+
 menu "Layout Types"
 
 config NVMEM_LAYOUT_SL28_VPD
@@ -21,3 +27,5 @@ config NVMEM_LAYOUT_ONIE_TLV
 	  If unsure, say N.
 
 endmenu
+
+endif
diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index defd42d4375c..b24cc5dcc6ee 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -225,16 +225,32 @@ static int onie_tlv_parse_table(struct device *dev, struct nvmem_device *nvmem)
 	return 0;
 }
 
+static int onie_tlv_probe(struct nvmem_layout *layout)
+{
+	layout->add_cells = onie_tlv_parse_table;
+
+	return nvmem_layout_register(layout);
+}
+
+static void onie_tlv_remove(struct nvmem_layout *layout)
+{
+	nvmem_layout_unregister(layout);
+}
+
 static const struct of_device_id onie_tlv_of_match_table[] = {
 	{ .compatible = "onie,tlv-layout", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, onie_tlv_of_match_table);
 
-static struct nvmem_layout onie_tlv_layout = {
-	.name = "ONIE tlv layout",
-	.of_match_table = onie_tlv_of_match_table,
-	.add_cells = onie_tlv_parse_table,
+static struct nvmem_layout_driver onie_tlv_layout = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "onie-tlv-layout",
+		.of_match_table = onie_tlv_of_match_table,
+	},
+	.probe = onie_tlv_probe,
+	.remove = onie_tlv_remove,
 };
 module_nvmem_layout_driver(onie_tlv_layout);
 
diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index 26c7cf21b523..b8ffae646cc2 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -134,16 +134,32 @@ static int sl28vpd_add_cells(struct device *dev, struct nvmem_device *nvmem)
 	return 0;
 }
 
+static int sl28vpd_probe(struct nvmem_layout *layout)
+{
+	layout->add_cells = sl28vpd_add_cells;
+
+	return nvmem_layout_register(layout);
+}
+
+static void sl28vpd_remove(struct nvmem_layout *layout)
+{
+	nvmem_layout_unregister(layout);
+}
+
 static const struct of_device_id sl28vpd_of_match_table[] = {
 	{ .compatible = "kontron,sl28-vpd" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sl28vpd_of_match_table);
 
-static struct nvmem_layout sl28vpd_layout = {
-	.name = "sl28-vpd",
-	.of_match_table = sl28vpd_of_match_table,
-	.add_cells = sl28vpd_add_cells,
+static struct nvmem_layout_driver sl28vpd_layout = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "kontron-sl28vpd-layout",
+		.of_match_table = sl28vpd_of_match_table,
+	},
+	.probe = sl28vpd_probe,
+	.remove = sl28vpd_remove,
 };
 module_nvmem_layout_driver(sl28vpd_layout);
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 36415a602d9e..6fe65b35ea97 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_NVMEM_PROVIDER_H
 #define _LINUX_NVMEM_PROVIDER_H
 
+#include <linux/device.h>
 #include <linux/device/driver.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -158,12 +159,11 @@ struct nvmem_cell_table {
 /**
  * struct nvmem_layout - NVMEM layout definitions
  *
- * @name:		Layout name.
- * @of_match_table:	Open firmware match table.
- * @add_cells:		Called to populate the layout using
- *			nvmem_add_one_cell().
- * @owner:		Pointer to struct module.
- * @node:		List node.
+ * @dev:		Device-model layout device.
+ * @nvmem:		The underlying NVMEM device
+ * @add_cells:		Will be called if a nvmem device is found which
+ *			has this layout. The function will add layout
+ *			specific cells with nvmem_add_one_cell().
  *
  * A nvmem device can hold a well defined structure which can just be
  * evaluated during runtime. For example a TLV list, or a list of "name=val"
@@ -171,13 +171,15 @@ struct nvmem_cell_table {
  * cells.
  */
 struct nvmem_layout {
-	const char *name;
-	const struct of_device_id *of_match_table;
+	struct device dev;
+	struct nvmem_device *nvmem;
 	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem);
+};
 
-	/* private */
-	struct module *owner;
-	struct list_head node;
+struct nvmem_layout_driver {
+	struct device_driver driver;
+	int (*probe)(struct nvmem_layout *layout);
+	void (*remove)(struct nvmem_layout *layout);
 };
 
 #if IS_ENABLED(CONFIG_NVMEM)
@@ -194,11 +196,15 @@ void nvmem_del_cell_table(struct nvmem_cell_table *table);
 int nvmem_add_one_cell(struct nvmem_device *nvmem,
 		       const struct nvmem_cell_info *info);
 
-int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner);
-#define nvmem_layout_register(layout) \
-	__nvmem_layout_register(layout, THIS_MODULE)
+int nvmem_layout_register(struct nvmem_layout *layout);
 void nvmem_layout_unregister(struct nvmem_layout *layout);
 
+int nvmem_layout_driver_register(struct nvmem_layout_driver *drv);
+void nvmem_layout_driver_unregister(struct nvmem_layout_driver *drv);
+#define module_nvmem_layout_driver(__nvmem_layout_driver)		\
+	module_driver(__nvmem_layout_driver, nvmem_layout_driver_register, \
+		      nvmem_layout_driver_unregister)
+
 const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 					struct nvmem_layout *layout);
 
@@ -262,8 +268,4 @@ static inline struct device_node *of_nvmem_layout_get_container(struct nvmem_dev
 
 #endif /* CONFIG_NVMEM && CONFIG_OF */
 
-#define module_nvmem_layout_driver(__layout_driver)		\
-	module_driver(__layout_driver, nvmem_layout_register,	\
-		      nvmem_layout_unregister)
-
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.25.1


