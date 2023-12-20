Return-Path: <linux-kernel+bounces-7244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0CE81A3B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1CA1C2437D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40B4645B;
	Wed, 20 Dec 2023 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nhWyhg47"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B33F4184F;
	Wed, 20 Dec 2023 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703088007; bh=g8YvPRZUntmP0IXEJjRd82n+bHsmgSr7jmdUnUCb5/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nhWyhg47K5trIv3W6tnxOID4QSwSS3RBE88WVqokE7C8EHiWAi7e6nTLPAopTv7dY
	 ETDNztUcYKhpEdBrxTtbgpbeDjuP762fmagwgkp7oFL90S9k4OcK/AEYHxGlqc4/FR
	 yu/uCKVqV9EKxRBuJ1wlbhXc5VT8PiO2xTS6m1IM=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id D7712EE5; Wed, 20 Dec 2023 23:53:55 +0800
X-QQ-mid: xmsmtpt1703087635teeqh3v89
Message-ID: <tencent_656D589558EA3EED8ACF3C79166F202E010A@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j87+24TT5WJDwDVq9R2dk3vEOfbV0qyctP9ss1ZMwPstU9eR941/
	 eq+dlV766aDFwmPR88WdvbP9XnuZ1jpmB9JcFugwr3K/vpsGnpCHZVTaECu0Hrfl8yV+ET5y7qwQ
	 JOHIeU1G3T1hoeHOZSVHF847PNIZHJyJrmFH2/LbvzHrzsmn6rxn0WuXdQGkTHufEKTsvuNaFxyA
	 RO1Ogitq6hPhebmyBfU/w/B+6PTFkLp+Oz+ufLDBcwXqE0SJ7rwE4ywYM7fTJ1j3nD9eA/Ott9X6
	 TJcW2Y5/WorYCzgWkVZ/BqvAybY2iRVCF8R/U+UAydqrc9U7FGJLwPYdhUSMnR3PIkk86AWZUSei
	 KFvRBNQ3PlYfsHHx5l0z/FGwjq8tP5rypBU2PYN7xU/e2oJHVtJk8xyGsrCI3FHSzmoGr+1O+sPM
	 955narG5ZmL8FgonzFRVjGUjhDE16IlKHAB+GffsZjqEGK+Ulkozn7+olgot65KAbkOAvSNGedac
	 A5uaEK72K1lL7Ye3h8syar2z3IKs7fTnY1Pd/wuhq+qoYXoeae1eZfjeJw7Qpv0q1Z+NXv6R2DC6
	 XiP7ZiMjeLgupSvAszetwTOz6YD7fEY66b7zxqGp3qAUzYP11tpMd8DhBTpaPLSVpFFVB6pkBOTZ
	 5loRSoLzHBSyrsaDsUTKtheUkYw0kaKELjvXGuqyn9UfI3KsXSlw2YWRV9fRcdi7OROipc77ovSK
	 slTdFp1q8OLqzJxWTVGFdaWfj73Hp4eWtyPcZuVbHeHm+5CYrREusjdi4fZK9RZhVw/YN/GyW+Y5
	 r/gjrW4mwgVVSN31WSsJ6HOW/gYTCY6VTPpe5pud1lW5/pC5MutsZRndkt9iUqwwVXXYdLx5lEaV
	 m6ceCwM6R9kHW/wIQJ9I5TaZz1kZZG6RYLn/VqxcOKIAW8jo1/8xpwFMulF3QOKyQve9QciCshQO
	 6+xYxxYdMkJ4AV9+XW+A==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next] crypto: fix oob Read in arc4_crypt
Date: Wed, 20 Dec 2023 23:53:55 +0800
X-OQ-MSGID: <20231220155354.3824368-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000d52e14060cc9c551@google.com>
References: <000000000000d52e14060cc9c551@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The space allocated to areq is not sufficient to access the member __ctx of 
struct skcipher_request, as the space occupied by struct arc4_ctx for reading 
is 1032 bytes, while the requested memory size in skcipher_recvmsg() is:
sizeof(struct af_alg_async_req) + crypto_skcipher_reqsize(tfm) = 736 bytes,
which does not include the memory required for __ctx of struct skcipher_request.

Reported-by: syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 crypto/algif_skcipher.c            | 10 +++++++---
 crypto/skcipher.c                  |  1 -
 include/crypto/internal/skcipher.h |  1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index 02cea2149504..b69d361b5515 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -33,6 +33,7 @@
 #include <linux/module.h>
 #include <linux/net.h>
 #include <net/sock.h>
+#include <crypto/internal/skcipher.h>
 
 static int skcipher_sendmsg(struct socket *sock, struct msghdr *msg,
 			    size_t size)
@@ -102,11 +103,12 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct alg_sock *pask = alg_sk(psk);
 	struct af_alg_ctx *ctx = ask->private;
 	struct crypto_skcipher *tfm = pask->private;
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
 	unsigned int bs = crypto_skcipher_chunksize(tfm);
 	struct af_alg_async_req *areq;
 	unsigned cflags = 0;
 	int err = 0;
-	size_t len = 0;
+	size_t len = 0, aqlen;
 
 	if (!ctx->init || (ctx->more && ctx->used < bs)) {
 		err = af_alg_wait_for_data(sk, flags, bs);
@@ -115,8 +117,10 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	/* Allocate cipher request for current operation. */
-	areq = af_alg_alloc_areq(sk, sizeof(struct af_alg_async_req) +
-				     crypto_skcipher_reqsize(tfm));
+	aqlen = sizeof(struct af_alg_async_req) + crypto_skcipher_reqsize(tfm);
+	if (alg->co.base.cra_type != &crypto_skcipher_type)
+		aqlen += 1032;
+	areq = af_alg_alloc_areq(sk, aqlen);
 	if (IS_ERR(areq))
 		return PTR_ERR(areq);
 
diff --git a/crypto/skcipher.c b/crypto/skcipher.c
index bc70e159d27d..0ae4a05a5aa7 100644
--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -44,7 +44,6 @@ struct skcipher_walk_buffer {
 	u8 buffer[];
 };
 
-static const struct crypto_type crypto_skcipher_type;
 
 static int skcipher_walk_next(struct skcipher_walk *walk);
 
diff --git a/include/crypto/internal/skcipher.h b/include/crypto/internal/skcipher.h
index 7ae42afdcf3e..3c05872652f2 100644
--- a/include/crypto/internal/skcipher.h
+++ b/include/crypto/internal/skcipher.h
@@ -24,6 +24,7 @@
 
 struct aead_request;
 struct rtattr;
+static const struct crypto_type crypto_skcipher_type;
 
 struct skcipher_instance {
 	void (*free)(struct skcipher_instance *inst);
-- 
2.43.0


