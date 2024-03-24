Return-Path: <linux-kernel+bounces-115175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CF6889340
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACAC1C2B7B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6937D13C91B;
	Mon, 25 Mar 2024 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxEeFK3A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709422BF99;
	Sun, 24 Mar 2024 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324234; cv=none; b=XVxSGVQPRXZY1aaOjhYWMm+S5GxXe2WLs1qp1R3yEGKcRdSPi14ch/CxAPQLX9mxHvLjKBLx7I1uxcIC/bTi8f2cHuv52FhlAYcaoNA48TpPh4iO13KX6+UIz4oL/OTIcI/tW7r9S++AZ5TvtRYR12o4MJjIFmxN56R5MP3DdwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324234; c=relaxed/simple;
	bh=yEXvRrcGEs1LrMgD2vUSSiAEV+7hUKTAAOpMzsUJkAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPYIkPoM9TtcbzAPaPdmzwjfi532NVk4OFbsUkD5MsW+bl8R5Q4To451rbZnuzLkz3uXySlk6SIqSOxAQZKRhDiWa9ytUWwU6B6fbkdZp9QyPEx3IMpILG/e9HEW7Y28tq/bkzLOAMO8GULustnyV7Qc0z0K+xVI7ZDViR8e3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxEeFK3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E520C433F1;
	Sun, 24 Mar 2024 23:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324233;
	bh=yEXvRrcGEs1LrMgD2vUSSiAEV+7hUKTAAOpMzsUJkAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxEeFK3AHD2+1CqrYUfnd742FOwEHvYSaNU+Oa+IksTgazw40GffRlLh3DLLZ6MQ4
	 F7W1fQ7OCkKpBEyFXn6letMAoFO2V3bpE0RmBfviZaM2DBkOSwARRO0yVpJJg9qR7x
	 EgP7gO3dpscvsfs6hcvPlvNu2dgZjO7bTZtKCTEBTUPhJ/lDC6UmRHTtDB8K8GRg/y
	 ajfUWpRfpXDFqgvrGKV7P7BP3i6vRC1qqXUBWhe9dwfmqY7kspsFAPbFXdH6IzH5IQ
	 gHMFPjYbxY1Gvx7sMGwvy9yIND1kJ27HO60Mr9SShIBA9W3/EUU9q+VdwxxbWfRHZY
	 eShlk15xpRx2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 016/148] crypto: af_alg - make some functions static
Date: Sun, 24 Mar 2024 19:48:00 -0400
Message-ID: <20240324235012.1356413-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 466e0759269d31485074126700574230bfff3b1c ]

Some exported functions in af_alg.c aren't used outside of that file.
Therefore, un-export them and make them 'static'.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: f3c802a1f300 ("crypto: algif_aead - Only wake up when ctx->more is zero")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/af_alg.c         | 20 +++++++-------------
 include/crypto/if_alg.h |  7 -------
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 914496b184a97..ed62632a1c355 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -429,12 +429,12 @@ int af_alg_make_sg(struct af_alg_sgl *sgl, struct iov_iter *iter, int len)
 }
 EXPORT_SYMBOL_GPL(af_alg_make_sg);
 
-void af_alg_link_sg(struct af_alg_sgl *sgl_prev, struct af_alg_sgl *sgl_new)
+static void af_alg_link_sg(struct af_alg_sgl *sgl_prev,
+			   struct af_alg_sgl *sgl_new)
 {
 	sg_unmark_end(sgl_prev->sg + sgl_prev->npages - 1);
 	sg_chain(sgl_prev->sg, sgl_prev->npages + 1, sgl_new->sg);
 }
-EXPORT_SYMBOL_GPL(af_alg_link_sg);
 
 void af_alg_free_sg(struct af_alg_sgl *sgl)
 {
@@ -445,7 +445,7 @@ void af_alg_free_sg(struct af_alg_sgl *sgl)
 }
 EXPORT_SYMBOL_GPL(af_alg_free_sg);
 
