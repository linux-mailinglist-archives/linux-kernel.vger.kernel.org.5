Return-Path: <linux-kernel+bounces-80230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A3C862C53
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC21281567
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2D51B81F;
	Sun, 25 Feb 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGWtt3a5"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43CC18B1B
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708882429; cv=none; b=JUg78ljRYjCUBLScDdsTI3h73rq3bkyS0Q4xvXnhYMYlIlUVMdEIXHp7pHu4fTo4sY36C46ng0dU5SoEFK0BDc3d1PnTXAGEpb68dqHaDi214lr/OSEfusNy65HWUBDN5vqtxZ1bCoFCh2Zc9j2UobN4a87VIrdBabXHucZipvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708882429; c=relaxed/simple;
	bh=hW1hBb+c5MG+qi1RYxCxybzyrw2JmdBqXGgpDRxc9L8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sza295z5Rti7zU8HmaM0+x3mcCIuqLn5dvE4isjJNVlZIpFs5k3FaHZfVmMyZ45X3+quoXnwbbT14BmIZIHHOTWbRevdMLjb8Xl6Sq3kMKvjt8tb4p7k4j1znPKZZq2fTZ6k+PlpXML9KTPdgfPmVWikjYckGh+a/IyAGkYYRLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGWtt3a5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412a4b86f5fso1257385e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 09:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708882426; x=1709487226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxAitMAlksvcfjA+ht28Uc2cND52s9jJweHCl49uv/0=;
        b=EGWtt3a5CcLnOVGo4Khh5t2pGjgnTP4OsBBCNq5KWjrEmc1p6JWfrEQq1UXgv0LBHf
         p02PHvsIE9wzj9tNtc3AAr6XbCt+WeDvfliwjjTBq4m2LQF7BGCoCGWnsElz8e5sUdEg
         wbvmTnZbfxQoNzJlbshD9VhpcPMkkkbnr0ad23tavAy4qOm3QJJ2T+G9zGFDTtF3NgoF
         hQcwP46YcwOgB4NlVYSLlsBi//KQwUF9352TZwqabFP1N4AQ3iw9zROzUXxBvnPSpK4V
         +hJ9e93eyHQM0nERzQ+LdzZGUNBXnzjLRgEc9e9GXc+i6SMg7UWNL69xYoOPdD+Em5Ms
         WIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708882426; x=1709487226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxAitMAlksvcfjA+ht28Uc2cND52s9jJweHCl49uv/0=;
        b=w8chXlAST4jG8R3RbKXeKx27zg7d9kBLDg/90ehRxQaZTqQnz+sS2HG+zgB/HZLSIS
         4lLnzgz9S2yCDzjkRcXxOq79xO2dc09vE9RVgMJAyH528Z3VEgLsqQhCFfRxFfYF6xIs
         xTFo4zf8OX7HyuQW8u2kEBPmRcp0C2Gjb7VHoi5bv2AZZGxzpnRqEoTokI6sT8dDIXpd
         o+LysdExYRfQdWN52efRY+kY6HP1Pr3dTisDPaQqIeZMkoFCGJ6pz0Uyj7hNkKnyoYNH
         LPU+WZ1eVy1ZF7NoABU/RTo3wMd1E1lm3a4OW9W7ZiSk5P9WcC8r9SfBAE8Yuu1jB3es
         8aHg==
X-Forwarded-Encrypted: i=1; AJvYcCWKPK/Cj885hRfM2Iyg0b5Vgsppr6diYkSqNQcdn8UrEzmXTPYl7WIR7RPcpVzk6GclbaVDG9WAXYm72ROfJBYRfzjGBdnPaCk1jYXU
X-Gm-Message-State: AOJu0YwqDbCTu3HpeWizH72H/ddb/rJSDOFplhM5z8euAHVbhlXtd/ci
	LCEx6AOY5uWydeFNuFWOHnmT5wZtRbdveUAt5xybTm/0itPg5kIV
X-Google-Smtp-Source: AGHT+IFatI2Mw1RwfVTugJjlPgmMizsnbu6KzRUHvlM62cOfiV0IypdKK4huN9qvklZnjlHFG9496g==
X-Received: by 2002:a05:600c:1c1c:b0:412:64cb:eff3 with SMTP id j28-20020a05600c1c1c00b0041264cbeff3mr3262561wms.3.1708882426004;
        Sun, 25 Feb 2024 09:33:46 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:79c9:6db8:8198:3c60])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm9400108wmc.27.2024.02.25.09.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:33:45 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] staging: pi433: Remove a duplicated F_OSC define
Date: Sun, 25 Feb 2024 19:33:38 +0200
Message-Id: <20240225173341.1278918-2-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240225173341.1278918-1-ikobh7@gmail.com>
References: <20240225173341.1278918-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

F_OSC is already defined & only used by rf69.c source file
Also fix define comment

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/rf69.c | 2 +-
 drivers/staging/pi433/rf69.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 8c7fab6a46bb..d7e2dbe70d7c 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -12,7 +12,7 @@
 #include "rf69.h"
 #include "rf69_registers.h"
 
-#define F_OSC	  32000000 /* in Hz */
+#define F_OSC	  32000000 /* Hz */
 #define FIFO_SIZE 66	   /* in byte */
 
 /*-------------------------------------------------------------------------*/
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 78fa0b8bab8b..52e43a909b03 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -12,7 +12,6 @@
 #include "rf69_registers.h"
 
 /* NOTE: Modifying FREQUENCY value impacts CE certification */
-#define F_OSC		32000000	/* Hz */
 #define FREQUENCY	433920000	/* Hz */
 #define FIFO_SIZE	66		/* bytes */
 #define FIFO_THRESHOLD	15		/* bytes */
-- 
2.34.1


