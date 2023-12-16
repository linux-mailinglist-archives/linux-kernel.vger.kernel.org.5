Return-Path: <linux-kernel+bounces-2164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5038158D8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77B62869CA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B0F16416;
	Sat, 16 Dec 2023 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3HQ/g4Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FDE15E98;
	Sat, 16 Dec 2023 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a1ca24776c3so495585266b.0;
        Sat, 16 Dec 2023 03:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702726953; x=1703331753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GHDpuEt9q0JKyakoAuDEQo/Zo4xTgq/4HjXtLbr9CBY=;
        b=m3HQ/g4Y7LoPTlyZw430Pz8Iy3jMguMlfbp6FjTCXdjBeJf2NR6uw9pqnYXyMFaN8o
         OUSrzW5MPRaAoAETgBLVP1MvBlxQY6foi/ZcO7Ef3c399m3w4Y/Gf9RFDG2meDqCrCWu
         V4Cdd+a+2OPcFFJM1AxRlyElaqphFMeu6IBvV1ItJFwumUGmZp1l9CO+Yy9QWMcSWtDk
         r30kVCyZJ76p1652SMRRly/UMymFSF6AdqRJ+ZUKYLCKRTPojVX+6drqXan/V57myEhR
         3STkR6oFROSI2QVwenD0G7lb1JpppCyowQu5iPW5ffeII8Dnh7PehQQZqhaUKxYni/uQ
         yUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702726953; x=1703331753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHDpuEt9q0JKyakoAuDEQo/Zo4xTgq/4HjXtLbr9CBY=;
        b=FGVp7maWES8CjfgEceFwckUtQNLADqLyAlJ6NxTtucyhK/vc92Y+JregtTjjVPbonm
         X2dhXrfkmKZ6TCZyOPf/JLjq1ZNzciFqGALgQ3lwJiUgMd7k/sn+Lml6fhtd37QI4yWm
         vxS3ubbhaeT+cjeSPrfyqZugVZSGV+pMfOih2xkqxeUKbg739hzzY+g8MkoWfIIqNf43
         btFDO75soGK4aFGo+iEM8ZnQE0QkT3Hq/lBm4j2v5wP2NUDTC5I3jfolL1I7/oJ9YySX
         Dh3FpGTmRhVcnEjmEai97WKWXyuy6U7WQlyRdxj2sRRHRJ/4AVpUCcEPtpPTZDT7VeQ6
         BAGg==
X-Gm-Message-State: AOJu0Yw1DmEezq0D+Bh5iKq0PW/WolI6DuyXaFf1u/a5ovDUlktnl4XQ
	7tFTCAVxc9fO0wGSZyofV32HCr6RApM=
X-Google-Smtp-Source: AGHT+IGyQTmHdPV8b9Di6TzWTs/z1hah/H2JgVrfUPeyiUt0LT2qhLqLgNf1ltg7ml9ASlf5p73oDA==
X-Received: by 2002:a17:906:241:b0:a1e:842d:ccd5 with SMTP id 1-20020a170906024100b00a1e842dccd5mr11943184ejl.48.1702726953154;
        Sat, 16 Dec 2023 03:42:33 -0800 (PST)
Received: from localhost.localdomain ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id ss22-20020a170907c01600b00a1d781068e8sm11756719ejc.8.2023.12.16.03.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 03:42:32 -0800 (PST)
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH] iio: hid-sensor-als: Don't stop probing at non-supported attribute
Date: Sat, 16 Dec 2023 13:42:29 +0200
Message-ID: <20231216114229.652020-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some ambient light sensors don't support color temperature and
chromaticity attributes. The driver stops probing if it finds this.

To support sensors without of color temperature and chromaticity
attributes, just skip them at probing if they weren't found.

Tested at Lenovo Yogabook YB1-X91L tablet.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/iio/light/hid-sensor-als.c | 39 ++++++++++++++++++------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index f17304b54468..b711bac3bb2b 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -314,8 +314,11 @@ static int als_parse_report(struct platform_device *pdev,
 						usage_id,
 						HID_USAGE_SENSOR_LIGHT_ILLUM,
 						&st->als[i]);
-		if (ret < 0)
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"Failed to setup Illuminance attribute\n");
 			return ret;
+		}
 		als_adjust_channel_bit_mask(channels, i, st->als[i].size);
 
 		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
@@ -326,14 +329,16 @@ static int als_parse_report(struct platform_device *pdev,
 				usage_id,
 				HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
 				&st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP]);
-	if (ret < 0)
-		return ret;
-	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_COLOR_TEMP,
-				st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
+	if (!ret) {
+		dev_info(&pdev->dev, "Color temperature is supported\n");
+		als_adjust_channel_bit_mask(channels,
+			CHANNEL_SCAN_INDEX_COLOR_TEMP,
+			st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
 
-	dev_dbg(&pdev->dev, "als %x:%x\n",
-		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
-		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
+		dev_dbg(&pdev->dev, "als %x:%x\n",
+			st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
+			st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
+	}
 
 	for (i = 0; i < 2; i++) {
 		int next_scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_X + i;
@@ -342,23 +347,25 @@ static int als_parse_report(struct platform_device *pdev,
 				HID_INPUT_REPORT, usage_id,
 				HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X + i,
 				&st->als[next_scan_index]);
-		if (ret < 0)
-			return ret;
-
-		als_adjust_channel_bit_mask(channels,
+		if (!ret) {
+			dev_info(&pdev->dev,
+				 "Light chromaticity %c is supported\n",
+				 i ? 'Y' : 'X');
+			als_adjust_channel_bit_mask(channels,
 					CHANNEL_SCAN_INDEX_CHROMATICITY_X + i,
 					st->als[next_scan_index].size);
 
-		dev_dbg(&pdev->dev, "als %x:%x\n",
-			st->als[next_scan_index].index,
-			st->als[next_scan_index].report_id);
+			dev_dbg(&pdev->dev, "als %x:%x\n",
+				st->als[next_scan_index].index,
+				st->als[next_scan_index].report_id);
+		}
 	}
 
 	st->scale_precision = hid_sensor_format_scale(usage_id,
 				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
 				&st->scale_pre_decml, &st->scale_post_decml);
 
-	return ret;
+	return 0;
 }
 
 /* Function to initialize the processing for usage id */
-- 
2.43.0


