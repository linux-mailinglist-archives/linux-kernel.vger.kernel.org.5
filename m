Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DF979BC94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbjIKU43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjIKIYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:24:01 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0BA1A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:53 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bf66a32f25so46836301fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694420631; x=1695025431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dl5LD8wtUJwzoyPBhKwaRw4zVOgRkHeCisg4Hejkfc8=;
        b=CPJzVZwZ6nAd2/iVayrm1htU7ruJ2dUM+qm3kMCBvN3jMYuAPHPumDHMlAz26vUNj8
         tF+rQaMr3pTdaBMkiY/0R5rbGkE4kZ3SsyT4Od3WQ6f+vRDRMZzSOWvF2RMSd6yXV13e
         UL9/lBGy7/czbaU4LLcoUfp1ykwdZjypNpCzZBz33nbT57UN72b1Ill3Vcz6WTY3yxGH
         IcDk4EzI4xH3xclNQX/bz3SOCz2umNk6OH41DUBO8aUSY46VActWS1PfmkyPYFc1Pw+x
         2lWuCerU2PmJ1Bd9OgMPoxl7iKIUgnJSsHYius6PB549QFs7quA+kTVn89qHZDA5OVN5
         RLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420631; x=1695025431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dl5LD8wtUJwzoyPBhKwaRw4zVOgRkHeCisg4Hejkfc8=;
        b=uAHdcnFn4z/ltNTVChu4QSBh0KKKwX2chyFApWXkbmw5621XD6CvakcqVGypzwAMnc
         OAszR0jjKznoH12j/l5GeZY32Ox/JKXJC0pDNlonDRJYVXItBAaJV8j4BBad9HT7xYtZ
         G7elNYQp3qWbFDelGRd0nCLX6HqDBWMp4bIHCtwdTMkBfPfoLsEMR990Q0uIRwBnzXse
         y76yXY6MTSQcGKEspulVsJ9kKtsDdEqV0Hs9QD7HGsRAthIMOPTFcMGc7qMw6ZPv5HK0
         Gv9oL92VOXJlDK1ljmTEqhzNFwIyk6h9sVAsgRxXBnBfJK2Qy2yr4FMtgxsnqYfqPpFO
         AiyQ==
X-Gm-Message-State: AOJu0YxhRPYn51foAFOqSvcQtxIH5vEaKdtRMoafwzhwgRjkDtSd1Plg
        D7k7kA/0PTsQiOdkTigR7YoQFg==
X-Google-Smtp-Source: AGHT+IFktZEGzVQ79iSZyPcJk9XOSRsrzr5WoeyEli+ACNX43xpOf0axceLlu9TSC+4tN8O7hIKwQw==
X-Received: by 2002:a05:6512:6ca:b0:4f6:3677:54e with SMTP id u10-20020a05651206ca00b004f63677054emr8794627lff.36.1694420631650;
        Mon, 11 Sep 2023 01:23:51 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b00500968ddca9sm1247712lff.136.2023.09.11.01.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:23:51 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 10:23:49 +0200
Subject: [PATCH v2 2/7] ASoC: max98357a: Drop pointless include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-descriptors-asoc-max-v2-2-b9d793fb768e@linaro.org>
References: <20230911-descriptors-asoc-max-v2-0-b9d793fb768e@linaro.org>
In-Reply-To: <20230911-descriptors-asoc-max-v2-0-b9d793fb768e@linaro.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is already using solely GPIO descriptors and
do not need to include the legacy header <linux/gpio.h>.
Drop it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/max98357a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 2a2b286f1747..cc811f58c9d2 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -8,7 +8,6 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>

-- 
2.34.1

