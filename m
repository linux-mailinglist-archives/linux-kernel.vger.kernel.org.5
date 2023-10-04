Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D677B7D50
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241906AbjJDKh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjJDKh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:37:57 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515D4AF;
        Wed,  4 Oct 2023 03:37:53 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 394AEoCZ026784;
        Wed, 4 Oct 2023 12:37:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=CpI7neB
        XhCSjFx6tMjeMOMf+DEVU5RTw/WINZZr8x8k=; b=FqfspHoPTMg+H9TBxgX/CzP
        VNndxrfDVRa6vRMPU6nwgIXSd+U8PcGRsqkPZHK5dFOzoMmyflPjedA2mgruxcJZ
        pYvUIj5V+k97SEde0mkLRy32PHpx+ZSBgsE5s0V5n2xcM4ncc0wXPYX96HY5Pp6i
        sCp/JCVyyITge+04lBPa1sKNYuq2NJ3eK6xCcvnsl2ixgg5mcM+Rcbxbuse8T2Us
        YaV94BKrXQn+AiOmPs1kdCnkIhbovL2GI6aeBKiaeldxJOeBY3akHUohKj5zx0so
        e0EYyVN9DpdL1pBiPVJmljU6T8ePUo/J5a0/DJqSIKiNWzWNRDyc7fK84hrxuag=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tew80p71d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 12:37:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1C0B1100053;
        Wed,  4 Oct 2023 12:37:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0CDEC231510;
        Wed,  4 Oct 2023 12:37:28 +0200 (CEST)
Received: from localhost (10.201.20.120) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 12:37:27 +0200
From:   Hugues Fruchet <hugues.fruchet@foss.st.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        <linux-media@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
CC:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Adam Ford <aford173@gmail.com>
Subject: [RFC 0/6] VP8 H1 stateless encoding
Date:   Wed, 4 Oct 2023 12:37:14 +0200
Message-ID: <20231004103720.3540436-1-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.120]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_02,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is an RFC to support VP8 encoding using Hantro H1 hardware
of STM32MP25 SoCs (Verisilicon VC8000NanoE IP).
This work is derived from work done to support Rockchip RK3399
VPU2 in RFC [1] with a reshuffling of registers to match H1
register set.

This has been tested on STM32MP257F-EV1 evaluation board using
GStreamer userspace [2]:
gst-launch-1.0 videotestsrc num-buffers=500 ! video/x-raw,width=640,height=480 \
! v4l2slvp8enc ! queue ! matroskamux ! filesink location=test_vp8.mkv

For the sake of simplicity I have embedded here the RFC [1] before the
changes related to this exact RFC, all rebased on v6.6 + STM32MP25
hardware codecs support [3].

[1] https://lwn.net/ml/linux-media/20230309125651.23911-1-andrzej.p@collabora.com/
[2] https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3736
[3] https://patchwork.kernel.org/project/linux-media/list/?series=789861

Best regards,
Hugues.


Andrzej Pietrasiewicz (2):
  media: uapi: Add VP8 stateless encoder controls
  media: hantro: add VP8 encode support for Rockchip RK3399 VPU2

Hugues Fruchet (4):
  media: hantro: add h1 vp8 encode support
  media: hantro: add VP8 encode support for STM32MP25 VENC
  media: hantro: h1: NV12 single-plane support
  media: hantro: add NV12 single-plane support for STM32MP25 VENC

 drivers/media/platform/verisilicon/Makefile   |    3 +
 drivers/media/platform/verisilicon/hantro.h   |   10 +
 .../platform/verisilicon/hantro_boolenc.c     |   69 +
 .../platform/verisilicon/hantro_boolenc.h     |   21 +
 .../media/platform/verisilicon/hantro_drv.c   |   15 +-
 .../platform/verisilicon/hantro_h1_jpeg_enc.c |   42 +-
 .../platform/verisilicon/hantro_h1_regs.h     |   71 +-
 .../platform/verisilicon/hantro_h1_vp8_enc.c  | 1589 +++++++++++++++++
 .../media/platform/verisilicon/hantro_hw.h    |   93 +
 .../media/platform/verisilicon/hantro_v4l2.c  |    5 +-
 .../media/platform/verisilicon/hantro_vp8.c   |  118 ++
 .../verisilicon/rockchip_vpu2_hw_vp8_enc.c    | 1574 ++++++++++++++++
 .../platform/verisilicon/rockchip_vpu2_regs.h |    1 +
 .../platform/verisilicon/rockchip_vpu_hw.c    |   23 +-
 .../platform/verisilicon/stm32mp25_venc_hw.c  |   35 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c     |   13 +
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |    5 +
 include/media/v4l2-ctrls.h                    |    2 +
 include/uapi/linux/v4l2-controls.h            |   91 +
 include/uapi/linux/videodev2.h                |    3 +
 20 files changed, 3755 insertions(+), 28 deletions(-)
 create mode 100644 drivers/media/platform/verisilicon/hantro_boolenc.c
 create mode 100644 drivers/media/platform/verisilicon/hantro_boolenc.h
 create mode 100644 drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu2_hw_vp8_enc.c

-- 
2.25.1

