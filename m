Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D817819BF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 15:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjHSNgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHSNgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 09:36:48 -0400
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA74170A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 06:35:47 -0700 (PDT)
X-QQ-mid: bizesmtp85t1692452053tcp1i7aj
Received: from ubuntu.localdomain ( [58.251.166.13])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 19 Aug 2023 21:34:04 +0800 (CST)
X-QQ-SSF: 01400000000000106000000A0000000
X-QQ-FEAT: 2cOz1NCvlGOiGwoh0vNvreWhIxjT+LXdU+Tpljw+/B+vZQiHTx0NER5oG3359
        8AkIeJoy26siDTa2/1JwLQebgIpmxsFD02O8NSW+h4ghsDTWln3efwcatzoSIcV4NNM/eA8
        FmY0tesl56uZRLIIRLAaG1paph1Pci16/mXLMS3kKH7k7v5GLriSkDlClOHB+aW3ZZPXUDZ
        lqHkn3Y3y21+Gr6Vyjhaw97b1ZW51LQb91Qo7dZu6K3w1SfOGuWTTb+JJNQ/l4Eb01tIBKr
        dhOHQIk5LtyuKhq+UIUPRg0qrR5rKOHuJABY32d4vRCjszgdsEqRLToOlMmjCUJS1h2qvCT
        vEDXZ0iyXvghFCRxWRdUyx2a+46hFtZRzigist84+CAR7xKWQvjIcej352lpQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15894462584696602267
From:   Senhong Liu <liusenhong2022@email.szu.edu.cn>
To:     oder_chiou@realtek.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Senhong Liu <liusenhong2022@email.szu.edu.cn>
Subject: [PATCH] sound/soc/codecs/rt5640.c: fix typos
Date:   Sat, 19 Aug 2023 06:33:45 -0700
Message-Id: <20230819133345.39961-1-liusenhong2022@email.szu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybglogicsvrsz:qybglogicsvrsz3a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed typos and i fixed them.

Signed-off-by: Senhong Liu <liusenhong2022@email.szu.edu.cn>
---
 sound/soc/codecs/rt5640.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 8920726c38e8..15e1a62b9e57 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2570,7 +2570,7 @@ static void rt5640_enable_jack_detect(struct snd_soc_component *component,
 					IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					"rt5640", rt5640);
 	if (ret) {
-		dev_warn(component->dev, "Failed to reguest IRQ %d: %d\n", rt5640->irq, ret);
+		dev_warn(component->dev, "Failed to request IRQ %d: %d\n", rt5640->irq, ret);
 		rt5640_disable_jack_detect(component);
 		return;
 	}
@@ -2625,7 +2625,7 @@ static void rt5640_enable_hda_jack_detect(
 					NULL, rt5640_irq, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"rt5640", rt5640);
 	if (ret) {
-		dev_warn(component->dev, "Failed to reguest IRQ %d: %d\n", rt5640->irq, ret);
+		dev_warn(component->dev, "Failed to request IRQ %d: %d\n", rt5640->irq, ret);
 		rt5640->irq = -ENXIO;
 		return;
 	}
-- 
2.25.1

