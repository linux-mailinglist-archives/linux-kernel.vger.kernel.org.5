Return-Path: <linux-kernel+bounces-50241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEAF84762E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9D51F2E2B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0C314A4FF;
	Fri,  2 Feb 2024 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3jbOXkN"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F7F14A0A5;
	Fri,  2 Feb 2024 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895170; cv=none; b=SkOJDRAqQzzrhxR67Lptm+2LlEIvXjRfy09F8+m/7LoXcMy6464ujMeLx3Z4zxMpO4QuH8SCOBvq9PQvzSujIIvbFEnMP3caV9c470gXzFCPQUjFB4OuTs4KNCSVsPuA7hIlWwwj6UPXrkIbfPkBbcU6TOkd+OBkrOjStlFdh3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895170; c=relaxed/simple;
	bh=BzeGSQFv23RzxfnxCCVXJrwUwm5DgaTHVJ5SPJupBPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QlhRA+o4r2qjOt5Q3+AZYlB985ryljkl8pDsxza4tNHM7sGJrDHRCJyUijrpACWlp69I0BCq38eyZwKq9eAr3INfA0e6QIfInajQpvOJyAkAxBEGFuHHRwmCGGHUxx8hiOr4uIbJg9Es1kJZFUiympNK0Wsz9yL+P5hixfzPqk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3jbOXkN; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42c0960382eso2125121cf.2;
        Fri, 02 Feb 2024 09:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706895167; x=1707499967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MZV5kKfu43pg+P1nwDSu3FuOWtizR/h4o6gwCwbwjx0=;
        b=M3jbOXkNsdO8TCSCabw+nMRZrlGzAg9DsePuLa3KLotbB8uZ3cZFCLyUp/i3dufOfd
         U3s57kcYqcJ6hQVRz5Fc9O56jGcBjzPh+GwUL9m94SQnaLkqbEuaz+rF3ZS8lFP5HO5a
         AwCrhiOPeQnqzbX1J5ojvLvzu9UKvmWNAfynxoLSIO8DODN76AAAHBmnME1g8UXdvf6a
         1bwvZtpYNKXM8OGxwmxP3fGPopm8tEHm3pregfCDVrrNH7oVwIgwFdyapyhtgvjbeKGz
         VFFzMI11ccBuFyHloDZT9lOhXmI3+l0dagqjeQzwksQo8jvlCzeVAAh7CJlW5fKBvmfT
         xwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895167; x=1707499967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZV5kKfu43pg+P1nwDSu3FuOWtizR/h4o6gwCwbwjx0=;
        b=MkeBI+mumtC1nJWBh6DwPWvlJafDEMIdBWGU5sD4JHb4p2gtrLEiuT0UnkXXAT/Fl/
         619ReTzIrGONXpJLrWTWAlsdjieyAlsXbndJLashwQNNnqnAQgyFH+BFoVwu5x/v2bHy
         8Kzv9e1ihtc39xrxSLhJtnl52KFeyys2/AFcxHyntCQDQtyhQXGOcDBk4vF6tOnZipw6
         lw9wSiTGPb2laWGrinOW3VVSZhG8AnbunTBSAhk2Nx0sAKVM2M2N2MkfFVVgNTIN3myD
         qi00caCXReaX5aJ46BBmdAXIvM6dsgX1fAU+SYHzcJCv45fRjptuuqI/9XUWFXAl1RDY
         YyTA==
X-Gm-Message-State: AOJu0YyUISn3p0KdDzDAQkYOYCHoNBsFW1HmDQG8yBd7KB3zxCmS9nex
	XrmEuHKX/mCPxD8o2FMvpdTZ0ixiQOdFDUt4L5xchGaEPupU0kyb
X-Google-Smtp-Source: AGHT+IFVw807y6m6f3FbmT7i6pT8mjFZXnvSiS4/VfgCKVuaoL7QhTGaS0X35ZTSkOeIVqLoArpbew==
X-Received: by 2002:ac8:5890:0:b0:42c:c7:ffe5 with SMTP id t16-20020ac85890000000b0042c00c7ffe5mr2836282qta.68.1706895166925;
        Fri, 02 Feb 2024 09:32:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX219F2y8peI5Q69R1Y+U1liVUJWjjCJsy/DuLn0zTq93lrH2hDuWmGCKJjgn/yP6MIz4mML3euTvsr3kxlkVMOpKCvJUEWW4inGk1W4v4KhHuymhivwEf+E2ME4iS1nslV9WbpGPPOBkF3ClCilwjWww==
Received: from localhost.localdomain (i577B69E4.versanet.de. [87.123.105.228])
        by smtp.gmail.com with ESMTPSA id cc22-20020a05622a411600b0042be0933c1csm1006890qtb.15.2024.02.02.09.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:32:46 -0800 (PST)
From: Jesus Gonzalez <jesusmgh@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesus Gonzalez <jesusmgh@gmail.com>
Subject: [PATCH 1/1] Add 10EC5280 to bmi160_i2c ACPI IDs to allow binding on some devices
Date: Fri,  2 Feb 2024 18:30:41 +0100
Message-ID: <20240202173040.26806-2-jesusmgh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"10EC5280" is used by several manufacturers like Lenovo, GPD, or AYA (and 
probably others) in their ACPI table as the ID for the bmi160 IMU. This 
means the bmi160_i2c driver won't bind to it, and the IMU is unavailable 
to the user. Manufacturers have been approached on several occasions to 
try getting a BIOS with a fixed ID, mostly without actual positive 
results, and since affected devices are already a few years old, this is 
not expected to change. This patch enables using the bmi160_i2c driver for 
the bmi160 IMU on these devices.

Signed-off-by: Jesus Gonzalez <jesusmgh@gmail.com>
---
A device-specific transformation matrix can then be provided in a second
step through udev hwdb.

This has been discussed before in 2021, see here:
https://lore.kernel.org/lkml/CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com/

Lenovo, as an example of a big manufacturer, is also using this ID:
https://www.reddit.com/r/linux/comments/r6f9de/comment/hr8bdfs/?context=3

At least some discussions with GPD took place on the GPD server Discord,
for which I can provide proof on demand via screenshot (if not accessible
directly).

I have read the patch submission instructions and followed them to the
best of my knowledge. Still, this is my first kernel patch submission,
so I'd be glad if you could please point out any mistakes. Thank you!


 drivers/iio/imu/bmi160/bmi160_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index 8b573ea99af2..0874c37c6670 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -41,6 +41,7 @@ MODULE_DEVICE_TABLE(spi, bmi160_spi_id);
 
 static const struct acpi_device_id bmi160_acpi_match[] = {
 	{"BMI0160", 0},
+	{"10EC5280", 0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
-- 
2.43.0


