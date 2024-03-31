Return-Path: <linux-kernel+bounces-125958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1979892EA5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 07:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D681F217ED
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 05:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9126C6FA7;
	Sun, 31 Mar 2024 05:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y38q9kBJ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6612B28FD;
	Sun, 31 Mar 2024 05:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711861893; cv=none; b=PD7BCV77YMnxIEL7ypCl2MnkcgML/6agJcQFT+ate1/sRa4/iX31NOfQ0WRgUJY359WntL/QdmIT212EYI5prOHwo9AzOe1pvyqamn9ciHlMlHoE2KuOBvb43wZEVtAa98w2iw6CF8LZgyXjlmaW4uxhKSqK7NmnpnVU80rl0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711861893; c=relaxed/simple;
	bh=iM4j34xzs4H/C5aI7KW/5nrBVU6wpjnIj2bQR623P+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bj7n2euwqLhuIo93jWpLyAmjgDHBf5Pp4q38isPPVLb4w5S6qitoXfJZE/iyAW3OHCpLoKAIoOkLw/TgA4ZwBjFsl7nvHr4MQowICqbDydbI2JcEu1rhh3oD/LYxJYxd2KINmN+Fp+NhaXc6QrI4vInK6CGZKYY/pcz9g7bRT+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y38q9kBJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e0edd0340fso28583705ad.2;
        Sat, 30 Mar 2024 22:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711861892; x=1712466692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gf3j772g4D5kTGxQjNZomrFFVnZ2TPDJswvLXT8RHmo=;
        b=Y38q9kBJ2WNcYh3iFBWfLbqGz8jfQXgIKPXEhGhudbWYneLPeAhzHBoFwsQuGZYR7K
         HgWf67ajTAqHvqmDFFRmZidA8rHasv1DZXFD6dFLzP284jYTkOtpXb4ZR+8wvAAkJ797
         lpd+9DM+l6bVkSqm91yjhM0Xo9l4+9c/IKrzXYPeU3XfNBtM78V9AUHvdySJao4I+DJw
         n7Yt14gX1RDWA2dem1YfR1klCzaa9Nt3xGhFDiuK0v/e1Pg8eYNO5UHzudboyalagNZN
         by1ZdPFNL+9afUhZEncJOQLnAjvDoX6AzhGI7uDc+tpxwM+YWMnwSaPprDQgDzVo+Bow
         FC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711861892; x=1712466692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gf3j772g4D5kTGxQjNZomrFFVnZ2TPDJswvLXT8RHmo=;
        b=o31onb31AN1DNPEMKOzNJoA5d6Y1E80B7FXdIE/J9pDrFe/7SnCT+s0IL3g8NOfz59
         sGLXc0KjCNSuNM7gh2hTMPwLOATY3j5naQs99L4kANq5XaBIjNIG/wd3a3Uy5OrkHOVu
         aaIiauZote78DcEebCOCmvygH2ssansbttxNjwLcBIKsg9WXx/rZjFaHaSOmZL3IRve3
         ji4ZnfHmW5TbkOUu4wJsMpXV8JdzW/Mmxi8bh4pTug9mHwwNkxGP2celNQbEnK875/55
         IyYMfXYouBONF10mpb6Wv8bSjDJ1TGJdsw+bmd8m8wPE98QUNe46PywUewA4Bbvqoqzq
         NC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCAu5kTfzQvbxJC+0nUC0rfLR/0FMGxIm00VrOVut3HXCAmCdI6JMVcFf4VOckp5WhtLB38K9fipz9DDMZE17LI4QzQP5X66cSxttD
X-Gm-Message-State: AOJu0YzoI1+j3NCGBkb3VzAhvMS5I9sw4O//4gaJsX4HDQ4joL9l6pvm
	xTiSMkpe6UkMGN6wWKMAmUIB5ZfTVAXjNpbfHw3QbSYiGzhaocuA
X-Google-Smtp-Source: AGHT+IEW6mEI2o29MvVNfuTAXnOCmcdkryAvITWJPRNY6G3PO7GIg2OC1xLmDXWGomi4pIpzpxYByQ==
X-Received: by 2002:a17:902:e746:b0:1de:ff81:f650 with SMTP id p6-20020a170902e74600b001deff81f650mr8170911plf.10.1711861891567;
        Sat, 30 Mar 2024 22:11:31 -0700 (PDT)
