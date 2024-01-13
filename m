Return-Path: <linux-kernel+bounces-25382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C3282CEF4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 23:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966091C20F92
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 22:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A1018048;
	Sat, 13 Jan 2024 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="H3bgI93m"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBC3168A7;
	Sat, 13 Jan 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28d61ba65eso877374066b.3;
        Sat, 13 Jan 2024 14:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705186017; x=1705790817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DY9iwm5mIi1yu3RP8RXkfD0AElUziXIbkBosoDfpThM=;
        b=H3bgI93mjqra2P+5N/BwWUiMBHWmxsV7ll8TbTsYsHXFlZ4BvvVT4HUKK7H8aliTac
         GlExmATvZaZAwV9zcAIXiqlDYYvkjZQ18P95mDfayPe63wy1+GlnQAOTrZYBS8/3Aue4
         /U6ZjRy96SzzMBZgUD+SJQVPe/tLcmScUvBExoDklhldC5p9k4dGj9Gcggku8QLiG9H8
         sK5asLsgHfnXiV9EVKFNAtn86jl01nmLoyCJVAXbWwZM1Q5Bc+yWumalbm3unGLLiNHm
         q0mAie1IvXc/V5nIzYF3jagS4KXYuOyWO5m8qbvkd4bmNeVZ8rtl54MrB930zZnvOpi3
         QPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705186017; x=1705790817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DY9iwm5mIi1yu3RP8RXkfD0AElUziXIbkBosoDfpThM=;
        b=uvkya0e7jlaMn75Rx0r9GoC25U8Zfn1TE2tu7XE8k75dRo0/clDY62X6quylO1IY0Q
         zhxexOjUQSHy+0nBfsCCo1wrvnPEBF2VNemiFJMStZFJ1vaFVh1Ze7AVRlA/NBE/mhac
         riAYD823jQppvfD26ido9j6yfeKqzd2z4pn92Kqyb+J020sZJJ96s1FbHqD8tmwtD+9L
         La22FoUfmmy3HrdOrbIojbRFT9IZ/d+gSAecHR00InP+mFU23ytVT8CwVbDSwc6DglsC
         gf4Vp9pdwxDKr9Ot41nu5TLIpuhqJylIl7Lt2mje48LLCtxy1L6sKLlU0TVN0xZ1A22J
         dXSw==
X-Gm-Message-State: AOJu0YyJpCxOWmGnfagOwVoNZgba+9xnynjsXJ0cE3ef/oIsFj/HF/lF
	J7fKx2t1K4jygSmeAg8j5kI=
X-Google-Smtp-Source: AGHT+IH62OCCDlaYXs/phJT6VVbys7so+fsQxIC6B1SCuu1YODV45kYu9d5gsD4El1bDlgTa3vn+8w==
X-Received: by 2002:a17:906:ae54:b0:a2d:559a:c72d with SMTP id lf20-20020a170906ae5400b00a2d559ac72dmr263432ejb.229.1705186017432;
        Sat, 13 Jan 2024 14:46:57 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-6fe7-c700-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:6fe7:c700::e63])
        by smtp.googlemail.com with ESMTPSA id g18-20020a170906595200b00a2d4e658132sm755409ejr.42.2024.01.13.14.46.56
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
Subject: [RFC PATCH v2 1/3] regulator: pwm-regulator: Add validity checks in continuous .get_voltage
Date: Sat, 13 Jan 2024 23:46:26 +0100
Message-ID: <20240113224628.377993-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113224628.377993-1-martin.blumenstingl@googlemail.com>
References: <20240113224628.377993-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Continuous regulators can be configured to operate only in a certain
duty cycle range (for example from 0..91%). Add a check to error out if
the duty cycle translates to an unsupported (or out of range) voltage.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes from v1 -> v2:
- this patch is new, using suggestions from Uwe


 drivers/regulator/pwm-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 698c420e0869..226ca4c62673 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -158,6 +158,9 @@ static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 	pwm_get_state(drvdata->pwm, &pstate);
 
 	voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
+	if (voltage < min(max_uV_duty, min_uV_duty) ||
+	    voltage > max(max_uV_duty, min_uV_duty))
+		return -ENOTRECOVERABLE;
 
 	/*
 	 * The dutycycle for min_uV might be greater than the one for max_uV.
-- 
2.43.0


