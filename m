Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B1879F60A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjINBBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjINBBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:01:20 -0400
Received: from smtp1.hiworks.co.kr (smtp1.hiworks.co.kr [121.254.168.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8247B170F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:01:14 -0700 (PDT)
Received: (qmail 55475 invoked from network); 14 Sep 2023 10:01:10 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.10.162)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        14 Sep 2023 10:01:10 +0900
Received: (qmail 103483 invoked from network); 14 Sep 2023 10:01:11 +0900
Received: from unknown (HELO saram-MINIPC-PN53..) (mwkim@gaonchips.com@220.88.49.178)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        14 Sep 2023 10:01:11 +0900
X-Authinfo: HIWORKS SMTP authenticated <mwkim@gaonchips.com|220.88.49.178|mwkim@gaonchips.com|230914100111_5864103031>
X-MailFrom-INFO: Info <country_code:KR|rbl_level:0>
From:   Myunguk Kim <mwkim@gaonchips.com>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, fido_max@inbox.ru,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, mwkim@gaonchips.com, perex@perex.cz,
        tiwai@suse.com, u.kleine-koenig@pengutronix.de,
        xingyu.wu@starfivetech.com
Subject: Re: [PATCH] [v2] ASoC: dwc: fix typo in comment
Date:   Thu, 14 Sep 2023 09:56:34 +0900
Message-Id: <20230914005633.2423696-1-mwkim@gaonchips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <64683b6c-1e31-4037-a47d-b8a19ea77c72@sirena.org.uk>
References: <64683b6c-1e31-4037-a47d-b8a19ea77c72@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch is obviously corrupted, the { there should be on the prior
> line and even fixing that by hand there appear to be some other issues.

The patch file should have been attached as shown below. 
Is there a problem with my git send-email?

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

Thanks,
myunguk