Received: from arotq-MS-7C96.. ([103.74.140.156])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902cec400b001e0c5be4e2esm6146481plg.48.2024.03.30.22.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 22:11:31 -0700 (PDT)
From: Rithvik Rama <rithvik.rama@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rithvik Rama <rithvik.rama@gmail.com>
Subject: [PATCH] ACPI/ADXL: Added function for ADXL DSM Function 3
Date: Sun, 31 Mar 2024 10:41:26 +0530
Message-Id: <20240331051126.10024-1-rithvik.rama@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current driver supports only Function Index 1 & 2 as mentioned in the
ACPI ADXL DSM Interface. Added a function for ACPI Function Index 3.

Signed-off-by: Rithvik Rama <rithvik.rama@gmail.com>
---
 drivers/acpi/acpi_adxl.c | 54 +++++++++++++++++++++++++++++++++++++++-
 include/linux/adxl.h     |  1 +
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_adxl.c b/drivers/acpi/acpi_adxl.c
index 13c8f7b50c46..5bf53662b737 100644
--- a/drivers/acpi/acpi_adxl.c
+++ b/drivers/acpi/acpi_adxl.c
@@ -14,6 +14,7 @@
 #define ADXL_REVISION			0x1
 #define ADXL_IDX_GET_ADDR_PARAMS	0x1
 #define ADXL_IDX_FORWARD_TRANSLATE	0x2
+#define ADXL_IDX_REVERSE_TRANSLATE	0X3
 #define ACPI_ADXL_PATH			"\\_SB.ADXL"
 
 /*
@@ -135,6 +136,56 @@ int adxl_decode(u64 addr, u64 component_values[])
 }
 EXPORT_SYMBOL_GPL(adxl_decode);
 
+/**
+ * adxl_reverse_decode - Ask BIOS to decode a memory address to system address
+ * @component_values: pointer to array of values for each component
+ * Returns 0 on success, negative error code otherwise
+ *
+ */
+
+int adxl_reverse_decode(u64 component_values[])
+{
+	union acpi_object *argv4, *results, *r;
+	int i, cnt;
+
+	argv4 = kzalloc((adxl_count+1)*sizeof(*argv4), GFP_KERNEL);
+	if (!argv4)
+		return -ENOMEM;
+
+	if (!adxl_component_names)
+		return -EOPNOTSUPP;
+
+	argv4[0].type = ACPI_TYPE_PACKAGE;
+	argv4[0].package.count = adxl_count;
+	argv4[0].package.elements = &argv4[1];
+
+	/*
+	 * Loop through supported memory component values
+	 */
+	for (i = 1; i <= adxl_count; i++) {
+		argv4[i].integer.type = ACPI_TYPE_INTEGER;
+		argv4[i].integer.value = component_values[i-1];
+	}
+
+	results = adxl_dsm(ADXL_IDX_REVERSE_TRANSLATE, argv4);
+	if (!results)
+		return -EINVAL;
+
+	r = results->package.elements + 1;
+	cnt = r->package.count;
+	if (cnt != adxl_count) {
+		ACPI_FREE(results);
+		return -EINVAL;
+	}
+	r = r->package.elements;
+	for (i = 0; i < cnt; i++)
+		component_values[i] = r[i].integer.value;
+
+	ACPI_FREE(results);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(adxl_reverse_decode);
+
 static int __init adxl_init(void)
 {
 	char *path = ACPI_ADXL_PATH;
@@ -155,7 +206,8 @@ static int __init adxl_init(void)
 
 	if (!acpi_check_dsm(handle, &adxl_guid, ADXL_REVISION,
 			    ADXL_IDX_GET_ADDR_PARAMS |
-			    ADXL_IDX_FORWARD_TRANSLATE)) {
+			    ADXL_IDX_FORWARD_TRANSLATE |
+			    ADXL_IDX_REVERSE_TRANSLATE)) {
 		pr_info("DSM method does not support forward translate\n");
 		return -ENODEV;
 	}
diff --git a/include/linux/adxl.h b/include/linux/adxl.h
index 2a629acb4c3f..f3fea64a270c 100644
--- a/include/linux/adxl.h
+++ b/include/linux/adxl.h
@@ -9,5 +9,6 @@
 
 const char * const *adxl_get_component_names(void);
 int adxl_decode(u64 addr, u64 component_values[]);
+int adxl_reverse_decode(u64 component_values[]);
 
 #endif /* _LINUX_ADXL_H */
-- 
2.34.1


