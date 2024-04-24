Return-Path: <linux-kernel+bounces-156191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3268AFF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE17A283CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874E9139573;
	Wed, 24 Apr 2024 03:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D933Vinz"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE4339A1;
	Wed, 24 Apr 2024 03:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927866; cv=none; b=Nn1GArESgKC6wj/hTIEpwi04tdg7l7TEnlF81AU576sAyg8dLBOCnlUqz8te2nxQ4a8E3lUm95jkRo1IX4cgh/SVmspGPuG+EWzf7YXvuvV8CUkz6JapUwgm0DC1lIENruanOZM/07ZsSXeu9FfLrWpbA5M8Ati6dGWOgYnRXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927866; c=relaxed/simple;
	bh=TxQHHD8ReW3yKrct5j+9dICT7Gj2PjIjiCUfAWik3tI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=at55p7Jc1jCmk8bvPcImhg1niBC1WZR8fLUfqERcy3W9YDUANKdRaNeAqziSTlVhqFkh0LZkXuItVoMRFzcpGqr5AOPv7NcjVzckKI+PiuvmPiHdHXPYPAkyejnORo8BhdJ6/BdDHI3v0xQU4LnUC8qvy3FOOZyCE9VVsvlKIp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=D933Vinz; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 575f6a6e01e711efb8927bc1f75efef4-20240424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YVDy5/ZsVM8z4DOMITGRoXpjJasjzOPGDsnn36hyu4g=;
	b=D933VinzE674GWPK/IWs01BE6LAX3dMgZRG6qLjIgy0UVZwQZzKR+0+AQM0q1d+aj75UWvn5cLjSAHXDUfp6yF5h9vobztapaDVzPZNyxmF7rxUa1ZqH/afrjpwooFLrL7C3fbkpjeHSyUQIn3WlK9AzqfuEMrMhOiUZoLrWwCw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:146e1982-69cf-45ff-a786-c3ae0b2e57e6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:80d646fb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 575f6a6e01e711efb8927bc1f75efef4-20240424
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <olivia.wen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 131397520; Wed, 24 Apr 2024 11:04:18 +0800
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
Subject: [PATCH v3 1/4] dt-bindings: remoteproc: mediatek: Support MT8188 dual-core SCP
Date: Wed, 24 Apr 2024 11:03:48 +0800
Message-ID: <20240424030351.5294-2-olivia.wen@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.711500-8.000000
X-TMASE-MatchedRID: eTEFbZ6VJO5jVtAwIy+afmHn2exfZC4LdER46uj876/oFeE5MSxNMeLz
	NWBegCW2wgn7iDBesS0nRE+fI6etkpar3ceJGClgN1rcfctnT3I4Cy/AjbisqpGJB31mduCgnJw
	vO47B+KCM47hkifH+EQ6x/CJdSYheO29r+zoVSuuTp+MobLNv/ICE5xpCtDRTUbJFyh4XXyqYo/
	TPOlMB4bCh3zE4wqa8DUCRr8oin+k=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.711500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 51EDF03EB993C1CB263B9901CEAEEBE8EED93A620167DDC423AC0563D5D95B982000:8
X-MTK: N

Under different applications, the MT8188 SCP can be used as single-core
or dual-core.

Signed-off-by: Olivia Wen <olivia.wen@mediatek.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---
 Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
index 507f98f..c5dc3c2 100644
--- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
@@ -19,6 +19,7 @@ properties:
       - mediatek,mt8183-scp
       - mediatek,mt8186-scp
       - mediatek,mt8188-scp
+      - mediatek,mt8188-scp-dual
       - mediatek,mt8192-scp
       - mediatek,mt8195-scp
       - mediatek,mt8195-scp-dual
@@ -194,6 +195,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - mediatek,mt8188-scp-dual
             - mediatek,mt8195-scp-dual
     then:
       properties:
-- 
2.6.4


