Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB46803BF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjLDRsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjLDRs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:48:28 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E14FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:48:34 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-420210e3b7dso3515851cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701712113; x=1702316913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlymwK1jk1jFV3VCFiRQli/4cvIfOna4saXXrG5eqCA=;
        b=mq2W6awpsGMCC4QQT/cV5B7mGmDfgbR7amQLrTjE6yRPoekv7JyVaYRF09RUEjPEoT
         +vhYvYfHNkkc3pQ1IZx+ezVdNwwAMLtyFUPxDhBqrXx8yxo/CvI7E2VmmWsnIvi3ilQ+
         3OocCG+TCcssFSFqC/twIVZfLFf8tgb1FIQhbJRT7RWsGrKSvvaks5xUg/biHd+POeNB
         wp+hPnUztkMq0UUBBj2u6YesUccVcX7HBbRjatSAPSnkF9di39P5FsuhcpgTpGv/3613
         58QXASizNWURKwuoXt+IBqLiEzijIiyEg/YjE5giYTsF3Wi+aq83aqKAmvOIoGUkqZyU
         QkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701712113; x=1702316913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlymwK1jk1jFV3VCFiRQli/4cvIfOna4saXXrG5eqCA=;
        b=ALuexRDp0JjqZFUDXUv+N+W2a9Aauw66qEuMIpvxRHKB8njPszyGottx6sTe4LlhK3
         6uQeMmOvEnRXwF2RKKDProC6Yn1UAjkySgHriYlveqlS1WGk0hZGGGjcEtVLqGtmKA7b
         VKTDiQpAo6QHjJegRzR38z/XQFkQJArc4A/k+I4D+ZWHLBjKQZj0ZN83jG2xOBKg2grf
         8FlYatj6Nsa7UPbdTobNNYKGvQLrAEHbtkwxfiwHiy80OrZeHNNQ/bFf8BLSG1coTCEL
         bk23jGaaYZq86Dx7YSv3b9dVuelyMprurrdbus2pFuEFyaZ7DQoWK5PsuEjPS2P6JXIE
         cWTg==
X-Gm-Message-State: AOJu0YxIHOYp2C7hI989zXlFn2Hj9A/uQ3tAKc5O9vWSv2okKHDDi3/9
        kbCjrjhdw1RQ/iKcisK9eyi0XefTGNgByVwA1m00ww==
X-Google-Smtp-Source: AGHT+IEE0WBXcJ4e710PUdn+lcijnC4gQS2DsbgE+PN5g0/3F1n7D6IcCzGIrOQBPWTKB6fglOXGcQ==
X-Received: by 2002:ac8:5d8c:0:b0:423:75a2:330f with SMTP id d12-20020ac85d8c000000b0042375a2330fmr36563842qtx.2.1701712113395;
        Mon, 04 Dec 2023 09:48:33 -0800 (PST)
Received: from m2max.tfbnw.net ([2620:10d:c091:400::5:2355])
        by smtp.gmail.com with ESMTPSA id hg15-20020a05622a610f00b00424059fe96esm3670981qtb.89.2023.12.04.09.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:48:32 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] iov_iter: remove unused 'iov' argument from import_single_range()
Date:   Mon,  4 Dec 2023 10:47:49 -0700
Message-ID: <20231204174827.1258875-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204174827.1258875-1-axboe@kernel.dk>
References: <20231204174827.1258875-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is entirely unused, just get rid of it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c         | 6 ++----
 drivers/char/random.c            | 6 ++----
 fs/aio.c                         | 2 +-
 include/linux/uio.h              | 2 +-
 kernel/trace/trace_events_user.c | 3 +--
 lib/iov_iter.c                   | 2 +-
 net/ipv4/tcp.c                   | 6 ++----
 net/socket.c                     | 6 ++----
 security/keys/keyctl.c           | 3 +--
 9 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 83600b45e12a..5656b0a1233d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -893,11 +893,10 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 	 */
 	if (ublk_need_map_req(req)) {
 		struct iov_iter iter;
-		struct iovec iov;
 		const int dir = ITER_DEST;
 
 		import_single_range(dir, u64_to_user_ptr(io->addr), rq_bytes,
-				&iov, &iter);
+					&iter);
 
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
@@ -915,13 +914,12 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 
 	if (ublk_need_unmap_req(req)) {
 		struct iov_iter iter;
-		struct iovec iov;
 		const int dir = ITER_SOURCE;
 
 		WARN_ON_ONCE(io->res > rq_bytes);
 
 		import_single_range(dir, u64_to_user_ptr(io->addr), io->res,
-				&iov, &iter);
+					&iter);
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4a9c79391dee..e79ae238b30d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1364,7 +1364,6 @@ static void __cold try_to_generate_entropy(void)
 SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags)
 {
 	struct iov_iter iter;
-	struct iovec iov;
 	int ret;
 
 	if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE))
@@ -1385,7 +1384,7 @@ SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags
 			return ret;
 	}
 
-	ret = import_single_range(ITER_DEST, ubuf, len, &iov, &iter);
+	ret = import_single_range(ITER_DEST, ubuf, len, &iter);
 	if (unlikely(ret))
 		return ret;
 	return get_random_bytes_user(&iter);
