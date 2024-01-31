Return-Path: <linux-kernel+bounces-46952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738378446CA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31261F254D1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FE3134758;
	Wed, 31 Jan 2024 18:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPpyJxaH"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52B4135A72;
	Wed, 31 Jan 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724558; cv=none; b=QrfTpDWFylxrwrptA/Ep+NK5Kq7iWtkMWn6CUHgvRUr3041Gi2QMwhEsib03tdoid0CYK6Y8ULqSe5iuU28k8qfssCK/gx5kGCKkT7mYHG7sJhWxjlwOHRCucfdINhebwYgU/z7QeYqfz7LgkjZBZQ5qgDfgyNKSkeDEUEZTtcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724558; c=relaxed/simple;
	bh=C36AFajirhLaSdgbvp2Bs+TDEH++3dWxh/wPfmAkr/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TrM88RabfUyx6/Ke8MYCz/bxXaCW6/chhb5/48xZ3ifrXPr3QKcukEWX9G0ydu/h0YhqsKUP2+lQ+aJEOTtQZkzTnB9L6p44z/9gC6y8hTQOyeGHPpby7+99pnkc6eM+i3FU16nSnw7dUbJgxzpbL5nKyNwZAYF2Iy2XyKpUdg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPpyJxaH; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59a58ef4a04so39638eaf.2;
        Wed, 31 Jan 2024 10:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706724556; x=1707329356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pY+pydgBSn0oBuAZ4TIKrdpFZjNR+SPivO3NF2Lnzdw=;
        b=YPpyJxaHyPQBUeHCpTdcBTNEGPRjswKJPvRrPeldQEYtcdPp9VgC2lFhmUXx0ncpS+
         MF+DLXNDJjMNyabSIEWkbRbeYPG+AWmrN8MM4EhuuqAmP6gmkew/3+X/i6j5FsCCRYZI
         Pl+kmlI7FTPDO3ki1yrADYc0R+sEmdt2QzKurOLbAdKiXCoR+ZQGlbR1+q88zCmPYhyr
         mq7rA6oVwl2qcp2HKRv0t/EjUUDOxlD8CeUwdaxeKz5cyaiD+KE2ZuctsBq7l9YqjylS
         H/mWsKb+TBbmt7Q7W9k/vxmYxux33leWjsP9besSXbls8X9hGFAtTAB4nhT+TDwM+ixg
         +vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706724556; x=1707329356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pY+pydgBSn0oBuAZ4TIKrdpFZjNR+SPivO3NF2Lnzdw=;
        b=MLj6d/pQygVgBkyUHX/MGQSKaaPDohJbSQrDn4oTmkFHF+OfbyTfY77bDtZ5g8IttQ
         NQ0QkATVe2DxOuj0iM3rOG8mSDB6WVr05H7a0qSvRxRc3h5b1TL3SK42jd2Z5VIbwqZM
         kwuun4hMS/GlB1C2ULfKfzYZoLfu3HDmppRQovn4iD4ybtCa3i+qvhvFBuEy3rg4/Z6I
         Y4l6bvWowNdQ4cc27/KbaUwA+pSJ0EKadboI/VodxWMVKDULVgmXbu38BQqBxqkzEPoZ
         oYddhUVU008IVsg5i0LpAY7VxeDFe7sxed9E4yGmOxFO0T4E+WrmzaMo/i0TxY8r3KVw
         YYig==
X-Gm-Message-State: AOJu0Yx9ZWNovmlc5KbpirkV/gK53mmVlil3cJ2Cx03VYvPwRfvitPQ3
	SVGA8ogZbzxuE0EFM8IKOeCL6OhlPFgZvbfTewYu0kgXrZApehLt
X-Google-Smtp-Source: AGHT+IH5bjZSEa7Dg9HfWduq+LKNJEE7TQFGoOIhTUjbkXMS5B9oc7oXg4CILaaGXxXsIZvycT1rog==
X-Received: by 2002:a05:6358:70cc:b0:176:a512:e63e with SMTP id h12-20020a05635870cc00b00176a512e63emr1721889rwh.29.1706724555584;
        Wed, 31 Jan 2024 10:09:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVI6Ya/WGaMcV5qkYWuwaWs1qnIoeyHhxlXkdOzPW5D4QLqHuWq1UqGxdntbbYswIj2u4FqNSqluC9NkpnbmaN4tg6R/xNobXhzGlXB56+zYC89Fa5iQ1QHnM1NpdnkLCfwZzsgl2+dkOnmQT9G+A2LXt6yrjbsnqEbziAQLsdNk6W1tykiiWHdmPcaJ9FNWycqgmJdrjxQmN+6Jb+98zhDSeCWdpKnokec9jLOOCeV
