Return-Path: <linux-kernel+bounces-72730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D445185B810
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E51B28108
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A1B657DF;
	Tue, 20 Feb 2024 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzi1/MY5"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6C60DDC;
	Tue, 20 Feb 2024 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422234; cv=none; b=dhCgrppCY6hXsZ7jHbdjtqNg9hihCYpNIm+/XmEBIfW2tSHeYz/UlRzSLgHgG7xE9CetMExZbvF+F1tLkfBoBBnIxhj7vEciVHi8/oieJh0wUjUN7zSj0b4ePtcR0p85UjVqMGCWzP/6bRtnubtyUrUdMb0LxBCng7Eg0nols54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422234; c=relaxed/simple;
	bh=9UhZWLvkrhqno/vFSqGZ/DXdacovNiY+EP2/H8gs4Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CL8llKgFVy9337lwByS5L4UpHcznc+mxc4nML+j0MwIQbNZ3W8ai//0F3bcJ6TO/giSUK08Yw+0od6WApHN0mNGvdJ7WEftZz6PZXqGh4JhNjPw83HCHBQPXZw7iEKyZ9g4KRetBB4K+Zj4UFu6X59QRiCtb5HZwZT4sv+aLeRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzi1/MY5; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so42223271fa.0;
        Tue, 20 Feb 2024 01:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708422230; x=1709027030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GfdpFSEU4FlothZXUc0bimkte0se1dxOFRg/9N9zyc=;
        b=Jzi1/MY55NXyeEAgCVzkMfQlL6KT03jjVnBcyN0A482D9QsUHzWjXLdhQ7C/KkS1fH
         kgw4C9momTntaJ3ii/xp11bPU0Ka6K+KU/YL/DE8NpK1/SlFw3PM/0BvqHaLc7sIMa31
         s4O12TBaC604aD+qQ8MPSJFNCmV7eoBmxA32hZX3c1K6DHUyyhhA6jF11wUs8rAj68gI
         cu12rqm8T0pBaHgHzGwDuuLNitr2uNeUgdkYqt59eh1lkkQUq2Z0VfhlEHt9lGb5AtcY
         jcbnQ/FxwxO0ztWh/nT+HS6xwLGXWFSN52B0BxqknXm2Fa8AIjqFLnarw3Nw+gc+xbPa
         sqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708422230; x=1709027030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GfdpFSEU4FlothZXUc0bimkte0se1dxOFRg/9N9zyc=;
        b=nDWkk+3oDFP6yFhsMt52d6RV8nj1uUVUnEo3Jqz04xsjJN1Q+wIWhJkPIAArHZY1li
         UXJKH0zqV+PED1bo2DLhM/bdY59CafBAi6ZfYzVOUwZxmFnvmsnVuxuroBkLxSF8+sTO
         g9tZ7/KdfKjn1Arsy0dg0LMaAmIjMMRxAoEz27Dh0Gt1qYze37mNNpBBUwnUNTm8vy6r
         FGAGjFK67EeU3M9zvyKJv1h32VIdL+G6okIYeFsmKVs0E5HqNkss5TuEQ/fLg5BriTq8
         stUB67t9PBocvCJIZwGg8m7c4lsk+PQmv6jisIfV7CyupgVqcSZTrA+CW6tU0os5c4q/
         ofwg==
X-Forwarded-Encrypted: i=1; AJvYcCW/LSUFp060bkvfx8EylyFLAyHrfVI3zXJhFM1tw4/X39xDMC+8BBcPjibHxBu7d+r2jL2VYSjS1wExVTVLY/gam5wwXiR+TMVuyEsUJ1LzUDQ+q0CURGQnKTNkzabf2p6puSDhMPBUE4d1qJL3wpEup1swWpGko77NYR1zFngKYkEwmCUNDJ/QGV6gzalUqgYI60DDA+l+Hu7ElzlmVws=
X-Gm-Message-State: AOJu0YxdclGW7HR34BXIDovM2QIPtGyb2gWGta6Sf6W6M1ewlui5I8op
	WsnwbZ+Y3B9r/fDEF1zDH805n/GjQbi0locqd7nNr96RXcc/8Ebx
