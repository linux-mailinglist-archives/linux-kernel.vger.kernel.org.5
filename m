Return-Path: <linux-kernel+bounces-139721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B69C8A06D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0351281F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1995913BAFA;
	Thu, 11 Apr 2024 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qmcu2PT5"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5061E863;
	Thu, 11 Apr 2024 03:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806682; cv=none; b=nIcrE38cG0XZMUvWL5Zrk1I28RepmKG64yfUB08Zp+qL0Tenht7QrQ7ZUPGbk8sORmADccpNGvJ+LW40Pj/+xzzlK64Swdk3VfIf3XIDULEYeUsZgQfGX/OWmk9nxNLyEX5xXsiyW8Au6LAQmY5C+D1xVYDoUR1JyleoGT4xFsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806682; c=relaxed/simple;
	bh=W2vEuN0Ei8x0/EdhFQfiyxL+NFDgxyRT8X21TwtVGag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCfsgHIOsjqb46k/JqbvD3r2qLDp7aqVOCoYk8V8xppqyNyM5Ta5aXwaVrdLnNfLjE1MNAPJgWWxTVqyPgOftc3EqUsWSzxyYCjjJeQjfZ4Ut5zIk2iDwhyOKwkOFJUP8sMJx4L2y0UqCsJyWArwPmmxmn6/gBYNYIIvAdjPvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qmcu2PT5; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e2073562f7b411eeb8927bc1f75efef4-20240411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4N+27Nm7lzpsbnRVD5dNKXK3d/Iz5vY7gg+UaT2lqDo=;
	b=qmcu2PT5UCF5P3veoGWxfCElLw+uufE5ePW2fEEK+DIiqghu9/XOq6R0XdJPiy5teuicSRM1v+vSSshFqYsoqPYObe7MTrg5TFId2XBs8VxgwxPzDXNB+J27+AHzY1mHLoxXayUkDkOMCgSlcvF6r8AFf04EGrhUaleBC6kYKtg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:71c7f81c-d57b-4640-8712-32e0a4c84884,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:58760a86-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e2073562f7b411eeb8927bc1f75efef4-20240411
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <olivia.wen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 923527615; Thu, 11 Apr 2024 11:37:55 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 Apr 2024 11:37:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 11 Apr 2024 11:37:53 +0800
From: olivia.wen <olivia.wen@mediatek.com>
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
Subject: [PATCH 1/2] dt-bindings: remoteproc: mediatek: Support MT8188 dual-core SCP
Date: Thu, 11 Apr 2024 11:37:49 +0800
Message-ID: <20240411033750.6476-2-olivia.wen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240411033750.6476-1-olivia.wen@mediatek.com>
References: <20240411033750.6476-1-olivia.wen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Under different applications, the MT8188 SCP can be used as single-core
or dual-core.

Signed-off-by: olivia.wen <olivia.wen@mediatek.com>
---
 Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
index 507f98f..7e7b567 100644
--- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
@@ -22,7 +22,7 @@ properties:
       - mediatek,mt8192-scp
       - mediatek,mt8195-scp
       - mediatek,mt8195-scp-dual
-
+      - mediatek,mt8188-scp-dual
   reg:
     description:
       Should contain the address ranges for memory regions SRAM, CFG, and,
@@ -195,6 +195,7 @@ allOf:
         compatible:
           enum:
             - mediatek,mt8195-scp-dual
+            - mediatek,mt8188-scp-dual
     then:
       properties:
         reg:
-- 
2.6.4


