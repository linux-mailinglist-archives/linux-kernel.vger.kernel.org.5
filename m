Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3127A9602
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjIUQ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjIUQ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:56:42 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FB0138;
        Thu, 21 Sep 2023 09:56:22 -0700 (PDT)
X-UUID: 78eb04c4584411eea33bb35ae8d461a2-20230921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=EWhNJUZu5Z/Tip7T2l6e0SxlNLO3our8/wpCQafOB/o=;
        b=czp2U5KbJR90VgSzXGViGBJicUN151f1UClpbZSiA633cbEnaYK+/eqTfkdy7MbIUiH504yXIH/hM47zATMTNVPw5SvExsT5OUjphUcfN2rUP2NQ8DcFlwH+Tn+lAt+kREjVyudAUg/a9/t1jeMyD0iMMqj6zflOd+j+DxKWzjU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:c6fff9dd-2294-42f8-a04b-24298a7a65f4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:fbad17bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 78eb04c4584411eea33bb35ae8d461a2-20230921
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 756191925; Thu, 21 Sep 2023 14:02:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Sep 2023 14:02:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Sep 2023 14:02:38 +0800
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
Subject: [RESEND PATCH v4 0/4] Add basic node support for MediaTek MT8188 SoC
Date:   Thu, 21 Sep 2023 14:02:31 +0800
Message-ID: <20230921060235.32478-1-jason-ch.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.917900-8.000000
X-TMASE-MatchedRID: 4M8Lw78TDBC57gDVLy87eqDKPaVrGhelnF8rflXuiRWLYYF0ANN+FM79
        PlJmAmXDw6u+ET+UDSLCsyZB1bKGqA9FV6kNYiPHcFEiuPxHjsVMkOX0UoduuZjk0EbtghtXRRZ
        I1R6hQzaMENdLhjEPNHATsg8MODVIHxPMjOKY7A8LbigRnpKlKTpcQTtiHDgW3RMO1vCX2BONXw
        kPEO+4GwmUKXRz5/kyHY8rUJbT9fBeEdd0tvLkfTSPadpOKohE/hInS/lBNZcc8kewVHD7dwXxZ
        AfqSp37wZBgUyJVEbl6Fw8/PpTMRaVvmiAyeA2kc5MSfkiJFI5p3LlElBHTlw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.917900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 10F5DF882A4120FA076CD7F133625259A899C92C29EB1633CA6B00F40409C17E2000:8
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Based on tag: next-20230920, linux-next/master

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
 arch/arm64/boot/dts/mediatek/mt8188-evb.dts   | 400 ++++++++
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 951 ++++++++++++++++++
 6 files changed, 1362 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188.dtsi

-- 
2.18.0

