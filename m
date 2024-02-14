Return-Path: <linux-kernel+bounces-64750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4AC85425E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E695CB274F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3C1CA73;
	Wed, 14 Feb 2024 05:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOi8IsD0"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0A811183;
	Wed, 14 Feb 2024 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707888645; cv=none; b=iphRUd73/7m/2wr7m8nlOKu5jo3KjI93JIZ7Y0jpqmrwHx2JUpbFW2WDfesJHhFC8pHyZkOttrIwk0zw9NnYIh83n1spQVJXvAsYJZhr+Dfil7HJsWeJIo5WA5dfG0XLwMSSlSY3DjYvCDbSReHXaMQT0Kx381NzqISGpPqr6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707888645; c=relaxed/simple;
	bh=Dpo6g6sxK3vAauBoF3mHDOYKnH0CVdQFwl2a9oAlRUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RGl+z62INSQ9cnByZEFIu0VlASNcsNXN0Fspd6PRxJtIudBawAYQipqt5A4ARvXS0J091notYr7W8UJjpG62IkXMW+BpvYednyswtbdKO4c0GwUckXsG/KGyKxFYCnfbzoV8EgWoHhhI9bVOP0i0zOz3Glm3rdRKrnXR17fra2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOi8IsD0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d73066880eso46650105ad.3;
        Tue, 13 Feb 2024 21:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707888643; x=1708493443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/sbBk2n6W8ORZ7uhudihLLqVzHuUrsjy8h+SricNyE=;
        b=OOi8IsD0OZuAUn/KY4NoADB25luspoF+oblrtWDyiQ8ew5HEqH6V6k0v3GxTx9zjrr
         YhAn4kyzx9GTzNPV3sWRm4h8FMBfN0ajKCP6p8jaV51jrKq4SZdOrq8J52898xIQiybe
         gIOAUzNLU1iUHTJSLE+RwDvDnZBiuPtV9yVC/H1b3kTVUv/vByp0lMbbWHxT5yCC7UZw
         4bxflHE9XWnBnpJnHc4aLdrsd1AenNtb6yGXFRk/fG/F7Zrz387mBDeYvFLpwB0yx2Q8
         wyOD4HMOx2CsbHOt16MTa7swQEoXmTRJQPM8GKqXhtdaYiscPwYtqk6TBwa9R0i9Ke5i
         tSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707888643; x=1708493443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/sbBk2n6W8ORZ7uhudihLLqVzHuUrsjy8h+SricNyE=;
        b=AMhBnr8ddIvGdzunOKj7osjRKM3x+k/vV1whrSjYhL5HlJLHZXE8AxtFO15WR6h6Ow
         zS3BtcaLeJpzSuE9vUbg7GCyDrHWpPXAeoLg0krR/Ms92VpcjJYNwgoRXgHV1412AdDh
         21Uf1vUglDe+plEdHf2lOdI7q+MdOa+ss73zqD12Oj8UnvZxAWl0zHDHDt10sm+HY57x
         RouKy7WSKoxceLtVEvYqIIJwPx+O08kU4Zfq92Zyh0Vdy2lA9eUROYhvWRp50SnFadQM
         pkKUYhQ3eJWPmCiRvyuihxGT8jX+GP/HobKmSF2TnRES51OINhhJPaP9vgHFyWzC5oZL
         praA==
X-Forwarded-Encrypted: i=1; AJvYcCXQq/owylw5S170OrqKadsOXNPNZQS9fre+Srw6ldavZqAvRKXbPFmpNOmW8LSTf9U8YW95VlMQ+H2WDiRgCm0x0QzhOo96aDFrs4Hv
X-Gm-Message-State: AOJu0YxNvHgeSgt0TPV28eviehedZ8jAAihliHni3s9m47Ud9BqUv0+p
	qOZ38TCdGLtk8oaemPQ+TeVH2P3X5AHxo5JWlaSL9/Iudg+NAkwo
