Return-Path: <linux-kernel+bounces-53250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF95C84A2B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A6EB21C42
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C95481CB;
	Mon,  5 Feb 2024 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fczhIVlu"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324E6482C3;
	Mon,  5 Feb 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159024; cv=none; b=FzK2/w9S8nLt1i7UXjRQitOd4O+aIs8KTyfwxXGH/HsneYm4xVwdQP4dcTh/Oebz4WuqvnSubx0BDSTUUC+BkOEDbmVmIDjYoQD8yH90DpVauhm4DsEjaXdGgKMBaQl/d8CIosPKqkaugriF4ww7cSNXTkJGV1hseyPheokehnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159024; c=relaxed/simple;
	bh=Xhujo+wDiMZRhR3TwEcnhYIXAGX+tOaXYwuQFNEDweY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UA2lThwlvvSkO8CL7t22ixDlAINcP7t777OwkTCJ4UlLqXfg5KqwxMFDTmuGFMBYagXB9jWWg5IgDaSSlfmljpq0epDZaf3bROl9tYd3c1rLgNpTriQEwHvzyzl6nBdjYBu8BrEFT9qUKzUkfERSGsxHAG9rve4lcRpcHG4Q2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fczhIVlu; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-599f5e71d85so22402eaf.3;
        Mon, 05 Feb 2024 10:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707159022; x=1707763822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5/QetKatJetZu8QUL35h5FIsCUnt2b4O8Bogdh7dS4=;
        b=fczhIVluWfK1xuswkTnwErAk+mc/BUBKeXF6FkefdyoXj6xrC/HmdWsR7itXA9xBP1
         BQ707M4yOC1eGN/He5ThRm9/vRu552A+x1YTBmU8mtdkmVnhUgwW6VwuvV1f0Mf19NpQ
         bOvp3ljJx3u15JWxs3NtWY5OzXXGdUQJtnBA6389H+2xCQrNv+D+Dqr95cVyr3BozGr6
         mCyNeIbbirtC+wV3yDlcCpFTVY688ZRmgZ3peFxo6952U+fr7DItSp1WlscJ1eJbOuFl
         fFnRq2dx+ksnU6eKzxBIJZKZaB8+s89pkTzPBZGIbUmnmzetZva3vnNoZLgWPOCWlhVB
         aAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159022; x=1707763822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5/QetKatJetZu8QUL35h5FIsCUnt2b4O8Bogdh7dS4=;
        b=hoWDB0CB4/iuCXefH/QZ7NWjueIqTShsBICM9P7/spq6vDW7YG8VwOVyE4wIv8tH3v
         dR3edy07DxDtBol3459wLsd8YrQgHaL4U7NECf+XVvjJaD+QC0EVq23E/I3pCrohz6TL
         jmOCD7ZjpNFmYiWU0XpHmjuUz22DqixQJPH6XUTmN3MCLX/dSDNdh42JYhjSS2lQbR0M
         ojuSt7Hk35SS53Jt904gZezF/VfpgrBX70ljfsRV8uoe04e8hV4hU32VeCo5aybto9us
         OnvqaVaXVSXniUoxv9CufdI3y/ULOLX0wrSvuNdBauAV8gt6RnHz4ReFMOMnnY+HT6M/
         unuw==
X-Gm-Message-State: AOJu0YyibJSTj7L+1vG7v8CHWqPV3yoPpaxAugkKTT+nXpjECPXV8Eol
	TgCOaokFNcuxGBHUZb/vsv0TMCNBSA8ghfp/2ShGIRWfZJsy4yyF
