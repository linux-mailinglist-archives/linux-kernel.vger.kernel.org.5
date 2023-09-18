Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8CE7A3FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 05:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbjIRDSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbjIRDSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:18:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB084F3;
        Sun, 17 Sep 2023 20:18:43 -0700 (PDT)
X-UUID: 1060a70c55d211eea33bb35ae8d461a2-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/f0FWQQmGWpBocKW+qX2qbxtis9/UWN4Enze7PcjHNk=;
        b=HaW0a/qEEsLRW+sT0d9OrmrgK9IR4dfelA8EhOS3NfUIUR+8pWcm6h9Ff+BSCu/UAMY0084CGYhTI2nx166PX7XF0/+E3zmRwHjJ9UDzeMlrz0D2jXD3CPhguUT3VVWKZxpwY2kEahx6RYEl05D9Vs8hz1jHnYILbIVAMvqaX9s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:448a5e10-9f33-48d8-958d-62962391898f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:7f1e0d14-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1060a70c55d211eea33bb35ae8d461a2-20230918
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1039299557; Mon, 18 Sep 2023 11:18:40 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 11:18:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 11:18:36 +0800
From:   Mark Tseng <chun-jen.tseng@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <chun-jen.tseng@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: soc: mediatek: add mt8188 svs dt-bindings
Date:   Mon, 18 Sep 2023 11:18:34 +0800
Message-ID: <20230918031835.12352-2-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230918031835.12352-1-chun-jen.tseng@mediatek.com>
References: <20230918031835.12352-1-chun-jen.tseng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.863000-8.000000
X-TMASE-MatchedRID: jhJi18RLqAJlrtpBkGUSk3QEQEU5OIefVBDQSDMig9GbKItl61J/yfJv
        ocwUrWp7FBpuM64i9KELbigRnpKlKZvjAepGmdoOdAywR1wkKlzCHJ7H4vPayagNGRLfssaoeW0
        M28aVtT+D4dBJSMcs6ArxDXKl5vtoTovWvmZjkMxEVmI4rJJgPJzhjrfzErKlSZrfNhP3sgUBh9
        AgBSEFrJm+YJspVvj2xkvrHlT8euJ0YHKn7N1oOA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.863000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5AB670023500A9E1E52BB83F17731F595DEFE465D0C7632E3508E005A48586312000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt8188 svs compatible in dt-bindings.

Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
---
 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
index f21eb907ee90..7eda63d5682f 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
@@ -22,6 +22,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt8183-svs
+      - mediatek,mt8188-svs
       - mediatek,mt8192-svs
 
   reg:
-- 
2.18.0

