Return-Path: <linux-kernel+bounces-6335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A215819760
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9E41C227BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5B2C153;
	Wed, 20 Dec 2023 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="D/Ts+foZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E1515495
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703044188; bh=coIR2leWfE09/iQXeKW2K56cU0j7xxFQcu8yUQEoVCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D/Ts+foZUCgO/bSZsgaTpAdWHsfEjGCK+BYZJ9wBj54xyKwCfYseKb6iHcmykJBxk
	 mZdnJImg24vfcxnqNw8ApSMyTzXaoQ2mpgNMOba1GGGeNKNFA86HHubG/dadOAEYK0
	 o2RRpw/0+OoyFTR1h1ZYZO9ZwQ62hOx9LGNvKZBU=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id C6E908D8; Wed, 20 Dec 2023 11:49:46 +0800
X-QQ-mid: xmsmtpt1703044186t048y8bka
Message-ID: <tencent_501F4BE81B712525BA1ABB71333D9E001B08@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6pb6ZN/T6VISo+8sqCpjz2tCaSuPsNTgtvXjy3g0NFztgkUpoT5
	 okiqS1YvfvGMn/42Q7IC3F+wvVPSGiYvA74UkqjJ/oPS7wNO8fFETJFLI6wO1r6cWibys2pFCRim
	 r4WOxTrMjUMCj5amFd5+FkQ9MrggN88wfKrW4Hd246MWl5VWzuK9TSNlEYN9TDFwLcoPni/pAsWk
	 9pyhvgoSlWkBmvjKj210bE42HO5UFyYM4cScXkwUmh5mJ8FVe9a5KN2nnBZRxmMu16ffA2A3NfSm
	 9BIoNF8dUEuqBEQj1dE43R8pkgXdjmPo7zAl/0mdGPnydPXupE+mss0UzVSAyzl5jjB7CiGY6Bt5
	 5x7M0KlnNegx8ydEBpyeL5/4mVbtqrVIgE6fipN6cXFumOFMaPrsuXylycek8ioJAkrwSTrOjTCl
	 FAuFayQGXn+cW0C0AvMof12i+BDiuVRSPyDX6Jv+2hodZdsTTAwXiQeKU8/ioE2pxe6gBOVh/eEC
	 55DdY6EcrnsRq4iRBkRJMB3obeaXADal6why5Q566KSiAQIWjrIR6vTiGFI6Oks4cZJi/L9T7BwA
	 uHxkQMv1Qa99FDYJia4yPfS+46GZUhXot7FcEui7wlX+GR0bcxWkOR6uHBC+gdxfRuKrjN5MtYU5
	 /kofbSTfQ2a0iYOavyZV/z0o2KoV+gry9bvPc8aIaaAPpcMLDSr5d5oXg+6LJ1ZHOikIKiYk6bEo
	 ZrvKcgDDHnnvzKEY5QgQjZOriFPWXYToaDHMvJmOSK//yqx+PBCklWBXeSoQpOGYPRUgsTbG9i7e
	 cjEVnH4qpR+qmp43oQ5M+HqDrdGkZMy3sVR3YB6gxpadwGYoHVxLrwLsCWMpqvHucevoNY/8apdU
	 zpZAutJ55IXMrtK5TFELeR87MerVUJsG70ciWTpcysVMZVafGLfl4p8fVpQbBR3Q==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
Date: Wed, 20 Dec 2023 11:49:47 +0800
X-OQ-MSGID: <20231220034946.2840444-2-eadavis@qq.com>
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
index 02cea2149504..299547b0e200 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -120,6 +120,7 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	if (IS_ERR(areq))
 		return PTR_ERR(areq);
 
+	printk("req: %p, %s\n", &areq->cra_u.skcipher_req, __func__);
 	/* convert iovecs of output buffers into RX SGL */
 	err = af_alg_get_rsgl(sk, msg, flags, areq, ctx->used, &len);
 	if (err)
diff --git a/crypto/arc4.c b/crypto/arc4.c
index 1a4825c97c5a..79621f4f4c68 100644
--- a/crypto/arc4.c
+++ b/crypto/arc4.c
@@ -29,6 +29,7 @@ static int crypto_arc4_crypt(struct crypto_lskcipher *tfm, const u8 *src,
 {
 	struct arc4_ctx *ctx = crypto_lskcipher_ctx(tfm);
 
+	printk("%p, flags: %u, ctx: %p, %s\n", siv, flags, ctx, __func__);
 	if (!(flags & CRYPTO_LSKCIPHER_FLAG_CONT))
 		memcpy(siv, ctx, sizeof(*ctx));
 
diff --git a/crypto/lskcipher.c b/crypto/lskcipher.c
index a06008e112f3..0a429ffc086f 100644
--- a/crypto/lskcipher.c
+++ b/crypto/lskcipher.c
@@ -215,6 +215,10 @@ static int crypto_lskcipher_crypt_sg(struct skcipher_request *req,
 
 	flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP;
 
+	printk("r: %p, ivs: %p, v: %d, s: %u, ri: %p, wi: %p, f: %u, wnb: %u, %s\n", 
+		req, ivs, IS_ERR_OR_NULL(ivs), ivsize, req->iv, walk.iv, 
+		req->base.flags, walk.nbytes, __func__);
+
 	if (req->base.flags & CRYPTO_SKCIPHER_REQ_CONT)
 		flags |= CRYPTO_LSKCIPHER_FLAG_CONT;
 	else
@@ -224,6 +228,9 @@ static int crypto_lskcipher_crypt_sg(struct skcipher_request *req,
 		flags |= CRYPTO_LSKCIPHER_FLAG_FINAL;
 
 	err = skcipher_walk_virt(&walk, req, false);
+	printk("ivs: %p, v: %d, s: %u, ri: %p, wi: %p, f: %u, wnb: %u, %s\n", 
+		ivs, IS_ERR_OR_NULL(ivs), ivsize, req->iv, walk.iv, 
+		req->base.flags, walk.nbytes, __func__);
 
 	while (walk.nbytes) {
 		err = crypt(tfm, walk.src.virt.addr, walk.dst.virt.addr,
diff --git a/crypto/skcipher.c b/crypto/skcipher.c
index bc70e159d27d..08409990b58a 100644
--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -716,6 +716,8 @@ static int crypto_lskcipher_import(struct skcipher_request *req, const void *in)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	u8 *ivs = skcipher_request_ctx(req);
 
+	printk("%p, csa: %u, csi: %u, tfm: %p, in: %p, %s\n", 
+		ivs, crypto_skcipher_alignmask(tfm), crypto_skcipher_ivsize(tfm), tfm, in, __func__);
 	ivs = PTR_ALIGN(ivs, crypto_skcipher_alignmask(tfm) + 1);
 
 	memcpy(ivs + crypto_skcipher_ivsize(tfm), in,


