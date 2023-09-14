Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEA47A0363
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbjINMKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbjINMKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:10:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B741BE8;
        Thu, 14 Sep 2023 05:10:48 -0700 (PDT)
X-UUID: b87acd3852f711ee8051498923ad61e6-20230914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=YKz6L0fgQbYGVpoCL894aRiXFIbPCR811nC+nBXMf/E=;
        b=BlsXrh0hNBXlPTnkVfrHxAylmud/v5u5vnil4adaHD99rnA45EpkIWR6XCuAQhNs9/7+rEGWc/pqcy6SB6cmnrnZrqmPaiR7cw8R293KTXmbOIvjgXN8NGZU0NZPMy2ohW5MdO0SwyTGHUul/Sq1eEQjqdy46QqdyeoOl6gMgfg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:efdcf695-3119-43dd-bc7d-de1a15d1b9f8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:792a07c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: b87acd3852f711ee8051498923ad61e6-20230914
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 375495485; Thu, 14 Sep 2023 20:10:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Sep 2023 20:10:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Sep 2023 20:10:38 +0800
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
Subject: [PATCH v2 0/1] arm64: dts: mediatek: mt8186: Increase CCI frequency
Date:   Thu, 14 Sep 2023 20:10:34 +0800
Message-ID: <20230914121035.17320-1-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.963800-8.000000
X-TMASE-MatchedRID: Zel3CUePV2i2tlYdo0NnhMAmcZEx8XHJ+KgiyLtJrSCzWpZM44wgRHZb
        RsJ0HDLLlLIxMfkcZY6gVbxI8zQaQh8TzIzimOwP0C1sQRfQzEHEQdG7H66TyMdRT5TQAJnAUxC
        rBvsxJqSSIRqjlsng6kUWYdxa9w6cq781MopyYmTBkGBTIlURuXoXDz8+lMxFpW+aIDJ4DaRzkx
        J+SIkUjmncuUSUEdOX
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.963800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: D0AE13EF9D738D9BAC88D0512FD03EE7C45DC0BB77354DF636728E6A14A4E8CD2000:8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
  - modify subject and patch reason.

Changes since v1:
  - arm64: dts: mediatek: mt8186: change CCI OPP scaling mapping.
    https://lore.kernel.org/all/20230911080927.17457-1-chun-jen.tseng@mediatek.com/ 

Mark Tseng (1):
  arm64: dts: mediatek: mt8186: Increase CCI frequency

 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 90 ++++++++++++------------
 1 file changed, 45 insertions(+), 45 deletions(-)

-- 
2.18.0

