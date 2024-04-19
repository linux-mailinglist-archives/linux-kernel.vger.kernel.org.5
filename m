Return-Path: <linux-kernel+bounces-151182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 971ED8AAAB9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24360B21CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A1745C3;
	Fri, 19 Apr 2024 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L9oiBrfW"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86F4CE05;
	Fri, 19 Apr 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713516152; cv=none; b=itYnxLGmEFqAQq0R1OTpC6VxpASnXIvfUlrnuoi3ZX0fBYujiQuIJ/27efGY698OPIZtwSJoETiXPD1KrE5Sx9CYLdHPocxAS0LkOAPdCraIhZITlWhW+72JHh+5nHkeFUK21YTemotTeIWhArwdHY1dYrrlr3/NytrLueNqX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713516152; c=relaxed/simple;
	bh=UyrmLszsuXov/+2qgDCcmG8ktxC+PNXx0eC/GFzlhgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgJwaLp04A9vupL0T2ZfZk+OgLcZIisHTZq025mERgujQGcyr0o0lOyEQh5SdgYshGF8NP4iraO1etB9dqJrFJgATy0DTmBLHxdBKl1a9/GLFk8HXG4clGTBfd0Dxs6uXP1a+W49HekHHDdkovym07SKeR+PwR8MSedTRdN6Z4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=L9oiBrfW; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bf8052c4fe2811eeb8927bc1f75efef4-20240419
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eAv7xsk4dMZg8O12CSjg7d5I237JEwcCQAw88TJ7XB8=;
	b=L9oiBrfWmhDUFUxUvUlia7Ib0BRO3e68m05gBqsFlZC4kCKeRFhQqK5LSYvsgDYabp9uLMMNafYdb87c70clCWeFm3fOEd7dQAiEVpZCgMaiME/A6yMefDjFRLHEmk5bPYnDwW1+g/Ibu8I9CIbn+29CIAg7rpQ9fCu6jl2VI2s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:feac5a27-ab46-4ab4-a8de-e708b384caf3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:8ef71bfb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bf8052c4fe2811eeb8927bc1f75efef4-20240419
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <olivia.wen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 58277498; Fri, 19 Apr 2024 16:42:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
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
Subject: [PATCH v2 1/2] dt-bindings: remoteproc: mediatek: Support MT8188 dual-core SCP
Date: Fri, 19 Apr 2024 16:42:10 +0800
Message-ID: <20240419084211.31901-2-olivia.wen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240419084211.31901-1-olivia.wen@mediatek.com>
References: <20240419084211.31901-1-olivia.wen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.679300-8.000000
X-TMASE-MatchedRID: UHRyBqsVSvp0BEBFOTiHn1QQ0EgzIoPRmyiLZetSf8mfop0ytGwvXiq2
	rl3dzGQ1Km7bFwpLlIgo10iBMPAt5xGQBR4wbgQDfi9EVwd+Ihh6foJpzBXqTqbAGcRZbBzXfVV
	OfiWwENdvy5usIFo8Mc5bvLLRwMDNndCRkxk0cZt0BNB20+SxH7f8mJY57oZddJaBDYald1lvF9
	+X2GEIHA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.679300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: AA43DF781759B6C48867241917EB748AAE5CC2A08526FD2F677B4151BB1D102E2000:8
X-MTK: N

From: "olivia.wen" <olivia.wen@mediatek.com>

Under different applications, the MT8188 SCP can be used as single-core
or dual-core.

Signed-off-by: olivia.wen <olivia.wen@mediatek.com>
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


