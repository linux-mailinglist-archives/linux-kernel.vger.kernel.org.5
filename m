Return-Path: <linux-kernel+bounces-36245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A12839DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B344EB21635
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F124C155;
	Wed, 24 Jan 2024 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="NqaDxTmj"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6971CBE69;
	Wed, 24 Jan 2024 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057931; cv=none; b=aFPmwHUxnewYEqfYlJe1QmLPlfW16+70cs8PzoIi59plcR42SdvaJRYrW0XnqjutpJ3pg+/Yv/6SQkQIlktLZTnJF7A/B3rtX8lJFX8kIz+rDwu0aTI2YgvITVmSRfTVKIBNYk8JS4Qt7XNI4vbVuJ3HCusDYkJYm4SpmhEwvtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057931; c=relaxed/simple;
	bh=L53s4XKugQkrOf4wmM10ZZtY0u5t5bfPYmQ5sniUf08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aS7c4cZxpQTo5KdkZ2ubuGM2hkzukKB+V/bt3UaE3mtUffuWF92uuILtqM+ACnzJAoMuRpcVWmOyP9mwNsmozeu0+ATvFxf3rix91ahwAT93sTNqUiwxVevs6o49L5WpLJCtsc5PX41qHw6mWcyFAtYdvb852cA1MXU24I4btfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=NqaDxTmj; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=B8C2ooCSc+NBhSvPUGlWB1ForKDdhBTvYMz91+iwYYc=; b=NqaDxTmjeEQD25eSN/50W62HSZ
	Ip3tzc4B99p+kiJnGG4moYcCYrHf6ylTC9sC8tsfbRfJ9REIkLjaK7idJnz3tYGRN4obzWh6IhgkL
	vG9NPIQIS/nKADUqkbPle4Dk1IaZl/3JsGnc+jQy+U+EpKYEQ3/yl+xwKWBNazd8qwTtqcara6cW2
	OCGv/QdsXDs6r/lxzlPo9je68MvbtV4iVOmO8jdEpaGIb46uK8OVAoNDEsCUAPkthyxN1wTI81yRJ
	t4W4MP/76sk5k0f31yPXhfEshycKBNwPosxqnExeSe4Jl8fsvs/sEO2OmNl5OeTokjch1g+j/2E3S
	zvws5ZzQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSRLC-00DVeW-1Z;
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
Subject: [RFC PATCH 9/9] ntsync: Introduce NTSYNC_IOC_KILL_OWNER.
Date: Tue, 23 Jan 2024 18:40:28 -0600
Message-ID: <20240124004028.16826-10-zfigura@codeweavers.com>
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

This does not correspond to any NT syscall, but rather should be called by the
user-space NT emulator when a thread dies. It is responsible for marking any
mutexes owned by that thread as abandoned.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 80 ++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 28f43768d1c3..1173c750c106 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -64,6 +64,7 @@ struct ntsync_obj {
 		struct {
 			__u32 count;
 			__u32 owner;
+			bool ownerdead;
 		} mutex;
 	} u;
 };
@@ -87,6 +88,7 @@ struct ntsync_q {
 	atomic_t signaled;
 
 	bool all;
+	bool ownerdead;
 	__u32 count;
 	struct ntsync_q_entry entries[];
 };
