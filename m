Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F417B4C42
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbjJBHH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjJBHH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:07:26 -0400
X-Greylist: delayed 2162 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Oct 2023 00:07:22 PDT
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFA6BC;
        Mon,  2 Oct 2023 00:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1696230440;
        bh=/va6eC4+0cEIiwSVm3cTBhnxHL1n1Ys42lzQlFSbemA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EH5353Zm1ORPKHjjH35V0B5RfmVJZBe8YuquinZrDw7sKsMlG1Tlsc5+zXIFSNY94
         u9WBuRDm8lKmoGMnx95+NaqebNj1nwwlgJCEuedU/lF+BYgx+128MZEUdGkseGdkeZ
         fjQhqiZ6unQXUsiyO/W96ekdLyn1gP21y2gcnbW4=
Received: from localhost ([124.78.196.55])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 7D027EE0; Mon, 02 Oct 2023 14:31:16 +0800
X-QQ-mid: xmsmtpt1696228276t3iuj484p
Message-ID: <tencent_E465261B2BB2C1EBAF5C19912B9F19B7E107@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjFJK57+xHWtgp8Z39avrTzcuiK+PjLSh5axQe5xVL+LS3/vkmak
         04R/P60x5pNZylcwXW4N3oapc9mgvzwLudqmrxKo28ib34Tl13D2cqrUCQTjcD+MjjBDyvQvukvq
         BcsilxEc2SSPTn+n1IdDPDB9qegPhUsqeT4G0wWn+ijKYbSleaCx6VQchRvU9e75owWkxhyw/p8h
         a7TQTm0Fwn0EU2zBa/T4NjkFhXRN0kY218B0HjA9S6X6Cd07NcGXI2+u2InqDrS6+7Fuz+9FeTnu
         0PilEjcl6eufObl0uFrKy5/dXnyeRwejqFOshgUwQzBeSNCFtHS4XGzBQ4qCQGDHdCwefGFhyNLm
         0VKYqaUycHLvERKALUrbBvaT/FycmJy2EPxxYJldf5T9ugHas4XePfN/lQdGZwDrlkZ5hIBGc1wi
         A8LQkf+NkNUKgG2cyWB2X52KQLlRX2ttutj5oGOHG/Sw5J8qERJqrcFQjaKkhdT7YPIttQuhCYgD
         3AsaYPz3eR0Zq1Sa5GovJ+bUTUm6R+L9niqvAiD6vs37Ki989fqlZbDiI1LmxNiYKnoCtiVPLzMT
         SIbROkkG9s1ylHbpbnkyI6sCgUdoriTWjD0+KZ5bpGWLVNz7YQIQwwJKKQFPAtHFRk5qxl9PdBMQ
         BT3KCln0BDMfXljPlP5fQ14Hm6d87COuhmhUacfieBAO7Z127FsHXZPcl2b9VV49v8yXp5Pi3gi7
         kMaXbUe44lGXHWuKyk+ZYBdIc386DblEMHE25czUzAaVrU/Kf7KGORLPtddIegnayvWeZPB2nxpF
         pV/G0rm2l8XitFf3/e+WgTgOYZEK9TBohuwNKnnOM1kpiFOkfpJM83+/kZVezAucdnnAcXgmxp9N
         WQIjeSamjCupVzEeBXzvMbNkp1UAyy1trJMDSwVv5UYzHfA9tWHW71Jr7619giCzv8i3i+eb5E4V
         YtT0oKCQmKPBESBQl3EKfm8E6ss8AYRWFRpInXcNjTHZQ2bnX+bQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From:   Woody Zhang <woodylab@foxmail.com>
To:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Woody Zhang <woodylab@foxmail.com>
Subject: [PATCH 2/2] spi: sun4i: Fix memory leak on device removal
Date:   Mon,  2 Oct 2023 14:29:59 +0800
X-OQ-MSGID: <20231002062957.1741396-3-woodylab@foxmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002062957.1741396-1-woodylab@foxmail.com>
References: <20231002062957.1741396-1-woodylab@foxmail.com>
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

Call spi_master_put to free the spi_master structure on device removal
and driver detachment.

Signed-off-by: Woody Zhang <woodylab@foxmail.com>
---
 drivers/spi/spi-sun4i.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index b8947265d329..ba5690039f72 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -518,7 +518,10 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 
 static void sun4i_spi_remove(struct platform_device *pdev)
 {
+	struct spi_master *master = dev_get_drvdata(&pdev->dev);
+
 	pm_runtime_force_suspend(&pdev->dev);
+	spi_master_put(master);
 }
 
 static const struct of_device_id sun4i_spi_match[] = {
-- 
2.39.2