-int af_alg_cmsg_send(struct msghdr *msg, struct af_alg_control *con)
+static int af_alg_cmsg_send(struct msghdr *msg, struct af_alg_control *con)
 {
 	struct cmsghdr *cmsg;
 
@@ -484,7 +484,6 @@ int af_alg_cmsg_send(struct msghdr *msg, struct af_alg_control *con)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(af_alg_cmsg_send);
 
 /**
  * af_alg_alloc_tsgl - allocate the TX SGL
@@ -492,7 +491,7 @@ EXPORT_SYMBOL_GPL(af_alg_cmsg_send);
  * @sk socket of connection to user space
  * @return: 0 upon success, < 0 upon error
  */
-int af_alg_alloc_tsgl(struct sock *sk)
+static int af_alg_alloc_tsgl(struct sock *sk)
 {
 	struct alg_sock *ask = alg_sk(sk);
 	struct af_alg_ctx *ctx = ask->private;
@@ -521,7 +520,6 @@ int af_alg_alloc_tsgl(struct sock *sk)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(af_alg_alloc_tsgl);
 
 /**
  * aead_count_tsgl - Count number of TX SG entries
@@ -658,7 +656,7 @@ EXPORT_SYMBOL_GPL(af_alg_pull_tsgl);
  *
  * @areq Request holding the TX and RX SGL
  */
-void af_alg_free_areq_sgls(struct af_alg_async_req *areq)
+static void af_alg_free_areq_sgls(struct af_alg_async_req *areq)
 {
 	struct sock *sk = areq->sk;
 	struct alg_sock *ask = alg_sk(sk);
@@ -687,7 +685,6 @@ void af_alg_free_areq_sgls(struct af_alg_async_req *areq)
 		sock_kfree_s(sk, tsgl, areq->tsgl_entries * sizeof(*tsgl));
 	}
 }
-EXPORT_SYMBOL_GPL(af_alg_free_areq_sgls);
 
 /**
  * af_alg_wait_for_wmem - wait for availability of writable memory
@@ -696,7 +693,7 @@ EXPORT_SYMBOL_GPL(af_alg_free_areq_sgls);
  * @flags If MSG_DONTWAIT is set, then only report if function would sleep
  * @return 0 when writable memory is available, < 0 upon error
  */
-int af_alg_wait_for_wmem(struct sock *sk, unsigned int flags)
+static int af_alg_wait_for_wmem(struct sock *sk, unsigned int flags)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	int err = -ERESTARTSYS;
@@ -721,7 +718,6 @@ int af_alg_wait_for_wmem(struct sock *sk, unsigned int flags)
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(af_alg_wait_for_wmem);
 
 /**
  * af_alg_wmem_wakeup - wakeup caller when writable memory is available
@@ -790,8 +786,7 @@ EXPORT_SYMBOL_GPL(af_alg_wait_for_data);
  *
  * @sk socket of connection to user space
  */
-
-void af_alg_data_wakeup(struct sock *sk)
+static void af_alg_data_wakeup(struct sock *sk)
 {
 	struct alg_sock *ask = alg_sk(sk);
 	struct af_alg_ctx *ctx = ask->private;
@@ -809,7 +804,6 @@ void af_alg_data_wakeup(struct sock *sk)
 	sk_wake_async(sk, SOCK_WAKE_SPACE, POLL_OUT);
 	rcu_read_unlock();
 }
-EXPORT_SYMBOL_GPL(af_alg_data_wakeup);
 
 /**
  * af_alg_sendmsg - implementation of sendmsg system call handler
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 2c1748dc66405..f0c83a7bd078b 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -172,9 +172,6 @@ int af_alg_accept(struct sock *sk, struct socket *newsock, bool kern);
 
 int af_alg_make_sg(struct af_alg_sgl *sgl, struct iov_iter *iter, int len);
 void af_alg_free_sg(struct af_alg_sgl *sgl);
-void af_alg_link_sg(struct af_alg_sgl *sgl_prev, struct af_alg_sgl *sgl_new);
-
-int af_alg_cmsg_send(struct msghdr *msg, struct af_alg_control *con);
 
 static inline struct alg_sock *alg_sk(struct sock *sk)
 {
@@ -233,15 +230,11 @@ static inline bool af_alg_readable(struct sock *sk)
 	return PAGE_SIZE <= af_alg_rcvbuf(sk);
 }
 
-int af_alg_alloc_tsgl(struct sock *sk);
 unsigned int af_alg_count_tsgl(struct sock *sk, size_t bytes, size_t offset);
 void af_alg_pull_tsgl(struct sock *sk, size_t used, struct scatterlist *dst,
 		      size_t dst_offset);
-void af_alg_free_areq_sgls(struct af_alg_async_req *areq);
-int af_alg_wait_for_wmem(struct sock *sk, unsigned int flags);
 void af_alg_wmem_wakeup(struct sock *sk);
 int af_alg_wait_for_data(struct sock *sk, unsigned flags);
-void af_alg_data_wakeup(struct sock *sk);
 int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		   unsigned int ivsize);
 ssize_t af_alg_sendpage(struct socket *sock, struct page *page,
-- 
2.43.0


