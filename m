Return-Path: <linux-kernel+bounces-132849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 431DC899B29
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED04B1F216D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5794616ABC0;
	Fri,  5 Apr 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="YdLFLAO4"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDAB18659
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314023; cv=none; b=SnMGOvK4W+keZ0zQfvuBYviKymGQVEyoFSptSDmmOQ0xZWxBQ1Cls+V/hKxhcfOCNM1a0JOTcA2ozgLIo3CakzGezIOHm7gB2zCQoTLqq16iniRBzyPXIaoD8fc++B51mv6hZMJ5RnPpoLA1pdMbTjjvQhuw28z6G8VjAvIMYSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314023; c=relaxed/simple;
	bh=SWszhvXa67B7cNMYOtTQ0pmGiq2oS/UZEJSvIsf/7DM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T6622ShwUzkaUoM5h9VacXYv98Nw1wwWJMJiwRSuTKT10WRQ+iHol0LGiI16yzB1qudUya3+URnjGH6zPSYigp5niyKUmqZcj3xR8C2vgnu/tRxB4H6GbRhohV1groPUwnlW0jF7nqh4L4OCRXtywc/xNcfLQyphokPdsbMUung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=YdLFLAO4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e2c725e234so5428985ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 03:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1712314021; x=1712918821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IW8WLsRqELRhGrnpFkB77O+jHrEv6LQ5ewlzXkr+zIU=;
        b=YdLFLAO4JPsy7gNWRDrojfljWO8vbjR12m/9yVwab1csUwy7XL+kC0B5TbCJoXXWuc
         LYzN9KhloiJ0GwSKtQ5fcK/Vf3sWAGH/WVKFZqSAsWFTku8TJL0GoCEII3NR4twPs8m+
         4cS5xsoYeyYVtZ43UqhAeu1PoZ4C6vUXcRfvzJXk6G60UVWz/BcPDFLdWVs74zu18DSp
         gycit9a2M/WavsIJdy2/F/bERu0wIayLIGW6LStVUfYJEyBM6tER6EAGCuse8JqlqOD8
         s0t3L1gmLw20U3nWWXzARuIu9Apz6qBb+3lJhHou3XnLf52kGDT0EOhFeviCGvkVYN1h
         QPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712314021; x=1712918821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IW8WLsRqELRhGrnpFkB77O+jHrEv6LQ5ewlzXkr+zIU=;
        b=Jnc+zJr3UrJG3jsqJZ/CKuV0GvsXaB0fqgPsRclmZh5GJVQw347z15aACQdvVq05O+
         x/OTKuJy5SnCEzO8SvsC0FQd22VpgUmReRtwEdQADURnbQBniLiNxJaij/y31gTM0ZzG
         4sv+ob2JFuuGuBwQ1bHE30qpfIogV03ElNmMu8tODEcs6Bbne9OmTIwJpqj6ckFlrWCm
         bsYOTQeCSfp8H6xsEJhwkY5Mi9dd44ds9ubbKuczROW4QilY8OHdFCjSLigN060sEgcz
         iyQDbk4zS528OhVI07/ky7d0Vh0blsaSXicJfBFNzHyd+EFwZL8nD/bfTlDEaBSR96NN
         ZErw==
X-Forwarded-Encrypted: i=1; AJvYcCXYXt45hGoha7jY37nskmsE+5ifnHDZaZbZ7/SzufS0JjbtNHsCZifGL2jcwqS/WqtfQPpN0Ide5kCkNWpz6ZqjQx+VjEjGplmVZLMF
X-Gm-Message-State: AOJu0Yy0IPloQVC7GCZSJcq3l4iTi98k1ZoJZNsFPqAuWYWJOct5EzH+
	e9QdF+HDNxr7WW3RYbaOZCmIaiiGyUofhXy3RotF0JoG6pXXW0vBkhfV1aDl/K2hqpTzZkE9QaK
	i
X-Google-Smtp-Source: AGHT+IEFdxo+UkKJYR9DhEbyIb4LCwpePH5hfHpch1oPI/VPdBqWu/Z938189HTj+SyV2nQxc8ZZlw==
X-Received: by 2002:a17:902:f0cb:b0:1e2:9c52:4757 with SMTP id v11-20020a170902f0cb00b001e29c524757mr2262263pla.14.1712314020854;
        Fri, 05 Apr 2024 03:47:00 -0700 (PDT)
Received: from localhost.localdomain ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id y20-20020a170903011400b001d8f81ecea1sm1257947plc.172.2024.04.05.03.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:47:00 -0700 (PDT)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: apds9306: Improve apds9306_write_event_config()
Date: Fri,  5 Apr 2024 21:16:41 +1030
Message-Id: <20240405104641.29478-1-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify event configuration flow.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/all/20240310124237.52fa8a56@jic23-huawei/
Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
 drivers/iio/light/apds9306.c | 48 ++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 4d8490602cd7..465b6957682b 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -1075,14 +1075,16 @@ static int apds9306_write_event_config(struct iio_dev *indio_dev,
 {
 	struct apds9306_data *data = iio_priv(indio_dev);
 	struct apds9306_regfields *rf = &data->rf;
-	int ret, val;
-
-	state = !!state;
+	int ret, enabled;
 
 	switch (type) {
 	case IIO_EV_TYPE_THRESH: {
 		guard(mutex)(&data->mutex);
 
+		ret = regmap_field_read(rf->int_en, &enabled);
+		if (ret)
+			return ret;
+
 		/*
 		 * If interrupt is enabled, the channel is set before enabling
 		 * the interrupt. In case of disable, no need to switch
@@ -1091,38 +1093,42 @@ static int apds9306_write_event_config(struct iio_dev *indio_dev,
 		 */
 		if (state) {
 			if (chan->type == IIO_LIGHT)
-				val = 1;
+				ret = regmap_field_write(rf->int_src, 1);
 			else if (chan->type == IIO_INTENSITY)
-				val = 0;
+				ret = regmap_field_write(rf->int_src, 0);
 			else
 				return -EINVAL;
 
-			ret = regmap_field_write(rf->int_src, val);
 			if (ret)
 				return ret;
-		}
 
-		ret = regmap_field_read(rf->int_en, &val);
-		if (ret)
-			return ret;
-
-		if (val == state)
-			return 0;
+			if (enabled)
+				return 0;
 
-		ret = regmap_field_write(rf->int_en, state);
-		if (ret)
-			return ret;
+			ret = regmap_field_write(rf->int_en, 1);
+			if (ret)
+				return ret;
 
-		if (state)
 			return pm_runtime_resume_and_get(data->dev);
+		} else {
+			if (!enabled)
+				return 0;
 
-		pm_runtime_mark_last_busy(data->dev);
-		pm_runtime_put_autosuspend(data->dev);
+			ret = regmap_field_write(rf->int_en, 0);
+			if (ret)
+				return ret;
 
-		return 0;
+			pm_runtime_mark_last_busy(data->dev);
+			pm_runtime_put_autosuspend(data->dev);
+
+			return 0;
+		}
 	}
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		return regmap_field_write(rf->int_thresh_var_en, state);
+		if (state)
+			return regmap_field_write(rf->int_thresh_var_en, 1);
+		else
+			return regmap_field_write(rf->int_thresh_var_en, 0);
 	default:
 		return -EINVAL;
 	}

base-commit: 526f7f17b651c78ead26fea7cea20948c00e47a5
-- 
2.34.1


