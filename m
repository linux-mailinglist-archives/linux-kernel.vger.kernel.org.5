Return-Path: <linux-kernel+bounces-52374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C542849740
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3481C22719
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E5A13AFB;
	Mon,  5 Feb 2024 10:03:10 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0617541;
	Mon,  5 Feb 2024 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127389; cv=none; b=rpqexQJUTygbUG9qaxl4UYL8LehJV+eAWm+I7KOQrtocq9obZfdxUbHT/+PhsakMPwv5T/B6QM28w02ZaruwG6CiE8NDwd0V7cXNvipPOG+K9uNICscgCpOWUvhRtvjrSta3MtNh7V76PBEXhJhw9DivubOq8OvxwpQL0qhUl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127389; c=relaxed/simple;
	bh=Ge0NE6CW5HB9v5jkMGVl5Gbq/LXrWPVFAPxqAtVHuHk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIAbRbX8eDafd+AUmIyYHqFOWVmmIhGrUG+v1meZKM9+trjInqvl+utRMYdj9XXUh50oaAdDt2HN/M9lZxFpW0gahYuk67YAo6GMXbI0s/4Z3ZzggTrtNbs6q1fjf+OdiZ7BcivP9Z0khYSknsCcGf0h/hHpPyd028opQGruwnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT21431cJz6GBWg;
	Mon,  5 Feb 2024 17:59:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CF6B140D26;
	Mon,  5 Feb 2024 18:03:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 5 Feb
 2024 10:02:59 +0000
Date: Mon, 5 Feb 2024 10:02:58 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jesus Gonzalez <jesusmgh@gmail.com>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Add 10EC5280 to bmi160_i2c ACPI IDs to allow
 binding on some devices
Message-ID: <20240205100258.00003e0f@Huawei.com>
In-Reply-To: <20240204180536.30617-2-jesusmgh@gmail.com>
References: <20240204140010.7edaa782@jic23-huawei>
	<20240204180536.30617-2-jesusmgh@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun,  4 Feb 2024 19:05:37 +0100
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
> Signed-off-by: Jesus Gonzalez <jesusmgh@gmail.com>
Make sure to include v2 in the patch title.  
git format-patch -v2 ...

+ as per other reply, I'd like to see more info in here including the
DSDT blob.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/bmi160/bmi160_spi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
> index 8b573ea99af2..0df961a129bb 100644
> --- a/drivers/iio/imu/bmi160/bmi160_spi.c
> +++ b/drivers/iio/imu/bmi160/bmi160_spi.c
> @@ -41,6 +41,14 @@ MODULE_DEVICE_TABLE(spi, bmi160_spi_id);
>  
>  static const struct acpi_device_id bmi160_acpi_match[] = {
>  	{"BMI0160", 0},
> +	/* FIRMWARE BUG WORKAROUND
> +	 * Some manufacturers like GPD, Lenovo or Aya used the incorrect
> +	 * ID "10EC5280" for bmi160 in their DSDT. A fixed firmware is not
> +	 * available as of Feb 2024 after trying to work with OEMs, and
> +	 * this is not expected to change anymore since at least some of
> +	 * the affected devices are from 2021/2022.
> +	 */
> +	{"10EC5280", 0},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);


