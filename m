Return-Path: <linux-kernel+bounces-13964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EF5821617
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B671F21821
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 01:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9F481C;
	Tue,  2 Jan 2024 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+LU5KJO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878EA381;
	Tue,  2 Jan 2024 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9b51093a0so4912001b3a.0;
        Mon, 01 Jan 2024 17:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704157644; x=1704762444; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFYxP6M9En/LfjFXyPIaCGUIynVC1Pp2AH5m72mqAtU=;
        b=i+LU5KJO6lcJxqi+1GnTiDl/OHjo4BM+ZObBsQRvk1Kg+jG1Ko+45Shr8IuMvjym27
         ukUJCW5Fue4ka1QM+q3McHG9CeOLAtJ6qcsVU0FkNJwXJbSUm3PP3uEykUXkHZFdqSHe
         caVj+U7uX6UGF9ziXfuTs9swNqW2EbcpH4BHQnNXyA0JgpKOA2IKwO4jvYhl8zgb8iHH
         U0vMxssTWzPHhmWHNwZQI5g+2WabNz6D+7FDaY/ANzpwCf+92hVnxIxoAxEaDDi0qbJq
         pZCokvpF29sL3FuGQSKCfcwQlZd9WBBaM6A/wBfeV5l/s/GOXcdrjKRvI1LtDWtWEa/o
         J8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704157644; x=1704762444;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFYxP6M9En/LfjFXyPIaCGUIynVC1Pp2AH5m72mqAtU=;
        b=YzgrW4QmdpM9FTezNqOBbYdqKFXdEMmtuZD7H/yXnU9+5f6/5T5C0gL4oeCl6qkLCK
         P+2l09tqV8bWMEL49eDrzkFOlI90XxkmEsUCSkgUk1uP7uOVdos4wOb24y0u82lj8tfI
         X8LCfFFJmPR+NBi73XXrY0kGoABcV6dI1De023eM24KiKcjny9FCIMLxu0JRNmoOzKl4
         YuhH0JcOl/UKT7h5YkbcqbMVwUMPdrbjJfAj025mWz326yze657bIg5ZLgZyUh+aSFkM
         1LW4SeJSVmk0wlflj33NRj4LO1/hl6BJ+nZixvkRHKMgc2RZvSN02TPee96jI5q+mICz
         4A6Q==
X-Gm-Message-State: AOJu0YxsQs/4Ymoc0VbmQSzVW1B+2qs/NBHn5XxXo+DNIfXpIuWSXnzV
	dqWvOJY395E4iFbHqXjmV6Q=
X-Google-Smtp-Source: AGHT+IEwDQrHgQiO6pKxQDDsPGcTu7RQuqbVcDql4OP0li7dx9jXakhzOM3VndS0qvM01NB+tLh45w==
X-Received: by 2002:a05:6a20:13cd:b0:190:8b2b:1959 with SMTP id ho13-20020a056a2013cd00b001908b2b1959mr17538719pzc.46.1704157643615;
        Mon, 01 Jan 2024 17:07:23 -0800 (PST)
Received: from localhost.localdomain ([154.220.3.115])
        by smtp.gmail.com with ESMTPSA id b1-20020aa78101000000b006d9ecb8e956sm11591683pfi.173.2024.01.01.17.07.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jan 2024 17:07:23 -0800 (PST)
From: zhouzhouyi@gmail.com
To: songqiang1304521@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "zhili.liu" <zhili.liu@ucas.com.cn>
Subject: [PATCH v3] iio: magnetometer: rm3100: add boundary check for the value read from RM3100_REG_TMRC
Date: Tue,  2 Jan 2024 09:07:11 +0800
Message-Id: <1704157631-3814-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: "zhili.liu" <zhili.liu@ucas.com.cn>

Recently, we encounter kernel crash in function rm3100_common_probe
caused by out of bound access of array rm3100_samp_rates (because of
underlying hardware failures). Add boundary check to prevent out of
bound access.

Fixes: 121354b2eceb ("iio: magnetometer: Add driver support for PNI RM3100")

Suggested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: zhili.liu <zhili.liu@ucas.com.cn>
---
 drivers/iio/magnetometer/rm3100-core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 69938204456f..12c2e3b0aeb6 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -530,6 +530,7 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	struct rm3100_data *data;
 	unsigned int tmp;
 	int ret;
+	int samp_rate_index;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -586,8 +587,14 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
 	if (ret < 0)
 		return ret;
+
+	samp_rate_index = tmp - RM3100_TMRC_OFFSET;
+	if (samp_rate_index < 0 || samp_rate_index >=  RM3100_SAMP_NUM) {
+		dev_err(dev, "The value read from RM3100_REG_TMRC is invalid!\n");
+		return -EINVAL;
+	}
 	/* Initializing max wait time, which is double conversion time. */
-	data->conversion_time = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][2]
+	data->conversion_time = rm3100_samp_rates[samp_rate_index][2]
 				* 2;
 
 	/* Cycle count values may not be what we want. */
-- 
2.34.1


