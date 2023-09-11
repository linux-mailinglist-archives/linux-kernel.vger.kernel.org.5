Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F5179A3B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjIKGrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjIKGrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:47:01 -0400
Received: from smtp1.hiworks.co.kr (smtp1.hiworks.co.kr [121.254.168.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627D112D
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:46:55 -0700 (PDT)
Received: (qmail 119038 invoked from network); 11 Sep 2023 15:46:50 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.10.162)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        11 Sep 2023 15:46:50 +0900
Received: (qmail 79196 invoked from network); 11 Sep 2023 15:46:50 +0900
Received: from unknown (HELO saram-MINIPC-PN53..) (mwkim@gaonchips.com@220.88.49.178)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        11 Sep 2023 15:46:50 +0900
X-Authinfo: HIWORKS SMTP authenticated <mwkim@gaonchips.com|220.88.49.178|mwkim@gaonchips.com|230911154650_360978981>
X-MailFrom-INFO: Info <country_code:KR|rbl_level:0>
From:   Myunguk Kim <mwkim@gaonchips.com>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Myunguk Kim <mwkim@gaonchips.com>
Subject: [PATCH] ASoC: dwc: fix typo in comment
Date:   Mon, 11 Sep 2023 15:46:46 +0900
Message-Id: <20230911064646.168181-1-mwkim@gaonchips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes typo in comment

Signed-off-by: Myunguk Kim <mwkim@gaonchips.com>
---
 sound/soc/dwc/dwc-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 71ff894035a4..45e55e550924 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -138,7 +138,7 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
 			irq_valid = true;
 		}
 
-		/* Error Handling: TX */
+		/* Error Handling: RX */
 		if (isr[i] & ISR_RXFO) 
{ 			dev_err_ratelimited(dev->dev, "RX overrun (ch_id=%d)\n", i);
 			irq_valid = true;
-- 
2.34.1

