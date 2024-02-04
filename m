Return-Path: <linux-kernel+bounces-51686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001C9848E3C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90792843B2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A11225A4;
	Sun,  4 Feb 2024 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZG18/A7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AE224DF;
	Sun,  4 Feb 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707055224; cv=none; b=mCka1B9KRP8aRC6NKAz/nbVIfEvGQ2jqb0K3Hlgw2BlkWOyg8PZPy8hIxOPnx1C3z1MzxRF4sX5VBBNNdpgQ8KsNp65snhxYh+0bFqRh5c3wIQ4ZlTqpKwf4ASTtqerYhKHe8thylqq24HrkyP5uCF8xu1XYuonYSuEzLgsfupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707055224; c=relaxed/simple;
	bh=+GbbwUe7Q/ClATrUhODZyGj8Pxv7kTwf0nLJ4c8so2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K48bVjbioR7zxtVOaVBvW+EUfMQBMjhw+V94ViYGrrQokH0RvjqtBOH0wB4g6xsIFQ3+1C0QFDiP4WLeR937dQS92TcDJq0386jhRzXa1vIc+HeaDcSv3o/4KwXanEgYoEFVXwGsb+nH8B1aF3ZwOIy3b13UfdP3SG5AkWj5r4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZG18/A7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCDDC43390;
	Sun,  4 Feb 2024 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707055224;
	bh=+GbbwUe7Q/ClATrUhODZyGj8Pxv7kTwf0nLJ4c8so2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kZG18/A7pATcoA7ozOqMJrduF5tXbE9xArqvMAIOJUTfOu//omK3EHrMvIi2WaA+b
	 9OllZmyZsjRz3U5ALKGQZGCJUorupiVv3PxLBUJJGXTcdiSENbk5LGZuyQvtgW70tl
	 O6+O4JBJ4T8vDteylY5clKCVQfodca/23VXKXPDk2h2edthKCPW7ihXPzLxfACJLPy
	 QLrTuiowESJpIqQExq6zR74a6QxtwCBrRB0iVEyyCNcwFXXtM4xgx6lom01z/CtxLn
	 MPUoqUMltP3TniYqfbBNm8XJQMzZRtOMxrVfzAhYOIk9fKxPb4DJZeyYaSsOLZ/t4f
	 bFzI6kfE1hR2A==
Date: Sun, 4 Feb 2024 14:00:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jesus Gonzalez <jesusmgh@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/1] Add 10EC5280 to bmi160_i2c ACPI IDs to allow
 binding on some devices
Message-ID: <20240204140010.7edaa782@jic23-huawei>
In-Reply-To: <20240202173040.26806-2-jesusmgh@gmail.com>
References: <20240202173040.26806-2-jesusmgh@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Feb 2024 18:30:41 +0100
Jesus Gonzalez <jesusmgh@gmail.com> wrote:

> "10EC5280" is used by several manufacturers like Lenovo, GPD, or AYA (and 
> probably others) in their ACPI table as the ID for the bmi160 IMU. This 
> means the bmi160_i2c driver won't bind to it, and the IMU is unavailable 
> to the user. Manufacturers have been approached on several occasions to 
> try getting a BIOS with a fixed ID, mostly without actual positive 
> results, and since affected devices are already a few years old, this is 
> not expected to change. This patch enables using the bmi160_i2c driver for 
> the bmi160 IMU on these devices.
Hi Jesus,

https://lore.kernel.org/lkml/CAHp75Vct-AXnU7QQmdE7nyYZT-=n=p67COPLiiZTet7z7snL-g@mail.gmail.com/
Lays out what Andy (and for that matter I) consider necessary for such
a patch.

In short, we want to see devices called out here - with a DSDT section.
+ a clear comment in the code.

The big problem here is this tramples on Realtech's ID space. It's not just
a made up code (incidentally the BMI0160 isn't valid either),
it's a valid code but for an entirely different (PCI) device.

So we need as much info as possible in the patch description and the driver
itself to justify carrying this.   Tempting to add a firmware bug taint on
it as well but that might scare people :)

Jonathan


> 
> Signed-off-by: Jesus Gonzalez <jesusmgh@gmail.com>
> ---
> A device-specific transformation matrix can then be provided in a second
> step through udev hwdb.
> 
> This has been discussed before in 2021, see here:
> https://lore.kernel.org/lkml/CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com/
> 
> Lenovo, as an example of a big manufacturer, is also using this ID:
> https://www.reddit.com/r/linux/comments/r6f9de/comment/hr8bdfs/?context=3
> 
> At least some discussions with GPD took place on the GPD server Discord,
> for which I can provide proof on demand via screenshot (if not accessible
> directly).
> 
> I have read the patch submission instructions and followed them to the
> best of my knowledge. Still, this is my first kernel patch submission,
> so I'd be glad if you could please point out any mistakes. Thank you!
> 
> 
>  drivers/iio/imu/bmi160/bmi160_spi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
> index 8b573ea99af2..0874c37c6670 100644
> --- a/drivers/iio/imu/bmi160/bmi160_spi.c
> +++ b/drivers/iio/imu/bmi160/bmi160_spi.c
> @@ -41,6 +41,7 @@ MODULE_DEVICE_TABLE(spi, bmi160_spi_id);
>  
>  static const struct acpi_device_id bmi160_acpi_match[] = {
>  	{"BMI0160", 0},
> +	{"10EC5280", 0},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);


