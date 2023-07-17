Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EBC756D78
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjGQTid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjGQTiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:38:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915B2BB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:38:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb41682472so7840692e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1689622701; x=1692214701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoBLkK2LHNAZNFLTLXxtcr6P67HJOzOANhsGn4ic+bU=;
        b=jzR2pq1rlEtnzLkc6fPM1RWXYa6wSHQD98evZn4wQLLmBFtxJA1ve0TcRf++jhvjjH
         pLJqnm4FVaQXgItzn2zhGlwyxNeEKYaoxJSZiy37jipmOFbNrWAk+b36NKNMbb1Aos/2
         UVaFCgaMfWADG3Oqinf3kIxty8HH6Cq3BoSIm7j9GbU0krP7vcp5xXuBDwWgQtQKQwGS
         D+RSGRggJQAhFknA9/uiyY1E6bi8li6BNkSEBtq2CkgwYEygGyzUBN479HOBGoxPVHgU
         hKo/BJ4KJNfDn6SnB1UzymekuU4XH+D1muOxl+0W5G83rjv+HxCqBVR10YwkPo+PO/ZG
         1hcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622701; x=1692214701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoBLkK2LHNAZNFLTLXxtcr6P67HJOzOANhsGn4ic+bU=;
        b=IRfVELg5k9I9zrLfrcLExmQrI5shzTPEcHqlAOHLDTgKDg5mIHbFY+wa2Ol0Vfh6rC
         Fp00sJa/W0V9kHsaOo6PJcPgjO8hkDaccnd1NrwXcWBBTS5vrqVoHxm+YPghZncEbQB0
         aHbVXFI3riLKKQ4QEvExeuZGSDcxSE7pF5NzNgoTcw7FDPOPNqhu5aB5necZuunfWDeK
         ODQTILPRbtGRfXvdqP1UTCLCF5T/JNtIAFnTpqy0sqsZL5Y4Hg6sZT2IlKsW5RgeQwLD
         qc6oD6c2E4vU37dU505lxBCmS7u9ZW83adcnrajn8MBAoeN0DfhQLJOUlABlO0utmSIk
         o8bA==
X-Gm-Message-State: ABy/qLZER0hcdiumg12hi/JlDNB59DabHwVrGvjmlweB4NQBIyERW/9j
        yFjyDRMfbhL1V7i7Pn+wYATAYw==
X-Google-Smtp-Source: APBJJlH/MKKctcUXF27xz60W++Q/7HDTxaCCnfDK9CXhGPZoNN9C6dKQ9myhU9W6KvzgKg9ZUKCgnQ==
X-Received: by 2002:a05:6512:3d03:b0:4fb:8f79:631 with SMTP id d3-20020a0565123d0300b004fb8f790631mr16932345lfv.46.1689622700837;
        Mon, 17 Jul 2023 12:38:20 -0700 (PDT)
Received: from dmaluka.office.semihalf.net ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id e5-20020ac25465000000b004fb75943ab3sm53124lfn.258.2023.07.17.12.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:38:20 -0700 (PDT)
From:   Dmytro Maluka <dmy@semihalf.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        DLG Support Opensource <DLG-Support.Opensource@lm.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Dmytro Maluka <dmy@semihalf.com>
Subject: [PATCH 2/2] ASoC: da7219: Check for failure reading AAD IRQ events
Date:   Mon, 17 Jul 2023 21:37:37 +0200
Message-ID: <20230717193737.161784-3-dmy@semihalf.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230717193737.161784-1-dmy@semihalf.com>
References: <20230717193737.161784-1-dmy@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handling an AAD interrupt, if IRQ events read failed (for example,
due to i2c "Transfer while suspended" failure, i.e. when attempting to
read it while DA7219 is suspended, which may happen due to a spurious
AAD interrupt), the events array contains garbage uninitialized values.
So instead of trying to interprete those values and doing any actions
based on them (potentially resulting in misbehavior, e.g. reporting
bogus events), refuse to handle the interrupt.

Signed-off-by: Dmytro Maluka <dmy@semihalf.com>
---
 sound/soc/codecs/da7219-aad.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 202715b7bbea..581b334a6631 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -361,11 +361,15 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 	u8 events[DA7219_AAD_IRQ_REG_MAX];
 	u8 statusa;
-	int i, report = 0, mask = 0;
+	int i, ret, report = 0, mask = 0;
 
 	/* Read current IRQ events */
-	regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
-			 events, DA7219_AAD_IRQ_REG_MAX);
+	ret = regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
+			       events, DA7219_AAD_IRQ_REG_MAX);
+	if (ret) {
+		dev_warn_ratelimited(component->dev, "Failed to read IRQ events: %d\n", ret);
+		return IRQ_NONE;
+	}
 
 	if (!events[DA7219_AAD_IRQ_REG_A] && !events[DA7219_AAD_IRQ_REG_B])
 		return IRQ_NONE;
-- 
2.41.0.255.g8b1d071c50-goog

