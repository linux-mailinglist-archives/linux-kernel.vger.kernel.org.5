Return-Path: <linux-kernel+bounces-78389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2858612D5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CB8285F75
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692D97F7C5;
	Fri, 23 Feb 2024 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OywzuOoN"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433C7EF04;
	Fri, 23 Feb 2024 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695488; cv=none; b=OaiBUMtIvdrCoge4NOWHkHLAKn1d20+HIO3IOz++NFRQRo4OXYqVRZmaeHkQUaSdTTwT6JlR8E3/odv6nDW1Q21B8XIspY7yMHJWie0Uu74Hte7R2epnvS8nVTOG0IkwpPJvzpy3837lVkWtzpx6I9u9vT+lo3aIglcaepOq6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695488; c=relaxed/simple;
	bh=rwgTv0+tt8DmkwbCCq7IVVH09nh6DvQW2NolmCLxYCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjqpiflG/B0ARHHrlEIFntdZaEmHstWXw8aSrRk8SBBFRlsFLQIUi88pokOZ0x2ymY3n+fe/sbGBIL3FTIEAfm1IaDXEs/OZsubMD/6Q4SWkHFammV1A3gT2sD4EMGG/tVZDtYwuJBTVcYB7pzhqfh0kCGQrFMDcSwW/z7RSpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OywzuOoN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563fe793e1cso1060128a12.3;
        Fri, 23 Feb 2024 05:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708695485; x=1709300285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVYh8Pt1sI9DwV8YnQvT559pSivGGSaGIJgfdzNNlQA=;
        b=OywzuOoN48Ndobq7Pk6FbHRhsU89Ks6iCKfBkw44mc/qaX9HN+DWTWar+XqMlVQOaf
         QnWLID/XkCgxXxM8k9g/Gvvx4GDG1vIsRKYiXhtnDgEpvOCichDvL8Pc7Q8AcontlOkj
         nMcrhhVJ6rvv2qnR1DSl7uIC4ef3Xr8vglw40HcAHV5W5vJGyrc+qVcydxvV6r8nZi92
         zo70e6qmcxJf/D8ZsmE7qY+ZmTxnK637kGy2iDKG4E6hkjyPDpK9aDkLAzznwjebcVH4
         qkd0w/lGyyUJRrTYYcFemn4qoUpm9B3p6Nqpra8M2rDpUWa+InLEtcixHcGqBd7XLYCK
         M1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708695485; x=1709300285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVYh8Pt1sI9DwV8YnQvT559pSivGGSaGIJgfdzNNlQA=;
        b=iu6nLoiD6WvYy/j97uUyb48DvI3NH9P+91qtxNNanFDlqBtv1nDxdX+kYo/HtRAgrV
         /2L63jdk9/tbAP6/Fm/oZ24heqUCqwob6hfROMVAC3piN0c76PnRJS316Ln/A4gttbEF
         4tkBKbDo4UrXhsIVCSR3nccmIFUIXj+hSULnMZkC6NDq7km9yrG3OVnqh0amWJnSndox
         /Co9R8BlUUmJ6eIr9DyqB8HcberIRB7l1PoyPUCijK3quqcxNutG7Y6sN2CvncDRCmaH
         0JPMET3lSXEaLyn3w39IJKoM6MtMpEEMGgaqCoXT0lob0vdDMJyYos/+0DFDCRvRUpHS
         TkkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnGfFgJPOq1CVZWVNptgKmeU0rMDKFpND9Hn/FRnhVBeXCwQSTwqv/iuf2uSmvqSLWvdSMsCR5sl7bGbG2dU8NWPa2k5RLrmSRVAP+gN2NWekvt1um90HucoxGob2t6V4OzQsPz3bB3ekxeRtkKPOEhU6g600zVo4oeRDN6x1M3EN0BkVTgV0/bXXeczYuZX8FKsaXs4dIWmQdFwZQeN0=
X-Gm-Message-State: AOJu0YyxUBhbTFwIZJQV0IcjzTk8RWDqEWnmrlf0EHnkfxKxZiYZ8uZK
	RA5RKA1ExoKxDYxkmyWHOtj4ammXw9t+dGt4+biIAjN1OboVIXL9LwENKqxlB54Llw==
X-Google-Smtp-Source: AGHT+IGN80GLzTdjf2dyxzlonrvB6WR0vGG7AF0Ag8OpGawTvTcRyjKhjMpjJiWHmavw7bfrdOtG9g==
X-Received: by 2002:a17:906:802:b0:a3d:a63f:2db0 with SMTP id e2-20020a170906080200b00a3da63f2db0mr1302630ejd.28.1708695484688;
        Fri, 23 Feb 2024 05:38:04 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([83.103.132.21])
        by smtp.gmail.com with ESMTPSA id h11-20020a17090634cb00b00a3d7bcfb9a1sm6911429ejb.128.2024.02.23.05.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:38:04 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org,
	linux-gpio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	David Lechner <dlechner@baylibre.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v15 2/3] iio: adc: ad_sigma_delta: Add optional irq selection
