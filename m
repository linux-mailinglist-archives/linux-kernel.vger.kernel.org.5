Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003BA79B486
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378814AbjIKWhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbjIKIYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:24:02 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8A8EE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:56 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-500b66f8b27so7131210e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694420635; x=1695025435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44JIVg8xfT/EISToMUTEvN6PJWh2bmWBrdxrTpht5uo=;
        b=QJ1VSBmff0euU4IAwhttZNDXi1W15EZ1g5jY6xyLF1pjZ+T0Fr6EVWYjP2AZDYrBmw
         KOGROvfUQT+l9KuaJ7BGIo16lPx+IsNqbVWBEh+bKPI36zOsXMZOaKwCFw0ir+sIw8BG
         4MEMMQdX6KeB0j1cJctOVgWq9lOpvtw8sqUC/oKDxCAPyZMo8ALGWS/FWFYQfgVsik4G
         3plPvyqYz0uSQ62nfIcvgABWZRP8HNOeoXZoQAYv9F6YtAkQnewxorJG8i2OrzzdBYTJ
         ZYVZ9gO51PszqkwiUfpdd6STFaIrMVb5oZcyXBkdr29pUy5iIGuxZYkAsVAJGjc7lmfp
         AQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420635; x=1695025435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44JIVg8xfT/EISToMUTEvN6PJWh2bmWBrdxrTpht5uo=;
        b=vPp7+iaLEiLmIWKpj0ODC+wVQYmNeq2+/Msg1R9OXKRtM5GmzK/Q5iVoARe4X7Es9E
         N1Ee1TZMuKitAw8s6+SASP4c+0dONnBYEQ2bZrjJMe0q7KoR26EWDN7dK5Ss+vTV0KPz
         DT4bJD3YRUCCqNoJX0Wakin3c/RSbE1dvAGTv6KscceNxpj+Nqdd+J+rvwzsWjYuhyop
         w9rWgv2L7xhisQMMOnrZnHye/TxAy4SHMJ+rERg8RKA0vhgn7di/VIoPKZk0cFAbbM/c
         oxtYFj1Vu2zAugF1HYYhVGAey0r8YJFha42XAn5MK1ejfLGBfZ3Nx5PNqYpxuOQTxk8z
         U8DQ==
X-Gm-Message-State: AOJu0YwVACXDLEJQeD3YomB7Jk5FDVgwCCFS7s2816R3/Yvp2VyNdHFP
        J42eKg9gwV7BrEzK/li1YVYGPg==
X-Google-Smtp-Source: AGHT+IEQ4w417/0zEAT3z1jUW5wv9C0zAydtmQXHmAkRjf5g/xJFpgA6Pz1UnIvmT0XiSUbE22ZM/Q==
X-Received: by 2002:a05:6512:2211:b0:4fb:8939:d95c with SMTP id h17-20020a056512221100b004fb8939d95cmr9556754lfu.30.1694420635138;
        Mon, 11 Sep 2023 01:23:55 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b00500968ddca9sm1247712lff.136.2023.09.11.01.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:23:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 10:23:53 +0200
Subject: [PATCH v2 6/7] ASoC: max98520: Drop pointless includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-descriptors-asoc-max-v2-6-b9d793fb768e@linaro.org>
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
 sound/soc/codecs/max98520.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/max98520.c b/sound/soc/codecs/max98520.c
index 8637fff307ad..edd05253d37c 100644
--- a/sound/soc/codecs/max98520.c
+++ b/sound/soc/codecs/max98520.c
@@ -11,10 +11,8 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <sound/tlv.h>
 #include "max98520.h"
 

-- 
2.34.1

