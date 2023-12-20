Return-Path: <linux-kernel+bounces-7180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E5381A2DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C19AB2137F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AB1405ED;
	Wed, 20 Dec 2023 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BVDatylC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBE63F8D1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703086830; bh=cnc7b//eseb1IF6/2PbbS8bC3b2L95WbGsMtfTAWWWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BVDatylCpXmnpYvQn7jLzW0fa5Nb/PBwWQ/Z3/D9CXw3BDyetR9Ag3Int1gtNeEHh
	 MjOSacoJNlu/rq3d2rcT47gJLXp5sqVcZ7vUc90GjeKiwiHg5/XGbW35RUNj6/xxEA
	 hcwqenMCAmZYZxNDf+dI7fFGUcnW3fZA616g2BzY=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 80C8941A; Wed, 20 Dec 2023 23:32:12 +0800
X-QQ-mid: xmsmtpt1703086332tsxhnhmf9
Message-ID: <tencent_4EF87A266D302E216D9094D8EA06EDBACD0A@qq.com>
X-QQ-XMAILINFO: NkBK3x0tNc75bbqK7HJJCVPrZzcphz63p27ohEsZOMz2ikKm7lGbgpcS7E66LT
	 Pl5+VXms818qApfd8bVBguE+HoSyWB/bEuJUapv1zcnNnjPlQJqi0fpYysFRpd8yP/SAO3lwI8fg
	 Flu0RY6dy/1Wlh2qHrqIDXkZMiiB1OS8CkvkBJ2I5Dy9jwa8GPjnGIfWW4EUcZFaVfJquR2nnYLw
	 wLLF+HaEc1308GcocjfvpPtiEU2aTu4jyeUxMoA7GoCBv8LFXMc337GVUBgJHC14zNdU9+8jSrAb
	 y5PIO+RnPQUcHZ717O+Ggvj57PW5ZZZw2SeDk69CYuQ4W11lKG67+9LH2tdH9hHtAY4tdJOt+VD3
	 9CyJv5PxrM1eXvcSmdozuKPizDMP+8MrQZNAIWRykAcEgstXWQ0GYhrByXdX+jdKxshzqjQ28jtW
	 8zdK1J0IMvycxPrqreG4nwke/PY3db7y/BPl8tGn/76V5+kuE6BEAIREf4wKy7tG58+jCBIlE8mI
	 Xiuawd/dhudvW346JXu8MZoEE3aJ0kUHJuXgV2YCr8DZJ8jET10VGyySOsAhSLhSEfdljNbhAj+8
	 3WAhRUCjhJigft35/N9L8zKHflUws9OsypQKWv40ETYr+tP8Oo2GxC5c53iVGokgA496OrVIro8I
	 W9jtGhmxnO6dmymfeHtB2cX4SHBF0A3+oifSG0Vtcsjbs0wrIb9ti1E3pDtTZeNMTarSjTt6pBK5
	 Viqfuq3fLo9H7TENDuP4o5h1wBsprXJxDcP5+8Jqw0XJcrJ5RV3qsRHAm+e05fTWhHRcEE62q0xy
	 /z/guGQIG3soYyiYa4o7qWFrV5dM3VgaRLMQQQs9oDDm7o40uRRtUceSe1eHtT6XiD7s0ffzi+CA
	 30FOSKNX2VVgZECpdju4YngcHtt7nV9skhsF93K+/OyfbAR7Jjx3luDxTRbVRSHdbWYuQv/ntR8g
	 zSaHRfs0iwRwL4fmM8d4msukeZYPSv/t3lCNspDhw=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
Date: Wed, 20 Dec 2023 23:32:13 +0800
X-OQ-MSGID: <20231220153212.3794503-2-eadavis@qq.com>
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


