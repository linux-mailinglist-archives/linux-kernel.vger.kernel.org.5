Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE547E20AA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjKFMEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjKFMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:04:37 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0CFDF;
        Mon,  6 Nov 2023 04:04:32 -0800 (PST)
X-UUID: a2ac9da07c9c11ee8051498923ad61e6-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ciPtDPF+TnvenA4+CRoRDc5pTrR/o2srfttrAr9XbFM=;
        b=rHPSFYIkaxU2nXNe2RQAoaBnDiJM8d653V/QBp9cuXFEyVUpiTOQw5yiY1wMkYMnCxXEHCx7KjfEmeRsM2rLSgMuUUcL7VncrM3VFYNOVPb7ubm7Q+mvW+p5XsfMdyuONjB3NYThIJSwbCU6Fu38SQPnJKZgK/JdJDUjTl4UojA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:aab5ff5d-04e3-458e-a96d-d83d2ead01e7,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:364b77b,CLOUDID:f7e41195-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: a2ac9da07c9c11ee8051498923ad61e6-20231106
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1203267962; Mon, 06 Nov 2023 20:04:28 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 20:04:25 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 20:04:24 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Jeffrey Kardatzke <jkardatzke@google.com>,
        "T . J . Mercier" <tjmercier@google.com>,
        John Stultz <jstultz@google.com>,
        Yong Wu <yong.wu@mediatek.com>,
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
        "Steve Cho" <stevecho@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,00/21] add driver to support secure video decoder
Date:   Mon, 6 Nov 2023 20:04:02 +0800
Message-ID: <20231106120423.23364-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.630100-8.000000
X-TMASE-MatchedRID: JhRlCkpv+Yto4JO2ZJOtUQI0yP/uoH+DFJFr2qlKix/b6Y+fnTZUL2F6
        OnunDMpM0iYP9KyvWGiNbWLcD74x2aTBNmfHIEnzhv1+2J3yQFxQCOsAlaxN72ecrqZc3vabxxE
        lGvP0lfgvVtEpvFuMNUGaeX/AzQEV4Yh4UkkUHv7uykw7cfAoIOiZcG9oG7pOX15NJHwjp24IXI
        ywbHNrmD5Cz4k65D4iLsOyjR5rXS8cqJwtUHLtOWZUc2jtcaSdUKlt4AyW7uDjud2x7TPVt2OrK
        vsUT0pAVLAa8KXwKt7H3jW5bUH06n3BSdKn4WxeH5YQyOg71ZZ9LQinZ4QefPcjNeVeWlqY+gtH
        j7OwNO2I3adjBtsMrOnbgh6EIA/muHu85lBc1WzDJAu5FtdmRomKnf8sKUzK+iEHvAMRWIrGDon
        WJihmxwh1J4CodOOy49vZlki2pPVE4C0jRE0xOqMnTJRI0XInfXwUEm1ouDzLDYxFC1/7rn6GdN
        k4NWmA
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.630100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 40AEF5215B6F64F5A62676A1632BA663CD157F81013A9B5FA3644D2E695F517A2000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is consists of four parts. The first is from Jeffrey,
adding secure memory flag in v4l2 framework to support request secure
buffer.

The second and third parts are from John and T.J, adding some heap
interfaces, then our kernel users could allocate buffer from special
heap. The patch v1 is inside below dmabuf link.
https://lore.kernel.org/linux-mediatek/20230911023038.30649-1-yong.wu@mediatek.com/
To avoid confusing, move them into vcodec patchset since we use the
new interfaces directly.

The fourth part is mediatek decoder driver, adding tee interface to
support secure video decoder(svp).

