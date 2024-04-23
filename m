Return-Path: <linux-kernel+bounces-154715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733638AE012
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D431C227CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EFA5FEE4;
	Tue, 23 Apr 2024 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqwXTFIj"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65D58AB9;
	Tue, 23 Apr 2024 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861763; cv=none; b=m7uZjkWXmUfCEY/ca8uM9ManGzOI8DUcoHnVe05N1EcvaMUG99lJb2gTm+QOh9bCG4oZDe3C8TJmmpm43Q+xDamT3nNpowCSxwxufclb80OFlQ1pXaFl1X5JvOGOADNQ4XBilpXrRAvtm4OeH86835wW7sl/7J8wSAVsaT0v2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861763; c=relaxed/simple;
	bh=ZCJiTRsB42adJW1jGpsPbGOs+pdNg3esf+F7zVVDU9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3UGxd3+La+DfSJUgxNMnscUhxMFbGsKXIG9+okRLKF4F5ppHpmOVCiYZNvgHjY9Fzj5taXvguhAIZ1d+CB96RniPTjtKUQDSCikBO30QT6UTU/WcqsA645VDSK/kYzH7Xoz7Fl1YTF8MiRCKIrfs48bHBOZM3jsmYYWh2PrjI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqwXTFIj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-347c197a464so3979039f8f.2;
        Tue, 23 Apr 2024 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713861759; x=1714466559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JJb8CLWZ+zpfclyWYZpViBviTkIv/4bGLE2vrOMCLo=;
        b=dqwXTFIjn4ZjKsyX/iiOCIMcdvAKNjvU+3jyxBieLAO6V2lWehEhrZiT/4ok8lly9/
         xS8b8qyAgzxA0p8isPJgvHZRPMRvksVB8mxfPrEbFHMTQFqhUS6q5S1X2b2YRB9RQjPL
         MivDrcOQ5PPyd/Ans8mp369hT0KnecMKPIrQyBDw+BNRceoTrgpcqh3jc0RjT0kGDOdu
         Sro4L59HCMhvb92ibl7nIpPML+gkfLzvSTMCe+M9sc3lJV5pfwgmceyov79WNPHjorDA
         uRtV1CbRyBvTXZ4WZeL0p7/inbIg9NfXWqEKZscpyzrqfh0Uc4s35nwW/x+HUgLJojO+
         EfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713861759; x=1714466559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JJb8CLWZ+zpfclyWYZpViBviTkIv/4bGLE2vrOMCLo=;
        b=nLiqEXq4iepcoLFo/V294eT7aDVB1zXTQQFGVqgZslixq5LY1gxQWZcRpMi/8DzF/c
         NGA4XLmwHMx9X5JRs/kIk9ZhSbFY/Z14D24KXTn8P8ubgI27L0JnSCLQuDMYJ1/eHz9V
         ST9m3zgZrFaCO2TRhvhJX3LcokHjA6IhzSW1dXNO9HcubL2mnzOmakM2ahWwglYfyt6C
         pzmJD30ohbjuAexhxgJoDyO75xJrq1iGxAcHJRiGRnGO89nuMvtfPu527Lyc/o6eMZNx
         daSv3JsUk14ZncqpMGdtKCgHzBhlGR77FNNccBYe+578nwv+Dqavj9ntApTCI9e90LPf
         x2Og==
X-Forwarded-Encrypted: i=1; AJvYcCVzw5GlutbaZO1n6h20Q5dshb3V/xn3SteRgX8eS0/1Q8pOYi2HNMVXCJwRQ19A1ePDb4EmROBhaq2Y4tB0UMP8uGiQUW7oQ4YAszcDehIDVUpMeTr8osgY/SF7jN1QvSe5krUI6ccIQyUIDVE02nQ5wivsEpwLm8b89IuhLgNgTg==
X-Gm-Message-State: AOJu0Yybqn7c3gKU5xD/uRQbsS7mS1EgL4mdal+vSuhqFerfGkUgFEgJ
	gJqwgxmRnC/PyXtkPpt9419YarUBBijokSz1SrrPF953ppAG0C0UejgaA0dD
