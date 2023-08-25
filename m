Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67F5788DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbjHYRX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbjHYRX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:23:29 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B192139
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:23:24 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso17879921fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692984202; x=1693589002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgZvHL8hFswLYwPF8AuRbBMK7oSEIDIwPQTcWj9HdOU=;
        b=GLVQRR0uqz7h3mQtbUDjl9KTg9wErpM6VkLfEbYi5c6RumHoQDQau59jJOZR/a72EL
         RbR7Tz7YcIWnHUtdHuF/Y47W01Kz2aYojHdPM7AInofd/QaNRKuXjrLG9ZutsVUenVCE
         95QiaH6WtlpdnjqMTJpl4gfQ5KpVptXQ4RtHkooUTBK64il+bYztIx5gvR1Nr7L6zl6k
         of9RBaLaOZYy9qWKiYn+Zeg6ql0rop5CA9J6zzbUoyI8vKePJYvr2IViClxE8TsRLbnX
         0K2F4IH0BCU8cu+X6nD2nDuPODM3Tu3RQYYHf0wghvgxsm/m3c8VBqIoEuRFiGHNZlRx
         47eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692984202; x=1693589002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgZvHL8hFswLYwPF8AuRbBMK7oSEIDIwPQTcWj9HdOU=;
        b=Bkzeo1Hf8/z2WeWY5N305WowLhMjw+zFVFXWVmDJSFR9krGBLJC6kZ9/2mmYBM6IqR
         MleA6MI2oqVzwoa4kipfJfU4iC6JHDn8cP0mPecYlNjyjwvbxzGe5pcKMw2k2jdEy0La
         Lh+WODszIQsAKpenKFsgUnOcSEaMktFItRM1ggXvUNMJcGs5a4J7U5ycGq5Z1nlHwqtC
         3J8dAYrWZcEzOw4qzQQ9+HmGErsOgTFkRu1et0Hj5ysGZM8LD9PAyL/JBez7s0mPI+QG
         3cZ+nWP5ovhTqm4vmqMFAk7+kCs12LfVaGYPZMDauJrgzo1rSOBhHCzS9D4F52Q2lYjF
         sCag==
X-Gm-Message-State: AOJu0YzyYt2zA0iYwsxG0rn/Dgi9423e1SyTeqBcCDGmN+uLtsvfzaBI
        SkFasGmEXZ2F1ulKL3mosWPNJQ==
X-Google-Smtp-Source: AGHT+IGEWTWl4FE5/sIMoCZYj5tNQhpLyEV1B/4/UDUeu8WyCLiRwN1y6zdZ489KTOTHVvEld8lL/g==
X-Received: by 2002:a2e:6a03:0:b0:2bc:d993:b7ba with SMTP id f3-20020a2e6a03000000b002bcd993b7bamr7286415ljc.27.1692984202704;
        Fri, 25 Aug 2023 10:23:22 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id n11-20020a2e904b000000b002bcb1e1322asm407647ljg.63.2023.08.25.10.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 10:23:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 25 Aug 2023 19:23:13 +0200
Subject: [PATCH 2/2] ASoC: codecs: lpass-tx-macro: Add SM6115 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-topic-6115tx-v1-2-ebed201ad54b@linaro.org>
References: <20230825-topic-6115tx-v1-0-ebed201ad54b@linaro.org>
In-Reply-To: <20230825-topic-6115tx-v1-0-ebed201ad54b@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692984198; l=3082;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+NN8XrEaFBygmo3q/e38Bu/eRF3y7vIEUdBDz81oARw=;
 b=PU8ItgsZg+K3RccuAVuAqM2PAzOyCQhzUKWthiWh3L6UofpAK5W3bKNmtGaPMdLJoFiUUi6zf
 3rLk7uFbnPtAvqytAVbHnLiVI7gkllxNwXze/kEeL6zDIkXc/aDdDGR
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM6115 has a TX macro, which surprisingly doesn't host a SWR master.
Conditionally skip the SWR reset sequence on this platform.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 sound/soc/codecs/lpass-macro-common.h |  2 ++
 sound/soc/codecs/lpass-tx-macro.c     | 22 +++++++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
index 4eb886565ea3..d3684c7ab930 100644
--- a/sound/soc/codecs/lpass-macro-common.h
+++ b/sound/soc/codecs/lpass-macro-common.h
@@ -8,6 +8,8 @@
 
 /* NPL clock is expected */
 #define LPASS_MACRO_FLAG_HAS_NPL_CLOCK		BIT(0)
+/* The soundwire block should be internally reset at probe */
+#define LPASS_MACRO_FLAG_RESET_SWR		BIT(1)
 
 struct lpass_macro {
 	struct device *macro_pd;
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 3e33418898e8..82f9873ffada 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -2045,15 +2045,19 @@ static int tx_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_fsgen;
 
+
 	/* reset soundwire block */
-	regmap_update_bits(tx->regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
-			   CDC_TX_SWR_RESET_MASK, CDC_TX_SWR_RESET_ENABLE);
+	if (flags & LPASS_MACRO_FLAG_RESET_SWR)
+		regmap_update_bits(tx->regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
+				   CDC_TX_SWR_RESET_MASK, CDC_TX_SWR_RESET_ENABLE);
 
 	regmap_update_bits(tx->regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
 			   CDC_TX_SWR_CLK_EN_MASK,
 			   CDC_TX_SWR_CLK_ENABLE);
-	regmap_update_bits(tx->regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
-			   CDC_TX_SWR_RESET_MASK, 0x0);
+
+	if (flags & LPASS_MACRO_FLAG_RESET_SWR)
+		regmap_update_bits(tx->regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
+				   CDC_TX_SWR_RESET_MASK, 0x0);
 
 	ret = devm_snd_soc_register_component(dev, &tx_macro_component_drv,
 					      tx_macro_dai,
@@ -2158,18 +2162,22 @@ static const struct dev_pm_ops tx_macro_pm_ops = {
 static const struct of_device_id tx_macro_dt_match[] = {
 	{
 		.compatible = "qcom,sc7280-lpass-tx-macro",
+		.data = (void *)(LPASS_MACRO_FLAG_HAS_NPL_CLOCK | LPASS_MACRO_FLAG_RESET_SWR),
+	}, {
+		.compatible = "qcom,sm6115-lpass-tx-macro",
 		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
 	}, {
 		.compatible = "qcom,sm8250-lpass-tx-macro",
-		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+		.data = (void *)(LPASS_MACRO_FLAG_HAS_NPL_CLOCK | LPASS_MACRO_FLAG_RESET_SWR),
 	}, {
 		.compatible = "qcom,sm8450-lpass-tx-macro",
-		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+		.data = (void *)(LPASS_MACRO_FLAG_HAS_NPL_CLOCK | LPASS_MACRO_FLAG_RESET_SWR),
 	}, {
 		.compatible = "qcom,sm8550-lpass-tx-macro",
+		.data = (void *)LPASS_MACRO_FLAG_RESET_SWR,
 	}, {
 		.compatible = "qcom,sc8280xp-lpass-tx-macro",
-		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+		.data = (void *)(LPASS_MACRO_FLAG_HAS_NPL_CLOCK | LPASS_MACRO_FLAG_RESET_SWR),
 	},
 	{ }
 };

-- 
2.42.0