Patch 1~4   add secure memory flag in v4l2 framework with Jeffrey's patch.
Patch 5~7   support allocate dmabufs from specific with John and T.J's patch.
Patch 8~11  initialize tee related interface and parameters.
Patch 12    allocate/free secure memory.
Patch 13    map vsi for secure mode.
Patch 14~16 support one plane capture buffer.
Patch 17~18 re-construct h264 driver to support secure mode.
Patch 19    disable interrupt.
Patch 20    support tee decode.
Patch 21    move init decoder interface to setup queue.
---
Changed in v2:
- remove setting decoder mode and getting secure handle from decode
- add Jeffrey's patch
- add John and T.J's patch
- getting secure flag with request buffer
- fix some comments from patch v1
---
Jeffrey Kardatzke (4):
  v4l2: add secure memory flags
  v4l2: handle secure memory flags in queue setup
  v4l2: verify secure dmabufs are used in secure queue
  v4l: add documentation for secure memory flag

John Stultz (2):
  dma-heap: Add proper kref handling on dma-buf heaps
  dma-heap: Provide accessors so that in-kernel drivers can allocate
    dmabufs from specific heaps

T.J. Mercier (1):
  dma-buf: heaps: Deduplicate docs and adopt common format

Yunfei Dong (14):
  media: mediatek: vcodec: add tee client interface to communiate with
    optee-os
  media: mediatek: vcodec: allocate tee share memory
  media: mediatek: vcodec: send share memory data to optee
  media: mediatek: vcodec: initialize msg and vsi information
  media: mediatek: vcodec: add interface to allocate/free secure memory
  media: mediatek: vcodec: using shared memory as vsi address
  media: mediatek: vcodec: Add capture format to support one plane
    memory
  media: mediatek: vcodec: Add one plane format
  media: medkatek: vcodec: support one plane capture buffer
  media: medkatek: vcodec: re-construct h264 driver to support svp mode
  media: medkatek: vcodec: remove parse nal_info in kernel
  media: medkatek: vcodec: disable wait interrupt for svp mode
  media: medkatek: vcodec: support tee decoder
  media: mediatek: vcodec: move vdec init interface to setup callback

 .../userspace-api/media/v4l/buffer.rst        |   8 +-
 .../media/v4l/pixfmt-reserved.rst             |   8 +
 drivers/dma-buf/dma-heap.c                    | 139 +++++--
 .../media/common/videobuf2/videobuf2-core.c   |  25 ++
 .../common/videobuf2/videobuf2-dma-contig.c   |   6 +
 .../media/common/videobuf2/videobuf2-dma-sg.c |   6 +
 .../media/common/videobuf2/videobuf2-v4l2.c   |  33 +-
 .../media/platform/mediatek/vcodec/Kconfig    |   1 +
 .../mediatek/vcodec/common/mtk_vcodec_util.c  | 121 +++++-
 .../mediatek/vcodec/common/mtk_vcodec_util.h  |   3 +
 .../platform/mediatek/vcodec/decoder/Makefile |   1 +
 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 155 ++++---
 .../vcodec/decoder/mtk_vcodec_dec_drv.c       |   8 +
 .../vcodec/decoder/mtk_vcodec_dec_drv.h       |   7 +
 .../vcodec/decoder/mtk_vcodec_dec_hw.c        |  34 +-
 .../vcodec/decoder/mtk_vcodec_dec_optee.c     | 383 ++++++++++++++++++
 .../vcodec/decoder/mtk_vcodec_dec_optee.h     | 156 +++++++
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c |  35 +-
 .../decoder/vdec/vdec_h264_req_common.c       |  11 +-
 .../decoder/vdec/vdec_h264_req_multi_if.c     | 334 +++++++++------
 .../mediatek/vcodec/decoder/vdec_drv_if.c     |   4 +-
 .../mediatek/vcodec/decoder/vdec_msg_queue.c  |   9 +-
 .../mediatek/vcodec/decoder/vdec_vpu_if.c     |  57 ++-
 .../mediatek/vcodec/decoder/vdec_vpu_if.h     |   4 +
 drivers/media/v4l2-core/v4l2-common.c         |   2 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
 include/linux/dma-heap.h                      |  29 +-
 include/media/videobuf2-core.h                |   8 +-
 include/uapi/linux/videodev2.h                |   3 +
 29 files changed, 1292 insertions(+), 299 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.h

-- 
2.18.0