X-Google-Smtp-Source: AGHT+IF8jcQSDNPpCg/TPAHgCWqSBkGJdO0aEfxeS/y7ooRXaDk/V7G3SyflRe3iPkFknUqZzkWVjA==
X-Received: by 2002:adf:e30f:0:b0:34a:119b:aadc with SMTP id b15-20020adfe30f000000b0034a119baadcmr7191229wrj.6.1713861759472;
        Tue, 23 Apr 2024 01:42:39 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:320d:e800:cce2:61fe:1efc:ce48])
        by smtp.gmail.com with ESMTPSA id a16-20020adffb90000000b0034af18ef68csm5989939wrr.5.2024.04.23.01.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:42:38 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
X-Google-Original-From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 1/5] iio: adis16480: make the burst_max_speed configurable
Date: Tue, 23 Apr 2024 11:42:06 +0300
Message-Id: <20240423084210.191987-2-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423084210.191987-1-ramona.gradinariu@analog.com>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With this, we can pass the maxixum spi burst speed to the
'ADIS16480_DATA()' macro. This is in preparation to support new devices
that have a different speed than the one used so far.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
 drivers/iio/imu/adis16480.c | 84 +++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index b40a55bba30c..bc6cbd00cd4b 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -107,8 +107,6 @@
 #define ADIS16495_BURST_ID			0xA5A5
 /* total number of segments in burst */
 #define ADIS16495_BURST_MAX_DATA		20
-/* spi max speed in burst mode */
-#define ADIS16495_BURST_MAX_SPEED              6000000
 
 #define ADIS16480_REG_SERIAL_NUM		ADIS16480_REG(0x04, 0x20)
 
