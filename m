Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1E880BFAD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjLKC4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKC4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:56:31 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A485BCE;
        Sun, 10 Dec 2023 18:56:33 -0800 (PST)
X-UUID: e166d0de97d011eea5db2bebc7c28f94-20231211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=cV6riP0Ow3bKYWIQlnMOTDlEkCQ8oQ7sgKAuWFgdgY4=;
        b=X1clbtpVx7GagyIQVEFgpQjRHJvp5ECvLto8GaNbHHoWbkpLCnWOr0btlwetlO29Dinn1YDOeY2WGNgQV7Z7gHB0ix3am/vz2X12kTbVcgqdkuwQzilnx6auEQ5BvaaUmgv0/YNoXY9LXsghA6N0lH8wIfJM9WNeACHnt5HmHHU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:7ee2fb62-41cf-48af-8961-e35025077681,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:3bc1a173-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e166d0de97d011eea5db2bebc7c28f94-20231211
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 102566418; Mon, 11 Dec 2023 10:56:28 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Dec 2023 10:56:26 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Dec 2023 10:56:26 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Macpaul Lin <macpaul.lin@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: mediatek: tphy: add a property for force-mode switch
Date:   Mon, 11 Dec 2023 10:56:23 +0800
Message-ID: <20231211025624.28991-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.360500-8.000000
X-TMASE-MatchedRID: RRfbWjdhZrr4Q348LKfXOO7KTDtx8CggtjHGWON8yeP9Ez/5IpHqp/pZ
        jWQiqBlh8/nBmhGQ+G7kiLqWsGi3RpShxRaS8Dn10FfSApnujPiAfODDLypXmtzOQo7mTgA+FVk
        w4X07kmjaFM5TPGLdCHBSByhCpcr+QdZuZ42vrpFu4W5gEinK6fMfibAjlaopIZUd3wirJi2jxY
        yRBa/qJcFwgTvxipFajoczmuoPCq0+xoUgd8obQZ05FFJdMwGG0mrAuei0ALC9AvG/HBY0xoHcO
        amUia0t
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.360500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 10541A3B766F5DABAF750EE74B7A1B24E217417B7A2FC9C7B112FDA6E978F3FF2000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to some old SoCs with shared t-phy between usb3 and pcie only support
force-mode switch, and shared and non-shared t-phy may exist at the same
time on a SoC, can't use compatible to distinguish between shared and
non-shared t-phy, add a property to supported it.
Currently, only support switch from default pcie mode to usb3 mode.
But now prefer to use "mediatek,syscon-type" on new SoC as far as possible.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: modify commit message, and property description 
---
 Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
index 2bb91542e984..acba0720125d 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
@@ -235,6 +235,15 @@ patternProperties:
           Specify the flag to enable BC1.2 if support it
         type: boolean
 
+      mediatek,force-mode:
+        description:
+          The force mode is used to manually switch the shared phy mode between
+          USB3 and PCIe, when USB3 phy type is selected by the consumer, and
+          force-mode is set, will cause phy's power and pipe toggled and force
+          phy as USB3 mode which switched from default PCIe mode. But perfer to
+          use the property "mediatek,syscon-type" for newer SoCs that support it.
+        type: boolean
+
       mediatek,syscon-type:
         $ref: /schemas/types.yaml#/definitions/phandle-array
         maxItems: 1
-- 
2.18.0

