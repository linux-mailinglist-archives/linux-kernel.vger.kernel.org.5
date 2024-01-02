Return-Path: <linux-kernel+bounces-13969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E10821625
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8602B1F2188D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 01:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD24A3C;
	Tue,  2 Jan 2024 01:35:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7BA48;
	Tue,  2 Jan 2024 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 13bd09458a2e4a3599d2b57a54f3a0f9-20240102
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:9420383e-e2fc-4d02-8f54-03bfb08ac8c6,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:14,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:29
X-CID-INFO: VERSION:1.1.35,REQID:9420383e-e2fc-4d02-8f54-03bfb08ac8c6,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:14,FILE:0,BULK:0,RULE:Release_HamU,ACTION
	:release,TS:29
X-CID-META: VersionHash:5d391d7,CLOUDID:8f88b22e-1ab8-4133-9780-81938111c800,B
	ulkID:240102093503YNBDE7H7,BulkQuantity:0,Recheck:0,SF:66|38|24|16|19|42|7
	4|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 13bd09458a2e4a3599d2b57a54f3a0f9-20240102
Received: from node4.com.cn [(39.156.73.12)] by mailgw
	(envelope-from <tanzheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1244345580; Tue, 02 Jan 2024 09:35:00 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id B121016001CD7;
	Tue,  2 Jan 2024 09:35:00 +0800 (CST)
X-ns-mid: postfix-65936844-53828531
Received: from localhost.localdomain (unknown [172.20.40.222])
	by node4.com.cn (NSMail) with ESMTPA id DE73916001CD7;
	Tue,  2 Jan 2024 01:34:52 +0000 (UTC)
From: zheng tan <tanzheng@kylinos.cn>
To: jmaloy@redhat.com,
	ying.xue@windriver.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Zheng tan <tanzheng@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH 1/5] net: tipc: fix spelling typo in comment
Date: Tue,  2 Jan 2024 09:34:35 +0800
Message-Id: <20240102013435.3187837-1-tanzheng@kylinos.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zheng tan <tanzheng@kylinos.cn>

fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Zheng tan <tanzheng@kylinos.cn>
---
 net/tipc/name_table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index d1180370fdf4..3c9a07f272ee 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -620,7 +620,7 @@ bool tipc_nametbl_lookup_anycast(struct net *net,
 	return res;
 }
=20
-/* tipc_nametbl_lookup_group(): lookup destinaton(s) in a communication =
group
+/* tipc_nametbl_lookup_group(): lookup destination(s) in a communication=
 group
  * Returns a list of one (=3D=3D group anycast) or more (=3D=3D group mu=
lticast)
  * destination socket/node pairs matching the given address.
  * The requester may or may not want to exclude himself from the list.
@@ -667,7 +667,7 @@ bool tipc_nametbl_lookup_group(struct net *net, struc=
t tipc_uaddr *ua,
 	return !list_empty(dsts);
 }
=20
-/* tipc_nametbl_lookup_mcast_sockets(): look up node local destinaton so=
ckets
+/* tipc_nametbl_lookup_mcast_sockets(): look up node local destination s=
ockets
  *                                      matching the given address
  * Used on nodes which have received a multicast/broadcast message
  * Returns a list of local sockets
--=20
2.34.1


