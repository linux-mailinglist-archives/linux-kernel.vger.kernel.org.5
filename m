Return-Path: <linux-kernel+bounces-6447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 400198198EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A041F21CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80107168C8;
	Wed, 20 Dec 2023 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iaWITDdT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB9168A5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703055750; bh=WgCFWsOj6en7CHxFZDFHPtV3XhIHZfQRhUtHtNY/prM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iaWITDdT1n6LWPg230OBU8q1b5UwTuSKTinISmXX11mLdD+6eI9gWYm1UCpkQp6eP
	 H7l2YBWO+aZLrWDpua4kK4DoiPVYNBKUUz18a0YfdEMp58BhaJ4Zum0hyfkaE+NXXm
	 yyAMdq1kQAE+YWh1iQ9awcya/k3YBLMFtGhzWyRw=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id E16B089E; Wed, 20 Dec 2023 14:56:22 +0800
X-QQ-mid: xmsmtpt1703055382tubi269fn
Message-ID: <tencent_ED8C99A7EB86C012DA86504993EEC1EECA06@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCt29ZWfJ7yurDSXnAuaIsiKCyVimQDjWCVBw81xtFEIYAduBDnWX
	 AFG/52Gx1cjNdQ9owvtv60GPMvDI246ChnaN9XmneKazou/esAHi70z2ikxNfhSCpCpvZd8Xy+JF
	 4FiIjVNuSiyH2O1zn+pENu3/K++qVXFfX+IK+46ufC8tiKc8cfeKsPqhwGXCd2KCddw1ThYco1Aq
	 h9AoEXXGgNFnZkTfHP1xtn6Lsb4A9CUg55ge7x4+d5sYgsbIKf6gU0KnLOeUkhNBrBFk4wV6PXPa
	 GBadL5qh88ocduuOzNRd/xFFHm/pxGIckhTNeQOP43cL39a26IgpYHkAnmBmBc8lDFOXRaqaMnMK
	 qgdMKhG45u+RDgcBgwFfO4C4OaVeZfmbkbsz1RjDyZxEUdbgcsenL6HBc4clyk1gzawHBqfFai/x
	 erP4kSDBQKNTeIxziUfGCPKtCbP8oEAc6OesmCmbqP/BzdOh1dPfIZx/okY06hFATPoeUsMEttbg
	 Lp7CLHQJM53aWuBgtMlcCcVDrizQDtlgIK/Ht/j8xzAaX+Kp07Vo7Rr0ykS4jtScCTL/ljUinRaY
	 9EbqdPaEpI5LWJ3WY5aT/MBJYagZMxKPlFV4ifukgZL9D02krCrNBuxcztpEfnnIexeJG+7zLFbG
	 +RykeTQNPzAfnicKBKZgWVyLY9zrE63bjIusZ3n0WcKMhUDLUvbhw31hctf0rgGLSO4cxPfxQWKO
	 YsIdnUxoiOZAp++zsTkG0LDgYCkh8li5c1pt6GBGhlatBvr/DXkj+6cF8gM9mgJxLxWQii0AvRmb
	 mRZLzSRqHOdYewiJvgl569d8ImoXprfcc/WdhOEBNipiTgRTI9WdnaVfQh7wg0UeRD0o6K1zZf66
	 GWj2v8wez7yLXkFOXNDnULrsLZou8aI4+LJCbSD/hM/zusknu87cq7t3Z5K8wonOTzLebzcF0WOl
	 KIOwSXteHjnlelpwIqyvOmlJ5bKcd3+qHgU8pafP4hBcXwerp6iMBgWn0bL2lG
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
Date: Wed, 20 Dec 2023 14:56:23 +0800
X-OQ-MSGID: <20231220065622.3139548-2-eadavis@qq.com>
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
index 02cea2149504..e1f44dc60e4a 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -106,7 +106,7 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct af_alg_async_req *areq;
 	unsigned cflags = 0;
 	int err = 0;
-	size_t len = 0;
+	size_t len = 0, aqlen;
 
 	if (!ctx->init || (ctx->more && ctx->used < bs)) {
 		err = af_alg_wait_for_data(sk, flags, bs);
@@ -115,11 +115,13 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	/* Allocate cipher request for current operation. */
-	areq = af_alg_alloc_areq(sk, sizeof(struct af_alg_async_req) +
-				     crypto_skcipher_reqsize(tfm));
+	aqlen = sizeof(struct af_alg_async_req) + crypto_skcipher_reqsize(tfm);
+	areq = af_alg_alloc_areq(sk, aqlen + 1032);
 	if (IS_ERR(areq))
 		return PTR_ERR(areq);
 
+	printk("req: %p, areqlen: %u, al: %u, %s\n", 
+		&areq->cra_u.skcipher_req, areq->areqlen, aqlen, __func__);
 	/* convert iovecs of output buffers into RX SGL */
 	err = af_alg_get_rsgl(sk, msg, flags, areq, ctx->used, &len);
 	if (err)


