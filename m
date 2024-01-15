Return-Path: <linux-kernel+bounces-26453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102C682E122
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAC6283813
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A825199D7;
	Mon, 15 Jan 2024 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6k25LwR"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63019473;
	Mon, 15 Jan 2024 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso44219665e9.0;
        Mon, 15 Jan 2024 12:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705348948; x=1705953748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iR96KjiNOLwJsrZW9YjWEMZZO1SB3q3Gyovy8VvF6lw=;
        b=l6k25LwRsDbc/vTBHa64vziXoka4xMWMWp9af+Ki511/xRyMLjGzRfoqHisj3plqyi
         AZVxpPSDTzuwh4fQBFfByoPS3k0HA0o1PFV91MO4/tnkNZml75j+exbU20PP+KiOzBUO
         iT/yF4Xdmc2Ds3PFM7o7uAf6LombgsVQYs1C02B0xFWJXhBjv1LHaEbo63v1w8PrHbkG
         tBUPJQwmLfxkjQgmUVQNyHoHVn9e+VhTcheog+mvt7hkJF5+0UNmWuye0thLIOoT5J5a
         epJCgKQLt0R74hciB506JwCdQrHJmfmZJaZNFNKMmwy9YH2QAV6vcqmh3RefJULQ8MiY
         6R5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705348948; x=1705953748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iR96KjiNOLwJsrZW9YjWEMZZO1SB3q3Gyovy8VvF6lw=;
        b=qoXNERLWhCm+XKrs8FSrv/wdXmieL69s1u1C/JJMQFrpF8m4pbLfYOVO3vokKSenPO
         p1gW0SNulODWo+fCC7msM1UKZX/dUCvNtSH9ZjiqnXoU4kiaRJuYE4ThOaF9X/4JbZe7
         xuBiwI+M/pQeneF5puzfOVcCILhFvXGT1GQmBNFa/mA+Q8+7rafLtO0nL1VlJgWAcDpy
         9pfIiuhEAixg9UtK3HXWheS0mjjfU90EchD779GVMtOT1TsQL8czZ83y8L42OATcei+d
         HdTQvOaEnJwDerll/FlriPUCRgYw/3bpXLiOWeDDEB4Xm25fftM9Z+pLZ+A2QP25/a2h
         emUQ==
X-Gm-Message-State: AOJu0YygzgW7rHbqZXC/HEJ8rSBmvFymayJcneBRyDtXs+twTBtrVJQ+
	3WndvQidpMWuo/08fCDf/ek=
X-Google-Smtp-Source: AGHT+IF/VWjuHv5O5f9qWqmE3BkrbN0yz+e3DwuXT8ubOTcN1ihqmBAfeD6hdzIwWqrmEEwJR9lmgw==
X-Received: by 2002:a05:600c:2112:b0:40e:7f2c:9dbd with SMTP id u18-20020a05600c211200b0040e7f2c9dbdmr681930wml.13.1705348947693;
        Mon, 15 Jan 2024 12:02:27 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-bf32-c470-1874-c1ad.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:bf32:c470:1874:c1ad])
        by smtp.gmail.com with ESMTPSA id m26-20020a7bca5a000000b0040e54381a85sm16377924wml.26.2024.01.15.12.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 12:02:27 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 15 Jan 2024 21:02:22 +0100
Subject: [PATCH v5 2/5] hwmon: (core) Add support for humidity min/max
 alarm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240115-topic-chipcap2-v5-2-0cc7a15aeece@gmail.com>
References: <20240115-topic-chipcap2-v5-0-0cc7a15aeece@gmail.com>
In-Reply-To: <20240115-topic-chipcap2-v5-0-0cc7a15aeece@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705348943; l=2225;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=re14X9c0E+VBxIxbVskjRDUjU7zOxmCOyQzwnK834Ds=;
 b=dd4rGLkjd9y828kruYsv6h+aliJTL24L+Inb5681K1+rd0C9CwKjEcELJmYKjdC+FqbmPrSZ9
 vnIHAL2Mp//C+zhZvr07AomwvL67uM1HRUVizAy/oU2gAmnKh24ZmJK
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


