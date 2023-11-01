Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FB77DDDFC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbjKAJCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjKAJCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:02:43 -0400
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F869F3;
        Wed,  1 Nov 2023 02:02:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2838174|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0377807-0.000735089-0.961484;FP=12384614467520510894|1|1|6|0|-1|-1|-1;HT=ay29a033018047203;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.VCeegvs_1698829346;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.VCeegvs_1698829346)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 17:02:29 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, wangweidong.a@awinic.com, liweilei@awinic.com,
        u.kleine-koenig@pengutronix.de, yang.lee@linux.alibaba.com,
        nathan@kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] ASoC: codecs: Modify macro value error
Date:   Wed,  1 Nov 2023 17:02:10 +0800
Message-ID: <20231101090211.177125-4-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101090211.177125-1-wangweidong.a@awinic.com>
References: <20231101090211.177125-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

The value of vsense_select should be either 32
or 0 in both cases, so modify the
AW88399_DEV_VDSEL_VSENSE macro to 32.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88399.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/aw88399.h b/sound/soc/codecs/aw88399.h
index 8b3f1e101985..4f391099d0f2 100644
--- a/sound/soc/codecs/aw88399.h
+++ b/sound/soc/codecs/aw88399.h
@@ -522,7 +522,7 @@ enum {
 
 enum {
 	AW88399_DEV_VDSEL_DAC = 0,
-	AW88399_DEV_VDSEL_VSENSE = 1,
+	AW88399_DEV_VDSEL_VSENSE = 32,
 };
 
 enum {
-- 
2.41.0

