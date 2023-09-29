Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E952B7B300F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjI2K20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjI2K2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:28:21 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF5C1AA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:28:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bfea381255so229171361fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1695983297; x=1696588097; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aGIn5BggoZuhwKSBFZqt6i9KKk/NG6ZBgEVljtS3j30=;
        b=Qn30jfrGnMd3Nsg/0SrWcnD5L1X5XqFm+COqyp+S3q3Mzax5IfRUhda8FTWDPJnV6x
         DR2GKa9ePcWN6gh4nPTeHCiUl1M1RINi2gvqEC40Gc09c1yLYRI/LFsZcuY8izMn8hG0
         8vDuOb8/tEs1mYAt/O8W5QPyFG4wxem+CzoLLnOpX/YYaxBMPaWUb9qbO4xCN0Cf1NG0
         6/mUmmXSO4zRe6FHMFOT60rG1q3N6MR7wbwb3bNoj2vxyu951eaDop2m89OKjuUhR/t1
         nRN2zHMuZRyiXXai1QPlns2nlUDVts7ej2MzJgnTuq7CR5/pLCQ+zb/rEYEEAeCD2yF9
         rN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695983297; x=1696588097;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGIn5BggoZuhwKSBFZqt6i9KKk/NG6ZBgEVljtS3j30=;
        b=kBeDUutvciHGCnxreosZJllLHMUjciMNH5KjSV9Sa1kGxtnQ/S7jzzgGgR+i5H8Ycp
         4TuBDzEzIMtMPw/biGet9e+N6+ax7Ju0h2A5MZaIhW5FpKWHQP6Vh2uqQyFYjrUL/ruY
         PtFfljLiEVc4oWCOm0Y3PgajP7lpQEzJxunBYqrXNngZXXwq6GOLX/rPwtDh68OhR+1I
         /po+xgbzW/uI49NSZRlXZIXeuN9MjbSADDHsJJu7adaUq7zSoTaXYg8ocrRRn+1xH+jD
         Du8tiXUia46MPnTKeVBWTTjeCOrAZdMzdwjx2TOkQVYU+7dK1HamcnlijkPyzCeIntOL
         BXXQ==
X-Gm-Message-State: AOJu0YwdUVO3xmIjmW7i/FoX8nDmoIHu4bizkGxVszBd3IgiAP9rh1uO
        ZYKP0cOdvpp0ksrv9+pENpSJd+MMUMYanhe/YyhtH8NB
X-Google-Smtp-Source: AGHT+IGGXxf9ux7KQnNBlakripYyXZ+c1ONN4+HqyLiaISzUtZ6brXVPSw8OOLHUQ0z7W6r5ecGl+g==
X-Received: by 2002:a2e:6a02:0:b0:2c0:122a:322b with SMTP id f2-20020a2e6a02000000b002c0122a322bmr3220061ljc.48.1695983297307;
        Fri, 29 Sep 2023 03:28:17 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906584d00b00992b8d56f3asm12165628ejs.105.2023.09.29.03.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 03:28:16 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 29 Sep 2023 12:28:10 +0200
Subject: [PATCH RFC] ASoC: codecs: aw88261: Remove non-existing reset gpio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-aw88261-reset-v1-1-fcbce194a823@fairphone.com>
X-B4-Tracking: v=1; b=H4sIALmmFmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSyNL3cRyCwsjM0PdotTi1BJd81QDgxTLVCNTS1MjJaCegqLUtMwKsHn
 RSkFuzkqxtbUA0iLZj2QAAAA=
To:     Weidong Wang <wangweidong.a@awinic.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the AW88261 datasheet (V1.1) and device schematics I have
access to, there is no reset gpio present on the AW88261. Remove it.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
In case this looks okay, also to the driver author at Awinic, the
binding doc also needs to be updated to include this change and not
require (or even allow) the reset-gpios anymore.

Therefore this is marked RFC for now.
---
 sound/soc/codecs/aw88261.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index 45eaf931a69c..e7683f70c2ef 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -10,7 +10,6 @@
 
 #include <linux/i2c.h>
 #include <linux/firmware.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <sound/soc.h>
 #include "aw88261.h"
@@ -1175,14 +1174,6 @@ static const struct snd_soc_component_driver soc_codec_dev_aw88261 = {
 	.remove = aw88261_codec_remove,
 };
 
-static void aw88261_hw_reset(struct aw88261 *aw88261)
-{
-	gpiod_set_value_cansleep(aw88261->reset_gpio, 0);
-	usleep_range(AW88261_1000_US, AW88261_1000_US + 10);
-	gpiod_set_value_cansleep(aw88261->reset_gpio, 1);
-	usleep_range(AW88261_1000_US, AW88261_1000_US + 10);
-}
-
 static void aw88261_parse_channel_dt(struct aw88261 *aw88261)
 {
 	struct aw_device *aw_dev = aw88261->aw_pa;
@@ -1254,12 +1245,6 @@ static int aw88261_i2c_probe(struct i2c_client *i2c)
 
 	i2c_set_clientdata(i2c, aw88261);
 
-	aw88261->reset_gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(aw88261->reset_gpio))
-		dev_info(&i2c->dev, "reset gpio not defined\n");
-	else
-		aw88261_hw_reset(aw88261);
-
 	aw88261->regmap = devm_regmap_init_i2c(i2c, &aw88261_remap_config);
 	if (IS_ERR(aw88261->regmap)) {
 		ret = PTR_ERR(aw88261->regmap);

---
base-commit: b216fb8946f819cf1b63dc12c7867cc501bda57e
change-id: 20230929-aw88261-reset-7e00d9e25952

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

