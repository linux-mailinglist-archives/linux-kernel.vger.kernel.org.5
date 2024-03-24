Return-Path: <linux-kernel+bounces-112623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60576887C1B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911BC1C20D58
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 09:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55E71758F;
	Sun, 24 Mar 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhjlHaZD"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EED15E88
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711272734; cv=none; b=eleKnndmFdRlzAPp0Sk0ZnuLMJskMIqm0yLN13fQwbTU5OQEpdDPx0tCZowihtyTlbmv07OpDHtgXlLpYQEJLuCjEYI7Q4okiURK820dNlZpwBiw//ht3EhtUSSMea222Q4b+zxzlSBE5p7A3bofCfS4zqUnAXMENaKs7dxhhpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711272734; c=relaxed/simple;
	bh=YVVA/Nue1HWli9ajTETSkp/Z8ht1gvkZIg5G81ES5Jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=szbnyK+IBCIbpXZL7RsCAXTmIw+1aPxPHWukNmT3fH/3cTYK7r4B3AsQE09gJSxa71a60566w/AXAU8s+8zFPIbWXdnKiLsKlmLJ1drwk6fogGvKHvOTH85/aJ4MfQjWWKLO8M7PwCqT2pb8wzoFq1+grpFPytkGat+rBSG2Uk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhjlHaZD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4146e9e45c8so22304235e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 02:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711272731; x=1711877531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z4c5G0kdSZAq5c11ZQYphuwgiNaPxmvqYLKdSmtxQw=;
        b=YhjlHaZDIH8qOdbP0w0MhKNs2FfIPtf3D9Y3MXqWo6qbbHR/v72IXTC89HCLFelbvc
         Zpv0EZvUEm+/yh8KUNKO6uDHexkARbPhefz4x8tEdAthm9AqPGghOLwiAoWYQTASMvej
         ffa46+tfYIGpNtMEIPLhD5s36PBxiHp6/sAfSZZ4iDgi5Dw30uHBjpGv1ltaTQvIRvjU
         T1kho8sBK6mSRgkxq4NFF+q1mp8C+ErOV0L4QQnp5JWEW5oLUan3jW8V+CPwj4FOrLM2
         v8aWECyOAXYSY3lW5ZJfs4o1b0YDAPw7MevQWUVHyZIDBMEEGtV69BoTG+HObJ7Paao+
         bfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711272731; x=1711877531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z4c5G0kdSZAq5c11ZQYphuwgiNaPxmvqYLKdSmtxQw=;
        b=f6c/tCebvMOvQtErERzBrBJk8IfcJOOcmicu+b2YdLEEs2aabR8fmFNPJw/M3cyWtc
         K8g0JQ1yG6ckKWGLQmydIDijiSXqdZgb1a07Gdgy3nmH9fq2VA8bNJDdZp23X2gEr5u5
         MZx2UdfA0Vvo/r9VpGsoQrGZlqM/ALcCAqgG+NoZNY0ZhD2DuJjM/bSS5DHyGRPxhRDV
         QeMwxvTn20QvUAUa3UVYMfpeZ05CjVzp0fT7SfghVayOTvZG/A68CoFPNOyCp63pBv7Z
         8TOvADn0ozDaTxjp6GzwewU5p6eHRyU3EJbc+iD3nD90aSnXPqgrcdsp1f7VhK2kCS9B
         +dxg==
X-Forwarded-Encrypted: i=1; AJvYcCUQxZi+FjyYmwXTTBFde0df09Jffh3uz2A59i/E7GpaK08KQ7v8mCifbF0chaKQQfZtioPcvuRrxnRfVy6tRm7jWveZEEt9j9a7SndA
X-Gm-Message-State: AOJu0YxM7bMkxG0r1D9rea/r6tq/dmKpWoVtuN8Y/eleuzWjQtv02h6n
	0z7HbcO4B1S3knouv/VfUnGCRjrvJPi12ZrUNHc5Lo1qb8kExEHl
X-Google-Smtp-Source: AGHT+IGMRut/BEV6BtVvBXPHbQ6PxSc0Wph7gW5unAlhd861t5LWGUaO56+dlY9f44h3fJp8ac1pwg==
X-Received: by 2002:a05:600c:3b98:b0:414:5e9b:804b with SMTP id n24-20020a05600c3b9800b004145e9b804bmr2787739wms.10.1711272730644;
        Sun, 24 Mar 2024 02:32:10 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:42b5:8c78:fc9d:7600])
        by smtp.gmail.com with ESMTPSA id ay9-20020a5d6f09000000b0033b87c2725csm6490711wrb.104.2024.03.24.02.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 02:32:10 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: pi433: Use headers in appropriate files.
Date: Sun, 24 Mar 2024 11:31:59 +0200
Message-Id: <20240324093201.793485-2-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240324093201.793485-1-ikobh7@gmail.com>
References: <20240324093201.793485-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure rf69.c directly includes rf69_enum.h.
Move rf69_registers.h from header to the relevant source file.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 1 +
 drivers/staging/pi433/rf69.c     | 1 +
 drivers/staging/pi433/rf69.h     | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index b6c4917d515e..a351b7acfcff 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -45,6 +45,7 @@
 
 #include "pi433_if.h"
 #include "rf69.h"
+#include "rf69_registers.h"
 
 #define N_PI433_MINORS		BIT(MINORBITS) /*32*/	/* ... up to 256 */
 #define MAX_MSG_SIZE		900	/* min: FIFO_SIZE! */
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 5a1c362badb6..bf802f097310 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -11,6 +11,7 @@
 #include <linux/units.h>
 
 #include "rf69.h"
+#include "rf69_enum.h"
 #include "rf69_registers.h"
 
 #define F_OSC (32 * HZ_PER_MHZ)
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 76f0f9896a52..dd6fa8af9b9c 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -9,7 +9,6 @@
 #define RF69_H
 
 #include "rf69_enum.h"
-#include "rf69_registers.h"
 
 #define FIFO_SIZE	66		/* bytes */
 
-- 
2.34.1


