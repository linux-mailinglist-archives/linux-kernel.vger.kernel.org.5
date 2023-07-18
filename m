Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C50757A51
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjGRLV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjGRLVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:21:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23568E8;
        Tue, 18 Jul 2023 04:21:53 -0700 (PDT)
X-UUID: 49b846d6255d11ee9cb5633481061a41-20230718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lKkjvXtoAymLFKitwFRjfHiPPpFieshzQX9Gwp7ANeA=;
        b=ngUI8qlrZk/by8naYx8BOUt+OSW9Mr6tgLbPMReTFSz/mTZMfw8voUaj88pEWqw38f+BtEA8OnCZq7BlKD5PGCtCmIr+uLVndmAEbmFeTH5VtBu6X4oaNcXnJsmfh3WgwCy3UBTAzt/5o0Od6/4gibJ+lM5jlRbPCk2zk6RBC6U=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:ed73ab56-fd64-4012-8f06-06e7d5bca952,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:95
X-CID-INFO: VERSION:1.1.28,REQID:ed73ab56-fd64-4012-8f06-06e7d5bca952,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:95
X-CID-META: VersionHash:176cd25,CLOUDID:898dc187-44fb-401c-8de7-6a5572f1f5d5,B
        ulkID:230718192149NV4B6JMX,BulkQuantity:0,Recheck:0,SF:38|29|28|16|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,
        TF_CID_SPAM_USA
X-UUID: 49b846d6255d11ee9cb5633481061a41-20230718
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <william-tw.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1329607392; Tue, 18 Jul 2023 19:21:49 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jul 2023 19:21:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jul 2023 19:21:48 +0800
From:   William-tw Lin <william-tw.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        William-tw Lin <william-tw.lin@mediatek.com>
Subject: [PATCH 0/3] mtk-socinfo driver implementation
Date:   Tue, 18 Jul 2023 19:21:40 +0800
Message-ID: <20230718112143.14036-1-william-tw.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This purpose for these patches is to enable soc-related information 
retrival. Such information includes manufacturer information, SoC name,
SoC segment name, and SoC marketing name.

Based on tag: next-20230718, linux-next/master

William-tw Lin (3):
  soc: mediatek: mtk-socinfo: Add driver for getting chip information
  dt-bindings: soc: mediatek: Add mtk-socinfo driver
  arm64: dts: Add node for chip info driver

 .../bindings/soc/mediatek/mtk-socinfo.yaml    |  58 +++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  15 ++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  15 ++
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  10 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  14 ++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |   9 +
 drivers/soc/mediatek/Kconfig                  |  18 ++
 drivers/soc/mediatek/Makefile                 |   1 +
 drivers/soc/mediatek/mtk-socinfo.c            | 203 +++++++++++++++++
 drivers/soc/mediatek/mtk-socinfo.h            | 213 ++++++++++++++++++
 10 files changed, 556 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-socinfo.yaml
 create mode 100644 drivers/soc/mediatek/mtk-socinfo.c
 create mode 100644 drivers/soc/mediatek/mtk-socinfo.h

-- 
2.18.0

