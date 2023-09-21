Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D10C7A973F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjIURMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjIURKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:10:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF11AD17;
        Thu, 21 Sep 2023 10:06:01 -0700 (PDT)
X-UUID: 71a8f338583f11ee8051498923ad61e6-20230921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=axTVp1RbS3/X8rB7C896mMeuab8S+wVpZdIarUZONPw=;
        b=S9nsBmRbrIGyRy6mIUiQ9YoZTiv14McR3HQRgPoiBrOBpJYeJZipxWq14ouACrtKFTRzT4eDkdfCsN9sxnO95HdY5xErrJAoDl+mq5kWLN9pm6dWEvbcvw7FW2yps0G4kuSpVN2PNJy6210obWFtw1/LGEQ8AVhfYnVko291QPk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:fbcdc8ed-3166-40d3-a52c-57341e9684f4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:681d48c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 71a8f338583f11ee8051498923ad61e6-20230921
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 723787508; Thu, 21 Sep 2023 13:26:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Sep 2023 13:26:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Sep 2023 13:26:39 +0800
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
Subject: [PATCH v4 1/3] dt-bindings: soc: mediatek: add mt8188 svs dt-bindings
Date:   Thu, 21 Sep 2023 13:26:35 +0800
Message-ID: <20230921052637.30444-2-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230921052637.30444-1-chun-jen.tseng@mediatek.com>
References: <20230921052637.30444-1-chun-jen.tseng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.895200-8.000000
X-TMASE-MatchedRID: tiRXYRqWr+tlrtpBkGUSk2NW0DAjL5p+YefZ7F9kLgt0RHjq6Pzvr+gV
        4TkxLE0x4vM1YF6AJbZhyT3WNjppUtAtbEEX0MxBxEHRux+uk8ifEzJ5hPndGSP/yY4f5n8Ip1/
        YQl+nUblS2CW/2oqSQd6b50geLAaV+42ujtXrfWikNlIb30v+KAPNiSkC92RldAGc3Y6RYhuh4/
        q7CR9Vj3mVKZusLp922v9OjYWA2uMMswg45VMfPadst5iAforfVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.895200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: D44D22243FF14CA987D5854C11202CD98AD916132098825D32C90592885D40282000:8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt8188 svs compatible in dt-bindings.

Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

