Return-Path: <linux-kernel+bounces-25383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4A182CEF7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 23:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9F41C2105E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 22:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A384182BF;
	Sat, 13 Jan 2024 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MDY9+/BQ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D85171D8;
	Sat, 13 Jan 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26f73732c5so880465266b.3;
        Sat, 13 Jan 2024 14:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705186018; x=1705790818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JNMD09d2RI31XsyGdLgYlrGA0nsMzH49soHDGceK5A=;
        b=MDY9+/BQ1PzXeR2Sj1JDqdZGXFRJ/8tlGpVKdGEaQpCiAYUoGrgh/q9sfVZvhoSkpX
         /Mcnprk/fGIhQvUk7uJU7l/7aw5rVKAexC7OLtsTum3ipDcnleFM5aLhVYYckXadJHlA
         Fd/ak7kUjyYJemIeS7GXtv++kjp1t+V+4RgMlv6/aoJH+5a0Ot5LtjIj4oavWHSsBupt
         skOcYqvtdg7EiI5phshoyqKstWKTNsflW9GuvDI/dLXO2X20PurgBKGYxdbCaD6lFNB0
         hv1Q5IYwlzuCowod+YWnRtPVkIxWH1nqumkxuxjh/BDbj4Gv7kmcb7W6bTWy8qQzRfLC
         nnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705186018; x=1705790818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JNMD09d2RI31XsyGdLgYlrGA0nsMzH49soHDGceK5A=;
        b=IHKxnDzXGaHWoihXRCSML3qNNee3bsOV2E49U/7UbjXDONinjM3oUKcWZnZT93MzXY
         e5pjxSLIowtmxDDX8u/fBD7vGxX6sUKq3eQzH2GEJrJ1IW3KbYECUQeZr0BTxjNhU8kQ
         gEnLH6wBObWh0xh16PjaKTSQIRRy0EjAUpor0Rfv5wVKJa1RJS5vCVI38cRrjMUOLxr9
         dW/68KM5VAQP3JuJXFwW8cdjF4geB8HI+mdQxDTyw/i4JwGWum5HAcDdvSs7Irn63odQ
         5e6a4b332HzQZQqkN5MNmdxxGzHk8sAuNPpag8tcxjvddFeaph+rysVflCIuPzpZrijQ
         XVzQ==
X-Gm-Message-State: AOJu0YwRDN7H1dmUqagfs88qRoj0x3vYWz+dxwyuDo2MeFXB0HMCRhup
	S81HD6gtuhn0o4ThXZnlLic582ULPMg=
X-Google-Smtp-Source: AGHT+IH57+jQicl/nrMvgqRkc+mYqfkhCajogy2AYQezBOw34978xaHVIC68tHaYJzDWugdeqFxkPg==
X-Received: by 2002:a17:907:908c:b0:a28:e2d7:b41d with SMTP id ge12-20020a170907908c00b00a28e2d7b41dmr1266919ejb.0.1705186018417;
        Sat, 13 Jan 2024 14:46:58 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-6fe7-c700-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:6fe7:c700::e63])
        by smtp.googlemail.com with ESMTPSA id g18-20020a170906595200b00a2d4e658132sm755409ejr.42.2024.01.13.14.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 14:46:57 -0800 (PST)
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
Subject: [RFC PATCH v2 2/3] regulator: pwm-regulator: Calculate the output voltage for disabled PWMs
Date: Sat, 13 Jan 2024 23:46:27 +0100
Message-ID: <20240113224628.377993-3-martin.blumenstingl@googlemail.com>
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

If a PWM output is disabled then it's voltage has to be calculated
based on a zero duty cycle (for normal polarity) or duty cycle being
equal to the PWM period (for inverted polarity). Add support for this
to pwm_regulator_get_voltage().

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes from v1 -> v2:
- update pstate.duty_cycle to catch out-of-range values with the new
  check from the first patch in this series


 drivers/regulator/pwm-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 226ca4c62673..d27b9a7a30c9 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -157,6 +157,13 @@ static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 
 	pwm_get_state(drvdata->pwm, &pstate);
 
+	if (!pstate.enabled) {
+		if (pstate.polarity == PWM_POLARITY_INVERSED)
+			pstate.duty_cycle = pstate.period;
+		else
+			pstate.duty_cycle = 0;
+	}
+
 	voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
 	if (voltage < min(max_uV_duty, min_uV_duty) ||
 	    voltage > max(max_uV_duty, min_uV_duty))
-- 
2.43.0


