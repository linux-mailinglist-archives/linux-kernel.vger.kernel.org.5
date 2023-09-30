Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24FD7B3FC8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjI3J4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjI3J4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:56:02 -0400
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDE3DD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 02:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1696067754;
        bh=bT0oatsp3pkSMaLKyp4Qrnd8ADAIwJtCgQOgUa+Ug6s=;
        h=From:To:Cc:Subject:Date;
        b=TuKoQkK9X8Tv/fYSIyblHvvdW+UufLSrjkAx3URg/JKCmbrNy0KF0zRsaE9btFXr2
         /VmA1LLESWreGNqd7b53bP7rHIehOldJtF1hBpxvrK3HH1I+WTOqLcXUE4K/wikUjP
         z+nS2mehFg77CO5Yu5yQfX98UWNEGOt1NTeWQGqI=
Received: from KernelDevBox.byted.org ([180.184.51.40])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id DF306A2B; Sat, 30 Sep 2023 17:55:51 +0800
X-QQ-mid: xmsmtpt1696067751ty35czsma
Message-ID: <tencent_4F37C9B5315B7960041E8E0ADDA869128F08@qq.com>
X-QQ-XMAILINFO: MBf0q8AysQnBhAPO+DycjfzqE4Ij8dAVEqskp0OipBIJ1hs7gNgQbeHUOFMDom
         jOhD4yriDBYsMsOjrlj14H3u2/egNFnAa8SxkXJumF5w9XcdwgZbCwGmp1knEbPPSuCdd3vI3rxH
         89PT7Y4FgpwBCBVrTGpY47mcsPpOYU3N3tdCGrlPP3XpfPj10kyEG2GFZj7E0WXKI0DOi04N+J5R
         BErCXvlfI/e+dj0/+BhdP8oJLS65iw2+9ic2EwexRHeKhdNXnljqyL/gQ2MBB5dVLe4kgjIYZEUI
         OVLOGzEWyQE/kJBDr5Ai2Xc7BTcTAWv2VN9MLgDRoIc9ZU9eL1BgpcW1o67/jD3OPYsAAdWfmoLG
         1SBr4e9b4cDQAHkwwat7U4ra+Bw7s2mFk3j9FYV8pobC4wvgsPRqHNUEWZm4Fy/goBHvJsN4I07T
         OjgQruxTHdaxYjbrudqRKBB6Z/yhFB13Hfigc49YnNWhRsn6cbrf/px/7ZuK5ECWbjkT31tdgwxh
         ruwe0/C7zH2KhiYxBHtpgFBFEMxVUoF9Q+dZpq7z9AKuHIJtpflK4LJNNqRcgopVXkUvNCdvvhC4
         OhAcrVjTwT/27ZDZYN+DqY/1wZXCDRRH0DQNd0r4stLaBA7bUfmqlAv3NxBSzaciKJyLo++iMP4S
         FCsvhT+V1FmhvwaeWfu/Vl7i2EvkUYmUDqq7/zR4QqByZHDMTdXf8B8HtR6ESBgQCE9Uypf1E/vo
         uQGzwjkGiwY8mq83BuovzaPJKAc+7VfzgaU6Kvl6vfmTmu9AN1oclynyAQbv7lAUit/71Z0yFpkn
         z/KDzb0Z4yyrCX1tzIASdjJqIOb+YdIvLvlRh8imNubfgnURz3egLq6+4EDTOp14ttjee4iVjigv
         6BQ2RoW2aF08NLhpKKakMNeffpQ5MWmTPKwr2sFeZUCdFORoG9N4mKPvOfe5haJU36OapYsHiQ12
         jW0muUv6qqW4t18uxamGutGbUL0mYv0fEhK6rM2LPzrqd48xxrpFSiPJkjJasx
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     oder_chiou@realtek.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] ASoC: rt5682: Fix regulator enable/disable sequence
Date:   Sat, 30 Sep 2023 17:55:50 +0800
X-OQ-MSGID: <20230930095550.99344-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will attempt to disable the regulators if the initial enable fails
which is a bug.

Fix this bug by modifying the code to the correct sequence.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 sound/soc/codecs/rt5682-i2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index b05b4f73d8aa..fbad1ed06626 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -157,11 +157,6 @@ static int rt5682_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&i2c->dev, rt5682_i2c_disable_regulators,
-				       rt5682);
-	if (ret)
-		return ret;
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(rt5682->supplies),
 				    rt5682->supplies);
 	if (ret) {
@@ -169,6 +164,11 @@ static int rt5682_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&i2c->dev, rt5682_i2c_disable_regulators,
+				       rt5682);
+	if (ret)
+		return ret;
+
 	ret = rt5682_get_ldo1(rt5682, &i2c->dev);
 	if (ret)
 		return ret;
-- 
2.30.2

