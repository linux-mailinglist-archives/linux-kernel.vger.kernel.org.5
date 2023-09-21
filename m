Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29AB7A973D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjIURMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjIURK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:10:56 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F368B36D7D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:06:14 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-4935f2d6815so782860e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315973; x=1695920773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eeMOKNMGbS/DsMrH7OuTs969NVB4cHla2zLnsvWNVkc=;
        b=hASbJYmYlfZxUed6c9ZlGQy/axeBuSNcjlKPNZWQ4krbgPJEaXjI67nvLcQQFMa33w
         xDf+LxZNceVPXMvmCF6XtEgr0dcwg4bn8Z+zBBSmDTxUF5oHlW7ZfF78ZpY9o8OMuFhB
         H3yuUH/o0GMdJNOyT0IQKVw2RQZSoUq4mcQ3/SFfEAbqDDoh95ZxKuXGazzdsiGzaEt9
         xoRoqIhZdWR4LiXxrkucU1MMJF4uzIvVbJnqicWiu+5NCDSxRtxNqZVw1aYZ/aHQWreh
         zIlHn7FnVKZynpmOnPkZoCx3KWvqtymGcLkrWur4j/Wqz4PrS0V4nf1HbhC5Ll2qlUC+
         gx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315973; x=1695920773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeMOKNMGbS/DsMrH7OuTs969NVB4cHla2zLnsvWNVkc=;
        b=IA9Co4W0VqvtlkE7KaoxbjcOaUiQgqEf41utYJX8HkrphoE3IjAYrF8OJ84QCYLIJ6
         15UcCWzfoVXZ/kCd8goXvj08Slvf9/VPjg20bAquTQKUkPz3dNF5IWG35DrgwfHEyRYi
         Q6i/xGknlBYCN2aqyeioVzG5+nvjlkXZbhRQC2n7Fi7sohFU4UKr/sxdGiC+3okebn6Z
         sep4PRfQqWuMZdSs38mXH60HhXLX8/4w6NGzXV08SiO8r+QgUkLn6oeXiELCD8pm/r3c
         dHsRTDmbZx8KpQ6HsvIjBYuqUXJd8BNqfaI6cfin23t5/K/IkCvqVDljI+P9DufIfj0P
         Z0AA==
X-Gm-Message-State: AOJu0YzU70QHKlGg3XW1T4PmXAfYp0GEyk/28wkTOXVb8LO7jp7VEwML
        mP6HCykY2DWT7CTQ012p3XrinIIQAQw=
X-Google-Smtp-Source: AGHT+IGx9fwfMpwxMt56x8tkQQZH21yBF5Az7KGb8w8UyOmG1IGrHDEpJ5t1F1q0MyZ7G67gRJFJhw==
X-Received: by 2002:a54:4595:0:b0:3a8:6a40:7dc0 with SMTP id z21-20020a544595000000b003a86a407dc0mr62943oib.18.1695314102348;
        Thu, 21 Sep 2023 09:35:02 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id d1-20020a9d5e01000000b006b90b5626desm470010oti.62.2023.09.21.09.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 09:35:01 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tanjore Suresh <tansuresh@google.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Daniel Wagner <dwagner@suse.de>,
        Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v4] driver core: shut down devices asynchronously
Date:   Thu, 21 Sep 2023 11:34:43 -0500
Message-Id: <20230921163443.9224-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shut down devices asynchronously, ensuring that each device is shut down
before its parents.

This can dramatically reduce system shutdown/reboot time on systems that
have devices that take many seconds to shut down, such as some NVMe drives.
On one system tested, the shutdown time went from 11 minutes without this
patch to 55 seconds with the patch.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
v1->v2: rewritten using kernel async code (suggested by Lukas Wunner)
v2->v3: removed recursive functions to schedule children to be shutdown
        before parents, since existing device_shutdown loop will already
        do this
v3->v4: bug fix (used "parent" not "dev->parent", in device_shutdown)
---
 drivers/base/base.h   |   3 ++
 drivers/base/core.c   | 104 ++++++++++++++++++++++++++----------------
 include/linux/async.h |   6 +++
 3 files changed, 74 insertions(+), 39 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index eb4c0ace9242..9b9d80e575ca 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -11,6 +11,7 @@
  *
  */
 #include <linux/notifier.h>
