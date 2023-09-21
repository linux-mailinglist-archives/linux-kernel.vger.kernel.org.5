Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A65D7A9622
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjIUQ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIUQ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:56:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7899E11A;
        Thu, 21 Sep 2023 09:56:24 -0700 (PDT)
X-UUID: 7a5dfc26584411eea33bb35ae8d461a2-20230921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hSKenHqHk4SnkzETMsc5fhZOH0K/HS/Ef7FZfrvVwHQ=;
        b=kZjkJeLvfbqrefsLKCKRMOgAXcrSIwJ4GTiSBvsWsEaZy5+0ok14mzF1Q7TFmOqwiB7e8e7OWBhEb1bB9WeZUEYXZvxpXwxGAPw83gZLq52J3C86w/Dz1d+niONkEWJTnGNd/EGkMuaJgmnH9qOOaYpTGaoi6mQlwjggC64su2M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:329ca6ba-c8e0-4d44-9bf4-171847448450,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:308448c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7a5dfc26584411eea33bb35ae8d461a2-20230921
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1910738219; Thu, 21 Sep 2023 14:02:42 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Sep 2023 14:02:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Sep 2023 14:02:39 +0800
From:   Jason-ch Chen <jason-ch.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        jason-ch chen <Jason-ch.Chen@mediatek.com>
Subject: [RESEND PATCH v4 1/4] dt-bindings: arm: Add compatible for MediaTek MT8188
Date:   Thu, 21 Sep 2023 14:02:32 +0800
Message-ID: <20230921060235.32478-2-jason-ch.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230921060235.32478-1-jason-ch.chen@mediatek.com>
References: <20230921060235.32478-1-jason-ch.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.837000-8.000000
X-TMASE-MatchedRID: EJLkrvRJ8yyQwm5+b+ZNPYv73wEu0Nx76SXuwUgGH0iyrCkM9r1bWjcG
        i0cOVVas5o/rYvVL+ieAMuqetGVetnyef22ep6XYymsk/wUE4hqGRDOcbb3m4Luw5dWU7dCvgNK
        kns7LOKC9USxFcx99f/60OdA7ebNUqFKsMxQGorMmEnqzIcoxxKJ6OktJMnOrCnixWeD50QygxO
        MC6+LmfHQE0HbT5LEft/yYljnuhl10loENhqV3WW8X35fYYQgc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.837000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 27A434A44148FAA3416E3B66A234CD621AB5CEC755A9B9CC870ABB7FDF9075502000:8
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jason-ch chen <Jason-ch.Chen@mediatek.com>

This commit adds dt-binding documentation for the MediaTek MT8188
reference board.

Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index ae12b1cab9fb..4f4910d7a1e9 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -163,6 +163,10 @@ properties:
           - enum:
               - mediatek,mt8186-evb
           - const: mediatek,mt8186
+      - items:
+          - enum:
+              - mediatek,mt8188-evb
+          - const: mediatek,mt8188
       - items:
           - enum:
               - mediatek,mt8192-evb
-- 
2.18.0

