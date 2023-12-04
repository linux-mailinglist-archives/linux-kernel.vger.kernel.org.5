Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC25803356
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344069AbjLDMrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343931AbjLDMri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:47:38 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD0AAA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:47:44 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54bfd4546fbso5393828a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701694063; x=1702298863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KY0JnJRKpd3/EUynN0UwcoxBlBhaBotyx7RxLf0wHWk=;
        b=WxFUILUg9AlH39Y2EB9mtJahq3vrhq/0j2+JHA2WeUFVB/LtnhfAJJ6nRyCnFjGPpq
         BhXtUVYhlZ5Sctx4Jf5xJG9kNB1uhew7yHFhboABHNdA9G6ritHPu+7MyG2S0hMh7rA9
         AwroFr7K940CJq4OKdWBdtYC0AjjyENd5/IHGtq6Yjsan9cNv+IjayLquw1iPCpv/aee
         dtzIN8IBwrImDDCb8s4iKTKA2JT20iNBuC2qDj6lbMWjZbhizaAhvauTUotVGSe86eHD
         giq6/GlbCED9cuEJY21EL25GlMokfTByfuXlceuYWtHd2261n6fkp7+BaSOk1Q+y+Tzv
         oV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694063; x=1702298863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KY0JnJRKpd3/EUynN0UwcoxBlBhaBotyx7RxLf0wHWk=;
        b=oh13hUHnfAtrSK2989pMFroXDl+Br6pk2Rt1YMrW0C3WrzVHMNLLMG2GwIQs4kjFVL
         rrlK0Wtyke8XQNVz7D0+yBB4NQq9ATl6AsStl4yxgXsnSwN9Icb+4I31wuQLrzVV2Nn8
         e/tdV7TqXq3R8VmDaYQoPaK2mlH1AAreJmcJTilmNACCm7vwKHhDhwp6paomE6pRU/ND
         wHkGpUrjdOgOsKbWFJBqoHIZVjEu3dx1PWkljYf6agQPLZ+SG2GSX14uABsvA4bEHipB
         5/uhupbM63Cnk2QPQ+uFtc+8s5h4xKGsHOUqRTZnxn63l0IlhGqAePLr8I96WKdUOnMZ
         RQNA==
X-Gm-Message-State: AOJu0YzFPXqvlEJl22IOX7BSYf96sL2VffWssiGPOYsuzaUL/Z9is3+i
        htEcYee0p3VS8iArMePdjRPYDw==
X-Google-Smtp-Source: AGHT+IFhu/InStD612XpzFwPv9bBK0nLIg+7JO9nMW2ZvtutTmDe1Q3IXR3v2X7PDbYWSph/4G/iGg==
X-Received: by 2002:a05:6402:17dc:b0:54c:a21b:8088 with SMTP id s28-20020a05640217dc00b0054ca21b8088mr1192577edy.63.1701694063127;
        Mon, 04 Dec 2023 04:47:43 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id dc15-20020a056402310f00b0054ced65bd26sm457017edb.41.2023.12.04.04.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:47:42 -0800 (PST)
From:   srinivas.kandagatla@linaro.org
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] ASoC: qcom: sc8280xp: Limit speaker digital volumes
Date:   Mon,  4 Dec 2023 12:47:36 +0000
Message-Id: <20231204124736.132185-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
References: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Limit the speaker digital gains to 0dB so that the users will not damage them.
Currently there is a limit in UCM, but this does not stop the user form
changing the digital gains from command line. So limit this in driver
which makes the speakers more safer without active speaker protection in
place.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sc8280xp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 249a43e1dee3..1e8f9452cd28 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -25,6 +25,23 @@ struct sc8280xp_snd_data {
 static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_card *card = rtd->card;
+
+	switch (cpu_dai->id) {
+	case WSA_CODEC_DMA_RX_0:
+	case WSA_CODEC_DMA_RX_1:
+		/*
+		 * set limit of 0dB on Digital Volume for Speakers,
+		 * this can prevent damage of speakers to some extent without
+		 * active speaker protection
+		 */
+		snd_soc_limit_volume(card, "WSA_RX0 Digital Volume", 84);
+		snd_soc_limit_volume(card, "WSA_RX1 Digital Volume", 84);
+		break;
+	default:
+		break;
+	}
 
 	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
 }
-- 
2.25.1

