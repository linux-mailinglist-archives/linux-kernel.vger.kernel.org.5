Return-Path: <linux-kernel+bounces-163214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB658B6748
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED52284FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87BA8C10;
	Tue, 30 Apr 2024 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WIMtMFir"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077E21C33;
	Tue, 30 Apr 2024 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439760; cv=none; b=rwm9O/UnWZ7o22nKhbRtCFZKbbh6VmzDzEWeTHzUqm2fGksGdkcm2etFUpwbNMdiFCm0ksbzoqqg6XkS1jOXbbtVQ4i5ByocHeOEi8oXzk/61DfCinTiX878l4pxMcKI5t6QGxqJ+JZdbWdJDv0lzIEj/4xsayqq/CSh8j6P3kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439760; c=relaxed/simple;
	bh=eM5xvI01NgUPByPC3K6awA80YXkY3Nm0CXi0UV8yhGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/zE4CGum7+BoX20S0ZQZDGFKUwfyZYXjIiCv5cQgzXxY2m+3AfRsD7CbNDWwMW58hWkU1305m4Uze+gVtjrqEHJ2Grb2/boUmBADrJKe50ss8KcVA/aW4Ptz+BDdfCphJYHSUoJSkTuLDYibiUK80YwD5VgdzlYq5M1ONuByig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WIMtMFir; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2ef914a6068f11ef8065b7b53f7091ad-20240430
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=E7qOPXMN3EtN709VL/sVHkpUIxB3GzdKBCh9pB/IiYI=;
	b=WIMtMFirpKj9IulHiTt0u8xMJKx6YyRc494w108Pd7UwmfZxWfy0+0zd1WbS1Y+S4ZREuq3rxlInQZNUdR30IFJIV+HdeynWUWquadjJvKpXTP7x85etCgQS7OppPLC0mWfQdXZodTdg8vjs7l153TlvNlIkrEFgFjljJZErdJs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:18194811-b185-4094-8b9c-254a341966cf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:15cf7ffb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2ef914a6068f11ef8065b7b53f7091ad-20240430
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <olivia.wen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1898165973; Tue, 30 Apr 2024 09:15:50 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 Apr 2024 09:15:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 Apr 2024 09:15:49 +0800
From: Olivia Wen <olivia.wen@mediatek.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Tinghan
 Shen <tinghan.shen@mediatek.com>, <linux-remoteproc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<jason-ch.chen@mediatek.com>, <yaya.chang@mediatek.com>,
	<teddy.chen@mediatek.com>, <olivia.wen@mediatek.com>
Subject: [PATCH v4 0/4] Support MT8188 SCP core 1
Date: Tue, 30 Apr 2024 09:15:30 +0800
Message-ID: <20240430011534.9587-1-olivia.wen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Change in v4:
Updating the description of PATCH v4 4/4.

Olivia Wen (4):
  dt-bindings: remoteproc: mediatek: Support MT8188 dual-core SCP
  remoteproc: mediatek: Support MT8188 SCP core 1
  remoteproc: mediatek: Support setting DRAM and IPI shared buffer sizes
  remoteproc: mediatek: Add IMGSYS IPI command

 .../devicetree/bindings/remoteproc/mtk,scp.yaml    |   2 +
 drivers/remoteproc/mtk_common.h                    |  11 +-
 drivers/remoteproc/mtk_scp.c                       | 230 +++++++++++++++++++--
 drivers/remoteproc/mtk_scp_ipi.c                   |   7 +-
 include/linux/remoteproc/mtk_scp.h                 |   1 +
 5 files changed, 225 insertions(+), 26 deletions(-)

-- 
2.6.4


