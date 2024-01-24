Return-Path: <linux-kernel+bounces-36238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBDB839DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F7E28DC9C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8361860;
	Wed, 24 Jan 2024 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="l2HUwBKi"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F02F1841;
	Wed, 24 Jan 2024 00:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057911; cv=none; b=FZau5uK8/Z1XLUczZuGcKM2u7n4iHBuxC/e3uyniWkgInJoCr1dBRz/7Snm0LPj/G4mk6iR1ks+KLuvnsMux6LheuOyO5TG0Ft/kkBVpOz8tRNQ3WaR4+L5JY26OKCjQb9fjusS09d0dwmkmssEbgYWIhhYe03VdHAqlCi3Bm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057911; c=relaxed/simple;
	bh=gGRv5odUNhfX4VoV6kC+64r+PLYNEQB8KtgHYIT9nk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1F2lILSXUXNQ13HEBQ0EyEHuDYMEbFlz8wEWAnr3a1bGGpkyE64qWI/+0GJMu5Yw4lPGi3f0S9tvhKvcaU8UnqQ9A2FsAC+n7CU5O4z09t7pXd/x/ys3+M/wEa3r0+uUFewiADTUwLkHFbUVfby4jTQPT0LrYNkJA4260wOuEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=l2HUwBKi; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=IpiExmoWV0N5DWasqyp0qDuktw1Ruf47n+D+iWJ83/M=; b=l2HUwBKixJXPHnQ8DC/ZTyFzDF
	f1cDRO66MzSI54QY6M9+BhzcwlcisBFZ2+Etbg2/jeEjyjHQXZSdxzyHnErw8VoGIhsTYX7T5+Qy7
	Idw6bNaBnRBok/idufHFDjVzpT9LzyMNApcaYe8KHDNGqOHDtLJX+Mh1i5YOrodAcO7csrScG+PPy
	P+2f/l+9K1mf3MWQiQJPnHRzoHlJMJ9spf9BV+YWjqj72+WfgNtvgSvIONcR/EIojDI15ncFlmR3t
	6P9fG4NhS8WuXTTk4+DyDRWgAMP7y00JSsOBIb4SDEQcEHPwUXR67qE4uQkfLFPqUuhJHCYcsmfd9
	8euWlbRg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSRLB-00DVeW-1i;
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
Subject: [RFC PATCH 3/9] ntsync: Introduce NTSYNC_IOC_CREATE_SEM and NTSYNC_IOC_DELETE.
Date: Tue, 23 Jan 2024 18:40:22 -0600
Message-ID: <20240124004028.16826-4-zfigura@codeweavers.com>
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

These correspond to the NT syscalls NtCreateSemaphore() and NtClose().
Unlike those functions, however, these ioctls do not handle object names, or
lookup of existing objects, or handle reference counting, but simply create the
underlying primitive. The user space emulator is expected to implement those
functions if they are required.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 117 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  25 ++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 include/uapi/linux/ntsync.h

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 84b498e2b2d5..3287b94be351 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -8,23 +8,140 @@
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/xarray.h>
+#include <uapi/linux/ntsync.h>
 
 #define NTSYNC_NAME	"ntsync"
 
+enum ntsync_type {
+	NTSYNC_TYPE_SEM,
+};
+
+struct ntsync_obj {
+	struct rcu_head rhead;
+	struct kref refcount;
+
+	enum ntsync_type type;
+
+	union {
+		struct {
+			__u32 count;
+			__u32 max;
+		} sem;
+	} u;
+};
+
+struct ntsync_device {
+	struct xarray objects;
+};
+
+static void destroy_obj(struct kref *ref)
+{
+	struct ntsync_obj *obj = container_of(ref, struct ntsync_obj, refcount);
+
+	kfree_rcu(obj, rhead);
+}
+
+static void put_obj(struct ntsync_obj *obj)
+{
+	kref_put(&obj->refcount, destroy_obj);
+}
+
 static int ntsync_char_open(struct inode *inode, struct file *file)
 {
+	struct ntsync_device *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	xa_init_flags(&dev->objects, XA_FLAGS_ALLOC);
+
+	file->private_data = dev;
 	return nonseekable_open(inode, file);
 }
 
 static int ntsync_char_release(struct inode *inode, struct file *file)
 {
+	struct ntsync_device *dev = file->private_data;
+	struct ntsync_obj *obj;
+	unsigned long id;
+
+	xa_for_each(&dev->objects, id, obj)
+		put_obj(obj);
+
+	xa_destroy(&dev->objects);
+
+	kfree(dev);
+
+	return 0;
+}
+
+static void init_obj(struct ntsync_obj *obj)
+{
+	kref_init(&obj->refcount);
+}
+
+static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
+{
+	struct ntsync_sem_args __user *user_args = argp;
+	struct ntsync_sem_args args;
+	struct ntsync_obj *sem;
+	__u32 id;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	if (args.count > args.max)
+		return -EINVAL;
+
+	sem = kzalloc(sizeof(*sem), GFP_KERNEL);
+	if (!sem)
+		return -ENOMEM;
+
+	init_obj(sem);
+	sem->type = NTSYNC_TYPE_SEM;
+	sem->u.sem.count = args.count;
+	sem->u.sem.max = args.max;
+
+	ret = xa_alloc(&dev->objects, &id, sem, xa_limit_32b, GFP_KERNEL);
+	if (ret < 0) {
+		kfree(sem);
+		return ret;
+	}
+
+	return put_user(id, &user_args->sem);
+}
+
+static int ntsync_delete(struct ntsync_device *dev, void __user *argp)
+{
+	struct ntsync_obj *obj;
+	__u32 id;
+
+	if (get_user(id, (__u32 __user *)argp))
+		return -EFAULT;
+
+	obj = xa_erase(&dev->objects, id);
+	if (!obj)
+		return -EINVAL;
+
+	put_obj(obj);
 	return 0;
 }
 
 static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 			      unsigned long parm)
 {
+	struct ntsync_device *dev = file->private_data;
+	void __user *argp = (void __user *)parm;
+
 	switch (cmd) {
+	case NTSYNC_IOC_CREATE_SEM:
+		return ntsync_create_sem(dev, argp);
+	case NTSYNC_IOC_DELETE:
+		return ntsync_delete(dev, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
new file mode 100644
index 000000000000..d97afc138dcc
--- /dev/null
+++ b/include/uapi/linux/ntsync.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Kernel support for NT synchronization primitive emulation
+ *
+ * Copyright (C) 2021-2022 Elizabeth Figura
+ */
+
+#ifndef __LINUX_NTSYNC_H
+#define __LINUX_NTSYNC_H
+
+#include <linux/types.h>
+
+struct ntsync_sem_args {
+	__u32 sem;
+	__u32 count;
+	__u32 max;
+};
+
+#define NTSYNC_IOC_BASE 0xf7
+
+#define NTSYNC_IOC_CREATE_SEM		_IOWR(NTSYNC_IOC_BASE, 0, \
+					      struct ntsync_sem_args)
+#define NTSYNC_IOC_DELETE		_IOW (NTSYNC_IOC_BASE, 1, __u32)
+
+#endif
-- 
2.43.0


