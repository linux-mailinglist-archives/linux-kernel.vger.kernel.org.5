Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA8175DD49
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 17:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGVPta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 11:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjGVPt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 11:49:28 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD06C1A7;
        Sat, 22 Jul 2023 08:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690040963;
        bh=PNBFOjg7o3EsVn1+13sq+jz+GGQ7ZM8w4tTYDhjxZYo=;
        h=From:To:Cc:Subject:Date;
        b=RiOjgJXYjXTk/4Cdv/9cqhlA6q0RhfJzt8H25VE1XjHkQWepCUjzAgcCS/Y2Hs5cL
         rM+Aaz7ugKtJmU+e7PlZ0TfW6xnREq7agfuLIWgMzr1BSc+DveEjUcim3DRGe5KPXu
         qIWpiMn/suJp/ghpGMdiXjsgJO8KONmUMULLpFb0=
Received: from localhost.localdomain ([220.243.131.5])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id C4F0A816; Sat, 22 Jul 2023 23:49:15 +0800
X-QQ-mid: xmsmtpt1690040955tzlo14pwo
Message-ID: <tencent_71FC162D589E4788C2152AAC84CD8D5C6D06@qq.com>
X-QQ-XMAILINFO: OZyNKfa8hWsKegdNMjRht8zBupmv5rz+fjyGdrH6G3cBWhYH6H6WXJlbSFGvHn
         89H3NJtLTaVY+GVnsgQ7vtKLDppY4P5dU6hsbsogyavp3ZlciYpbgGP8p6Us7637iNX5ogmZGZuL
         Nf7M+wlxG4vkYhJGALLPzU4fAg1SpJG1Wwy/jkt1ivsbVOvv2yPjcVlGs3S4TvJqsfm7Gro3MINL
         yVajRMUanIsgylVsrh/A/6TG426FvD83WW46bXX7mw3d1BE8qCy8QmULuFwZKGDlfj0k8rlX2ejc
         jhBliTTBJzS3h+m1Mbm9/WnlnGWeRtwfqPypmWbWkkLop3XDPfBfp8387ZMV0M3gf0IAgCrvgD3/
         UUIACTP49iibKci/o92/ujiOqF+dDVrp1RUzhN338p9/dr36lPh2LjJwt2aC6FRtP/MDkp9y9and
         2tt87FYVL1FbzsiCFTIDzD/LKP4VQD1dGiEmLbjHLOjdu4/8bWRi/KnNyMiBVljG7t4fOrAO2tNL
         /NibwyXCM1rKtuVsR8KPTLoSYE+KaCJaTMhLAi5tsifbQiNbIYKGQvLzXvqWRqalEyMv4ws/M4k3
         oVwPJwgVaO7eg3SxAb2Jv4u0OjjRpvaxJ4aQRHjGAHANa/+VQ2J69iNPNgKVrSLquLOLOUpsWnTF
         gBtDW0dkjG55rjZlsmfjkfi1WoWvXqc/ypLgpvRhpEgfp1PJsc5zizrFev/Y80oxRlmH5dXKZRjz
         3gFfR8wXON4IQFZl0BwmM9PTbOsz3NbVJeNDTbfwi4hwZtP2hn1P3NvcyDPGYjNzKFtuMRcPFUQN
         2sZDG9G7GFC5JFUfdvuMjy57rANAN6XFXcrM9NZc5N64kVwdNOuEUE6Xm239kt/eqK+pZFN/uCU6
         LkZ2zn4mvm67mC2Vd2CTBQrwK1bef4xc1D4zA8gKQ6nR3MFtDjwfryC9e1xByTK02mf3i6ZOHYlf
         ZfYQCPJRs2kSBn3FvIc/tUNhlGMFICT+IlKFaVQ0Ne/nRW9vJMLoRz1cUjdyB/hTAt7dxL8FU7iL
         dwwN8/hw904FXCQHQqYO+n4moQsos=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     thierry.reding@gmail.com
Cc:     ldewangan@nvidia.com, broonie@kernel.org, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH v2] spi: tegra20-sflash: fix to check return value of platform_get_irq() in tegra_sflash_probe()
Date:   Sat, 22 Jul 2023 23:49:09 +0800
X-OQ-MSGID: <20230722154909.22413-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_get_irq might be failed and return a negative result. So
there should have an error handling code.

Fixed this by adding an error handling code.

Fixes: 8528547bcc33 ("spi: tegra: add spi driver for sflash controller")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
Changes in v2:
- reworded the commit message.

 drivers/spi/spi-tegra20-sflash.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 4286310628a2..0c5507473f97 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -455,7 +455,11 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 		goto exit_free_master;
 	}
 
-	tsd->irq = platform_get_irq(pdev, 0);
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		goto exit_free_master;
+	tsd->irq = ret;
+
 	ret = request_irq(tsd->irq, tegra_sflash_isr, 0,
 			dev_name(&pdev->dev), tsd);
 	if (ret < 0) {
-- 
2.41.0

