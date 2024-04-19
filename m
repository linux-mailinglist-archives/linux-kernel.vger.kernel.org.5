Return-Path: <linux-kernel+bounces-151183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C618AAAB8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E891C21FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3A74BF5;
	Fri, 19 Apr 2024 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="q62PXFxp"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFC860262;
	Fri, 19 Apr 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713516153; cv=none; b=e+5Bp+NdRCLXmdZJs2p2rq1beI8hjp6TpDuluWmHa94OraEbM8CdlJQVFjnG5HOFXxzH00HUBoAiB1Gtb6c793/8FTOTL0aDClPWxqG0CxRRLiVLS8VvXF0h0f8s7X3MyR0u0tsrMiiphhlDDs4M45KxZ6jFRiWNYqmrxq/Ak/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713516153; c=relaxed/simple;
	bh=fFtf8h/oA2Cwr2KUbMg7w3OMJkjoupDDeZrMA1tlLXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dbn8d9uI/9Uc9mzJAvYm96zWapUyxGuHPlX9BtI24qXl5/Qf6SpotZTe5D+5OYL2Ap/Ny8HsJ5GWwB3a9nZYhXn/VSTl0PvWsQ5lIAYZiMyxwbdsx4BkbQ8s4/nFlFUqHwvf5jamZDLlzDpqB0voRnRCDr2T8e1QXqZ2lg4+YMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=q62PXFxp; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bf877e82fe2811eeb8927bc1f75efef4-20240419
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=k8xgKHGOLk22YTxlkQUseLp0TL4Lfi+IptzX72z60f8=;
	b=q62PXFxppyKkS6FZTIeMXnZwsU/mn6tl9kU09cOQCARSagviOzFs6YsuoOq57ef0corxqV1h1J3OV9DNqcbzC0QLliMdAHhZWgvzeraRK28ogAnhpy2IJdu/gnhEjwbaMDtoubbr8fiOmZQwnWZwSAXTkYTnHEtnG0P2jhP80uE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:270be675-9540-458b-ba8b-4177c521a1b4,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:82c5f88,CLOUDID:d415df82-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bf877e82fe2811eeb8927bc1f75efef4-20240419
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <olivia.wen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 746720402; Fri, 19 Apr 2024 16:42:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 Apr 2024 16:42:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 19 Apr 2024 16:42:23 +0800
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
Subject: [PATCH v2 0/2] Support MT8188 SCP core 1
Date: Fri, 19 Apr 2024 16:42:09 +0800
Message-ID: <20240419084211.31901-1-olivia.wen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.099800-8.000000
X-TMASE-MatchedRID: 5QkmdD6LvPJ+YhdyenZTz4sKNaNh88CQsEf8CpnIYtnfUZT83lbkEBFx
	R5JQAS6O4wnhOb+JR+SAMuqetGVetiVvu9chHp+mavP8b9lJtWr6C0ePs7A07Q2y0JeZ/zscoZw
	wICyeoD3MM3a3XeTtKmFz8X6dP8PZtV04mbdKF8YOwU2/CT+xV0ZNgzs5p1AvtSF30+HwrkKm6E
	3e35F4TGLSbfA3MPr6dmtRsRmKkASJZPT2ZDPuzPD2QfzMDLjho65UufHcDvg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.099800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	07CE3AA0174AD91AB9808404EAB492C91087E1EB2468EADC569D868CE0F9A4722000:8
X-MTK: N

From: "olivia.wen" <olivia.wen@mediatek.com>

Change in v2:
- change the order of mt8188-scp-dual
- modify the struct mtk_scp_of_data on MT8188
- add MT8188-specific functions
- add structure mtk_scp_sizes_data to manage sizes
- change tmp_data allocation to share_buf

olivia.wen (2):
  dt-bindings: remoteproc: mediatek: Support MT8188 dual-core SCP
  remoteproc: mediatek: Support MT8188 SCP core 1

 .../devicetree/bindings/remoteproc/mtk,scp.yaml    |   2 +
 drivers/remoteproc/mtk_common.h                    |  11 +-
 drivers/remoteproc/mtk_scp.c                       | 230 +++++++++++++++++++--
 drivers/remoteproc/mtk_scp_ipi.c                   |   7 +-
 include/linux/remoteproc/mtk_scp.h                 |   1 +
 5 files changed, 225 insertions(+), 26 deletions(-)

-- 
2.6.4


