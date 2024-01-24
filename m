Return-Path: <linux-kernel+bounces-36246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3BE839DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278831F299D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C602DD275;
	Wed, 24 Jan 2024 00:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="Jig3bTtu"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE9CC158;
	Wed, 24 Jan 2024 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057934; cv=none; b=imfcRKbgvdL0oO5N8+2k82K/xlWlK/s2tMFCw0ZxLE++MFjNpRZ9CKWRH09i2BlAymzwPQDzCiL8YVZ/M3Qddr56jyn1/U+Q1GCjB0eCLC5QJcePuc8BdomDVqn69KQzIUHxBx9G3/eSGYIdfr7or9eYjfJXcORUSY97s9THnc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057934; c=relaxed/simple;
	bh=OK38CsfmTQ/+2qSV1J4hYuKjCcXbFCVQw/NRr4ahxMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTKI9cgqYK7Y+fI/AtqzoeK5XbaRO6HKpuGRnIy+qkIkT8I3MoXHhgHNHrObKBEe8YTfK/Lyd7sNeyE8zw1dahteFOHnZaXWBRlkWx4GX5ivrg8Dy9krd5kYck3sIPU2CRDzMxHhVuw/GWiXhZCiXRmKey1AmGvjI2ea7kiLdKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=Jig3bTtu; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=n18n/Dm5XC6gbUFhjKBhHb8lqgVEir8MGaSOOm77plw=; b=Jig3bTtunFQFejUo6b+UvK6XZF
	7SgxJtpxArTsO4cbvnNbOIvIMo/QGA5gArDGz5JtNA6ry5L2pt/CCiH6HjGwck0+X0b43/Gslh9g2
	vg1y3MvizpW+KlPcFJalkc/qzzfjIe1lhgfzD4kqE2tc2DCDzItFsu2TNrajxp7H11asQ0Lz9zaY8
	3zldhzmOHX85FHXvneXHHk0kK3l2HGF4xl5D7jAUPI+sCDSPuwGBOBLC4nfMB2xCtzYXKAIwjFVD6
	K4J9qAEXgW/wFMhlWUhGrBkJX4M/4RtcLIiYrZ5xpEvQMxUHYEg939uG9ym9EZXiJALrjelKkCMEm
	o+169QSw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSRLC-00DVeW-0c;
	Tue, 23 Jan 2024 18:42:06 -0600
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
Subject: [RFC PATCH 7/9] ntsync: Introduce NTSYNC_IOC_CREATE_MUTEX.
Date: Tue, 23 Jan 2024 18:40:26 -0600
Message-ID: <20240124004028.16826-8-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtCreateMutant().

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 72 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  8 +++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 2685363fae9e..d48f2ef41341 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -16,6 +16,7 @@
 
 enum ntsync_type {
 	NTSYNC_TYPE_SEM,
+	NTSYNC_TYPE_MUTEX,
 };
 
 struct ntsync_obj {
@@ -60,6 +61,10 @@ struct ntsync_obj {
 			__u32 count;
 			__u32 max;
 		} sem;
+		struct {
+			__u32 count;
+			__u32 owner;
+		} mutex;
 	} u;
 };
 
@@ -188,6 +193,10 @@ static bool is_signaled(struct ntsync_obj *obj, __u32 owner)
 	switch (obj->type) {
 	case NTSYNC_TYPE_SEM:
 		return !!obj->u.sem.count;
+	case NTSYNC_TYPE_MUTEX:
+		if (obj->u.mutex.owner && obj->u.mutex.owner != owner)
+			return false;
+		return obj->u.mutex.count < UINT_MAX;
 	}
 
 	WARN(1, "bad object type %#x\n", obj->type);
@@ -230,6 +239,10 @@ static void try_wake_all(struct ntsync_device *dev, struct ntsync_q *q,
 			case NTSYNC_TYPE_SEM:
 				obj->u.sem.count--;
 				break;
+			case NTSYNC_TYPE_MUTEX:
+				obj->u.mutex.count++;
+				obj->u.mutex.owner = q->owner;
+				break;
 			}
 		}
 		wake_up_process(q->task);
