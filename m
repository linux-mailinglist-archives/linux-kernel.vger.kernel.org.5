Return-Path: <linux-kernel+bounces-38322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA183BDCC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2317F1F328A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4541CD1E;
	Thu, 25 Jan 2024 09:46:49 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCB01BF38
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176009; cv=none; b=XFD21Vlm8aaDBbmqEtffNJBqEULpOhMkMaURUVkVzPCa2i0Z7hPDVzjs0I7t4Yco/tFzn8GIV2VWdd+Nx4WwMO+Dq7hE5nJC83W/Taa33nGwRhpCABArMtDALH5iUM4M9aq83usPYg04ycMnWpUEO06DOFM7A67R8KduMxwjKLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176009; c=relaxed/simple;
	bh=xdFZpeCRG2TNf/DDO5k9jUPoTXk8oGxfpATTRCbxTkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IJUwlgqWqUZuQpNIsKfxalae/MsgfJRG7fN0zWIS/oDvhdlwGLD0OwPQKwWNFu2PqZ+FDqZz/n9Az54FRfaKtQN/RpKaUiPRtm/t+0UPwqgeKffHYVH8jFDDIHpM/N9rbajpwuVTTZIlPpsnQWArJtomGoK+dJ9OiZ/s/xXscTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0f8b16b06b254827ab24561f4300281f-20240125
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:d351d60f-d08e-48cc-8450-7bce4e5d0dad,IP:20,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:0
X-CID-INFO: VERSION:1.1.35,REQID:d351d60f-d08e-48cc-8450-7bce4e5d0dad,IP:20,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:df05a68e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240125174642EFIYU8ZJ,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 0f8b16b06b254827ab24561f4300281f-20240125
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1965344753; Thu, 25 Jan 2024 17:46:41 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 62C7FE000EBA;
	Thu, 25 Jan 2024 17:46:41 +0800 (CST)
X-ns-mid: postfix-65B22E01-303995797
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id D0B63E000EBA;
	Thu, 25 Jan 2024 17:46:38 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] powerpc/mm/hash: Code cleanup
Date: Thu, 25 Jan 2024 17:46:36 +0800
Message-Id: <20240125094636.539372-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This part was commented in about 17 years before.
If there are no plans to enable this part code in the future,
we can remove this dead code.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 22 -------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc=
/include/asm/book3s/64/mmu-hash.h
index 1c4eebbc69c9..d39ec7134a78 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -731,26 +731,6 @@ struct hash_mm_context {
 #endif /* CONFIG_PPC_SUBPAGE_PROT */
 };
=20
-#if 0
-/*
- * The code below is equivalent to this function for arguments
- * < 2^VSID_BITS, which is all this should ever be called
- * with.  However gcc is not clever enough to compute the
- * modulus (2^n-1) without a second multiply.
- */
-#define vsid_scramble(protovsid, size) \
-	((((protovsid) * VSID_MULTIPLIER_##size) % VSID_MODULUS_##size))
-
-/* simplified form avoiding mod operation */
-#define vsid_scramble(protovsid, size) \
-	({								 \
-		unsigned long x;					 \
-		x =3D (protovsid) * VSID_MULTIPLIER_##size;		 \
-		x =3D (x >> VSID_BITS_##size) + (x & VSID_MODULUS_##size); \
-		(x + ((x+1) >> VSID_BITS_##size)) & VSID_MODULUS_##size; \
-	})
-
-#else /* 1 */
 static inline unsigned long vsid_scramble(unsigned long protovsid,
 				  unsigned long vsid_multiplier, int vsid_bits)
 {
@@ -764,8 +744,6 @@ static inline unsigned long vsid_scramble(unsigned lo=
ng protovsid,
 	return (vsid + ((vsid + 1) >> vsid_bits)) & vsid_modulus;
 }
=20
-#endif /* 1 */
-
 /* Returns the segment size indicator for a user address */
 static inline int user_segment_size(unsigned long addr)
 {
--=20
2.39.2


