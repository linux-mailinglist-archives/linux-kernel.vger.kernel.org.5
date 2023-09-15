Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CB17A224E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbjIOP0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbjIOP0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:26:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AAAE50;
        Fri, 15 Sep 2023 08:26:20 -0700 (PDT)
X-UUID: 34fca07c53dc11eea33bb35ae8d461a2-20230915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DFB1ce/CaeRxMkY2IQnRopnHe2UahnGT279P4kFvN6w=;
        b=d/pv0mp0VW4HE8JObo7qMlBHvo2tyTPCFyuuRzYAcfnozpXW8wN/EdmMdM+olI8XDrITpvkU/LfGM8n4yKCCkw+m9SV6fZY+2G6j1Fm7N3fHijO6ApsCbStEPXLTNbo2YYBzzsoYwlHjUfPWH1dumm74sIo/ltpo/VpzV6N5LRI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:32cb2023-3f14-419a-966f-1fdb287e85c4,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:2fe313c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 34fca07c53dc11eea33bb35ae8d461a2-20230915
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <william-tw.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2073194743; Fri, 15 Sep 2023 23:26:14 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Sep 2023 23:26:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Sep 2023 23:26:11 +0800
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
Subject: [PATCH v2 0/3] mtk-socinfo driver implementation
Date:   Fri, 15 Sep 2023 23:26:04 +0800
Message-ID: <20230915152607.18116-1-william-tw.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-0.910800-8.000000
X-TMASE-MatchedRID: 7LejLvGCNgAsZYGCajmr7M+QmA3DfdSbTCv58Zx9SJpUjspoiX02Fyuk
        s9vcKhsTldfHsj3+ZpTaSHwlOL1r6kttpN+KVVd9A9lly13c/gF/aDoolm3GXTUsHjosUACSR3R
        HPHTssNVZfh5NyMNmxIAy6p60ZV62fJ5/bZ6npdjKayT/BQTiGoCxaPcRWGBYaz1jwFb6Hi1LRI
        6qNRdnldwlh41JmumFJaD3/dLreAh7VtbENfMiUYgD8vh/Ci8nh465MwdO/NcyPT6YOUMfw6/XF
        oPK0hZ9dATQdtPksR+3/JiWOe6GXXSWgQ2GpXdZ9D6bLBJM9NtDDKa3G4nrLQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-0.910800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: D8F24BC104B54FDB57C56364F1072AABD6E1812F6E7F2E8267B43BBD45A354932000:8
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This purpose of the patches is for soc-related information retrival.
Such information includes manufacturer information, SoC name, SoC 
segment name, and SoC marketing name.

Based on tag: next-20230915, linux-next/master

Changes in v2:
- Remove mtk-socinfo.h
- Consolidate different compatibles into mediatek,socinfo
- Move socinfo node out of MMIO bus
- Move mtk-socinfo.yaml to hwinfo
- Fix reviewer's comments

William-tw Lin (3):
  arm64: dts: Add node for chip info driver
  soc: mediatek: mtk-socinfo: Add driver for getting chip information
  dt-bindings: hwinfo: Add mtk-socinfo driver

 .../bindings/hwinfo/mtk-socinfo.yaml          |  48 +++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  15 ++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  15 ++
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  10 ++
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  14 ++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |   9 +
 drivers/soc/mediatek/Kconfig                  |   9 +
 drivers/soc/mediatek/Makefile                 |   1 +
 drivers/soc/mediatek/mtk-socinfo.c            | 166 ++++++++++++++++++
 9 files changed, 287 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
 create mode 100644 drivers/soc/mediatek/mtk-socinfo.c

-- 
2.18.0

