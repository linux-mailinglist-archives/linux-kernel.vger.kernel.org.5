Return-Path: <linux-kernel+bounces-36244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92515839DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419B228DEC8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8952FBA5D;
	Wed, 24 Jan 2024 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="nCD3x1+s"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73277AD38;
	Wed, 24 Jan 2024 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057928; cv=none; b=XYPNQ4L3zrFtO9kCGPNn0BHvjn+XOfD+4OH/PtE92EPw1zveqRXtGrMht0H6on/BjE8u42TVrCFfd49HzPUtTtQV7eU4qFeqcAu8r/kRL6JbJHKe1xaegqvTqmffPMsl7geoBnxjihGVA9/+XufleI3/qlH/DI+0+J28FuoUHWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057928; c=relaxed/simple;
	bh=iT0r2RJsto1epLipUV7SicZlac1/9HjZGJBM22ZpeMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcFhJSD0+/GgfvDm/ZFeFwOCYTEn0f6Ul4jG2g/MRDE4GFTVdsnQeOGqdi6enb+IcKuy4RKcaaQg1pTLH+rNKEPm9TTb0oS9Q1I90ZyHx+1715F0YoqkoKYZmkZqsTD0L8zVc6un4lXReTOr28unhSVzwIuqsCWJOo1GjQy98sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=nCD3x1+s; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=eZKiIoLdsYnVqMY14FeAEuF83BaQKKBYG8kS3hI8OEQ=; b=nCD3x1+skIr64JObiGTnvjAR3J
	BXBdGr7y/1cAZYqhITSnQ73PPPQczXmXiJHZYDM194xUMoZbjkba2sgi9WQBDEIiDIWny/sixH4Oi
	qEPN8oCIqY5huhGeMpPCw5yQdYLBuQ3IOTkkPXUdSrO9dWj7UIjpNmAQKOdNASbqVKLluZA7rXTYk
	lH0a2i0YMkQyg/JPey0al9TplGpw7LaTIvFA8edL1SCcWEu5yN6JCx4fM5VZ7Y1zXmWcR0ghh75Xz
	Xh1FiCdUlZa5l+kVBa6sHZ7y4UUC7bUEw8z8ZlavNUsLjuiRHBNp3oZaoTX3JAng4J4+nGO7OIRWY
	dusaE1xQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSRLC-00DVeW-18;
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
Subject: [RFC PATCH 8/9] ntsync: Introduce NTSYNC_IOC_PUT_MUTEX.
Date: Tue, 23 Jan 2024 18:40:27 -0600
Message-ID: <20240124004028.16826-9-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtReleaseMutant().

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 67 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  2 ++
 2 files changed, 69 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index d48f2ef41341..28f43768d1c3 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -449,6 +449,71 @@ static int ntsync_put_sem(struct ntsync_device *dev, void __user *argp)
 	return ret;
 }
 
+/*
+ * Actually change the mutex state, returning -EPERM if not the owner.
+ */
+static int put_mutex_state(struct ntsync_obj *mutex,
+			   const struct ntsync_mutex_args *args)
+{
+	lockdep_assert_held(&mutex->lock);
+
+	if (mutex->u.mutex.owner != args->owner)
+		return -EPERM;
+
+	if (!--mutex->u.mutex.count)
+		mutex->u.mutex.owner = 0;
+	return 0;
+}
+
+static int ntsync_put_mutex(struct ntsync_device *dev, void __user *argp)
+{
+	struct ntsync_mutex_args __user *user_args = argp;
+	struct ntsync_mutex_args args;
+	struct ntsync_obj *mutex;
+	__u32 prev_count;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+	if (!args.owner)
+		return -EINVAL;
+
+	mutex = get_obj_typed(dev, args.mutex, NTSYNC_TYPE_MUTEX);
+	if (!mutex)
+		return -EINVAL;
+
+	if (atomic_read(&mutex->all_hint) > 0) {
+		spin_lock(&dev->wait_all_lock);
+		spin_lock_nest_lock(&mutex->lock, &dev->wait_all_lock);
+
+		prev_count = mutex->u.mutex.count;
+		ret = put_mutex_state(mutex, &args);
+		if (!ret) {
+			try_wake_all_obj(dev, mutex);
+			try_wake_any_mutex(mutex);
+		}
+
+		spin_unlock(&mutex->lock);
+		spin_unlock(&dev->wait_all_lock);
+	} else {
+		spin_lock(&mutex->lock);
+
+		prev_count = mutex->u.mutex.count;
+		ret = put_mutex_state(mutex, &args);
+		if (!ret)
+			try_wake_any_mutex(mutex);
+
+		spin_unlock(&mutex->lock);
+	}
+
+	put_obj(mutex);
+
+	if (!ret && put_user(prev_count, &user_args->count))
+		ret = -EFAULT;
+
+	return ret;
+}
+
 static int ntsync_schedule(const struct ntsync_q *q, ktime_t *timeout)
 {
 	int ret = 0;
@@ -738,6 +803,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_create_sem(dev, argp);
 	case NTSYNC_IOC_DELETE:
 		return ntsync_delete(dev, argp);
+	case NTSYNC_IOC_PUT_MUTEX:
+		return ntsync_put_mutex(dev, argp);
 	case NTSYNC_IOC_PUT_SEM:
 		return ntsync_put_sem(dev, argp);
 	case NTSYNC_IOC_WAIT_ALL:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 26d1b3d4847f..2e44e7e77776 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -46,5 +46,7 @@ struct ntsync_wait_args {
 					      struct ntsync_wait_args)
 #define NTSYNC_IOC_CREATE_MUTEX		_IOWR(NTSYNC_IOC_BASE, 5, \
 					      struct ntsync_mutex_args)
+#define NTSYNC_IOC_PUT_MUTEX		_IOWR(NTSYNC_IOC_BASE, 6, \
+					      struct ntsync_mutex_args)
 
 #endif
-- 
2.43.0