+#include <linux/async.h>
 
 /**
  * struct subsys_private - structure to hold the private to the driver core portions of the bus_type/class structure.
@@ -97,6 +98,7 @@ struct driver_private {
  *	the device; typically because it depends on another driver getting
  *	probed first.
  * @async_driver - pointer to device driver awaiting probe via async_probe
+ * @child_domain - domain for async shutdown work of children
  * @device - pointer back to the struct device that this structure is
  * associated with.
  * @dead - This device is currently either in the process of or has been
@@ -114,6 +116,7 @@ struct device_private {
 	struct list_head deferred_probe;
 	struct device_driver *async_driver;
 	char *deferred_probe_reason;
+	struct async_domain child_domain;
 	struct device *device;
 	u8 dead:1;
 };
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4d8b315c48a1..e939ff5269a4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/async.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -3473,6 +3474,7 @@ static int device_private_init(struct device *dev)
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
+	INIT_ASYNC_DOMAIN_EXCLUSIVE(&dev->p->child_domain);
 	return 0;
 }
 
@@ -4718,12 +4720,69 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+/**
+ * shutdown_device - shutdown one device
+ * @data: the pointer to the struct device to be shutdown
+ * @cookie: not used
+ *
+ * This shuts down one device, after waiting for children to finish
+ * shutdown.  This should be scheduled for any children first.
+ */
+static void shutdown_device(void *data, async_cookie_t cookie)
+{
+	struct device *dev = data;
+
+	/*
+	 * wait for shutdown work of children to finish
+	 */
+	async_synchronize_full_domain(&dev->p->child_domain);
+
+	/*
+	 * Make sure the device is off the kset list, in the
+	 * event that dev->*->shutdown() doesn't remove it.
+	 */
+	spin_lock(&devices_kset->list_lock);
+	list_del_init(&dev->kobj.entry);
+	spin_unlock(&devices_kset->list_lock);
+
+	/* hold lock to avoid race with probe/release */
+	if (dev->parent)
+		device_lock(dev->parent);
+	device_lock(dev);
+
+	/* Don't allow any more runtime suspends */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_barrier(dev);
+
+	if (dev->class && dev->class->shutdown_pre) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown_pre\n");
+		dev->class->shutdown_pre(dev);
+	}
+	if (dev->bus && dev->bus->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->bus->shutdown(dev);
+	} else if (dev->driver && dev->driver->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->driver->shutdown(dev);
+	}
+
+	device_unlock(dev);
+	if (dev->parent)
+		device_unlock(dev->parent);
+
+	put_device(dev);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
-	struct device *dev, *parent;
+	ASYNC_DOMAIN_EXCLUSIVE(top_domain);
+	struct device *dev;
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4732,20 +4791,14 @@ void device_shutdown(void)
 
 	spin_lock(&devices_kset->list_lock);
 	/*
-	 * Walk the devices list backward, shutting down each in turn.
-	 * Beware that device unplug events may also start pulling
+	 * Walk the devices list backward, scheduling shutdown of each in
+	 * turn. Beware that device unplug events may also start pulling
 	 * devices offline, even as the system is shutting down.
 	 */
 	while (!list_empty(&devices_kset->list)) {
 		dev = list_entry(devices_kset->list.prev, struct device,
 				kobj.entry);
 
-		/*
-		 * hold reference count of device's parent to
-		 * prevent it from being freed because parent's
-		 * lock is to be held
-		 */
-		parent = get_device(dev->parent);
 		get_device(dev);
 		/*
 		 * Make sure the device is off the kset list, in the
@@ -4754,40 +4807,13 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		/* hold lock to avoid race with probe/release */
-		if (parent)
-			device_lock(parent);
-		device_lock(dev);
-
-		/* Don't allow any more runtime suspends */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
-
-		if (dev->class && dev->class->shutdown_pre) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown_pre\n");
-			dev->class->shutdown_pre(dev);
-		}
-		if (dev->bus && dev->bus->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->bus->shutdown(dev);
-		} else if (dev->driver && dev->driver->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
-		}
-
-		device_unlock(dev);
-		if (parent)
-			device_unlock(parent);
-
-		put_device(dev);
-		put_device(parent);
+		async_schedule_domain(shutdown_device, dev,
+			dev->parent ? &dev->parent->p->child_domain : &top_domain);
 
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+	async_synchronize_full_domain(&top_domain);
 }
 
 /*
diff --git a/include/linux/async.h b/include/linux/async.h
index cce4ad31e8fc..ab62402452f8 100644
--- a/include/linux/async.h
+++ b/include/linux/async.h
@@ -35,6 +35,12 @@ struct async_domain {
 	struct async_domain _name = { .pending = LIST_HEAD_INIT(_name.pending), \
 				      .registered = 0 }
 
+static inline void INIT_ASYNC_DOMAIN_EXCLUSIVE(struct async_domain *domain)
+{
+	INIT_LIST_HEAD(&domain->pending);
+	domain->registered = 0;
+}
+
 async_cookie_t async_schedule_node(async_func_t func, void *data,
 				   int node);
 async_cookie_t async_schedule_node_domain(async_func_t func, void *data,
-- 
2.39.3

