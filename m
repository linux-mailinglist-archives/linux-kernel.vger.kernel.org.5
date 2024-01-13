Return-Path: <linux-kernel+bounces-25384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A8482CEF9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 23:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7212CB22227
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 22:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D774B18646;
	Sat, 13 Jan 2024 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Piszy7Xm"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693851804A;
	Sat, 13 Jan 2024 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5592019711fso193203a12.0;
        Sat, 13 Jan 2024 14:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705186019; x=1705790819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u77d1PdAZp3rFhBqhc5w9JQRTU1ABuAUI/VbGA4eG5E=;
        b=Piszy7Xm+GIOKAYhAve6L8kGuZslbrJO76Fkc73X/7cUdG5Mqc/jLCPWDGod8G9k37
         OKFB1z4DEWByAGTt8++1BeGQJSd6XFmzV8MsTZq98N39N5mWiYv22hfLDULRl+UxMCeS
         1r09UPn30Mx2mU881M+iFmViguVrXQLTe4JpFDrftNwKyJN3iCUN68dtlm65xEgoQDYg
         zAA2a1Yi7bgmBiC/tFVy3cUj3cTsyAHXd4xjKi8RCjj4QktuLKTkNJ/PqcsF1fb25XIq
         q5lUk02dUb0R8PUgNq4nvUFSs9rE0MBK2kXh6cn2A9/EJ72PeOTmBniYSKO68UIfEv8Q
         PmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705186019; x=1705790819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u77d1PdAZp3rFhBqhc5w9JQRTU1ABuAUI/VbGA4eG5E=;
        b=mZvYYvZaJWgb3ytQ6N8N2CQGoO90agEhKngV247VMsT8sFCwWCVYP9CAbBUN/I2Yzs
         LDbL59ucexP3e3DO6wPxww9FU7UHOe1+2pHDZAm1RWKmJfW+ySvDyGlTpwAJZp6Wgiu9
         2Wl2+IdjkGnUjZyzB1s2frc7giBjV+ynj3YPz6hW09SyUHHqMuSwS//8fg4AnG7uSyRE
         yYbNFfIvZLdjQ1lqWyoHd/eEIubTpC+8v5TQJ4G8DcckV+aiCig2ZJskZ+oYvkFaO+/5
         7O8KkkZ6h0c0c2kV1lxnXqBmiDUF6y9+MA3zsGm6/jEDyt+/kFNu71FyoMM6vVoZvYfF
         kPnQ==
X-Gm-Message-State: AOJu0YzxXVTvPZB9dtLXMNBBG6t35nb+ajj49guU0wLXOj+3/E92ZNNg
	qxL4d7ViCDA+iPvbEmAYzWs=
X-Google-Smtp-Source: AGHT+IGrTHqAsnkxLbC9/RDxevudhcPYQyFh07IzdE4LD1fX0nX39xtURTRDLkgg0t9KwbqmZEZvHA==
X-Received: by 2002:a17:907:1a55:b0:a2b:1ba9:873b with SMTP id mf21-20020a1709071a5500b00a2b1ba9873bmr1400845ejc.125.1705186019470;
        Sat, 13 Jan 2024 14:46:59 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-6fe7-c700-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:6fe7:c700::e63])
        by smtp.googlemail.com with ESMTPSA id g18-20020a170906595200b00a2d4e658132sm755409ejr.42.2024.01.13.14.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 14:46:58 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pwm@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH v2 3/3] regulator: pwm-regulator: Manage boot-on with disabled PWM channels
