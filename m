Return-Path: <linux-kernel+bounces-52128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F0D84946A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BA61F25419
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2579B13AC2;
	Mon,  5 Feb 2024 07:20:49 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CFE10A25;
	Mon,  5 Feb 2024 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117648; cv=none; b=T0vRCpp7XotnTsEzrzIc65MLupnQNw9UQ/FwARcw4H3DMVOF+uVtvoYCMpNoj531Z34ZN+UEaWvkPr8ULNjHHWqHHipzOukxyqc3dZ63OXHTGAkIcODspI+pvd2ebcoPUuVsbn14xyjdNGjClyXK0M1q7tTgHCjyXuOi95ypj60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117648; c=relaxed/simple;
	bh=biOCybBNDhjOReD9xZnf1JAj6jSi0ruvZfoR2nzth48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XRCHNzd3k2Js60C4wMFybSS9bDtNDTDB9JIEW6mzTWgbyLNut22DCrCQNeI7tPmrJXliumjXRXGvACrxaOptgBmMDhlckC83+wjPzL4ZUDzYu8dwfIknOkZNVOiHDgAZU0+z1K87tkH9doUWm5O/Y0joxkE8WQRvhr+THFF+pDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fddf02a90dd44ab288f898ab8ea2abeb-20240205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:50d1ff59-2439-4ffe-8ed1-576131a8fe74,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:50d1ff59-2439-4ffe-8ed1-576131a8fe74,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:23af078f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240205152044NCROXGAD,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: fddf02a90dd44ab288f898ab8ea2abeb-20240205
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2072795595; Mon, 05 Feb 2024 15:20:42 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 597F8E000EBD;
	Mon,  5 Feb 2024 15:20:42 +0800 (CST)
X-ns-mid: postfix-65C08C4A-16642375
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id A0048E000EBC;
	Mon,  5 Feb 2024 15:20:41 +0800 (CST)
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
Subject: [PATCH net-next 3/6] ipmr: Simplify the allocation of slab caches
Date: Mon,  5 Feb 2024 15:20:10 +0800
Message-Id: <20240205072013.427639-4-chentao@kylinos.cn>
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
And change cache name from 'ip_mrt_cache' to 'mfc_cache'.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/ipv4/ipmr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 9d6f59531b3a..820c95bee6bb 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3139,10 +3139,7 @@ int __init ip_mr_init(void)
 {
 	int err;
=20
-	mrt_cachep =3D kmem_cache_create("ip_mrt_cache",
-				       sizeof(struct mfc_cache),
-				       0, SLAB_HWCACHE_ALIGN | SLAB_PANIC,
-				       NULL);
+	mrt_cachep =3D KMEM_CACHE(mfc_cache, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
=20
 	err =3D register_pernet_subsys(&ipmr_net_ops);
 	if (err)
--=20
2.39.2


