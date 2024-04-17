Return-Path: <linux-kernel+bounces-148207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A328A7F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D9B1C21CED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A41812CD98;
	Wed, 17 Apr 2024 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HW1/Z8r7"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484780C04
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345099; cv=none; b=AhGztsorLEsANoynOVMloFwYfRjUvtYGsOxJhpRNXa3b0KXQpBrSoxyHDYtbnvkCLxql+DIfjMpbL9gIw0zJKdVPZcOZrjd8rkHLutbyCH58jab+Lm4bwnDoBXPI9jjkCChUTimUpMxNK8MY2MGTVKrlDfNvo5whsnPdIi0xGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345099; c=relaxed/simple;
	bh=4so/DjICniai2gy4hPDEymiB2k6AzqH3UPSdcy4I48A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FtU8FG6MJDo8QheRC758GglzhglBuHnNSvwEEUMptleHZV0jZjOmebijDJ/wfsRO9WnRLfB6iO8nlZXg7pRlixDUb2hy2ETEcVtf/1pnpSJtsp2iThoEji9vzcjWvhGbqd+MeSepE8MVoHut8IfYwjHdq087CWVA7vffY1bp32I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HW1/Z8r7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-418798199a2so16811295e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713345095; x=1713949895; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yUCwpFSVZ5ZYfrY/Hj6Ptc7bsuAxiwe1379MgwwwhAU=;
        b=HW1/Z8r7o/ZI+FHbJPdphDRtWVvglg3w+0TpiHNGcT16uazOB6EXyP7x/e/Y8Cqo+V
         3KOY9hW1H/YqPPmqLwR09Hkn/Q6GD1+JsKaVbYJlgHTQy4CTf81sFJAq4BYzn5SAivLY
         jMbeBLDD7NHIrRzjO+SmHC25lTvi+NYRicXS39AVCartbdmFBWi4yImty7Y3Bo2wHOu7
         ideTQGQzdpIzR3XqNSr2J5QjwOmNJQPO6AtgLicmfRd/4DF3AlTwwnvMOKP38+7Ln5RX
         pdbVHKv3lkQXNsbbE8tPsVaKXEKgLX0i9pjIjWjP+gt9t1OPSTjJ+b0ORvX+Pa2tlQRd
         VW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713345095; x=1713949895;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUCwpFSVZ5ZYfrY/Hj6Ptc7bsuAxiwe1379MgwwwhAU=;
        b=L5EuQ0xTpyF3mldAL1maBbl1dkYaHapiXGkdcI3+uXEg4Q8RAfgNWrsa3C7BcONjjq
         oV7WVUHTDWfxKFbLCxM/DnhZuhUNHunzX2KayWfogDW5YbO6JUo4Cs8kzW3T+EdYk8iK
         //SVpdCuK25jt38n8NPEkD2S4kXavXt4Ev4kn0oZe4Ml+90F3upZotMUgGVjdWhcWrIu
         ny3ZQH5mGcDQtZwWloutPQTBejKTuq4Wfdw/uwITY9zndEGYxTwWniEYvHZtycw5jL8J
         RAvaBI5DtVwQZtFhEDi6LGhcBPpDh9t67MbrONWIk1rp872/rvYvUK3XW/CfJxlnF7nm
         eDzA==
X-Forwarded-Encrypted: i=1; AJvYcCX0ie1hBYO4a/mbNgrF1AFlr7L6sQ4X6CnG4U6Y8k000Yu3al1IwQK7hy6a9XK6pWFHkKhtd59u11BCYcBiiICMxhhiQZ7u/DPi+SCK
X-Gm-Message-State: AOJu0Yz2QO1DWZJZwPn60BAGhpOX9O2YyIqOS/dQbLCv0+FshPaw8cGs
	MhcSVdhiw86xpteOyx/fNWeviGCFtZKS4evUC/nwHRQLZyZuglDPIuT3yVRGQcv9uIfBzG8HlBY
	BeNg=
X-Google-Smtp-Source: AGHT+IFU8r/UI/9hCdniBuP0TJ45VTWKaw1knMQeFdI7wHl3H/f+PGMgrqbFO++tjjzEzEORH8Mnjg==
X-Received: by 2002:a05:600c:46c9:b0:418:d6e:9536 with SMTP id q9-20020a05600c46c900b004180d6e9536mr9899661wmo.6.1713345095359;
        Wed, 17 Apr 2024 02:11:35 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c351500b004186405a95esm1982248wmq.21.2024.04.17.02.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 02:11:35 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Wed, 17 Apr 2024 09:11:18 +0000
