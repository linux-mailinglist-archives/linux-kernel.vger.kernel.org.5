Return-Path: <linux-kernel+bounces-30820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEE78324A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A391F22444
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC56D518;
	Fri, 19 Jan 2024 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sUZqtrfC"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04473214;
	Fri, 19 Jan 2024 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705645960; cv=none; b=JXJvGJLCgNx4v3q7p8dNYZYWvNBnvAA9rakSnOV+jhmtZKkFHdW+LuMDdizl1iu80YRqAfXoRqbhIT+N6NXMdWaHU7YgVbZDRF5pSuT9UajuACtDYZb9ZprUwpq15SePONN0HBfE/REQUerH5+y5K0rCBOAN7js/zU1QPw9u474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705645960; c=relaxed/simple;
	bh=XAe25R1TLx5SEWPyIwO6YRLxYKOOi3yEHOmv8aJSDjI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgLDIEVHavFmTnTKvN0n6OqVieXS4DnBLiq60j9puB//pEP9ALCgz9Dl5e50ylfhs2/9H+37WM2ofjOq6BoHHkljJ4GRPNE2fNz/wFi3q3noUdkTJhlkRNvW104XQNmLK3T0OEOr12FmxsJy/V5lPeOGZ5bDDzAAoyaswRu964g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sUZqtrfC; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 83185c0eb69411eea2298b7352fd921d-20240119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FwGx9t8Ya6K6n4RmygSg+WES02bkxAi+xN+PSkJnWU0=;
	b=sUZqtrfC0pMroa0QePz2g6QAzOJZ16rtq7O0ZG7oEOzQCY4DfVvCoU04GKOCloLfsUSYM8TZIPJ3DMQl4RuBXZxNQcEeE3nNoqhgUBKSZwXzE4rWLWepjbGeT5SHzxqVvRFCVmQll+s26+OR5D9uG0WwObd6cL6NtTDGvj7IG7I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:44722500-8e34-4204-b688-5861e177423a,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6e16cf4,CLOUDID:85ca0583-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 83185c0eb69411eea2298b7352fd921d-20240119
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1191493499; Fri, 19 Jan 2024 14:32:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 Jan 2024 14:32:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 19 Jan 2024 14:32:25 +0800
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
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3 1/3] dt-bindings: mailbox: Add mediatek,gce-props.yaml
Date: Fri, 19 Jan 2024 14:32:22 +0800
Message-ID: <20240119063224.29671-2-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240119063224.29671-1-jason-jh.lin@mediatek.com>
References: <20240119063224.29671-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Add mediatek,gce-props.yaml for common GCE properties that is used for
both mailbox providers and consumers. We place the common property
"mediatek,gce-events" in this binding currently.

The property "mediatek,gce-events" is used for GCE event ID corresponding
to a hardware event signal sent by the hardware or a sofware driver.
If the mailbox providers or consumers want to manipulate the value of
the event ID, they need to know the specific event ID.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 .../bindings/mailbox/mediatek,gce-props.yaml  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gce-props.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-props.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-props.yaml
new file mode 100644
index 000000000000..68b519ff089f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-props.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/mediatek,gce-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Global Command Engine Common Propertes
+
+maintainers:
+  - Houlong Wei <houlong.wei@mediatek.com>
+
+description:
+  The Global Command Engine (GCE) is an instruction based, multi-threaded,
+  single-core command dispatcher for MediaTek hardware. The Command Queue
+  (CMDQ) mailbox driver is a driver for GCE, implemented using the Linux
+  mailbox framework. It is used to receive messages from mailbox consumers
+  and configure GCE to execute the specified instruction set in the message.
+  We use mediatek,gce-mailbox.yaml to define the properties for CMDQ mailbox
+  driver. A device driver that uses the CMDQ driver to configure its hardware
+  registers is a mailbox consumer. The mailbox consumer can request a mailbox
+  channel corresponding to a GCE hardware thread to send a message, specifying
+  that the GCE thread to configure its hardware. The mailbox provider can also
+  reserved a mailbox channel to configure GCE hardware register by the spcific
+  GCE thread. This binding defines the common GCE properties for both mailbox
+  provider and consumers.
+
+properties:
+  mediatek,gce-events:
+    description:
+      GCE has an event table in SRAM, consisting of 1024 event IDs (0~1023).
+      Each event ID has a boolean event value with the default value 0.
+      The property mediatek,gce-events is used to obtain the event IDs.
+      Some gce-events are hardware-bound and cannot be changed by software.
+      For instance, in MT8195, when VDO0_MUTEX is stream done, VDO_MUTEX will
+      send an event signal to GCE, setting the value of event ID 597 to 1.
+      Similarly, in MT8188, the value of event ID 574 will be set to 1 when
+      VOD0_MUTEX is stream done.
+      On the other hand, some gce-events are not hardware-bound and can be
+      changed by software. For example, in MT8188, we can set the value of
+      event ID 855, which is not bound to any hardware, to 1 when the driver
+      in the secure world completes a task. However, in MT8195, event ID 855
+      is already bound to VDEC_LAT1, so we need to select another event ID to
+      achieve the same purpose. This event ID can be any ID that is not bound
+      to any hardware and is not yet used in any software driver.
+      To determine if the event ID is bound to the hardware or used by a
+      software driver, refer to the GCE header
+      include/dt-bindings/gce/<chip>-gce.h of each chip.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 1024
+
+additionalProperties: true
-- 
2.18.0


