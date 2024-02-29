Return-Path: <linux-kernel+bounces-86052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061E386BF09
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACBD1F223B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E0138DEA;
	Thu, 29 Feb 2024 02:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="A8YcOTyF"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703D376E1;
	Thu, 29 Feb 2024 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709174141; cv=none; b=NawaS1qfHscLH8kqQ0bY1itgsxEG2fMScafGUaOgQh0afEyyjgtzCI6A4TtR+grmYOo4o3eVTp5GleFmK8Y97Aox3GuCP5IM4ukSe1IfSboybDyf9q+aDQ+P5egM5i8yADEiI3zwYaog8ZjfTytwMfFfzdUytd9/wiFP8WCKOwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709174141; c=relaxed/simple;
	bh=DEJVmXvo6At2KdWVj+pMijxpweSuAOBybt4Kn54ieRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s45T7WWgZ7Yuf+vkSSGxbPGF5CtBAJkgor1DFZO9x7UV3XVbbqJGVL9RVbB9dGrQRCwG5R76jXZ8cvXhBfzaS4UP+28wEuvuB3GDQk+HQ8pnEbhCNXWAS5fKgeEC3zK5pC1b5IATZa5PrCJ2r2npvKwvlhiTPTWpNcxXlwCCgBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=A8YcOTyF; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 32544148d6ab11ee935d6952f98a51a9-20240229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=siodBAxe3jUCZrekllMPYZtT9MUfipocRXBozlziOE8=;
	b=A8YcOTyFl4kBo/wJlvI6NJ38kGOcdYNkEg+O5zzaq4nejcNeXWCfZzqoboC2IFC/7kD+ymHomA00hWigOGSB40W76AKhnX7WQhFkCrDTmm6GYjPbJjBz15fr6MCwqMvPcY5saaGtao6mfAkC0fQ59ygycOExrLWDDPJ1L6x7zCo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c976b97c-2ee2-4313-823b-28ac563e1edd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:ed016e84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 32544148d6ab11ee935d6952f98a51a9-20240229
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 971676650; Thu, 29 Feb 2024 10:35:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Feb 2024 10:35:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 29 Feb 2024 10:35:24 +0800
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
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, "Nancy
 Lin" <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Fei Shao
	<fshao@chromium.org>
Subject: [PATCH 1/3] dt-bindings: display: mediatek: gamma: Change MT8195 to single enum group
Date: Thu, 29 Feb 2024 10:35:20 +0800
Message-ID: <20240229023522.15870-2-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240229023522.15870-1-jason-jh.lin@mediatek.com>
References: <20240229023522.15870-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-0.572500-8.000000
X-TMASE-MatchedRID: oTn/OBj9AQ9nI6of4eefuQPZZctd3P4Bw8djaG0FrZu+pmoxzV3exqPF
	jJEFr+olwXCBO/GKkVr3FLeZXNZS4IzHo47z5Aa+gVKopVj7xjuRonGTfTkJZD4EzjOU/EVrj9s
	GszqT+V0l8T+a+xOPOoqQ9E/6HR7c2mNZXsYhBSMeg2EPxk5i2qr2rQs5XG7QeZUpm6wun3ba/0
	6NhYDa4wyzCDjlUx89p2y3mIB+it/DyDYcE1wXmQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-0.572500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: D227AF03FD96C1C6792B7CFC21F09EC2EDF623B826802693F40BCA39B067FE412000:8
X-MTK: N

Since MT8195 gamma has multiple bank for 12 bits LUT and it is
different from any other SoC LUT setting.

So we move MT8195 compatible from the one of items to the
single enum group.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,gamma.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
index c6641acd75d6..3e6cb8f48bcc 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
@@ -24,6 +24,7 @@ properties:
       - enum:
           - mediatek,mt8173-disp-gamma
           - mediatek,mt8183-disp-gamma
+          - mediatek,mt8195-disp-gamma
       - items:
           - enum:
               - mediatek,mt6795-disp-gamma
@@ -33,7 +34,6 @@ properties:
               - mediatek,mt8186-disp-gamma
               - mediatek,mt8188-disp-gamma
               - mediatek,mt8192-disp-gamma
-              - mediatek,mt8195-disp-gamma
           - const: mediatek,mt8183-disp-gamma
 
   reg:
-- 
2.18.0


