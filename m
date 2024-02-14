Return-Path: <linux-kernel+bounces-64751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 188A9854260
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8448AB27BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EC6D26D;
	Wed, 14 Feb 2024 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH/AQDwg"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3B10A01;
	Wed, 14 Feb 2024 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707888674; cv=none; b=NrwTXvogmcPDtrYpTrlihvikKnT/AZgA9px6NhYJfJRHrteLOQ4oMByH2fhom5ivoSFyc6rkZjusx99Jj/oXptvd1nivdBYVgVun6hZTuFk+7uNZCAFS++tqkn5kgR7nUgs1jKlXApWhw8AZsDXioJ013yfU+OSLG8ZnQT86LRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707888674; c=relaxed/simple;
	bh=B60+RecEuLd6rhxCQ8CG0rd8kX29GYsT4px2gp3B5Fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PPlOS2f9lp5fQ8bP0DAJtnTXTzwHjXy+OouR6sd0wuEEJKBU0v13RHbxTb+gKa0XSBjAoMF9HEAuUAHPPIjstyBuQCZF/ZdV/2TD/ChCEC/d/Tf6CEsXqMl1jgwr5JDf34q8MBeL1CcDrFa9vT1RZr9tPHby++PZdwjNhb7gBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hH/AQDwg; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce2aada130so4345361a12.1;
        Tue, 13 Feb 2024 21:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707888672; x=1708493472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1bhCKGDvBVOs9ngY7YgSkummluoNzAr0v78tY3BsCw=;
        b=hH/AQDwgKkt/pTMNfkHb8iRy84o+KEc9tkX7BP8sWzft9quZY/HZWRbCf7jOoVwNJV
         oQlh9+yBVcjIo97i5M1bTO0QA+A7sLeNe8Cj1gPpUGpGfM/LU9+XEWxsqE9m+MnCr2Au
         d/VAiD10g0zsgdMZ1LN5Avu50KtU3glSSTwm7s/hXvUYrU8LpHoRSTDi56lOypcZSP6F
         KoeGpAPZYe8XstHWxBwg39jABwyw2p08hLQaW/mTHi8fcQ6MbjbEHZ5yTIL141Vb8Li7
         tdQiyw5GUpe+f0bKSGRy76dD26fpNhbfOIbM46KVGrztbsDcNiu728pFuS6oaI/BCfJz
         DNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707888672; x=1708493472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1bhCKGDvBVOs9ngY7YgSkummluoNzAr0v78tY3BsCw=;
        b=YD7ObxjxTg3vdY9pF874PbvQfKlKzn+pu+d/72pn5xEk1j3Xsuh5i4n18RUbaEu96H
         Em/lKVDInDmIElcC7p3PO2geaLZuoy5ATDeh4TAqCoGYPciLyzp+qMOZbgb9mjOkNrXJ
         ol91rdsOTUlBFYfzN8mZyPKvnX5rUmOyvdhowrMczh/QF+9Ffm9oZutzg4JHz94HluBO
         2WOFPiYG6FV4DFLU+03+kNmSv4rIyJjB3K3ou2k8HK8J4zfXiz8G7ELMee71jwPwn7uF
         GVS8mwC4RQ81yU8y4M6J/QlOlfLkUBkMtqs0Nz/x9r75vAjZk/r/JNgrBQnBZomvyvqJ
         Ncbw==
X-Forwarded-Encrypted: i=1; AJvYcCVzruwWW+Y/SAV2d4aZjpo7Tz1AnkkvW/rjJ/AuexRMpN0zSoZth4dKTJQFIz6Aghjac9PrgTg3Ge3ANteJBW1z49YknGl/sWAxuulC
X-Gm-Message-State: AOJu0Yw5L5SOAEf585JxmS5MslSrMK9Z3QtoFSQErPL3a7p3+F9xeOC1
	89KtNvaVsqISaoeJp/3VLpbWJDzmK1jhfRR/iuDfQRFncByRTgxs
X-Google-Smtp-Source: AGHT+IG6Ax5PUpSuixTzpakqKtXTvoLIZnbalklzBvOXb72/Zmq+RRJsUONzQoWNYMglfZkyyiz+gA==
X-Received: by 2002:a17:90a:b311:b0:297:15f7:2ba2 with SMTP id d17-20020a17090ab31100b0029715f72ba2mr1628297pjr.28.1707888672415;
        Tue, 13 Feb 2024 21:31:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVAAX9B9wlxdTwmOImJEajfeNjqI+/pqIlA3edOqtsp6WSNMy0zPPoprUmA2ewVbMiSCGYFSQvGJb76exLR+TFZeOghEKD3bw+ESzJ96pzMDARHbRbjfubo4QuePXkRVO57vwYq/dL9vCjS/DJ3JlaCZ/x14tOK/us1HUcPbY7P3PhQoIh7VjbQG6/ZPZyP8hoDhlVFREDUXRohHfs3gw7AeQqXRdy9nkmXv+uFWfK
