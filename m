Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0FC79AED3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354629AbjIKVyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbjIKM7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:59:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABBFE40;
        Mon, 11 Sep 2023 05:59:45 -0700 (PDT)
X-UUID: 11da3b7250a311eea33bb35ae8d461a2-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=h5MlQeYSjp2j/LB9w519bAWy3e+QI9O2SLovvv9dKIs=;
        b=AbWCZ/B+EqhLS09j9YpCnGhj0+pTRo97qKwvdELJzy3d6N0DqxCc5EpwSjJDERwQy3idDh6CwwilG2/SpRozIKYM8kMFjSVgqpXzruB/47TxmFV1oOrXT6ddtp5NA8lNoQEe0UJrwFAGDxKLqGmVkP+x2bslxf2OB2KSji5zLVw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:b4850ba6-ae1c-4709-84c7-43bbf7766511,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:cbc3e4c2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 11da3b7250a311eea33bb35ae8d461a2-20230911
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 585064307; Mon, 11 Sep 2023 20:59:40 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 20:59:38 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 20:59:37 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
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
Subject: [PATCH 00/14] add driver to support secure video decoder
Date:   Mon, 11 Sep 2023 20:59:22 +0800
Message-ID: <20230911125936.10648-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.569700-8.000000
X-TMASE-MatchedRID: /kvX+BAyhRdLbaTfilVXfZqrexa4CbEQUAjrAJWsTe8KA2OoGAlTk54d
        VMHTNaMULOOktaHND2iW4kxGbzOebKo77AcuQhw7o65WJt1k1O9YMtqMzbYRNmfYlY6RxyOvXA6
        qLXqEbYuwDEIJD1Y7K9r7qQBGAlkIi8ICQO6ibxQVglQa/gMvfDFcf92WG8u/EvoxTu3fj1s3Bo
        tHDlVWrHZmxDzqJ8rQkgebTBpa5lDwOTPseUY5HB+WEMjoO9WWfS0Ip2eEHnz3IzXlXlpamPoLR
        4+zsDTtgUicvJ4MChmMp7Dr14nIYnrpZk2SoHtre7MWlND3CeQUtK2l9hQpvBM3tVf09E8l
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.569700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B9A27BB1E74839D8447AA282BB12001D619C9E13CF4D50EEB8FA142406C08CEE2000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support secure video decoder for mt8195/mt8188 h264 driver,
need to use tee client interface to communicate with optee-os. Firstly,
open tee context and tee session for each hardware.

Secondly, allocate two shared memory msg and vsi, msg used to send ipi to
optee-os and get ack msg from optee-os, vsi used to store syntax for
hardware decoder.

Thirdly, adding two CID controls: V4L2_CID_MPEG_MTK_SET_SECURE_MODE and
V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE, get secure handle used for user space
to convert secure fd to secure handle, set secure mode used to tell decoder
driver to initialize tee interface to decode secure video.

Lastly, re-construct h264 driver to support secure video decoder.

Patch 1~4  initialize tee related interface and parameters.
Patch 5~6  allocate/free secure memory.
Patch 7    map vsi for secure mode.
Patch 8    support one plane capture buffer.
Patch 9~10 re-construct h264 driver to support secure mode.
patch 11   used to convert secure fd to secure handle.
Patch 12   used to set secure decoder mode.
Patch 13   disable interrupt.
Patch 14   support tee decode
---
Reference series:
[1]: v1 of this series is submitted by Yong Wu.
	message-id: 20230911023038.30649-1-yong.wu@mediatek.com

Yunfei Dong (14):
  media: mediatek: vcodec: add tee client interface to communiate with
    optee-os
  media: mediatek: vcodec: allocate tee share memory
  media: mediatek: vcodec: send share memory data to optee
  media: mediatek: vcodec: initialize msg and vsi information
  media: mediatek: vcodec: using encoder's device to alloc/free memory
  media: mediatek: vcodec: add interface to allocate/free secure memory
  media: mediatek: vcodec: using shared memory as vsi address
  media: medkatek: vcodec: support one plane capture buffer
  media: medkatek: vcodec: re-construct h264 driver to support svp mode
  media: medkatek: vcodec: remove parse nal_info in kernel
  media: medkatek: vcodec: covert secure fd to secure handle
  media: medkatek: vcodec: set secure mode to decoder driver
  media: medkatek: vcodec: disable wait interrupt for svp mode
  media: medkatek: vcodec: support tee decoder

 .../media/platform/mediatek/vcodec/Kconfig    |   1 +
 .../mediatek/vcodec/common/mtk_vcodec_util.c  | 177 ++++++++-
 .../mediatek/vcodec/common/mtk_vcodec_util.h  |   3 +
 .../platform/mediatek/vcodec/decoder/Makefile |   1 +
 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  |  24 +-
 .../vcodec/decoder/mtk_vcodec_dec_drv.c       |   9 +
 .../vcodec/decoder/mtk_vcodec_dec_drv.h       |   7 +
 .../vcodec/decoder/mtk_vcodec_dec_hw.c        |  34 +-
 .../vcodec/decoder/mtk_vcodec_dec_optee.c     | 373 ++++++++++++++++++
 .../vcodec/decoder/mtk_vcodec_dec_optee.h     | 156 ++++++++
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c |  80 +++-
 .../decoder/vdec/vdec_h264_req_common.c       |  16 +-
 .../decoder/vdec/vdec_h264_req_multi_if.c     | 334 +++++++++-------
 .../mediatek/vcodec/decoder/vdec_drv_if.c     |   4 +-
 .../mediatek/vcodec/decoder/vdec_msg_queue.c  |   9 +-
 .../mediatek/vcodec/decoder/vdec_vpu_if.c     |  54 ++-
 .../mediatek/vcodec/decoder/vdec_vpu_if.h     |   4 +
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  10 +
 include/uapi/linux/v4l2-controls.h            |   5 +
 19 files changed, 1110 insertions(+), 191 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_optee.h

-- 
2.18.0

