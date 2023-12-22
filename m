Return-Path: <linux-kernel+bounces-9651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 110F181C8F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E631C20AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E231C6A6;
	Fri, 22 Dec 2023 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QUtPrCTh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BC3179A1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cc259392a6so20532301fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1703243846; x=1703848646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJqa3kVWWYiQcg8Win00bhuGpmvRZlPGwxPFmgF93ro=;
        b=QUtPrCThDWE2tB/JiHmwddGMIycm2skmsOb/CY3wMiHAOsJDQrkMvlG/5aHXi7z7/m
         xfERMGl5AShV+k2MHtAoo7N1jbkilJk0Lu/LZ8Pz3p5WXpMi+UTQyvvt/smPxOMThYiL
         2QCWkzkIUiScG2vVEo6t0hGyhRDz9OMn3X4jnEGP+HAUMa7DfAViujJSG/s/FZShAF1o
         5StZqjyNiWbBIlGgH816iy1oVC19UVv4Qv0mheCh80OubuWGXv1VmulBozM0xbPAWbAe
         nDOCQRTnymRMN5hT+y6YEaiy+48TsIxT8XQoD2V5Zd549XA/0HdLs2dR1r2g/7YDrork
         eWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703243846; x=1703848646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJqa3kVWWYiQcg8Win00bhuGpmvRZlPGwxPFmgF93ro=;
        b=Ubn2KTPmcEdZITTv6kfAHiTquTUsgtNono3nS6TvoghVNkwtGCFtLrrPL2NGwnm/Ox
         IB6j5uA45H7SPyrt3QriyPnHcGvhyzDM7ojgp09vD/ul/BRvOE+otpGRwIc998xB+qQ9
         WcJCRhMP0cvh6L2F7HBn6UbXc6lekvpkzbPPXhgpSVRSYDxDm3+ZIU1C+mq0xvfe6MF0
         BV67Br5T24IR63RLOgrgdPRu4fSqYCdbqJgzqmvlNN/U0nB3U+YmCNSjdPjuNR8EDXWB
         lOoURwQXPlObSOl/24SWeUdYIDX/05kTYx7i5uuMLjSpbWXzEnjmijIUWghDBt+ECdZ3
         /Vew==
X-Gm-Message-State: AOJu0YxE8vrqYXKGdfNeSqMvui6TJymakM/B345CWxKRNW4PF+ZNIdOn
	fwdOr6TvlkvFqLby//59zPJB+wNl3P9JZA==
X-Google-Smtp-Source: AGHT+IE8MY2ShungujTaWAHUKjrfZf/vr4bgoomQQiP61LoKa4gO0MC/5GYmz//gJ3hg6/9jWtMVMA==
X-Received: by 2002:a2e:86d7:0:b0:2cc:769e:723d with SMTP id n23-20020a2e86d7000000b002cc769e723dmr528564ljj.87.1703243845072;
        Fri, 22 Dec 2023 03:17:25 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:c099:e596:3179:b0fa])
        by smtp.googlemail.com with ESMTPSA id f8-20020adffcc8000000b003366b500047sm4054069wrs.50.2023.12.22.03.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:17:24 -0800 (PST)
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
Subject: [PATCH v4 4/6] pwm: meson: use device data to carry information around
Date: Fri, 22 Dec 2023 12:16:52 +0100
Message-ID: <20231222111658.832167-5-jbrunet@baylibre.com>
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

Use struct device data to carry the information data around, instead
of embedded the pwm structure in it and using container_of()

Doing so works just as well and makes it a little easier to add setup
callback depending on the DT compatible.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index ef50c337f444..15c44185d784 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -101,7 +101,6 @@ struct meson_pwm_data {
 };
 
 struct meson_pwm {
-	struct pwm_chip chip;
 	const struct meson_pwm_data *data;
 	struct meson_pwm_channel channels[MESON_NUM_PWMS];
 	void __iomem *base;
@@ -114,7 +113,7 @@ struct meson_pwm {
 
 static inline struct meson_pwm *to_meson_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct meson_pwm, chip);
+	return dev_get_drvdata(chip->dev);
 }
 
 static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -146,6 +145,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
