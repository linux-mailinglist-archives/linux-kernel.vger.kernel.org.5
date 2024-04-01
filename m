Return-Path: <linux-kernel+bounces-127008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DE28945B0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977DB1F21E1F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAD754FB1;
	Mon,  1 Apr 2024 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0EHfJ/A"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184353E0C;
	Mon,  1 Apr 2024 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000959; cv=none; b=N6yDgaWL1dtIjQmjxfjQiJixvursnH4K6QOmA91OgdIDybTf+0RJhiD7yE2ZTYmYrxUIoPBBWBKGSKyy4xoc8xttZQrD8zuLW/PUnQJnUDD3LHWEo1bM7wK2RbqZ2N33dvbuN9DS/xKc8IxYx7UZxHVddv4dpogWORhPWHmasgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000959; c=relaxed/simple;
	bh=zm86oDdJl6cIxDdoXgsyL0UvfiCEMG2mxojpGbrsdGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGHeTgZDFF9DkCBPOxXhJG/EyIPxBQ2l6kxG4D4J81DSlw9iPMQ+j/AGlXzR+syBpALRZ9GXSLwS5xTqQLhAoXMZnltLkaai2bxdIopwMuo6S9t3OBhouyYWBtxWkkO9+XJYWrXgWhEqAmsf6NBpqZW1EzkowDv6tY9/i1Rp+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0EHfJ/A; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4a393b699fso657852566b.0;
        Mon, 01 Apr 2024 12:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712000957; x=1712605757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtxI4w0Qk7zIrSyvpR8HbIgO3d5u7cqE3RU/yO0B6Vw=;
        b=M0EHfJ/AjPd02JiyQInmYXpDk/s0BB4SWLFe6veFZviLp5cLGrBFQW7oDb+ek8T9pj
         uakyifaT0gvnIB9P0lZ/rad+BO5j9qXxnhrOroDskrhgpQ8n+rgAZZnhJCQDHCFVg98L
         m6w97SN8HQowbMGif9lljUDaTGGREB0A6Bkj6J6gkoPG3wLzRmrSfq3wcpaMPn83kOcp
         2+87ng+YhU5LrsX0L4Ho52L5KgI9IvOf8IjBEfDBY2XQgnLUmUq5y8WgFeFyhxXPof4N
         OZtYaWatgf6qF2J7N/sFTS1PxPw/f2Akj76p7XEyJ/gYgtfo95TOuz1LZ1kqgRkQdJti
         7HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000957; x=1712605757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtxI4w0Qk7zIrSyvpR8HbIgO3d5u7cqE3RU/yO0B6Vw=;
        b=ljxNPlFtiOtJhWPGYKRN5miwDyeFtE9ZvEIN9SrfOo6zO1pl0V4eWke12c2NoHIRSo
         +h3FiVZibzHWQ9JWmgV7dvGqPic5HIfGq4N+pmK3XICXcyzO7nZXf9DUC4gec1VsA0yR
         TaA6sLRE0E2urj9i9uOGB10SBIa1h0dU2Mz5SncKE44jhSuP2TKvH15Fh3xv+uJLw8nA
         ZI7cNXqNUUjgcH7ontZXjNl44LM9SQfm/Vd9H2bZiLeY4pu2a3XWwkpARmOAhCKcapbv
         nm9XfJl6Ms5IBgRefeTqzB1GmS1s2RrjBrYJ2k8dH2+7txISpQffZblKtviQ2rna6uma
         RZ3w==
X-Forwarded-Encrypted: i=1; AJvYcCWICzJe7m6k7QsV1DlqNDMZOuCg5Q5iNpG8WmojYdf4SduqrPZJxFwVmpaP6LYoFxs+tgjdXirDA+d9kANw109YLiIJ49BvArqXT4MEY8J/m8PlA/5p+cfzKU3MGyNVNmJZKn9qypa6yA==
X-Gm-Message-State: AOJu0YymilNznfyYeELgNBTZJuYREACZKyj+op4+RpCZJksU6Uo0heJ3
	s+3o450D5R2xL1XFtOr/Z9aFHm1LSrAxsGKXyJhpa0BQapNPZjLL
X-Google-Smtp-Source: AGHT+IH3RWiV5C16zahtay366pDFB7qgpr5W1IfZGXVR7HSUwL2ED5v9MRWxNey41nQ8uCW0qmkg1w==
X-Received: by 2002:a17:906:6b87:b0:a4e:405d:8e3d with SMTP id l7-20020a1709066b8700b00a4e405d8e3dmr7900870ejr.22.1712000956709;
        Mon, 01 Apr 2024 12:49:16 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id dn21-20020a17090794d500b00a4588098c5esm5540575ejc.132.2024.04.01.12.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:49:16 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v7 2/8] iio: accel: adxl345: Group bus configuration
Date: Mon,  1 Apr 2024 19:49:00 +0000
Message-Id: <20240401194906.56810-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401194906.56810-1-l.rubusch@gmail.com>
References: <20240401194906.56810-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Group the indio_dev initialization and bus configuration for improved
readability.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index ff89215e9..e4afc6d2a 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -229,18 +229,18 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 	if (!data->info)
 		return -ENODEV;
 
-	/* Enable full-resolution mode */
-	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
-			data_format_mask, ADXL345_DATA_FORMAT_FULL_RES);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to set data range\n");
-
 	indio_dev->name = data->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl345_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 
+	/* Enable full-resolution mode */
+	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
+			data_format_mask, ADXL345_DATA_FORMAT_FULL_RES);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set data range\n");
+
 	/* Enable measurement mode */
 	ret = adxl345_powerup(data->regmap);
 	if (ret < 0)
-- 
2.25.1


