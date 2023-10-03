Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869007B6D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjJCPye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjJCPyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:54:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2559FBF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:54:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ad810be221so204846966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696348465; x=1696953265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qwggqM5g4H2kMBZ1deteV2yt6E9yc4Vqh+Tp6Hnvgo=;
        b=mmaSiZcCH+DXUmz09lDemy233/CUEnRFt4ROlBjTnoPtncwzi3DvB120qaewocHnCa
         LKj4R+yOVHAGZHHvqruATzl7ZPqdd68v1FBvvFCfOJWilwivm0HVQbbenGFzyF/gnlEm
         t5rt2qq7Jh7kgwydcNP5O/CUL8GP93x723YSqDny1Mml67Fx4gX646D1FToTd/2M3blD
         N+7EdNsQfwixdYxz/W09XwFXpnf2VwSfvcr4rpg04SRS/vkmFlexE45C6WUYK98NB/Oa
         DFbWpuElM0PBr+/NHT+FZ/Cz0ROwZ7aUdGLKJw2BUgEG2mX0FVTtPYV4vRHaFHzOqtSj
         nv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348465; x=1696953265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qwggqM5g4H2kMBZ1deteV2yt6E9yc4Vqh+Tp6Hnvgo=;
        b=T0UzczyxwWZbrVLH7TWDSieSS9IFYqPYHY+34WAUfuDZwDGO4T2b9AhyBTDxSmciYs
         0wb2Vg1oYH4nbcFBxJ41YmcXB/WVKs3e6iHZNBRJPu8EL4lMRolLUebyHcypsZ9rXWNX
         6eWVkxTYJQGJXc2H7kxgyPXEKdFchwp2Hnvn7Hnc13Mv06YI12b5d+N39x7OnJeFNJ5K
         p9Ee5RhaLm0yCI2zsofxVmDceBWATLPcSuXGSg5B2blUQe852Ihm49pjSyfVacY7JPDv
         UozrNROPFmfJFmcxqo8bjObXkHuKpZYcJ1cnJexr760phmHHki2wZWpIhviKej9QQM5l
         whQg==
X-Gm-Message-State: AOJu0YxALlnRamfwR+9AbmUpOgRbXvRKw80Q0NDFaXLW49B8s/HbGAbK
        We9G4DTku4/Hc7DarD5fQGk8ag==
X-Google-Smtp-Source: AGHT+IH09d6DTdcKc37AqByhCIppHQNpciXplK+DYeKcZhmAvum3wYCeGF8amKbOLfAWBgKm2xynPQ==
X-Received: by 2002:a17:906:5349:b0:9b2:9a0e:9973 with SMTP id j9-20020a170906534900b009b29a0e9973mr13823175ejo.42.1696348465487;
        Tue, 03 Oct 2023 08:54:25 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id sa18-20020a170906edb200b0098733a40bb7sm1268948ejb.155.2023.10.03.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 08:54:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] ASoC: codecs: wsa-macro: fix uninitialized stack variables with name prefix
Date:   Tue,  3 Oct 2023 17:54:22 +0200
Message-Id: <20231003155422.801160-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver compares widget name in wsa_macro_spk_boost_event() widget event
callback, however it does not handle component's name prefix.  This
leads to using uninitialized stack variables as registers and register
values.  Handle gracefully such case.

Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This is a fix only for uninitialized values case.  The fix for including
name prefixes will be sent separate, because I think it is not a stable
material.  Happy to combine patches if needed.
---
 sound/soc/codecs/lpass-wsa-macro.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index ec6859ec0d38..ea6e3fa7e9e1 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1685,6 +1685,9 @@ static int wsa_macro_spk_boost_event(struct snd_soc_dapm_widget *w,
 		boost_path_cfg1 = CDC_WSA_RX1_RX_PATH_CFG1;
 		reg = CDC_WSA_RX1_RX_PATH_CTL;
 		reg_mix = CDC_WSA_RX1_RX_PATH_MIX_CTL;
+	} else {
+		dev_warn(component->dev, "Incorrect widget name in the driver\n");
+		return -EINVAL;
 	}
 
 	switch (event) {
-- 
2.34.1

