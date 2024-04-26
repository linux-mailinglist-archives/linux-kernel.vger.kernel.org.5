Return-Path: <linux-kernel+bounces-160097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3BC8B3915
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC77287453
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F90E148854;
	Fri, 26 Apr 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dx0uVD5b"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F71148825;
	Fri, 26 Apr 2024 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139633; cv=none; b=G2o8dolx1p4IqbEeDFW4zboVq3vaiiFGuNVvd5OO1uI0uS+AYeX/yHQkaAhYNtPdU5b6dGHMqie8YINnDADLFOyzI4qgC5bfbodTHjMZFPmbRN+H1uAjXv6tOXc+Xe7aFTm1uo5OZDIap8Qb1KT/8wySypMvV1Ba/x/0FiDecmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139633; c=relaxed/simple;
	bh=s46D5VE1a9+LZtM8feY9X9CdkNYJktMcrrTVJv0uZbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t006Dui5IzppOdqhBG+gz/f/w9wRporuaM2fQmfxFq26i9OUJTO9XAxNEvdmgSaikuxdZO+FVaxOXqchSdx4i7QQiEjd0OFTh+q+JUQ3sYwbiKYvcj5sSBb8DAeG10kGHWMUNBzDQ8A3Mkz+VnwD/fC7EMvft4LSw+40z1H19UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dx0uVD5b; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-347c197a464so1554771f8f.2;
        Fri, 26 Apr 2024 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714139629; x=1714744429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts8PanbuocYKHioybpUJKUW7o4eKULt+4+GailhanEU=;
        b=dx0uVD5b8XPIn/aCxvSoZOS9b5INzRcwkCfMsJfqbxsPaeaD2m94SzC8kvksb9qCtZ
         KqoZK76MdmZO95lnlL8EhfIIhTPYysR03Qny13ZgYYB4YxOOonhJugzufchxDlcC7F3x
         KQ2n/DRe3TjOCRJ0QeUHkMgU9DKt+zLq7H3stt+m4CPaU580tFi5gG0sCMqAu22QBKMm
         yAZk/UkdEATRIoEUvZs7gy5y/oaEOueUf99JZAKNjOmbanR9607D1jm3j9rboRljxeO2
         HQ2/ci4/r1VQZ83vWqjiHenVQ6Kx4sWuiS6JXEFqMWIQXgW3FQGXMBYrSkD+MnCdBQ1Z
         D++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139629; x=1714744429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ts8PanbuocYKHioybpUJKUW7o4eKULt+4+GailhanEU=;
        b=QsaY8IDwS2TQ1SRIYtOpGwwBDcirLd+PlCbfGuzAa7A8XjmRXmFQnOnhHFr4o7Gjjx
         nvqFsWK2bJ7/CifvmqnJeaY/JsePpzLxAN1WnCRFZ64vUU+fi7qcAPXWC4ARO0DIcamR
         GonECGr4s3Yrzq5Jt8WHyLDM3KCjaghwRKtztdkvvdS3fxeflH54s7uqus1vVGEpj2Bn
         w68RmMP4/Cj78t72ra8bEnNkziADlayApjgqDP7z1OGV3RMYXda0wo/2bkog+DJrOuZN
         I0G/IQzshejNf2MRrWbTRmYu4UIEIiieZrLh3FyCcxJUfC4NhQDcMjuzvhC6X/RuaXkv
         b5WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt08rqb4DzluP3eyLKlt092K8q8a8SKa8i7ib6eBNMXfgYpsSxxOgIfXOE+0U+BwoSemZM9jfJg3adXmrOMixx2PM++dgRHqAiGofdd+iMusIg4ycV7ZDfQIobOXHPI7tU/+Dr7g==
X-Gm-Message-State: AOJu0YxXc3L87ty/qTAWzbFy85qKS3LG36d6YoXNChM2meELo5bVbNLD
	s4t6jDPRvjKn/w11IaUQ/ke4suExQaBHCbgalolkl1pF/3UT+OasL35EEUow
X-Google-Smtp-Source: AGHT+IEYxwA/tYeZdOVQU2YXoLT3zHxBrre6YzwqxgOq69D5zKpU3QgN2/qRc5jLZSpp2z7mKGnmdQ==
X-Received: by 2002:a05:6000:1251:b0:34a:5683:1c37 with SMTP id j17-20020a056000125100b0034a56831c37mr1795930wrx.51.1714139628840;
        Fri, 26 Apr 2024 06:53:48 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:320d:e800:f4f8:b5e1:d7d4:bf65])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6d46000000b003434f526cb5sm22302919wri.95.2024.04.26.06.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:53:48 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH 3/7] iio: imu: adis16475: Re-define ADIS16475_DATA
Date: Fri, 26 Apr 2024 16:53:35 +0300
Message-Id: <20240426135339.185602-4-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
References: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-define ADIS16475_DATA such that it takes _burst_max_len and
_burst_max_speed_hz as parameters.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
 drivers/iio/imu/adis16475.c | 136 +++++++++++++++++++++++-------------
 1 file changed, 89 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 7fab40daa659..52333772fbe0 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -690,32 +690,32 @@ static const char * const adis16475_status_error_msgs[] = {
 	[ADIS16475_DIAG_STAT_CLK] = "Clock error",
 };
 