Date: Fri, 23 Feb 2024 15:37:29 +0200
Message-ID: <20240223133758.9787-2-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223133758.9787-1-mitrutzceclan@gmail.com>
References: <20240223133758.9787-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add optional irq_num attribute to ad_sigma_delta_info structure for
selecting the used interrupt line for ADC's conversion completion.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
V15->V14
 - Uppercase ADC acronym in commit message
 - Rename irq_num to irq_line, change type to int
V13->V14
 - Invert logic checking the presence of the optional irq_num attribute
V1->V12
<Not present>
 drivers/iio/adc/ad_sigma_delta.c       | 23 ++++++++++++++---------
 include/linux/iio/adc/ad_sigma_delta.h |  3 +++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 7e2192870743..03c170b638a8 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -222,11 +222,11 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 		goto out;
 
 	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->spi->irq);
+	enable_irq(sigma_delta->irq_line);
 	timeout = wait_for_completion_timeout(&sigma_delta->completion, 2 * HZ);
 	if (timeout == 0) {
 		sigma_delta->irq_dis = true;
-		disable_irq_nosync(sigma_delta->spi->irq);
+		disable_irq_nosync(sigma_delta->irq_line);
 		ret = -EIO;
 	} else {
 		ret = 0;
@@ -295,7 +295,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
 
 	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->spi->irq);
+	enable_irq(sigma_delta->irq_line);
 	ret = wait_for_completion_interruptible_timeout(
 			&sigma_delta->completion, HZ);
 
@@ -315,7 +315,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 
 out:
 	if (!sigma_delta->irq_dis) {
-		disable_irq_nosync(sigma_delta->spi->irq);
+		disable_irq_nosync(sigma_delta->irq_line);
 		sigma_delta->irq_dis = true;
 	}
 
@@ -396,7 +396,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 		goto err_unlock;
 
 	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->spi->irq);
+	enable_irq(sigma_delta->irq_line);
 
 	return 0;
 
@@ -414,7 +414,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
 	wait_for_completion_timeout(&sigma_delta->completion, HZ);
 
 	if (!sigma_delta->irq_dis) {
-		disable_irq_nosync(sigma_delta->spi->irq);
+		disable_irq_nosync(sigma_delta->irq_line);
 		sigma_delta->irq_dis = true;
 	}
 
@@ -516,7 +516,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 irq_handled:
 	iio_trigger_notify_done(indio_dev->trig);
 	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->spi->irq);
+	enable_irq(sigma_delta->irq_line);
 
 	return IRQ_HANDLED;
 }
@@ -586,9 +586,9 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	sigma_delta->irq_dis = true;
 
 	/* the IRQ core clears IRQ_DISABLE_UNLAZY flag when freeing an IRQ */
-	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
+	irq_set_status_flags(sigma_delta->irq_line, IRQ_DISABLE_UNLAZY);
 
-	ret = devm_request_irq(dev, sigma_delta->spi->irq,
+	ret = devm_request_irq(dev, sigma_delta->irq_line,
 			       ad_sd_data_rdy_trig_poll,
 			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
 			       indio_dev->name,
@@ -668,6 +668,11 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 		}
 	}
 
+	if (info->irq_line)
+		sigma_delta->irq_line = info->irq_line;
+	else
+		sigma_delta->irq_line = spi->irq;
+
 	iio_device_set_drvdata(indio_dev, sigma_delta);
 
 	return 0;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 7852f6c9a714..576eb617939d 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -45,6 +45,7 @@ struct iio_dev;
  * @data_reg: Address of the data register, if 0 the default address of 0x3 will
  *   be used.
  * @irq_flags: flags for the interrupt used by the triggered buffer
+ * @irq_line: IRQ for reading conversions. If 0, spi->irq will be used
  * @num_slots: Number of sequencer slots
  */
 struct ad_sigma_delta_info {
@@ -60,6 +61,7 @@ struct ad_sigma_delta_info {
 	unsigned int data_reg;
 	unsigned long irq_flags;
 	unsigned int num_slots;
+	int irq_line;
 };
 
 /**
@@ -87,6 +89,7 @@ struct ad_sigma_delta {
 	unsigned int		active_slots;
 	unsigned int		current_slot;
 	unsigned int		num_slots;
+	int		irq_line;
 	bool			status_appended;
 	/* map slots to channels in order to know what to expect from devices */
 	unsigned int		*slots;
-- 
2.42.0


