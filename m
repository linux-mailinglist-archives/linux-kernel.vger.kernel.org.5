Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A967C6D06
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379176AbjJLLrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378597AbjJLLrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:47:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05F6103;
        Thu, 12 Oct 2023 04:47:03 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7ae7:b86d:c19a:877e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2B9EB660737C;
        Thu, 12 Oct 2023 12:47:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697111222;
        bh=tcL10ushjZKOfejORLVlDBPX8x0SngzD2gGkivTGU0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ldW/Ogjn9kC7gijcctJUy/y/+tFA0G7iAnA/ttNi0MVF+0mW3uyktXU526npAf3Wd
         B8jXbM6qUhwD4mEpacvh2dWg6MJNrsnW6dpB5ib3/1mvycY4+CBfekkt4EjWGKu5tT
         LrMbdQ+L9Qviv1A8u8gVDalkbsHMBXdPyTD3EPT/+xxlJxg+Prl3SfhCCQNm7zSf9w
         NOw3TH2uk3HtGi0/wwAHViVKX8HCyoCNJdUba0qgVOCyqpbCbVO3pdmOz72ATTysmj
         yb3MqZbn66e2YrfsDGI4rkDivBXmmL8PVFzGf7/LwkbgCG97VWKM9OLI7HX0Y612ho
         dGi7FgsOFNteg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>
Subject: [PATCH v11 24/56] media: pci: netup_unidvb: Remove useless number of buffers check
Date:   Thu, 12 Oct 2023 13:46:10 +0200
Message-Id: <20231012114642.19040-25-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
References: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vb2 core tests this already so remove it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Sergey Kozlov <serjk@netup.ru>
CC: Abylay Ospan <aospan@netup.ru>
---
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index d85bfbb77a25..52de9b0af812 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -297,11 +297,9 @@ static int netup_unidvb_queue_setup(struct vb2_queue *vq,
 	dev_dbg(&dma->ndev->pci_dev->dev, "%s()\n", __func__);
 
 	*nplanes = 1;
-	if (vq->num_buffers + *nbuffers < VIDEO_MAX_FRAME)
-		*nbuffers = VIDEO_MAX_FRAME - vq->num_buffers;
 	sizes[0] = PAGE_ALIGN(NETUP_DMA_PACKETS_COUNT * 188);
 	dev_dbg(&dma->ndev->pci_dev->dev, "%s() nbuffers=%d sizes[0]=%d\n",
-		__func__, *nbuffers, sizes[0]);
+		__func__, vb2_get_num_buffers(vq), sizes[0]);
 	return 0;
 }
 
-- 
2.39.2

