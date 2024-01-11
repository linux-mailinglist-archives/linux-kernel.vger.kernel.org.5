Return-Path: <linux-kernel+bounces-23825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CABDF82B25D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81E21C23902
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FAA4F887;
	Thu, 11 Jan 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNCCZdhp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8083F4F889
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704989003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CFpKfL9UxFZICnioMPt+I5fx4/TKb+KT5j8NZp5YmI=;
	b=HNCCZdhpwtkU4KEOJOYZdKlWu6GfRrIXuKeZTJpryMj15sD1qPm4wokKqX+8qN2LGiGyKy
	p9TWPnAmvTrXO/or9U2t5bZkYXtsTcsHFOe5bV557E3Rj6cw6Q2he82DFV33/DEkBoxA7A
	ETlKgWgyWK+Grg5ev8oE+ZHDqZYkYb8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-jCGoBt5IOzqhoMbL7KbI-g-1; Thu, 11 Jan 2024 11:03:21 -0500
X-MC-Unique: jCGoBt5IOzqhoMbL7KbI-g-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5ce67a3f275so3086594a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989000; x=1705593800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CFpKfL9UxFZICnioMPt+I5fx4/TKb+KT5j8NZp5YmI=;
        b=iAYw5YWlw/1bz1Lx6gazaXeVvFhDTB0qhv7achxwiOdbCi0a7XoRovTqoW9dU28ZZh
         Q89pyZx/VSQZX07OJYxbmPWGEgzhbe6uHq2+UxEDeAJ2iOB3RlJlB68Zm9EWRpZ9+kyF
         8vpTeeMJ3I7be6ZAASbBdu8buKg5rihhxm2rDn5JAvUErhe+YUbgt0zpRlEt2pro0+Qq
         GlYN0B2ere4PlOJHBnHH5JoYU2W9fFwEH5HUAjid/figB0YXKomFskyMDcniN5Dbc3fB
         kkbZA3ybavfDDM2qjGjlsyLkDww9PryVaYdGZBAQkj8btQps4g+xsOBMDSehY72GQlQV
         l5Eg==
X-Gm-Message-State: AOJu0YzF83V/25MMKbeJO1nA7jofC/HsCMpC6Ft7c4jAeT0cOAoAPFFM
	wTLBpR9Z2Igu9yW2H6FZCsBy3vjxsbiQsHttFxPPjsvF4wrqa+JejIeK6dFJEa1lmMU7gCbU28S
	rsDqnGf2WLxokqBcd1oTmXEmeDmXesxE=
X-Received: by 2002:a17:902:e850:b0:1d5:73b7:5dfa with SMTP id t16-20020a170902e85000b001d573b75dfamr1626786plg.110.1704988999736;
        Thu, 11 Jan 2024 08:03:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9hjWghZm0O0id7aZM94/NzFI97g7IfJ82vPiJqImDKiWg60Zp5umoO11tVU8mFGZ+t61Htw==
X-Received: by 2002:a17:902:e850:b0:1d5:73b7:5dfa with SMTP id t16-20020a170902e85000b001d573b75dfamr1626761plg.110.1704988999280;
        Thu, 11 Jan 2024 08:03:19 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id jh18-20020a170903329200b001d4593a2e8fsm1343903plb.83.2024.01.11.08.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:03:18 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [RFC PATCH v5 1/1] fpga: add an owner and use it to take the low-level module's refcount
Date: Thu, 11 Jan 2024 17:02:42 +0100
Message-ID: <20240111160242.149265-2-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111160242.149265-1-marpagan@redhat.com>
References: <20240111160242.149265-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a module owner field to the fpga_manager struct to take the
low-level control module refcount instead of assuming that the parent
device has a driver and using its owner pointer. The owner is now
passed as an additional argument at registration time. To this end,
the functions for registration have been modified to take an additional
owner parameter and renamed to avoid conflicts. The old function names
are now used for helper macros that automatically set the module that
registers the fpga manager as the owner. This ensures compatibility
with existing low-level control modules and reduces the chances of
registering a manager without setting the owner.

To detect when the owner module pointer becomes stale, set the mops
pointer to null during fpga_mgr_unregister() and test it before taking
the module's refcount. Use a mutex to protect against a crash that can
happen if __fpga_mgr_get() gets suspended between testing the mops
pointer and taking the refcount while the low-level module is being
unloaded.

Update the documentation to keep it consistent with the new interface
for registering an fpga manager.

