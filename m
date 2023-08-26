Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1087895C9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 12:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjHZKJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 06:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjHZKJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 06:09:27 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183FA1A6;
        Sat, 26 Aug 2023 03:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693044559;
        bh=E32l48gh74u0wKPcn5axJaB36BSlQqywiLukbAdXIo0=;
        h=From:To:Cc:Subject:Date;
        b=pMw0dHheqOETx/42m5JkQ3GvhEjCypxNmxhjYof43QPa0mI0zhCuxA5cN8MbELzLH
         aD862MVItTkqqrSObW6Lh1VskIlYzKjNepWYbL0YssSGPVn96BEr8y+yaVNVmE86rX
         4vhCjqZVQP+0yIeGuBlsp3JkL5UPAFJJ6kEVEW9w=
Received: from KernelDevBox.byted.org ([180.184.49.4])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id B702291; Sat, 26 Aug 2023 18:02:55 +0800
X-QQ-mid: xmsmtpt1693044175tknomh8m9
Message-ID: <tencent_73FCC06A3D1C14EE5175253C6FB46A07B709@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTZp3i9LCvKYDbI9UtNovodc1zIJP/gvVV0C9AiP/tkwAKzErV5Z
         875prIgdlkbQpLlKuuDWJuSxiNTe9ZpBCF6bvFBCPFOYAQEqYccrDWb4p4UIUKm2SJbS2L7BCwaT
         aoVnREjC45OyNfRG5LdTdi2S6Sj8kgyNIvuq5tdodzK1sZv+ovLK1ct+MfiqkEqQZ2F5LSgZPe7P
         VRSTirdwNI0Xr6j6ZCEK3iE0U4PUChNDVVd26cGBOdWBh6/kjJG/URi+TIt57uVcwSg1fwZ5KGRq
         zg4881cK67nDMhzeVGvxsq/sWPLIAv5zUrO+Zu/h4Q+xcAKy7FCBuJaBEtQux0Y2MYCCQcZ+71CO
         49nIUnRSRUsASYy9w0tb78mXeHeSiSe75vFhx63/JDOhGY2t/jvAFioCZgg85EKQsZvcPplEKQGX
         Dd9YGOmaibSR3xNvjFYq1mfq2X23vAp8SrMxlDvVP2LCc/wrN7R4Zb9V6BEtMEYvzrF0sc6jqwlk
         C1hEvrPG1k7yblUPaW5Eafvgp5naHYNqr4ezrlcXyGHHZEMd0+rhi3CV0ewzxqm4/V6+WcIrihao
         rdoY7D4lSPlCF9YPzcXm896zLv5AXU0aNfIbLaBlW7LyKJVKeG6gLVywVx3ROtFoXEFLerSX1fCY
         NXtsngpac08po6cZhVWu8HwL33gWUOyfDP5DoOO7jZ950JRf39/DXdu/CdaT3jQykKVE2rPbXSQm
         TTBxOU0tNz4p+LL+ovIRisVZXr1qWadcmoiVegik36K3YAoZGfM0XuJLfxh//8LoRTIhYG85P9oR
         bpqqvbp+uzSRPUh9cfJXUkbbl2bVXBK+h5Gs+D/cKn3s1Ds+pB94TUjFOnF8fR3QJILE4axHRcKs
         OmWWj85kO/riG3TJQ0AyGoT/r+sboldviGFALGxtnsNJ9UA4OKrbS2ViJOBG7vHkJHsm6yE+x1im
         F8sxgLGCb1a0DMBZ82MDtEspBUhtVJ51bruqFEHr5UbCEGYe8TD2si4XQWpQizhWNDDL4OnHI=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     ldewangan@nvidia.com
Cc:     broonie@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, sumit.semwal@linaro.org,
        christian.koenig@amd.com, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] spi: tegra: Fix missing IRQ check in tegra_slink_probe()
Date:   Sat, 26 Aug 2023 18:02:54 +0800
X-OQ-MSGID: <20230826100254.2197256-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This func misses checking for platform_get_irq()'s call and may passes the
negative error codes to request_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.

Fix this by stop calling request_irq() with invalid IRQ #s.

Fixes: dc4dc3605639 ("spi: tegra: add spi driver for SLINK controller")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/spi/spi-tegra20-slink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 4d6db6182c5e..f5cd365c913a 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1086,6 +1086,8 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	reset_control_deassert(tspi->rst);
 
 	spi_irq = platform_get_irq(pdev, 0);
+	if (spi_irq < 0)
+		return spi_irq;
 	tspi->irq = spi_irq;
 	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
 				   tegra_slink_isr_thread, IRQF_ONESHOT,
-- 
2.30.2