X-Google-Smtp-Source: AGHT+IG+/XgqpdseubU3KptrBKz456hW/fWGCnDQFNkMAppuMUXqBK1gGGoLAh33mHGpWwkdgW3XZA==
X-Received: by 2002:a2e:3606:0:b0:2d2:35af:e8a2 with SMTP id d6-20020a2e3606000000b002d235afe8a2mr3732012lja.48.1708422230167;
        Tue, 20 Feb 2024 01:43:50 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c020d00b00410dd253008sm13865092wmi.42.2024.02.20.01.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:43:49 -0800 (PST)
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
Subject: [PATCH v13 2/3] iio: adc: ad_sigma_delta: Add optional irq selection
Date: Tue, 20 Feb 2024 11:43:39 +0200
Message-ID: <20240220094344.17556-2-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240220094344.17556-1-mitrutzceclan@gmail.com>
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add optional irq_num attribute to ad_sigma_delta_info structure for
selecting the used interrupt line for adc's conversion completion.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 23 ++++++++++++++---------
 include/linux/iio/adc/ad_sigma_delta.h |  3 +++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 7e2192870743..a0ae3a21e919 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -222,11 +222,11 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 		goto out;
 
 	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->spi->irq);
+	enable_irq(sigma_delta->irq_num);
 	timeout = wait_for_completion_timeout(&sigma_delta->completion, 2 * HZ);
 	if (timeout == 0) {
 		sigma_delta->irq_dis = true;
-		disable_irq_nosync(sigma_delta->spi->irq);
+		disable_irq_nosync(sigma_delta->irq_num);
 		ret = -EIO;
 	} else {
 		ret = 0;
@@ -295,7 +295,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
 
 	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->spi->irq);
+	enable_irq(sigma_delta->irq_num);
 	ret = wait_for_completion_interruptible_timeout(
 			&sigma_delta->completion, HZ);
 
@@ -315,7 +315,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 
 out:
 	if (!sigma_delta->irq_dis) {
-		disable_irq_nosync(sigma_delta->spi->irq);
+		disable_irq_nosync(sigma_delta->irq_num);
 		sigma_delta->irq_dis = true;
 	}
 
@@ -396,7 +396,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 		goto err_unlock;
 
 	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->spi->irq);
+	enable_irq(sigma_delta->irq_num);
 
 	return 0;
 
@@ -414,7 +414,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
 	wait_for_completion_timeout(&sigma_delta->completion, HZ);
 
 	if (!sigma_delta->irq_dis) {
-		disable_irq_nosync(sigma_delta->spi->irq);
+		disable_irq_nosync(sigma_delta->irq_num);
 		sigma_delta->irq_dis = true;
 	}
 
@@ -516,7 +516,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 irq_handled:
 	iio_trigger_notify_done(indio_dev->trig);
 	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->spi->irq);
+	enable_irq(sigma_delta->irq_num);
 
 	return IRQ_HANDLED;
 }
@@ -586,9 +586,9 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	sigma_delta->irq_dis = true;
 
 	/* the IRQ core clears IRQ_DISABLE_UNLAZY flag when freeing an IRQ */
-	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
+	irq_set_status_flags(sigma_delta->irq_num, IRQ_DISABLE_UNLAZY);
 
-	ret = devm_request_irq(dev, sigma_delta->spi->irq,
+	ret = devm_request_irq(dev, sigma_delta->irq_num,
 			       ad_sd_data_rdy_trig_poll,
 			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
 			       indio_dev->name,
@@ -668,6 +668,11 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 		}
 	}
 
+	if (!info->irq_num)
+		sigma_delta->irq_num = spi->irq;
+	else
+		sigma_delta->irq_num = info->irq_num;
+
 	iio_device_set_drvdata(indio_dev, sigma_delta);
 
 	return 0;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 7852f6c9a714..77c3a33e5370 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -45,6 +45,7 @@ struct iio_dev;
  * @data_reg: Address of the data register, if 0 the default address of 0x3 will
  *   be used.
  * @irq_flags: flags for the interrupt used by the triggered buffer
+ * @irq_num: IRQ for reading conversions. If 0, spi->irq will be used
  * @num_slots: Number of sequencer slots
  */
 struct ad_sigma_delta_info {
@@ -59,6 +60,7 @@ struct ad_sigma_delta_info {
 	unsigned int status_ch_mask;
 	unsigned int data_reg;
 	unsigned long irq_flags;
+	unsigned long irq_num;
 	unsigned int num_slots;
 };
 
@@ -87,6 +89,7 @@ struct ad_sigma_delta {
 	unsigned int		active_slots;
 	unsigned int		current_slot;
 	unsigned int		num_slots;
+	unsigned int		irq_num;
 	bool			status_appended;
 	/* map slots to channels in order to know what to expect from devices */
 	unsigned int		*slots;
-- 
2.42.0


