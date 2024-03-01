Return-Path: <linux-kernel+bounces-88319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC06886DFFC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E6F1C210A5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3D6F523;
	Fri,  1 Mar 2024 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuJ7dY3n"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B23D6CDC3;
	Fri,  1 Mar 2024 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291565; cv=none; b=rJly8cPylIZqhlm5ZNmr7baMDfZ7ZCx7ghHhd7qwyoKiSeqipkbqqQ5NDtsMaeZ5Dbs/m6wy1juheKTV6ZQyi9KmIiQBRD+5+pNIyErbAfKx5E93NCi9N4Kxk8sYmT5L/loBqtPk3Ix5+S6sY6S8gaxHnCYr/eYGRvACHB6qw3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291565; c=relaxed/simple;
	bh=7IIXC1qsD1MFpjVOqYYi+BOf0Ko89zjnAhsRvckXXLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JZECmuiTBEy4nqfQfDTlDKTjSBsAH8jU4hlsi9S254ADwZFqejfnpfqMGZsk75CO+RRStzCuf/qiOiv/BAoGGoUxIx2bjzUH7eq0xslxjB18wK+6VWxYsOhjGfDE7HRl/sx0kpP07j2KyoSaAb3ftzw3R72OmU39fd1qdS15BM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuJ7dY3n; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a441d7c6125so253510966b.2;
        Fri, 01 Mar 2024 03:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709291562; x=1709896362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPr5OT0hjAf7wDQpFiXt+umkADr7mP/nXjReYVXPj5M=;
        b=IuJ7dY3nK6Qgu/hBg3XdZzffbClVFdoSGQfWE1vXYhRyaNB7r2TPmPXWvkmuVPg8H7
         mT31J9He6NVPNV4n7gh4o19UHsg63Z9KsSYHY6cxZvWt0pUDgXwD3P7VbFYaPt4CO7Tm
         OrQ/EchUsm4C94HpfDOcoofs2Hmz+9qouMN7nyy2aZGwwawEWl3NCEu4j2JdPS2wsmPm
         OQ34JII8VAf+QqUtDjVr/pGTFcy+nehhlVUCAXbjHQMzhAw73iFbw1eXGoZuL0GJvICT
         wRPjsK+wxrR6biXn9BnLrtK5Nx4NIxu21296exygR5ybmW430rk6I3MIavy6ZrXyFb0x
         8xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291562; x=1709896362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPr5OT0hjAf7wDQpFiXt+umkADr7mP/nXjReYVXPj5M=;
        b=NAiXzG/SBrwHhK7Oo0qMxQ/KCbRsURMRuJeqXpyocLF/Nx7tjxhVshlz5DeqWTy7SZ
         HCFQ75ESt9ZXzv7kXuBHEZtJk7wKxgziNs7dsBZ/Uzeo+9WT1YDA6jqd5yQ9gXXKDh4a
         0+9kPlmMUtV8QTPBbNEtx5RcwPZchIfDf6+yN/BVHWaEjR0zYufgiYuGQeJMuJi9lFud
         KSLBLeTmT9y9gS5YGhs+/WrXRItceF+T5ibFYZC57En3UWo0klM1ksIatq7DymcSyYc5
         /sDphp+46grZAJmhnmTDQpttEG4DcwSmaHhHGvoYqvNZRZh9yAZMc0PET0uwgLZRQpKg
         ZYlg==
X-Forwarded-Encrypted: i=1; AJvYcCU12yxnDCai8VpuckolvX18dfkZvJc2usfCLct/o5bRE9aHBJIljMBUOYnBJhtY7XxgOG00oYlIY2yejTJvmIuGRo4LcnoV7+wHqhXKwrfUZninPmANmppEwFS7NUzdGMsTDKt2bVVFaBwyja4swWoBAHJzz3Qiigx4aXMHKRdy9X2Fgw==
X-Gm-Message-State: AOJu0Yx5reZteLfSyqwZhCe+eUMSHbUo621Han5fnFJqPPUN96il3Lod
	3S9iyCPKTnrXhmJYMZHczZVsGYaKibt820VNtAMefFz+6svjJG0R
