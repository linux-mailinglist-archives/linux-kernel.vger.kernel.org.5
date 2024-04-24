Return-Path: <linux-kernel+bounces-156190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C28AFF06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9211F23913
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6139128360;
	Wed, 24 Apr 2024 03:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="d/pzYgQ/"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B936BE4D;
	Wed, 24 Apr 2024 03:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927866; cv=none; b=mlYKPw2XBbDrHXSfS8dS3DO7kWK+fhNtOxcBlaVA57S8MybV/grzKTjnbw45HSYsCRLqSwlBZw/DwF9jb0rb60EgF0Y+3YddHpEJAk769xW5Ft9wLfVU/bPlkncNdTu/RCMHz+wctbqgWHScSEpd75GnfkCVMg7Vx7bkvvRuUI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927866; c=relaxed/simple;
	bh=NyoI49MiWu2JlRuAZES9nkxzwWJr3057uoRzCMLHTn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ks+KdSGkzcSo47OSldfOhLhh4HmzUdCymOxnzvBTZ/SDrCi6El0cwi2fWQRL7yn2Bzo0NXBfl4m9cc43fUd/2b7Gebn7A9RCvpX9X0/tctC3MgVN/zCIJNhSbCTX/AJAXWoFM3wW5FHMpiMvRM75GWVm2Sf/uVa/VoqtkfQm+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=d/pzYgQ/; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 56a58bf801e711efb8927bc1f75efef4-20240424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tPXp6IY8q3S8Hp5LeJ8kB7ewIichTuen82oH0ZHu/V4=;
	b=d/pzYgQ/3xm+oYyIDMxtf0oK/jQKCNTdWQh3upyHFlI48nr65qFZ7+3QwgrCvEFg5PxBkUYZxkX2rsQn8WSnxgEzgDAmN2IL3w0MjSV1H1DAftWuTqv02nLQTAyjUto1tIS/2hl8fOsfiAG2uSHQ/0XY1/Sr6VmzxiIeUVo2Atc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:769782ce-816f-49d5-9c98-fded8ffef277,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:b7f40983-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 56a58bf801e711efb8927bc1f75efef4-20240424
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <olivia.wen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1973307455; Wed, 24 Apr 2024 11:04:17 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Apr 2024 11:04:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 Apr 2024 11:04:16 +0800
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
Subject: [PATCH v3 4/4] media: mediatek: imgsys: Support image processing
Date: Wed, 24 Apr 2024 11:03:51 +0800
Message-ID: <20240424030351.5294-5-olivia.wen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240424030351.5294-1-olivia.wen@mediatek.com>
References: <20240424030351.5294-1-olivia.wen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Integrate the imgsys core architecture driver for image processing on
the MT8188 platform.

Signed-off-by: Olivia Wen <olivia.wen@mediatek.com>
---
 include/linux/remoteproc/mtk_scp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/remoteproc/mtk_scp.h b/include/linux/remoteproc/mtk_scp.h
index 7c2b7cc9..344ff41 100644
--- a/include/linux/remoteproc/mtk_scp.h
+++ b/include/linux/remoteproc/mtk_scp.h
@@ -43,6 +43,7 @@ enum scp_ipi_id {
 	SCP_IPI_CROS_HOST_CMD,
 	SCP_IPI_VDEC_LAT,
 	SCP_IPI_VDEC_CORE,
+	SCP_IPI_IMGSYS_CMD,
 	SCP_IPI_NS_SERVICE = 0xFF,
 	SCP_IPI_MAX = 0x100,
 };
-- 
2.6.4


