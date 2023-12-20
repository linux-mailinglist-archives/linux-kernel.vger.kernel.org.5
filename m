Return-Path: <linux-kernel+bounces-6918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8200819F53
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C07CB234B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8241F2554D;
	Wed, 20 Dec 2023 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JK5dcKx/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABC425543
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703076714; bh=dDA7s6cLkYl9Y27bXuM7ONc4rDr3vZ02baelaAtoo48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JK5dcKx/lHmu5nrnVluTe/CSG17v5Ds6VQsB4c1pU5LsN4J2rhksRfflAOFe95DLt
	 nLerNSJsJv4Ek/4crZsW2DZzyA+J3D43SFisobSm+aLV8cfOrZQRsx72m8tRoa1l4L
	 RoUPg5JyjMbhIz6IsukP5TMXPa9FkLVyhdrvg4LI=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id CF49281A; Wed, 20 Dec 2023 20:51:52 +0800
X-QQ-mid: xmsmtpt1703076712tv7g3v10l
Message-ID: <tencent_08175DFCDDF2993CCFAB0D88A5BD0D889207@qq.com>
X-QQ-XMAILINFO: OCzxluqIaPHWpv/n4BVKJUo54DWozrG+RlGeUL8eBJk/YsYbSs5JPiLpT0VHdA
	 j8Ca9NECVQcKAQyK4NGO0FGZ3gPgNb47rglkiJKt9OFw6g8UgfJ70GL/gokYvNTBeWi/z7aSn6nL
	 25IQQ7aMT+bfUB0JgUE1mdZOKq2SblHJbZVR53EoHYsaPoBE4GyjOwGUE7AuiB3rPYnoymZB1smL
	 7QPms0M1IHbpSCnLZb+fpWi4G+DVLXtmi7C0DKmB1l9mzt91RMNYxbc+hfOB6bXp5XbWtnvSXeR6
	 o8x081YITRrjVQAjUUNuPxogOoJTlkeWU/WnIwzbfAjCfsjiq7cydTBSMiLZcn5zCiXWiq31QWZc
	 m3HZNcFqUiD8e/q/qwTGbVK4uXo39QQZKQDL1/wNh/JZwFIqKFsQzT9kSgNCI/3+vs+ULULn/LiY
	 FFftbU16s0UDL/5opjDkFOjCHh5M5fU++ehdfaKOQW3eS1hKsDKX3i9Kicip/Wmvkj8CBighD3YS
	 9S47zs3B6hPuP0Ejs75qk2OZDGaUvC33cPXCsOe/G26+7E0iF015p7YrjBqkRpRgNRlVqWpoCfK4
	 oUP5jskVNV7TWq548l5BTLXgoM+6OjDcGGBRtZXVU44xVcYRwdF+6WeiCtOBC7dyTcjgKBzdS5Hm
	 YOeIaKXD+y8Sirffs2J+t22f/+G233hqPHLYP4jVxmtfVbysATl2fBImztossU8iEu6bShL67qAz
	 u7B2mn68Yd+kNbvYI6CYx1+sJYLzSa4UQgEdNbcvR68aWowTdRPkM5No2DH7R5XSzoz3yhbpo8Sp
	 ovt8ajdaMaNgdTveljtdJzFT2KAXnuiDyb4lcVje2NIwz1UymAMhM2S3HAzQelICSAbLw9aq4ipc
	 kNCSXbACqp4ua/S8zZibX0G+J3lIlg6W9+4eknBTbb6XUm9LmxJyfJbzI0KA5VcIdD44z/KJevYh
	 0T+XNqSfg=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
Date: Wed, 20 Dec 2023 20:51:53 +0800
X-OQ-MSGID: <20231220125152.3574150-2-eadavis@qq.com>
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
index 02cea2149504..236ba4221b07 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -102,11 +102,12 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
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
@@ -115,8 +116,11 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
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


