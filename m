Return-Path: <linux-kernel+bounces-44283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833CD841FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0B51F2859E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7F60869;
	Tue, 30 Jan 2024 09:40:56 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF1756448
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607656; cv=none; b=jMMBP6kaw+bmQwrx4VgJDybvS/0eOI6z/u/a3EzJmwCWWBGZwnzH4TV/qe2q7opOUV0SKPw8U0r0GBYVQ5ODVc30bpMO6rolybxBRT+Nb/6liaA9Hr/hXZBK4vXbcc6+CbFojYvk5CLx9tOwNS4/YNcH8ROdvUPgg6mgPxWgbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607656; c=relaxed/simple;
	bh=ufH/YfkovaUPjRe2Wr0p28Xr1kor2t9YuM7pYvf8SEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VxkCWo5pYJMG7MVchYiFIAAHqMAixhsR/XPa30N266DxCwKEjTVK2e3wUi//yfm2ZzDlg/uEym8pPCuzgo3xXBfaIvmfCqvQovAUKDOX3gkryO5XIVdXHxbzB5xheKLmQAnqRBr7Bc/BmUZ5dLTElZbWz0FH9C0vUg8xyUb0w/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d9510a6461524e2b8a80b966313b8d64-20240130
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:91328706-21cf-49b7-9778-703d31fd7df0,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.35,REQID:91328706-21cf-49b7-9778-703d31fd7df0,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:5d391d7,CLOUDID:551e6a83-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:2401301740489IUEEHSU,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: d9510a6461524e2b8a80b966313b8d64-20240130
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1433395071; Tue, 30 Jan 2024 17:40:46 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 522A9E000EB9;
	Tue, 30 Jan 2024 17:40:46 +0800 (CST)
X-ns-mid: postfix-65B8C41E-1119281145
Received: from kernel.. (unknown [172.20.15.213])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3DBF6E000EB9;
	Tue, 30 Jan 2024 17:40:44 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: axboe@kernel.dk,
	paul@paul-moore.com,
	elena.reshetova@intel.com
Cc: linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] cred: Use KMEM_CACHE instead of kmem_cache_create
Date: Tue, 30 Jan 2024 17:40:37 +0800
Message-Id: <20240130094037.76895-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
introduces a new macro.
Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/cred.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index c033a201c808..02a96e9d9cfd 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -606,8 +606,8 @@ int set_cred_ucounts(struct cred *new)
 void __init cred_init(void)
 {
 	/* allocate a slab in which we can store credentials */
-	cred_jar =3D kmem_cache_create("cred_jar", sizeof(struct cred), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
+	cred_jar =3D KMEM_CACHE(cred,
+				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 }
=20
 /**
--=20
2.39.2


