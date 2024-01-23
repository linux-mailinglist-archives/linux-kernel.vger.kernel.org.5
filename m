Return-Path: <linux-kernel+bounces-35435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3462683910E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E351F2A51D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DCC605B0;
	Tue, 23 Jan 2024 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VUV7wcHc"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98006604B4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019233; cv=none; b=Rf4GGhgIsWcszoQC3aFiCcQW7WnThArwyoIBqP/WQwUHRylKNk0ci4o4KanByl4q1Dj96mt/UJKKM0zatETNN55X2Jq0oxJiM+J7tuJOLNeJrUL/e1k0on4Oi/jS0iBLd1RQSBlKBFlaM+kThchA9lmH72FI293jYHmDL7IRKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019233; c=relaxed/simple;
	bh=zd6Bmh48g7rsM+87XsXBkxNU+Zs2Yu+NMiweLujpj9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zq2lsKfLzjTaHOxc/XJQP5T3rVkSbPIoK5Gm0ZdTcHezi6KZCVz3lmMUkzZUTz6L/ffe0o/8YAbG5i3Tlkf4Lm1QzeeFT/978szc2xjmuCQ038uAI3S469Rj1DzmM2lqxt1wRY+wIAdn/v1Q+Asse9d6aMgzF82TElb8VdyJbtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VUV7wcHc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33922b66bd7so2985993f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 06:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706019229; x=1706624029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJ0gjfKMOfp9CH0Fl1AfdBLtnAI1t5WhWrFWLERW/vA=;
        b=VUV7wcHcc6udQnCmXkUlYNNaIXwzT45/R90OgLr6ZF9YVFWehNeLZksZ1rhDq8kso/
         FtjfgzuXFdenYS9N9QONRHYyDNfqal2VXNCxhB2jM9o0kzTNFeXcnW3A/pOy9q3ZbFlY
         ar7UHsOxXnVOh7eyWgvj6u6Rda4l4SPQ0lawXvvnPRiZdwYX8mEqWwWbkb+klYWcQE20
         cg6Huqz2d9Pd5OsWOReudJDQQ05PFk1SzbRO243TBdyiqIlNJcrKNPgtuqYA+FXsOFTA
         1637JUEZlON5rtdXKTdPX8QtuqkxIJFnP7legeuUooXNIiHY8BkaAkTs4r40N9m/HpW0
         TCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706019229; x=1706624029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJ0gjfKMOfp9CH0Fl1AfdBLtnAI1t5WhWrFWLERW/vA=;
        b=IzK/Em8rSDK7IcMiQhjF/Z5Mt0dzIU8BxnQZjYcpDLqn0Z13NW/GElt1HdJTd7Rfmp
         sdZghZXzvTxoq59fntc+/1jz6wj40F8jx+7Di6LiDvRkmHlXls+DZ4PV6DJkUXT/9Hm7
         KINTXo9nn8dr7njiGU7jMoLqqkFPOgigA+gfdmX+TWnP/OMJeOAD2RKLfMGTXLTHswTR
         zhNfBIYhcATdE7sX0Y7YtaRNe+CUIPAm8LTTSjqdK3vjOI3pmg6unBRXvaqo/MyHJjkY
         WXnbBe3XKkJ2vfeQJaq7jAamB/YYWUcVTde/LsVkOuJ1qh9Nmw+W+kj/6IHdhzdGOiSy
         rQCg==
X-Gm-Message-State: AOJu0YzyxzqfuUltarSuvbfxCGa1bhd1r4elLUloBUGjF9TcpKtuittN
	RCCRIWRnfalz2zcDNJf0NCqgpK1ig7Id9sY0wkYXsX5nscwf9OswdQHBleog4U8=
X-Google-Smtp-Source: AGHT+IEmbmNSvVll9puJMHID5ADLiEU47RyJFA7juTXNLnNPBn9fghYRSUWnGYd4fyil/i4UIdqrsg==
X-Received: by 2002:a5d:5086:0:b0:337:c5fb:c84f with SMTP id a6-20020a5d5086000000b00337c5fbc84fmr3473681wrt.33.1706019229029;
        Tue, 23 Jan 2024 06:13:49 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id r8-20020adfe688000000b00337d97338b0sm12132298wrm.76.2024.01.23.06.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:13:48 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v4 6/6] ASoC: codecs: wsa884x: Allow sharing reset GPIO
Date: Tue, 23 Jan 2024 15:13:11 +0100
Message-Id: <20240123141311.220505-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123141311.220505-1-krzysztof.kozlowski@linaro.org>
References: <20240123141311.220505-1-krzysztof.kozlowski@linaro.org>
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
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

If previous patches are fine, then this commit is independent and could
be taken via ASoC.
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