@@ -872,33 +870,33 @@ static const char * const adis16480_status_error_msgs[] = {
 
 static int adis16480_enable_irq(struct adis *adis, bool enable);
 
-#define ADIS16480_DATA(_prod_id, _timeouts, _burst_len)			\
-{									\
-	.diag_stat_reg = ADIS16480_REG_DIAG_STS,			\
-	.glob_cmd_reg = ADIS16480_REG_GLOB_CMD,				\
-	.prod_id_reg = ADIS16480_REG_PROD_ID,				\
-	.prod_id = (_prod_id),						\
-	.has_paging = true,						\
-	.read_delay = 5,						\
-	.write_delay = 5,						\
-	.self_test_mask = BIT(1),					\
-	.self_test_reg = ADIS16480_REG_GLOB_CMD,			\
-	.status_error_msgs = adis16480_status_error_msgs,		\
-	.status_error_mask = BIT(ADIS16480_DIAG_STAT_XGYRO_FAIL) |	\
-		BIT(ADIS16480_DIAG_STAT_YGYRO_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_ZGYRO_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_XACCL_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_YACCL_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_ZACCL_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_XMAGN_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_YMAGN_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_ZMAGN_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_BARO_FAIL),			\
-	.enable_irq = adis16480_enable_irq,				\
-	.timeouts = (_timeouts),					\
-	.burst_reg_cmd = ADIS16495_REG_BURST_CMD,			\
-	.burst_len = (_burst_len),					\
-	.burst_max_speed_hz = ADIS16495_BURST_MAX_SPEED			\
+#define ADIS16480_DATA(_prod_id, _timeouts, _burst_len, _burst_max_speed)	\
+{										\
+	.diag_stat_reg = ADIS16480_REG_DIAG_STS,				\
+	.glob_cmd_reg = ADIS16480_REG_GLOB_CMD,					\
+	.prod_id_reg = ADIS16480_REG_PROD_ID,					\
+	.prod_id = (_prod_id),							\
+	.has_paging = true,							\
+	.read_delay = 5,							\
+	.write_delay = 5,							\
+	.self_test_mask = BIT(1),						\
+	.self_test_reg = ADIS16480_REG_GLOB_CMD,				\
+	.status_error_msgs = adis16480_status_error_msgs,			\
+	.status_error_mask = BIT(ADIS16480_DIAG_STAT_XGYRO_FAIL) |		\
+		BIT(ADIS16480_DIAG_STAT_YGYRO_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_ZGYRO_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_XACCL_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_YACCL_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_ZACCL_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_XMAGN_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_YMAGN_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_ZMAGN_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_BARO_FAIL),				\
+	.enable_irq = adis16480_enable_irq,					\
+	.timeouts = (_timeouts),						\
+	.burst_reg_cmd = ADIS16495_REG_BURST_CMD,				\
+	.burst_len = (_burst_len),						\
+	.burst_max_speed_hz = _burst_max_speed					\
 }
 
 static const struct adis_timeout adis16485_timeouts = {
@@ -944,7 +942,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(16375, &adis16485_timeouts, 0),
+		.adis_data = ADIS16480_DATA(16375, &adis16485_timeouts, 0, 0),
 	},
 	[ADIS16480] = {
 		.channels = adis16480_channels,
@@ -958,7 +956,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(16480, &adis16480_timeouts, 0),
+		.adis_data = ADIS16480_DATA(16480, &adis16480_timeouts, 0, 0),
 	},
 	[ADIS16485] = {
 		.channels = adis16485_channels,
@@ -972,7 +970,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(16485, &adis16485_timeouts, 0),
+		.adis_data = ADIS16480_DATA(16485, &adis16485_timeouts, 0, 0),
 	},
 	[ADIS16488] = {
 		.channels = adis16480_channels,
@@ -986,7 +984,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(16488, &adis16485_timeouts, 0),
+		.adis_data = ADIS16480_DATA(16488, &adis16485_timeouts, 0, 0),
 	},
 	[ADIS16490] = {
 		.channels = adis16485_channels,
@@ -1000,7 +998,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(16490, &adis16495_timeouts, 0),
+		.adis_data = ADIS16480_DATA(16490, &adis16495_timeouts, 0, 0),
 	},
 	[ADIS16495_1] = {
 		.channels = adis16485_channels,
@@ -1016,7 +1014,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.has_pps_clk_mode = true,
 		/* 20 elements of 16bits */
 		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts,
-					    ADIS16495_BURST_MAX_DATA * 2),
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6000000),
 	},
 	[ADIS16495_2] = {
 		.channels = adis16485_channels,
@@ -1032,7 +1031,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.has_pps_clk_mode = true,
 		/* 20 elements of 16bits */
 		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts,
-					    ADIS16495_BURST_MAX_DATA * 2),
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6000000),
 	},
 	[ADIS16495_3] = {
 		.channels = adis16485_channels,
@@ -1048,7 +1048,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.has_pps_clk_mode = true,
 		/* 20 elements of 16bits */
 		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts,
-					    ADIS16495_BURST_MAX_DATA * 2),
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6000000),
 	},
 	[ADIS16497_1] = {
 		.channels = adis16485_channels,
@@ -1064,7 +1065,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.has_pps_clk_mode = true,
 		/* 20 elements of 16bits */
 		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts,
-					    ADIS16495_BURST_MAX_DATA * 2),
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6000000),
 	},
 	[ADIS16497_2] = {
 		.channels = adis16485_channels,
@@ -1080,7 +1082,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.has_pps_clk_mode = true,
 		/* 20 elements of 16bits */
 		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts,
-					    ADIS16495_BURST_MAX_DATA * 2),
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6000000),
 	},
 	[ADIS16497_3] = {
 		.channels = adis16485_channels,
@@ -1096,7 +1099,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.has_pps_clk_mode = true,
 		/* 20 elements of 16bits */
 		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts,
-					    ADIS16495_BURST_MAX_DATA * 2),
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6000000),
 	},
 };
 
-- 
2.34.1