@@ -240,6 +242,9 @@ static void try_wake_all(struct ntsync_device *dev, struct ntsync_q *q,
 				obj->u.sem.count--;
 				break;
 			case NTSYNC_TYPE_MUTEX:
+				if (obj->u.mutex.ownerdead)
+					q->ownerdead = true;
+				obj->u.mutex.ownerdead = false;
 				obj->u.mutex.count++;
 				obj->u.mutex.owner = q->owner;
 				break;
@@ -299,6 +304,9 @@ static void try_wake_any_mutex(struct ntsync_obj *mutex)
 			continue;
 
 		if (atomic_cmpxchg(&q->signaled, -1, entry->index) == -1) {
+			if (mutex->u.mutex.ownerdead)
+				q->ownerdead = true;
+			mutex->u.mutex.ownerdead = false;
 			mutex->u.mutex.count++;
 			mutex->u.mutex.owner = q->owner;
 			wake_up_process(q->task);
@@ -514,6 +522,71 @@ static int ntsync_put_mutex(struct ntsync_device *dev, void __user *argp)
 	return ret;
 }
 
+/*
+ * Actually change the mutex state to mark its owner as dead.
+ */
+static void put_mutex_ownerdead_state(struct ntsync_obj *mutex)
+{
+	lockdep_assert_held(&mutex->lock);
+
+	mutex->u.mutex.ownerdead = true;
+	mutex->u.mutex.owner = 0;
+	mutex->u.mutex.count = 0;
+}
+
+static int ntsync_kill_owner(struct ntsync_device *dev, void __user *argp)
+{
+	struct ntsync_obj *obj;
+	unsigned long id;
+	__u32 owner;
+
+	if (get_user(owner, (__u32 __user *)argp))
+		return -EFAULT;
+	if (!owner)
+		return -EINVAL;
+
+	rcu_read_lock();
+
+	xa_for_each(&dev->objects, id, obj) {
+		if (!kref_get_unless_zero(&obj->refcount))
+			continue;
+
+		if (obj->type != NTSYNC_TYPE_MUTEX) {
+			put_obj(obj);
+			continue;
+		}
+
+		if (atomic_read(&obj->all_hint) > 0) {
+			spin_lock(&dev->wait_all_lock);
+			spin_lock_nest_lock(&obj->lock, &dev->wait_all_lock);
+
+			if (obj->u.mutex.owner == owner) {
+				put_mutex_ownerdead_state(obj);
+				try_wake_all_obj(dev, obj);
+				try_wake_any_mutex(obj);
+			}
+
+			spin_unlock(&obj->lock);
+			spin_unlock(&dev->wait_all_lock);
+		} else {
+			spin_lock(&obj->lock);
+
+			if (obj->u.mutex.owner == owner) {
+				put_mutex_ownerdead_state(obj);
+				try_wake_any_mutex(obj);
+			}
+
+			spin_unlock(&obj->lock);
+		}
+
+		put_obj(obj);
+	}
+
+	rcu_read_unlock();
+
+	return 0;
+}
+
 static int ntsync_schedule(const struct ntsync_q *q, ktime_t *timeout)
 {
 	int ret = 0;
@@ -585,6 +658,7 @@ static int setup_wait(struct ntsync_device *dev,
 	q->owner = args->owner;
 	atomic_set(&q->signaled, -1);
 	q->all = all;
+	q->ownerdead = false;
 	q->count = count;
 
 	for (i = 0; i < count; i++) {
@@ -697,7 +771,7 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 		struct ntsync_wait_args __user *user_args = argp;
 
 		/* even if we caught a signal, we need to communicate success */
-		ret = 0;
+		ret = q->ownerdead ? -EOWNERDEAD : 0;
 
 		if (put_user(signaled, &user_args->index))
 			ret = -EFAULT;
@@ -778,7 +852,7 @@ static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
 		struct ntsync_wait_args __user *user_args = argp;
 
 		/* even if we caught a signal, we need to communicate success */
-		ret = 0;
+		ret = q->ownerdead ? -EOWNERDEAD : 0;
 
 		if (put_user(signaled, &user_args->index))
 			ret = -EFAULT;
@@ -803,6 +877,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_create_sem(dev, argp);
 	case NTSYNC_IOC_DELETE:
 		return ntsync_delete(dev, argp);
+	case NTSYNC_IOC_KILL_OWNER:
+		return ntsync_kill_owner(dev, argp);
 	case NTSYNC_IOC_PUT_MUTEX:
 		return ntsync_put_mutex(dev, argp);
 	case NTSYNC_IOC_PUT_SEM:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 2e44e7e77776..fec9a3993322 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -48,5 +48,6 @@ struct ntsync_wait_args {
 					      struct ntsync_mutex_args)
 #define NTSYNC_IOC_PUT_MUTEX		_IOWR(NTSYNC_IOC_BASE, 6, \
 					      struct ntsync_mutex_args)
+#define NTSYNC_IOC_KILL_OWNER		_IOW (NTSYNC_IOC_BASE, 7, __u32)
 
 #endif
-- 
2.43.0


