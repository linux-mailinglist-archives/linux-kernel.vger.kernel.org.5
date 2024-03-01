Return-Path: <linux-kernel+bounces-88130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8342986DDB3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23451C2165E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D866A031;
	Fri,  1 Mar 2024 08:58:51 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632A6A034
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283531; cv=none; b=PSQ2X/tO+1UoEyKSuacDDFgkaflA2vES/LypX6NZALgMAUkQ9uYRCZG/noNr3mF2NG1WUJmUVSfi8HaOFByQvjQGUD7BvCLJM/u5Doc8Cyi5BI97vhrTAzw1OrISr1HsJcK97BGmKrt6JEcNIrheV2qYfS0l6ovMhBV8xUfMHTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283531; c=relaxed/simple;
	bh=OtSnKgTUNbArv5oNDRQme9b+jn40ryx23wK4YVQpvWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F9WF0glawJgKf9L206WAmiwGgbxjctYkH4YxSl08GvTWZH2J14M/3WXmI3F4FW/XM1t2TvpdE95Qb2UMv1oN6vBCdWxb4uLJNhmiCkYRVIe45eebXmxmhs1YDTo5orxbEy1RjwP2v4q4/GfksWJWFq9FumjtZG7UN1iKEszyHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6fcd9518fad74e9e8e1119d24725da21-20240301
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:6b25d915-c005-4fd9-995e-80141905d565,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-30
X-CID-INFO: VERSION:1.1.37,REQID:6b25d915-c005-4fd9-995e-80141905d565,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:6f543d0,CLOUDID:53bafe80-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240301165841JSPWFF9D,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 6fcd9518fad74e9e8e1119d24725da21-20240301
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1125709206; Fri, 01 Mar 2024 16:58:40 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 8AD6CE000EBC;
	Fri,  1 Mar 2024 16:58:39 +0800 (CST)
X-ns-mid: postfix-65E198BF-298440663
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id C6123E000EBC;
	Fri,  1 Mar 2024 16:58:36 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v2] powerpc/mm: Code cleanup for __hash_page_thp
Date: Fri,  1 Mar 2024 16:58:34 +0800
Message-Id: <20240301085834.1512921-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This part was commented from commit 6d492ecc6489
("powerpc/THP: Add code to handle HPTE faults for hugepages")
in about 11 years before.

If there are no plans to enable this part code in the future,
we can remove this dead code and replace with a comment
explaining what the dead code was trying to say.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Suggested-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
---
Changes to v2:
    - Replace dead code with a comment as Michael Ellerman said in https:=
//lore.kernel.org/all/87h6hva4b0.fsf@mail.lhotse/#R
    - Improve commit msg
---
 arch/powerpc/mm/book3s64/hash_hugepage.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_hugepage.c b/arch/powerpc/mm/b=
ook3s64/hash_hugepage.c
index c0fabe6c5a12..15d6f3ea7178 100644
--- a/arch/powerpc/mm/book3s64/hash_hugepage.c
+++ b/arch/powerpc/mm/book3s64/hash_hugepage.c
@@ -59,16 +59,13 @@ int __hash_page_thp(unsigned long ea, unsigned long a=
ccess, unsigned long vsid,
=20
 	rflags =3D htab_convert_pte_flags(new_pmd, flags);
=20
-#if 0
-	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
+	/*
+	 * THPs are only supported on platforms that can do mixed page size
+	 * segments (MPSS) and all such platforms have coherent icache. Hence w=
e
+	 * don't need to do lazy icache flush (hash_page_do_lazy_icache()) on
+	 * noexecute fault.
+	 */
=20
-		/*
-		 * No CPU has hugepages but lacks no execute, so we
-		 * don't need to worry about that case
-		 */
-		rflags =3D hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
-	}
-#endif
 	/*
 	 * Find the slot index details for this ea, using base page size.
 	 */
--=20
2.39.2


