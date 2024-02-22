Return-Path: <linux-kernel+bounces-76386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B1285F689
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E091F27413
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0ED4501B;
	Thu, 22 Feb 2024 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdzrpUed"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA48374CF;
	Thu, 22 Feb 2024 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600108; cv=none; b=F8h+OY9jYiKJ8oTZrxt49YdA+oc0NmPoEimT38O0085h93v6lW+u1axgf9EcLdMb1n4rRnGc46RG3E9vgnjbJhyPsmdUEcE3TCiA3pcF2aN4im/F0Uxq6gfYvrng4sKcpFMCv43cMulewFlSJpK2yUgZ4InYn1QwJapJ8r3UsQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600108; c=relaxed/simple;
	bh=ZdU9wBISxOsrpSdFDOijNSWjW/gIn3dQBpoDND5uCLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gV+F6dVvdNL0KAIvVwMMRuP3aEd7jx2YG6iXlHMAme9knm1+W00BC1xExOCCuan8+p4HnP7GA28AXZzsDAsn3wlpXJVrt+MgPix+CwF9WdXYBWy9j//xIWsMYKAUw3JP4RWcOUiZsaRyexg03jq61J+U69BQyMqxkriMq+vXOC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdzrpUed; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-565468bec51so482382a12.1;
        Thu, 22 Feb 2024 03:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708600104; x=1709204904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c9tEavVJwE0s5btrHn1HvDsJcnZmI9yG1XSPH+gBac=;
        b=bdzrpUedmE0B7tUMfD0d4HBZIZgIPI2/Y4o38SCz8BhW1s+p0UmcrFOh6HWOkiETa+
         8/jHOtpVl2RfXW9xn0Xaf+2dAtJim0VY2Al1Stqq/HyQfHbAmPqYWUZJtoa1NFylpYcG
         eMqA8MdpfeiCAvKDqxf07necWPBzn8CfjH/T0mMRrwwTEvYFVTS5NhYhPaYeXaLx4Zbs
         ihN8GeiA/EIht1arGh/OybzxVyk3JG4k/GZ8y+9Ky6BtiHe7VRYNUwkQvBT7jbudHQCl
         4BhNfNPYlNL+fyZOTYaRynPc//FLRjBY0T+ae3Iue+tOfa32e7ur4zW/aFMmbatGwFjx
         8nZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708600104; x=1709204904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3c9tEavVJwE0s5btrHn1HvDsJcnZmI9yG1XSPH+gBac=;
        b=Gc4qX0y3d0QGnEjRSeeK5JxU1ACQiHb5Q8CeyPbo23VeQNxePfckI6tCAdNP+U2woM
         AvWf9BhyxCugrksnRCdBUSGWnHAUYvYg8Y5kBW2yu5ak6HZt06+YHZLsmVI2lhJHh6xv
         2MnF0dcofBFjr1N79y0EMksYq//ejZiuNeIpF211pB2/gDgznNdp2Zt4r+272fIxUnCp
         7NmdWFTFlsr9o0+ltQRAbiyf/UtY0RcIW1sVgFbxkLGV6ee60wv82yQOza4JrGhGzhSx
         Hl0Ov8qt2LX7kB6Q9TxJYgDgo0zwjx5kgEeUijuow9TeevfUNPkNPBnIQjp6ruCzW2GK
         bing==
X-Forwarded-Encrypted: i=1; AJvYcCX9MRlNwwfDvtrEXzywranB3/MWUVlA/HMWLobMD3DmAQueQ9/JD8qsn4r8xnaboOLuLhc7DA+JzBpzNi1k9tTqP9DCNTeKXJvDMjCEGMKJD1gzF4xZ2ZPM27y7WET3tZxsxNr2BtUVoL4YdSgkma9Zbi/4g3yV1ic+eK4KbbxMTFOvY/HuFqjEjwrGHah/fTCSEOskvtjUDuglrLeOrgk=
X-Gm-Message-State: AOJu0YxX1/gcyyEdwReiJ+vKnP1aGWzzs6whCnM/sWAQ74oYZSkxtM+V
	mb57URvQsTmZGKRQC1G+yeGIVeZkFphHuQnrHiWR1cAOfFG66qWvJpQk8z8m0MuGBbRH
X-Google-Smtp-Source: AGHT+IEjUjZQF48QpFskm62wG4Ck4XNSPdZVzRtL63kvWgijBq74TzvzH/z52cqpPigJf7iORgfmWA==
X-Received: by 2002:aa7:c894:0:b0:565:42a4:82ff with SMTP id p20-20020aa7c894000000b0056542a482ffmr830716eds.0.1708600104397;
        Thu, 22 Feb 2024 03:08:24 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([83.103.132.21])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b00563a3ff30basm5786350edi.59.2024.02.22.03.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:08:23 -0800 (PST)
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
Subject: [PATCH v14 2/3] iio: adc: ad_sigma_delta: Add optional irq selection
Date: Thu, 22 Feb 2024 13:07:42 +0200
Message-ID: <20240222110817.29670-2-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240222110817.29670-1-mitrutzceclan@gmail.com>
References: <20240222110817.29670-1-mitrutzceclan@gmail.com>
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
V13->V14
 - Invert logic checking the presence of the optional irq_num attribute
V1->V12
<Not present>

 drivers/iio/adc/ad_sigma_delta.c       | 23 ++++++++++++++---------
 include/linux/iio/adc/ad_sigma_delta.h |  3 +++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 7e2192870743..b814c5fbcb5b 100644
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
 
+	if (info->irq_num)
+		sigma_delta->irq_num = info->irq_num;
+	else
+		sigma_delta->irq_num = spi->irq;
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


