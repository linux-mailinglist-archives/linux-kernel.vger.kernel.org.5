Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9137D28CA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjJWDG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJWDG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:06:56 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4CF119;
        Sun, 22 Oct 2023 20:06:49 -0700 (PDT)
X-UUID: 31ed50b0715111ee8051498923ad61e6-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Xp1z/ij/6MEXRS02xVyH+bWbshJokuMQpgZ/n9ooiu0=;
        b=jandzS9H9xMBJ0liixBGr1LMN+qNjRp39HFwYlG8xqUNffW4KDhRBntcwul5Mzr0xk+9LumjeO18+IGeMbbWH5app9dJ8dOrQhG5z3GlX7d9AXSGVKQNtBc6wAM1iY+eA9isiBfrcj5L2fsNpIDHVOqKyOUre5fAIfbCwQfdb/0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:24a925c6-64ad-4594-aac4-ec59daba7907,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:1e6230d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 31ed50b0715111ee8051498923ad61e6-20231023
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 834352821; Mon, 23 Oct 2023 11:06:43 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 11:06:42 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 11:06:41 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
CC:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,0/7] media: mediatek: vcodec: Set the correct profile and level for each platform
Date:   Mon, 23 Oct 2023 11:06:33 +0800
Message-ID: <20231023030640.16393-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The supported maximum resolution, bit and frame rate of different platform
for each spec are not always the same, need to set the correct level and
and profile values according to the chip name.

patch 1 get the chip name for each platform
patch 2~3 set h264 and h265 level
patch 4~5 set h264 and h265 profile
patch 6~7 set vp9 level and profile

changed with v1:
- Change the commit message for each patch.
- Change the supported level for mt8195 and mt8192
---
Yunfei Dong (7):
  media: mediatek: vcodec: Get the chip name for each platform
  media: mediatek: vcodec: Set the supported h264 level for each
    platform
  media: mediatek: vcodec: Set the supported h265 level for each
    platform
  media: mediatek: vcodec: Set the supported h264 profile for each
    platform
  media: mediatek: vcodec: Set the supported h265 profile for each
    platform
  media: mediatek: vcodec: Set the supported vp9 level for each platform
  media: mediatek: vcodec: Set the supported vp9 profile for each
    platform

 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  |  24 +--
 .../vcodec/decoder/mtk_vcodec_dec_drv.c       |  26 +++
 .../vcodec/decoder/mtk_vcodec_dec_drv.h       |  14 ++
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 168 +++++++++++++++++-
 4 files changed, 208 insertions(+), 24 deletions(-)

-- 
2.18.0

