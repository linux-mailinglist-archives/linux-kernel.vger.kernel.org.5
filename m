Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC97C7C844B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjJMLU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjJMLUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:20:24 -0400
X-Greylist: delayed 1037 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Oct 2023 04:20:20 PDT
Received: from vps19.webwerkers.nl (vps19.webwerkers.nl [136.144.231.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62F891
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:20:20 -0700 (PDT)
Received: from [89.255.59.226] (helo=server.mep)
        by vps19.webwerkers.nl with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <roy.chateau@mep-info.com>)
        id 1qrFwM-0005kS-DX; Fri, 13 Oct 2023 13:02:46 +0200
From:   Roy Chateau <roy.chateau@mep-info.com>
Cc:     roy.chateau@mep-info.com, Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: tas2780: Fix log of failed reset via I2C.
Date:   Fri, 13 Oct 2023 13:02:39 +0200
Message-Id: <20231013110239.473123-1-roy.chateau@mep-info.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: meptelco
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correctly log failures of reset via I2C.

Signed-off-by: Roy Chateau <roy.chateau@mep-info.com>
---
 sound/soc/codecs/tas2780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2780.c b/sound/soc/codecs/tas2780.c
index 86bd6c18a944..41076be23854 100644
--- a/sound/soc/codecs/tas2780.c
+++ b/sound/soc/codecs/tas2780.c
@@ -39,7 +39,7 @@ static void tas2780_reset(struct tas2780_priv *tas2780)
 		usleep_range(2000, 2050);
 	}
 
-	snd_soc_component_write(tas2780->component, TAS2780_SW_RST,
+	ret = snd_soc_component_write(tas2780->component, TAS2780_SW_RST,
 				TAS2780_RST);
 	if (ret)
 		dev_err(tas2780->dev, "%s:errCode:0x%x Reset error!\n",
-- 
2.39.2

