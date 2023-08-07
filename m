Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F09771786
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 02:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjHGAnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 20:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGAnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 20:43:03 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D050B1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 17:43:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vp7CMlG_1691368978;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vp7CMlG_1691368978)
          by smtp.aliyun-inc.com;
          Mon, 07 Aug 2023 08:42:59 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm: bridge: dw_hdmi: clean up some inconsistent indentings
Date:   Mon,  7 Aug 2023 08:42:56 +0800
Message-Id: <20230807004256.25609-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c:332 dw_hdmi_cec_suspend() warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6101
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
index be21c11de1f2..14640b219dfa 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
@@ -329,9 +329,9 @@ static int __maybe_unused dw_hdmi_cec_suspend(struct device *dev)
 	struct dw_hdmi_cec *cec = dev_get_drvdata(dev);
 
 	/* store interrupt status/mask registers */
-	 cec->regs_polarity = dw_hdmi_read(cec, HDMI_CEC_POLARITY);
-	 cec->regs_mask = dw_hdmi_read(cec, HDMI_CEC_MASK);
-	 cec->regs_mute_stat0 = dw_hdmi_read(cec, HDMI_IH_MUTE_CEC_STAT0);
+	cec->regs_polarity = dw_hdmi_read(cec, HDMI_CEC_POLARITY);
+	cec->regs_mask = dw_hdmi_read(cec, HDMI_CEC_MASK);
+	cec->regs_mute_stat0 = dw_hdmi_read(cec, HDMI_IH_MUTE_CEC_STAT0);
 
 	return 0;
 }
-- 
2.20.1.7.g153144c

