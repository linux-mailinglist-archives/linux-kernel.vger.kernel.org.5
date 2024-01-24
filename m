Return-Path: <linux-kernel+bounces-36240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBFD839DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D44D1F25C90
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434933C00;
	Wed, 24 Jan 2024 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="i4sXuuWK"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3158C1106;
	Wed, 24 Jan 2024 00:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057917; cv=none; b=cBZ2F2Y3Iw34KLN5NNgqgSbvdzBC9waRIRl2rri4jFiUW1gx8MU0eX10VWHwG6ACsEHN1WwCS20HgEY+4S2/ms84a+S1Jip+jELJtwx1jzvnkCSx0DUSUfxV4TCBks+fCI8oYYddWakCi+C/HqHtzYLH4639LqjiQMG4OfgT6N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057917; c=relaxed/simple;
	bh=XM9GV8+sIMF5RW/KaB3HIusG5cMiPnVsHGK1IBjoex4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aciia/+kjrKlzr4yTxgvGqQZKPmUOc78gdmxTsNTeiHsQeMsCzk1Ic3yhEF89/kcK2H27bHRn5ppuPlF22Wak7s1VQwlUOQxXX51NR1SNHoO5zCGLye8L9pgbkr8uaRWRQ5Z5hLfndh4bZDIb5hJMQyvFxrZWO0U8Jmsfm6ut08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=i4sXuuWK; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=/+Jb+z9Ua1CTDoDCd/u+WQhU/PYvORg76KqM3L0CpVs=; b=i4sXuuWKHjKxS4FGq+K00nVbyd
	HlFC/HixOQ6zLd8hsht4H0sEAuy1eGn37NCPWHIEX+Eq1B88g53/FVvQNJqlXN3xkkSYB8ZSWA6q5
	UWjhWjzJ4LkoEZt8Ohtp8mjy63flNZb0D6PZ6qsXAiwXRK8o6clyD/0MBE4FH1Dgzz82gbnYJnCv3
	mw6lFvqXAfrG/ttBhTioQWRcbpDa31XtlA86Ir86L7GcES9HawtUN2gpzlUHApzOouXjq1Dy2ajQ3
	yg2luBELKYi/4nhk81bFmZmxbIi+ZIUQdfC3KguyST03qarJGjn7T8CPnIwPC9YpIymuR6zhU6y+j
	b2SYn2Cw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSRLB-00DVeW-2B;
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
Subject: [RFC PATCH 4/9] ntsync: Introduce NTSYNC_IOC_PUT_SEM.
Date: Tue, 23 Jan 2024 18:40:23 -0600
Message-ID: <20240124004028.16826-5-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtReleaseSemaphore().

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 76 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  2 +
 2 files changed, 78 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 3287b94be351..d1c91c2a4f1a 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -21,9 +21,11 @@ enum ntsync_type {
 struct ntsync_obj {
 	struct rcu_head rhead;
 	struct kref refcount;
+	spinlock_t lock;
 
 	enum ntsync_type type;
 
+	/* The following fields are protected by the object lock. */
 	union {
 		struct {
 			__u32 count;
@@ -36,6 +38,19 @@ struct ntsync_device {
 	struct xarray objects;
 };
 
+static struct ntsync_obj *get_obj(struct ntsync_device *dev, __u32 id)
+{
+	struct ntsync_obj *obj;
+
+	rcu_read_lock();
+	obj = xa_load(&dev->objects, id);
+	if (obj && !kref_get_unless_zero(&obj->refcount))
+		obj = NULL;
+	rcu_read_unlock();
+
+	return obj;
+}
+
 static void destroy_obj(struct kref *ref)
 {
 	struct ntsync_obj *obj = container_of(ref, struct ntsync_obj, refcount);
@@ -48,6 +63,18 @@ static void put_obj(struct ntsync_obj *obj)
 	kref_put(&obj->refcount, destroy_obj);
 }
 
+static struct ntsync_obj *get_obj_typed(struct ntsync_device *dev, __u32 id,
+					enum ntsync_type type)
+{
+	struct ntsync_obj *obj = get_obj(dev, id);
+
+	if (obj && obj->type != type) {
+		put_obj(obj);
+		return NULL;
+	}
+	return obj;
+}
+
 static int ntsync_char_open(struct inode *inode, struct file *file)
 {
 	struct ntsync_device *dev;
@@ -81,6 +108,7 @@ static int ntsync_char_release(struct inode *inode, struct file *file)
 static void init_obj(struct ntsync_obj *obj)
 {
 	kref_init(&obj->refcount);
+	spin_lock_init(&obj->lock);
 }
 
 static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
@@ -131,6 +159,52 @@ static int ntsync_delete(struct ntsync_device *dev, void __user *argp)
 	return 0;
 }
 
+/*
+ * Actually change the semaphore state, returning -EOVERFLOW if it is made
+ * invalid.
+ */
+static int put_sem_state(struct ntsync_obj *sem, __u32 count)
+{
+	lockdep_assert_held(&sem->lock);
+
+	if (sem->u.sem.count + count < sem->u.sem.count ||
+	    sem->u.sem.count + count > sem->u.sem.max)
+		return -EOVERFLOW;
+
+	sem->u.sem.count += count;
+	return 0;
+}
+
+static int ntsync_put_sem(struct ntsync_device *dev, void __user *argp)
+{
+	struct ntsync_sem_args __user *user_args = argp;
+	struct ntsync_sem_args args;
+	struct ntsync_obj *sem;
+	__u32 prev_count;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	sem = get_obj_typed(dev, args.sem, NTSYNC_TYPE_SEM);
+	if (!sem)
+		return -EINVAL;
+
+	spin_lock(&sem->lock);
+
+	prev_count = sem->u.sem.count;
+	ret = put_sem_state(sem, args.count);
+
+	spin_unlock(&sem->lock);
+
+	put_obj(sem);
+
+	if (!ret && put_user(prev_count, &user_args->count))
+		ret = -EFAULT;
+
+	return ret;
+}
+
 static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 			      unsigned long parm)
 {
@@ -142,6 +216,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_create_sem(dev, argp);
 	case NTSYNC_IOC_DELETE:
 		return ntsync_delete(dev, argp);
+	case NTSYNC_IOC_PUT_SEM:
+		return ntsync_put_sem(dev, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index d97afc138dcc..8c610d65f8ef 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -21,5 +21,7 @@ struct ntsync_sem_args {
 #define NTSYNC_IOC_CREATE_SEM		_IOWR(NTSYNC_IOC_BASE, 0, \
 					      struct ntsync_sem_args)
 #define NTSYNC_IOC_DELETE		_IOW (NTSYNC_IOC_BASE, 1, __u32)
+#define NTSYNC_IOC_PUT_SEM		_IOWR(NTSYNC_IOC_BASE, 2, \
+					      struct ntsync_sem_args)
 
 #endif
-- 
2.43.0


