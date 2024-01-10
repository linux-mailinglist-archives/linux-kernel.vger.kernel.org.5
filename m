Return-Path: <linux-kernel+bounces-21747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE8A8293B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CAC1C255E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DDC3588B;
	Wed, 10 Jan 2024 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="j0ZyMil9"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA497F7;
	Wed, 10 Jan 2024 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 75d85238af8211ee9e680517dc993faa-20240110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lcCbFNmFcDjwLfDNroezfdb2otTHOVj9cqaCJYHFNhE=;
	b=j0ZyMil9PVCSqZ9LqVklLMgmoPOQPflW/GrCgY/CD2t4uhrzcj2lF4MS4c9DuEdwr2r0ETC0ubBhCHIxj+l2zjlXbTJIykGeEnWeWA+VS8Y81By+RDlWMx/z9spEqrXjylBlyafqYLZMR2psiF0E7eS0BHpN29GMgqwCaFPsjAc=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.35,REQID:fafce948-1d83-4735-99dd-61d6953ffdfe,IP:0,U
	RL:25,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Spam_GS6885AD,AC
	TION:quarantine,TS:125
X-CID-META: VersionHash:5d391d7,CLOUDID:eac02f7f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:801,TC:nil,Content:3,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 75d85238af8211ee9e680517dc993faa-20240110
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2035505861; Wed, 10 Jan 2024 14:35:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Jan 2024 14:35:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Jan 2024 14:35:33 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Jason-ch Chen
	<jason-ch.chen@mediatek.com>, Johnson Wang <johnson.wang@mediatek.com>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>, Singo Chang
	<singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, Shawn Sung
	<shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2 2/4] dt-bindings: mailbox: mediatek: gce-mailbox: Add reference to gce-props.yaml
Date: Wed, 10 Jan 2024 14:35:30 +0800
Message-ID: <20240110063532.14124-3-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240110063532.14124-1-jason-jh.lin@mediatek.com>
References: <20240110063532.14124-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.735000-8.000000
X-TMASE-MatchedRID: y/MOm6ldwRK5u1dzaqGIEwPZZctd3P4BKhNpTcvbdUJa2Ghz+vIal7l+
	75cRptKm8izX0ZvrybNpuwczjzvbdUBduJGafVsPngIgpj8eDcCbifj2/J/1cS8z+bJ2nm9UKra
	uXd3MZDWHa3kXaoLg85MEyCAdbSnUTBw+1q+L/poFcTh9oTEFS2weV3hBhNXz31op4IqnOD3MfH
	kOT6w0ZV8j6O98Ee9zo7hK7NXLqvRBLAb/FTpmUnQE0HbT5LEft/yYljnuhl10loENhqV3WYc7S
	1VgNXhPQwymtxuJ6y0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.735000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 2D8C7380F05ECC953BF4EE69CDC11939361AFA394D3B83209CFBD993FB8E7A102000:8
X-MTK: N

1. Add "Provider" to the title to make it clearer.
2. Add reference to gce-props.yaml for adding mediatek,gce-events property.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 .../devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml   | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
index cef9d7601398..728dc93117a6 100644
--- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek Global Command Engine Mailbox
+title: MediaTek Global Command Engine Mailbox Provider
 
 maintainers:
   - Houlong Wei <houlong.wei@mediatek.com>
@@ -57,6 +57,8 @@ required:
   - clocks
 
 allOf:
+  - $ref: mediatek,gce-props.yaml
+
   - if:
       not:
         properties:
@@ -67,7 +69,7 @@ allOf:
       required:
         - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.18.0


