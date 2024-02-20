Return-Path: <linux-kernel+bounces-72544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C40D85B501
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF21C2326E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B8A5D462;
	Tue, 20 Feb 2024 08:25:05 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26E5C8E3;
	Tue, 20 Feb 2024 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417505; cv=none; b=Bidwba23Ew/u1QC2zU1QXRrURj1FswM4c7Q+82scsPR2edIbMiqdnjmClg4rjzxUqCk44v+KN2YHoB4CfnZKYMR1gXcgATPkioMoWjbJDO2ugRXUVo3rPCvI9KcFVe7ScTyAXAx8rbJf/lF8xYAxvyswwaUMieAPdTiTyacrsIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417505; c=relaxed/simple;
	bh=l46b04BQ9/cguSPWDJvEFDJiYvWEQAJk4USQVhOsPVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IAqie/XVQEEJAA+4w6FfG/sjLuASOIxyDLKeS8yWmT4g31j9+FnX5FF9iXjgT8N1H3sofcAs3CNqiQ9zneVZDXdHHy24Bl3HA24Wkul1LkCdumrV7L1lIb1e7Y2Lu3Q5jKR+W5mYWmkiHPDtyPxe0lKnVToiYln323j2EpGErQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4564e0be11e047c9978189527fd6d6ba-20240220
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:3cc6625c-3a8e-4cfa-b4c0-2e6d50b39c22,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:3cc6625c-3a8e-4cfa-b4c0-2e6d50b39c22,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:94fc9780-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240220153652XMGBIA5V,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,
	TF_CID_SPAM_FSD
X-UUID: 4564e0be11e047c9978189527fd6d6ba-20240220
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 723137940; Tue, 20 Feb 2024 15:36:51 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 0CE36E000EBC;
	Tue, 20 Feb 2024 15:36:51 +0800 (CST)
X-ns-mid: postfix-65D45692-85218917
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 99373E000EBC;
	Tue, 20 Feb 2024 15:36:48 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiri@resnulli.us,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH net-next v2 0/5] Use KMEM_CACHE instead of kmem_cache_create
Date: Tue, 20 Feb 2024 15:36:41 +0800
Message-Id: <20240220073646.102033-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As Jiri Pirko suggests,=20
I'm using a patchset to cleanup the same issues in the 'net' module.
Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Some cache names are changed to be the same as struct names.=20
This change is recorded in the changelog for easy reference.
It's harmless cause it's used in /proc/slabinfo to identify this cache.
---
Changes in v2:
	- Delete a patch as Eric said in https://lore.kernel.org/all/CANn89iLkWv=
um6wSqSya_K+1eqnFvp=3DL2WLW=3DkAYrZTF8Ei4b7g@mail.gmail.com/
	- No code changes,only add Reviewed-by tag
---
Kunwu Chan (5):
  net: kcm: Simplify the allocation of slab caches
  ip6mr: Simplify the allocation of slab caches in ip6_mr_init
  ipmr: Simplify the allocation of slab caches
  ipv4: Simplify the allocation of slab caches in ip_rt_init
  ipv6: Simplify the allocation of slab caches

 net/ipv4/ipmr.c    | 5 +----
 net/ipv4/route.c   | 5 ++---
 net/ipv6/ip6_fib.c | 6 ++----
 net/ipv6/ip6mr.c   | 5 +----
 net/kcm/kcmsock.c  | 8 ++------
 5 files changed, 8 insertions(+), 21 deletions(-)

--=20
2.39.2