Received: from ares2-ThinkPad-L13-Yoga-Gen-2.. ([2400:2410:b9a0:8400:93ae:f463:289c:d6c5])
        by smtp.googlemail.com with ESMTPSA id ll5-20020a170903090500b001da186aa72csm2921904plb.17.2024.02.13.21.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 21:31:12 -0800 (PST)
From: Vishnu Sankar <vishnuocv@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mpearson-lenovo@squebb.ca,
	vsankar@lenovo.com,
	Vishnu Sankar <vishnuocv@gmail.com>
Subject: [PATCH 2/2] platform/x86: thinkpad_acpi: Fix to correct wrong temp reporting on some ThinkPads
Date: Wed, 14 Feb 2024 14:29:59 +0900
Message-Id: <20240214052959.8550-2-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214052959.8550-1-vishnuocv@gmail.com>
References: <20240214052959.8550-1-vishnuocv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added non-standard thermal register support for some ThinkPads.

Some of the Thinkpads use a non-standard ECFW which use different
thermal register addresses.
This is a fix to correct the wrong temperature reporting on
those systems.

Tested on Lenovo ThinkPad L13 Yoga Gen2

Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
-Improvements as requested.
-Improved the readability in case TPACPI_THERMAL_TPEC_12.
-idx < 8 from idx idx <=7 to match idx = 8
-KILO used from linux/units.h instead of 1000.
---
---
 drivers/platform/x86/thinkpad_acpi.c | 74 +++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 2428c8bd0fa2..9be114572f17 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -69,6 +69,7 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/units.h>
 #include <linux/workqueue.h>
 
 #include <acpi/battery.h>
@@ -6126,12 +6127,15 @@ enum thermal_access_mode {
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
 
@@ -6144,8 +6148,22 @@ struct ibm_thermal_sensors_struct {
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
 
 /* Function to check thermal read mode */
 static enum thermal_access_mode thermal_read_mode_check(void)
@@ -6168,6 +6186,16 @@ static enum thermal_access_mode thermal_read_mode_check(void)
 		if (!acpi_ec_read(TP_EC_FUNCREV, &ver))
 			pr_warn("Thinkpad ACPI EC unable to access EC version\n");
 
+		/* Quirks to check non-standard EC */
+		thermal_with_ns_address = tpacpi_check_quirks(thermal_quirk_table,
+							ARRAY_SIZE(thermal_quirk_table));
+
+		/* Support for Thinkpads with non-standard address */
+		if (thermal_with_ns_address) {
+			pr_info("ECFW with non-standard thermal registers found\n");
+			return TPACPI_THERMAL_TPEC_12;
+		}
+
 		ta1 = ta2 = 0;
 		for (i = 0; i < 8; i++) {
 			if (acpi_ec_read(TP_EC_THERMAL_TMP0 + i, &t)) {
@@ -6239,6 +6267,20 @@ static int thermal_get_sensor(int idx, s32 *value)
 		}
 		break;
 
+	/* The Non-standard EC uses 12 Thermal areas */
+	case TPACPI_THERMAL_TPEC_12:
+		if (idx >= 12)
+			return -EINVAL;
+
+		t = idx < 8 ? TP_EC_THERMAL_TMP0_NS + idx :
+				TP_EC_THERMAL_TMP8_NS + (idx - 8);
+
+		if (!acpi_ec_read(t, &tmp))
+			return -EIO;
+
+		*value = tmp * KILO;
+		return 0;
+
 	case TPACPI_THERMAL_ACPI_UPDT:
 		if (idx <= 7) {
 			snprintf(tmpi, sizeof(tmpi), "TMP%c", '0' + idx);
@@ -6284,6 +6326,8 @@ static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
 
 	if (thermal_read_mode == TPACPI_THERMAL_TPEC_16)
 		n = 16;
+	else if (thermal_read_mode == TPACPI_THERMAL_TPEC_12)
+		n = 12;
 
 	for (i = 0 ; i < n; i++) {
 		res = thermal_get_sensor(i, &s->temp[i]);
@@ -6382,18 +6426,36 @@ static struct attribute *thermal_temp_input_attr[] = {
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
 			return 0;
+		break;
+
+	case TPACPI_THERMAL_TPEC_12:
+		if (idx >= 12)
+			return 0;
+		break;
+
+	default:
+		break;
+
 	}
 
 	return attr->mode;
-- 
2.34.1


