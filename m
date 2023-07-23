Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4636A75E03D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 09:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGWHXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 03:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGWHXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 03:23:09 -0400
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76539FD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 00:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690096984;
        bh=uA1bQ6F3ScWTXuQJewjURf1TMDBQ+1aeSJ31bGjC9EM=;
        h=From:To:Cc:Subject:Date;
        b=HR8t/7nZch5w/7x3CAlnp0uundcxkao+AUPmUW36B/pU9csOicHC7B91ilPd70pFs
         xuOxx8KRD0LOQNnaJHP5aDlEmN763xLnjec3df/u+fx4ls41nmeUnD5H0+Mwx/M7Mm
         HKdM4XAQQZI72xjMNgdMBx7cwDajgNe95yuQkpz8=
Received: from localhost.ust.hk ([175.159.123.184])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 5C20A80A; Sun, 23 Jul 2023 15:23:02 +0800
X-QQ-mid: xmsmtpt1690096982tdwknz5eh
Message-ID: <tencent_F05F5B0860B41E180AA0A88B1279376CB508@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2rgist0z0wskKoEKHyOVxX9Znkpt5bRhyb9VtAdlhIo6i1JhRyg
         85XVjr7LzqQo2hEvAHNer49d4uxQ88lRWNu2DBWPx/apGj1htvBM9b39kq4WGUwjmpbS7+F02Ela
         4Pj9yaYx6k/2fG9n017Eurar/JQdprpZAlckyqkjl9Fij8eY3c14jwVbjD9qjUDJf7ny7QrCQGcC
         dZZlqF/ScYLAwKa/jFhk7aO6ahmyjNI7GSGMB9Yt5c0TPVXP8y6g+WZ5okYDfcH0o+cn0KayxY+g
         wDICZtJmz14b9XRWpGLX1JCC9U2dPJJpbTw+13STSNpfZO2Pi2hjVyKq2JyuIqi6bR44TFTtevqV
         JolNeNAc2qWl5TYG2SR7pihCnKahwWkJy2LQrI4LYe65p/B25enCeBrwh5O3AE4UrN5bcmJVmxiv
         o3MLjpSSiZQ9Ckz4I3Sb7h5f0fXHe207Ew2qewUPrMnI1kohVI9QQ+dHv4aZDJrAHTe5Ro8XQKxh
         ue8+vLNKuAeciSgz3+jgyIh6XcnWeeKtC9A9HA7/jfrZh3O67j8rIOgvk7b3Ena9SNYMlyb7xrPm
         blS30s0AVXNN0d3lOFJxOVejmqI04DHSLwjiwHoRxDF+8Amlri0sHdoQwmxuXyk/Zm7JEIY9Xvo0
         Km2cgdM7gIm4aUA512Nu7fja0lcEatO76b3oZ9BHIf8Q8xaXOOvXugR7Qp3tuoZYowoBLnBeT5zm
         0SPi6lZdFBOcbeJNIkAwg8tC6LUJNQwkqxGXxaVVqBQ6/yKZ9hKdP0cSroP98+uetd4Fv/YfKDrw
         dEhQAW3Jq1ZXIFA3WvoXM5kfd+k/BU6l4Cr098EzrnGRD//nc/hqTRo9KLRBTsS+QE/wYHdMQAgK
         nepDWb81U6x9HL8ODKEY38Q8MS07KI5UfoiUeWzteNsTXh0YhNzTCkCD8pwa11gKZnetZkwlt1NP
         J9HKq5GilOccBRXSTwzW2C2DihRBsZQRpSwqGMaRAGD79UOr1C7ui0sOPtYJL1pjgT0DkxdWIz2X
         GiKSkujIgCutDdrN7+
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     oder_chiou@realtek.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] ASoC: rt5668: add missed regulator_bulk_disable
Date:   Sun, 23 Jul 2023 15:23:01 +0800
X-OQ-MSGID: <20230723072301.10106-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call regulator_bulk_disable()

Add the missed call to fix it.

Fixes: d59fb2856223 ("ASoC: rt5668: add rt5668B codec driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 sound/soc/codecs/rt5668.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index f04c810fd710..d66c9e9b9185 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -2452,6 +2452,13 @@ static void rt5668_calibrate(struct rt5668_priv *rt5668)
 
 }
 
+static void rt5668_i2c_disable_regulators(void *data)
+{
+	struct rt5668_priv *rt5668 = data;
+
+	regulator_bulk_disable(ARRAY_SIZE(rt5668->supplies), rt5668->supplies);
+}
+
 static int rt5668_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5668_platform_data *pdata = dev_get_platdata(&i2c->dev);
@@ -2490,6 +2497,11 @@ static int rt5668_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&i2c->dev, rt5668_i2c_disable_regulators,
+			rt5668);
+	if (ret)
+		return ret;
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(rt5668->supplies),
 				    rt5668->supplies);
 	if (ret != 0) {
-- 
2.41.0

