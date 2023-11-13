Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93417E9C23
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjKMMcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjKMMcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:32:06 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659971727
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:32:03 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc5b7057d5so38694835ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699878723; x=1700483523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=py+4SutQqV3+4rqQPYSiHKI4gA9eXI6g2jeOqoYb50s=;
        b=JPS6rm2yeQo7Iw6LLyIFlNnGg1Rc2UDrOJJMd6kRjsIcp0ENV3Sul+ThfI9BHexV2/
         txIfqExM7SirpfhQqf/IpHYTYcPdal0UJk9+qSLCOXWy0p7vHnq2GSsORJg8H3Uy7HJH
         9fiOVaavr+7Lu0Vv5yluyPjs36/suSR8SjkTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699878723; x=1700483523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=py+4SutQqV3+4rqQPYSiHKI4gA9eXI6g2jeOqoYb50s=;
        b=SLoqUfM2gY/VbUAlz3pwEeU1dB8t873iVy2xU1b//dHYatQNvolctmWn5sm7Ybv7TJ
         IO75yb6G6NzDE3SneS/jjVliNzweo1Los5kq1tRURhzEuEt7pC8UVGKrA5HBJhf/pxsk
         40JL/bKC+MOkmnYf6aPkDxBDg3qf6ese7RzDVY5SzjFCC9bh1oMvFEy7+OhziJc+yp1N
         JS65yLct4jXefgzoXFz9NE1rqLpQdcWQvofLvuIRvHcX1v0+xlT6kH+K3O+X1c1uxtLE
         4ISudoK6Y37KWINTDlWdChu/IiGu959YNzCZh2VjsAlc5whGrHsQw0Ky/9Q9NPVkcDn0
         97hQ==
X-Gm-Message-State: AOJu0YzEoKD6CxHTNuBsku3wpvKzaKn8NjJMRrgr+qN6fFjNzYfX4kJA
        wHOEDMfc+3jDQ9p9vhssjhwS5g==
X-Google-Smtp-Source: AGHT+IHEgiuNFFVDdx270O6Oa6UBDR2x3iAow64arQ4fbeLxoenvFolURDN435oi95jJKjzlfm9Imw==
X-Received: by 2002:a17:902:f686:b0:1ce:19cd:b9c4 with SMTP id l6-20020a170902f68600b001ce19cdb9c4mr5539445plg.3.1699878722789;
        Mon, 13 Nov 2023 04:32:02 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:bc9:4777:173:8be3])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001bde65894c8sm3924104pld.268.2023.11.13.04.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 04:32:02 -0800 (PST)
From:   Fei Shao <fshao@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Fei Shao <fshao@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 0/4] Improvement around mtk_vcodec_mem_free() logging and usage
Date:   Mon, 13 Nov 2023 20:26:48 +0800
Message-ID: <20231113123049.4117280-1-fshao@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes some improvements around mtk_vcodec_mem_free() in
mtk_vcodec_util.c.

I noticed that mtk_vcodec_mem_free() generates a spurious error if the
target DMA buffer has been freed previously:
  mtk_vcodec_mem_free(),69: [MTK_V4L2][ERROR] 18000000.video-codec
  dma_free size=0 failed!

It's actually harmless, but it brings some confusion to our developers
and testing infra so I'd like to fix it. Then I found some checks around
mtk_vcodec_mem_free() usages in the driver that can optimized together,
so I wrapped both into this series.

The first two patches are for aesthetic and style improvements, the
third suppresses the error mentioned above, and the last removes the
redundant code for optimization.

Regards,
Fei


Fei Shao (4):
  media: mediatek: vcodec: Replace dev_name in error string
  media: mediatek: vcodec: Drop unnecessary variable
  media: mediatek: vcodec: Fix mtk_vcodec_mem_free() error log criteria
  media: mediatek: vcodec: Drop VA check against mtk_vcodec_mem_free()

 .../mediatek/vcodec/common/mtk_vcodec_util.c  | 23 +++++++--------
 .../vcodec/decoder/vdec/vdec_av1_req_lat_if.c | 18 ++++--------
 .../vcodec/decoder/vdec/vdec_h264_if.c        |  9 ++----
 .../vcodec/decoder/vdec/vdec_h264_req_if.c    |  9 ++----
 .../decoder/vdec/vdec_h264_req_multi_if.c     |  6 ++--
 .../decoder/vdec/vdec_hevc_req_multi_if.c     |  9 ++----
 .../vcodec/decoder/vdec/vdec_vp8_if.c         |  4 +--
 .../vcodec/decoder/vdec/vdec_vp8_req_if.c     | 12 +++-----
 .../vcodec/decoder/vdec/vdec_vp9_if.c         | 15 ++++------
 .../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c | 29 +++++++------------
 .../mediatek/vcodec/decoder/vdec_msg_queue.c  | 15 ++++------
 11 files changed, 54 insertions(+), 95 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