@@ -271,6 +284,28 @@ static void try_wake_any_sem(struct ntsync_obj *sem)
 	}
 }
 
+static void try_wake_any_mutex(struct ntsync_obj *mutex)
+{
+	struct ntsync_q_entry *entry;
+
+	lockdep_assert_held(&mutex->lock);
+
+	list_for_each_entry(entry, &mutex->any_waiters, node) {
+		struct ntsync_q *q = entry->q;
+
+		if (mutex->u.mutex.count == UINT_MAX)
+			break;
+		if (mutex->u.mutex.owner && mutex->u.mutex.owner != q->owner)
+			continue;
+
+		if (atomic_cmpxchg(&q->signaled, -1, entry->index) == -1) {
+			mutex->u.mutex.count++;
+			mutex->u.mutex.owner = q->owner;
+			wake_up_process(q->task);
+		}
+	}
+}
+
 static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
 {
 	struct ntsync_sem_args __user *user_args = argp;
@@ -303,6 +338,38 @@ static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
 	return put_user(id, &user_args->sem);
 }
 
+static int ntsync_create_mutex(struct ntsync_device *dev, void __user *argp)
+{
+	struct ntsync_mutex_args __user *user_args = argp;
+	struct ntsync_mutex_args args;
+	struct ntsync_obj *mutex;
+	__u32 id;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	if (!args.owner != !args.count)
+		return -EINVAL;
+
+	mutex = kzalloc(sizeof(*mutex), GFP_KERNEL);
+	if (!mutex)
+		return -ENOMEM;
+
+	init_obj(mutex);
+	mutex->type = NTSYNC_TYPE_MUTEX;
+	mutex->u.mutex.count = args.count;
+	mutex->u.mutex.owner = args.owner;
+
+	ret = xa_alloc(&dev->objects, &id, mutex, xa_limit_32b, GFP_KERNEL);
+	if (ret < 0) {
+		kfree(mutex);
+		return ret;
+	}
+
+	return put_user(id, &user_args->mutex);
+}
+
 static int ntsync_delete(struct ntsync_device *dev, void __user *argp)
 {
 	struct ntsync_obj *obj;
@@ -497,6 +564,9 @@ static void try_wake_any_obj(struct ntsync_obj *obj)
 	case NTSYNC_TYPE_SEM:
 		try_wake_any_sem(obj);
 		break;
+	case NTSYNC_TYPE_MUTEX:
+		try_wake_any_mutex(obj);
+		break;
 	}
 }
 
@@ -662,6 +732,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 	void __user *argp = (void __user *)parm;
 
 	switch (cmd) {
+	case NTSYNC_IOC_CREATE_MUTEX:
+		return ntsync_create_mutex(dev, argp);
 	case NTSYNC_IOC_CREATE_SEM:
 		return ntsync_create_sem(dev, argp);
 	case NTSYNC_IOC_DELETE:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index a5bed5a39b21..26d1b3d4847f 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -16,6 +16,12 @@ struct ntsync_sem_args {
 	__u32 max;
 };
 
+struct ntsync_mutex_args {
+	__u32 mutex;
+	__u32 owner;
+	__u32 count;
+};
+
 struct ntsync_wait_args {
 	__u64 timeout;
 	__u64 objs;
@@ -38,5 +44,7 @@ struct ntsync_wait_args {
 					      struct ntsync_wait_args)
 #define NTSYNC_IOC_WAIT_ALL		_IOWR(NTSYNC_IOC_BASE, 4, \
 					      struct ntsync_wait_args)
+#define NTSYNC_IOC_CREATE_MUTEX		_IOWR(NTSYNC_IOC_BASE, 5, \
+					      struct ntsync_mutex_args)
 
 #endif
-- 
2.43.0


