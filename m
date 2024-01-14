Return-Path: <linux-kernel+bounces-25387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD3C82CF68
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 01:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD792830CD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 00:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0F1626;
	Sun, 14 Jan 2024 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uoawl+zg"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A737E;
	Sun, 14 Jan 2024 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cf450eba00so1354326a12.0;
        Sat, 13 Jan 2024 16:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705192075; x=1705796875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=elvLBDbW4dRNs2gzXKMswl8m0M399MzVK+RkZSJ3FIc=;
        b=Uoawl+zgzOjHW9GCjdNSqxgVHPmBrGuH2fjTN4UdHFEvmmD3018+afu35GxFegANEQ
         f6xdlQx5DKCijjdomasi5S630y0wfUpjrPhsdEdMLr1+LX8gCqLyMcWHDK1EIfeKFYdf
         qR4Nyk5VBn/XKNr98re07iNxS1zfPvyhi85guwbnuqKBkIvy7xjNyMvwo95yfaPmRmsD
         xSMrh2hebzOVO5iJQ1dmTKxlSfzvz+6LdUpx+r7+piENQv5ww17bfCO3LajrNEw9lgqi
         xn/bDzrHmQA8QolWqO5b8KpxSqrM68iComrmLG6i0+XB+HsdZZB0lSHf2EhWioIp7zbG
         /gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705192075; x=1705796875;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elvLBDbW4dRNs2gzXKMswl8m0M399MzVK+RkZSJ3FIc=;
        b=RFnBq06EB7BRBxSmMLKNyVl8Ugrcya5HVBEQeqPn9cDXFaABQWoaQlRkhnwILl9JDj
         k1Cmj6v05wA5w38Cf1GFp3YCSWX6oA3TK0mMoejBIj6wFh7DLxyir6UhfsT+bewRK+n7
         jbczzNH0nMyn7f0k+3wJZgPXJUgdcYA2FmPqGDofATl3+GCCt91n6no0icy7ULin9zVe
         /sctzBuUD0qdgw0uQpUoKDu0GcLyDwuRq0nWGfw8ev9RYgLUElBd5eGzI4cuxS2wA9By
         t7gUdM7eA4HQ8NebZFXzG18d9kiQI4TSWIM0DEmrB2cMY1J4RZcZg58Ecjk0Ztp5YKg+
         Tm5w==
X-Gm-Message-State: AOJu0YyB4J1Q6yD0hy/T0VqUTDfV8VDr1EnVmrXRT/oz+RcHjYU2CFEF
	KHpc8eWwcidLxMfMeArCW8uhWtM9G+oClgIs7wWYmDIbjQs=
X-Google-Smtp-Source: AGHT+IFrknLNR/PGRtfX8dprts3GPgWSjO4YvPcTXckJ7hKu3QsOwNoJ3SoAP669fGBQSRPuiVhE41LNGLF0A3hCMgI=
X-Received: by 2002:a05:6a20:2d0c:b0:19a:e211:f873 with SMTP id
 g12-20020a056a202d0c00b0019ae211f873mr32910pzl.90.1705192075632; Sat, 13 Jan
 2024 16:27:55 -0800 (PST)
Received: from 377903785069 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 13 Jan 2024 16:27:55 -0800
From: Forest Crossman <cyrozap@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 13 Jan 2024 16:27:55 -0800
Message-ID: <CAO3ALPwot01+bBisj7Roog7SD9UwV+y4NtiakKrBDE0tPvFhbw@mail.gmail.com>
Subject: [PATCH] hwmon: (nct6683) Add another customer ID for MSI
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Jonathan Corbet <corbet@lwn.net>
Cc: Forest Crossman <cyrozap@gmail.com>, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This value was found on an MSI PRO X670-P WIFI with an NCT6687D chip.

Signed-off-by: Forest Crossman <cyrozap@gmail.com>
---
 Documentation/hwmon/nct6683.rst | 1 +
 drivers/hwmon/nct6683.c         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/hwmon/nct6683.rst b/Documentation/hwmon/nct6683.rst
index 3e7f6ee779c2..2a7a78eb1b46 100644
--- a/Documentation/hwmon/nct6683.rst
+++ b/Documentation/hwmon/nct6683.rst
@@ -64,4 +64,5 @@ Intel DB85FL	NCT6683D EC firmware version 1.0 build 04/03/13
 ASRock X570	NCT6683D EC firmware version 1.0 build 06/28/19
 ASRock X670E	NCT6686D EC firmware version 1.0 build 05/19/22
 MSI B550	NCT6687D EC firmware version 1.0 build 05/07/20
+MSI X670-P	NCT6687D EC firmware version 0.0 build 09/27/22
 =============== ===============================================
diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index 3f3f7a88413e..0d016fedb9c2 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -174,6 +174,7 @@ superio_exit(int ioreg)
 #define NCT6683_CUSTOMER_ID_MITAC	0xa0e
 #define NCT6683_CUSTOMER_ID_MSI		0x201
 #define NCT6683_CUSTOMER_ID_MSI2	0x200
+#define NCT6683_CUSTOMER_ID_MSI3	0x207
 #define NCT6683_CUSTOMER_ID_ASROCK		0xe2c
 #define NCT6683_CUSTOMER_ID_ASROCK2	0xe1b
 #define NCT6683_CUSTOMER_ID_ASROCK3	0x1631
@@ -1224,6 +1225,8 @@ static int nct6683_probe(struct platform_device *pdev)
 		break;
 	case NCT6683_CUSTOMER_ID_MSI2:
 		break;
+	case NCT6683_CUSTOMER_ID_MSI3:
+		break;
 	case NCT6683_CUSTOMER_ID_ASROCK:
 		break;
 	case NCT6683_CUSTOMER_ID_ASROCK2:
-- 
2.39.2

