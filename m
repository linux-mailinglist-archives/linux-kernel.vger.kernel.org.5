Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C9B79A59F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjIKIKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjIKIKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:10:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC603CFE;
        Mon, 11 Sep 2023 01:09:37 -0700 (PDT)
X-UUID: 8a636e3e507a11eea33bb35ae8d461a2-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8W/rAUiPcskFPX+ufYSNJ1mxz6QAHbHSoUfVwMrzPIo=;
        b=eJlj6x1/st2by1U55DzLVayQXIksxFeDZqAfzYeFH+sPkEo9qg9B09Ma97Q5KV2DOmmhZlQxt9RMn+GreR8fjUXcxN4LnShsJOSYSus3waL2irTFxrOCDAJj8Mg4ohWtOV5uIbqFUXjIJw2O2rVfMIvM9mJBSkxci5FqAaufK2s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:a29b896f-9bdd-4874-a163-10d7c818de8c,IP:0,U
        RL:0,TC:0,Content:29,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:29
X-CID-META: VersionHash:0ad78a4,CLOUDID:5d52b1be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8a636e3e507a11eea33bb35ae8d461a2-20230911
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 225850226; Mon, 11 Sep 2023 16:09:33 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 16:09:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 16:09:31 +0800
From:   Mark Tseng <chun-jen.tseng@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <chun-jen.tseng@mediatek.com>
Subject: [PATCH] arm64: dts: mediatek: mt8186: change CCI OPP scaling mapping
Date:   Mon, 11 Sep 2023 16:09:27 +0800
Message-ID: <20230911080927.17457-1-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.027300-8.000000
X-TMASE-MatchedRID: /BnZajOwp9c77EsBOi8++riMC5wdwKqdMZm0+sEE9msZs8aIepa/RnTv
        v/bTZRlo1rH4Rg0AOT2N6fDbnTu0nx8TzIzimOwPC24oEZ6SpSkj80Za3RRg8EzLGtcUyG9kVBW
        ulG+2IksTqMpkTCkeGqC8ayqaa9oyZnYyx+3zDYE=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.027300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 76E66E642CD04C75C9B5E2BAFB56464D44FBF6D8AF957EEB7C525FFBCD04261C2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original CCI OPP table minimum frequency 500Mhz is too low to cause
system stall, So it need update to new version, 1.4G ~ 1.05G.

Fixes: 32dfbc03fc26 ("arm64: dts: mediatek: mt8186: Add CCI node and CCI OPP table")

Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 90 ++++++++++++------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index f04ae70c470a..b98832d032eb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -39,79 +39,79 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		cci_opp_0: opp-500000000 {
-			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <600000>;
+		cci_opp_0: opp-1050000000 {
+			opp-hz = /bits/ 64 <1050000000>;
+			opp-microvolt = <843750>;
 		};
 
-		cci_opp_1: opp-560000000 {
-			opp-hz = /bits/ 64 <560000000>;
-			opp-microvolt = <675000>;
+		cci_opp_1: opp-1073000000 {
+			opp-hz = /bits/ 64 <1073000000>;
+			opp-microvolt = <850000>;
 		};
 
-		cci_opp_2: opp-612000000 {
-			opp-hz = /bits/ 64 <612000000>;
-			opp-microvolt = <693750>;
+		cci_opp_2: opp-1096000000 {
+			opp-hz = /bits/ 64 <1096000000>;
+			opp-microvolt = <856250>;
 		};
 
-		cci_opp_3: opp-682000000 {
-			opp-hz = /bits/ 64 <682000000>;
-			opp-microvolt = <718750>;
+		cci_opp_3: opp-1120000000 {
+			opp-hz = /bits/ 64 <1120000000>;
+			opp-microvolt = <862500>;
 		};
 
-		cci_opp_4: opp-752000000 {
-			opp-hz = /bits/ 64 <752000000>;
-			opp-microvolt = <743750>;
+		cci_opp_4: opp-1143000000 {
+			opp-hz = /bits/ 64 <1143000000>;
+			opp-microvolt = <881250>;
 		};
 
-		cci_opp_5: opp-822000000 {
-			opp-hz = /bits/ 64 <822000000>;
-			opp-microvolt = <768750>;
+		cci_opp_5: opp-1166000000 {
+			opp-hz = /bits/ 64 <1166000000>;
+			opp-microvolt = <893750>;
 		};
 
-		cci_opp_6: opp-875000000 {
-			opp-hz = /bits/ 64 <875000000>;
-			opp-microvolt = <781250>;
+		cci_opp_6: opp-1190000000 {
+			opp-hz = /bits/ 64 <1190000000>;
+			opp-microvolt = <906250>;
 		};
 
-		cci_opp_7: opp-927000000 {
-			opp-hz = /bits/ 64 <927000000>;
-			opp-microvolt = <800000>;
+		cci_opp_7: opp-1213000000 {
+			opp-hz = /bits/ 64 <1213000000>;
+			opp-microvolt = <918750>;
 		};
 
-		cci_opp_8: opp-980000000 {
-			opp-hz = /bits/ 64 <980000000>;
-			opp-microvolt = <818750>;
+		cci_opp_8: opp-1236000000 {
+			opp-hz = /bits/ 64 <1236000000>;
+			opp-microvolt = <937500>;
 		};
 
-		cci_opp_9: opp-1050000000 {
-			opp-hz = /bits/ 64 <1050000000>;
-			opp-microvolt = <843750>;
+		cci_opp_9: opp-1260000000 {
+			opp-hz = /bits/ 64 <1260000000>;
+			opp-microvolt = <950000>;
 		};
 
-		cci_opp_10: opp-1120000000 {
-			opp-hz = /bits/ 64 <1120000000>;
-			opp-microvolt = <862500>;
+		cci_opp_10: opp-1283000000 {
+			opp-hz = /bits/ 64 <1283000000>;
+			opp-microvolt = <962500>;
 		};
 
-		cci_opp_11: opp-1155000000 {
-			opp-hz = /bits/ 64 <1155000000>;
-			opp-microvolt = <887500>;
+		cci_opp_11: opp-1306000000 {
+			opp-hz = /bits/ 64 <1306000000>;
+			opp-microvolt = <975000>;
 		};
 
-		cci_opp_12: opp-1190000000 {
-			opp-hz = /bits/ 64 <1190000000>;
-			opp-microvolt = <906250>;
+		cci_opp_12: opp-1330000000 {
+			opp-hz = /bits/ 64 <1330000000>;
+			opp-microvolt = <993750>;
 		};
 
-		cci_opp_13: opp-1260000000 {
-			opp-hz = /bits/ 64 <1260000000>;
-			opp-microvolt = <950000>;
+		cci_opp_13: opp-1353000000 {
+			opp-hz = /bits/ 64 <1353000000>;
+			opp-microvolt = <1006250>;
 		};
 
-		cci_opp_14: opp-1330000000 {
-			opp-hz = /bits/ 64 <1330000000>;
-			opp-microvolt = <993750>;
+		cci_opp_14: opp-1376000000 {
+			opp-hz = /bits/ 64 <1376000000>;
+			opp-microvolt = <1018750>;
 		};
 
 		cci_opp_15: opp-1400000000 {
-- 
2.18.0

