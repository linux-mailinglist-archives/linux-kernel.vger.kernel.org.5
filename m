Return-Path: <linux-kernel+bounces-350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5575F813FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9D61C221D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51817ED4;
	Fri, 15 Dec 2023 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ryMzjk8V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8951A38
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a8eece589af211eeba30773df0976c77-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=oAgvCkE4M2zbYmW++fzjJcHwTEGwPobG91eN8CsvEBI=;
	b=ryMzjk8VKfCXOQDg5xL28CRuMsbvj+CqT5+BUlzoIcIJX9pvI4gpWIAG6JTpjlqZzpfQnFNGmL+AkCR1mwkveA5W/W9R2HxejgzgM0biLtVj/4ktLrxUWEnEf+upvxRFBSsjHhZLOtgHQBNydZQ5PGU7JnRMAyLp/W4FjWc3/Lk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:cf0ec86e-8bba-4990-aef1-dabc4a4b3161,IP:0,U
	RL:0,TC:0,Content:24,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:24
X-CID-META: VersionHash:5d391d7,CLOUDID:39b032bd-2ac7-4da2-9f94-677a477649d9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a8eece589af211eeba30773df0976c77-20231215
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 505734082; Fri, 15 Dec 2023 10:35:50 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 10:35:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 10:35:48 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jeffrey Kardatzke
	<jkardatzke@google.com>, Jason-ch Chen <jason-ch.chen@mediatek.com>, "Johnson
 Wang" <johnson.wang@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, "Nancy
 Lin" <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	"Jason-jh Lin" <jason-jh.lin@mediatek.corp-partner.google.com>
Subject: [PATCH 0/2] Add CMDQ driver support for mt8188
Date: Fri, 15 Dec 2023 10:35:44 +0800
Message-ID: <20231215023546.6594-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.931300-8.000000
X-TMASE-MatchedRID: yd+n2EYA75gb+BGg6rnrdlz+axQLnAVBuLwbhNl9B5W6SmGkMbaxzqPF
	jJEFr+olKE0Je8DR/D4CU1PRf9o2s90H8LFZNFG7doMssNsUwYX69iXByCLZ0AqJrCeZkMsUYqi
	98iWc8Ne3v8y3o7lkiSSXpcVye5jiXjvIBRQGNUHwA3HHlzP9c6rO4O9SwYGHtkxmOvfMlP+AhO
	caQrQ0U1GyRcoeF18qmKP0zzpTAeGwod8xOMKmvA1Aka/KIp/p
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.931300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: A355C0DDCA07CD1D0FD23379EC3A0DDDDCDC844E13490BD97FE65BA7510588312000:8
X-MTK: N

From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>

Since mt8188 has 32 GCE HW thread, we nedd a new platform data to
support it.

So we sort the platform data in numerical order of compatible names and
add a new mt8188 platform data.

Jason-JH.Lin (2):
  mailbox: mtk-cmdq: Sort cmdq platform data by compatible name
  mailbox: mtk-cmdq: Add CMDQ driver support for mt8188

 drivers/mailbox/mtk-cmdq-mailbox.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.18.0


