Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34CF8091C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjLGTpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjLGToz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:44:55 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D8A1709;
        Thu,  7 Dec 2023 11:45:01 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso1864259a12.3;
        Thu, 07 Dec 2023 11:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701978299; x=1702583099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iR96KjiNOLwJsrZW9YjWEMZZO1SB3q3Gyovy8VvF6lw=;
        b=c8Iq9OGSDTXULqsFMiUWJ1ixM+dCdkmMijuC3xTRiggdwXJooBb0ETWsh5GdGQe95M
         CLkj6rZCuoz8fN21B5STx3nJiQ9Iu7En6aRF8OhffOvK4NbBxzf6JHEaCaJ4vWNeCt8+
         3FNhXsvbfbE1EPqSzm0mtKKUfMJKtIPyIg6rFtmql4dh9VcGBgt5ZoMn/e5X++uANZtK
         NDo3C0TLMNOrwKjDfmuVMsMlxvoQtURLJYlyDJN+xgS5hOkBpPO/1rsRNdA5NOkEipQ1
         g7v+/TJWiSFY8gjp2M7uksCgLzJu1cm2ypz5j2vrujcxF5mQ/Tcq0IpC9GYAmNGKvPK/
         wpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701978299; x=1702583099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iR96KjiNOLwJsrZW9YjWEMZZO1SB3q3Gyovy8VvF6lw=;
        b=c5BhCDDABSHLxxUZ84wGfE+MJJYwR6ArCnD8pIkN+mQoSd48MS/5ByVtVEN+VVRUmF
         X5U2cv6LJR+LyVg5B8nFC4lsyZmQwltvjNgFd6Z7VR7VZbYnfoOHm9OehOm+WKZk4Pe1
         iwhiNwiBQ6UBfQ2+bi93u2o67p3xFSF4CXnhjmOXsFtLB6HaScIcumPM1rcCozDmIU9p
         zQ4RFCa0vXvLmv7+kyOeuJRfSuVniKzzW6dX2GY9GCUki0eaDJgLkK7bOxtgiJNK+nzm
         k/7/TgRdVUdUueghz6kQTAlwnJgzVqKA42T9y5F11QjlqmhYao1FUxNzjfTvKoMvD0r5
         vsZA==
X-Gm-Message-State: AOJu0YyvQsJdSbynHNWZwROKiv0+SL4pf8ieCEAc22V1KBarHbX4JMpv
        PhPhWwGsBBhOaKNJvGhqypXcUTBaALKUSA==
X-Google-Smtp-Source: AGHT+IGGfg6FQkDeXgFVOZAAwsGykP8saS+dQgbd6tzsdn7cTkB8gmpMf11d4ZrPl2zNZU3SJZ39zg==
X-Received: by 2002:a17:906:3f5b:b0:a10:8db4:bcf3 with SMTP id f27-20020a1709063f5b00b00a108db4bcf3mr2164697ejj.9.1701978299216;
        Thu, 07 Dec 2023 11:44:59 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1de9-f6cf-eef8-174f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1de9:f6cf:eef8:174f])
        by smtp.gmail.com with ESMTPSA id rr17-20020a170907899100b00a1d457954d6sm127364ejc.75.2023.12.07.11.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 11:44:58 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Thu, 07 Dec 2023 20:44:52 +0100
Subject: [PATCH v3 2/5] hwmon: (core) Add support for humidity min/max
 alarm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-topic-chipcap2-v3-2-5b3bb50a5f0b@gmail.com>
References: <20231020-topic-chipcap2-v3-0-5b3bb50a5f0b@gmail.com>
In-Reply-To: <20231020-topic-chipcap2-v3-0-5b3bb50a5f0b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701978294; l=2225;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=re14X9c0E+VBxIxbVskjRDUjU7zOxmCOyQzwnK834Ds=;
 b=6+7E7/19cnzN0IzDd0a0MN1feBqT8ruX2D3qeCJ1uUNbYkWz1JYXsq2M+Ky3CGJcDcyc1c2K3
 dc1V6ZyWHOXBBg/Mw+a5UKLAbMVyel7oYNKn8OyNw0w6E3RqLJyiKSE
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

