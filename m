Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30D27E5A38
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbjKHPhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjKHPhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:37:38 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D43138;
        Wed,  8 Nov 2023 07:37:35 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a6190af24aso1094626766b.0;
        Wed, 08 Nov 2023 07:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699457854; x=1700062654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iR96KjiNOLwJsrZW9YjWEMZZO1SB3q3Gyovy8VvF6lw=;
        b=Fmyj4inNDf/PbVRfl7yj+0Y6WC6o3IBl1870dr3aXKoc6OSopT7cHFKX/HcAdmpuH5
         yrupKXmrbRFp+w/Np2unppLEfCLYa7ucunD9Z+CmhrRruG6/f58L9yHLk+cZ9IwY1V4K
         c1NGLQQPMD01wNmDvrfwURJ9wBO4TWwpQtWzEKTFh+pRJ0ZzAZ4JqvMDcO/dAVYbIoN4
         rEfqqURIuRB7XOECuPEIJzLLBMKOeUTZ5KQWd3a36h0HsebCeL5mh0M/UzP8z7WD+2Xx
         1DUB0KMW+OAJ6JtkkyrguDTCwKJZpNxhIvNXF/LwhAurD3NjTneNJzmNpjdIXnNGX53s
         sTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699457854; x=1700062654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iR96KjiNOLwJsrZW9YjWEMZZO1SB3q3Gyovy8VvF6lw=;
        b=e+E23ltbiBuJp+GDsQqL/brH4JNLJO6h1tUxEBCCUlqQt1NdjdyiYZvfHqFmWqbHkj
         iJLIbomgSMhHJYGnbw9o3pUS0/6/gjDZLluntJJQU8joD7wY9K11YL+05gEKotNyG63s
         fGbgdGcJ2e8UhuTdxkBtJDe25n14JChn2f1JtCBFnA4lA3u+JbDAIpaYOvoyeKSnKzQi
         bVoOJF3OJ+bN5sqzsjPJ+y434opXTtMMf/oWIij5VNSreDxbG4YfMBdx+9E10FP5mn7W
         0yBXR+CIJ9tDC82degVCZNwMrD04FQ4yGalHP/e/LZwo4vKjv48VOekhzWz9Qix14bEV
         +vvw==
X-Gm-Message-State: AOJu0YzgcmB+oVrAEBMa/KWoC9IMwD/2OkUhX7bjF6w4AMPJ1xjensgP
        E5Qqxk6mtCZuOugHbWOOuNM=
X-Google-Smtp-Source: AGHT+IFvpQz6IU53s8AC35mADYmMKcNfAIOelcC+vnE8De+ZP5TsRdyNdDUhHDounJYANxlk5WvdFQ==
X-Received: by 2002:a17:907:7e83:b0:9d7:139:ca02 with SMTP id qb3-20020a1709077e8300b009d70139ca02mr1959958ejc.18.1699457854220;
        Wed, 08 Nov 2023 07:37:34 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-840c-82c6-68fb-9a49.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:840c:82c6:68fb:9a49])
        by smtp.gmail.com with ESMTPSA id j28-20020a508a9c000000b0053e3839fc79sm7009966edj.96.2023.11.08.07.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:37:33 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Wed, 08 Nov 2023 16:37:28 +0100
Subject: [PATCH v2 2/4] hwmon: (core) Add support for humidity min/max
 alarm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-topic-chipcap2-v2-2-f5c325966fdb@gmail.com>
References: <20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com>
In-Reply-To: <20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699457849; l=2225;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=re14X9c0E+VBxIxbVskjRDUjU7zOxmCOyQzwnK834Ds=;
 b=G0ri7HM2GmI44QiKtxd/lNS11ugK3iZG0lzeHXpRUwc1yMr7svZeI+YVxuoqZl0yEb8EdDJJ8
 ThOB3QieZEmCXGwPk4/gVKOcHTQ5fs6gUlDtMLYm9+0d2tRaVMbyKfM
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