X-Google-Smtp-Source: AGHT+IHSnJIoVPAnEUWf/FE05TMfN7Yvs/5N9ZhglJgInjg61rfGyt9zj8S4UjW5dD5MC4gt0U8tDQ==
X-Received: by 2002:a17:903:183:b0:1d8:ee41:de89 with SMTP id z3-20020a170903018300b001d8ee41de89mr1954970plg.69.1707888642529;
        Tue, 13 Feb 2024 21:30:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVvyB7fcy9Fhfykt0RRukcrKwI7zTE91Tt8Tmoicvt5ndF7ZDWLDNv4seZGzgyPeHrU9RKCaXX6wAgVJ+B6phrDlfhr2HSbvdbYZ0gc3G2B8RiGXFNzn5DDNVG2jlC5Lm4EiKD33Pf8C2+v4S95K8xXFzJTRysLwUKZkSm1GKhs7eP5HZ7NqpCSkGAfzGQgJDdXf7qM4IoTZO7yX1Ck3ToIWbmUxf3TMel4NCrTdM3KsjmnJjilO3ceQFSUpJfkVxGfeXT05CmPQ==
Received: from ares2-ThinkPad-L13-Yoga-Gen-2.. ([2400:2410:b9a0:8400:93ae:f463:289c:d6c5])
        by smtp.googlemail.com with ESMTPSA id ll5-20020a170903090500b001da186aa72csm2921904plb.17.2024.02.13.21.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 21:30:42 -0800 (PST)
From: Vishnu Sankar <vishnuocv@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mpearson-lenovo@squebb.ca,
	vsankar@lenovo.com,
	Vishnu Sankar <vishnuocv@gmail.com>,
	Ilpo Jarvinen <ilpo.jarvinen@intel.com>
Subject: [PATCH 1/2] platform/x86: thinkpad_acpi: Simplify thermal mode checking
Date: Wed, 14 Feb 2024 14:29:58 +0900
Message-Id: <20240214052959.8550-1-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a thermal_read_mode_check helper function to make the code
simpler during init.
This helps particularly when the new TPEC_12 mode is added in
the next patch.

