Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B1876B941
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjHAP72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjHAP7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:59:18 -0400
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B541736
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690905555;
        bh=OMeXsTEoSV37i5q3b+jlJxSVQJjMWTEe0h/gT1sAYts=;
        h=From:To:Cc:Subject:Date;
        b=cxHgVw41sK85rVmq1LgQhaDfKejjLFw/fs+pqRWFl+Oj3QxWMXLz24scrxIck7MJn
         eriTVrFLdzGnufYCr73opSu45rDDxqzD2L1PRnjm7bA7fiMWDuVDlQOlZCatOPtQnR
         n6pWhT/10Z7lN2boEf1MF8EfWfTd84ya2AX0OsoE=
Received: from KernelDevBox.byted.org ([180.184.51.134])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id ECCB1097; Tue, 01 Aug 2023 23:59:12 +0800
X-QQ-mid: xmsmtpt1690905552tyfhwer0f
Message-ID: <tencent_A560D01E3E0A00A85A12F137E4B5205B3508@qq.com>
X-QQ-XMAILINFO: NGS5xw3DVfAMV/jfbZlCf9owjwKZJdc3ehD5Gs0w53jsUCSTCupG6mehI+9XiQ
         uXUUz5H8aBY/XIKy9L6NsIq/3YoujfAQN2JwExL7Kl2PVe1wmxQtqGeXQjWXMd+lxX7p6tm1mXix
         MkMo4Mmm4aFi/v4OD2ANDG5xylKl9J6H6HNvY/WmuudbwgVRDSswAJi5svJFF6dOFWkIEAz7IVjZ
         74yYk9MkQli4YXGENrXXJXfONnFxdxoiPO988ZMSaZS0l7GiLStQIy/lY9dZoiedHvts0gczYPZY
         BWPgLq3mlLYK6iAxiH4xAlY2KkPGNA8Xv9LObpMyRqqwSLrsblrxrvLhxL53U/96utkUSD6iMIeo
         nsVcfQwXKOQlP/B9wGjaxVtc0N6y7FYmB/5flfRfQW6KANAsH7jv7CwTjIadrDnYCsvHpjUro5rR
         0IlZ8+yXg3KG44KrXMPFWdxYHvibSXIw85NkJ+/xYQ5anwyuGAe0scJO8uYgrjOTaN5MvyRD1dST
         Rr7TjrHTHF2su1kXAPnnyq04g83Ozp9iyLqmBpBp3oPvIYPhI5BimwcZUodKMnIk3WAnohowjV7Z
         zOcMK/hepZQVDukqM7kMOU9osC0fXBrk9hdehVk7qHSsTjEx1UHESFUEWubSuvggn9qGdHIFY7tA
         RY3ireifn37EbPmjUdUIgpxv+6n0y7Rq1Xeg+ZLIlQqNeuW6Es49rv4JS8dcs+kWe1OwE6FI3uCa
         S+BSS8vSydaExCqfqIrBmBNAqdg4mdd9AJf32mYXm4uSEnEIEo7jZT0OnfhHkzhGJ/LzaoLroXc7
         xZcupIy4mk0KJPSb/Zpect3SvgzKAdPNEbA3H+p5puq3ajD33g63C67af2PuJjWpWe/3myNAWn0W
         oknMsFGurP/K0TrKyzq46RFZRL8H2qIND38vVntWugtZqbWUPXF0NZMLL1oD48afO5HwBBSVAO/x
         cyyty2ptUVyMYqLeSeucMT/SYpTdHUe97ZWEOUpCUGt9Rqj4/dHqjkRlICiedJhSEiMAwKyg6kH6
         gNZ5kf+Q==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     broonie@kernel.org, oder_chiou@realtek.com
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH v2] ASoC: rt5665: add missed regulator_bulk_disable
Date:   Tue,  1 Aug 2023 23:59:11 +0800
X-OQ-MSGID: <20230801155911.372244-1-zhang_shurong@foxmail.com>
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

The driver forgets to call regulator_bulk_disable()

Add the missed call to fix it.

Fixes: 33ada14a26c8 ("ASoC: add rt5665 codec driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
Changes in v2:
 - move regulator_bulk_disable() in rt5665_remove() 

 sound/soc/codecs/rt5665.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 83c367af91da..525713c33d71 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4472,6 +4472,8 @@ static void rt5665_remove(struct snd_soc_component *component)
 	struct rt5665_priv *rt5665 = snd_soc_component_get_drvdata(component);
 
 	regmap_write(rt5665->regmap, RT5665_RESET, 0);
+
+	regulator_bulk_disable(ARRAY_SIZE(rt5665->supplies), rt5665->supplies);
 }
 
 #ifdef CONFIG_PM
-- 
2.30.2

