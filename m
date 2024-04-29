Return-Path: <linux-kernel+bounces-162869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2C38B6185
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25B028335C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88F13BADF;
	Mon, 29 Apr 2024 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaB4rAeB"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A8113AD1D;
	Mon, 29 Apr 2024 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417262; cv=none; b=KzSlsXcKZqojbCOnTG8G4l2KLxk8a7eYDiAFGhdhA239JNPoKwATOrld7dnyGOLoYOBTfPj2BJZn2OZUucrD9jZjVNyUJ4fJW6AYjoyOyeWVX0to+w4dQLrgJSfbJDMEKF7VoOzQpB22ZNeeaFyYKXqRY8/vWive6y2LjMdBmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417262; c=relaxed/simple;
	bh=e/EKtuPTPn4NChpsM6c21+3QDbDI1wDTorh6nJv74wU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YO0Cs+bAOSu2NR7wl6Sw4zWJjOzULePa37+zeVtz1ISeX1+fAibKKyta+b6Xb5G/UsryUheU897QOwtl+rf64dDDKSCOEZNhwLEP8InBbBKE2GQtO3WvnSJTztJSEhpufJRxJxjRYkDozwICiapUJc70XBVCFNOkfT+6NuozQwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaB4rAeB; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34d16d204f4so931078f8f.0;
        Mon, 29 Apr 2024 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417260; x=1715022060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+OOjPjRo623dIYYIWsxFcTXv4CTjfVgOyFCPn/JKfg=;
        b=ZaB4rAeBt4uxkCrlhymjQUsuktW4AX2DlB3z5hFEhvEvOPlexLoFkl8rsnzEfPLOuD
         YoOpyMTwOUjk6XQLkBlG4nJzmjLWhY7rrrvsYjxETzrqMAbgfYKj3tAxCJxBLrA+FEms
         RljJN+O0+tIajAUf3YxPi4MNBpGAtfeGvG6GrohTnCSPXaJ7I8Iqyzfo8Yh4GUzNuTjJ
         6aXJ6o5+WQ+TLy9bKoGPDN6BF8Rs3uBM5gC/MfXozdMVVN6P7ZvOKlFiW00VxG62hRPd
         OFdt3aq8u1x0HAIzCwcaqWmC2vfRZ5QwbhQ7yLcM155Kk7P6qGFe1TDX05KCQbVMAPHW
         acaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417260; x=1715022060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+OOjPjRo623dIYYIWsxFcTXv4CTjfVgOyFCPn/JKfg=;
        b=eXnyPZcYhZYeCg2zaWDR97R1YHlvESgm+2mto9lL1KiOXDFPYDQ4CIExUVk5SBNh+D
         Jjyj2Pe3aT5dVIpoxIVmaARMA6nqGjMyjHEGszTUQbqB615ENvLOi2EpZPf4N2j4wuGb
         008oqZPlDtF2IHMqQI1ls119jyD7VI0WaoM7JwQw8ykVA5I93KBUFd0oS20nQFSbVpoD
         fEEXYYYN81h2Y/O9nhlZ7gQZQYribucIU3EQlefV1+ThMrSQbkm4jdSnLLwXX77lWZO7
         AqIHCsCklWDWZZGXATg3PavA9OQTNmAAl+TJYnQWqfLmWY0hal6fVzeNQ90bAWcKfc7N
         JpkA==
X-Forwarded-Encrypted: i=1; AJvYcCUISumM7UQW10HA1Oask5T2tqmf+UPfDjBp3nUrGm37qsydhXBybAjgpTSaTx3DUmcwNjFSIlnLf3YxSAuAcgSyYW026jDa/p4eQWumMLMqyZ0hJJIPAQ9PN5mF8ggXKhedOF6sP5ll
X-Gm-Message-State: AOJu0YyKH+msl1U/4gm/M4EZju1b7xmV6HLX8vlGv71ZAjOXNqbNvE7v
	NvzpVVMVR6nHgzpVzH+MCrMpk9zWXw8onKZxLGmsrkjiGbUdwSFl
X-Google-Smtp-Source: AGHT+IFCG/f4fvOPYpgCtVIwD807apMXXXPXdiKyjA3/oZdLYym934G2JY3apElTiAsLB0wnEczZ0Q==
X-Received: by 2002:a05:6000:8b:b0:34c:8673:21f5 with SMTP id m11-20020a056000008b00b0034c867321f5mr5295641wrx.38.1714417259599;
        Mon, 29 Apr 2024 12:00:59 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:abbf:c98a:cf84:d14c])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdd82000000b0034c78bba70bsm8469456wrl.72.2024.04.29.12.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:00:59 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v5 03/10] iio: pressure: bmp280: Add identifier names in function definitions
Date: Mon, 29 Apr 2024 21:00:39 +0200
Message-Id: <20240429190046.24252-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240429190046.24252-1-vassilisamir@gmail.com>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch.pl complained about missing identifier names in the input
variables for some function definitions.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 91d4457a9230..fe4d3f127954 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -452,12 +452,12 @@ struct bmp280_chip_info {
 	int num_sampling_freq_avail;
 	int sampling_freq_default;
 
-	int (*chip_config)(struct bmp280_data *);
-	int (*read_temp)(struct bmp280_data *, int *, int *);
-	int (*read_press)(struct bmp280_data *, int *, int *);
-	int (*read_humid)(struct bmp280_data *, int *, int *);
-	int (*read_calib)(struct bmp280_data *);
-	int (*preinit)(struct bmp280_data *);
+	int (*chip_config)(struct bmp280_data *data);
+	int (*read_temp)(struct bmp280_data *data, int *val, int *val2);
+	int (*read_press)(struct bmp280_data *data, int *val, int *val2);
+	int (*read_humid)(struct bmp280_data *data, int *val, int *val2);
+	int (*read_calib)(struct bmp280_data *data);
+	int (*preinit)(struct bmp280_data *data);
 };
 
 /* Chip infos for each variant */
@@ -476,7 +476,7 @@ extern const struct regmap_config bmp580_regmap_config;
 /* Probe called from different transports */
 int bmp280_common_probe(struct device *dev,
 			struct regmap *regmap,
-			const struct bmp280_chip_info *,
+			const struct bmp280_chip_info *chip_info,
 			const char *name,
 			int irq);
 
-- 
2.25.1


