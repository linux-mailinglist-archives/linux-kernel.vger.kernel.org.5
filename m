Return-Path: <linux-kernel+bounces-120351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FCC88D629
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D35A1F2A0B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBB222F0C;
	Wed, 27 Mar 2024 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AdoOzG1W"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6177224EF;
	Wed, 27 Mar 2024 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711519064; cv=none; b=X5v9kZ6E+Pn2SanJOVVGA0fhRObaKqj0XTPF7tqxbj2o07iaZ7qCDToMj7nti/CVBwBNlb1Yv1RSHg6vcA2DVI4w37EpuFo4v5N8+1HHmbu80+72z8vp+fl0XKvGRJziaGU+EV6PtFYu3ifdDBnFxY/JHJQV8bFNiFpKkhRUtYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711519064; c=relaxed/simple;
	bh=/0EvIoS4FoeQBZKeWVIpuWw0C4MKZXMmkpRB2++22RI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oW//8O/gWze26uoqDRlHvgSe4n//gEkaHJzLwrm1QnJDg0p1uJbeGW5kg2/2VuXMgVBG+amwwluFf70wVY7nJkfDWpTHUQRil/0uarqid5XGNOCCPU6MnhuXtqUCyGKQI8bNvhnrAJSVyHDHcEWb9foVVbDywQmY69iZEBHH4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AdoOzG1W; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e916456cebfe11eeb8927bc1f75efef4-20240327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/2eLA/TH/ne/YsQmVXep4OzHNxDnmZn9sfsjEtn7A8g=;
	b=AdoOzG1WL8wqwnGWoL5L4CJkSqpmhxC34y+eVKyez1LyEldkjbCNprhNrVcPUn32OIkywzs1P8kbVcdeYmgUPVZiGrtZUUHoc46GV+KsZ8WrRFGb4btPsAinprcKlQd1yDArfg2TRCMM4bzZ3xUAxi7R6e6penZaSU0CFiIEKIg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:9be3e245-8492-44e3-a557-b50670007332,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:1460fb81-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e916456cebfe11eeb8927bc1f75efef4-20240327
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <yu-chang.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 152260002; Wed, 27 Mar 2024 13:57:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Mar 2024 13:57:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Mar 2024 13:57:34 +0800
From: yu-chang.lee <yu-chang.lee@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Ulf
 Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, MandyJH
 Liu <mandyjh.liu@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, <fan.chen@mediatek.com>,
	<xiufeng.li@mediatek.com>, <yu-chang.lee@mediatek.com>
Subject: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb definition
Date: Wed, 27 Mar 2024 13:57:31 +0800
Message-ID: <20240327055732.28198-3-yu-chang.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240327055732.28198-1-yu-chang.lee@mediatek.com>
References: <20240327055732.28198-1-yu-chang.lee@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Add Smart Multimedia Interface Local Arbiter to mediatek
power domain.

Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>
---
 .../devicetree/bindings/power/mediatek,power-controller.yaml  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 8985e2df8a56..228c0dec5253 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -125,6 +125,10 @@ $defs:
         $ref: /schemas/types.yaml#/definitions/phandle
         description: phandle to the device containing the SMI register range.
 
+     mediatek,larb:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to the device containing the LARB register range.
+
     required:
       - reg
 
-- 
2.18.0


