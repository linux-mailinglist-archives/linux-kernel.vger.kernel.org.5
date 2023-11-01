Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF297DDDFA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjKAJCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjKAJC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:02:29 -0400
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B622F1;
        Wed,  1 Nov 2023 02:02:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1985962|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0107958-0.00031274-0.988891;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.VCeegnI_1698829339;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.VCeegnI_1698829339)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 17:02:22 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, wangweidong.a@awinic.com, liweilei@awinic.com,
        u.kleine-koenig@pengutronix.de, yang.lee@linux.alibaba.com,
        nathan@kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] ASoC: codecs: Modify the maximum value of calib
Date:   Wed,  1 Nov 2023 17:02:08 +0800
Message-ID: <20231101090211.177125-2-wangweidong.a@awinic.com>
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

The maximum value that calib can set should be
consistent with the maximum value of re.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88395/aw88395.c | 2 +-
 sound/soc/codecs/aw88399.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/aw88395/aw88395.c b/sound/soc/codecs/aw88395/aw88395.c
index 77227c8f01f6..3c459a67ad0c 100644
--- a/sound/soc/codecs/aw88395/aw88395.c
+++ b/sound/soc/codecs/aw88395/aw88395.c
@@ -356,7 +356,7 @@ static const struct snd_kcontrol_new aw88395_controls[] = {
 		aw88395_get_fade_in_time, aw88395_set_fade_in_time),
 	SOC_SINGLE_EXT("Volume Ramp Down Step", 0, 0, FADE_TIME_MAX, FADE_TIME_MIN,
 		aw88395_get_fade_out_time, aw88395_set_fade_out_time),
-	SOC_SINGLE_EXT("Calib", 0, 0, 100, 0,
+	SOC_SINGLE_EXT("Calib", 0, 0, AW88395_CALI_RE_MAX, 0,
 		aw88395_re_get, aw88395_re_set),
 	AW88395_PROFILE_EXT("Profile Set", aw88395_profile_info,
 		aw88395_profile_get, aw88395_profile_set),
diff --git a/sound/soc/codecs/aw88399.c b/sound/soc/codecs/aw88399.c
index 47fe38d0def5..1d6228cb1cc2 100644
--- a/sound/soc/codecs/aw88399.c
+++ b/sound/soc/codecs/aw88399.c
@@ -1710,7 +1710,7 @@ static const struct snd_kcontrol_new aw88399_controls[] = {
 		aw88399_get_fade_in_time, aw88399_set_fade_in_time),
 	SOC_SINGLE_EXT("Volume Ramp Down Step", 0, 0, FADE_TIME_MAX, FADE_TIME_MIN,
 		aw88399_get_fade_out_time, aw88399_set_fade_out_time),
-	SOC_SINGLE_EXT("Calib", 0, 0, 100, 0,
+	SOC_SINGLE_EXT("Calib", 0, 0, AW88399_CALI_RE_MAX, 0,
 		aw88399_re_get, aw88399_re_set),
 	AW88399_PROFILE_EXT("AW88399 Profile Set", aw88399_profile_info,
 		aw88399_profile_get, aw88399_profile_set),
-- 
2.41.0