X-Google-Smtp-Source: AGHT+IGfoQkB/H8ik9gQhKggMPkvacbJTf9TekGtVT+uS77S6XFVNy/3k5wTrM139VVQ1AXLQoYIJA==
X-Received: by 2002:a17:906:6d4e:b0:a44:731c:bacc with SMTP id a14-20020a1709066d4e00b00a44731cbaccmr1146651ejt.10.1709291561812;
        Fri, 01 Mar 2024 03:12:41 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id n18-20020a170906089200b00a43a478e4f0sm1583254eje.180.2024.03.01.03.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:12:41 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] pwm: mc33xs2410: add support for direct inputs
Date: Fri,  1 Mar 2024 12:11:24 +0100
Message-Id: <20240301111124.29283-4-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240301111124.29283-1-dima.fedrau@gmail.com>
References: <20240301111124.29283-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for direct inputs, which are used to directly turn-on or
turn-off the outputs. Direct inputs have the advantage over the SPI
controlled outputs that they aren't limited to the frequency steps.
Frequency resolution depends on the input signal, range is still
from 0.5Hz to 2.048kHz.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/pwm/pwm-mc33xs2410.c | 116 +++++++++++++++++++++++++++++++----
 1 file changed, 105 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
index 35753039da6b..828a67227185 100644
--- a/drivers/pwm/pwm-mc33xs2410.c
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -18,7 +18,10 @@
 #define MC33XS2410_GLB_CTRL_MODE_MASK	GENMASK(7, 6)
 #define MC33XS2410_GLB_CTRL_NORMAL_MODE	BIT(6)
 #define MC33XS2410_GLB_CTRL_SAFE_MODE	BIT(7)
+#define MC33XS2410_GLB_CTRL_CMOS_LEVEL	BIT(0)
 #define MC33XS2410_OUT1_4_CTRL		0x02
+#define MC33XS2410_IN_CTRL1		0x03
+#define MC33XS2410_IN_CTRL1_IN_EN(x)	BIT(x)
 #define MC33XS2410_PWM_CTRL1		0x05
 #define MC33XS2410_PWM_CTRL1_POL_INV(x)	BIT(x)
 #define MC33XS2410_PWM_CTRL3		0x07
@@ -45,6 +48,7 @@
 struct mc33xs2410_pwm {
 	struct pwm_chip chip;
 	struct spi_device *spi;
+	struct pwm_device *di[4];
 	struct mutex lock;
 };
 
@@ -154,20 +158,15 @@ static u8 mc33xs2410_pwm_get_freq(const struct pwm_state *state)
 	return (ret | FIELD_PREP(MC33XS2410_PWM_FREQ_STEP_MASK, step));
 }
 
-static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-				const struct pwm_state *state)
+static int mc33xs2410_pwm_apply_spi(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    const struct pwm_state *state)
 {
 	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
 	struct spi_device *spi = mc33xs2410->spi;
 	u8 mask, val;
 	int ret;
 
-	if (state->period > mc33xs2410_period[STEP_05HZ][MC33XS2410_PERIOD_MAX])
-		return -EINVAL;
-
-	if (state->period < mc33xs2410_period[STEP_32HZ][MC33XS2410_PERIOD_MIN])
-		return -EINVAL;
-
 	guard(mutex)(&mc33xs2410->lock);
 	mask = MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm);
 	val = (state->polarity == PWM_POLARITY_INVERSED) ? mask : 0;
@@ -190,9 +189,38 @@ static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return mc33xs2410_modify_reg(spi, MC33XS2410_PWM_CTRL3, mask, val);
 }
 
