Return-Path: <linux-kernel+bounces-9650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B313D81C8F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64274287902
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C26B1A598;
	Fri, 22 Dec 2023 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JqutJ6JI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4BA17993
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-336755f1688so1503072f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1703243846; x=1703848646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uCw/+6SV9XRUaerzvd3Y9nkib6uwp0dhEr/geBlgA0=;
        b=JqutJ6JIqcOksvfkoe3KfLNZjyOjzGa/U/hU/4Zzb/KjgT/wJz8JZ6aTrdEkwuz8ib
         bwcvSVkcMfz+2y6AUlEC6FM7U5JSnhWWcuRekHI+3b0mHplVkArOXHqa+RB8t4IeMUqI
         379berTZ4IdncjPTOtcow3jxAorbatVp19uSmf0kzxGRHs8A8hd3RxZY5+J/K4bG/5+7
         I62wnXKKdPQyCMSDZpLHK79AARY7Z6aBUREj23BKQV2qz+CZf1/4pYP5m87LfWNq8J47
         RRBN+x2p7698ri2RPUSJ/M/inPnxH7NZhEDoHHDoRKjrFTjOlld1jH0Gqe8BmJdwo0Wk
         E4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703243846; x=1703848646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uCw/+6SV9XRUaerzvd3Y9nkib6uwp0dhEr/geBlgA0=;
        b=FV0CvdVykx2uSjO0ggFnOI1e8H1BE0dwe96Qkq6itbLL+uLnYae8PyIOssTVXR+YhP
         RN9gehag5bmBwOHJRgKXIyhE+i7H6s5Qzq0nhEAe9fVPEDhXCVbglf9gXpsaVbfDdsxH
         r4zpARqxRn9+0kKMnVLxR3Hfg128SxhLW4l1JpLLw/mhwTEMnkiLmu9wXaFsTgACy9zY
         8e/jMKK48+P4n8kxymsmDLWY7zHDg731qKUhzgYrfEHIjB7qO2Uy+ME1K167D0a8t2RE
         p4QaZv1v+Zxm9VtxITiw86kSy/ZhKhqlYWsEumR3JpwOMSxwZqRJ4bwPm+T8SEFsMCXz
         YByA==
X-Gm-Message-State: AOJu0YwZbg4EQMJKoSuTaCcUe1wPxkFZKOVbebE3l7vdiFLDUPQDSNjW
	lIq6jSMcAgi871Mf9p1hXlRm0ho3F/tYjA==
X-Google-Smtp-Source: AGHT+IH/FkJeyB+QCBAK3KIexNgspcRHvmbo2VnQSOJL1p8eFeedvMBI24HYDGNtfxSdKKFgMUDsTg==
X-Received: by 2002:a5d:6d8b:0:b0:336:95d2:c64b with SMTP id l11-20020a5d6d8b000000b0033695d2c64bmr421842wrs.134.1703243845983;
        Fri, 22 Dec 2023 03:17:25 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:c099:e596:3179:b0fa])
        by smtp.googlemail.com with ESMTPSA id f8-20020adffcc8000000b003366b500047sm4054069wrs.50.2023.12.22.03.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:17:25 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	JunYi Zhao <junyi.zhao@amlogic.com>
Subject: [PATCH v4 5/6] pwm: meson: don't carry internal clock elements around
Date: Fri, 22 Dec 2023 12:16:53 +0100
Message-ID: <20231222111658.832167-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231222111658.832167-1-jbrunet@baylibre.com>
References: <20231222111658.832167-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Pointers to the internal clock elements of the PWM are useless
after probe. There is no need to carry this around in the device
data. Just let devres deal with it.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 67 ++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 15c44185d784..fb113bc8da29 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -90,9 +90,6 @@ struct meson_pwm_channel {
 	unsigned int hi;
 	unsigned int lo;
 
-	struct clk_mux mux;
-	struct clk_divider div;
-	struct clk_gate gate;
 	struct clk *clk;
 };
 
@@ -442,6 +439,13 @@ static int meson_pwm_init_channels(struct device *dev)
 		struct meson_pwm_channel *channel = &meson->channels[i];
 		struct clk_parent_data div_parent = {}, gate_parent = {};
 		struct clk_init_data init = {};
+		struct clk_divider *div;
+		struct clk_gate *gate;
+		struct clk_mux *mux;
+
+		mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+		if (!mux)
+			return -ENOMEM;
 
 		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
 
