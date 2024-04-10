Return-Path: <linux-kernel+bounces-138352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327C789F00F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5630B1C2199D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC68159564;
	Wed, 10 Apr 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="S+C085kn"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712DC1552EF;
	Wed, 10 Apr 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745632; cv=none; b=fbTVQc6dPuinO6d8jb0Pe9fLrgvmMfXdWYK3eI+7Ziz5+IRnx8N0FAFd4HsHmp8Vd8CJWzJgIMgXr+t8glY2X2jo4L7bM1vM6lAKwHJAtp2AREEEOXwitWw1zWUSn7+IXSdzrCe3vbe1zdD9ONmLmoL5TcCOIrEWFMjsBmOyF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745632; c=relaxed/simple;
	bh=nmlI+1jg5aL2ruwfW6qmSVbZjwUzX5Rn62wwnZgu9RY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxxNMpPaL9NQH67P9slk8IuddW+vfWBocXMR5+tinp4BD45FaJiozI0SSGViwGXKfXqHgpLp6vvYVXXYcEoVKIR2OcO8RssaVXIQ1KkVhnkYImHaQNHSql50/8LFOsUSVJP9JUdNDHXd6Y4nSch3cQwTDId5IVUfaT4Itta36Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=S+C085kn; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bdead744f72611ee935d6952f98a51a9-20240410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IbvyZleKeBzCkSQwcR5/JyUse6gQVlPZjhR9xVr78M0=;
	b=S+C085kn1yqfCj88x8QZUlirtUkES7TSYul1woxoBAYbx5v3OB9X2ru6sP8ZkKHJ0DPS/rvaHOqwH85SNlpaPoM/GEQF/nrAMkJfVh9RlcUo/QjZvgD2Hd0E/3tzjWYDcghA8DAliDny+UkA1KpH3lzcTtRQiyVrH+Qt1cwfbZE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:499b88e8-4a3e-41cb-87d6-81c5e86dd057,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6f543d0,CLOUDID:4f960386-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: bdead744f72611ee935d6952f98a51a9-20240410
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1889807943; Wed, 10 Apr 2024 18:40:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Apr 2024 18:40:25 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Apr 2024 18:40:23 +0800
From: Zhi Mao <zhi.mao@mediatek.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Zhi Mao <zhi.mao@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Laurent Pinchart
	<laurent.pinchart+renesas@ideasonboard.com>, Heiko Stuebner
	<heiko@sntech.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil
	<hverkuil-cisco@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, Tomi
 Valkeinen <tomi.valkeinen@ideasonboard.com>, Alain Volmat
	<alain.volmat@foss.st.com>, Paul Elder <paul.elder@ideasonboard.com>, Mehdi
 Djait <mehdi.djait@bootlin.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bingbu Cao <bingbu.cao@intel.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<shengnan.wang@mediatek.com>, <yaya.chang@mediatek.com>,
	<yunkec@chromium.org>, <10572168@qq.com>
Subject: [PATCH 1/2] media: dt-bindings: i2c: add Giantec GT97xx VCM driver
Date: Wed, 10 Apr 2024 18:40:01 +0800
Message-ID: <20240410104002.1197-2-zhi.mao@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410104002.1197-1-zhi.mao@mediatek.com>
References: <20240410104002.1197-1-zhi.mao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add YAML device tree binding for GT97xx VCM driver,
and the relevant MAINTAINERS entries.

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 .../bindings/media/i2c/giantec,gt97xx.yaml    | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.yaml b/Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.yaml
new file mode 100644
index 000000000000..8c9f1eb4dac8
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) 2020 MediaTek Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/giantec,gt97xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Giantec Semiconductor, Crop. GT97xx Voice Coil Motor (VCM)
+
+maintainers:
+  - Zhi Mao <zhi.mao@mediatek.com>
+
+description: |-
+  The Giantec GT97xx is a 10-bit DAC with current sink capability.
+  The DAC is controlled via I2C bus that operates at clock rates up to 1MHz.
+  This chip integrates Advanced Actuator Control (AAC) technology
+  and is intended for driving voice coil lens in camera modules.
+
+properties:
+  compatible:
+    enum:
+      - giantec,gt9768 # for GT9768 VCM
+      - giantec,gt9769 # for GT9769 VCM
+
+  reg:
+    maxItems: 1
+
+  vin-supply: true
+
+  vdd-supply: true
+
+  giantec,aac-mode:
+    description:
+      Indication of AAC mode select.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 1    #  AAC2 mode(operation time# 0.48 x Tvib)
+      - 2    #  AAC3 mode(operation time# 0.70 x Tvib)
+      - 3    #  AAC4 mode(operation time# 0.75 x Tvib)
+      - 5    #  AAC8 mode(operation time# 1.13 x Tvib)
+    default: 2
+
+  giantec,aac-timing:
+    description:
+      Number of AAC Timing count that controlled by one 6-bit period of
+      vibration register AACT[5:0], the unit of which is 100 us.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x20
+    minimum: 0x00
+    maximum: 0x3f
+
+  giantec,clock-presc:
+    description:
+      Indication of VCM internal clock dividing rate select, as one multiple
+      factor to calculate VCM ring periodic time Tvib.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0    #  Dividing Rate -  2
+      - 1    #  Dividing Rate -  1
+      - 2    #  Dividing Rate -  1/2
+      - 3    #  Dividing Rate -  1/4
+      - 4    #  Dividing Rate -  8
+      - 5    #  Dividing Rate -  4
+    default: 1
+
+required:
+  - compatible
+  - reg
+  - vin-supply
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        vcm@c {
+            compatible = "giantec,gt9768";
+            reg = <0x0c>;
+
+            vin-supply = <&gt97xx_vin>;
+            vdd-supply = <&gt97xx_vdd>;
+            giantec,aac-timing = <0x20>;
+        };
+    };
+
+...
-- 
2.25.1


