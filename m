Return-Path: <linux-kernel+bounces-4278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA63817AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89DFD1F245FF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E12A73462;
	Mon, 18 Dec 2023 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB6XZ2tH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA772045;
	Mon, 18 Dec 2023 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e305530baso2349615e87.3;
        Mon, 18 Dec 2023 11:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702926639; x=1703531439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iR96KjiNOLwJsrZW9YjWEMZZO1SB3q3Gyovy8VvF6lw=;
        b=RB6XZ2tHcvG/NkAbswEXlkox0iNcqvhf5vbAllshpW8+3xmKIjWhdQNXIK56ennc8H
         Rim4OrSLsrwETxRK1Kwt3chrk629Xl/vzYlaCnefG4X60Iu5AZ7L6PkIEjGIPaSxieBt
         mW3fulrkQgHQFWYuJf0IjOB7KJ1+8OEaSAtYEkROezmXRkV6ZClVGwvCD9t4LHuBTsht
         TzVIkO4vkjgrFUMkNu6eTfJ00oM+k4YPtlYBB2IP+sZNx11r5HgJDqiAp0W3DOr3oj1u
         LPpbwT2zvyrY9iDnt2OJYHWvxFa+vCht1j000xYB+HLe58nSmzfR6mehEBy9SMrFuu8e
         z5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702926639; x=1703531439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iR96KjiNOLwJsrZW9YjWEMZZO1SB3q3Gyovy8VvF6lw=;
        b=CDvxcYd1GPTCfpJ7q9vp1IxYMAW7ld2aBj7qHAwT7Kz2F9WocwuDMjsF22Y7SSUJob
         HTtPMKuG6lvPYgWi8SbWG0d5wIhXIGBK1BQKF0bbC089XO9JhRklgHdj+5Wv2artI1Y0
         WPr62B3+Z4e5gXD09W4jefxevAWWrz6XFYHNkCDUGOpXI9QaZ0i280JyunSh1XCLXzs5
         U6E4KECByqSXcVzEsp2YaoGfGV579S4KtYSUzC70lNyeUV1DwKe3htithhQl/ckzbZUp
         PAp0esmsItsDX/lDG+zUCAZUN7iLE4OBs5wH42J/hQIJlsPJY5shS7NIbeJO3oUTTgwS
         sjHw==
X-Gm-Message-State: AOJu0YyoeDDr4FXyyn83wzydMyEZ4rygCc5hn/Y2Uw9DQWScOLeepVlU
	XMOqVXpu+PJFJ4eMsNNshYo=
X-Google-Smtp-Source: AGHT+IFn0boX+o72vreroGEmpYllVfCl6oHKVVO2QGZrdkxsQDNign0sCG8cbfQAvV0fl3GPyEeMrw==
X-Received: by 2002:a05:6512:3da2:b0:50d:12fe:4881 with SMTP id k34-20020a0565123da200b0050d12fe4881mr10720551lfv.4.1702926638935;
        Mon, 18 Dec 2023 11:10:38 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-339c-9917-d041-4030.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:339c:9917:d041:4030])
        by smtp.gmail.com with ESMTPSA id vw6-20020a170907a70600b00a1d80b665dfsm14398956ejc.26.2023.12.18.11.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 11:10:38 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 18 Dec 2023 20:10:30 +0100
Subject: [PATCH v4 2/5] hwmon: (core) Add support for humidity min/max
 alarm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-topic-chipcap2-v4-2-7940cfa7613a@gmail.com>
References: <20231020-topic-chipcap2-v4-0-7940cfa7613a@gmail.com>
In-Reply-To: <20231020-topic-chipcap2-v4-0-7940cfa7613a@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702926633; l=2225;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=re14X9c0E+VBxIxbVskjRDUjU7zOxmCOyQzwnK834Ds=;
 b=TkBmNiSywbp1Yc77Ix0cyOrE+dmDcwVthDD/18c5ENXNS9VhEcRvh0Y47JPFzk0UCCf3UWji2
 s71rmVpbYCEB2XzzoHuxwXPlBAjHMbMlatJDriL/j/2MAn+wIfKqNjV
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

Add min_alarm and max_alarm attributes for humidityX to support devices
that can generate these alarms.
Such attributes already exist for other magnitudes such as tempX.

Tested with a ChipCap 2 temperature-humidity sensor.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/hwmon.c | 2 ++
 include/linux/hwmon.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index c7dd3f5b2bd5..7f92984c37d9 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -579,8 +579,10 @@ static const char * const hwmon_humidity_attr_templates[] = {
 	[hwmon_humidity_input] = "humidity%d_input",
 	[hwmon_humidity_label] = "humidity%d_label",
 	[hwmon_humidity_min] = "humidity%d_min",
+	[hwmon_humidity_min_alarm] = "humidity%d_min_alarm",
 	[hwmon_humidity_min_hyst] = "humidity%d_min_hyst",
 	[hwmon_humidity_max] = "humidity%d_max",
+	[hwmon_humidity_max_alarm] = "humidity%d_max_alarm",
 	[hwmon_humidity_max_hyst] = "humidity%d_max_hyst",
 	[hwmon_humidity_alarm] = "humidity%d_alarm",
 	[hwmon_humidity_fault] = "humidity%d_fault",
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 8cd6a6b33593..154de35e34ac 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -286,8 +286,10 @@ enum hwmon_humidity_attributes {
 	hwmon_humidity_input,
 	hwmon_humidity_label,
 	hwmon_humidity_min,
+	hwmon_humidity_min_alarm,
 	hwmon_humidity_min_hyst,
 	hwmon_humidity_max,
+	hwmon_humidity_max_alarm,
 	hwmon_humidity_max_hyst,
 	hwmon_humidity_alarm,
 	hwmon_humidity_fault,
@@ -299,8 +301,10 @@ enum hwmon_humidity_attributes {
 #define HWMON_H_INPUT			BIT(hwmon_humidity_input)
 #define HWMON_H_LABEL			BIT(hwmon_humidity_label)
 #define HWMON_H_MIN			BIT(hwmon_humidity_min)
+#define HWMON_H_MIN_ALARM		BIT(hwmon_humidity_min_alarm)
 #define HWMON_H_MIN_HYST		BIT(hwmon_humidity_min_hyst)
 #define HWMON_H_MAX			BIT(hwmon_humidity_max)
+#define HWMON_H_MAX_ALARM		BIT(hwmon_humidity_max_alarm)
 #define HWMON_H_MAX_HYST		BIT(hwmon_humidity_max_hyst)
 #define HWMON_H_ALARM			BIT(hwmon_humidity_alarm)
 #define HWMON_H_FAULT			BIT(hwmon_humidity_fault)

-- 
2.39.2


