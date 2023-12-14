Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A23D813212
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573113AbjLNNsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjLNNsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:48:16 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA38E;
        Thu, 14 Dec 2023 05:48:22 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cedc988cf6so3680150b3a.3;
        Thu, 14 Dec 2023 05:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702561702; x=1703166502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yajGESInsEM3+Dq8wk7XIP+ZhNgF7pNHgffdPQVgjQQ=;
        b=VQp6lvllB4MW/m3ySEmjgUK2sASrOgG/ivITYq489MYZbwwMLLDmIAfE/4J/2drSR3
         D5JYCC8Rpa3WO7CARHjRuFK7o9biKe7h86oyKppaEGnuLx+YKSjB/0r1KzcmGk35hvUf
         uGohm/qOcmjRWHlZTOruGZiIEl7iQp28DcGittJztJljy5w0nY19nKKfll4fchRKMyJD
         A55w97khrEPO17t+6T/j7763F+O1HkPDmNuWY/bE1m2RiJvaYK6ICeSMgG+g3Xb0hqEO
         o0CYO9ZlzAWjv7PFo/RZBRbRikSxr8bsrQsfzcKGKafAYvdXdM3jJANIa8bnrQc16rRE
         lY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561702; x=1703166502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yajGESInsEM3+Dq8wk7XIP+ZhNgF7pNHgffdPQVgjQQ=;
        b=BjJ+w5xYWwxfRegg6Izfn3zGQ/U/fsJ/b7HajNX2vGZk3ZFiKVSh8N71T/468/CIOl
         V7l+rgEQPzdWBOc7bT7DyK09Ton2RQqaWkfxJKi4DVN63HQwwHB/v3u3XJQBcgI+eoJv
         FsLld8ZUH3NQr1Q0e6H+mhCZunMNYyuKDt3fSrfrNfYqlcKFdTBdumacasMYCO+CMG7X
         uzb9kQJNIl7F9GuhVNqFIba8NqNO3aYTEW6UO1mpvwnmTxX6ukkUzKWuP7RjxxAdCIrk
         hM3T5jPj52rB4rOTuGlqz30eM2tmJr/nI12rBv1dic/JASpwNjwgiF9v83lLuwfd1Ng5
         9LUw==
X-Gm-Message-State: AOJu0YxeQ5QWwO3upDc04+baq5sexvmjjVjFfTyKhJVVkTIxF9/QQNYD
        5mEGsaH1VFuIapfOUyjmJdiEpmLg9yTrCQ==
X-Google-Smtp-Source: AGHT+IED/Olcvocj4zKEWubc+evyQuOXJojRxv5U7lFKAD6bPilhpPAtwNdE9QByedo0wk5Cb8ALNA==
X-Received: by 2002:a05:6a00:4655:b0:6ce:6cf3:38b4 with SMTP id kp21-20020a056a00465500b006ce6cf338b4mr5309174pfb.1.1702561701382;
        Thu, 14 Dec 2023 05:48:21 -0800 (PST)
Received: from ares2-ThinkPad-L13-Yoga-Gen-2.. ([2400:2410:b9a0:8400:66d2:122:6512:e458])
        by smtp.googlemail.com with ESMTPSA id p1-20020a056a000a0100b006c06779e593sm12245165pfh.16.2023.12.14.05.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:48:20 -0800 (PST)
From:   Vishnu Sankar <vishnuocv@gmail.com>
To:     hdegoede@redhat.com
Cc:     mpearson-lenovo@squebb.ca, ilpo.jarvinen@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        markgross@kernel.org, vsankar@lenovo.com,
        Vishnu Sankar <vishnuocv@gmail.com>
