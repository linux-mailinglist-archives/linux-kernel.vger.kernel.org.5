Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF77E1E7C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjKFKhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjKFKhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:37:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AD3A1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:37:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32da7ac5c4fso2653998f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699267048; x=1699871848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9kyxum5YNhiGFDrnxvukFQjBtUh2qLRYWx5QnJK2YXc=;
        b=Mmiq8J1ju2rDb2Grq15UnYMcBaUg+kFgRkQo77crslkwFDZgIKhBTQSEMLsd3GP0Wd
         l/ZAPf5w8uIX9TseA+BACms3DOiJCxQv9vz4Ubu70FA83XLFyi1xCe9ks6kNdcI40dqj
         k1im5Chvc89SpJKQodAjt7qD1EtIjVx98uq9MOk2Lrr+xtb8wDk5/35UVnUxT4IGuiuA
         aIym29pLzN7JYHM+C+n+CFdwQWiAvPRaIB/fsKiGm0YDDRZ1xzQzwJc1BJsj6XL7Vk0u
         lR9tUwp2b6iNdt7infQvodb3Uegw90aoAYiJEkzVbf645CPWH3gKqnDgFfRN0C6WYC6c
         EM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699267048; x=1699871848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kyxum5YNhiGFDrnxvukFQjBtUh2qLRYWx5QnJK2YXc=;
        b=gW1F6ptVU25nsPhdABnqOP7q0sgWKEed1GzpIxQzj1ZU9sBOIYZ7Y2aczgQOkO709t
         TOcs/hDhBbRkQelcroQOoHs7F8pSHtZoBZr83u8VLFjvD7yhUuSWDJ9oADdFNXBotsqc
         8W9V1tE5+g9iZyryECF8GJ6NVK1uSGnHiDXp/c/Adh0tVVZNd3L+D790pYcQbAjYI9E8
         iXGim+MVMkeX7NmxM+DceUALHyhVT4NdEMUag+HjlGNq4MKsqo2ztK7loYLs09D16VMg
         GfzTuSGxMNA5YtqoHRu+OdcO5ueRBMJBQ8s8I+Ccr+oemFe4ykU/qApz131g8kvYRFkl
         UiYw==
X-Gm-Message-State: AOJu0YwxDaCcTxz/ab7ul/4QO1wXpdIgT6+FUgwa2h3IQDeq65oe3nU3
        GThWvGpI6zn6adN6X0a1THI8Eg==
X-Google-Smtp-Source: AGHT+IHdcanmjp6niY0sMoZF7bwPXZ4XAjqJnCGHA2okTmCF7vPefs2OEigl43Ieu5XrrkMeoA4vXg==
X-Received: by 2002:adf:eb0a:0:b0:32d:884b:7403 with SMTP id s10-20020adfeb0a000000b0032d884b7403mr20244809wrn.66.1699267047784;
        Mon, 06 Nov 2023 02:37:27 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:fabf:ec8c:b644:5d3])
        by smtp.googlemail.com with ESMTPSA id h3-20020a5d5043000000b0032dba85ea1bsm9106950wrt.75.2023.11.06.02.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:37:27 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dapm: fix clock get name
Date:   Mon,  6 Nov 2023 11:37:09 +0100
Message-ID: <20231106103712.703962-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name currently used to get the clock includes the dapm prefix.
It should use the name as provided to the widget, without the prefix.

Fixes: 3caac759681e ("ASoC: soc-dapm.c: fixup snd_soc_dapm_new_control_unlocked() error handling")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4e2beda6f9bf..3844f777c87b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3670,7 +3670,7 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		dapm_pinctrl_event(w, NULL, SND_SOC_DAPM_POST_PMD);
 		break;
 	case snd_soc_dapm_clock_supply:
-		w->clk = devm_clk_get(dapm->dev, w->name);
+		w->clk = devm_clk_get(dapm->dev, widget->name);
 		if (IS_ERR(w->clk)) {
 			ret = PTR_ERR(w->clk);
 			goto request_failed;
-- 
2.42.0

