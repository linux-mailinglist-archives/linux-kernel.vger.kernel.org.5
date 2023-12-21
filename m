Return-Path: <linux-kernel+bounces-9074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA8E81BFED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E852867D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEF376DAD;
	Thu, 21 Dec 2023 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WB0oxVna"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44C6280F;
	Thu, 21 Dec 2023 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d3c4bfe45so12595285e9.1;
        Thu, 21 Dec 2023 13:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703193160; x=1703797960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4Cbsukg0G3muNGOdfceGuCWeyDTmVu8AAhb+DgFIkI=;
        b=WB0oxVna3wSylCA8jCD15INYJLvftWNViGIlL+D93XCa6iL3JIT1IrXtmk9j+37gaw
         Vut++3Xe4muxExe7PI+jabgkXm+ymvsiEFoVQudOCQIbx6lEbI45qkjq/cxWUQbBjcwc
         0NhxPpHzOKT1YZX/jsazWPp/FAhk9JS+6G2E+LSHi9a0yZ/JQgsyX+N8IICZau7KwJix
         nqoALmgbkdfFTUR02RWwUYeoBl2BNXvp1niyl7soB2IDAwCL86CVFGitTrQv/ssSa+a5
         /v/hjxzUNh41/Dau7r4E1kEd4aDn+Begps3J6xKYSuER4Dnu7QHxEgmcFl7mILrPMn0K
         vZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703193160; x=1703797960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4Cbsukg0G3muNGOdfceGuCWeyDTmVu8AAhb+DgFIkI=;
        b=fg33kqsuEcGQJkBTN2ZyG0CCk0gd37eFKA/zXYaqpCeGf7BDU9tkw4BfoSFK8g6p8h
         bghXhHc+7WpOkdKgsyBPqz54FDDeUwdqym9Cez4QlBqk5gFdufIWV/hwhS3p9hDAiSGG
         L5lQqjszPRO++bmAP7SBrnSyzGo64DLfjj69avWBIT2YU1Up2CwKuSp0uav2o7xIMpIS
         08EPMfAoxWC3xf3mOpaCK5swv63yuUWrAk7MbdgpnmYYyrKWvWuOV56A9GjNsqZatNCf
         rbX5JVs5aaWlLSfPsdjVYtrwzHAE/MHolfUN2X+hqr3XzTwZZN85tckkirArpvXyCFCp
         Y83A==
X-Gm-Message-State: AOJu0YwtD69KoSVqDSk7fAGXl/f70dQxelxiCgJDAIbSt5xdqFqRhZlE
	+A8/u646spzvNcW5YQNRdauIAw2CNzg=
X-Google-Smtp-Source: AGHT+IHmELJUnkQDo5KJjUSCQrDQziZzRPhiuycQ2ms54XOnISGI1jfghQbrIMYzE02RPLo8s0fN8w==
X-Received: by 2002:a05:600c:ccf:b0:40d:3d57:eaf5 with SMTP id fk15-20020a05600c0ccf00b0040d3d57eaf5mr105640wmb.164.1703193159410;
        Thu, 21 Dec 2023 13:12:39 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-b96c-7a00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:b96c:7a00::e63])
        by smtp.googlemail.com with ESMTPSA id uz16-20020a170907119000b00a2685eca385sm1341669ejb.195.2023.12.21.13.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 13:12:38 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pwm@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH v1] regulator: pwm-regulator: Fix continuous get_voltage for disabled PWM
Date: Thu, 21 Dec 2023 22:12:22 +0100
Message-ID: <20231221211222.1380658-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.0
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
.dts) because the VDDEE voltage is required for the Meson8b SoC to work.
The public S805 datasheet [0] states on page 17 (where "A5" refers to the
Cortex-A5 CPU cores):
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
pwm-regulator driver which now considers the voltage to be at the
minimum or maximum (depending on whether the polarity is inverted) if
the PWM output is disabled. This makes the VDDEE regulator on Odroid-C1
read 1140mV while the PWM output is disabled, so all following steps try
to keep the 1140mV until any regulator consumer (such as the lima
driver's devfreq implementation) tries to set a different voltage
(1100mV is the target voltage).

[0] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Sending this as RFC as I'm not 100% sure if this is the correct way to
solve my problem. Reverting commit 6b9352f3f8a1 (which I found via git
bisect) also works, but it seems hacky.

Once we agreed on the "correct" solution I will add Fixes tags as needed


 drivers/regulator/pwm-regulator.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 2aff6db748e2..30402ee18392 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -157,7 +157,12 @@ static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 
 	pwm_get_state(drvdata->pwm, &pstate);
 
-	voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
+	if (pstate.enabled)
+		voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
+	else if (max_uV_duty < min_uV_duty)
+		voltage = max_uV_duty;
+	else
+		voltage = min_uV_duty;
 
 	/*
 	 * The dutycycle for min_uV might be greater than the one for max_uV.
-- 
2.43.0


