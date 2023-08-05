Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E79C771082
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 18:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjHEQWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 12:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHEQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 12:22:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9618A10F8
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 09:22:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe45481edfso20748525e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691252549; x=1691857349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNfDyfwYBpzfaoZbAIE6EgJYECHgCylif4C/yupq9CQ=;
        b=niWJpZG0OU/zQcYy9oz1AuH4Rjto9ldCL8tUU8Y3Bzn+B8AjIgiBpFJt00QELZHSjD
         RrBstF67mpu+EHTtmVoIuCJAkCpNtRKGSCXqgT7hN8j+5+CVwNXRjB3QvW4ikRwGGtLS
         qEgtK7P4ZOg6gX3g14oN5+IYZXkMwKS22pKqZ3+I3wItRser25ryzmS4FqDlRXs0E/0K
         7APPoo6PU7JC1ife9DgkOT2bBpPdZn71URlDeBzyyYrMEN0ZzkK7GIfOzMSfrbz9838M
         6ttO8QP3HvLG9ViVCQrbrZSuBs85pC4VclwY1bb5SQ0tVNY9bT6IQ67dY0hxY3O2cDOZ
         3P1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691252549; x=1691857349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNfDyfwYBpzfaoZbAIE6EgJYECHgCylif4C/yupq9CQ=;
        b=EU95PkitVbBRqp28GDpYfM5Nkt7JcgrJ540Xf4UUjvrVCb4xh/KB2Q5cmznHtdmuV/
         jctwir4zbIY30v2EOBsDLwQhq/f7TPftE0q8k7KgQ3H+AHfUK8FDJWvTbi747UpXYW0T
         ZeIIL+Ho2Oq7F+E3tvbvbjY+CEqZWmxpr+hRGRL6yy4It256ecQVa+sF5/KHvzaJwhav
         3lup4+cECP0eyrFzuh1Z5vFz8/fqKrKnmWMWo7KnpI15/sdZ0a4ATlYQKk1O6CxlupM4
         mp1h2eQyI6ZS3ILUBaLgBa2i+XTVkr3YjDoH++Oczh1I3NuSEee+UdxM/iNonj9N7iOR
         +0jg==
X-Gm-Message-State: AOJu0Yxwi3+9CMV6S8w+jACV5kBgkVCsdvAUh8/ifeuQkyHDp7DsvCKH
        wFjsm1JYYwUSbGMSL0V7/TWOo9c3NxY=
X-Google-Smtp-Source: AGHT+IFV27M6Ye2RYbBMYwaesczoiT6wmLBTABsbL3gUj4lS4oWUaB3lniwbPRZtWNUdbUQRVSoN1w==
X-Received: by 2002:a7b:cb95:0:b0:3fe:374f:f7fd with SMTP id m21-20020a7bcb95000000b003fe374ff7fdmr4008716wmi.33.1691252548785;
        Sat, 05 Aug 2023 09:22:28 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id q7-20020a1cf307000000b003fa98908014sm9733202wmq.8.2023.08.05.09.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 09:22:27 -0700 (PDT)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ASoC: amd: acp3x-rt5682-max9836: Configure jack as not detecting Line Out
Date:   Sat,  5 Aug 2023 19:22:16 +0300
Message-Id: <20230805162216.441410-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RT5682, RT1015 and RT1015p codecs used in this driver do not seem
capable of distinguishing Line Out connections from Headphone, but
the driver configures its jack object as if it can. Remove the wrong
value from the jack creation call to avoid any confusion.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
Depends on [1] which applies onto of linux-next. Untested, see [2]:
[1] https://lore.kernel.org/alsa-devel/20230802175737.263412-5-alpernebiyasak@gmail.com/
[2] https://lore.kernel.org/alsa-devel/3d6794c9-60d3-b8f3-99d2-afdc69593d9f@gmail.com/

 sound/soc/amd/acp3x-rt5682-max9836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 3bf7e1e83c36..28ad5f5b9a76 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -98,7 +98,7 @@ static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
 	rt5682_dai_bclk = clk_get(component->dev, "rt5682-dai-bclk");
 
 	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
-					 SND_JACK_HEADSET | SND_JACK_LINEOUT |
+					 SND_JACK_HEADSET |
 					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
 					 &pco_jack,

base-commit: 626c67169f9972fffcdf3bc3864de421f162ebf5
prerequisite-patch-id: 7158530856f8f97324906b342528a5ffe7b4032b
-- 
2.40.1

