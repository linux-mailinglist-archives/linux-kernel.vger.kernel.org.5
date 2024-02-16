Return-Path: <linux-kernel+bounces-68521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7BF857BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5D91C23C51
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FEE7764F;
	Fri, 16 Feb 2024 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5HOEDXs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBEB627FF;
	Fri, 16 Feb 2024 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082964; cv=none; b=hTPYIz9HjRxXkBNmCjTKTqioNgr+NPiXkZwc4VkhxePKjLx97hCZ7XZIR41h7PDsuRIA4djmrsB+TPKc4k8nJKqL2DztN868OqNBDDPKctqp/ZHaMK+mQTJbgOhSj/a1xsFW6HvGCMlUlL4TtpUz8QvN+2+cmSLVMBPPvA0h2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082964; c=relaxed/simple;
	bh=LaKs5DqAuKaU3encHBxSEltA7O1irPZqnTol1trVLEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MClMKFJc4JqZBkk9+QuE+ACFQVRkywG/vCRFq0k58inlm2rNV+dZmaBLAkIqqP4+IIu7W3n3v06fPsF1h8JMwI9Qycjd+CoFF4+Dn5VCu8RhY1enl3+XnCmhEc0szHXMVaykKJJOfgEbCSfJRM7F0Wt/bfZK7zov6jfGmLyRGws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5HOEDXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68980C433B2;
	Fri, 16 Feb 2024 11:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708082964;
	bh=LaKs5DqAuKaU3encHBxSEltA7O1irPZqnTol1trVLEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I5HOEDXs4RGYSouKlxxc0vt7BLbZGIAj31GCowFh0QUM9Vk5PvFYU/luROXnSbWo3
	 et5ArAltsZKlKwWWwB/uP+eDRd3i5VxvGQ1xNbTn7tzYVegk4CbuPzE6JRrJQEoHmW
	 iOfLz0EoBtJGuTM0JaC0mDhSoD5IkVWYkCKrU4ceAUxprUNK7VB74KLkS0u2vbVhKx
	 iONu4FBGFgdEKFSwsVEH27VY/VV+To12D6I5msl7cIEJ8vzs1H7REN7S3MYJIZWLOP
	 lc69mS1uXXeJX99cNtgOlS0yy/PXlqiEfwIfHzqTyW6EVx6WT+qhvhHFNHKeroKfaU
	 Ogb9QsWfW0F/A==
Date: Fri, 16 Feb 2024 11:29:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 thomas.haemmerle@leica-geosystems.com
Subject: Re: [RESEND PATCH 2/2] iio: temperature: tmp117: add support for
 vcc-supply
Message-ID: <20240216112910.4059a09b@jic23-huawei>
In-Reply-To: <20240216102820.1395815-2-m.felsch@pengutronix.de>
References: <20240216102820.1395815-1-m.felsch@pengutronix.de>
	<20240216102820.1395815-2-m.felsch@pengutronix.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 11:28:20 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
> 
> Add support to specify the VCC supply which is required to power the
> device.
> 
> Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Hi.

With power supply enables, the question that normally comes up is whether
the device takes significant time to become available after the power is
turned on.

I had a look at the datasheet but couldn't find clear language on
how long we need to wait before the device is usable following power up.
There is a number for reset of 1.5 msecs so I guess we could use that
safely?

Maybe no delay is fine for reading the device ID. I've no idea.
Sometimes we start with no delay and only end up adding one later when
people report issues.  We could do that here.

Jonathan

> ---
> Resend since I forgot to add the DT maintainers
> 
>  drivers/iio/temperature/tmp117.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
> index 059953015ae7..69328066811a 100644
> --- a/drivers/iio/temperature/tmp117.c
> +++ b/drivers/iio/temperature/tmp117.c
> @@ -17,6 +17,7 @@
>  #include <linux/kernel.h>
>  #include <linux/limits.h>
>  #include <linux/property.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include <linux/iio/iio.h>
>  
> @@ -152,6 +153,10 @@ static int tmp117_probe(struct i2c_client *client)
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>  		return -EOPNOTSUPP;
>  
> +	ret = devm_regulator_get_enable(&client->dev, "vcc");
> +	if (ret)
> +		return ret;
> +
>  	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
>  	if (dev_id < 0)
>  		return dev_id;


