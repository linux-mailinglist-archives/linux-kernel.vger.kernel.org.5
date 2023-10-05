Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097497BA01D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjJEOd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjJEObc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:31:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB7822CAA;
        Thu,  5 Oct 2023 03:49:17 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DDFC4660731C;
        Thu,  5 Oct 2023 11:49:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696502954;
        bh=lFr30I+Cr7avNK4wzwGybpTkaEAtq/uM7VOwFYqZwUs=;
        h=From:To:Cc:Subject:Date:From;
        b=K9wZ35FlCGgxB/NKW138gQiIJYWnO/3EuMst1hxKCbXMEHzVpGsaRfzYehABqODKK
         9nf/PW+08IxV+ID1qM2N5A6tAlXn9ciXWA9/py4ikoRRwxcFyv70fQ04Fdv1rVIvLY
         z4YwXjyPfUlajcNrgK9AmXm8Zma8fBA8mKZMkP/LwfE++uE4KbMXkmqYXzaDyFwOFr
         B3ZiDYY6ZZrUIXdaNCj3khhqlltii5P3FfxM++96SZyummWHIu8V3uTYqB30hW4LZY
         QLM1CRCluC4KeS8YHe7ve/gcKguhEg9AfU/0zXMFiQvgPEK9i0ssyhry4wZRm/fCqd
         QzzY24bkIgOyg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mchehab@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, moudy.ho@mediatek.com,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        u.kleine-koenig@pengutronix.de, linqiheng@huawei.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v2 0/2] MediaTek MDP3: use devicetree to retrieve SCP
Date:   Thu,  5 Oct 2023 12:49:03 +0200
Message-ID: <20231005104905.120544-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - Rebased over media_stage master as of 05/10/2023
 - Reworked description of mediatek,scp property in bindings
   - Dropped Conor's and Chen-Yu's R-b tags from bindings patch due
     to the description rework.

Especially now that Multi-Core SCP support has landed, it makes sense to
retrieve the SCP handle by using the "mediatek,scp" property (as already
done in MediaTek VCODEC), both to select one specific SCP core for MDP3
and to avoid walking the parent node to find a SCP node.

AngeloGioacchino Del Regno (2):
  media: dt-bindings: mediatek: Add phandle to mediatek,scp on MDP3 RDMA
  media: platform: mtk-mdp3: Use devicetree phandle to retrieve SCP

 .../bindings/media/mediatek,mdp3-rdma.yaml       |  8 ++++++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.c | 16 ++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.42.0

