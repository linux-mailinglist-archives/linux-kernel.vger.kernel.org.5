Return-Path: <linux-kernel+bounces-38365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C5983BE5A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208E71F21462
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9A01CA8E;
	Thu, 25 Jan 2024 10:09:06 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA78D1CA81
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177346; cv=none; b=msYoeVtUA8/1Ig/u4YXudKJeRYTx8ZccdCKrurgGbrVqfGMXjWgbp1o6+I5lUu37FUbvvKEYCW83s5XE3Swjm9E7VIiGM+90ECoe7NrkZ519FFHBjpmD+3D2k6CS+2to0bgQpwbpgYcAzlQOu+aLaWOCPukkDDx87OTq3i0VG28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177346; c=relaxed/simple;
	bh=feE/pzcwYiMwFlr7r+nVcgXXXtyr7CaTHIey22W0H9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=haCON8sA8J3fTe+X+xbhGGjUV2f4+ql2QsFhs8omJHG72NzVIywnpbYUXV13QZrCmRp/1GDoQj5QPMok1Za4XM5eH/KdYkulNxoqeyQE7alZoJZHMgXcM4ad/biXLx434SfHdytds+pgu0Qd9Atgnd7JgWpaV0B3OFKYFMCwFjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7c0b766ba512435ab66b311e2776c7df-20240125
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:1d8bd605-f9b2-47c7-a380-ef21dc22fcbf,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:1d8bd605-f9b2-47c7-a380-ef21dc22fcbf,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:525bbf7f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240125180858YZSW2I97,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 7c0b766ba512435ab66b311e2776c7df-20240125
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 976720039; Thu, 25 Jan 2024 18:08:57 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 5F189E000EB9;
	Thu, 25 Jan 2024 18:08:57 +0800 (CST)
X-ns-mid: postfix-65B23339-177941856
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 4668DE000EB9;
	Thu, 25 Jan 2024 18:08:56 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: jk@ozlabs.org,
	arnd@arndb.de,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] powerpc/cell: Code cleanup for spufs_mfc_flush
Date: Thu, 25 Jan 2024 18:08:54 +0800
Message-Id: <20240125100854.540964-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This part was commented from commit a33a7d7309d7
("[PATCH] spufs: implement mfc access for PPE-side DMA")
in about 18 years before.

If there are no plans to enable this part code in the future,
we can remove this dead code.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 arch/powerpc/platforms/cell/spufs/file.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/plat=
forms/cell/spufs/file.c
index 02a8158c469d..d5e1af483601 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1705,19 +1705,7 @@ static int spufs_mfc_flush(struct file *file, fl_o=
wner_t id)
 	ret =3D spu_acquire(ctx);
 	if (ret)
 		goto out;
-#if 0
-/* this currently hangs */
-	ret =3D spufs_wait(ctx->mfc_wq,
-			 ctx->ops->set_mfc_query(ctx, ctx->tagwait, 2));
-	if (ret)
-		goto out;
-	ret =3D spufs_wait(ctx->mfc_wq,
-			 ctx->ops->read_mfc_tagstatus(ctx) =3D=3D ctx->tagwait);
-	if (ret)
-		goto out;
-#else
 	ret =3D 0;
-#endif
 	spu_release(ctx);
 out:
 	return ret;
--=20
2.39.2


