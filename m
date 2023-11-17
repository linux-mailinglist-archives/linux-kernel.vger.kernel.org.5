Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9397EEFB3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345833AbjKQKEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345719AbjKQKEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:04:12 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE977B0;
        Fri, 17 Nov 2023 02:04:08 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 38394FF803;
        Fri, 17 Nov 2023 10:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700215447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cl2LjMo9y4kvfDVQJV3DM0tMK1TINYKcgigqy6Qohec=;
        b=RCp2V0P3x9CUu7RYAlP4bUyJuhoBpyrtZtFKsDlc+qoLE942p6cLWUPQpj0Chgvw/U84Rk
        N7BFXpYxvzqWwh8p/Q6B8sAAHG7VkO+hdA70ZLN+i6WUOijmQw//rFh7T1tA40OgU6c2yp
        n4PfRgReGy9U+lnkOtX0YvEXVQpgbVE4yXVSUQAgW/DEZsy67gcKNmNjqcUNpb0KKY7wCG
        LO2v+L22qVI1JLKTuG4sGiw1XEVIzYE4Xv8hubLcv2i72+7J+4Rw5agm+QKiN1PC7qajtw
        VSGllGb8VvGAThztu1xp1gUbCxsdRUe12HLKjszykKIxy8zoVweJDlcQfUprCg==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Fri, 17 Nov 2023 11:03:51 +0100
Subject: [PATCH v6 3/6] dmaengine: dw-edma: HDMA_V0_REMOTEL_STOP_INT_EN
 typo fix
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231117-b4-feature_hdma_mainline-v6-3-ebf7aa0e40d7@bootlin.com>
References: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
In-Reply-To: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "HDMA_V0_REMOTEL_STOP_INT_EN" typo error

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- Split the patch in two to differ bug fix and simple harmless typo.

Changes in v6:
- Mention the typo in the subject.
---
 drivers/dma/dw-edma/dw-hdma-v0-regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index a974abdf8aaf..eab5fd7177e5 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -15,7 +15,7 @@
 #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
 #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
 #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
-#define HDMA_V0_REMOTEL_STOP_INT_EN		BIT(3)
+#define HDMA_V0_REMOTE_STOP_INT_EN		BIT(3)
 #define HDMA_V0_ABORT_INT_MASK			BIT(2)
 #define HDMA_V0_STOP_INT_MASK			BIT(0)
 #define HDMA_V0_LINKLIST_EN			BIT(0)

-- 
2.25.1

