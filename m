Return-Path: <linux-kernel+bounces-6733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C97FB819CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59352B2777A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1592033A;
	Wed, 20 Dec 2023 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CvUR6RMk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF120326
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703067565; bh=vejMJ34VuUxZn/hzoCTBR1krH0wZSl7IMNxr8nBx0Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CvUR6RMkYzeQdwsH2/JF7A9j5yFQsXutBzbieCOwZdq6ipCvykcuApjzHeF0VNKeI
	 A+vKX358ielUKK2m7z6dxT5Qf8jUYSuygtxhfBKnIrVLaJpaObBf1/EA5TzjvQU4tB
	 MeGW6LP2SaOi2gDbQ6J+GaLiSt1XO9YtmYhQb4Wg=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 4D812CAF; Wed, 20 Dec 2023 18:19:24 +0800
X-QQ-mid: xmsmtpt1703067564t5bjjcij0
Message-ID: <tencent_35D11227DD835DA5994ACF968DCFA58B8D07@qq.com>
X-QQ-XMAILINFO: OGZxhFXqN7PJO9fwN0NmcXErCBOVpoUBL5+k8JU9XvylHb670BuVDQoOyddg/9
	 H2sHRDI2yANg9pkhW4E5GTzxKQRR04YkNuXiplT0emnVU1i8YBxCzGQxkMRAeOXQXAgBlIj6AMnV
	 EEPD3Ae9onnIVJTW3jjc/TiwmfMpQ9QjfCa5G/a/ys7FbGMeV3YdjPbS7UMzWrsZNxjYfb6BNpgP
	 ICJ8YWhOwp9huQv04Z2D/pg6zCUMPDxn2cf5eCI8xdWUsbxlT3/8qdcZPhiUNwTb1G8nH4f5M4r2
	 3B61Qb1VcAl5beRkRFD5wVzQNesePh9sBz4KQDWTPLhIHiIk/m/d5PCEccIp7ikrCNIvV2BtNbxu
	 xSAuwhat6y3ai3lKF7jpQ+TJiH1h91SiNVkzjFz/9sIkmkrrdKkgDgVMCMttZ7KuF1LPf4M8EYwe
	 Nxpn1fVoxnkqeVurc+ktyY0RhhElDt6CCJ+WXrlks1xR/ag82bxVP1wCK/cuSwr2DjdFiAB04UH4
	 Jcg9weMsJXmoziM++rDsj8KaPrRTsF49uVYJk+nUwvfu3uysa9uIlbe8XIefs8D695era6iNhKk3
	 llC48a57H1b+v5GndUNCFyUX8/5rvGSgk46pWqdcUFKLkq44XGMi3cY1602dsN0y9tEHP8TT5gMi
	 W0m6PFpeZ/9QrstLM/rfru/BOTOD4oELs0rlXpOjQOC87FnDuf1sWjSkHpcmjZ/zlNmxt8w4TGtf
	 pXOm+r5jUwFhyK24Z9MNk8zh7GS/a6GtmZpyjKpZCZXNt9Ak71wYtGKuRBJ/krHFVaTEccJzZRKB
	 9f4D734nLuKOqQCZj5ES4vi/Z3ZU+05D+4QpImgdku/0H6BOkhGzA1EaWfz6elQabHtXpbcXsI/7
	 0jm+0q09Lr2UswGXES1Y1UzUWIp1W37CN7G/xPA6Xvj7tQmZCk5aYWredHg2jp/B3GDK5fHwuh2u
	 5vHewZVAA=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
Date: Wed, 20 Dec 2023 18:19:24 +0800
X-OQ-MSGID: <20231220101923.3378458-2-eadavis@qq.com>
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

diff --git a/crypto/lskcipher.c b/crypto/lskcipher.c
index a06008e112f3..f7727698b797 100644
--- a/crypto/lskcipher.c
+++ b/crypto/lskcipher.c
@@ -205,11 +205,19 @@ static int crypto_lskcipher_crypt_sg(struct skcipher_request *req,
 	struct crypto_lskcipher **ctx = crypto_skcipher_ctx(skcipher);
 	u8 *ivs = skcipher_request_ctx(req);
 	struct crypto_lskcipher *tfm = *ctx;
+	struct lskcipher_alg *alg = crypto_lskcipher_alg(tfm);
 	struct skcipher_walk walk;
 	unsigned ivsize;
 	u32 flags;
 	int err;
+	static u8 relen;
 
+	if (!relen) {
+		printk("req: %p, alg: %p, ss: %u, %s\n", req, alg, alg->co.statesize, __func__);
+		*req->__ctx = kzalloc(alg->co.statesize, GFP_KERNEL);
+		req->areqlen += alg->co.statesize;
+		relen = 1;
+	}
 	ivsize = crypto_lskcipher_ivsize(tfm);
 	ivs = PTR_ALIGN(ivs, crypto_skcipher_alignmask(skcipher) + 1);
 


