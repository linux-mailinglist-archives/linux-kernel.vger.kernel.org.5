Return-Path: <linux-kernel+bounces-21750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D124C8293C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3891F21363
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217813E490;
	Wed, 10 Jan 2024 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e2bvmJf6"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D3939FEF;
	Wed, 10 Jan 2024 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 756da1feaf8211eea2298b7352fd921d-20240110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vjXmLIHryISHRUtxh9pi1TfFi3d26ZfU2q7c/DnXizk=;
	b=e2bvmJf6QlTMi0DG0+KpCdyxHsVjVLVxclrIdn3/znMIjcty5AEytCwcqVHOCrPaLFmuRrVelAxB5TC28wD2dzxqDvHpL/sRdb4fN6+fDLQftlhfFvSd4UfQBmRYvdFRoIPpCo9Xxe1G7ze8T6EPhSDNeoFVrdrL4Zi9XCGFzOQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:54004e52-5208-48ef-8ad8-fa8e0f6f7c50,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:5fab168e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 756da1feaf8211eea2298b7352fd921d-20240110
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1940673489; Wed, 10 Jan 2024 14:35:34 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Jan 2024 14:35:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Jan 2024 14:35:33 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Jason-ch Chen
	<jason-ch.chen@mediatek.com>, Johnson Wang <johnson.wang@mediatek.com>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>, Singo Chang
	<singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, Shawn Sung
	<shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jason-jh Lin
	<jason-jh.lin@mediatek.corp-partner.google.com>
Subject: [PATCH v2 0/4] Add mediatek,gce-props.yaml for other bindings reference mediatek,gce-events
Date: Wed, 10 Jan 2024 14:35:28 +0800
Message-ID: <20240110063532.14124-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>

Since mediatek,gce-events property is a HW event signal to GCE,
it can be used for both mailbox producers and consumers.

Add a new mediatek,gce-props.yaml to define this kind of GCE properties
and move mediatek,gce-events property existed in other bindings
to reference mediatek,gce-props.yaml.

Jason-JH.Lin (4):
  dt-bindings: mailbox: Add mediatek,gce-props.yaml
  dt-bindings: mailbox: mediatek: gce-mailbox: Add reference to
    gce-props.yaml
  dt-bindings: media: mediatek: mdp: Change mediatek,gce-events to
    reference
  dt-bindings: soc: mediatek: Change mediatek,gce-events to refernece

 .../mailbox/mediatek,gce-mailbox.yaml         |  6 ++-
 .../bindings/mailbox/mediatek,gce-props.yaml  | 41 +++++++++++++++++++
 .../bindings/media/mediatek,mdp3-rdma.yaml    | 11 ++---
 .../bindings/media/mediatek,mdp3-rsz.yaml     | 12 ++----
 .../bindings/media/mediatek,mdp3-wrot.yaml    | 12 ++----
 .../bindings/soc/mediatek/mediatek,ccorr.yaml | 12 ++----
 .../bindings/soc/mediatek/mediatek,mutex.yaml | 11 ++---
 .../bindings/soc/mediatek/mediatek,wdma.yaml  | 12 ++----
 8 files changed, 67 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gce-props.yaml

-- 
2.18.0


