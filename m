Return-Path: <linux-kernel+bounces-74620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CEB85D705
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2D31C22EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94BE41AAB;
	Wed, 21 Feb 2024 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgFExfEB"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F89405DD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515045; cv=none; b=KofaEGRmnN6by5HXE0C03sVqkRJsxn+Zbb68IWmqD2+FRXiMVcy9Z42k76SF7Fhr8Lgletmtz1I80p5U5Rpwn818pUg50U06Vfx5iJUpEqYXgvpsRAICO99LXYQvFbGjdvX9SD4sUC5treMwNQj6FqrYij0gpx6gGAR3bA03Z00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515045; c=relaxed/simple;
	bh=UvCheUVIoFjk4cSiZxMiMgUAjFsOzD0QEdp/BP6hA54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ctdVR6igxbnConsoNsRQb7h3YejIqg2/JJITYHH7aTgX0jNnfqVlKYs+hrbSM3NdIQbrgMiUnIYT2vF2J98OnsuYt4qceRWNOQX4JKmcGhhUK03N6dqyWloXnbSYkzOorXwAcSBDKsbtdq82xYvPbZW9NWqSLIRO9EOHh6FiMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NgFExfEB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e75e30d36so598150166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708515042; x=1709119842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMJuotCi10MIEivhgp+/HFVWVuz2YA+wsQ3N0tBEkCQ=;
        b=NgFExfEBtuPzOq8ifX7JMsESrD2wfANQfoyYYYAWm6BbP1NR1ERpkQrEcJF5rv/mdW
         L+ct51HifCgTodAllpbLQfI2wglCtnzVFEGHmKTKjuXPxIWRTN0rhG7nYJkgNTJoHQN3
         DXvt9jRzHN9fldGmzAKUiNRQ3V0xwRfwJhI+M6WpgaMoO4keRfBhjpQIRB9lhLeSSSvu
         NQhYWOGwAG/N+XocsMgxJ8F0MvTDwwYogMR7e1ZE1z5Lx0m6K06CGCEQy3jlrTLMLY1R
         f12M1mA78X9Sjaf9mu4Gn0wDSvswabxrSP3WoiaGcz+DJIGkXzdrY1vPw/wwxvSBF7rK
         V5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515042; x=1709119842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMJuotCi10MIEivhgp+/HFVWVuz2YA+wsQ3N0tBEkCQ=;
        b=oEtDf20EvAPmDxxYHnoOu7A6Jr9/OPXhtB7wx+ofmu6BsDUOcNakAot2YARX9dDpYZ
         VBqp5rh7VnawI3Wz3D7ZxwmPpZ+CkPO0sTLfrZFMkjZHerS7WoHsajRhf5isjU68C1z5
         JagJxU+DL1OZJ81B6jdRhwmaOgNKwQFnbEp0c+J20alZy45WBTHyKcsa8QAcPuLHlLso
         kfUyr05jJoJRKfx61AZrbVUIqRNHECde9aLU1Spg3VSxpa2RhuuavxV1ZJSQRG9Uxh58
         +kMY2yujVdrCz+ob0wABmUWLoYOahLLqglw8X4QZXRYO010s5s53jnw+bn+BmnhafhxZ
         YHwA==
X-Forwarded-Encrypted: i=1; AJvYcCU4WDBY5pzyKN1f3Fml4AvxxMt9q2FjAs6chu9KS4I5Y7GpIxKGXtXbotP7AVxRAt+cy6qCAmLoGAQxrLQmKkJF2FfztSFN0OhIglIe
X-Gm-Message-State: AOJu0YwpQt4XjXr70Lx/+aXgKx+uNJUMhKLlzh3bwwcjXpBPMBa35y5I
	cXCwkgLQ/xxWbbATZN0kPKceIcAOKLi1aK27dqNHYGNG1fqnEyoSA4UlBIH/ugo=
X-Google-Smtp-Source: AGHT+IGa30Y9sZCSRDuOG9iML0YaKidoEu1++hvS9trF/xcUXTGjRT1+VbSba/xh5BEu6evlsLJz4w==
X-Received: by 2002:a17:906:e085:b0:a3f:421:26a5 with SMTP id gh5-20020a170906e08500b00a3f042126a5mr4151010ejb.12.1708515041688;
        Wed, 21 Feb 2024 03:30:41 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906c18100b00a3e278c4a3fsm4393712ejz.53.2024.02.21.03.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 03:30:41 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sean Anderson <sean.anderson@seco.com>