Other changes: opportunistically move put_device() from __fpga_mgr_get()
to fpga_mgr_get() and of_fpga_mgr_get() to improve code clarity since
the device refcount in taken in these functions.

Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
Suggested-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 Documentation/driver-api/fpga/fpga-mgr.rst | 34 ++++----
 drivers/fpga/fpga-mgr.c                    | 93 ++++++++++++++--------
 include/linux/fpga/fpga-mgr.h              | 28 +++++--
 3 files changed, 102 insertions(+), 53 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 49c0a9512653..8d2b79f696c1 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -24,7 +24,8 @@ How to support a new FPGA device
 --------------------------------
 
 To add another FPGA manager, write a driver that implements a set of ops.  The
-probe function calls fpga_mgr_register() or fpga_mgr_register_full(), such as::
+probe function calls ``fpga_mgr_register()`` or ``fpga_mgr_register_full()``,
+such as::
 
 	static const struct fpga_manager_ops socfpga_fpga_ops = {
 		.write_init = socfpga_fpga_ops_configure_init,
@@ -69,10 +70,11 @@ probe function calls fpga_mgr_register() or fpga_mgr_register_full(), such as::
 	}
 
 Alternatively, the probe function could call one of the resource managed
-register functions, devm_fpga_mgr_register() or devm_fpga_mgr_register_full().
-When these functions are used, the parameter syntax is the same, but the call
-to fpga_mgr_unregister() should be removed. In the above example, the
-socfpga_fpga_remove() function would not be required.
+register functions, ``devm_fpga_mgr_register()`` or
+``devm_fpga_mgr_register_full()``.  When these functions are used, the
+parameter syntax is the same, but the call to ``fpga_mgr_unregister()`` should be
+removed. In the above example, the ``socfpga_fpga_remove()`` function would not be
+required.
 
 The ops will implement whatever device specific register writes are needed to
 do the programming sequence for this particular FPGA.  These ops return 0 for
@@ -125,15 +127,19 @@ API for implementing a new FPGA Manager driver
 * struct fpga_manager -  the FPGA manager struct
 * struct fpga_manager_ops -  Low level FPGA manager driver ops
 * struct fpga_manager_info -  Parameter structure for fpga_mgr_register_full()
-* fpga_mgr_register_full() -  Create and register an FPGA manager using the
+* __fpga_mgr_register_full() -  Create and register an FPGA manager using the
   fpga_mgr_info structure to provide the full flexibility of options
-* fpga_mgr_register() -  Create and register an FPGA manager using standard
+* __fpga_mgr_register() -  Create and register an FPGA manager using standard
   arguments
-* devm_fpga_mgr_register_full() -  Resource managed version of
-  fpga_mgr_register_full()
-* devm_fpga_mgr_register() -  Resource managed version of fpga_mgr_register()
+* __devm_fpga_mgr_register_full() -  Resource managed version of
+  __fpga_mgr_register_full()
+* __devm_fpga_mgr_register() -  Resource managed version of __fpga_mgr_register()
 * fpga_mgr_unregister() -  Unregister an FPGA manager
 
+Helper macros ``fpga_mgr_register_full()``, ``fpga_mgr_register()``,
+``devm_fpga_mgr_register_full()``, and ``devm_fpga_mgr_register()`` are available
+to ease the registration.
+
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
    :functions: fpga_mgr_states
 
@@ -147,16 +153,16 @@ API for implementing a new FPGA Manager driver
    :functions: fpga_manager_info
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_register_full
+   :functions: __fpga_mgr_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_register
+   :functions: __fpga_mgr_register
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: devm_fpga_mgr_register_full
+   :functions: __devm_fpga_mgr_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: devm_fpga_mgr_register
+   :functions: __devm_fpga_mgr_register
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
    :functions: fpga_mgr_unregister
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 06651389c592..d7bfbdfdf2fc 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -664,20 +664,20 @@ static struct attribute *fpga_mgr_attrs[] = {
 };
 ATTRIBUTE_GROUPS(fpga_mgr);
 
-static struct fpga_manager *__fpga_mgr_get(struct device *dev)
+static struct fpga_manager *__fpga_mgr_get(struct device *mgr_dev)
 {
 	struct fpga_manager *mgr;
 
-	mgr = to_fpga_manager(dev);
+	mgr = to_fpga_manager(mgr_dev);
 
-	if (!try_module_get(dev->parent->driver->owner))
-		goto err_dev;
+	mutex_lock(&mgr->mops_mutex);
 
-	return mgr;
+	if (!mgr->mops || !try_module_get(mgr->mops_owner))
+		mgr = ERR_PTR(-ENODEV);
 
-err_dev:
-	put_device(dev);
-	return ERR_PTR(-ENODEV);
+	mutex_unlock(&mgr->mops_mutex);
+
+	return mgr;
 }
 
 static int fpga_mgr_dev_match(struct device *dev, const void *data)