Subject: [PATCH v2] platform/x86: thinkpad_acpi: fix for incorrect fan reporting on some ThinkPad systems
Date:   Thu, 14 Dec 2023 22:47:02 +0900
Message-Id: <20231214134702.166464-1-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ThinkPad systems ECFW use non-standard addresses for fan control
and reporting. This patch adds support for such ECFW so that it can report
the correct fan values.
Tested on Thinkpads L13 Yoga Gen 2 and X13 Yoga Gen 2.

Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
-Improvements to comments as requested.
-Removed the usage of unlikely/likely while reading fan speed.
-Improved and clearer print statements to match the current style.
-Changed seq_puts to seq_printf of an unrelated section of the patch.
-Improved the readability of the code.
-Added more clearer comments.
---
 drivers/platform/x86/thinkpad_acpi.c | 98 ++++++++++++++++++++++++----
 1 file changed, 85 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d0b5fd4137bc..dcada766c169 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -7948,8 +7948,19 @@ static struct ibm_struct volume_driver_data = {
  * 	TPACPI_FAN_WR_TPEC is also available and should be used to
  * 	command the fan.  The X31/X40/X41 seems to have 8 fan levels,
  * 	but the ACPI tables just mention level 7.
+ *
+ * TPACPI_FAN_RD_TPEC_NS:
+ *	This mode is used for a few ThinkPads (L13 Yoga Gen2, X13 Yoga Gen2 etc.)
+ *	that are using non-standard EC locations for reporting fan speeds.
+ *	Currently these platforms only provide fan rpm reporting.
+ *
  */
 
+#define FAN_RPM_CAL_CONST 491520	/* FAN RPM calculation offset for some non-standard ECFW */
+
+#define FAN_NS_CTRL_STATUS	BIT(2)		/* Bit which determines control is enabled or not */
+#define FAN_NS_CTRL		BIT(4)		/* Bit which determines control is by host or EC */
+
 enum {					/* Fan control constants */
 	fan_status_offset = 0x2f,	/* EC register 0x2f */
 	fan_rpm_offset = 0x84,		/* EC register 0x84: LSB, 0x85 MSB (RPM)
@@ -7957,6 +7968,11 @@ enum {					/* Fan control constants */
 	fan_select_offset = 0x31,	/* EC register 0x31 (Firmware 7M)
 					   bit 0 selects which fan is active */
 
+	fan_status_offset_ns = 0x93,	/* Special status/control offset for non-standard EC Fan1 */
+	fan2_status_offset_ns = 0x96,	/* Special status/control offset for non-standard EC Fan2 */
+	fan_rpm_status_ns = 0x95,	/* Special offset for Fan1 RPM status for non-standard EC */
+	fan2_rpm_status_ns = 0x98,	/* Special offset for Fan2 RPM status for non-standard EC */
+
 	TP_EC_FAN_FULLSPEED = 0x40,	/* EC fan mode: full speed */
 	TP_EC_FAN_AUTO	    = 0x80,	/* EC fan mode: auto fan control */
 
@@ -7967,6 +7983,7 @@ enum fan_status_access_mode {
 	TPACPI_FAN_NONE = 0,		/* No fan status or control */
 	TPACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
 	TPACPI_FAN_RD_TPEC,		/* Use ACPI EC regs 0x2f, 0x84-0x85 */
+	TPACPI_FAN_RD_TPEC_NS,		/* Use non-standard ACPI EC regs (eg: L13 Yoga gen2 etc.) */
 };
 
 enum fan_control_access_mode {
@@ -7994,6 +8011,8 @@ static u8 fan_control_desired_level;
 static u8 fan_control_resume_level;
 static int fan_watchdog_maxinterval;
 
+static bool fan_with_ns_addr;
+
 static struct mutex fan_mutex;
 
 static void fan_watchdog_fire(struct work_struct *ignored);
@@ -8123,6 +8142,15 @@ static int fan_get_status(u8 *status)
 		}
 
 		break;
+	case TPACPI_FAN_RD_TPEC_NS:
+		/* Default mode is AUTO which means controlled by EC */
+		if (!acpi_ec_read(fan_status_offset_ns, &s))
+			return -EIO;
+
+		if (status)
+			*status = s;
+
+		break;
 
 	default:
 		return -ENXIO;
@@ -8139,7 +8167,8 @@ static int fan_get_status_safe(u8 *status)
 	if (mutex_lock_killable(&fan_mutex))
 		return -ERESTARTSYS;
 	rc = fan_get_status(&s);
-	if (!rc)
+	/* NS EC doesn't have register with level settings */
+	if (!rc && !fan_with_ns_addr)
 		fan_update_desired_level(s);
 	mutex_unlock(&fan_mutex);
 
@@ -8166,7 +8195,13 @@ static int fan_get_speed(unsigned int *speed)
 
 		if (likely(speed))
 			*speed = (hi << 8) | lo;
+		break;
+	case TPACPI_FAN_RD_TPEC_NS:
+		if (!acpi_ec_read(fan_rpm_status_ns, &lo))
+			return -EIO;
 
+		if (speed)
+			*speed = lo ? FAN_RPM_CAL_CONST / lo : 0;
 		break;
 
 	default:
@@ -8178,7 +8213,7 @@ static int fan_get_speed(unsigned int *speed)
 
 static int fan2_get_speed(unsigned int *speed)
 {
-	u8 hi, lo;
+	u8 hi, lo, status;
 	bool rc;
 
 	switch (fan_status_access_mode) {
@@ -8194,7 +8229,21 @@ static int fan2_get_speed(unsigned int *speed)
 
 		if (likely(speed))
 			*speed = (hi << 8) | lo;
+		break;
 
+	case TPACPI_FAN_RD_TPEC_NS:
+		rc = !acpi_ec_read(fan2_status_offset_ns, &status);
+		if (rc)
+			return -EIO;
+		if (!(status & FAN_NS_CTRL_STATUS)) {
+			pr_info("secondary fan control not supported\n");
+			return -EIO;
+		}
+		rc = !acpi_ec_read(fan2_rpm_status_ns, &lo);
+		if (rc)
+			return -EIO;
+		if (speed)
+			*speed = lo ? FAN_RPM_CAL_CONST / lo : 0;
 		break;
 
 	default:
@@ -8697,6 +8746,7 @@ static const struct attribute_group fan_driver_attr_group = {
 #define TPACPI_FAN_2FAN		0x0002		/* EC 0x31 bit 0 selects fan2 */
 #define TPACPI_FAN_2CTL		0x0004		/* selects fan2 control */
 #define TPACPI_FAN_NOFAN	0x0008		/* no fan available */
+#define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
 
 static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
@@ -8715,6 +8765,8 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('N', '2', 'O', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (2nd gen) */
 	TPACPI_Q_LNV3('N', '3', '0', TPACPI_FAN_2CTL),	/* P15 (1st gen) / P15v (1st gen) */
 	TPACPI_Q_LNV3('N', '3', '7', TPACPI_FAN_2CTL),  /* T15g (2nd gen) */
+	TPACPI_Q_LNV3('R', '1', 'F', TPACPI_FAN_NS),	/* L13 Yoga Gen 2 */
+	TPACPI_Q_LNV3('N', '2', 'U', TPACPI_FAN_NS),	/* X13 Yoga Gen 2*/
 	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
 };
 
@@ -8749,18 +8801,27 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		return -ENODEV;
 	}
 
+	if (quirks & TPACPI_FAN_NS) {
+		pr_info("ECFW with non-standard fan reg control found\n");
+		fan_with_ns_addr = 1;
+		/* Fan ctrl support from host is undefined for now */
+		tp_features.fan_ctrl_status_undef = 1;
+	}
+
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
 		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
 	} else {
 		/* all other ThinkPads: note that even old-style
 		 * ThinkPad ECs supports the fan control register */
-		if (likely(acpi_ec_read(fan_status_offset,
-					&fan_control_initial_status))) {
+		if (fan_with_ns_addr ||
+		    likely(acpi_ec_read(fan_status_offset, &fan_control_initial_status))) {
 			int res;
 			unsigned int speed;
 
-			fan_status_access_mode = TPACPI_FAN_RD_TPEC;
+			fan_status_access_mode = fan_with_ns_addr ?
+				TPACPI_FAN_RD_TPEC_NS : TPACPI_FAN_RD_TPEC;
+
 			if (quirks & TPACPI_FAN_Q1)
 				fan_quirk1_setup();
 			/* Try and probe the 2nd fan */
@@ -8769,7 +8830,8 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 			if (res >= 0 && speed != FAN_NOT_PRESENT) {
 				/* It responded - so let's assume it's there */
 				tp_features.second_fan = 1;
-				tp_features.second_fan_ctl = 1;
+				/* fan control not currently available for ns ECFW */
+				tp_features.second_fan_ctl = !fan_with_ns_addr;
 				pr_info("secondary fan control detected & enabled\n");
 			} else {
 				/* Fan not auto-detected */
@@ -8944,6 +9006,7 @@ static int fan_read(struct seq_file *m)
 			       str_enabled_disabled(status), status);
 		break;
 
+	case TPACPI_FAN_RD_TPEC_NS:
 	case TPACPI_FAN_RD_TPEC:
 		/* all except 570, 600e/x, 770e, 770x */
 		rc = fan_get_status_safe(&status);
@@ -8958,13 +9021,22 @@ static int fan_read(struct seq_file *m)
 
 		seq_printf(m, "speed:\t\t%d\n", speed);
 
-		if (status & TP_EC_FAN_FULLSPEED)
-			/* Disengaged mode takes precedence */
-			seq_printf(m, "level:\t\tdisengaged\n");
-		else if (status & TP_EC_FAN_AUTO)
-			seq_printf(m, "level:\t\tauto\n");
-		else
-			seq_printf(m, "level:\t\t%d\n", status);
+		if (fan_status_access_mode == TPACPI_FAN_RD_TPEC_NS) {
+			/*
+			 * No full speed bit in NS EC
+			 * EC Auto mode is set by default.
+			 * No other levels settings available
+			 */
+			seq_printf(m, "level:\t\t%s\n", status & FAN_NS_CTRL ? "unknown" : "auto");
+		} else {
+			if (status & TP_EC_FAN_FULLSPEED)
+				/* Disengaged mode takes precedence */
+				seq_printf(m, "level:\t\tdisengaged\n");
+			else if (status & TP_EC_FAN_AUTO)
+				seq_printf(m, "level:\t\tauto\n");
+			else
+				seq_printf(m, "level:\t\t%d\n", status);
+		}
 		break;
 
 	case TPACPI_FAN_NONE:
-- 
2.34.1

