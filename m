Return-Path: <linux-kernel+bounces-79894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75F2862808
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7292CB214AC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E134E1CB;
	Sat, 24 Feb 2024 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4n6wHvM"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B34C63D;
	Sat, 24 Feb 2024 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708814999; cv=none; b=t0EYWpFadJ+CAxMUJPKuP2QJoobke1SOFM1YBIpr9FWIfd56aGcuVg88RHd+/OGJxcBsVW+Ngh/p095UL502iQH7Rjxoj7QlGgqyf0ojD0SIpUrIbUxmkPAbS3XtNEJMtD1LbnBEpnWoCbw0tNUCHCA8e//6l+qoGxCjTXpoIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708814999; c=relaxed/simple;
	bh=+M/IcrkC4KiqVSgKEfF4MEPWWH07B+P/vlCcnh7YeNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/NJFUnPlAN+Tc5iV4vntKhCM8zqygqYQy1qiHv7+WGKXubNakfcRE1iVttw+46ArTUeSxCSqWUZi9q5aOA0KaMS1rgA5Q21CRvJcJFaBEpcfvCDnnSwIDtl5LcUkfMKVC0BSPg3UIqH6Cp9qbfzymYZ8wdV5UT2M2vs4SVguto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4n6wHvM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5655c7dd3b1so2870493a12.0;
        Sat, 24 Feb 2024 14:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708814996; x=1709419796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dpglvbug8B6rz9FHKHRWvwGpjAjoa19+rytvw+mL+G8=;
        b=Z4n6wHvMA6d83CuYaa3qrH+S2RI/fVNdzo68PIFxPKSC2Z9x851cyO049Ovfjb3LIO
         AC/0YUHmMI1/A/b+oPNdU81Rm7yXiQzTJ8p0urhj2Zi6gkTOLljJWtn16RdUsw/0tjV9
         79FJyGV48zh9NUf5qCixQ+3k9LOqNLXEJxNe2PTshySjf12PvrFhKjDavc/US25eJdkX
         QgKyFQK8c9lKDVW13mkyoXBIJ+dUwe80pOqahPxHxfhbKoV7PJSVulfXIfMupT4fI18M
         ynd+LNclizDyxhhB/grCAfZPdiTZH0YdS/uftuA9kcpirWQCY6sgGyJBEHVhS1W8YhyU
         Y87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708814996; x=1709419796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpglvbug8B6rz9FHKHRWvwGpjAjoa19+rytvw+mL+G8=;
        b=j1H5nkKQNOub8EpK/iJ6LrPYFrllvvUifmGk5xQUWy1kwgRf8ZgsMOIRegiksxXwNX
         87Ms5RGAzRRTzzFS7RuDBqmzwbnUmTAOpa9Q/bsvl5e3sSYlkmfEz5rVAlfmXu2S8X2+
         Hp75Yjz3ypTBgxeAX+UXEw5eNWb4rCQzG6357eCedzXCgYjt/w7EKWJhyoJ0wanqJHci
         83SJ4rcORccxb4EcEgr8vXu3UZnP5VenHR98eglO1j6UIaE9QdIfb5xZWfpFML+xJgrP
         pX1D4khW8Z56PxYRk/NrYynkUeWw8IFL/RoxvBKQFk0UX4o62VHsjsN5kwTDXs1znHTe
         vV2A==
X-Forwarded-Encrypted: i=1; AJvYcCXT4A+LP4y2gDm/+pak7blnjg4RluAJC+VEbFGUrZja7jdIRG55ztCGDM+WT2Ohdy4EPCH1r41PKnmwcs6JHPojtFtppaVo1+RWG89LgJs16ai6+aMv5QUf/a0yVS2aEPyfhFUmSPREH/Y1yG+2KDwuAfgapOudFHqcAMRSX34favy4UPFGQ57u2+3J6eXHGnKhhCoEUHYSL53o3PLAuQklnROf
X-Gm-Message-State: AOJu0YwVC/aKXO/c3FYq3y3RthrIiaD54Cskzcp1eDEiahTdDe6v3A0A
	LBOu+WSVjzu+eV1XJTxOu+znB84dUE5hOlA53PMC4QYAsQPaCPoj
X-Google-Smtp-Source: AGHT+IHezV4As1b96/JxzDP6NBZJMXtzlZvALrG1yUtw58NRnfOwh1D+9iMHqeOsJkYgoUvEacE24g==
X-Received: by 2002:a17:906:c9d3:b0:a3e:69ff:141f with SMTP id hk19-20020a170906c9d300b00a3e69ff141fmr2679500ejb.33.1708814996309;
        Sat, 24 Feb 2024 14:49:56 -0800 (PST)
Received: from unknown.netbird.cloud ([37.161.229.181])
        by smtp.googlemail.com with ESMTPSA id ti6-20020a170907c20600b00a431cc4bd3dsm145672ejc.182.2024.02.24.14.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 14:49:55 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH 1/3] leds: qcom-lpg: Add support for PMI8950 PWM
Date: Sat, 24 Feb 2024 23:49:49 +0100
Message-ID: <20240224224951.1357644-1-morf3089@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PMI8950 PMIC contains 1 PWM channel

Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 6bdc5b923f98..9467c796bd04 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1693,6 +1693,13 @@ static const struct lpg_data pm8941_lpg_data = {
 	},
 };
 
+static const struct lpg_data pmi8950_pwm_data = {
+	.num_channels = 1,
+	.channels = (const struct lpg_channel_data[]) {
+		{ .base = 0xb000 },
+	},
+};
+
 static const struct lpg_data pm8994_lpg_data = {
 	.lut_base = 0xb000,
 	.lut_size = 64,
@@ -1819,6 +1826,7 @@ static const struct of_device_id lpg_of_table[] = {
 	{ .compatible = "qcom,pm8941-lpg", .data = &pm8941_lpg_data },
 	{ .compatible = "qcom,pm8994-lpg", .data = &pm8994_lpg_data },
 	{ .compatible = "qcom,pmi632-lpg", .data = &pmi632_lpg_data },
+	{ .compatible = "qcom,pmi8950-pwm", .data = &pmi8950_pwm_data },
 	{ .compatible = "qcom,pmi8994-lpg", .data = &pmi8994_lpg_data },
 	{ .compatible = "qcom,pmi8998-lpg", .data = &pmi8998_lpg_data },
 	{ .compatible = "qcom,pmc8180c-lpg", .data = &pm8150l_lpg_data },
-- 
2.44.0


