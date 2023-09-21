Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D5E7A9746
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjIURMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjIURKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:10:38 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDDFAD11;
        Thu, 21 Sep 2023 10:06:00 -0700 (PDT)
X-UUID: 719970d4583f11eea33bb35ae8d461a2-20230921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=AwmaUUhkEaQmbRXLi0fx5iHxlyssYThhpAR9/2J7T8Q=;
        b=AYjBmq9kh2bhW5P+QjhoDE4LyS6b4+Vdh620yh13vIwxXtP86FjBWmnu/gNraclqsHZCXsx5FmvyOXCbnv8GsC+kMMnsYsJxclc5RZnCZhCe8MU7xymH7QhwqBtJ9k2b7WB6OEQWXS/tt8E56knvDufbisq0/o8QzVROl7e1/XM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:5ae123a7-05a6-43fc-a24a-be669828565c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:c3a8f3ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 719970d4583f11eea33bb35ae8d461a2-20230921
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 703265398; Thu, 21 Sep 2023 13:26:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Sep 2023 13:26:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Sep 2023 13:26:38 +0800
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
Subject: [PATCH v4 0/3] soc: mediatek: svs: add support for mt8188
Date:   Thu, 21 Sep 2023 13:26:34 +0800
Message-ID: <20230921052637.30444-1-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.651000-8.000000
X-TMASE-MatchedRID: msJaThnkmNaUYaO/E+T/Q7Gj3LN0+Ey9MZm0+sEE9msY0A95tjAn+6TT
        MgD+EF6Mt6h/5bQ4cfk486vsentZ7yY0eULsNBXlngIgpj8eDcBpkajQR5gb3savT21DsLD/UEh
        Wy9W70AEgBwKKRHe+r42/LML0lZwJXU6WEuGZ75CeyQmfiMLyaC/+W0uWJBj8vgnKFRxxFmo=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.651000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 512EB21A3D506CEB24845C79D732D95861D2463192AB94854A880DFF3B2B976C2000:8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series supports MT8188 Smart Voltage Scaling (SVS) hardware which
used as optimization of opp voltage table for gpu dvfs driver.

Changes since v3:
  - separate the voltage bin support from the MT8188 support

Changes since v2:
  - Add Acked-by & Acked-by in patch

Changes since v1:
  - thermal name change to lvts
  - fixed voltage bin flow
  - using svs_get_efuse_data() replace nvmem read API in mt8188 efuse
    parsing 

Mark Tseng (3):
  dt-bindings: soc: mediatek: add mt8188 svs dt-bindings
  soc: mediatek: svs: Add support for MT8188 SoC
  soc: mediatek: svs: Add support for voltage bins

 .../bindings/soc/mediatek/mtk-svs.yaml        |   1 +
 drivers/soc/mediatek/mtk-svs.c                | 184 +++++++++++++++++-
 2 files changed, 181 insertions(+), 4 deletions(-)

-- 
2.18.0