@@ -451,63 +455,70 @@ static int meson_pwm_init_channels(struct device *dev)
 		init.parent_data = mux_parent_data;
 		init.num_parents = MESON_NUM_MUX_PARENTS;
 
-		channel->mux.reg = meson->base + REG_MISC_AB;
-		channel->mux.shift =
-				meson_pwm_per_channel_data[i].clk_sel_shift;
-		channel->mux.mask = MISC_CLK_SEL_MASK;
-		channel->mux.flags = 0;
-		channel->mux.lock = &meson->lock;
-		channel->mux.table = NULL;
-		channel->mux.hw.init = &init;
+		mux->reg = meson->base + REG_MISC_AB;
+		mux->shift = meson_pwm_per_channel_data[i].clk_sel_shift;
+		mux->mask = MISC_CLK_SEL_MASK;
+		mux->flags = 0;
+		mux->lock = &meson->lock;
+		mux->table = NULL;
+		mux->hw.init = &init;
 
-		err = devm_clk_hw_register(dev, &channel->mux.hw);
+		err = devm_clk_hw_register(dev, &mux->hw);
 		if (err)
 			return dev_err_probe(dev, err,
 					     "failed to register %s\n", name);
 
+		div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
+		if (!div)
+			return -ENOMEM;
+
 		snprintf(name, sizeof(name), "%s#div%u", dev_name(dev), i);
 
 		init.name = name;
 		init.ops = &clk_divider_ops;
 		init.flags = CLK_SET_RATE_PARENT;
 		div_parent.index = -1;
-		div_parent.hw = &channel->mux.hw;
+		div_parent.hw = &mux->hw;
 		init.parent_data = &div_parent;
 		init.num_parents = 1;
 
-		channel->div.reg = meson->base + REG_MISC_AB;
-		channel->div.shift = meson_pwm_per_channel_data[i].clk_div_shift;
-		channel->div.width = MISC_CLK_DIV_WIDTH;
-		channel->div.hw.init = &init;
-		channel->div.flags = 0;
-		channel->div.lock = &meson->lock;
+		div->reg = meson->base + REG_MISC_AB;
+		div->shift = meson_pwm_per_channel_data[i].clk_div_shift;
+		div->width = MISC_CLK_DIV_WIDTH;
+		div->hw.init = &init;
+		div->flags = 0;
+		div->lock = &meson->lock;
 
-		err = devm_clk_hw_register(dev, &channel->div.hw);
+		err = devm_clk_hw_register(dev, &div->hw);
 		if (err)
 			return dev_err_probe(dev, err,
 					     "failed to register %s\n", name);
 
+		gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
+		if (!gate)
+			return -ENOMEM;
+
 		snprintf(name, sizeof(name), "%s#gate%u", dev_name(dev), i);
 
 		init.name = name;
 		init.ops = &clk_gate_ops;
 		init.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED;
 		gate_parent.index = -1;
-		gate_parent.hw = &channel->div.hw;
+		gate_parent.hw = &div->hw;
 		init.parent_data = &gate_parent;
 		init.num_parents = 1;
 
-		channel->gate.reg = meson->base + REG_MISC_AB;
-		channel->gate.bit_idx = meson_pwm_per_channel_data[i].clk_en_shift;
-		channel->gate.hw.init = &init;
-		channel->gate.flags = 0;
-		channel->gate.lock = &meson->lock;
+		gate->reg = meson->base + REG_MISC_AB;
+		gate->bit_idx = meson_pwm_per_channel_data[i].clk_en_shift;
+		gate->hw.init = &init;
+		gate->flags = 0;
+		gate->lock = &meson->lock;
 
-		err = devm_clk_hw_register(dev, &channel->gate.hw);
+		err = devm_clk_hw_register(dev, &gate->hw);
 		if (err)
 			return dev_err_probe(dev, err, "failed to register %s\n", name);
 
-		channel->clk = devm_clk_hw_get_clk(dev, &channel->gate.hw, NULL);
+		channel->clk = devm_clk_hw_get_clk(dev, &gate->hw, NULL);
 		if (IS_ERR(channel->clk))
 			return dev_err_probe(dev, PTR_ERR(channel->clk),
 					     "failed to register %s\n", name);
-- 
2.42.0