Received: from ares2-ThinkPad-L13-Yoga-Gen-2.domain.name ([61.3.130.155])
        by smtp.googlemail.com with ESMTPSA id q16-20020a635050000000b005cfbdf71baasm10734058pgl.47.2024.01.31.10.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 10:09:12 -0800 (PST)
From: Vishnu Sankar <vishnuocv@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vsankar@lenovo.com,
	Vishnu Sankar <vishnuocv@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: [PATCH] Fix to correct wrong temp reporting on some ThinkPads
Date: Thu,  1 Feb 2024 03:07:57 +0900
Message-Id: <20240131180757.35044-1-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added non-standard thermal register support for some ThinkPads.

Some of the Thinkpads use a non-standard ECFW which uses different
thermal register addresses.
This is a Fix to correct the wrong temperature reporting on
those systems.

Tested on Lenovo Thinkpad L13 Yoga Gen2

Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 132 ++++++++++++++++++++-------
 1 file changed, 97 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c4895e9bc714..a4631196513f 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6126,12 +6126,15 @@ enum thermal_access_mode {
 	TPACPI_THERMAL_ACPI_TMP07,	/* Use ACPI TMP0-7 */
 	TPACPI_THERMAL_ACPI_UPDT,	/* Use ACPI TMP0-7 with UPDT */
 	TPACPI_THERMAL_TPEC_8,		/* Use ACPI EC regs, 8 sensors */
+	TPACPI_THERMAL_TPEC_12,		/* Use ACPI EC regs, 12 sensors */
 	TPACPI_THERMAL_TPEC_16,		/* Use ACPI EC regs, 16 sensors */
 };
 
 enum { /* TPACPI_THERMAL_TPEC_* */
 	TP_EC_THERMAL_TMP0 = 0x78,	/* ACPI EC regs TMP 0..7 */
 	TP_EC_THERMAL_TMP8 = 0xC0,	/* ACPI EC regs TMP 8..15 */
+	TP_EC_THERMAL_TMP0_NS = 0xA8,	/* ACPI EC Non-Standard regs TMP 0..7 */
+	TP_EC_THERMAL_TMP8_NS = 0xB8,	/* ACPI EC Non-standard regs TMP 8..11 */
 	TP_EC_FUNCREV      = 0xEF,      /* ACPI EC Functional revision */
 	TP_EC_THERMAL_TMP_NA = -128,	/* ACPI EC sensor not available */
 
@@ -6144,8 +6147,22 @@ struct ibm_thermal_sensors_struct {
 	s32 temp[TPACPI_MAX_THERMAL_SENSORS];
 };
 
+static const struct tpacpi_quirk thermal_quirk_table[] __initconst = {
+	/* Non-standard address for thermal registers on some ThinkPads */
+	TPACPI_Q_LNV3('R', '1', 'F', true),	/* L13 Yoga Gen 2 */
+	TPACPI_Q_LNV3('N', '2', 'U', true),	/* X13 Yoga Gen 2*/
+	TPACPI_Q_LNV3('R', '0', 'R', true),	/* L380 */
+	TPACPI_Q_LNV3('R', '1', '5', true),	/* L13 Yoga Gen 1*/
+	TPACPI_Q_LNV3('R', '1', '0', true),	/* L390 */
+	TPACPI_Q_LNV3('N', '2', 'L', true),	/* X13 Yoga Gen 1*/
+	TPACPI_Q_LNV3('R', '0', 'T', true),	/* 11e Gen5 GL*/
+	TPACPI_Q_LNV3('R', '1', 'D', true),	/* 11e Gen5 GL-R*/
+	TPACPI_Q_LNV3('R', '0', 'V', true),	/* 11e Gen5 KL-Y*/
+};
+
 static enum thermal_access_mode thermal_read_mode;
 static bool thermal_use_labels;
+static bool thermal_with_ns_address;	/*Non-standard thermal reg address*/
 
 /* idx is zero-based */
 static int thermal_get_sensor(int idx, s32 *value)
@@ -6154,7 +6171,7 @@ static int thermal_get_sensor(int idx, s32 *value)
 	s8 tmp;
 	char tmpi[5];
 
-	t = TP_EC_THERMAL_TMP0;
+	t = thermal_with_ns_address ? TP_EC_THERMAL_TMP0_NS : TP_EC_THERMAL_TMP0;
 
 	switch (thermal_read_mode) {
 #if TPACPI_MAX_THERMAL_SENSORS >= 16
@@ -6174,6 +6191,21 @@ static int thermal_get_sensor(int idx, s32 *value)
 		}
 		break;
 
+	/* The Non-standard EC uses 12 Thermal areas */
+	case TPACPI_THERMAL_TPEC_12:
+		if (idx <= 11) {
+			if (idx <= 7) {
+				if (!acpi_ec_read(TP_EC_THERMAL_TMP0_NS + idx, &tmp))
+					return -EIO;
+			} else {
+				if (!acpi_ec_read(TP_EC_THERMAL_TMP8_NS + (idx - 8), &tmp))
+					return -EIO;
+			}
+			*value = tmp * 1000;
+			return 0;
+		}
+		break;
+
 	case TPACPI_THERMAL_ACPI_UPDT:
 		if (idx <= 7) {
 			snprintf(tmpi, sizeof(tmpi), "TMP%c", '0' + idx);
@@ -6219,6 +6251,8 @@ static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
 
 	if (thermal_read_mode == TPACPI_THERMAL_TPEC_16)
 		n = 16;
+	else if (thermal_read_mode == TPACPI_THERMAL_TPEC_12)
+		n = 12;
 
 	for (i = 0 ; i < n; i++) {
 		res = thermal_get_sensor(i, &s->temp[i]);
@@ -6317,18 +6351,36 @@ static struct attribute *thermal_temp_input_attr[] = {
 	NULL
 };
 
+#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
+
 static umode_t thermal_attr_is_visible(struct kobject *kobj,
 				       struct attribute *attr, int n)
 {
-	if (thermal_read_mode == TPACPI_THERMAL_NONE)
+	struct device_attribute *dev_attr = to_dev_attr(attr);
+	struct sensor_device_attribute *sensor_attr =
+					to_sensor_dev_attr(dev_attr);
+
+	int idx = sensor_attr->index;
+
+	switch (thermal_read_mode) {
+	case TPACPI_THERMAL_NONE:
 		return 0;
 
-	if (attr == THERMAL_ATTRS(8) || attr == THERMAL_ATTRS(9) ||
-	    attr == THERMAL_ATTRS(10) || attr == THERMAL_ATTRS(11) ||
-	    attr == THERMAL_ATTRS(12) || attr == THERMAL_ATTRS(13) ||
-	    attr == THERMAL_ATTRS(14) || attr == THERMAL_ATTRS(15)) {
-		if (thermal_read_mode != TPACPI_THERMAL_TPEC_16)
+	case TPACPI_THERMAL_ACPI_TMP07:
+	case TPACPI_THERMAL_ACPI_UPDT:
+	case TPACPI_THERMAL_TPEC_8:
+		if (idx >= 8)
+			return 0;
+		break;
+
+	case TPACPI_THERMAL_TPEC_12:
+		if (idx >= 12)
 			return 0;
+		break;
+
+	default:
+		break;
+
 	}
 
 	return attr->mode;
@@ -6398,40 +6450,50 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
 		if (!acpi_ec_read(TP_EC_FUNCREV, &ver))
 			pr_warn("Thinkpad ACPI EC unable to access EC version\n");
 
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
+		/* Quirks to check non-standard EC */
+		thermal_with_ns_address = tpacpi_check_quirks(thermal_quirk_table,
+							ARRAY_SIZE(thermal_quirk_table));
+
+		/* Support for Thinkpads with non-standard address */
+		if (thermal_with_ns_address) {
+			pr_info("ECFW with non-standard thermal registers found\n");
+			thermal_read_mode = TPACPI_THERMAL_TPEC_12;
+		} else {
+			ta1 = ta2 = 0;
+			for (i = 0; i < 8; i++) {
+				if (acpi_ec_read(TP_EC_THERMAL_TMP0 + i, &t)) {
+					ta1 |= t;
 				} else {
 					ta1 = 0;
 					break;
 				}
+				if (ver < 3) {
+					if (acpi_ec_read(TP_EC_THERMAL_TMP8 + i, &t)) {
+						ta2 |= t;
+					} else {
+						ta1 = 0;
+						break;
+					}
+				}
 			}
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
+			if (ta1 == 0) {
+				/* This is sheer paranoia, but we handle it anyway */
+				if (acpi_tmp7) {
+					pr_err("ThinkPad ACPI EC access misbehaving, falling back to ACPI TMPx access mode\n");
+					thermal_read_mode = TPACPI_THERMAL_ACPI_TMP07;
+				} else {
+					pr_err("ThinkPad ACPI EC access misbehaving, disabling thermal sensors access\n");
+					thermal_read_mode = TPACPI_THERMAL_NONE;
+				}
 			} else {
-				thermal_read_mode =
-					(ta2 != 0) ?
-					TPACPI_THERMAL_TPEC_16 : TPACPI_THERMAL_TPEC_8;
+				if (ver >= 3) {
+					thermal_read_mode = TPACPI_THERMAL_TPEC_8;
+					thermal_use_labels = true;
+				} else {
+					thermal_read_mode =
+						(ta2 != 0) ?
+						TPACPI_THERMAL_TPEC_16 : TPACPI_THERMAL_TPEC_8;
+				}
 			}
 		}
 	} else if (acpi_tmp7) {
-- 
2.34.1