@@ -693,12 +693,18 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
  */
 struct fpga_manager *fpga_mgr_get(struct device *dev)
 {
-	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
-						   fpga_mgr_dev_match);
+	struct fpga_manager *mgr;
+	struct device *mgr_dev;
+
+	mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev, fpga_mgr_dev_match);
 	if (!mgr_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_mgr_get(mgr_dev);
+	mgr = __fpga_mgr_get(mgr_dev);
+	if (IS_ERR(mgr))
+		put_device(mgr_dev);
+
+	return mgr;
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_get);
 
@@ -711,13 +717,18 @@ EXPORT_SYMBOL_GPL(fpga_mgr_get);
  */
 struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
 {
-	struct device *dev;
+	struct fpga_manager *mgr;
+	struct device *mgr_dev;
 
-	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
-	if (!dev)
+	mgr_dev = class_find_device_by_of_node(&fpga_mgr_class, node);
+	if (!mgr_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_mgr_get(dev);
+	mgr = __fpga_mgr_get(mgr_dev);
+	if (IS_ERR(mgr))
+		put_device(mgr_dev);
+
+	return mgr;
 }
 EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
 
@@ -727,7 +738,7 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
  */
 void fpga_mgr_put(struct fpga_manager *mgr)
 {
-	module_put(mgr->dev.parent->driver->owner);
+	module_put(mgr->mops_owner);
 	put_device(&mgr->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_put);
@@ -766,9 +777,10 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
 EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
 
 /**
- * fpga_mgr_register_full - create and register an FPGA Manager device
+ * __fpga_mgr_register_full - create and register an FPGA Manager device
  * @parent:	fpga manager device from pdev
  * @info:	parameters for fpga manager
+ * @owner:	owner module containing the ops
  *
  * The caller of this function is responsible for calling fpga_mgr_unregister().
  * Using devm_fpga_mgr_register_full() instead is recommended.
@@ -776,7 +788,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
  * Return: pointer to struct fpga_manager pointer or ERR_PTR()
  */
 struct fpga_manager *
-fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
+__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			 struct module *owner)
 {
 	const struct fpga_manager_ops *mops = info->mops;
 	struct fpga_manager *mgr;
@@ -803,6 +816,9 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 	}
 
 	mutex_init(&mgr->ref_mutex);
+	mutex_init(&mgr->mops_mutex);
+
+	mgr->mops_owner = owner;
 
 	mgr->name = info->name;
 	mgr->mops = info->mops;
@@ -841,14 +857,15 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
+EXPORT_SYMBOL_GPL(__fpga_mgr_register_full);
 
 /**
- * fpga_mgr_register - create and register an FPGA Manager device
+ * __fpga_mgr_register - create and register an FPGA Manager device
  * @parent:	fpga manager device from pdev
  * @name:	fpga manager name
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
+ * @owner:	owner module containing the ops
  *
  * The caller of this function is responsible for calling fpga_mgr_unregister().
  * Using devm_fpga_mgr_register() instead is recommended. This simple
@@ -859,8 +876,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
  * Return: pointer to struct fpga_manager pointer or ERR_PTR()
  */
 struct fpga_manager *
-fpga_mgr_register(struct device *parent, const char *name,
-		  const struct fpga_manager_ops *mops, void *priv)
+__fpga_mgr_register(struct device *parent, const char *name,
+		    const struct fpga_manager_ops *mops, void *priv, struct module *owner)
 {
 	struct fpga_manager_info info = { 0 };
 
@@ -868,9 +885,9 @@ fpga_mgr_register(struct device *parent, const char *name,
 	info.mops = mops;
 	info.priv = priv;
 
-	return fpga_mgr_register_full(parent, &info);
+	return __fpga_mgr_register_full(parent, &info, owner);
 }
-EXPORT_SYMBOL_GPL(fpga_mgr_register);
+EXPORT_SYMBOL_GPL(__fpga_mgr_register);
 
 /**
  * fpga_mgr_unregister - unregister an FPGA manager
@@ -888,6 +905,12 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
 	 */
 	fpga_mgr_fpga_remove(mgr);
 
+	mutex_lock(&mgr->mops_mutex);
+
+	mgr->mops = NULL;
+
+	mutex_unlock(&mgr->mops_mutex);
+
 	device_unregister(&mgr->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
@@ -900,9 +923,10 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
 }
 
 /**
- * devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
+ * __devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
  * @parent:	fpga manager device from pdev
  * @info:	parameters for fpga manager
+ * @owner:	owner module containing the ops
  *
  * Return:  fpga manager pointer on success, negative error code otherwise.
  *
@@ -910,7 +934,8 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
  * function will be called automatically when the managing device is detached.
  */
 struct fpga_manager *
-devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
+__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			      struct module *owner)
 {
 	struct fpga_mgr_devres *dr;
 	struct fpga_manager *mgr;
@@ -919,7 +944,7 @@ devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_inf
 	if (!dr)
 		return ERR_PTR(-ENOMEM);
 
-	mgr = fpga_mgr_register_full(parent, info);
+	mgr = __fpga_mgr_register_full(parent, info, owner);
 	if (IS_ERR(mgr)) {
 		devres_free(dr);
 		return mgr;
@@ -930,14 +955,15 @@ devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_inf
 
 	return mgr;
 }
-EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
+EXPORT_SYMBOL_GPL(__devm_fpga_mgr_register_full);
 
 /**
- * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
+ * __devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
  * @parent:	fpga manager device from pdev
  * @name:	fpga manager name
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
+ * @owner:	owner module containing the ops
  *
  * Return:  fpga manager pointer on success, negative error code otherwise.
  *
@@ -946,8 +972,9 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
  * device is detached.
  */
 struct fpga_manager *
-devm_fpga_mgr_register(struct device *parent, const char *name,
-		       const struct fpga_manager_ops *mops, void *priv)
+__devm_fpga_mgr_register(struct device *parent, const char *name,
+			 const struct fpga_manager_ops *mops, void *priv,
+			 struct module *owner)
 {
 	struct fpga_manager_info info = { 0 };
 
@@ -955,9 +982,9 @@ devm_fpga_mgr_register(struct device *parent, const char *name,
 	info.mops = mops;
 	info.priv = priv;
 
-	return devm_fpga_mgr_register_full(parent, &info);
+	return __devm_fpga_mgr_register_full(parent, &info, owner);
 }
-EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
+EXPORT_SYMBOL_GPL(__devm_fpga_mgr_register);
 
 static void fpga_mgr_dev_release(struct device *dev)
 {
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 54f63459efd6..0a4f67b59fb5 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -201,6 +201,8 @@ struct fpga_manager_ops {
  * @state: state of fpga manager
  * @compat_id: FPGA manager id for compatibility check.
  * @mops: pointer to struct of fpga manager ops
+ * @mops_mutex: protects mops from low-level module removal
+ * @mops_owner: module containing the mops
  * @priv: low level driver private date
  */
 struct fpga_manager {
@@ -210,6 +212,8 @@ struct fpga_manager {
 	enum fpga_mgr_states state;
 	struct fpga_compat_id *compat_id;
 	const struct fpga_manager_ops *mops;
+	struct mutex mops_mutex;
+	struct module *mops_owner;
 	void *priv;
 };
 
@@ -230,18 +234,30 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
 
 void fpga_mgr_put(struct fpga_manager *mgr);
 
+#define fpga_mgr_register_full(parent, info) \
+	__fpga_mgr_register_full(parent, info, THIS_MODULE)
 struct fpga_manager *
-fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
+__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			 struct module *owner);
 
+#define fpga_mgr_register(parent, name, mops, priv) \
+	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
 struct fpga_manager *
-fpga_mgr_register(struct device *parent, const char *name,
-		  const struct fpga_manager_ops *mops, void *priv);
+__fpga_mgr_register(struct device *parent, const char *name,
+		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
+
 void fpga_mgr_unregister(struct fpga_manager *mgr);
 
+#define devm_fpga_mgr_register_full(parent, info) \
+	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
 struct fpga_manager *
-devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
+__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			      struct module *owner);
+#define devm_fpga_mgr_register(parent, name, mops, priv) \
+	__devm_fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
 struct fpga_manager *
-devm_fpga_mgr_register(struct device *parent, const char *name,
-		       const struct fpga_manager_ops *mops, void *priv);
+__devm_fpga_mgr_register(struct device *parent, const char *name,
+			 const struct fpga_manager_ops *mops, void *priv,
+			 struct module *owner);
 
 #endif /*_LINUX_FPGA_MGR_H */
-- 
2.43.0


