Return-Path: <linux-kernel+bounces-41254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A5E83EE0F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B631C2123F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F7128E2E;
	Sat, 27 Jan 2024 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCdvLyog"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101264A;
	Sat, 27 Jan 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706370496; cv=none; b=mJhqCIgbjctkpu2WP9Njlw8vUbAzhkuiuz6U5/K8m9dRNNE2egCZqra/mLCyZ6Zgp7impcHuRdplFCz8Nu6y0a3Wcma4M5gLf10GTJAREzonjvPtzgizSOjtJEuNnd1t2FudaLUHH9soCRUl8f+062Ud5s/voWJUl85kQVy6tQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706370496; c=relaxed/simple;
	bh=2vOKiEHboJdiAxvu00DPS8yzQByWuSQy2Jtnc2WdpCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ErT1cXALlemktE6h9ZAhIrTZlTuQsRJrPTSdjf4JmW4HFwWyg8n7u4KHVUwr+4aCz/chJ3nqPT6H+qh/IQhuTPmejQqq5FcebjBclu9fzzMOa/faqUV2dlC7lBsDOKz+ZP3efNRRsPIPmQDiMhReVjofiXWNxxBoorFxeea+kR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCdvLyog; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8bc1caf00so299755a12.1;
        Sat, 27 Jan 2024 07:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706370493; x=1706975293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6zG5dUyRrzoqOGz0xh5LGbnthlDBJBO90unNewlCsms=;
        b=RCdvLyogbnJKQzbhXqfeKAEkGPst/sQLkArMlZY7b+V3lstkmAubTlsFM7f2n7rqAs
         //j9WDHrLDT9eUxOKxaYfyviluUqiHarBFlSlq6Y6B4zA4DmmfyloXL8gucZULaA6CY8
         SiCxQk0BZqq2Igk1g23L0jPbjktFj7ywGjoVFkji7x3DQU3jcyjcitvZkI46+6JbS8IQ
         WfaYlADXGrhZe0tpwA/PPlE9HGQaMCipBOtBb1k/TJtZxIuRm8/2pJSoh47ODtt+T58k
         sm4H7QwK/6nEKjJBWCEoFvIQ3f8D/zd1qj+6XsQaSlk4ad6sPXb/caEpXGr2vr4PnHhl
         RSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706370493; x=1706975293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zG5dUyRrzoqOGz0xh5LGbnthlDBJBO90unNewlCsms=;
        b=hC239wQlEeu4jqLN1Ybj5gOoY69H/TqzOiG4upOhzWFs4GvRqGlRNss/H3BWZjv8YN
         3n0fPMq3C3Wzcjfbyejgt0f45zH9YFWVwridgD35/3Wzym84nl8BXyS3lsGl40UeEh39
         RDJllRhaobX4ufS4FP+0ZBIhSeBTxHvdN4R9O/2oDIpHT/R2r/MRxwvw5N4XXQL+ZtxJ
         aaACO5mvuaDQsHehXyu9SL7uoXHgfdoP37e2lN96dsgIVqcergi/Cccu064BLgvsbJT0
         A/tdETCZZwIIx7MWeOYYWhlh+SvBQ25J3KOgEgmQitaVHcXUdIGHgS9PspxVr1eBRZlG
         b0AA==
X-Gm-Message-State: AOJu0YxRlIOqyUIf8m+ZeUyXEG1Gt8ekeBBoJW/Xr5XOU45GqEaeaGfH
	E6eexUWQDyEfhoAjepmNRu0ZlItIhWmZWrgtc5qWX5lNQeolaekNppWiaiaF
X-Google-Smtp-Source: AGHT+IEyChnUj4GgE/wXk7Y/evNbsTx4OmTWX7pm52luzrcLN7tlDPf4Pt+3I70Jmp86DIGWHLhsbQ==
X-Received: by 2002:a05:6a20:da89:b0:19c:843d:a6e3 with SMTP id iy9-20020a056a20da8900b0019c843da6e3mr2053930pzb.18.1706370493431;
        Sat, 27 Jan 2024 07:48:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j12-20020a056a00234c00b006d9b35b2602sm2892581pfj.3.2024.01.27.07.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 07:48:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] MAINTAINERS: Drop entries for hwmon devices with unreachable maintainers
Date: Sat, 27 Jan 2024 07:48:11 -0800
Message-Id: <20240127154811.2192488-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop maintainer entries for MAX31760 and MAX31827 since the e-mail
addresses of their maintainers is no longer reachable and there is
no known alternative means to contact them.

HWMON drivers have a subsystem maintainer, so individual maintainer
entries are not mandatory.

Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 MAINTAINERS | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..5e7239cb40ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1384,15 +1384,6 @@ F:	drivers/iio/amplifiers/hmc425a.c
 F:	drivers/staging/iio/*/ad*
 X:	drivers/iio/*/adjd*
 
-ANALOG DEVICES INC MAX31760 DRIVER
-M:	Ibrahim Tilki <Ibrahim.Tilki@analog.com>
-S:	Maintained
-W:	http://wiki.analog.com/
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
-F:	Documentation/hwmon/max31760.rst
-F:	drivers/hwmon/max31760.c
-
 ANALOGBITS PLL LIBRARIES
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 S:	Supported
@@ -13130,15 +13121,6 @@ F:	Documentation/userspace-api/media/drivers/max2175.rst
 F:	drivers/media/i2c/max2175*
 F:	include/uapi/linux/max2175.h
 
-MAX31827 TEMPERATURE SWITCH DRIVER
-M:	Daniel Matyas <daniel.matyas@analog.com>
-L:	linux-hwmon@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
-F:	Documentation/hwmon/max31827.rst
-F:	drivers/hwmon/max31827.c
-
 MAX31335 RTC DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-rtc@vger.kernel.org
-- 
2.39.2


