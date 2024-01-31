Return-Path: <linux-kernel+bounces-46107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE64843A70
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F412946F2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D756E2C1;
	Wed, 31 Jan 2024 09:09:04 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E672B9AC;
	Wed, 31 Jan 2024 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692143; cv=none; b=dOqlH3Vc4GnQXnxwFQd7cFERbfOJr5Cc9Uu4Edth3ysuEIbWIeL3aKN/pxVMttrGUCOCO5zt/pCSy6dHdBmGUWbbKoen4mbGdf0+DIhoJ0i/IEUSEsFrEAtUXC/FwfaUwgW3IO23PLeFaVxwNZO+JlBM8xoHKGplu80uKZOn1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692143; c=relaxed/simple;
	bh=ujwMiO00xHpCheR9JNmSZrbICGjRt5Prk8QBLRfTBqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=udlnHOAuPcl4cJrX3sozYu85f+sRHq0bxT+d5M/dkD4QOVsm4DRMHiTBGqUiFgq1qoIruWB1dolA7KTITrP7DPJVeMePQkNzyM6jgRD4Ya9IiI+te+BEyr2uX0+twyOF7FZ7l6bgHk2XDwp8RtRplK1Ztlz128Oqh9fHiJlo8rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2af88985a625436e8365e53352332a4e-20240131
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:599b2e0d-088f-4f13-b4ac-3fb1808a31a8,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:599b2e0d-088f-4f13-b4ac-3fb1808a31a8,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:963df57f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240131170855MHIAF13P,BulkQuantity:0,Recheck:0,SF:24|17|19|44|66|38|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 2af88985a625436e8365e53352332a4e-20240131
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 326931249; Wed, 31 Jan 2024 17:08:55 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 79BFDE000EB9;
	Wed, 31 Jan 2024 17:08:53 +0800 (CST)
X-ns-mid: postfix-65BA0E25-202812822
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id A2CBEE000EB9;
	Wed, 31 Jan 2024 17:08:52 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: dccp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH net-next] net: dccp: Simplify the allocation of slab caches in dccp_ackvec_init
Date: Wed, 31 Jan 2024 17:08:51 +0800
Message-Id: <20240131090851.144229-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/dccp/ackvec.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/dccp/ackvec.c b/net/dccp/ackvec.c
index c4bbac99740d..1cba001bb4c8 100644
--- a/net/dccp/ackvec.c
+++ b/net/dccp/ackvec.c
@@ -376,15 +376,11 @@ EXPORT_SYMBOL_GPL(dccp_ackvec_parsed_cleanup);
=20
 int __init dccp_ackvec_init(void)
 {
-	dccp_ackvec_slab =3D kmem_cache_create("dccp_ackvec",
-					     sizeof(struct dccp_ackvec), 0,
-					     SLAB_HWCACHE_ALIGN, NULL);
+	dccp_ackvec_slab =3D KMEM_CACHE(dccp_ackvec, SLAB_HWCACHE_ALIGN);
 	if (dccp_ackvec_slab =3D=3D NULL)
 		goto out_err;
=20
-	dccp_ackvec_record_slab =3D kmem_cache_create("dccp_ackvec_record",
-					     sizeof(struct dccp_ackvec_record),
-					     0, SLAB_HWCACHE_ALIGN, NULL);
+	dccp_ackvec_record_slab =3D KMEM_CACHE(dccp_ackvec_record, SLAB_HWCACHE=
_ALIGN);
 	if (dccp_ackvec_record_slab =3D=3D NULL)
 		goto out_destroy_slab;
=20
--=20
2.39.2


