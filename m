Return-Path: <linux-kernel+bounces-39531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FA583D264
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE3F1C245AF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FC64683;
	Fri, 26 Jan 2024 02:13:17 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5110F7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706235197; cv=none; b=JdYbwqzHLk/qWy/MjtoRjSXvuNpeK7RHMLVRt0oQ1BmjE5pmFeFzpuXNA/vPGUgzNqId4MhirHKV01Vxf5/zksXZ4deuAOpDznxhMW+C7hoC10+xpE55JCcm1pUbm/f9DhRQVfHOTSuu2KCt6YtP1d0t0b2lrtxdIjZjEBXc8Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706235197; c=relaxed/simple;
	bh=isGudYeufLVd46hzgO6qswlq10p7OKMdVIQxjIgq+Zg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i4kh3CjAYXO9mHhcV3ILym6dG1xojRdhF65jTk3lNBu7Spj3PqWlxLqnN7bhL441v9BfMw4z7QIRq4oX8ZJ65193heG3u7EZS1zefXBQ/cB9fu5RBx/yubsoRuhIZRAtZdVzg82MD7HTzUcf8teNDgvDRDuJ7bF4I71b8EhapLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e0a20f20402d4c17a485494f5c93a1bb-20240126
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:c94aca0a-e81e-4bd6-9cd9-7f4a57b094fb,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.35,REQID:c94aca0a-e81e-4bd6-9cd9-7f4a57b094fb,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:5d391d7,CLOUDID:10f9ab8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240126101308KTMUY66O,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: e0a20f20402d4c17a485494f5c93a1bb-20240126
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 455094102; Fri, 26 Jan 2024 10:13:06 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 129D0E000EB9;
	Fri, 26 Jan 2024 10:13:06 +0800 (CST)
X-ns-mid: postfix-65B31531-871453518
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id AB957E000EB9;
	Fri, 26 Jan 2024 10:12:59 +0800 (CST)
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
Subject: [PATCH v2] powerpc/cell: Code cleanup for spufs_mfc_flush
Date: Fri, 26 Jan 2024 10:12:58 +0800
Message-Id: <20240126021258.574916-1-chentao@kylinos.cn>
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
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
Changes in v2:
    - Remove unnecessary label 'out'
    - Add Suggested-by label in commit msg
---
 arch/powerpc/platforms/cell/spufs/file.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/plat=
forms/cell/spufs/file.c
index 02a8158c469d..7f4e0db8eb08 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1704,23 +1704,11 @@ static int spufs_mfc_flush(struct file *file, fl_=
owner_t id)
=20
 	ret =3D spu_acquire(ctx);
 	if (ret)
-		goto out;
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
-	ret =3D 0;
-#endif
+		return ret;
+
 	spu_release(ctx);
-out:
-	return ret;
+
+	return 0;
 }
=20
 static int spufs_mfc_fsync(struct file *file, loff_t start, loff_t end, =
int datasync)
--=20
2.39.2


