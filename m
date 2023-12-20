Return-Path: <linux-kernel+bounces-6426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 518188198A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8B01F25B87
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566681C29E;
	Wed, 20 Dec 2023 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iIh1yF7r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9081BDC0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703054096; bh=UhwCBZOEYbNUSZePeQQtZqhLG0RKT1Pd+HhasPn5ONY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iIh1yF7r+w/REMyXqis/mEVAht/c9ZnW7aF8JicWscKX7nUmzij8OvN84MhJ3bqtT
	 JMoim9wTJzSZkvrDhNxZi7qtGAWbDWnVS3Xlg0LbOpC5xq5mxIZ5tHFfDnamCULKII
	 1A/6lcaYuFXABlR1sN1IcvZxjUI3aHrolEUpFv9A=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 8B639E67; Wed, 20 Dec 2023 14:34:54 +0800
X-QQ-mid: xmsmtpt1703054094t9r8a3bsp
Message-ID: <tencent_2D9956CFC10D9425B98DCE12085DBEDDB607@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNoZ241g0V/0SCVaRZeJj5SXQgLf0rzgrhmew2O3xQ4zn2bQOFqSa
	 Vht9k3F8M4nVpNYMvqDCe9wYZfU2bF3XVP/Cs/haVGg2PFJnh+iXj2NywddApWuZXWSguN2SQ0lC
	 FmFlENTXOoPIYb7mKjv78HLGNwKQEBOj/OzpiuF6M/MvFs5aUXpQOODucPoQfhPqcq/wZFivMuSQ
	 FuTOO/mkQYS1w874adVg6jsQ3L0TbNxr9/lnJkx1uKxFvdkoOAfrXsRajtJfRyCqi0m1YntSoBKN
	 IO758Z6WVt76oDvvnQC8QpKAMLK2BwjXVuxjy8cAb66L8w7m5oXh8+zpqkIAZUaW3j0hoRYix1fk
	 AD+0P9dpRGYgNbKLG6DzpnDUB6B8fNysiyMRcxbx+8EShfuGV6VXB1NYwOxKXfULlVLZbgJP+nkp
	 kkr0aXtDfzNDgqcHXdbFpIaLDTuOAsOnWp1D6pYLaDUtM8AYGUPPwopKO7bKqx4w4+zcxkqcOnqT
	 SrMuL40UYgPNpuNMfqxpGDnWsQwT8QPNiX0XHhO/iI3cPG6hNrZJNX3badJ2EUZkp/S6tVb8gNrk
	 N52Vdw45fkmoiq2Go2jrcjmoc1sL8UX/VxaTIHnNCb3zhoLvZrXc2466fF8sl56Vjw3szrPn65Pv
	 e7RzDkCZai1/LWWjVvUVaLqYB0v8mLfCStFw2wojwPiuOTZFmPfnFGs9vYdrns7W9QZB0zylaISV
	 BQfrCzGvvWj4bmzgoiq1yTsrwwvs5wYX8CD4ztsqdQmYZyXHV+u9pIGMSBDUiA0I0/f1KgrCs2UE
	 U2ADhV3WopDokoI/LPQ4blg5IH9HIQ8EmoYubWUrM01gXODvXLYJRt22vyMgjXA7NpGDfuxMDHOp
	 //dRto6owvgL7cbYtO3bwnioilgqEScs/Rc3MBhMi7RPoy+O67UDJbeKuYDOK/zjPGcMjLqGOpOS
	 J1icy1PAbhTNxlT8lTV86+cuOBqimootIrQlz4tCGhgKDrjpFDpg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
Date: Wed, 20 Dec 2023 14:34:55 +0800
X-OQ-MSGID: <20231220063454.3106945-2-eadavis@qq.com>
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
index 02cea2149504..1c50f6e3f334 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -120,6 +120,10 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	if (IS_ERR(areq))
 		return PTR_ERR(areq);
 
+	printk("req: %p, areqlen: %u, %s\n", 
+		&areq->cra_u.skcipher_req, areq->areqlen, __func__);
+	if (areq->areqlen < 1032)
+		areq->cra_u.skcipher_req.__ctx = kzalloc(1032, GFP_KERNEL);
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
index a06008e112f3..4dda11ce6536 100644
--- a/crypto/lskcipher.c
+++ b/crypto/lskcipher.c
@@ -215,6 +215,10 @@ static int crypto_lskcipher_crypt_sg(struct skcipher_request *req,
 
 	flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP;
 
+	printk("r: %p, ivs: %p, v: %d, s: %u, ri: %p, wi: %p, f: %u, wnb: %u, am: %u, %s\n", 
+		req, ivs, IS_ERR_OR_NULL(ivs), ivsize, req->iv, walk.iv, 
+		req->base.flags, walk.nbytes, crypto_skcipher_alignmask(skcipher), __func__);
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