Date: Sat, 13 Jan 2024 23:46:28 +0100
Message-ID: <20240113224628.377993-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113224628.377993-1-martin.blumenstingl@googlemail.com>
References: <20240113224628.377993-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Odroid-C1 uses a Monolithic Power Systems MP2161 controlled via PWM for
the VDDEE voltage supply of the Meson8b SoC. Commit 6b9352f3f8a1 ("pwm:
meson: modify and simplify calculation in meson_pwm_get_state") results
in my Odroid-C1 crashing with memory corruption in many different places
(seemingly at random). It turns out that this is due to a currently not
supported corner case.

The VDDEE regulator can generate between 860mV (duty cycle of ~91%) and
1140mV (duty cycle of 0%). We consider it to be enabled by the bootloader
(which is why it has the regulator-boot-on flag in .dts) as well as
being always-on (which is why it has the regulator-always-on flag in
dts) because the VDDEE voltage is generally required for the Meson8b
SoC to work. The public S805 datasheet [0] states on page 17 (where "A5"
refers to the Cortex-A5 CPU cores):
  [...] So if EE domains is shut off, A5 memory is also shut off. That
  does not matter. Before EE power domain is shut off, A5 should be shut
  off at first.

It turns out that at least some bootloader versions are keeping the PWM
output disabled. This is not a problem due to the specific design of the
regulator: when the PWM output is disabled the output pin is pulled LOW,
effectively achieving a 0% duty cycle (which in return means that VDDEE
voltage is at 1140mV).

The problem comes when the pwm-regulator driver tries to initialize the
PWM output. To do so it reads the current state from the hardware, which
is:
  period: 3666ns
  duty cycle: 3333ns (= ~91%)
  enabled: false
Then those values are translated using the continuous voltage range to
860mV.
Later, when the regulator is being enabled (either by the regulator core
due to the always-on flag or first consumer - in this case the lima
driver for the Mali-450 GPU) the pwm-regulator driver tries to keep the
voltage (at 860mV) and just enable the PWM output. This is when things
start to go wrong as the typical voltage used for VDDEE is 1100mV.

Commit 6b9352f3f8a1 ("pwm: meson: modify and simplify calculation in
meson_pwm_get_state") triggers above condition as before that change
period and duty cycle were both at 0. Since the change to the pwm-meson
driver is considered correct the solution is to be found in the
pwm-regulator driver. Update the duty cycle during driver probe if the
regulator is flagged as boot-on so that a call to pwm_regulator_enable()
(by the regulator core during initialization of a regulator flagged with
boot-on) without any preceding call to pwm_regulator_set_voltage() does
not change the output voltage.

[0] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes from v1 -> v2:
- This patch is new and the idea is to keep the voltage regulator
  description in device-tree as-is (which means: support for 860mV to
  1140mV). Instead we allow the pwm-regulator driver to preserve the
  output voltage at boot when enabling the regulator.
- note: Mark Brown said in v1 "I'd expect a change in the init_state()
  function". That function is not updated as it's only relevant for
  regulators with a voltage table - on Odroid-C1 we have a continuous
  regulator though.


 drivers/regulator/pwm-regulator.c | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index d27b9a7a30c9..60cfcd741c2a 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -323,6 +323,32 @@ static int pwm_regulator_init_continuous(struct platform_device *pdev,
 	return 0;
 }
 
+static int pwm_regulator_init_boot_on(struct platform_device *pdev,
+				      struct pwm_regulator_data *drvdata,
+				      const struct regulator_init_data *init_data)
+{
+	struct pwm_state pstate;
+
+	if (!init_data->constraints.boot_on || drvdata->enb_gpio)
+		return 0;
+
+	pwm_get_state(drvdata->pwm, &pstate);
+	if (pstate.enabled)
+		return 0;
+
+	/*
+	 * Update the duty cycle so the output does not change
+	 * when the regulator core enables the regulator (and
+	 * thus the PWM channel).
+	 */
+	if (pstate.polarity == PWM_POLARITY_INVERSED)
+		pstate.duty_cycle = pstate.period;
+	else
+		pstate.duty_cycle = 0;
+
+	return pwm_apply_might_sleep(drvdata->pwm, &pstate);
+}
+
 static int pwm_regulator_probe(struct platform_device *pdev)
 {
 	const struct regulator_init_data *init_data;
@@ -382,6 +408,13 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = pwm_regulator_init_boot_on(pdev, drvdata, init_data);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to apply boot_on settings: %d\n",
+			ret);
+		return ret;
+	}
+
 	regulator = devm_regulator_register(&pdev->dev,
 					    &drvdata->desc, &config);
 	if (IS_ERR(regulator)) {
-- 
2.43.0


