Return-Path: <linux-kernel+bounces-72548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B1185B508
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52071F21742
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F26D5C8F3;
	Tue, 20 Feb 2024 08:25:09 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0EA5C8E2;
	Tue, 20 Feb 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417509; cv=none; b=hj/R316k7lmbCpzuGRA5FvxtHrSPLKIFoKHHxKK0X9J9ToFmwe5NJbwTLSYBftpTbXXB3R6JOthz72823kFh1xwXZMCLkMqkr+qJ/YqjhjWsdp+587p5SmwQBDFm66QHWcQjmL1gBAVd14gzYPjnSE+pUIeVLspdThGSjVyInpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417509; c=relaxed/simple;
	bh=+gpIKjjNe8+R+5iRvhPGIqKmtaT2w4KlGI3vBCIRKEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u0O1PFt941LM96sU8VlV5aM/Dd7jzRI5BpGw+f4G5umSB8QWnS9m7KMkst0hvlprSQD3Cdn4co95laNuhLZ0t9LbySRkFGqZ4QgxCzn2OQHaRg4M82vBgy2PxuOWQLAQpIoMxnsR3Vmh+epr2nmUfoVLT20OBH5Swgmj6I3/xHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cbb1d3fac0944f1897f3f03419695c7f-20240220
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:530f3a93-76a3-4c1c-965c-e43fbf8c287c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:530f3a93-76a3-4c1c-965c-e43fbf8c287c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:5ef67e8f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240220153655OTY0JWRP,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: cbb1d3fac0944f1897f3f03419695c7f-20240220
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1545208456; Tue, 20 Feb 2024 15:36:53 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 5BFFDE000EBC;
	Tue, 20 Feb 2024 15:36:53 +0800 (CST)
X-ns-mid: postfix-65D45695-20178919
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 9590BE000EBD;
	Tue, 20 Feb 2024 15:36:52 +0800 (CST)
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
Subject: [PATCH net-next v2 2/5] ip6mr: Simplify the allocation of slab caches in ip6_mr_init
Date: Tue, 20 Feb 2024 15:36:43 +0800
Message-Id: <20240220073646.102033-3-chentao@kylinos.cn>
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
And change cache name from 'ip6_mrt_cache' to 'mfc6_cache'.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 net/ipv6/ip6mr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 9782c180fee6..1f19743f2540 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1373,10 +1373,7 @@ int __init ip6_mr_init(void)
 {
 	int err;
=20
-	mrt_cachep =3D kmem_cache_create("ip6_mrt_cache",
-				       sizeof(struct mfc6_cache),
-				       0, SLAB_HWCACHE_ALIGN,
-				       NULL);
+	mrt_cachep =3D KMEM_CACHE(mfc6_cache, SLAB_HWCACHE_ALIGN);
 	if (!mrt_cachep)
 		return -ENOMEM;
=20
--=20
2.39.2


