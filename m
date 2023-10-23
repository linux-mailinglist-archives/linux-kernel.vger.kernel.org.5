Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21677D2CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjJWIjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjJWIiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:38:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B341D188;
        Mon, 23 Oct 2023 01:38:49 -0700 (PDT)
X-UUID: 925d184e717f11ee8051498923ad61e6-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dQXcmjFwd9DXm27/c465+NmP2tWOpWp/6hKymZvRh44=;
        b=D5xl3ItWDjypRc5RlLN/z+kn+TH5lTX1nM/fUSRLuLDEsYNmEXbid9xAqn9ouviR6bEiwZ1chmv14Xa+Z4X7IJJ2mr5Iqz7Gy4WvlK885QcUjXICBLH9T2TrsSWvBX1320vPYK9c5U9FctpnCV54dKVX8sJuF9nVV2SlSzTkZUM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:0ea7720a-484b-407b-ba1f-51ec4506eb35,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:a830a8fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 925d184e717f11ee8051498923ad61e6-20231023
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1486113246; Mon, 23 Oct 2023 16:38:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 16:38:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 16:38:41 +0800
From:   Jason-ch Chen <jason-ch.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexandre Mergnat <amergnat@baylibre.com>
CC:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        jason-ch chen <Jason-ch.Chen@mediatek.com>
Subject: [PATCH v6 0/4] Add basic node support for MediaTek MT8188 SoC
Date:   Mon, 23 Oct 2023 16:38:35 +0800
Message-ID: <20231023083839.24453-1-jason-ch.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jason-ch chen <Jason-ch.Chen@mediatek.com>

MT8188 is a SoC based on 64bit ARMv8 architecture.
It contains 6 CA55 and 2 CA78 cores.
MT8188 share many HW IP with MT65xx series.

This patchset was tested on MT8188 evaluation board to shell.

Based on tag: next-20231023, linux-next/master

Changes in v6:
- Add L2 and L3 cache information
- Fix reviewer's comments

Changes in v5:
- Remove unnecessary always-on regulator nodes
- Fix dtbs_check warning

Changes in v4:
- Explain the reason of modifying pwrap binding file, and correct the
  subject
- Fix reviewer's comments

Changes in v3:
- Remove the duplicated part of mt8188 in the pwrap yaml file
- Fix reviewer's comments about coding style

Changes in v2:
- Add MT8188 PMIC Wrapper compatible to binding document
- Fix reviewer's comments

jason-ch chen (4):
  dt-bindings: arm: Add compatible for MediaTek MT8188
  dt-bindings: arm: mediatek: Add mt8188 pericfg compatible
  dt-bindings: soc: mediatek: pwrap: Modify compatible for MT8188
  arm64: dts: Add MediaTek MT8188 dts and evaluation board and Makefile

 .../devicetree/bindings/arm/mediatek.yaml     |   4 +
 .../arm/mediatek/mediatek,pericfg.yaml        |   1 +
 .../bindings/soc/mediatek/mediatek,pwrap.yaml |   6 +-
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 arch/arm64/boot/dts/mediatek/mt8188-evb.dts   | 387 +++++++
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 956 ++++++++++++++++++
 6 files changed, 1354 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188.dtsi

-- 
2.18.0

