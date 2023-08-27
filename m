Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9977578A291
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjH0WR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjH0WRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:17:01 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4986B6;
        Sun, 27 Aug 2023 15:16:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DEE05E0002;
        Sun, 27 Aug 2023 22:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693174616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IEBggQJcGAS2ZTc+gnah+Y1oXvRlQWb/y/kodguClMc=;
        b=Aa6BsT7BThDBVLPQsE4BoCEmWtZeyLWKR2IXiOyVlGRZ9GjobAqglzXF9I6NaC0LNQyuYn
        NwU2gaJ+f0Y9iBOt6B1Fx3ZsNZ3n975TeuLkzUy62M6eT0y70lKObV9qViXtiWLWFhQnGa
        nNfP5+z/k1iBMGM6YwglepBtLozr6dDI1SE7T7Q79zOVuSw6fYGIslo4uKqVxz6lYD7kTx
        1zxG3cOkwXZoBmErMO43HsVYhnAdyBeyQh+AzbA74CiaP3KYqDf2KHy5l1easYKjQfCC+M
        hVuthTm4BMrjDOg4LRDszeQLvK52tfxNjaOObqU+uFXPdivU+hMLHCg81t508Q==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] rtc: sun6i: remove unnecessary message
Date:   Mon, 28 Aug 2023 00:16:40 +0200
Message-ID: <20230827221643.544259-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The core already print a message once the rtc is successfully registered,
it is not necessary to print an other one.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-sun6i.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 753a2d9c8a17..8e0c66906103 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -846,8 +846,6 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	dev_info(&pdev->dev, "RTC enabled\n");
-
 	return 0;
 }
 
-- 
2.41.0

