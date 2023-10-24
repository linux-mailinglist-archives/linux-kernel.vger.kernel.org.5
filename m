Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5657D482E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjJXHPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjJXHO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:14:58 -0400
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E43110CB;
        Tue, 24 Oct 2023 00:14:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3180432|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00854121-0.000347876-0.991111;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.V6azq2U_1698131681;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.V6azq2U_1698131681)
          by smtp.aliyun-inc.com;
          Tue, 24 Oct 2023 15:14:48 +0800
From:   wangweidong.a@awinic.com
To:     broonie@kernel.org
Cc:     13916275206@139.com, ajye_huang@compal.corp-partner.google.com,
        alsa-devel@alsa-project.org, arnd@arndb.de,
        ckeepax@opensource.cirrus.com, colin.i.king@gmail.com,
        conor+dt@kernel.org, dan.carpenter@linaro.org,
        devicetree@vger.kernel.org, harshit.m.mogalapalli@oracle.com,
        herve.codina@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, liweilei@awinic.com, perex@perex.cz,
        rf@opensource.cirrus.com, robh+dt@kernel.org, ryans.lee@analog.com,
        sebastian.reichel@collabora.com, shumingf@realtek.com,
        tiwai@suse.com, trix@redhat.com, wangweidong.a@awinic.com,
        yijiangtao@awinic.com
Subject: [PATCH V2 2/4] ASoC: codecs: Modify max_register usage error
Date:   Tue, 24 Oct 2023 15:14:17 +0800
Message-ID: <20231024071419.85647-3-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024071419.85647-1-wangweidong.a@awinic.com>
References: <21bfa0bb-d936-402d-9ca9-6bcf181a0f35@sirena.org.uk>
 <20231024071419.85647-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

Modify the value of max_register, otherwirse
the AW88261_EFRL1_REG register will not be
accessible.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88261.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index a697b5006b45..0db7a0a3c179 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -20,7 +20,7 @@
 static const struct regmap_config aw88261_remap_config = {
 	.val_bits = 16,
 	.reg_bits = 8,
-	.max_register = AW88261_REG_MAX - 1,
+	.max_register = AW88261_REG_MAX,
 	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
 	.val_format_endian = REGMAP_ENDIAN_BIG,
 };
-- 
2.41.0