X-Google-Smtp-Source: AGHT+IGdMtsWr1OpAk73Qdb2h2Xh3VJkag4VDyc6etFQCzn0YJKsKWR1PimbbtLuYoStFbba0Frj2g==
X-Received: by 2002:a4a:241d:0:b0:599:49ec:6d15 with SMTP id m29-20020a4a241d000000b0059949ec6d15mr542271oof.1.1707159022108;
        Mon, 05 Feb 2024 10:50:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUhhGoU4pHLpckzL33j+8HDGr+TsjC1gXJaozqI+dj5ji++n55Rbv9euK17brsZ5XaENmpcVnPmXeQyKwE4k+xkTu7UVelm7TNQ8+QmNEdRKzc++XUCK0tbget5H5rQA0d2mCTit3gTYDJTXgCkWfozQZrcb4HL2A5rJEJ6lufiWTkMJw==
Received: from localhost.localdomain (i577B6813.versanet.de. [87.123.104.19])
        by smtp.gmail.com with ESMTPSA id x5-20020a4a8005000000b0059a096ee494sm59382oof.47.2024.02.05.10.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:50:21 -0800 (PST)
From: Jesus Gonzalez <jesusmgh@gmail.com>
To: andriy.shevchenko@linux.intel.com,
	jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesus Gonzalez <jesusmgh@gmail.com>
Subject: [PATCH v2 1/1] Add 10EC5280 to bmi160_i2c ACPI IDs to allow binding on some devices
Date: Mon,  5 Feb 2024 19:36:20 +0100
Message-ID: <20240205183618.7761-3-jesusmgh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZcDnikkiwSIDGzT0@smile.fi.intel.com>
References: <ZcDnikkiwSIDGzT0@smile.fi.intel.com>
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

Here is the relevant extract from the DSDT of a GPD Win Max 2 (AMD 6800U
model) with the latest firmware 1.05 installed. GPD sees this as WONTFIX
with the argument of the device working with the Windows drivers.

     Scope (_SB.I2CC)
    {
        Device (BMA2)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Name (_HID, "10EC5280")  // _HID: Hardware ID
            Name (_CID, "10EC5280")  // _CID: Compatible ID
            Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
            Name (_UID, One)  // _UID: Unique ID
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2CC",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                })
                Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
            }

            OperationRegion (CMS2, SystemIO, 0x72, 0x02)
            Field (CMS2, ByteAcc, NoLock, Preserve)
            {
                IND2,   8, 
                DAT2,   8
            }

            IndexField (IND2, DAT2, ByteAcc, NoLock, Preserve)
            {
                Offset (0x74), 
                BACS,   32
            }

            Method (ROMS, 0, NotSerialized)
            {
                Name (RBUF, Package (0x03)
                {
                    "0 -1 0", 
                    "-1 0 0", 
                    "0 0 1"
                })
                Return (RBUF) /* \_SB_.I2CC.BMA2.ROMS.RBUF */
            }

            Method (CALS, 1, NotSerialized)
            {
                Local0 = Arg0
                If (((Local0 == Zero) || (Local0 == Ones)))
                {
                    Return (Local0)
                }
                Else
                {
                    BACS = Local0
                }
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }
        }
    }

Signed-off-by: Jesus Gonzalez <jesusmgh@gmail.com>
---
v2 patch implementing the improvements mentioned by Mr. Cameron and Mr.
Shevchenko, if I understood them correctly. Please tell me if anything
else should be changed, and I'll be happy to make a new revision.

Thank you!


 drivers/iio/imu/bmi160/bmi160_spi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index 8b573ea99af2..f88d4b2ba79b 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -40,6 +40,14 @@ static const struct spi_device_id bmi160_spi_id[] = {
 MODULE_DEVICE_TABLE(spi, bmi160_spi_id);
 
 static const struct acpi_device_id bmi160_acpi_match[] = {
+	/* FIRMWARE BUG WORKAROUND
+	 * Some manufacturers like GPD, Lenovo or Aya used the incorrect
+	 * ID "10EC5280" for bmi160 in their DSDT. A fixed firmware is not
+	 * available as of Feb 2024 after trying to work with OEMs, and
+	 * this is not expected to change anymore since at least some of
+	 * the affected devices are from 2021/2022.
+	 */
+	{"10EC5280", 0},
 	{"BMI0160", 0},
 	{ },
 };
-- 
2.43.0