Subject: [RESEND PATCH v6 v6 2/2] ASoC: codecs: wsa884x: Allow sharing reset GPIO
Date: Wed, 21 Feb 2024 12:30:36 +0100
Message-Id: <20240221113036.23905-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221113036.23905-1-krzysztof.kozlowski@linaro.org>
References: <20240221113036.23905-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some boards with multiple WSA8840/WSA8845 speakers, the reset
(shutdown) GPIO is shared between two speakers.  Use the reset
controller framework and its "reset-gpio" driver to handle this case.
This allows bring-up and proper handling of all WSA884x speakers on
X1E80100-CRD board.

Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wsa884x.c | 53 +++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
index f2653df84e4a..a9767ef0e39d 100644
--- a/sound/soc/codecs/wsa884x.c
+++ b/sound/soc/codecs/wsa884x.c
@@ -13,6 +13,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
@@ -699,6 +700,7 @@ struct wsa884x_priv {
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[WSA884X_MAX_SWR_PORTS];
 	struct gpio_desc *sd_n;
+	struct reset_control *sd_reset;
 	bool port_prepared[WSA884X_MAX_SWR_PORTS];
 	bool port_enable[WSA884X_MAX_SWR_PORTS];
 	unsigned int variant;
@@ -1799,9 +1801,22 @@ static struct snd_soc_dai_driver wsa884x_dais[] = {
 	},
 };
 
-static void wsa884x_gpio_powerdown(void *data)
+static void wsa884x_reset_powerdown(void *data)
 {
-	gpiod_direction_output(data, 1);
+	struct wsa884x_priv *wsa884x = data;
+
+	if (wsa884x->sd_reset)
+		reset_control_assert(wsa884x->sd_reset);
+	else
+		gpiod_direction_output(wsa884x->sd_n, 1);
+}
+
+static void wsa884x_reset_deassert(struct wsa884x_priv *wsa884x)
+{
+	if (wsa884x->sd_reset)
+		reset_control_deassert(wsa884x->sd_reset);
+	else
+		gpiod_direction_output(wsa884x->sd_n, 0);
 }
 
 static void wsa884x_regulator_disable(void *data)
@@ -1809,6 +1824,27 @@ static void wsa884x_regulator_disable(void *data)
 	regulator_bulk_disable(WSA884X_SUPPLIES_NUM, data);
 }
 
+static int wsa884x_get_reset(struct device *dev, struct wsa884x_priv *wsa884x)
+{
+	wsa884x->sd_reset = devm_reset_control_get_optional_shared(dev, NULL);
+	if (IS_ERR(wsa884x->sd_reset))
+		return dev_err_probe(dev, PTR_ERR(wsa884x->sd_reset),
+				     "Failed to get reset\n");
+	else if (wsa884x->sd_reset)
+		return 0;
+	/*
+	 * else: NULL, so use the backwards compatible way for powerdown-gpios,
+	 * which does not handle sharing GPIO properly.
+	 */
+	wsa884x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
+						GPIOD_OUT_HIGH);
+	if (IS_ERR(wsa884x->sd_n))
+		return dev_err_probe(dev, PTR_ERR(wsa884x->sd_n),
+				     "Shutdown Control GPIO not found\n");
+
+	return 0;
+}
+
 static int wsa884x_probe(struct sdw_slave *pdev,
 			 const struct sdw_device_id *id)
 {
@@ -1838,11 +1874,9 @@ static int wsa884x_probe(struct sdw_slave *pdev,
 	if (ret)
 		return ret;
 
-	wsa884x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
-						GPIOD_OUT_HIGH);
-	if (IS_ERR(wsa884x->sd_n))
-		return dev_err_probe(dev, PTR_ERR(wsa884x->sd_n),
-				     "Shutdown Control GPIO not found\n");
+	ret = wsa884x_get_reset(dev, wsa884x);
+	if (ret)
+		return ret;
 
 	dev_set_drvdata(dev, wsa884x);
 	wsa884x->slave = pdev;
@@ -1858,9 +1892,8 @@ static int wsa884x_probe(struct sdw_slave *pdev,
 	pdev->prop.sink_dpn_prop = wsa884x_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
 
-	/* Bring out of reset */
-	gpiod_direction_output(wsa884x->sd_n, 0);
-	ret = devm_add_action_or_reset(dev, wsa884x_gpio_powerdown, wsa884x->sd_n);
+	wsa884x_reset_deassert(wsa884x);
+	ret = devm_add_action_or_reset(dev, wsa884x_reset_powerdown, wsa884x);
 	if (ret)
 		return ret;
 
-- 
2.34.1