Subject: [PATCH] iio: adc: ad7606: remove frstdata check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-cleanup-ad7606-v1-1-5c2a29662c0a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADWSH2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0Mz3eSc1MS80gLdxBRzMwMzXUMzw1Sj1BRLC0OLJCWgpoKi1LTMCrC
 B0bG1tQDo3breYAAAAA==
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 jstephan@baylibre.com, dlechner@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713345094; l=3771;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=4so/DjICniai2gy4hPDEymiB2k6AzqH3UPSdcy4I48A=;
 b=V3xArsmCclp956TCoDgJ0jlbEZjzEr2URthxzrmi5AtbfJ25S/TK+QhGQeDkxNDJvcNLuGfV0
 m+f0AxC/AjPCYUmu19LNHraVEYQO/y4PuQfVAKi29FdAJJTnyMJp7B9
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Frstdata pin is set high during the first sample's transmission and
then set low.
This code chunk attempts to recover from an eventual glitch in the clock
by checking frstdata state after reading the first channel's sample.
Currently, in serial mode, this check happens AFTER the 16th pulse, and if
frstdata is not set it resets the device and returns EINVAL.
According to the datasheet, "The FRSTDATA output returns to a logic low
following the 16th SCLK falling edge.", thus after the 16th pulse, the check
will always be true, and the driver will not work as expected.
Even if it was working, the usefulness of this check is limited, since
it would only detect a glitch on the first channel, but not on the
following ones, and the convst pulse will reset the communication sequence at
each new conversion.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
This is the first commit of cleanup series. It will be followed by more
cleanups and support for more parts and features.
---
 drivers/iio/adc/ad7606.c | 30 ------------------------------
 drivers/iio/adc/ad7606.h |  3 ---
 2 files changed, 33 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 1928d9ae5bcf..f85eb0832703 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -88,31 +88,6 @@ static int ad7606_read_samples(struct ad7606_state *st)
 {
 	unsigned int num = st->chip_info->num_channels - 1;
 	u16 *data = st->data;
-	int ret;
-
-	/*
-	 * The frstdata signal is set to high while and after reading the sample
-	 * of the first channel and low for all other channels. This can be used
-	 * to check that the incoming data is correctly aligned. During normal
-	 * operation the data should never become unaligned, but some glitch or
-	 * electrostatic discharge might cause an extra read or clock cycle.
-	 * Monitoring the frstdata signal allows to recover from such failure
-	 * situations.
-	 */
-
-	if (st->gpio_frstdata) {
-		ret = st->bops->read_block(st->dev, 1, data);
-		if (ret)
-			return ret;
-
-		if (!gpiod_get_value(st->gpio_frstdata)) {
-			ad7606_reset(st);
-			return -EIO;
-		}
-
-		data++;
-		num--;
-	}
 
 	return st->bops->read_block(st->dev, num, data);
 }
@@ -450,11 +425,6 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 	if (IS_ERR(st->gpio_standby))
 		return PTR_ERR(st->gpio_standby);
 
-	st->gpio_frstdata = devm_gpiod_get_optional(dev, "adi,first-data",
-						    GPIOD_IN);
-	if (IS_ERR(st->gpio_frstdata))
-		return PTR_ERR(st->gpio_frstdata);
-
 	if (!st->chip_info->oversampling_num)
 		return 0;
 
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 0c6a88cc4695..eacb061de6f8 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -80,8 +80,6 @@ struct ad7606_chip_info {
  * @gpio_range		GPIO descriptor for range selection
  * @gpio_standby	GPIO descriptor for stand-by signal (STBY),
  *			controls power-down mode of device
- * @gpio_frstdata	GPIO descriptor for reading from device when data
- *			is being read on the first channel
  * @gpio_os		GPIO descriptors to control oversampling on the device
  * @complete		completion to indicate end of conversion
  * @trig		The IIO trigger associated with the device.
@@ -108,7 +106,6 @@ struct ad7606_state {
 	struct gpio_desc		*gpio_reset;
 	struct gpio_desc		*gpio_range;
 	struct gpio_desc		*gpio_standby;
-	struct gpio_desc		*gpio_frstdata;
 	struct gpio_descs		*gpio_os;
 	struct iio_trigger		*trig;
 	struct completion		completion;

---
base-commit: 62d3fb9dcc091ccdf25eb3b716e90e07e3ed861f
change-id: 20240416-cleanup-ad7606-161e2ed9818b

Best regards,
-- 
Guillaume Stols <gstols@baylibre.com>


