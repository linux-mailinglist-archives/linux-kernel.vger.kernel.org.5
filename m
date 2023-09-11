Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E379179BCF6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377519AbjIKW0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbjIKK5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:57:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46FCF3;
        Mon, 11 Sep 2023 03:57:26 -0700 (PDT)
X-UUID: fc336156509111eea33bb35ae8d461a2-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gElX76EooqTMgZPTL7giI+XlGA/O4bjKB0y+ZAuWYS0=;
        b=BXIiaclQk3XdnrOCTIDkqRCukwJJwzNQeyejf2b++Go+DT2OI/gzVItXmwdugcqKZH/GjfbQw/b5ZLC/aYEPGqAMQ4w2FIuRLfhWnPdd/ndtlm0HS+fypj4zv2X6loQmN36Uccn1oX+pC2rgmDitAIhPJ9b7nVDHzYmmBhcM5FE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:04cf4518-16d4-4e4c-983c-bbbb6bbd0c65,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:f8f0e3c2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fc336156509111eea33bb35ae8d461a2-20230911
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <shuijing.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 98129765; Mon, 11 Sep 2023 18:57:22 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 18:57:20 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 18:57:20 +0800
From:   Shuijing Li <shuijing.li@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <jitao.shi@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Shuijing Li <shuijing.li@mediatek.com>
Subject: [PATCH v3,0/3] Add mt8188 compatiable for DSI cmd packet control
Date:   Mon, 11 Sep 2023 18:57:33 +0800
Message-ID: <20230911105736.11752-1-shuijing.li@mediatek.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.997700-8.000000
X-TMASE-MatchedRID: yvDAzrttxFXHCChNBbZThTvfsoCuAcP+h+w9Wz/xXDqIDxaki6CTmJgZ
        2+o9ceX07wgYhNgOzKL/Z0qDAfk1Q6Gsq9dfniq5A9lly13c/gGeEP0DdJrulp2iHEDAUb20o8W
        MkQWv6iUoTQl7wNH8Pg1fA1QHegDv3QfwsVk0UbtuRXh7bFKB7r+k1NFlulNIlZGidBa7H0aVZ3
        zXfISSyJKTX6EwXfWI66XHIc5w+gc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.997700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9F65558BB8E37DB6576E9BCA47856FDB2071D16DFB4AB4D407FEB7A2A12D17432000:8
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding documentation of DSI for MediaTek MT8188 SoC.
Because of the difference between SOC and DSI cmd packet control, for
MT8188, it is necessary to increase the DSI_CMDQ_SIZE control when
sending long packets to initialize the panel. Of course, this will not
affect the sending of short packets.

Base on the branch of linus/master v6.5.

Shuijing Li (3):
  dt-bindings: display: mediatek: dsi: Add compatible for MediaTek
    MT8188
  drm/mediatek: dsi: Add dsi cmdq_ctl to send panel initial code
  drm/mediatek: Add mt8188 dsi compatible to mtk_dsi.c

 .../bindings/display/mediatek/mediatek,dsi.yaml     |  1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c              |  2 ++
 drivers/gpu/drm/mediatek/mtk_dsi.c                  | 13 +++++++++++++
 3 files changed, 16 insertions(+)

-- 
2.40.1

