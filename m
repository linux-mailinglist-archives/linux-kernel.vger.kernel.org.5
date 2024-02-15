Return-Path: <linux-kernel+bounces-67004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C73E8564AD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5D01F21984
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759AB131737;
	Thu, 15 Feb 2024 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CndQH9xd"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E0D130E5F;
	Thu, 15 Feb 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004561; cv=none; b=cdvCiTFwElJtYc/UpnsdbKEl4100b2IR65tjeYcGxYsAaqFF1kGVBmlrnpEv1TWixn70uB9GoShzZjrrz6qbDUo3tKnKGDTCjt0/UB6gSQ7OZ/ii56GRHjoccPCI6rMQ0GOjzWwVEjL/iuY3YSOb+eYmK4PYJMqocNzGKDNs1eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004561; c=relaxed/simple;
	bh=E8OlhBexmyPJ4iQH4AQ1pm64iW/pOvcs4dk0on3bIvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G1eKn/CPVWXGIx6nKGYUPpIAFLEVuxk95fhOELEVv5fYs4tRlzhpxR+WSE8A8QP3EbqtsJyCjaPyNpxqr1taG6O6J2ntdK1OxrCT0k60D1NodPR1ZgF1/FklLogIn/y4InyuW6EtvWYESCHXQmDFjt4MEeC6Ba8la0CnJN6x1CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CndQH9xd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d8aadc624dso7090295ad.0;
        Thu, 15 Feb 2024 05:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708004559; x=1708609359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjLhIY/3/EVVCHaVWEMNbXR920ZLh6dypPeIlZRhOdw=;
        b=CndQH9xdxH91uNBDqRF37eSyguG2+ePuhVoiINH+c5bLCFbRiBFv8BmQPDRUmPDiz5
         b3bRtCtNfkPmcQ1DPgD+eCZgyqi28U1T68Dz/MokU4TgNglE2SRF8o9lDek2ua4OMDBN
         BB9dIjWOEuBwVXezos9uPbJdseUXZJvYvbWIaVHe0gaTiLluhLEFTOdUSbRdlRY2PZQK
         YhB/DN8B+D5d5L+tfeJ0VwgMcZf8vNfegaWxTNccTGa0ovfbKAsmWf+838KQA3eGBFnf
         XM7ZtxXa4sR+m0KjNlwD3IOs8UVN334rrt8fpNkLJAPXBSor7boOryHrn3CrsZl+qxor
         Cb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708004559; x=1708609359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjLhIY/3/EVVCHaVWEMNbXR920ZLh6dypPeIlZRhOdw=;
        b=LKQUOKpWeNFwzPO3LP82YbkefvofPBLDGH+MfYhoonOs7znbVHgCPiHBnF9fGuC4JI
         2Yb5BZhGu9MkEsO1AI3ahGmgXtDYR9N7i1GjupXVP8GE9Fu48PyQKZJzAV1CEsDJX3+J
         tGC5Ayszog+lawVTLAz1aDol6WR2gAG3NJ2Vn7kN82byfyJYjRDIYVuwg6Asjc8JL1IJ
         7FOFjZPFMiI4vYVuK8QSSDzwhqrpSl7IASA1KjrvbmhF0+DK+n+xNE+ac65dXf5ZiBoT
         ReN1WET6aFgHqAvwkmc2lhbeKpV3rjLMEHM0zUBipxJfnlKzP6PhdO36OEBaA/749hcZ
         GD7g==
X-Forwarded-Encrypted: i=1; AJvYcCXeOipImi7u4VzCSPtTKncUI/zi1d0EIr81YnWTnlm314vSTv0R0+HOhF7tR9yA21r9C+po4Rq0kF1DVQhHpPUUjgyiyPijERXk4Z7r
X-Gm-Message-State: AOJu0Yy99tYrhcfmuYzISOGZhTdKM1cQfZ4iRkpAAyVj/23KL7kC07Fz
	ryW6wrePsSZsmaQMSsYufiNDDguNa6Q46vE/0Zrsrv086bCmES0T
X-Google-Smtp-Source: AGHT+IHUvPh4DP3oO/lFlaFHkiVjxcHXwb3tTZ1lLT0mQIR2iq5ZfMoacXMmyHwyvOmQadaQU6vevA==
X-Received: by 2002:a17:903:987:b0:1d7:35ba:6a39 with SMTP id mb7-20020a170903098700b001d735ba6a39mr2441388plb.69.1708004559225;
        Thu, 15 Feb 2024 05:42:39 -0800 (PST)
Received: from ares2-ThinkPad-L13-Yoga-Gen-2.. ([2400:2410:b9a0:8400:51:a250:48bc:afe2])
        by smtp.googlemail.com with ESMTPSA id mo14-20020a1709030a8e00b001d8e4de7a44sm1262431plb.127.2024.02.15.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:42:38 -0800 (PST)
From: Vishnu Sankar <vishnuocv@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mpearson-lenovo@squebb.ca,
	vsankar@lenovo.com,
	Vishnu Sankar <vishnuocv@gmail.com>
Subject: [PATCH v2 2/2] platform/x86: thinkpad_acpi: Fix to correct wrong temp reporting on some ThinkPads
Date: Thu, 15 Feb 2024 22:41:02 +0900
Message-Id: <20240215134102.25118-2-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215134102.25118-1-vishnuocv@gmail.com>
References: <20240215134102.25118-1-vishnuocv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added non-standard thermal register's support for some ThinkPads.

Some of the Thinkpads use a non-standard ECFW which has different
thermal register addresses. This is a fix to correct the wrong temperature
reporting on those systems.

Tested on Lenovo ThinkPad L13 Yoga Gen2.

Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
-Improvements as requested.
-Improved the readability in case TPACPI_THERMAL_TPEC_12.
-idx < 8 from idx idx <=7 to match idx = 8.
-KILO used from linux/units.h instead of 1000.
Changes in v2
-MILLIDEGREE_PER_DEGREE used from linux/units.h instead of KILO.
-Updated comments for better readability.
---
 drivers/platform/x86/thinkpad_acpi.c | 74 +++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 81df8fe59912..02cd873bd3f6 100644
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
+static bool thermal_with_ns_address;	/* Non-standard thermal reg address */
 
 /* Function to check thermal read mode */
 static enum thermal_access_mode thermal_read_mode_check(void)
@@ -6170,6 +6188,16 @@ static enum thermal_access_mode thermal_read_mode_check(void)
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
@@ -6245,6 +6273,20 @@ static int thermal_get_sensor(int idx, s32 *value)
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
+		*value = tmp * MILLIDEGREE_PER_DEGREE;
+		return 0;
+
 	case TPACPI_THERMAL_ACPI_UPDT:
 		if (idx <= 7) {
 			snprintf(tmpi, sizeof(tmpi), "TMP%c", '0' + idx);
@@ -6290,6 +6332,8 @@ static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
 
 	if (thermal_read_mode == TPACPI_THERMAL_TPEC_16)
 		n = 16;
+	else if (thermal_read_mode == TPACPI_THERMAL_TPEC_12)
+		n = 12;
 
 	for (i = 0 ; i < n; i++) {
 		res = thermal_get_sensor(i, &s->temp[i]);
@@ -6388,18 +6432,36 @@ static struct attribute *thermal_temp_input_attr[] = {
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