-#define ADIS16475_DATA(_prod_id, _timeouts)				\
-{									\
-	.msc_ctrl_reg = ADIS16475_REG_MSG_CTRL,				\
-	.glob_cmd_reg = ADIS16475_REG_GLOB_CMD,				\
-	.diag_stat_reg = ADIS16475_REG_DIAG_STAT,			\
-	.prod_id_reg = ADIS16475_REG_PROD_ID,				\
-	.prod_id = (_prod_id),						\
-	.self_test_mask = BIT(2),					\
-	.self_test_reg = ADIS16475_REG_GLOB_CMD,			\
-	.cs_change_delay = 16,						\
-	.read_delay = 5,						\
-	.write_delay = 5,						\
-	.status_error_msgs = adis16475_status_error_msgs,		\
-	.status_error_mask = BIT(ADIS16475_DIAG_STAT_DATA_PATH) |	\
-		BIT(ADIS16475_DIAG_STAT_FLASH_MEM) |			\
-		BIT(ADIS16475_DIAG_STAT_SPI) |				\
-		BIT(ADIS16475_DIAG_STAT_STANDBY) |			\
-		BIT(ADIS16475_DIAG_STAT_SENSOR) |			\
-		BIT(ADIS16475_DIAG_STAT_MEMORY) |			\
-		BIT(ADIS16475_DIAG_STAT_CLK),				\
-	.unmasked_drdy = true,						\
-	.timeouts = (_timeouts),					\
-	.burst_reg_cmd = ADIS16475_REG_GLOB_CMD,			\
-	.burst_len = ADIS16475_BURST_MAX_DATA,				\
-	.burst_max_len = ADIS16475_BURST32_MAX_DATA,			\
-	.burst_max_speed_hz = ADIS16475_BURST_MAX_SPEED			\
+#define ADIS16475_DATA(_prod_id, _timeouts, _burst_max_len, _burst_max_speed_hz)	\
+{											\
+	.msc_ctrl_reg = ADIS16475_REG_MSG_CTRL,						\
+	.glob_cmd_reg = ADIS16475_REG_GLOB_CMD,						\
+	.diag_stat_reg = ADIS16475_REG_DIAG_STAT,					\
+	.prod_id_reg = ADIS16475_REG_PROD_ID,						\
+	.prod_id = (_prod_id),								\
+	.self_test_mask = BIT(2),							\
+	.self_test_reg = ADIS16475_REG_GLOB_CMD,					\
+	.cs_change_delay = 16,								\
+	.read_delay = 5,								\
+	.write_delay = 5,								\
+	.status_error_msgs = adis16475_status_error_msgs,				\
+	.status_error_mask = BIT(ADIS16475_DIAG_STAT_DATA_PATH) |			\
+		BIT(ADIS16475_DIAG_STAT_FLASH_MEM) |					\
+		BIT(ADIS16475_DIAG_STAT_SPI) |						\
+		BIT(ADIS16475_DIAG_STAT_STANDBY) |					\
+		BIT(ADIS16475_DIAG_STAT_SENSOR) |					\
+		BIT(ADIS16475_DIAG_STAT_MEMORY) |					\
+		BIT(ADIS16475_DIAG_STAT_CLK),						\
+	.unmasked_drdy = true,								\
+	.timeouts = (_timeouts),							\
+	.burst_reg_cmd = ADIS16475_REG_GLOB_CMD,					\
+	.burst_len = ADIS16475_BURST_MAX_DATA,						\
+	.burst_max_len = _burst_max_len,						\
+	.burst_max_speed_hz = _burst_max_speed_hz					\
 }
 
 static const struct adis16475_sync adis16475_sync_mode[] = {
@@ -753,7 +753,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16470, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16470, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16475_1] = {
 		.name = "adis16475-1",
@@ -770,7 +772,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16475_2] = {
 		.name = "adis16475-2",
@@ -787,7 +791,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16475_3] = {
 		.name = "adis16475-3",
@@ -804,7 +810,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16477_1] = {
 		.name = "adis16477-1",
@@ -822,7 +830,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16477_2] = {
 		.name = "adis16477-2",
@@ -840,7 +850,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16477_3] = {
 		.name = "adis16477-3",
@@ -858,7 +870,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16465_1] = {
 		.name = "adis16465-1",
@@ -875,7 +889,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16465_2] = {
 		.name = "adis16465-2",
@@ -892,7 +908,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16465_3] = {
 		.name = "adis16465-3",
@@ -909,7 +927,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16467_1] = {
 		.name = "adis16467-1",
@@ -926,7 +946,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16467_2] = {
 		.name = "adis16467-2",
@@ -943,7 +965,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16467_3] = {
 		.name = "adis16467-3",
@@ -960,7 +984,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16500] = {
 		.name = "adis16500",
@@ -979,7 +1005,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16500, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16500, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16501] = {
 		.name = "adis16501",
@@ -998,7 +1026,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16501, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16501, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16505_1] = {
 		.name = "adis16505-1",
@@ -1017,7 +1047,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16505, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16505_2] = {
 		.name = "adis16505-2",
@@ -1036,7 +1068,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16505, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16505_3] = {
 		.name = "adis16505-3",
@@ -1055,7 +1089,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16505, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16507_1] = {
 		.name = "adis16507-1",
@@ -1074,7 +1110,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16507, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16507_2] = {
 		.name = "adis16507-2",
@@ -1093,7 +1131,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16507, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16507_3] = {
 		.name = "adis16507-3",
@@ -1112,7 +1152,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16507, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 };
 
-- 
2.34.1


