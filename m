Return-Path: <linux-kernel+bounces-84858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC12786ACA8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED72E1C225FC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E29F1384B8;
	Wed, 28 Feb 2024 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCUNPJxD"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CF07E577;
	Wed, 28 Feb 2024 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118392; cv=none; b=YjQN3T9ASQEtXx7+ZoEf4l8s+ARu3gisYjkXPzxVQz1r2OZ22CYJpqKAjV/oLCaloo7HpcCYo3k3WUmvuWLYtjvbEkAP9GKlZEYKcIJtolbCdc2sTxdtKuyEWxoLMbnqKy/nvDfLSQ58v9X8t6g/G/0a1EOoL1XpmcBk6vXJ7j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118392; c=relaxed/simple;
	bh=zgVBQQNdLcI5u/3eJittkjKFWT8SsSWqMjLnEWwmHII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEr0ghumMy9KEXRZbdVNRAadFmQL7Dlx9qwDYsRQzhbYCGlXePhOzuOduC37O5oSgM+RmLLjncuQOwJheHCKsvbR0sBDVZyttlK+vUJT79eBFkKPwCLxNS7SMR272N4Qi5p/9XjT2cEgpl913a3nWxWKXbHuHGthQl2nGtOZnNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCUNPJxD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-564a53b8133so4554599a12.0;
        Wed, 28 Feb 2024 03:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709118389; x=1709723189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7T4BNW/EVrA/ljL/F5Mfy2Gl1eafnsTSt0599HMS28=;
        b=PCUNPJxDUOlb72G8ssJoKmtOp6ZzahCKTSb1rcFmXaU7S03JWsKMujJpKnK5BlOaye
         MFdJ3TwPZ2lZ6Z+FqHhwN/Q7G8irsNdfk7N5jmUKvC2oh788kWz/+lMFg3mtztFiOQjF
         ftxCrKaRf9fETxryec9mEl87/ltjOqqILnjHFvgUt23Sjimoz/z6kwOMHeF9FWo/RC0y
         uEQME2oNn2XQyS3dlJb4LTv227s42E362CyLPTUjYeEuUP24PPiLp/SsqQ9w0yil5oCj
         JY/VXRtt4P50bgfC8wgbkj+ZapPo5bSUpnXAQ46wj4M0M+wN0FW4JCqAQKiqjZm+Tkn4
         KhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709118389; x=1709723189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7T4BNW/EVrA/ljL/F5Mfy2Gl1eafnsTSt0599HMS28=;
        b=l9imcaYmusFSX4nR5RFGmyxQeI7HA1cwDnLMtCljNZT3SeGVpves206hkc/W8lKEQG
         uJhKYt1fb/Trak2WFi8f807CBmCeO5imNhx/jXPjjExvYHuCzEzdEIlR+LovPF4OgwJ0
         s/WYv5m5nM4QIt0cB0h4/qD8D+0zRoZnXaPcbalh8Y57QYE+P2SFbuHBO4eLM5VCE06u
         oP5RGf/2xphDmS2PoDH6wX5DNAQaWJHVeXHkDo+rUe61GhA3Q3OP4S2EQS1+dF1vMrS9
         BknJevUKFzj3Dezs5/fvGm0yEFddeytQO8hTX3SaAs5XV3XKRjeQj5JHKp/hvO/7sEDb
         ymkg==
X-Forwarded-Encrypted: i=1; AJvYcCV+ATlmWHE9JPtCM/w1owwudREtNR93CwN5jEzIPPTICtJzC1ZEkOuyL5qN0qKxCCWRT3sjqN1BtPzBUuZMEkN6ZJuPClxkQxCw+LAVqAl58wm5IN0UlgKUEpdlriwoVsUK74sqa0Bp9CYb9YuKnhOBoUvP4GRK9hQLKfMWroUHjhjTuYvJSJJHVGm9OH/ntZM3Nt0XyftXVG3EfFpI4g0=
X-Gm-Message-State: AOJu0YxoGIVkQaMgNdxK5J7ksQiDfNLBC2LKlGyUqUuOD7z9dnFwzMfN
	uMF7GUU9qRz2FwyH/R0TLXy9vlsLP535uoIxUcoZCmHS9oL3MiQb
X-Google-Smtp-Source: AGHT+IFLIWurDnvTfidibHsXfJA5CHazg06uIdJmV0dWZZncoDT2HYriUUhCkamNWOX+tJXWev7Qeg==
X-Received: by 2002:a17:907:1008:b0:a3f:b6a4:8878 with SMTP id ox8-20020a170907100800b00a3fb6a48878mr7791943ejb.40.1709118388799;
        Wed, 28 Feb 2024 03:06:28 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q11-20020a17090622cb00b00a431e4d5deasm1717773eja.155.2024.02.28.03.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 03:06:28 -0800 (PST)
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
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 2/3] iio: adc: ad_sigma_delta: Add optional irq selection
Date: Wed, 28 Feb 2024 13:06:19 +0200
Message-ID: <20240228110622.25114-2-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228110622.25114-1-mitrutzceclan@gmail.com>
References: <20240228110622.25114-1-mitrutzceclan@gmail.com>
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
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20240223133758.9787-2-mitrutzceclan@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
V15->v16 <no changes>
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
index fbba3f4a1189..068ab4cc4c7f 100644
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
@@ -587,13 +587,13 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	sigma_delta->irq_dis = true;
 
 	/* the IRQ core clears IRQ_DISABLE_UNLAZY flag when freeing an IRQ */
-	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
+	irq_set_status_flags(sigma_delta->irq_line, IRQ_DISABLE_UNLAZY);
 
 	/* Allow overwriting the flags from firmware */
 	if (!irq_flags)
 		irq_flags = sigma_delta->info->irq_flags;
 
-	ret = devm_request_irq(dev, sigma_delta->spi->irq,
+	ret = devm_request_irq(dev, sigma_delta->irq_line,
 			       ad_sd_data_rdy_trig_poll,
 			       irq_flags | IRQF_NO_AUTOEN,
 			       indio_dev->name,
@@ -673,6 +673,11 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
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
index 7852f6c9a714..9b176bb55a63 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -46,6 +46,7 @@ struct iio_dev;
  *   be used.
  * @irq_flags: flags for the interrupt used by the triggered buffer
  * @num_slots: Number of sequencer slots
+ * @irq_line: IRQ for reading conversions. If 0, spi->irq will be used
  */
 struct ad_sigma_delta_info {
 	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
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
2.43.0


