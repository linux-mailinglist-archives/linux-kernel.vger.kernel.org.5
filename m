Return-Path: <linux-kernel+bounces-55899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FDB84C32B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161E728413B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AC212B75;
	Wed,  7 Feb 2024 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqSEWnnw"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE9810A20;
	Wed,  7 Feb 2024 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707277033; cv=none; b=sSyjrQpwv0nMGvxGzYyLkFlWCz0VS8ZQItsY9Hv8xjKmMNwD3XVFbAaNnNM+Wrh1ey7MMxW58xrCssBdJSHW5R3EBSbfI/Ml3t7XT4r6MntIkhFGPnm9GZy6rTRgUsvIwdqkxLESpUG1g+snPnke5+FevMQAahNVFQe6UpWRcwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707277033; c=relaxed/simple;
	bh=DzXdpNk0IldplWnZUSXf8zpiuY5OZq+4Qd+G8Yan964=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8hYjYI55slJDDCmfh5lXGMitTtsOmKwS1WHS5PkB+3mMj1dC5CttMyedJsBk91/gS5Obaino8Ht5lAIQT2IaEcIEdV2XomNhDV1d8ZKU3bT45cTWnsW+V5/a3sRh2/du4cWkqdxOYCyYyuhz49K0QwmyDyaSvP71hZ7TF1qU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqSEWnnw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ff802496cso1369385e9.3;
        Tue, 06 Feb 2024 19:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707277030; x=1707881830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jO4v0nbCePd1+AMeAWjbKpihfEE3SN8JiqCXFyWGK0Y=;
        b=WqSEWnnwTOD7Sz/aDQSa9U8I87Y5XN13cMnaeM1FHQz/bDyKZ1jpMMbrMq9UzBj9OF
         ZT/1TUqYae3+LvQyggFes/9WHmKS8V231SEfoX8LmoK8RV5JVGmLLMwisNwUqnhS5+YI
         2MTUo0xMgtNVYYNDWyMFtKsiYrTMoH38UBR5b7uSWiydKE4iYmhQLKM6Y7094rDdMhqP
         niDwQ27XQNmhUXUedbAXXGwX6sv4qYBY55vQZVDhK6Li3jVTilHjSuSCkyK0m1obgsrL
         yK1RBdktf2a6gRCl/3zxRvsa6qnsffvt7wtO+chfvXLfff0A67Zvji0ZwN0iqbxeO94/
         LTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707277030; x=1707881830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jO4v0nbCePd1+AMeAWjbKpihfEE3SN8JiqCXFyWGK0Y=;
        b=w2y4oIIIjr7I6IoZdETCD+VfliD6Fh8xwr9Agckgn5h9WrEnn/94uHY/AOn5V6hMB1
         JHuw2T3MVfCfctxsq4D5M7SFpqkm5loZVaXA+ZNpHapE9OvW51tkgzvbGixMC7n/cAcx
         bCEzOJprgh2FNBIzTCH4EBp0iL7dkyz29UesDa0byMwTE/+n5V9cejrH3rY4ZAR6wqIp
         ygyS75CeDw+Sb9vQ8QFm5z8NGKZjTvzoCXdPSZGylMCBW6eEt6IqS3PiwKgX3ONtj1W/
         M2OFtUvo7rnnAsjLG7g19BweYyc8/FY7TN+GMt3XQRXckcxiuu/3BdSsCeVkDmr4zbFL
         gAtg==
X-Forwarded-Encrypted: i=1; AJvYcCUjgMbJh4IE2ByXlgwbN8wVTtCV867K5MTDV4EU6IgJsheQxvzm1Vt2SIkWvOmz/Q480/05edI1NKAMChCTzS7t8cMWuak0V0tc0gYnBga8O5BJ/ZFu6i8qtJJKkIovxO0Mmtu+4OHQ
X-Gm-Message-State: AOJu0Yx0IkKR2jcZdYcwVQWh0/Ogs+3u/zq8vkUyZgtc5yb0pnLLfOPI
	a9vic4XkP3A02vOpbVUUv3JfE5WsJSSC3UkI8Y/oYec/bCFhGuco
X-Google-Smtp-Source: AGHT+IFvuN46Yba6zvQUzA+PGsOaAcK3v+MuP3fOMQoVXxOcYEkz+hetsFuvi65WoeoI5+4gmpDMbw==
X-Received: by 2002:a5d:59a1:0:b0:33b:48f2:13ee with SMTP id p1-20020a5d59a1000000b0033b48f213eemr3193489wrr.19.1707277030214;
        Tue, 06 Feb 2024 19:37:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXd3JgzV+wPPM5K2DxTTdIA3ceUB2hjcCuZgwd/YIgPq3/Iqwera8AB0fFGyAlFkn2E6t99T6G9yLQ9OBR7L2+/f/7p7RmsKF3vPezfL+3HoJJd6tg4KwwKsO6AmD3HlZkPqiAb4v84wVoFQy7prDLiJV8B8V6BscaUdMPITzbA6e2/3ki8YspigCLKA384hi1q/VhQcZl5HzwHcrM5l9zQm3GmXXHl9bL1RT/ArsaI8O4x2LruKOhjpZIYII5GQ563Utj4CPxS4KcZ
Received: from demon-pc.localdomain ([188.24.52.65])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4e05000000b0033b422356fbsm373447wrt.80.2024.02.06.19.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 19:37:09 -0800 (PST)
From: Cosmin Tanislav <demonsingur@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH 2/2] iio: accel: adxl367: fix I2C FIFO data register
Date: Wed,  7 Feb 2024 05:36:51 +0200
Message-ID: <20240207033657.206171-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207033657.206171-1-demonsingur@gmail.com>
References: <20240207033657.206171-1-demonsingur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As specified in the datasheet, the I2C FIFO data register is
0x18, not 0x42. 0x42 was used by mistake when adapting the
ADXL372 driver.

Fix this mistake.

Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
---
 drivers/iio/accel/adxl367_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl367_i2c.c b/drivers/iio/accel/adxl367_i2c.c
index b595fe94f3a3..62c74bdc0d77 100644
--- a/drivers/iio/accel/adxl367_i2c.c
+++ b/drivers/iio/accel/adxl367_i2c.c
@@ -11,7 +11,7 @@
 
 #include "adxl367.h"
 
-#define ADXL367_I2C_FIFO_DATA	0x42
+#define ADXL367_I2C_FIFO_DATA	0x18
 
 struct adxl367_i2c_state {
 	struct regmap *regmap;
-- 
2.43.0


