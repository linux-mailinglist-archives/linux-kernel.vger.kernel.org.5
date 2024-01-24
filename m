Return-Path: <linux-kernel+bounces-36497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D43B83A1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8071C22ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D52EF514;
	Wed, 24 Jan 2024 06:02:40 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06621F4F3;
	Wed, 24 Jan 2024 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076160; cv=none; b=OhhpfInbu7uBr06Xjia2mtTj1sBA7P6kBcfgngRrCPC6eLy3eU6abrFytb7ppcoI8Tj+C5PYfLi1iayTB1u46XijRCv2220Exf+/LzlueKHF5mdtlrvk4lWO3wCsdFr0vZu0eyseOkKskv6ynyngHNq4aLAUI6cSr8tTutFoSyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076160; c=relaxed/simple;
	bh=1cJ6y/s5yfErFY2lTdHgVlK39PG6xTSXM204E6Jaajc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KVPYJZfFSfETrj9/JyOCV2CFcEtvVY2DFXkkHvUwX5IBCrAQmF1DhP0PwjrEgwa7RAQZ7jlfhc77rr87QpxtK+T2FT0OOnD53oluAUk+hY/+dsf/MJLwAKwO0UtJa2Dk0viALNFOm4Yx1DVmgUWrjPVJEfeCW0klsbCi0WIy0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e59fd9dbe6164cc7b6c9fc7ee19fd901-20240124
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:3e2797d1-8673-409c-ab5f-fd77af66332d,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.35,REQID:3e2797d1-8673-409c-ab5f-fd77af66332d,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:5d391d7,CLOUDID:a088b17f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2401241402291UVM2KV1,BulkQuantity:0,Recheck:0,SF:19|44|66|38|24|17|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: e59fd9dbe6164cc7b6c9fc7ee19fd901-20240124
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 226046693; Wed, 24 Jan 2024 14:02:28 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id E0CDBE000EB9;
	Wed, 24 Jan 2024 14:02:27 +0800 (CST)
X-ns-mid: postfix-65B0A7F3-71094480
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 4243EE000EB9;
	Wed, 24 Jan 2024 14:02:25 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: paul@paul-moore.com,
	eparis@redhat.com
Cc: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] audit: Use KMEM_CACHE instead of kmem_cache_create
Date: Wed, 24 Jan 2024 14:02:24 +0800
Message-Id: <20240124060224.463335-1-chentao@kylinos.cn>
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
 kernel/audit.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9c8e5f732c4c..e7a62ebbf4d1 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1693,9 +1693,7 @@ static int __init audit_init(void)
 	if (audit_initialized =3D=3D AUDIT_DISABLED)
 		return 0;
=20
-	audit_buffer_cache =3D kmem_cache_create("audit_buffer",
-					       sizeof(struct audit_buffer),
-					       0, SLAB_PANIC, NULL);
+	audit_buffer_cache =3D KMEM_CACHE(audit_buffer, SLAB_PANIC);
=20
 	skb_queue_head_init(&audit_queue);
 	skb_queue_head_init(&audit_retry_queue);
--=20
2.39.2


