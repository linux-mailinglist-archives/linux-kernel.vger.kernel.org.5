Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D71F810A65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378617AbjLMGfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378592AbjLMGfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:35:54 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686FDB;
        Tue, 12 Dec 2023 22:35:55 -0800 (PST)
X-UUID: d97a61ee998111eeba30773df0976c77-20231213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=f3OU7CjnbH//nRBpQtLH2qmbYACQpUO/AoU+C4fdwSk=;
        b=cITbByqaRDolW3VOoU2HncXua8F+CWuO9+aYe+d5ayBKVaW64em2eCWSBKSm77u/5zfkUkNfvV8Ser7wsM5fv0LxFlE7c45/N2TsWGqAJpzptjw8ux7juS0ldqA9FgCKGo5OrLYFpZS6VWsfJxxXeb6Wmi8gAls0HecSPpegx/A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:b9941cd2-2956-4194-9d03-41790810c969,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:aa93bb73-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d97a61ee998111eeba30773df0976c77-20231213
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1180993719; Wed, 13 Dec 2023 14:35:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Dec 2023 14:35:45 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 13 Dec 2023 14:35:45 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 1/3] dt-bindings: usb: mtk-xhci: add a property for Gen1 isoc-in transfer issue
Date:   Wed, 13 Dec 2023 14:35:41 +0800
Message-ID: <20231213063543.12435-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.784700-8.000000
X-TMASE-MatchedRID: qeswZJixemc28LK855iUisp9Bgr5ONKhXxT5cg8K/td+YesuCgkiXLiN
        d7CXjOinEs/2xsX/gQY8osFhwSMl+G94Ipa1otxodARARTk4h595y+Nu7/EOOvHFoBcOsKez3yV
        lQmz6NJXYcj7A8ibVERc9sLlt0gKBwrxsKoa/qe0Q9/tMNQ4aijacujaE3jwhmyiLZetSf8mfop
        0ytGwvXiq2rl3dzGQ1eqPDNxZp5CwymZplauphdjnPhlbu/1N0Qxp+Se8vDj6zKqplBvusUA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.784700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 0140AD80CA739D4971F882E7ED6BC57CCD2352AD2BB0F20DF4AA9A0AD1D19CE32000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Gen1 isoc-in endpoint on controller before about SSUSB IPM v1.6.0, it
still send out unexpected ACK after receiving a short packet in burst
transfer, this will cause an exception on connected device, specially for
a 4k camera.
Add a quirk property "mediatek,rxfifo-depth" to work around this hardware
issue;
The side-effect is that may cause performance drop about 10%, including
bulk transfer.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index e9644e333d78..b8ed68574ba4 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -124,6 +124,16 @@ properties:
       defined in the xHCI spec on MTK's controller.
     default: 5000
 
+  mediatek,rxfifo-depth:
+    description:
+      It is a quirk flag used to work around Gen1 isoc-in endpoint transfer
+      issue that still send out unexpected ACK after device finish the burst
+      transfer with a short packet and cause an exception, specially on a 4K
+      camera device, it happens on controller before about IPM v1.6.0; the
+      side-effect is that may cause performance drop about 10%, include bulk
+      transfer.
+    type: boolean
+
   # the following properties are only used for case 1
   wakeup-source:
     description: enable USB remote wakeup, see power/wakeup-source.txt
-- 
2.25.1

