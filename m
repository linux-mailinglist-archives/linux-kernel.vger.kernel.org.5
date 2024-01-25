Return-Path: <linux-kernel+bounces-38286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5737583BD83
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7AC1C22AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F83B1CD1C;
	Thu, 25 Jan 2024 09:37:20 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389F1CA9A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175439; cv=none; b=fLSNdebKxKMJXSKM5jRr6G+qHBJeJ65cGJjdQ7zylS1dxjxm3WlaQpgprQUlw5WJml2pknwTm4bgAtO+cJjHPPcL1M9vpKm0db8r3NSBIqwFw1SRWjPRZWXHFwPQvmyXRhSn8wN4acVLrcNSi64PReaztVx64IL4PVFxbJ/kYMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175439; c=relaxed/simple;
	bh=zqW0i7Mt28UhG8E6gHi0hyAhHECwgXyrINp2Clw78K8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tRL31PN8vO3DFLf3gHWoA7Fyjy6T3aMqUe/5j59LlAzDCzV45USon19KYl78hNQPVgEKJDRYjnNA6Li15vu2dB/vEf+kg3W/nfvkf8b7tj7umZCbKWTRWwyqjMKSW86D0zX8RHHAZvYuKIuHSNVoI7toN1gCPMWGkGZ86A5KUBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 64fd2d18a7e4437c8889442e3c4bdec7-20240125
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:43234eab-9fd4-4712-a46a-9edd81ef7d9f,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.35,REQID:43234eab-9fd4-4712-a46a-9edd81ef7d9f,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:5d391d7,CLOUDID:9ff4be7f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240125172630BJ3E7V88,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 64fd2d18a7e4437c8889442e3c4bdec7-20240125
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2129244633; Thu, 25 Jan 2024 17:26:27 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 454FBE000EB9;
	Thu, 25 Jan 2024 17:26:27 +0800 (CST)
X-ns-mid: postfix-65B22942-199714737
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 8E2EDE000EB9;
	Thu, 25 Jan 2024 17:26:25 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] powerpc/mm: Code cleanup for __hash_page_thp
Date: Thu, 25 Jan 2024 17:26:24 +0800
Message-Id: <20240125092624.537564-1-chentao@kylinos.cn>
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
we can remove this dead code.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 arch/powerpc/mm/book3s64/hash_hugepage.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_hugepage.c b/arch/powerpc/mm/b=
ook3s64/hash_hugepage.c
index c0fabe6c5a12..127a3a2c174b 100644
--- a/arch/powerpc/mm/book3s64/hash_hugepage.c
+++ b/arch/powerpc/mm/book3s64/hash_hugepage.c
@@ -59,16 +59,6 @@ int __hash_page_thp(unsigned long ea, unsigned long ac=
cess, unsigned long vsid,
=20
 	rflags =3D htab_convert_pte_flags(new_pmd, flags);
=20
-#if 0
-	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
-
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


