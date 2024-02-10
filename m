Return-Path: <linux-kernel+bounces-60444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA05850505
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA011F22F17
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158FB5C03D;
	Sat, 10 Feb 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+l5UQja"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC295B69C;
	Sat, 10 Feb 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707580943; cv=none; b=OYmzP6GSJ7gVModYq4j1hdvRKy3q0UCUYK+8NpBOYzDxyrb1AF+MUUjuBJowalZjHEygeSOlpVSm9lXu3n/oWrUOqisXmK5qHXbFZ7givA1XtBty/RF+FLvga5B+8LViu8x76UULf5jjJ3JOosGlz/s0ycbJ3v4EO2Sr5cwBbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707580943; c=relaxed/simple;
	bh=OJzXw3Ds337hCBpyFZS8yQw7PPY+pMe8+OVAJ3/GEiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7REHdmflc5ytykt9cunT5WKylcXGwx8sXk+TWQrVVltEEAEePLOLAbP/exdrR/O6JWM3Pat+deUmgUe71RrKoSI0VrnUhY9TO6q/+kHpYsV1sjk/L3fIaK0wStxr/bOBEAXk55Qz8JW0qTnU7HbzwVgNVWZcPuqcSyEARFsA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+l5UQja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95A4C433C7;
	Sat, 10 Feb 2024 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707580942;
	bh=OJzXw3Ds337hCBpyFZS8yQw7PPY+pMe8+OVAJ3/GEiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H+l5UQjaSuCvsq3TbM/1CMjRayMNZszaahPc/lWGmsJuwvsltSsHmI+Uq1aGLCj8h
	 8bcpeZUz5VaopkFyelJkSrGT9Gufy2QA+eVXiwseFJxAc+JYqHzjQMK/bzC8sES3bt
	 amL+xIiIvvVjkm0wReIJWVgG8+SGGEvMB9AvXoaBMgl0C+jUb0MaFGpmLyEhDBVoW5
	 e5PvFDT0k1h51jyLF1x6XTTdQ7q3UqNwfpdFPYkSZdmj28yG6rLp6Wgzdvo0lwzbDH
	 Mo0S3ERWq0mWTuW0wUN/c+72ddAb/pAmZHn4MPNdc18fO3GtLwh4cgA8jIBVkrS8d5
	 HhRTB0fq8WbRg==
Date: Sat, 10 Feb 2024 16:02:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jesus Gonzalez <jesusmgh@gmail.com>
Cc: andriy.shevchenko@linux.intel.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Add 10EC5280 to bmi160_i2c ACPI IDs to allow
 binding on some devices
Message-ID: <20240210160210.65bb2c95@jic23-huawei>
In-Reply-To: <20240207195549.37994-2-jesusmgh@gmail.com>
References: <ZcOLql2RGmPP10EY@smile.fi.intel.com>
	<20240207195549.37994-2-jesusmgh@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 20:55:50 +0100
Jesus Gonzalez <jesusmgh@gmail.com> wrote:

> "10EC5280" is used by several manufacturers like Lenovo, GPD, or AYA (and
> probably others) in their ACPI table as the ID for the bmi160 IMU. This
> means the bmi160_i2c driver won't bind to it, and the IMU is unavailable
> to the user. Manufacturers have been approached on several occasions to
> try getting a BIOS with a fixed ID, mostly without actual positive
> results, and since affected devices are already a few years old, this is
> not expected to change. This patch enables using the bmi160_i2c driver for
> the bmi160 IMU on these devices.
> 
> Here is the relevant extract from the DSDT of a GPD Win Max 2 (AMD 6800U
> model) with the latest firmware 1.05 installed. GPD sees this as WONTFIX
> with the argument of the device working with the Windows drivers.
> 
> 	Device (BMA2)
> 	{
> 	    Name (_ADR, Zero)  // _ADR: Address
> 	    Name (_HID, "10EC5280")  // _HID: Hardware ID
> 	    Name (_CID, "10EC5280")  // _CID: Compatible ID
> 	    Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
> 	    Name (_UID, One)  // _UID: Unique ID
> 	    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> 	    {
> 		Name (RBUF, ResourceTemplate ()
> 		{
> 		    I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
> 		        AddressingMode7Bit, "\\_SB.I2CC",
> 		        0x00, ResourceConsumer, , Exclusive,
> 		        )
> 		})
> 		Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
> 	    }
> 	    
> 	    ...
> 	    
> 	}
> 
> Signed-off-by: Jesus Gonzalez <jesusmgh@gmail.com>
For future reference don't send a new version in reply to the old one.
It makes a big mess in many people's email clients
if we get lots of versions.  The patch naming is enough to associate
the different versions.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to take a look at it.

Thanks,

Jonathan

> ---
> v4: Moved comment back to relevant position inside function
> 
>  drivers/iio/imu/bmi160/bmi160_i2c.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
> index 81652c08e644..a081305254db 100644
> --- a/drivers/iio/imu/bmi160/bmi160_i2c.c
> +++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
> @@ -43,6 +43,15 @@ static const struct i2c_device_id bmi160_i2c_id[] = {
>  MODULE_DEVICE_TABLE(i2c, bmi160_i2c_id);
>  
>  static const struct acpi_device_id bmi160_acpi_match[] = {
> +	/*
> +	 * FIRMWARE BUG WORKAROUND
> +	 * Some manufacturers like GPD, Lenovo or Aya used the incorrect
> +	 * ID "10EC5280" for bmi160 in their DSDT. A fixed firmware is not
> +	 * available as of Feb 2024 after trying to work with OEMs, and
> +	 * this is not expected to change anymore since at least some of
> +	 * the affected devices are from 2021/2022.
> +	 */
> +	{"10EC5280", 0},
>  	{"BMI0160", 0},
>  	{ },
>  };


