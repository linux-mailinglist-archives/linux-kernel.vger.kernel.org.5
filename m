Return-Path: <linux-kernel+bounces-44247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B79841F88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25C50B323A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26836605C1;
	Tue, 30 Jan 2024 09:23:10 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D935F6086F;
	Tue, 30 Jan 2024 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606589; cv=none; b=WLdsnhygTQS/fJk85EEZ3BaWFDhydq3CFyrEC+Ut8XX+m/xw4Out/CirYrJS0jSRap0E6jut33yE4Pn1F0LMqQxUHFfHXlIJMsVN+kjKqEgUY3LuYr0rvtEJLcY7M97MYzXFAhjdyAjnqAZXNl3sgjKoH2hvbo7DwrgcfJNBqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606589; c=relaxed/simple;
	bh=RR2Ok8eBu0hx7ryrpW9iLq2RX/x8Hk8b0Su0iAg7OxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jcht5U9nzprNf37L20fXCMVOOekr//Gm4NsM37kMeu5aBZeHCimy2Kow16pLUG70lBXCCJk+J8+iFw2n5jYXE4d3Ax8bOamCbpmwqeDdOygEjlWkCoxb4MEOvbJGoftCou+alXqrMun7Ba1Ld0GilOaRuE0tiHwLtSXLhrPl5mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 96f56ac84e1d4b7fb233b844da02fedb-20240130
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:a29a4ccd-7f3f-4b35-ad67-a1ff0bb61347,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:a29a4ccd-7f3f-4b35-ad67-a1ff0bb61347,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:4eef6983-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240130172300JBAW41TA,BulkQuantity:0,Recheck:0,SF:24|17|19|44|66|38|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 96f56ac84e1d4b7fb233b844da02fedb-20240130
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1225308110; Tue, 30 Jan 2024 17:22:59 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 021C6E000EB9;
	Tue, 30 Jan 2024 17:22:59 +0800 (CST)
X-ns-mid: postfix-65B8BFF2-8629861024
Received: from kernel.. (unknown [172.20.15.213])
	by mail.kylinos.cn (NSMail) with ESMTPA id 108B0E000EB9;
	Tue, 30 Jan 2024 17:22:57 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH net-next] net: ipv4: Simplify the allocation of slab caches in inet_initpeers
Date: Tue, 30 Jan 2024 17:22:55 +0800
Message-Id: <20240130092255.73078-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
introduces a new macro.
Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/ipv4/inetpeer.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index e9fed83e9b3c..5bd759963451 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -81,10 +81,7 @@ void __init inet_initpeers(void)
=20
 	inet_peer_threshold =3D clamp_val(nr_entries, 4096, 65536 + 128);
=20
-	peer_cachep =3D kmem_cache_create("inet_peer_cache",
-			sizeof(struct inet_peer),
-			0, SLAB_HWCACHE_ALIGN | SLAB_PANIC,
-			NULL);
+	peer_cachep =3D KMEM_CACHE(inet_peer, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
 }
=20
 /* Called with rcu_read_lock() or base->lock held */
--=20
2.39.2


