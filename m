Return-Path: <linux-kernel+bounces-21983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB71E82977A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792191F21137
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCAE48799;
	Wed, 10 Jan 2024 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3Sqwgxc"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E1482CC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e4582ed74so32220015e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882081; x=1705486881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIejJEXeNUqkKRlWpyybjPC4hGJCbHArkKwU6CRLU6k=;
        b=Z3SqwgxcnFKlWFa8xWVshMiT/It8Qky4i5hZWPM0juCESNRhqlR5uOvGMW/QR33GOn
         5wVqTieLjrw9MHPdnAcPDSBVHY2qL4riUB8nnnZePRhGEEUNQ/EOISRNOMRfzcv5OpPe
         PXTjAj3ALhZITWOTD/mbIZ89XKw340RDc5/ofwMC6mQXv8f0EPRzH24GvaS9XQCofD52
         jXtGdI5hE64frL1E8NLh3DWihwcwmUZNP65CmXw7QNKr8KOmIrRs2nrMyQg9hwmgEHwA
         r/8WK6eIxJw0qlske6k7MTB2hb4wxsx0s7QUj+ufqgbAshBoOExBOckVT1RIywaX01NT
         /psQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882081; x=1705486881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIejJEXeNUqkKRlWpyybjPC4hGJCbHArkKwU6CRLU6k=;
        b=HsG+NUg4BwVl1lpxf3L21oIgatcD2ZlG5IXtqXV/A+cSqSii4l7rTrQBhwl0AVgiMv
         FRJ7PHIbBNDTtKLqbeL1+iIPyS2kfiFjtrgwIlnSqVx0lPs/ZRp6St9oMUtSO96mz6pl
         4ipYTeMZGEuIhRxAS6RKYZhGnyu5mll9uWlh4UJTnM/JM+XOQFk1L1eTXmZ1UvOQraC3
         wbWCu/2bCwi87y9f4QSM4aSXKyI6aJOdXJBI2W4DNLwq8c1ypU1KNyvFcfPSk7yoXG5K
         t1OnbnUppyV+tnH3F8kHG8QZH8DkpqYNaXfwhkfaxgpz5Cw7zCH3b2v+83zeV44EA71R
         35uw==
X-Gm-Message-State: AOJu0YwM++YNMdxztg/ggW0qEiJsfrMokJj8pKKFokoV4zdQkOv0JTSp
	sV4W4sufqwOY8hBsqcMtmxe8YVo+fpaVvA==
X-Google-Smtp-Source: AGHT+IFtDvi8wjZKg9pm0ERSI9OUVSk7oMwH+ipIk06V0XhYNU2+w7zsSgC+1btLE2dAAQHJq3B/vw==
X-Received: by 2002:a05:600c:1d97:b0:40e:567f:38d7 with SMTP id p23-20020a05600c1d9700b0040e567f38d7mr188898wms.225.1704882081232;
        Wed, 10 Jan 2024 02:21:21 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm1625302wmq.29.2024.01.10.02.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:21:20 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 17/18] tty: serial: samsung: shrink port feature flags to u8
Date: Wed, 10 Jan 2024 10:21:01 +0000
Message-ID: <20240110102102.61587-18-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240110102102.61587-1-tudor.ambarus@linaro.org>
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's a single flag defined as of now. Shrink the feature flags to u8
and aim for a better memory footprint for ``struct s3c24xx_uart_info``.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 5df2bcebf9fb..598d9fe7a492 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -90,7 +90,7 @@ struct s3c24xx_uart_info {
 
 	/* uart port features */
 
-	unsigned int		has_divslot:1;
+	u8			has_divslot:1;
 };
 
 struct s3c24xx_serial_drv_data {
-- 
2.43.0.472.g3155946c3a-goog


