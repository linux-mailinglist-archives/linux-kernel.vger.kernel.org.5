Return-Path: <linux-kernel+bounces-52130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3923C84946E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C23287650
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93B91428B;
	Mon,  5 Feb 2024 07:20:59 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E1614008;
	Mon,  5 Feb 2024 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117659; cv=none; b=p2QfR7buEhT5sfmCzfQWeVg4passK9zsJVQPkI+GwkT/I23m8Y0vMrwkKOrZsjPF3U3y48TrxgtUhgifuoV0NeR5cuX9LmAWvhzxb5ZCDOFs5N2hrRVBqsQTalVnNKsqOvPXxsr530rGfjSHrlo9GqKQ5Zb4AwLjCkNRITLZors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117659; c=relaxed/simple;
	bh=EWhvGxiu9nKUlD223b5RUmg8URskoZ2Ajs6i2J1FTec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LHE9Liic0D/v0t0Z5wdOOdh+WyDSxxz6YWOiqOCd3Qh72QmnfdJGyqtbKhmzMBABZeGTbcMkz8LmhkN3SfdSS5KMtqtJdiLuM7Qtn43qTJGbXsOh9IaSr2dGnngiW3WvLPZhAbuE1DiNUfViooZKrAovczKeT7luaFhJSqQQLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e1b809629f7a4cb6adc5306ec28bb32f-20240205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:834f65fe-04d1-422d-887d-cfff6283464b,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:834f65fe-04d1-422d-887d-cfff6283464b,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:97af078f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240205152053NOLOL8W3,BulkQuantity:0,Recheck:0,SF:19|44|66|38|24|17|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: e1b809629f7a4cb6adc5306ec28bb32f-20240205
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1384232374; Mon, 05 Feb 2024 15:20:52 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 4B1EEE000EBC;
	Mon,  5 Feb 2024 15:20:52 +0800 (CST)
X-ns-mid: postfix-65C08C54-11146078
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 93223E000EBC;
	Mon,  5 Feb 2024 15:20:51 +0800 (CST)
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
Subject: [PATCH net-next 5/6] tcp: Simplify the allocation of slab caches
Date: Mon,  5 Feb 2024 15:20:12 +0800
Message-Id: <20240205072013.427639-6-chentao@kylinos.cn>
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
And change cache name from 'tcp_bind_bucket' to 'inet_bind_bucket',
'tcp_bind2_bucket' to 'inet_bind2_bucket'.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/ipv4/tcp.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a1c6de385cce..2dc3dd4323c2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4697,17 +4697,11 @@ void __init tcp_init(void)
 			    thash_entries, 21,  /* one slot per 2 MB*/
 			    0, 64 * 1024);
 	tcp_hashinfo.bind_bucket_cachep =3D
-		kmem_cache_create("tcp_bind_bucket",
-				  sizeof(struct inet_bind_bucket), 0,
-				  SLAB_HWCACHE_ALIGN | SLAB_PANIC |
-				  SLAB_ACCOUNT,
-				  NULL);
+		KMEM_CACHE(inet_bind_bucket,
+			   SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 	tcp_hashinfo.bind2_bucket_cachep =3D
-		kmem_cache_create("tcp_bind2_bucket",
-				  sizeof(struct inet_bind2_bucket), 0,
-				  SLAB_HWCACHE_ALIGN | SLAB_PANIC |
-				  SLAB_ACCOUNT,
-				  NULL);
+		KMEM_CACHE(inet_bind2_bucket,
+			   SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
=20
 	/* Size and allocate the main established and bind bucket
 	 * hash tables.
--=20
2.39.2


