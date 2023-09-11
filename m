Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176E379B26D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347961AbjIKVZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjIKIYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:24:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EAB110
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:57 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-500c37d479aso6641376e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694420636; x=1695025436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoFqFLIfT/Pj/zYgo2TV8TIm3I2iaBuNZRSIlIfashI=;
        b=Sz/xdsGbzAb50fv7LSSeYbW54cSwqmAfepV+Gf2mGArfvEdasNpls9WtoLKIdniGX5
         cfxQooafGXPZsnvEui7qOTUTwEQ4MktL7ghgoFw1l6w8cqwIP7BNCNmLWCjY+S5QhACJ
         2aC2MbhnlvDH5ehStWyoebIV+KleXYMwI0CyZ/DX+Y9XP/Mk9XtL3wIWyxz3E6hUIV3b
         1xx9ubJ6K+2OGe+YR+2OX4reQqyUA/2RKic1Hya7qpzWCRrBdRmUwBwG2UxLuWlJj7Ji
         4waq6AMRCKKm7iQ8JsPs5/e2l4PaKTABlZWUxDSXHrucnbS/HGYwrJVL73GS+iHLYcVi
         I00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420636; x=1695025436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoFqFLIfT/Pj/zYgo2TV8TIm3I2iaBuNZRSIlIfashI=;
        b=lbriFiKUu8QCuZMuzguyMUHPKEr3A4RyYfV/74/rz8VKycAQRmPI2l0rpnfiCAjZ0A
         yC9SyWm/GD91W4Fe7G7KylxeQpESaEgQ3naLq6E0Rd18gU2I22Y1k3q5/WVXGQ4ldWpX
         hUTPpuAb3fp/NMj4IKkNqjFu2Glx5/1gzOYlgFZGPkTBzbzJo1bQ7jF4rNvF/Upc7rTP
         REMZOIBdcf/wtZnwJfzMn8/+el9l86MHWr2rcC+BdZTxap3lYneH1oWu2cvkyISKUoGk
         RGNtosoqwnZ0SGV8zZmd01pCOQdQeykzvi5th85eNYxEKxRvvitOsmvouL4n5MFJm+EO
         aHtw==
X-Gm-Message-State: AOJu0YwiqlPEhsMJsOnYz6DW4RSUktjlI0g9nI3bU2T29Xg84vl0Ug/A
        KxmUPWFzEJdhU3NvzVtHyPi02Q==
X-Google-Smtp-Source: AGHT+IH/CI+1Aa8xWX3l3qD+VArAvLQxWZ8YfL/GW2vDk7MBZhMam+A68zhQz0zu3t/vzQtZwPJeiA==
X-Received: by 2002:ac2:4c48:0:b0:500:c765:bbe with SMTP id o8-20020ac24c48000000b00500c7650bbemr8797463lfk.0.1694420635941;
        Mon, 11 Sep 2023 01:23:55 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b00500968ddca9sm1247712lff.136.2023.09.11.01.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:23:55 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 10:23:54 +0200
Subject: [PATCH v2 7/7] ASoC: max98927: Drop pointless includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-descriptors-asoc-max-v2-7-b9d793fb768e@linaro.org>
References: <20230911-descriptors-asoc-max-v2-0-b9d793fb768e@linaro.org>
In-Reply-To: <20230911-descriptors-asoc-max-v2-0-b9d793fb768e@linaro.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is already using solely GPIO descriptors and
do not need to include the legacy headers <linux/gpio.h>
or <linux/of_gpio.h>. Drop them.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/max98927.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 776f23d38ac5..70db9d3ff5a5 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -15,9 +15,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of_gpio.h>
 #include <sound/tlv.h>
 #include "max98927.h"
 

-- 
2.34.1