-static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
-				    struct pwm_device *pwm,
-				    struct pwm_state *state)
+static int mc33xs2410_pwm_apply_direct_inputs(struct pwm_chip *chip,
+					      struct pwm_device *pwm,
+					      const struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
+	struct pwm_device *di = mc33xs2410->di[pwm->hwpwm];
+
+	guard(mutex)(&mc33xs2410->lock);
+
+	return pwm_apply_state(di, state);
+}
+
+static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+				const struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
+
+	if (state->period > mc33xs2410_period[STEP_05HZ][MC33XS2410_PERIOD_MAX])
+		return -EINVAL;
+
+	if (state->period < mc33xs2410_period[STEP_32HZ][MC33XS2410_PERIOD_MIN])
+		return -EINVAL;
+
+	if (mc33xs2410->di[pwm->hwpwm])
+		return mc33xs2410_pwm_apply_direct_inputs(chip, pwm, state);
+	else
+		return mc33xs2410_pwm_apply_spi(chip, pwm, state);
+}
+
+static int mc33xs2410_pwm_get_state_spi(struct pwm_chip *chip,
+					struct pwm_device *pwm,
+					struct pwm_state *state)
 {
 	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
 	struct spi_device *spi = mc33xs2410->spi;
@@ -236,6 +264,28 @@ static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
 	return 0;
 }
 
+static int mc33xs2410_pwm_get_state_direct_inputs(struct pwm_chip *chip,
+						  struct pwm_device *pwm,
+						  struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
+
+	pwm_get_state(mc33xs2410->di[pwm->hwpwm], state);
+	return 0;
+}
+
+static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
+
+	if (mc33xs2410->di[pwm->hwpwm])
+		return mc33xs2410_pwm_get_state_direct_inputs(chip, pwm, state);
+	else
+		return mc33xs2410_pwm_get_state_spi(chip, pwm, state);
+}
+
 static const struct pwm_ops mc33xs2410_pwm_ops = {
 	.apply = mc33xs2410_pwm_apply,
 	.get_state = mc33xs2410_pwm_get_state,
@@ -257,6 +307,45 @@ static int mc33xs2410_reset(struct device *dev)
 	return 0;
 }
 
+static int mc33xs2410_direct_inputs_probe(struct mc33xs2410_pwm *mc33xs2410)
+{
+	struct device *dev = &mc33xs2410->spi->dev;
+	u16 di_en = 0;
+	char buf[4];
+	int ret, ch;
+
+	for (ch = 0; ch < 4; ch++) {
+		sprintf(buf, "di%d", ch);
+		mc33xs2410->di[ch] = devm_pwm_get(dev, buf);
+		ret = PTR_ERR_OR_ZERO(mc33xs2410->di[ch]);
+		switch (ret) {
+		case 0:
+			di_en |= MC33XS2410_IN_CTRL1_IN_EN(ch);
+			break;
+		case -ENODATA:
+			mc33xs2410->di[ch] = NULL;
+			break;
+		case -EPROBE_DEFER:
+			return ret;
+		default:
+			dev_err(dev, "Failed to request %s: %d\n", buf, ret);
+			return ret;
+		}
+	}
+
+	if (!di_en)
+		return 0;
+
+	/* CMOS input logic level */
+	ret = mc33xs2410_modify_reg(mc33xs2410->spi, MC33XS2410_GLB_CTRL,
+				    MC33XS2410_GLB_CTRL_CMOS_LEVEL,
+				    MC33XS2410_GLB_CTRL_CMOS_LEVEL);
+	if (ret < 0)
+		return ret;
+
+	return mc33xs2410_write_reg(mc33xs2410->spi, MC33XS2410_IN_CTRL1, di_en);
+}
+
 static int mc33xs2410_probe(struct spi_device *spi)
 {
 	struct mc33xs2410_pwm *mc33xs2410;
@@ -290,6 +379,11 @@ static int mc33xs2410_probe(struct spi_device *spi)
 		return dev_err_probe(dev, ret,
 				     "Failed to transition to normal mode\n");
 
+	/* Enable direct inputs */
+	ret = mc33xs2410_direct_inputs_probe(mc33xs2410);
+	if (ret)
+		return ret;
+
 	ret = devm_pwmchip_add(dev, &mc33xs2410->chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
-- 
2.39.2


