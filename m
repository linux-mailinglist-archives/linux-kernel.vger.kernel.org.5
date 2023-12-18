Return-Path: <linux-kernel+bounces-3166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA388816824
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CAC1F22AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ADC10945;
	Mon, 18 Dec 2023 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="K1I45V9r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F241101E8;
	Mon, 18 Dec 2023 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8f6380249d8011eea5db2bebc7c28f94-20231218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RN8uPOB4PQETpivCJ+p4IT7QHrFP25bbFcqUaZN5iAg=;
	b=K1I45V9rCMNp+O6PLon9PJ5LcgdACAlOcJU9HqyAthptJuENF2roJIAz2+ASLywDDQfau3nAS8Jxgtz1Qby3sdY7bE5tVmmoiSn5Fk5hbA7+E5TEmz6aInlIhXhegC7/TcOj3dYZDHQHNgXvM+RyQdRltJWSkENwmhGgIb8yXXs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:5911d87e-c21f-4519-b310-e17f79b96462,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:a7ee4cbd-2ac7-4da2-9f94-677a477649d9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8f6380249d8011eea5db2bebc7c28f94-20231218
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1302869408; Mon, 18 Dec 2023 16:36:38 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Dec 2023 16:36:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Dec 2023 16:36:05 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Jason-ch Chen <jason-ch.chen@mediatek.com>, Johnson Wang
	<johnson.wang@mediatek.com>, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
	Shawn Sung <shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jason-jh Lin
	<jason-jh.lin@mediatek.corp-partner.google.com>
Subject: [PATCH 0/3] Add mediatek,gce-events definition to mediatek,gce-mailbox bindings
Date: Mon, 18 Dec 2023 16:36:01 +0800
Message-ID: <20231218083604.7327-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.736100-8.000000
X-TMASE-MatchedRID: REQh4LCxv5DHof55kx23ffyAR9DgC/hHecvjbu/xDjoY0A95tjAn+7h0
	OUlkSqv9tYR/uNxnStGIJs0Up7vkWEkjllSXrjtQFEUknJ/kEl7dB/CxWTRRuwihQpoXbuXFU0N
	mgjpLwWgpK7FYyXJ7dzWXzuuIBy9l39CfFEXKCCLIp7X/GY6TRDQ+x7OL/d9Ga95GWOWghV7vUj
	22LskS7tuMe3AJpm3nF0aD5ljt43pMcHZD6gqu7wxMjfifIXfowkvVoA11TwqeqD9WtJkSIw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.736100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4835C8790B1F7367BF5849827331B2C30F006B62E79F41485C34A86A534115FA2000:8
X-MTK: N

From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>

Since mediatek,gce-events property is a HW event signal from GCE,
it should be defined in mediatek,gce-mailbox.yaml.

Change the description of mediatek,gce-events property existed in
other bindings to reference mediatek,gce-mailbox.yaml.

Jason-JH.Lin (3):
  dt-bindings: mailbox: mediatek,gce-mailbox: Add mediatek,gce-events
    definition
  dt-bindings: media: mediatek-mdp: Change the description of gce-events
  dt-bindings: soc: mediatek: Change the description of gce-events

 .../devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml  | 7 +++++++
 .../devicetree/bindings/media/mediatek,mdp3-rdma.yaml      | 5 +----
 .../devicetree/bindings/media/mediatek,mdp3-rsz.yaml       | 5 +----
 .../devicetree/bindings/media/mediatek,mdp3-wrot.yaml      | 5 +----
 .../devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml   | 5 +----
 .../devicetree/bindings/soc/mediatek/mediatek,mutex.yaml   | 5 +----
 .../devicetree/bindings/soc/mediatek/mediatek,wdma.yaml    | 5 +----
 7 files changed, 13 insertions(+), 24 deletions(-)

-- 
2.18.0


