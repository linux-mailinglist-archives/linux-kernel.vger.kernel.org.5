Return-Path: <linux-kernel+bounces-156193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8478AFF0F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4D8285076
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B53213CFAD;
	Wed, 24 Apr 2024 03:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pUqIa7ig"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DC084FAA;
	Wed, 24 Apr 2024 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927867; cv=none; b=QXFDf4htMX7N//fpMpMRpZy/zatcMTEfU2XMmdqmDc1D2hkZKoR8Q5ajSTMuyJun59oePnTIuwKGFLVydCBjiI+wsoN0zWs3SvlczfIkn9lOClFAUi/JJ3Rev7VzPqFiSb5hyS//N0UoDVkITPT5ZKsYBVcx0+nMok11853YyeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927867; c=relaxed/simple;
	bh=HxHt/Gd+zZutpsHkZ4sqzlMWRHkv4SXKbRnflPqF3vM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GbLk22yioCx0vkGihK0/tiX2Y6CsW3U7S3n3jWCPaHbfjfhIfTBXXv7vyg6JtzrA6mqpzxDBp79yfKdfc+0vsGTQGDpJLzQfh1afy+072tWCgQvwAXNRNuyMwSGfmeNkjIfzmTomogCuiwhrndAki432r1RxMEcCotwA4IgHm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pUqIa7ig; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 576231c201e711efb8927bc1f75efef4-20240424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bK/04hzbREP4PVgBgY3aaLnmQrWeIappsXHz2+2OJ4w=;
	b=pUqIa7igyOJoFAlCDls/mES5bB7HNg+/061mI4B2dCD33pUoUG3BvUrgJizleHQrZCasmloC1Pq64MyPZ/cnXASZyqCTEWXtPSsSd60E0zhUaXWMfQsflV3QCS0Pw2FQiKuJBNniruLSU/wRVT1MKQE7R+j0wnYlH/RJ0n1bwSw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:5cf3c036-4496-4461-9676-a7bf1a71f702,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:b8f40983-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 576231c201e711efb8927bc1f75efef4-20240424
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <olivia.wen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 600295369; Wed, 24 Apr 2024 11:04:18 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Apr 2024 11:04:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 Apr 2024 11:04:15 +0800
From: Olivia Wen <olivia.wen@mediatek.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Tinghan Shen" <tinghan.shen@mediatek.com>,
	<linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<jason-ch.chen@mediatek.com>, <yaya.chang@mediatek.com>,
	<teddy.chen@mediatek.com>, <olivia.wen@mediatek.com>
Subject: [PATCH v3 0/4] Support MT8188 SCP core 1
Date: Wed, 24 Apr 2024 11:03:47 +0800
Message-ID: <20240424030351.5294-1-olivia.wen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.239800-8.000000
X-TMASE-MatchedRID: oW+CQKgX/2R+YhdyenZTz7Gj3LN0+Ey9lIsQ0nJjgWNcKZwALwMGs+2V
	VVLUIzQwTiQecD9aKoRYo3G+rvxrNUkjllSXrjtQFEUknJ/kEl5q8/xv2Um1avoLR4+zsDTtB00
	/kkeBTwAaleYWbIcH4tivMLMhjTVTyRWDL5/tObbY4PhY0w6qGMUgcbg+pBgtlrwXq2t0/ejenY
	rAXROpoaDDDv6krQYM8lWpj+Ra1oh2a1GxGYqQBIlk9PZkM+7M8PZB/MwMuOGjrlS58dwO+A==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.239800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E8FEBF4C631EFB7E5D7428EE62BEAC47F881B0ECBFB26DEE7BF71404867064662000:8
X-MTK: N

Change in v3:
- split the modifications in version 2 into three separate commits

Change in v2:
- change the order of mt8188-scp-dual
- modify the struct mtk_scp_of_data on MT8188
- add MT8188-specific functions
- add structure mtk_scp_sizes_data to manage sizes
- change tmp_data allocation to share_buf

Olivia Wen (4):
  dt-bindings: remoteproc: mediatek: Support MT8188 dual-core SCP
  remoteproc: mediatek: Support MT8188 SCP core 1
  remoteproc: mediatek: Support setting DRAM and IPI shared buffer sizes
  media: mediatek: imgsys: Support image processing

 .../devicetree/bindings/remoteproc/mtk,scp.yaml    |   2 +
 drivers/remoteproc/mtk_common.h                    |  11 +-
 drivers/remoteproc/mtk_scp.c                       | 230 +++++++++++++++++++--
 drivers/remoteproc/mtk_scp_ipi.c                   |   7 +-
 include/linux/remoteproc/mtk_scp.h                 |   1 +
 5 files changed, 225 insertions(+), 26 deletions(-)

-- 
2.6.4


