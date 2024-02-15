Return-Path: <linux-kernel+bounces-67003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C548564AA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271032858EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE7F131738;
	Thu, 15 Feb 2024 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k//CdRIs"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C413172A;
	Thu, 15 Feb 2024 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004534; cv=none; b=tzx8WfOyq7KLdJ+JhJmPaRKRMHVsgqr+JRGYFmWv2Yks1/zDSI+NGJtIxks6jGnotj/vg7y7u8XO7AAWXkEUT1mfQQWuCneAfMDjAIYGUjeAkCfsH1yruSpcOdKLY3MHUV79NA2eLAmqsBuXkPNRGBMTF2h/lszaIV+RfTmSVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004534; c=relaxed/simple;
	bh=hWV55ZH4W/J6GJkYQhXDaaTALc/56jpVBm8No26BoZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Bqt1cHtoH16+ia/UF/m6QXgkc8z5czH5oHvaMvx1c4G0mxmL3y+cCGVkVC6f87DOcBDGZPXQiB7mEadBm5LQI8AxQQi3RaPppK44CmYkPJnt5KH737cqZ6aMEvqOsa6bRYY1Ha7nBRjMb1zDQv/P4monEsYquHwMjP9uxo04huk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k//CdRIs; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71cb97937so8377675ad.3;
        Thu, 15 Feb 2024 05:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708004532; x=1708609332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4hAKjndwXLxW4jKVPNgTLfXjmqIDdZxiWWGo39+hpM=;
        b=k//CdRIsKSA7bsnN/a7G+mbpEj3WaSB2k1X3/+nDj6ifTpRYFiBlRyLcYF1iYkQMY6
         H9+XtA5whPeFZhhAV1z0zImfZqRKcLQLayROjTWeR6qCWe7kv9g1Dg0IFrgGvdkmc7A0
         nB7L9zbVbQy47p0S4rpf/lIfQI+a3gTlqS0joRceA6yyRi8HoKb81odJdtHF/daane+M
         r6SdhHpifGJ/PZsz6G1TNWy+kXFPAL/srz7IrJtfMlNC1trF3a1n+SpmjE4Ub0KbeGJG
         gwrF1ZVr4ShNA2/0GEs94QEqyMtXpybUo5Z4jcZvbzAoUQP1l568jjX4UFLk6FnU2Ipx
         m/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708004532; x=1708609332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4hAKjndwXLxW4jKVPNgTLfXjmqIDdZxiWWGo39+hpM=;
        b=bZl0FKJZQ7VqyODSsONuWMse3IkReYYjfbOat7CQ4vqRXTGQJ5MXbK9XnAee4/c4kS
         9D7kO8KmO5YdiIATHjrzsqfI+T7gTedy3PzkrP/jiCoaGgzbR+tp1UwFiNEPfI8stHG+
         5UyEEILcpY7EBW2SELB0S3J2Vge8JwPfmIoOxmI3S5bc5OUOD1ZzF3q9YlIs4z0dtSHi
         3cShOTcIACXbEvdkgiNuUeKMOa+44M75CYZza+M3l54v4UMxLq/IVMyOyZtUKMwVngdo
         IZAVy/zih7W5DQrlRRfbhMlAZNmKLiV6x5D5RD3x7jO3v+Ig27KXtkC/yWs5d/6dIJf9
         vc2w==
X-Forwarded-Encrypted: i=1; AJvYcCXSY6+e5hyMbhJWMzO4lVCRblvah7l4atjOVeuOjG/4pTrF1O1U1GknAdZQZYDcL1oLagbf2RtPqD5Doyw0X/khRE7jdZvFgulo/l+3
X-Gm-Message-State: AOJu0Ywe0KgOxmZuQk585Kib7IGb2AhbCxYD1UjtUmEE5vLkFbaYKyhY
	kzZGJtHQlqfEgBATloj5Sl83eBAatm31462wvLv4e8yXklcMc08/
X-Google-Smtp-Source: AGHT+IGo3YPqke8xOsRj5JKCANniBbJqs6VpWhT6ERpmDwBA3jCz8HdH/3Hm+UY+GToPUlxYWgfUqw==
X-Received: by 2002:a17:902:db09:b0:1da:1b60:2209 with SMTP id m9-20020a170902db0900b001da1b602209mr2047641plx.44.1708004531986;
        Thu, 15 Feb 2024 05:42:11 -0800 (PST)
Received: from ares2-ThinkPad-L13-Yoga-Gen-2.. ([2400:2410:b9a0:8400:51:a250:48bc:afe2])
        by smtp.googlemail.com with ESMTPSA id mo14-20020a1709030a8e00b001d8e4de7a44sm1262431plb.127.2024.02.15.05.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:42:11 -0800 (PST)
From: Vishnu Sankar <vishnuocv@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mpearson-lenovo@squebb.ca,
	vsankar@lenovo.com,
	Vishnu Sankar <vishnuocv@gmail.com>
Subject: [PATCH v2 1/2] platform/x86: thinkpad_acpi: Simplify thermal mode checking
Date: Thu, 15 Feb 2024 22:41:01 +0900
Message-Id: <20240215134102.25118-1-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a thermal_read_mode_check helper to make the code
simpler during init. This helps particularly when the new
TPACPI_THERMAL_TPEC_12 mode is added in the next patch.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
Changes in v2
-Minor code cleanup/reformat as recommended.
-Added in missing check for Misbehaving EC.
---
 drivers/platform/x86/thinkpad_acpi.c | 142 ++++++++++++++-------------
 1 file changed, 72 insertions(+), 70 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c4895e9bc714..81df8fe59912 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6147,6 +6147,77 @@ struct ibm_thermal_sensors_struct {
 static enum thermal_access_mode thermal_read_mode;
 static bool thermal_use_labels;
 
+/* Function to check thermal read mode */
+static enum thermal_access_mode thermal_read_mode_check(void)
+{
+	u8 t, ta1, ta2, ver = 0;
+	int i;
+	int acpi_tmp7;
+
+	acpi_tmp7 = acpi_evalf(ec_handle, NULL, "TMP7", "qv");
+
+	if (thinkpad_id.ec_model) {
+		/*
+		 * Direct EC access mode: sensors at registers
+		 * 0x78-0x7F, 0xC0-0xC7. Registers return 0x00 for
+		 * non-implemented, thermal sensors return 0x80 when
+		 * not available.
+		 *
+		 * In some special cases (when Power Supply ID is 0xC2) above rule
+		 * cause thermal control issues. Offset 0xEF determines EC version.
+		 * 0xC0-0xC7 is not thermal registers in Ver 3.
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
+			/* This is sheer paranoia, but we handle it anyway */
+			if (acpi_tmp7) {
+				pr_err("ThinkPad ACPI EC access misbehaving, falling back to ACPI TMPx access mode\n");
+				return TPACPI_THERMAL_ACPI_TMP07;
+			}
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
+	if (acpi_tmp7) {
+		if (tpacpi_is_ibm() && acpi_evalf(ec_handle, NULL, "UPDT", "qv"))
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
@@ -6375,78 +6446,9 @@ static const struct attribute_group temp_label_attr_group = {
 
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