Suggested-by: Ilpo Jarvinen <ilpo.jarvinen@intel.com>
Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 136 +++++++++++++--------------
 1 file changed, 66 insertions(+), 70 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c4895e9bc714..2428c8bd0fa2 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6147,6 +6147,71 @@ struct ibm_thermal_sensors_struct {
 static enum thermal_access_mode thermal_read_mode;
 static bool thermal_use_labels;
 
+/* Function to check thermal read mode */
+static enum thermal_access_mode thermal_read_mode_check(void)
+{
+	u8 t, ta1, ta2, ver = 0;
+	int i;
+
+	if (thinkpad_id.ec_model) {
+		/*
+		 * Direct EC access mode: sensors at registers
+		 * 0x78-0x7F, 0xC0-0xC7.  Registers return 0x00 for
+		 * non-implemented, thermal sensors return 0x80 when
+		 * not available
+		 * The above rule is unfortunately flawed. This has been seen with
+		 * 0xC2 (power supply ID) causing thermal control problems.
+		 * The EC version can be determined by offset 0xEF and at least for
+		 * version 3 the Lenovo firmware team confirmed that registers 0xC0-0xC7
+		 * are not thermal registers.
+		 */
+		if (!acpi_ec_read(TP_EC_FUNCREV, &ver))
+			pr_warn("Thinkpad ACPI EC unable to access EC version\n");
+
+		ta1 = ta2 = 0;
+		for (i = 0; i < 8; i++) {
+			if (acpi_ec_read(TP_EC_THERMAL_TMP0 + i, &t)) {
+				ta1 |= t;
+			} else {
+				ta1 = 0;
+				break;
+			}
+			if (ver < 3) {
+				if (acpi_ec_read(TP_EC_THERMAL_TMP8 + i, &t)) {
+					ta2 |= t;
+				} else {
+					ta1 = 0;
+					break;
+				}
+			}
+		}
+
+		if (ta1 == 0) {
+			pr_err("ThinkPad ACPI EC access misbehaving, disabling thermal sensors access\n");
+			return TPACPI_THERMAL_NONE;
+		}
+
+		if (ver >= 3) {
+			thermal_use_labels = true;
+			return TPACPI_THERMAL_TPEC_8;
+		}
+
+		return (ta2 != 0) ? TPACPI_THERMAL_TPEC_16 : TPACPI_THERMAL_TPEC_8;
+	}
+
+	if (acpi_evalf(ec_handle, NULL, "TMP7", "qv")) {
+		if (tpacpi_is_ibm() &&
+		    acpi_evalf(ec_handle, NULL, "UPDT", "qv"))
+			/* 600e/x, 770e, 770x */
+			return TPACPI_THERMAL_ACPI_UPDT;
+		/* IBM/LENOVO DSDT EC.TMPx access, max 8 sensors */
+		return TPACPI_THERMAL_ACPI_TMP07;
+	}
+
+	/* temperatures not supported on 570, G4x, R30, R31, R32 */
+	return TPACPI_THERMAL_NONE;
+}
+
 /* idx is zero-based */
 static int thermal_get_sensor(int idx, s32 *value)
 {
@@ -6375,78 +6440,9 @@ static const struct attribute_group temp_label_attr_group = {
 
 static int __init thermal_init(struct ibm_init_struct *iibm)
 {
-	u8 t, ta1, ta2, ver = 0;
-	int i;
-	int acpi_tmp7;
-
 	vdbg_printk(TPACPI_DBG_INIT, "initializing thermal subdriver\n");
 
-	acpi_tmp7 = acpi_evalf(ec_handle, NULL, "TMP7", "qv");
-
-	if (thinkpad_id.ec_model) {
-		/*
-		 * Direct EC access mode: sensors at registers
-		 * 0x78-0x7F, 0xC0-0xC7.  Registers return 0x00 for
-		 * non-implemented, thermal sensors return 0x80 when
-		 * not available
-		 * The above rule is unfortunately flawed. This has been seen with
-		 * 0xC2 (power supply ID) causing thermal control problems.
-		 * The EC version can be determined by offset 0xEF and at least for
-		 * version 3 the Lenovo firmware team confirmed that registers 0xC0-0xC7
-		 * are not thermal registers.
-		 */
-		if (!acpi_ec_read(TP_EC_FUNCREV, &ver))
-			pr_warn("Thinkpad ACPI EC unable to access EC version\n");
-
-		ta1 = ta2 = 0;
-		for (i = 0; i < 8; i++) {
-			if (acpi_ec_read(TP_EC_THERMAL_TMP0 + i, &t)) {
-				ta1 |= t;
-			} else {
-				ta1 = 0;
-				break;
-			}
-			if (ver < 3) {
-				if (acpi_ec_read(TP_EC_THERMAL_TMP8 + i, &t)) {
-					ta2 |= t;
-				} else {
-					ta1 = 0;
-					break;
-				}
-			}
-		}
-		if (ta1 == 0) {
-			/* This is sheer paranoia, but we handle it anyway */
-			if (acpi_tmp7) {
-				pr_err("ThinkPad ACPI EC access misbehaving, falling back to ACPI TMPx access mode\n");
-				thermal_read_mode = TPACPI_THERMAL_ACPI_TMP07;
-			} else {
-				pr_err("ThinkPad ACPI EC access misbehaving, disabling thermal sensors access\n");
-				thermal_read_mode = TPACPI_THERMAL_NONE;
-			}
-		} else {
-			if (ver >= 3) {
-				thermal_read_mode = TPACPI_THERMAL_TPEC_8;
-				thermal_use_labels = true;
-			} else {
-				thermal_read_mode =
-					(ta2 != 0) ?
-					TPACPI_THERMAL_TPEC_16 : TPACPI_THERMAL_TPEC_8;
-			}
-		}
-	} else if (acpi_tmp7) {
-		if (tpacpi_is_ibm() &&
-		    acpi_evalf(ec_handle, NULL, "UPDT", "qv")) {
-			/* 600e/x, 770e, 770x */
-			thermal_read_mode = TPACPI_THERMAL_ACPI_UPDT;
-		} else {
-			/* IBM/LENOVO DSDT EC.TMPx access, max 8 sensors */
-			thermal_read_mode = TPACPI_THERMAL_ACPI_TMP07;
-		}
-	} else {
-		/* temperatures not supported on 570, G4x, R30, R31, R32 */
-		thermal_read_mode = TPACPI_THERMAL_NONE;
-	}
+	thermal_read_mode = thermal_read_mode_check();
 
 	vdbg_printk(TPACPI_DBG_INIT, "thermal is %s, mode %d\n",
 		str_supported(thermal_read_mode != TPACPI_THERMAL_NONE),
-- 
2.34.1


