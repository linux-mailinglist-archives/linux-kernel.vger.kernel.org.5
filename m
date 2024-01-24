Return-Path: <linux-kernel+bounces-36259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513D2839E02
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E699A1F29F51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D5C15CE;
	Wed, 24 Jan 2024 01:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rxB9HOM7"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1B10E6;
	Wed, 24 Jan 2024 01:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058910; cv=none; b=LrOzdtozLtWqbPSvtvNMVf7i8bosUF8P0kIjArAwVcDDDMLdXWj28k8i1lBFsyCsMqzFCcOggmpkspYJG4P/ZW0Pw4tpC83159FHcXBh/ljN971bgztIZTDFhkeiJnKsjrqPj9rr6bLUJbK5pRFF2OHvkMtXzjQxDdS5nyDDrgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058910; c=relaxed/simple;
	bh=5c7EiDpzvTgMQIbLwiumvkCTBwLx2if0fY/UPr8iITc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sWGKGq/qr5GKKULMGX6VwfxsPhRpEEs5895UhOOMru+1TqD1nBQvX4ELLi4oPf8nNWU9MhuJLRKvpdMO0RNsfQla5m75wKqpuRXVj1XF5MpHREJ5vZfzPz3uGAi6lUKBzFoY2rRu+WGFFupVmxnlotqAEjdpKGLzVZ56YuOhbns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rxB9HOM7; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ffa3dbf8ba5511ee9e680517dc993faa-20240124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Y2eeQTZZY/NZ2a6vQYTyhiRsKBL6xd0zO5wl1rg1YyU=;
	b=rxB9HOM78j+NMjcuBvzvtfG4QJomjAwtce5C9/yQdRIUASFyRVoZW0PjX1GsH3xaSBVBfybo926wPXk+HGnoKfyvigwC098F+eW29qQR+MI/qARm9IPFshKpkAkwWFujyHf8Dr7fWLFPznIbs1xztyCL8LTwAHONNTObaOu1d90=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:9c7ed194-fd0c-4953-912e-033ab8466ef9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6e16cf4,CLOUDID:2b7aae7f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ffa3dbf8ba5511ee9e680517dc993faa-20240124
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 504146864; Wed, 24 Jan 2024 09:15:01 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Jan 2024 09:15:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 Jan 2024 09:15:00 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<dri-devel@lists.freedesktop.org>, <linux-media@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, Jason-ch Chen <jason-ch.chen@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Fei Shao
	<fshao@chromium.org>, Jason-jh Lin
	<jason-jh.lin@mediatek.corp-partner.google.com>
Subject: [PATCH v4 0/3] Add mediatek,gce-props.yaml for other bindings reference
Date: Wed, 24 Jan 2024 09:14:56 +0800
Message-ID: <20240124011459.12204-1-jason-jh.lin@mediatek.com>
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

The property "mediatek,gce-events" is used for GCE event ID corresponding
to a hardware event signal sent by the hardware or a software driver.
If the mailbox providers or consumers want to manipulate the value of
the event ID, they need to know the specific event ID.

Since mediatek,gce-events property is used for both mailbox producers
and consumers, we add a mediatek,gce-props.yaml to place the common GCE
properties like mediatek,gce-events.

Change in v4:
1. Fix some typo.
2. Change maxItems of gce-events from 1024 to 32.

Change in v3:
1. Add more description and fix typo and grammar.
2. Fix $ref as full path.

Change in v2:
1. Add mediatek,gce-props.yaml for other binding reference.

Jason-JH.Lin (3):
  dt-bindings: mailbox: Add mediatek,gce-props.yaml
  dt-bindings: media: mediatek: mdp: Change mediatek,gce-events to
    reference
  dt-bindings: soc: mediatek: Change mediatek,gce-events to refernece

 .../bindings/mailbox/mediatek,gce-props.yaml  | 52 +++++++++++++++++++
 .../bindings/media/mediatek,mdp3-rdma.yaml    | 11 ++--
 .../bindings/media/mediatek,mdp3-rsz.yaml     | 12 ++---
 .../bindings/media/mediatek,mdp3-wrot.yaml    | 12 ++---
 .../bindings/soc/mediatek/mediatek,ccorr.yaml | 12 ++---
 .../bindings/soc/mediatek/mediatek,mutex.yaml | 11 ++--
 .../bindings/soc/mediatek/mediatek,wdma.yaml  | 12 ++---
 7 files changed, 74 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gce-props.yaml

-- 
2.18.0


