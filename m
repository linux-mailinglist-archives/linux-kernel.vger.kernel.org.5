Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B208F79F36B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjIMVFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjIMVFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:05:37 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A30F9B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:05:33 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ab29af398aso145853b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694639132; x=1695243932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TNmqu4US8pjnHl52WjknK3kPn3oTiqt5qfwDspexuC0=;
        b=Sta0fmyKvvK8eTKppOeJ8H7DZNz+Syi0kuQIhY5jpo5I/9TRxnSfN462J5q/0K24ou
         iZEHVDK1NUCqK6yc7bOxBBds+MnIyRxZ4g+UxnkXPmhKMtt/bDltHWLKR0o66tm+B1+a
         LNqNY8rc19+4lsWQE+WKocpFD/p18toBvevsV5udLrjrx/q5IJwKvMrzIX9BBRVeK+Tj
         2KkTcOBpZmt3vedm0op8ydPAVZ9WSTMqzhMsla4i+q5DOfkrTzdto84u4pOUgm96Q5Tr
         xWROEtIUsROjEJfqy7bYRppTe8c3MRpTPaGi51AVUhVtY1SFSoznQJHfVBYn7uwnWTB1
         Coig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694639132; x=1695243932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNmqu4US8pjnHl52WjknK3kPn3oTiqt5qfwDspexuC0=;
        b=RHyFFBO+aQ46v7tT+9YQtal3Hbf8BpNCcgZ64ZPubyewtEjjGTyeNkBfSqw/p7V3F/
         hyrs4STfzEfgZCJL+6Qr86scb5DhZdkBM/7XGHjp0Ub8c6WoCWELFCJzqhZ7MSS9PQIf
         DvCmMU9tx5WjTwz1GXMqwdH33OaTj9P9IH+GeRM/xtPFRBx6f0x819TAI8awFMdU8ILS
         cm82au6uYEbohdwnAHySR+3nieHCYP7vTWH2HmoTqYztWkx0uWzNC8XH2wImODCVz6+3
         oN+W2l9w2PiaPKJvyPhHx2V+BtIVL52IQBStQK/2jamv2JRMyykkqMTb4IkG54QB9K/h
         ek4g==
X-Gm-Message-State: AOJu0YwmCqsamw/NxRi6xdkOkNFHQJ5UNYewPmb+6O8DcFx2PtWeLD1d
        SM4AmUqt1iBT65ifnmGbW6+HPUPQPgc=
X-Google-Smtp-Source: AGHT+IHkgSCLceGACL5a42cwIzm4c1NEZdNeRyaoaJPyCqnwnKMU0cmHntAbYtRvBZ6ivKWRUc3LbA==
X-Received: by 2002:a54:4390:0:b0:3a1:bfda:c6d2 with SMTP id u16-20020a544390000000b003a1bfdac6d2mr3998360oiv.11.1694639132124;
        Wed, 13 Sep 2023 14:05:32 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id z21-20020a056808065500b003a75748af5esm2141oih.30.2023.09.13.14.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:05:31 -0700 (PDT)
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
Subject: [PATCH v2] driver core: shut down devices asynchronously
Date:   Wed, 13 Sep 2023 16:05:16 -0500
Message-Id: <20230913210516.3545-1-stuart.w.hayes@gmail.com>
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
---

 drivers/base/base.h   |   2 +
 drivers/base/core.c   | 135 ++++++++++++++++++++++++------------------
 include/linux/async.h |   6 ++
 3 files changed, 87 insertions(+), 56 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index eb4c0ace9242..e193d48d9acc 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -11,6 +11,7 @@
  *
  */
 #include <linux/notifier.h>
+#include <linux/async.h>
 
 /**
  * struct subsys_private - structure to hold the private to the driver core portions of the bus_type/class structure.
@@ -114,6 +115,7 @@ struct device_private {
 	struct list_head deferred_probe;
 	struct device_driver *async_driver;
 	char *deferred_probe_reason;
+	struct async_domain children_shutdown;
 	struct device *device;
 	u8 dead:1;
 };
diff --git a/drivers/base/core.c b/drivers/base/core.c
index b7d7f410c256..d122788f2944 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/async.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -4716,76 +4717,98 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+static void shutdown_device(void *data, async_cookie_t cookie)
+{
+	struct device *dev = data;
+
+	async_synchronize_full_domain(&dev->p->children_shutdown);
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
+/**
+ * device_shutdown_async - schedule ->shutdown() on each device to shutdown
+ * asynchronously, ensuring each device's children are shut down before
+ * shutting down the device
+ */
+static int shutdown_device_and_children(struct device *dev, void *data)
+{
+	struct async_domain *domain = data;
+	struct device_private *p = dev->p;
+
+	INIT_ASYNC_DOMAIN_EXCLUSIVE(&p->children_shutdown);
+
+	/* make sure device doesn't go away before it is shut down */
+	get_device(dev);
+
+	/* schedule shutdown of children */
+	device_for_each_child(dev, &p->children_shutdown,
+			      shutdown_device_and_children);
+
+	/* schedule shutdown of this device */
+	async_schedule_domain(shutdown_device, dev, domain);
+
+	return 0;
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
-	struct device *dev, *parent;
+	ASYNC_DOMAIN_EXCLUSIVE(shutdown_domain);
+	struct device *dev, *temp;
 
 	wait_for_device_probe();
 	device_block_probing();
 
 	cpufreq_suspend();
 
-	spin_lock(&devices_kset->list_lock);
 	/*
-	 * Walk the devices list backward, shutting down each in turn.
-	 * Beware that device unplug events may also start pulling
-	 * devices offline, even as the system is shutting down.
+	 * schedule shutdown of top level devices
 	 */
-	while (!list_empty(&devices_kset->list)) {
-		dev = list_entry(devices_kset->list.prev, struct device,
-				kobj.entry);
-
-		/*
-		 * hold reference count of device's parent to
-		 * prevent it from being freed because parent's
-		 * lock is to be held
-		 */
-		parent = get_device(dev->parent);
-		get_device(dev);
-		/*
-		 * Make sure the device is off the kset list, in the
-		 * event that dev->*->shutdown() doesn't remove it.
-		 */
-		list_del_init(&dev->kobj.entry);
-		spin_unlock(&devices_kset->list_lock);
-
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
-
-		spin_lock(&devices_kset->list_lock);
+	list_for_each_entry_safe_reverse(dev, temp, &devices_kset->list, kobj.entry) {
+		if (dev->parent)
+			continue;
+		shutdown_device_and_children(dev, &shutdown_domain);
 	}
-	spin_unlock(&devices_kset->list_lock);
+	async_synchronize_full_domain(&shutdown_domain);
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

