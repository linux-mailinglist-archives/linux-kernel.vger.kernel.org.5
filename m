Return-Path: <linux-kernel+bounces-52126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0A1849466
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2A01F2512C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3877C10A2A;
	Mon,  5 Feb 2024 07:20:46 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324A12E63;
	Mon,  5 Feb 2024 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117645; cv=none; b=OTzT0p2NPRKU6nLJTTcxYgoe++ROJyKla5xAcZydgQPBLy0iGy4QTK9lBsqtOt0CxGsB+OZx2w05mKLccXS2IHqNE8+o2QXdGkiiWhj3G0xk5GRy/MEFuNVpFCU5zsov77C3QebmfDSo550tXWdGxLAJFpcGpU4YWqtf/4U8vI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117645; c=relaxed/simple;
	bh=YN1aQFZ5Zc8+LiztBiUiibV+CuZKGEL0EVvyyuJVySg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ok9LPLpEq8bSRVR2+cPg55goWnC4uHr0mIo6u6Ksl8WCll5z1u3dxo0BgkFkOTkqA9DyUdJTNUUFsdlPsUwhRxXnPC9YjWu6TbSUZJp//4Q/bdShaAIKBZcR95JVJKjj6YVSVnRqwQWu8RrGcOn27xTq5n+sSL6m59+tPB0xocI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: eb5a048872ba4ac0ada8276a0bb8a711-20240205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:5f8fd22c-67ce-4c69-84ab-7d6c2786cf4f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:5f8fd22c-67ce-4c69-84ab-7d6c2786cf4f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:4bd12080-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240205152038WUMG2LHW,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: eb5a048872ba4ac0ada8276a0bb8a711-20240205
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1267139241; Mon, 05 Feb 2024 15:20:36 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 942C9E000EBC;
	Mon,  5 Feb 2024 15:20:36 +0800 (CST)
X-ns-mid: postfix-65C08C44-40680673
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 9C61EE000EBC;
	Mon,  5 Feb 2024 15:20:33 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH net-next 1/6] net: kcm: Simplify the allocation of slab caches
Date: Mon,  5 Feb 2024 15:20:08 +0800
Message-Id: <20240205072013.427639-2-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205072013.427639-1-chentao@kylinos.cn>
References: <20240205072013.427639-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.
And change cache name from 'kcm_mux_cache' to 'kcm_mux',
'kcm_psock_cache' to 'kcm_psock'.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/kcm/kcmsock.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 1184d40167b8..bdc3e58a9b2b 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1877,15 +1877,11 @@ static int __init kcm_init(void)
 {
 	int err =3D -ENOMEM;
=20
-	kcm_muxp =3D kmem_cache_create("kcm_mux_cache",
-				     sizeof(struct kcm_mux), 0,
-				     SLAB_HWCACHE_ALIGN, NULL);
+	kcm_muxp =3D KMEM_CACHE(kcm_mux, SLAB_HWCACHE_ALIGN);
 	if (!kcm_muxp)
 		goto fail;
=20
-	kcm_psockp =3D kmem_cache_create("kcm_psock_cache",
-				       sizeof(struct kcm_psock), 0,
-					SLAB_HWCACHE_ALIGN, NULL);
+	kcm_psockp =3D KMEM_CACHE(kcm_psock, SLAB_HWCACHE_ALIGN);
 	if (!kcm_psockp)
 		goto fail;
=20
--=20
2.39.2