+	struct device *dev = pwm->chip->dev;
 	unsigned int cnt, duty_cnt;
 	unsigned long fin_freq;
 	u64 duty, period, freq;
@@ -168,19 +168,19 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
 	fin_freq = clk_round_rate(channel->clk, freq);
 	if (fin_freq == 0) {
-		dev_err(meson->chip.dev, "invalid source clock frequency\n");
+		dev_err(dev, "invalid source clock frequency\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
+	dev_dbg(dev, "fin_freq: %lu Hz\n", fin_freq);
 
 	cnt = div_u64(fin_freq * period, NSEC_PER_SEC);
 	if (cnt > 0xffff) {
-		dev_err(meson->chip.dev, "unable to get period cnt\n");
+		dev_err(dev, "unable to get period cnt\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "period=%llu cnt=%u\n", period, cnt);
+	dev_dbg(dev, "period=%llu cnt=%u\n", period, cnt);
 
 	if (duty == period) {
 		channel->hi = cnt;
@@ -191,7 +191,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	} else {
 		duty_cnt = div_u64(fin_freq * duty, NSEC_PER_SEC);
 
-		dev_dbg(meson->chip.dev, "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
+		dev_dbg(dev, "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
 
 		channel->hi = duty_cnt;
 		channel->lo = cnt - duty_cnt;
@@ -214,7 +214,7 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 
 	err = clk_set_rate(channel->clk, channel->rate);
 	if (err)
-		dev_err(meson->chip.dev, "setting clock rate failed\n");
+		dev_err(pwm->chip->dev, "setting clock rate failed\n");
 
 	spin_lock_irqsave(&meson->lock, flags);
 
@@ -425,10 +425,10 @@ static const struct of_device_id meson_pwm_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
 
-static int meson_pwm_init_channels(struct meson_pwm *meson)
+static int meson_pwm_init_channels(struct device *dev)
 {
 	struct clk_parent_data mux_parent_data[MESON_NUM_MUX_PARENTS] = {};
-	struct device *dev = meson->chip.dev;
+	struct meson_pwm *meson = dev_get_drvdata(dev);
 	unsigned int i;
 	char name[255];
 	int err;
@@ -438,7 +438,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 		mux_parent_data[i].name = meson->data->parent_names[i];
 	}
 
-	for (i = 0; i < meson->chip.npwm; i++) {
+	for (i = 0; i < MESON_NUM_PWMS; i++) {
 		struct meson_pwm_channel *channel = &meson->channels[i];
 		struct clk_parent_data div_parent = {}, gate_parent = {};
 		struct clk_init_data init = {};
@@ -519,28 +519,35 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 static int meson_pwm_probe(struct platform_device *pdev)
 {
 	struct meson_pwm *meson;
+	struct pwm_chip *chip;
 	int err;
 
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
 	meson = devm_kzalloc(&pdev->dev, sizeof(*meson), GFP_KERNEL);
 	if (!meson)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, meson);
+
 	meson->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(meson->base))
 		return PTR_ERR(meson->base);
 
 	spin_lock_init(&meson->lock);
-	meson->chip.dev = &pdev->dev;
-	meson->chip.ops = &meson_pwm_ops;
-	meson->chip.npwm = MESON_NUM_PWMS;
+	chip->dev = &pdev->dev;
+	chip->ops = &meson_pwm_ops;
+	chip->npwm = MESON_NUM_PWMS;
 
 	meson->data = of_device_get_match_data(&pdev->dev);
 
-	err = meson_pwm_init_channels(meson);
+	err = meson_pwm_init_channels(&pdev->dev);
 	if (err < 0)
 		return err;
 
-	err = devm_pwmchip_add(&pdev->dev, &meson->chip);
+	err = devm_pwmchip_add(&pdev->dev, chip);
 	if (err < 0)
 		return dev_err_probe(&pdev->dev, err,
 				     "failed to register PWM chip\n");
-- 
2.42.0


