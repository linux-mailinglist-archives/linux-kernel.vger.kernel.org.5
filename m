Return-Path: <linux-kernel+bounces-72545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E38C85B502
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7BE2826BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28975D460;
	Tue, 20 Feb 2024 08:25:05 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1605C8E9;
	Tue, 20 Feb 2024 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417505; cv=none; b=oGlozK5egtY4bGBWsO0nkZ2aEz68fv7XHqbVVCkc932eBxWCFfBF3I1NjxK3bacOhyUFNeECCsyZLaut2LH3/1JGHVAdjVWHwiv9m8a1EqsdD2pIsptNXxkpLvHe2Eogi5V4SyNx4IfgtekfMVtEIGrIqYbxTyaJ9DAQDBUgvqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417505; c=relaxed/simple;
	bh=aGMZvL1E+Kg3YalVE1lVohFSTudazOHSLjbToygnCs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YN2LDKeeIXU2HWGx+TR/qqtoUUaJgB6h/GawHbKXc6VE1b8AwvyoOH/h8BhUItEiPPBMza/n/ugnQVzmsGpxIshwI+dUiLR+qPF23flTZoIi8x534EIU/xdLtBGfDAzj5uC/FtQsgJ7ShdhacoXOj970uvtbYntSFRTLvu1FE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 76a16fe503ca45c88fb8ea4a64c05306-20240220
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:87b0dffe-d672-4843-b988-436162f7c16f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:87b0dffe-d672-4843-b988-436162f7c16f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:d9f8fcfe-c16b-4159-a099-3b9d0558e447,B
	ulkID:240220153655JDMHATEQ,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 76a16fe503ca45c88fb8ea4a64c05306-20240220
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1016564439; Tue, 20 Feb 2024 15:36:52 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 85748E000EBC;
	Tue, 20 Feb 2024 15:36:52 +0800 (CST)
X-ns-mid: postfix-65D45693-91819618
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 1C4B1E000EBD;
	Tue, 20 Feb 2024 15:36:51 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiri@resnulli.us,
	Kunwu Chan <chentao@kylinos.cn>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH net-next v2 1/5] net: kcm: Simplify the allocation of slab caches
Date: Tue, 20 Feb 2024 15:36:42 +0800
Message-Id: <20240220073646.102033-2-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220073646.102033-1-chentao@kylinos.cn>
References: <20240220073646.102033-1-chentao@kylinos.cn>
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
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
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


