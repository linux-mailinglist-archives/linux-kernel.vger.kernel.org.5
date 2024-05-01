Return-Path: <linux-kernel+bounces-165415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440E08B8C70
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66ABC1C21911
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82C312F580;
	Wed,  1 May 2024 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZrR9QJ7"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806891F176;
	Wed,  1 May 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575963; cv=none; b=IdijetVErK/HhUn/EozeBDwPTkpixWnV9QX2Jas8lsfyJjPXCTnhMIAWFhhlaiVaYjFSMMkXZ1BLtLKWwP+1Nw402vQHdN2pYz2afyqVWADurRFWHtz7h+V3xiVoNopH74NQVj73NVCNmTfSeGUv8M3s5VLgk4gPHyEBZcpd0X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575963; c=relaxed/simple;
	bh=ZwcoVXh6+PU1Qu8+uoknJ6rPtJiNfbVuHlJ8BsHXYqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tz6UJZP0YrnH5RIKI8OZsxIX3HuVNwK9s99S/NGKIeK+9T2l1eYsmfNUnKsV+Zd4ZGykTMC7KS1Ot65TGR00PS//xfzQUeGSM/sCf1PS/a9TQBdvH7lk8ndI2hVPatmSAeV+wuojM8JdArQoVTXRYEYkR10SCKgQxrKCUd7MzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZrR9QJ7; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2df83058d48so57894911fa.1;
        Wed, 01 May 2024 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714575960; x=1715180760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fb5C+Oc43A6y8Mz0LyTdT4dWeHAlemsr8HHVEt5MmiU=;
        b=DZrR9QJ7kn13Z+/kt5/Hny+CgW8udKSowgsKkI8vnlnFjWMtgoWCscLsMwQ20vJSz3
         dTEXbHp/t9qmG29Vt5krBKlu7QCFHvZesdhGEL/KQfQtZhmWjxWsl/4Y+IIau1FWBXVv
         CTyH3P4a4AN90gXUkncA1ruajt5leGLVxPH6ndNk/fW7P6OGi0FtIhwJYrgBZydi2Pvp
         rE4+pJbKqeYogq59hp+i3mJZgwdXo9sgUepQHsWklCN8fgW8oA7oXqA4rSsDslImzy/4
         ZhXlUCJWBU9QUJxYN+0N9/sIHnyyHqhnBa//YfES+eqneSE5UAp8NBPzs+gpALxtJufk
         1pQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714575960; x=1715180760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fb5C+Oc43A6y8Mz0LyTdT4dWeHAlemsr8HHVEt5MmiU=;
        b=ugYeE+x2viOkjJI0f7ZkG2e2DiwbI3AYzbMgZGeWvX2rU5sE2OVoiSY3GsRi5CVEMX
         EMxxZmH9lbqhwepkmLAXe+wRIKF7TzkYVtwIJ0woskLOQwjTs2TmXZSOSuQhGlfk50jz
         kPDbfRLJ0E/JZFC7EqFIAKqbloIF+H5/fubCjyLFPDNttVGiQuPwYBtftX4TVKMGyYTG
         h3K3Hl6zSCD3+0sR8dgy/y3PQAOdHfcrHdWzuFkTCt9Vc2Tdj69gGqk6xm8cqQYP51a2
         67+fY1BqWYh1DhsN7Qx/LrYG37cE0P1pXc6JV4QxR1mapaNwB2wFOL1CpPPIocH2Qe4R
         7D/w==
X-Forwarded-Encrypted: i=1; AJvYcCXgrO1dGT09a9dE780OPk+vxubmty1ACJPO3Q3neF4sSxlFYkERsoMTerl0sjV2ZVNTRowcFFrcaFbJx8j4Xg7Wq0dyOH2S066I7Uta3nZOmYOTVHqngughxqoU1jO1BHsJ9aNBRGHn
X-Gm-Message-State: AOJu0Ywk45MnKDNhrVxz/3qcNOy6JdNg4oG5MC6/KNHxYPdpArZtr3j3
	BjjIhBqSslDl4ljrHgtr0BK6etRhI0h/3iv5zGiTP6Xn60uAydE4
X-Google-Smtp-Source: AGHT+IEvmLsjyKIR3eHEAoH52jjjYcX0cNpyCFmb2VP3y0BOTdMQXrtbKIx9KoVxZ7ALexiwSMj5UA==
X-Received: by 2002:a05:651c:1a07:b0:2df:6524:581a with SMTP id by7-20020a05651c1a0700b002df6524581amr2084004ljb.30.1714575959435;
        Wed, 01 May 2024 08:05:59 -0700 (PDT)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id m17-20020a05600c3b1100b0041b4c293f75sm2493160wms.13.2024.05.01.08.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:05:59 -0700 (PDT)
From: marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Ferland <marc.ferland@sonatest.com>
Subject: [PATCH v2] iio: dac: ad5592r: fix temperature channel scaling value
Date: Wed,  1 May 2024 11:05:54 -0400
Message-Id: <20240501150554.1871390-1-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Ferland <marc.ferland@sonatest.com>

The scale value for the temperature channel is (assuming Vref=2.5 and
the datasheet):

    376.7897513

When calculating both val and val2 for the temperature scale we
use (3767897513/25) and multiply it by Vref (here I assume 2500mV) to
obtain:

  2500 * (3767897513/25) ==> 376789751300

Finally we divide with remainder by 10^9 to get:

    val = 376
    val2 = 789751300

However, we return IIO_VAL_INT_PLUS_MICRO (should have been NANO) as
the scale type. So when converting the raw temperature value to the
'processed' temperature value we will get (assuming raw=810,
offset=-753):

    processed = (raw + offset) * scale_val
              = (810 + -753) * 376
	      = 21432

    processed += div((raw + offset) * scale_val2, 10^6)
              += div((810 + -753) * 789751300, 10^6)
	      += 45015
    ==> 66447
    ==> 66.4 Celcius

instead of the expected 21.5 Celsius.

Fix this issue by changing IIO_VAL_INT_PLUS_MICRO to
IIO_VAL_INT_PLUS_NANO.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
---
Change in v2:
 - Improve commit message as suggested by Jonathan.

 drivers/iio/dac/ad5592r-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 076bc9ecfb49..4763402dbcd6 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -415,7 +415,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 			s64 tmp = *val * (3767897513LL / 25LL);
 			*val = div_s64_rem(tmp, 1000000000LL, val2);
 
-			return IIO_VAL_INT_PLUS_MICRO;
+			return IIO_VAL_INT_PLUS_NANO;
 		}
 
 		mutex_lock(&st->lock);

base-commit: 98369dccd2f8e16bf4c6621053af7aa4821dcf8e
-- 
2.34.1