@@ -1491,7 +1490,6 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		return 0;
 	case RNDADDENTROPY: {
 		struct iov_iter iter;
-		struct iovec iov;
 		ssize_t ret;
 		int len;
 
@@ -1503,7 +1501,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		if (get_user(len, p++))
 			return -EFAULT;
-		ret = import_single_range(ITER_SOURCE, p, len, &iov, &iter);
+		ret = import_single_range(ITER_SOURCE, p, len, &iter);
 		if (unlikely(ret))
 			return ret;
 		ret = write_pool_user(&iter);
diff --git a/fs/aio.c b/fs/aio.c
index f8589caef9c1..251eeaef7fbf 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1498,7 +1498,7 @@ static ssize_t aio_setup_rw(int rw, const struct iocb *iocb,
 	size_t len = iocb->aio_nbytes;
 
 	if (!vectored) {
-		ssize_t ret = import_single_range(rw, buf, len, *iovec, iter);
+		ssize_t ret = import_single_range(rw, buf, len, iter);
 		*iovec = NULL;
 		return ret;
 	}
diff --git a/include/linux/uio.h b/include/linux/uio.h
index b6214cbf2a43..bfafd3542fa7 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -348,7 +348,7 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 		 unsigned nr_segs, unsigned fast_segs, struct iovec **iovp,
 		 struct iov_iter *i, bool compat);
 int import_single_range(int type, void __user *buf, size_t len,
-		 struct iovec *iov, struct iov_iter *i);
+		 struct iov_iter *i);
 int import_ubuf(int type, void __user *buf, size_t len, struct iov_iter *i);
 
 static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 9365ce407426..4efc75d90a0d 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2177,14 +2177,13 @@ static int user_events_open(struct inode *node, struct file *file)
 static ssize_t user_events_write(struct file *file, const char __user *ubuf,
 				 size_t count, loff_t *ppos)
 {
-	struct iovec iov;
 	struct iov_iter i;
 
 	if (unlikely(*ppos != 0))
 		return -EFAULT;
 
 	if (unlikely(import_single_range(ITER_SOURCE, (char __user *)ubuf,
-					 count, &iov, &i)))
+					 count, &i)))
 		return -EFAULT;
 
 	return user_events_write_core(file, &i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index de7d11cf4c63..d60c73354e1f 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1370,7 +1370,7 @@ ssize_t import_iovec(int type, const struct iovec __user *uvec,
 EXPORT_SYMBOL(import_iovec);
 
 int import_single_range(int rw, void __user *buf, size_t len,
-		 struct iovec *iov, struct iov_iter *i)
+			struct iov_iter *i)
 {
 	if (len > MAX_RW_COUNT)
 		len = MAX_RW_COUNT;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 53bcc17c91e4..57cf3adb191a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1849,7 +1849,6 @@ static int receive_fallback_to_copy(struct sock *sk,
 {
 	unsigned long copy_address = (unsigned long)zc->copybuf_address;
 	struct msghdr msg = {};
-	struct iovec iov;
 	int err;
 
 	zc->length = 0;
@@ -1859,7 +1858,7 @@ static int receive_fallback_to_copy(struct sock *sk,
 		return -EINVAL;
 
 	err = import_single_range(ITER_DEST, (void __user *)copy_address,
-				  inq, &iov, &msg.msg_iter);
+				  inq, &msg.msg_iter);
 	if (err)
 		return err;
 
@@ -1886,14 +1885,13 @@ static int tcp_copy_straggler_data(struct tcp_zerocopy_receive *zc,
 {
 	unsigned long copy_address = (unsigned long)zc->copybuf_address;
 	struct msghdr msg = {};
-	struct iovec iov;
 	int err;
 
 	if (copy_address != zc->copybuf_address)
 		return -EINVAL;
 
 	err = import_single_range(ITER_DEST, (void __user *)copy_address,
-				  copylen, &iov, &msg.msg_iter);
+				  copylen, &msg.msg_iter);
 	if (err)
 		return err;
 	err = skb_copy_datagram_msg(skb, *offset, &msg, copylen);
diff --git a/net/socket.c b/net/socket.c
index 3379c64217a4..1f0d0e8d0a50 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2161,10 +2161,9 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 	struct sockaddr_storage address;
 	int err;
 	struct msghdr msg;
-	struct iovec iov;
 	int fput_needed;
 
-	err = import_single_range(ITER_SOURCE, buff, len, &iov, &msg.msg_iter);
+	err = import_single_range(ITER_SOURCE, buff, len, &msg.msg_iter);
 	if (unlikely(err))
 		return err;
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
@@ -2226,11 +2225,10 @@ int __sys_recvfrom(int fd, void __user *ubuf, size_t size, unsigned int flags,
 		.msg_name = addr ? (struct sockaddr *)&address : NULL,
 	};
 	struct socket *sock;
-	struct iovec iov;
 	int err, err2;
 	int fput_needed;
 
-	err = import_single_range(ITER_DEST, ubuf, size, &iov, &msg.msg_iter);
+	err = import_single_range(ITER_DEST, ubuf, size, &msg.msg_iter);
 	if (unlikely(err))
 		return err;
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 19be69fa4d05..193df7ca3ca8 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1252,12 +1252,11 @@ long keyctl_instantiate_key(key_serial_t id,
 			    key_serial_t ringid)
 {
 	if (_payload && plen) {
-		struct iovec iov;
 		struct iov_iter from;
 		int ret;
 
 		ret = import_single_range(ITER_SOURCE, (void __user *)_payload, plen,
-					  &iov, &from);
+					  &from);
 		if (unlikely(ret))
 			return ret;
 
-- 
2.42.0

