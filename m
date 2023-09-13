Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D62979DE59
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbjIMClo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238165AbjIMClm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:41:42 -0400
Received: from smtp3.hiworks.co.kr (smtp3.hiworks.co.kr [121.254.168.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5571718
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 19:41:37 -0700 (PDT)
Received: (qmail 130652 invoked from network); 13 Sep 2023 11:41:35 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.10.161)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        13 Sep 2023 11:41:35 +0900
Received: (qmail 71941 invoked from network); 13 Sep 2023 11:41:35 +0900
Received: from unknown (HELO saram-MINIPC-PN53..) (mwkim@gaonchips.com@220.88.49.178)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        13 Sep 2023 11:41:35 +0900
X-Authinfo: HIWORKS SMTP authenticated <mwkim@gaonchips.com|220.88.49.178|mwkim@gaonchips.com|230913114135_422671671>
X-MailFrom-INFO: Info <country_code:KR|rbl_level:0>
From:   Myunguk Kim <mwkim@gaonchips.com>
To:     alsa-devel@alsa-project.org
Cc:     broonie@kernel.org, fido_max@inbox.ru,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        u.kleine-koenig@pengutronix.de, xingyu.wu@starfivetech.com,
        mwkim@gaonchips.com
Subject: [PATCH] [v2] ASoC: dwc: fix typo in comment
Date:   Wed, 13 Sep 2023 11:41:04 +0900
Message-Id: <20230913024103.1454354-1-mwkim@gaonchips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ISR_RXFO means "Status of Data Overrun interrupt for the RX channel"
according to the datasheet.

So, the comment should be RX, not TX

Signed-off-by: Myunguk Kim <mwkim@gaonchips.com>
---
 sound/soc/dwc/dwc-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 22c004179214..c71c17ef961d 100644
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

