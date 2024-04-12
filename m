Return-Path: <linux-kernel+bounces-142087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818F58A2765
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52201C21356
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE3554BF4;
	Fri, 12 Apr 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OJ+ZTZFM"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8734E1DD;
	Fri, 12 Apr 2024 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905079; cv=none; b=pahYEvF0yrNEvlbD7YRFb8CP87wPmeowZTeGcVZuEQgk6S8ETuo2YG34AfKAZUOn2PFWZLmT5rJli1uohfFuXN8pFv9Qy0DeUUZ5QRu5nxaP8opWXfoRnn1h/vtR3b0Am61hsAEsyXVHlYbMfTxtgAM9IdhDk0dX1A08mUpjROc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905079; c=relaxed/simple;
	bh=FUpETsFgu8pQoCUAi/idXmabQsHYEbi/gDmd3xqHUY8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vd3PLC0crMyUN9oIvRelP/lKdP4WBw2aH3SsAGhZDUhHIcVYuzE3Q4AfWUTsWtHTHoY8lYL2WPPF8c1Ul5wdeu9vNh6vyGZkyIK/RgyoXIiE60RHflCW8zlEg51MsUXG415QQpF57KRX6iQExHhVcoYVfWI2X1yZQK8IR+OrAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OJ+ZTZFM; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f843e826f89911eeb8927bc1f75efef4-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AiR6hdy4wlQ6FRlbcH1KPtOUfNUNeCb2g6btveoZqFQ=;
	b=OJ+ZTZFMz00qKLCssGDFUptfjMRZzQT41uMGmIBpkpECLnsCJlrjH7X6bYwRAIcKuJmmdA4HrXPO49S/cw+inu1ldYGellTBAxVYGkoSsB2iAHbevhsrmfz/V20HZQ2DbFqLZwXtY2SPh0B8GjeYbC8NfscloRYhN7E2+x4O9a8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:764619f5-837e-42c0-902e-2e2a315deac6,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6f543d0,CLOUDID:854a9782-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f843e826f89911eeb8927bc1f75efef4-20240412
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1534360413; Fri, 12 Apr 2024 14:57:47 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 14:57:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 14:57:44 +0800
From: Yi-De Wu <yi-de.wu@mediatek.com>
To: Yingshiuan Pan <yingshiuan.pan@mediatek.com>, Ze-Yu Wang
	<ze-yu.wang@mediatek.com>, Yi-De Wu <yi-de.wu@mediatek.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-mediatek@lists.infradead.org>, David Bradil
	<dbrazdil@google.com>, Trilok Soni <quic_tsoni@quicinc.com>, My Chuang
	<my.chuang@mediatek.com>, Shawn Hsiao <shawn.hsiao@mediatek.com>, PeiLun Suei
	<peilun.suei@mediatek.com>, Liju Chen <liju-clr.chen@mediatek.com>, "Willix
 Yeh" <chi-shen.yeh@mediatek.com>, Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: [PATCH v10 03/21] dt-bindings: hypervisor: Add MediaTek GenieZone hypervisor
Date: Fri, 12 Apr 2024 14:57:00 +0800
Message-ID: <20240412065718.29105-4-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240412065718.29105-1-yi-de.wu@mediatek.com>
References: <20240412065718.29105-1-yi-de.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.112700-8.000000
X-TMASE-MatchedRID: YXgS1C6OPWzHCChNBbZThW3NvezwBrVmUXlp1FHYSPVfSPKGP39CrlYW
	wxB9tw0TJhXAZMA4h8Vncviyus0oC5/JE/eOMuX3vGTc5oROod7rpC+cgGEjuhHfiujuTbedOOF
	xXXPqKHnyga3Otdj4UogmzRSnu+RYqjvsBy5CHDu4jAucHcCqnZYcYQ11P5U/m5zZfbOy37EOsb
	dDU8hPqApsQGG0bIwTwKX8fpO+yjIFvymnGwMQKcgc0seoKgtWDcK8n+cR7XKbKItl61J/yUGDD
	kbg1gJk32mPO5tnascgBwKKRHe+r4Tmrs6kIqRYDHUdSdBtRVeFr2eUKstlg95yxw2xiJGmTC56
	0xUyzIQ=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.112700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9DE13550BABBE4B27820AF5D7E56489CBDF4740A6B5978BE7A30613916C11B812000:8
X-MTK: N

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

Add documentation for GenieZone(gzvm) node. This node informs gzvm
driver to start probing if geniezone hypervisor is available and
able to do virtual machine operations.

[Reason to use dt solution]
- The GenieZone hypervisor serves as a vendor model for facilitating
platform virtualization, with an implementation that is independent
from Linuxism.
- In contrast to the dt solution, our previous approach involved probing
via hypercall to determine the existence of our hypervisor. However, this
method raised concerns about potentially impacting all systems, including
those without the GenieZone hypervisor embedded[ref].

Link: https://lore.kernel.org/all/2fe0c7f9-55fc-ae63-3631-8526a0212ccd@linaro.org/

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 .../hypervisor/mediatek,geniezone-hyp.yaml    | 31 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml

diff --git a/Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml b/Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml
new file mode 100644
index 000000000000..ab89a4c310cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hypervisor/mediatek,geniezone-hyp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek GenieZone hypervisor
+
+maintainers:
+  - Yingshiuan Pan <yingshiuan.pan@mediatek.com>
+
+description:
+  This interface is designed for integrating GenieZone hypervisor into Android
+  Virtualization Framework(AVF) along with Crosvm as a VMM.
+  It acts like a wrapper for every hypercall to GenieZone hypervisor in
+  order to control guest VM lifecycles and virtual interrupt injections.
+
+properties:
+  compatible:
+    const: mediatek,geniezone-hyp
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    hypervisor {
+        compatible = "mediatek,geniezone-hyp";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0cda103140b4..0d1e5d127929 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9180,6 +9180,7 @@ GENIEZONE HYPERVISOR DRIVER
 M:	Yingshiuan Pan <yingshiuan.pan@mediatek.com>
 M:	Ze-Yu Wang <ze-yu.wang@mediatek.com>
 M:	Yi-De Wu <yi-de.wu@mediatek.com>
+F:	Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml
 F:	Documentation/virt/geniezone/
 
 GENWQE (IBM Generic Workqueue Card)
-- 
2.18.0


