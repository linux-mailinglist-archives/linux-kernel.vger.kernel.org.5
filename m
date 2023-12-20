Return-Path: <linux-kernel+bounces-6979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 644AA81A007
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF459B21AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948E3358A5;
	Wed, 20 Dec 2023 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pBN07i0M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453424B4B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703079421; bh=1+yL4gGE9+NGHEgkyt7frrtI1/QrZQBFYggsrD23Jlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pBN07i0MrZv5X0hICU2DIWkTufmsx6Jx85jasot7c/gwiuROsNBELnWuxBkfEccOp
	 cyteFOVLf5H4PJKFRjsrOWPRuG0O0qfiEXiItEQnXLDMKv0w5qkGrokcy7g7ZKuMKz
	 h5dHNx0S5gCTlSmeJ+DGQ599iHKknOJ8Yrekl0Hg=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 93B8AAD4; Wed, 20 Dec 2023 21:36:59 +0800
X-QQ-mid: xmsmtpt1703079419trhplsea4
Message-ID: <tencent_A10367297463BFC44CB76A577DE6C1737305@qq.com>
X-QQ-XMAILINFO: OORdZW5aAcVyqp13AiMh2g6/cPk8RtxT1PCiOcfac1XfhcT5kXJlsFw0ZnQTzh
	 pR8qsaAx2S+1BTyjfAXgP5onxyM+siwnYotn0W3RlqkTJ+vu/M6EZAH+w0FLmhG2vdyEi8PmK0W1
	 QPsOXVJCOfi5OoSsMRYQxwsgngraFFjJ5lRG1CR1NzNeXN0bsh7TN34sQswlprBjn+yusgHHIoqf
	 ixfIP9BMF4gJmMgRAN/KabxCqMuS6ogqSc7eQyaSudQAqUxonhxw/v1e159vIkIam5hKJ8Wkeyo0
	 m4q0mQaHlD2FL6/HxPwfTr0xM90u6k6E35MJ+eTJDjLXcsSt/fZl/t6PyPbDCaiXZebgkWm6pdJY
	 /aCbeYmTPf+US90F2aDtxrR/j5QWFw9UgYwXUqqk+9cvTqx5j/FiOe99ryNUbjuSkdthLGwTCM1A
	 75XNS6aFEWGXfijjlH09dIvvEWrEsBfqPKGZ8R/XzxOZwNmV7u2Tr2EAzst41Om0WuUKPdbQBPON
	 HwHGrIq37kzzVD5mkAQMpp91JixZJUz800HG8kqc1434reIkMsIUqlLgAQHq6t2MM5Q2KTA5YyUN
	 njA8ZNUyKmTdRVHYC6a5dSRx7Xr0JkFrHZdJn3+72YmLLtjbKp5PwjU04irWx6bLcTijR0vWlQzG
	 6e9sCC/PU9IThh29WfsFWbQNunDEr+yW/sc4+BU2a4dlHHHCqUaIlKI9qg4XHy5EYdXj0r+XdzqK
	 eOiHYX7AI0PrJd1TF8ZqESkvI0HyJtPlXGPdAAf9f77fB0tBifyXjhxnuVlcoAHZ14Ws7efkxcnY
	 ujHbPiSdaEHnliPS5QvKRbbN16PzZAWzpOLBJ8ivzrS3qc9vPS33/x6HrPoqrSb8/gN+ZnK+bE39
	 sAkaj2Qe0FYwZwpqGYZPM/GUq8PCTeZ+CaThe7Ht/8TDxoKKeBZY0rYSNud32HTy6oHYFJAdpxOh
	 1XA9LcorhlUIFeVCdLNQtAc95elTmUw1gGHfuxcMw=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
Date: Wed, 20 Dec 2023 21:37:00 +0800
X-OQ-MSGID: <20231220133659.3639130-2-eadavis@qq.com>
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

please test slab-out-of-bounds Read in arc4_crypt

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 17cb8a20bde6

diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index 02cea2149504..72ce8e9c16d5 100644
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
@@ -115,8 +117,11 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	/* Allocate cipher request for current operation. */
-	areq = af_alg_alloc_areq(sk, sizeof(struct af_alg_async_req) +
-				     crypto_skcipher_reqsize(tfm));
+	aqlen = sizeof(struct af_alg_async_req) + crypto_skcipher_reqsize(tfm);
+	if (alg->co.base.cra_type != &crypto_skcipher_type)
+		aqlen += alg->co.statesize;
+	printk("%u, %s\n", alg->co.statesize, __func__);
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


