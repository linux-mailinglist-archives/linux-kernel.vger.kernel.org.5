Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B56175480D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjGOJyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOJyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:54:03 -0400
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4799A268F
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689414840;
        bh=UpVM55kDs942KIyIZCbP7/8cjNZBSlpLjQ3vWtUWbAI=;
        h=From:To:Cc:Subject:Date;
        b=W6JbsmJObdcaQdvewf/8RwUKllu/6mjri9scVorkj7AGD1aMhMYl56X4bqO9iZMOD
         gl+QePoz3LP7U3U+IEHu7+FfnphAa6fn/5Pqxd3N1Z0A911fY8HOjzr96AfsfxblBv
         SBmJmzjKpMYOCG1/+1MuF36qdv54PiyUzyqXKAh0=
Received: from KernelDevBox.byted.org ([180.184.49.4])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id D792BC5A; Sat, 15 Jul 2023 17:53:57 +0800
X-QQ-mid: xmsmtpt1689414837tvr97vcsh
Message-ID: <tencent_4D4974DE0CD4266C25819179B42888A3E20A@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/P5bMlDWHt42XZlbuAP7IOtLgcr56S2b6SFl47cFJLKPDw3Zd8x
         p72EqDQVEnDzcOZQqqmhByqXK8hxcSLfaPCRg4e9rhEtnRxG3BFTa8JlgI9gUga4gTdY6aAMJgjb
         uO73jir/95rKCRCGaMBS1O/u72LcaEqkhsUUIJ6kLCxYNCVihnxZqi1dSdGGxFTuWAWg5XhX4uYz
         NLLFfBRIsz5lXGqeUYTGu8Z4jG49IggTtTRsuiSJy+bQ/d1GVy2Sr/YYpsGTMub3zwA4RCg3AuKE
         vXPfbuwpaaBuWZnmDI2o8D898OVekZXDffwdFe/lPrZJ+0wzXcbfVrG9DsgsmNel4EfKZpKuScy0
         kgy63qaTX3XM3xLqbS9tQjrUQBe9jRKGoW1BCHvte7lbUOE/v+DZckCncnuodiPdDYy8ftk5mK+a
         e1IuXipIcPalRtYDtS4O7gr+6UQ02TU6F2uu4ld8hDT3qCOcX8nnvl9wPOmmjcabau6wnvztLXsd
         HGDN9IOORlBtFktWBI1u5RXGBaLUSyCPdKRVtHSjS54F46u7aeCfvl3GPjRc6XdcT7WTD3NHtDQI
         7O+mcRLN58lxMaScCByj3HR/TrITaM0Dwqe8/pbC+cbzAK+pAdzu+mcGlRzBZBsbS+A6NMiw5AQ8
         nT5eCBk4GWKkn8Tl2kiPrGpXnrc9Ys9F5kQ41+U0pMXk91/1OK2TCZloIVnxNY27umx/1w081Ewl
         NsZXUYuoOtFVO0JdYFUS62CwGJaXiY1RWXrk8Mr+HCK8aSRRGJOIAauFrAuRmnh/w7JBpdTRqOxK
         7AeMQFm6VWs67FEqJ2h6gHhhxvQ5oka3tMz+LyQDEKv1xcc9gIxMg/ZB2z7j9K2beJhyTFxiO0WN
         tea16zM+YjzZHGi3a+LKx5/SsKLjX93iF5GF3V4Pr5RuioilrEGkFEGup/sL/aNOHGtEf2ltbxNf
         9cTN4AAnomRfGfmD5S47CFu23xOIOPYHt/GWJ0mAD0+ClDPapn8+Ruo8gCS1LwgC+KgRA07UC9Oa
         T2La0xSw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     ldewangan@nvidia.com
Cc:     broonie@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] spi: tegra20-sflash: Fix signedness bug in tegra_sflash_probe
Date:   Sat, 15 Jul 2023 17:53:56 +0800
X-OQ-MSGID: <20230715095356.1507787-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
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

The "tsd->irq" variable is unsigned so this error handling
code will not work.

Fix this by adding error handling statement

Fixes: 8528547bcc33 ("spi: tegra: add spi driver for sflash controller")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/spi/spi-tegra20-sflash.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 4286310628a2..4c18337de813 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -455,7 +455,11 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 		goto exit_free_master;
 	}
 
-	tsd->irq = platform_get_irq(pdev, 0);
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		goto exit_free_master;
+
+	tsd->irq = ret;
 	ret = request_irq(tsd->irq, tegra_sflash_isr, 0,
 			dev_name(&pdev->dev), tsd);
 	if (ret < 0) {
-- 
2.30.2

