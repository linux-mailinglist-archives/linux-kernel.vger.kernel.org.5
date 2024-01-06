Return-Path: <linux-kernel+bounces-18625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CCD82602D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25FE6B22F67
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472868495;
	Sat,  6 Jan 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcoAXPst"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257CFC2C7;
	Sat,  6 Jan 2024 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d5a41143fso5617075e9.3;
        Sat, 06 Jan 2024 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704555123; x=1705159923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DF824uCnaiGc2FSUzvMoqf5PsqvATqJrmBhYo2JITb0=;
        b=fcoAXPst/fZh33zUWAKmKeqmhfEaKk7uHFUa2DeH9sqD/r3FMxUouIVbqxIYLziNm4
         V9BGAL3vJBD5KpiYgSRo6IrwxQkAbep7EdTJk6+FX9VgyYdCyDP/ON6UMdYvluCKZftw
         wAWQwBXLoOW3R+t33TtAawvdJ43bUbaYWy3vn+tho9/iYwadpoi7cgLX7EaoJrxxGA5q
         3tD9bxZd0FwYIvukWV6fVzh2QXyCOmII412vUl3c8d/vkyjD1WoPXe+zaiER/ySTuT01
         Q1n60Nqyx/1uxbKIq1yW4mkYzOrqg/YfsQT/VeWV4gMvWup6FbThQGB7zvg5xm9g8C93
         fzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704555123; x=1705159923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DF824uCnaiGc2FSUzvMoqf5PsqvATqJrmBhYo2JITb0=;
        b=hnlFxU0lV4sOhP3RtJPSoZjwYNAERf5E271Gb07OjKENK1aPt+cnGsJ2g3LtHPu3Uh
         mXFyIX7ziaGoiuRDHVygNdibhJskY4UzHqJn+4Vo9CfXzko4fBMQPu7AjRBg0MINT9rS
         pokw498WQcJQX0MJ/vpotW7haavLk4Cgee8Tgd9DVDll1XiRzdwU4CRMqkqiuwE0IBZs
         p0VozJlCdlyveIRRZa9kAaSs3SNcThuPJGc8kIZhPt4wtnfpYpwOyOZP+AzE+cDNoIAz
         +pxj1jfqNPolEa+MGemKWMYoLzGLQaTX3tgOhXK0hbxMgPe+0447MYce/ONOR7cSpJtD
         37CQ==
X-Gm-Message-State: AOJu0Yxvw94JL8I+AKXwPET7u42Gy0hH2j5HPGSJCwbKcq3vWQZZFEue
	Zw3R0nCsW/imZ5i5s5spx/uamQ3UT51xlA==
X-Google-Smtp-Source: AGHT+IGVSyhZpT89vDc93D2+XViO6lhhdOuR9fXaaZlNwaNxIYg1xJ/EnTlo7jlVKu0Uv8LrWzQrdw==
X-Received: by 2002:a05:600c:6987:b0:40e:3caa:f308 with SMTP id fp7-20020a05600c698700b0040e3caaf308mr605650wmb.56.1704555123228;
        Sat, 06 Jan 2024 07:32:03 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b0040e42391a12sm690204wmo.13.2024.01.06.07.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 07:32:02 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: invensense: remove redundant initialization of variable period
Date: Sat,  6 Jan 2024 15:32:02 +0000
Message-Id: <20240106153202.54861-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable period is being initialized with a value that is never
read, it is being re-assigned a new value later on before it is read.
The initialization is redundant and can be removed.

Cleans up clang scan build warning:
Value stored to 'period' during its initialization is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 03823ee57f59..3b0f9598a7c7 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -126,7 +126,7 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 	struct inv_sensors_timestamp_interval *it;
 	int64_t delta, interval;
 	const uint32_t fifo_mult = fifo_period / ts->chip.clock_period;
-	uint32_t period = ts->period;
+	uint32_t period;
 	bool valid = false;
 
 	if (fifo_nb == 0)
-- 
2.39.2


