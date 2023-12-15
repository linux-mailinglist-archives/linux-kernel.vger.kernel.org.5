Return-Path: <linux-kernel+bounces-523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767FD81426D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2151F23AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C1BD30F;
	Fri, 15 Dec 2023 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t/PtFAc9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E910783;
	Fri, 15 Dec 2023 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 30daf7789b1c11eeba30773df0976c77-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wuqy1hMTeZu6Bp6O+Yhh2t/FfLhJ7df12NX9Rgk+tQ8=;
	b=t/PtFAc9i8U9RTUdwsU0natjryglq3g9UUtwekhx2DI/RSvWcI3jzbpac+M2pcBBo06U4kDOdiF2UzJBTgDS6YbAA+zQR7QASN8EkqGkdz3hk4w3RaTpba+fq/qKKAhAxNb2djS1Tj1rnJ1qoprPhoaCWqMXVQpryH/QOlx6+4E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:8accf49b-607d-4d86-9a1a-4763f165d3c0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:de81b4fd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 30daf7789b1c11eeba30773df0976c77-20231215
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 84030136; Fri, 15 Dec 2023 15:33:07 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 15:33:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 15:33:05 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ben Lok <ben.lok@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Arnd Bergmann <arnd@arndb.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH] arm64: dts: mediatek: mt8395-genio-1200-evk: add interrupt-parent for mt6360
Date: Fri, 15 Dec 2023 15:32:52 +0800
Message-ID: <20231215073252.21586-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.356500-8.000000
X-TMASE-MatchedRID: 1uypKmLkdmc6xeGwKgJtJov2/i8VNqeOh+w9Wz/xXDqdwU/qXYxHvE/3
	ZkXeY1OAsdosXJJWMVzBxVNeNzsv2R9J5bZqJbIJhK8o4aoss8oj3JVwc0NTtub59Kr2OlMmo8W
	MkQWv6iXBcIE78YqRWo6HM5rqDwqtEfvfpBK/uQoV1xzfrGKVLSvrrpz74+KsntWQqRKRLQ2l1b
	bYDEPZgxQSOnu3diL+lNiqWPzXo3LY9EVSutGyk/MY2/Am1+M74sOrsb4iT/K/bbEolHIgZUOc7
	GjOamnWv5a9cmIodEszD8HZ4XvJ2ZRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.356500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8D9319EFF555C22B70A702C8A5D19EAFDCBF723E3B96DD491DB3AED319B88BDB2000:8
X-MTK: N

This patch fix the warning introduced by mt6360 node in
mt8395-genio-1200-evk.dts.

arch/arm64/boot/dts/mediatek/mt8195.dtsi:464.4-27: Warning (interrupts_property): /soc/i2c@11d01000/pmic@34:#interrupt-cells: size is (8), expected multiple of 16

Add a missing 'interrupt-parent' to fix this warning.

Fixes: f2b543a191b6 ("arm64: dts: mediatek: add device-tree for Genio 1200 EVK board")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-devicetree/20231212214737.230115-1-arnd@kernel.org/
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index 70b465f7c6a7..00ac59a873e8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -238,6 +238,7 @@
 	mt6360: pmic@34 {
 		compatible = "mediatek,mt6360";
 		reg = <0x34>;
+		interrupt-parent = <&pio>;
 		interrupts = <128 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-names = "IRQB";
 		interrupt-controller;
-- 
2.18.0


