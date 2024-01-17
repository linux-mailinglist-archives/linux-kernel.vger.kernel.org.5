Return-Path: <linux-kernel+bounces-28699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5957B830207
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4B41F22DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F1A13ADC;
	Wed, 17 Jan 2024 09:17:21 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A782134BC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483041; cv=none; b=ZJka0GYPk99qEP+EoK/x33X6rS9tAP4rb4Oi5XCSoIXMkLoi8n3GASXDeGjL5rf2119tsqkZDKZaQWeco9gnxg5dczU4cak1Rk6dXHjVwePy4eCFjJo4UOIezu0na1p4i3/DouVd8TRhoDUyKfUtlOgDx6bMXtvmeZ5SBIw3hn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483041; c=relaxed/simple;
	bh=sYxmtWaOUPMmJejHPWIri6Krn9Q3F04U5nHmf+lslrY=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:X-ns-mid:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=qjyRfBO9UlRS3MXYlyrmmAX8o19RvFKO2C1zR6ZpCkCyVX0f//A0ARWLzqLSVj1wQ29urrVM8nC2qJ/BEzEr3wYAm58KId5asVbVPQndKjtV2belFMSwXWn0Ni9tOqNuJiEsWI+YP6mQ7t9NGryzVedL/O4G/EqlcV9DbgXoBwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 092a25c25f774595a76680933ec4c3ab-20240117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:e62c8672-fef4-4b33-9946-b3a1b05d1d21,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.35,REQID:e62c8672-fef4-4b33-9946-b3a1b05d1d21,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:5d391d7,CLOUDID:035e432f-1ab8-4133-9780-81938111c800,B
	ulkID:24011717171241K6UZ5Z,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 092a25c25f774595a76680933ec4c3ab-20240117
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 55816797; Wed, 17 Jan 2024 17:17:10 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id AF339E000EB9;
	Wed, 17 Jan 2024 17:17:10 +0800 (CST)
X-ns-mid: postfix-65A79B16-504608615
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id DF716E000EB9;
	Wed, 17 Jan 2024 17:17:07 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] powerpc/pasemi: Add a null pointer check to the pas_setup_mce_regs
Date: Wed, 17 Jan 2024 17:17:06 +0800
Message-Id: <20240117091706.153431-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 arch/powerpc/platforms/pasemi/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platfor=
ms/pasemi/setup.c
index 0761d98e5be3..8f98f3b58888 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -165,6 +165,8 @@ static int __init pas_setup_mce_regs(void)
 	while (dev && reg < MAX_MCE_REGS) {
 		mce_regs[reg].name =3D kasprintf(GFP_KERNEL,
 						"mc%d_mcdebug_errsta", reg);
+		if (!mce_regs[reg].name)
+			return -ENOMEM;
 		mce_regs[reg].addr =3D pasemi_pci_getcfgaddr(dev, 0x730);
 		dev =3D pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa00a, dev);
 		reg++;
--=20
2.39.2


