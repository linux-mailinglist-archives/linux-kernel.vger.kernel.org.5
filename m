Return-Path: <linux-kernel+bounces-6413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE842819886
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D5AB21AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3019168CF;
	Wed, 20 Dec 2023 06:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="g5R1Ktn5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E36F168B3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703052473; bh=ToRhOowO0/JDKgCTFzZK2Z9TBYAFcGyfcjyGo7j8Fr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g5R1Ktn5LxusQsAuYKFPwQBoNZ/lgedeylgp4pR86Lkl4GPHkhe1V6yLsip4tFUdF
	 sdAUupsXkMMwy77G//eIpi/7akVzYvny15EedYBzrDjXbS7hQKc9EEsjG3Q3tNRiEz
	 YzhKwkeWsV+ddQCM4F42KGh1NzMjILe0cRTUQs4o=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 1F3388D4; Wed, 20 Dec 2023 14:07:51 +0800
X-QQ-mid: xmsmtpt1703052471tzeueq582
Message-ID: <tencent_D1BC2F696F3495C4E80AEC1ECD7C79366C0A@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70Or1JZvPbk/cptFX3F9JvPu/obwVG/rpPN5jRYCUAmlDTPbjDmL
	 rCV+0wkbEWCuz+Qh0Sydqikpj4erQ3irkmceAC8RVix9B3pfCuRCeArIr6OI+67JQM0Gub0NG72A
	 XhHQF0vBk/VN+/8RYXTTpg70Y9E/BV/WoSQ3Q87HlrJB7+QhwqcoVIIHuyptkpHBvWUZF1HQCTkL
	 6o6B0TRCFYRoMzpaUEi6tMkDtzIh9beEhB8UyYBp2K+qaxAoDYn2WOyepixJVFq25mA7IPJ7DSO2
	 rbm+H/7s2wFJFa6J1Oe/CMybl8SmzvHeyFl3dm62wXoIikxSamAXdpJcUpQraBoSvcPEI1VQTGwp
	 kjFPjyZ3IQVRfzDS25QntxFZn8n4XoV9N5bWbCRO5qu4i9FOnyoSbjaFhh4GD698Ry50I7RCRrVZ
	 cvUfS997t8L7kWKLt2aXgky15XLFlILX0WVqvDQQdGT+ciPyo8zFnQTfdnfBDFXTFMEjxFP3BUjQ
	 PzVoiAUUPu37B3slXv8/HUqM+Tf8iDkhsGpUmAcNMY6vwtmjz9kCbI2+z+ifoBLq6PoC0lYRvhl8
	 5+Hb+EzPqU7zrJDY8f/QTpNVE6xbt0YNXbDaOvdd/feByhlI4bcFiGAVI+liYb7kzav8PKrzretP
	 0IcgrbmwSRKR1ajH6xJAhnxhYMQXd6cudtD3fnFekPpzvbhHJBuJSCPwogC77InNMoNeRwluQeAO
	 QxOwZWHphEIUUCoogAkn9gS01B6kV07iH42CGkG5YKmjoiiZbU7Mssod9rB/N1zpbnk7gw286kni
	 zGj1hy6iEd4IRSo3hxd0X6kCYfvXZW3zfgbSCucBJCz9zqf5VxwDt8TFuazfw+z5OQ/c2zFT4dSa
	 DaU0d6Xdlx+tAt1aJEEj1wHiNIe2IDdSmQNUMmqWGa5Yz4ERea5aX6IiPK6iKez8NbwPD8ZbCv
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
Date: Wed, 20 Dec 2023 14:07:52 +0800
X-OQ-MSGID: <20231220060751.3064882-2-eadavis@qq.com>
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
+		areq->cra_u.skcipher_req->__ctx = kzalloc(1032, GFP_KERNEL);
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


