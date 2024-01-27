Return-Path: <linux-kernel+bounces-41328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1947183EEDD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C94283B4C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9932C848;
	Sat, 27 Jan 2024 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAWCrzo3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C45825615;
	Sat, 27 Jan 2024 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706374659; cv=none; b=UJLp+5+BFcGefKw1R4cXn7GiP4+WhU1Mfo1AfkA5OMYd9Y7NkO1XyWHdGi4k16HBPAr50FRTpcx3Fw9hCf8hAVhpixB195kJV8xh0n/4SSQhb0v3fynJ0paCqro5+mF+xMdX6RvFOePUxynZMDek6Lu5x6MeKmNbeTT/gIF/88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706374659; c=relaxed/simple;
	bh=nOXA2c12RAby5M8SUuFH3qf80EdSAt6dzoh2DKF90tA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYtFeMePX/bggYIlZ/ltC6hRi9r99jTj2BOdsirJvS2536ZFp4g3DvuM+lgH3RmK1uScnj72R+Oicd3H8xaLIPdiyUZgXh+C54zGRIzEzJs9HOeVGWhQqsBJ/9+BBdvE2BHZBECYmxPjMzJIesQm12tCtPVfq96YK6T6nEnSqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAWCrzo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B33C433C7;
	Sat, 27 Jan 2024 16:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706374658;
	bh=nOXA2c12RAby5M8SUuFH3qf80EdSAt6dzoh2DKF90tA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vAWCrzo3vx+OCgvipPDyAWafHcz6hA4sXdFNgwIDiQPU3zfraJPVEOFEF4fJfmk/O
	 z48pbOTm9ZhfVyHxqcOsLX9dgcUdsRug/WJMXcwXVutGGd7Vx6nmCOl3EWIXALs9VW
	 +lSPPVdUEKF18VQRTWLXHS6Z5ag6zZNJ6fVDr+KY12FnDA7PkIW5+HUL2N8ZyU1mcb
	 vPIP/xHU2pb6pMIivp3GSV4kCxmgpOfLlsRhTL0IKAWbgSMoczva4JbF3u2SiYY791
	 Y8EopoLg1fl8vngdSYUvM3HsjeF6mm+vmQNCTD4k+yE1EBB2wnC4/5J9cnJKsJRID4
	 RyPOevMZkwLWQ==
Date: Sat, 27 Jan 2024 16:57:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/4] iio: pressure: hsc030pa cleanup
Message-ID: <20240127165727.1fde5925@jic23-huawei>
In-Reply-To: <20240127160405.19696-3-petre.rodan@subdimension.ro>
References: <20240127160405.19696-1-petre.rodan@subdimension.ro>
	<20240127160405.19696-3-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 18:03:56 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Use signed type to variable holding the result given by div_s64().
> 
> Add includes based on prior reviews from Andy.
> 
> Provide bus-specific technical datasheet in the _i2c.c _spi.c headers
> instead of the generic one.

Given this lists 3 things, should really be 3 patches... 
They are small though so meh, if nothing else comes up to require
a v3 I might take it in the interests of expediency. 

> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> v1 -> v2 no change
>  drivers/iio/pressure/hsc030pa.c     | 2 +-
>  drivers/iio/pressure/hsc030pa.h     | 2 ++
>  drivers/iio/pressure/hsc030pa_i2c.c | 6 ++++--
>  drivers/iio/pressure/hsc030pa_spi.c | 5 ++++-
>  4 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc030pa.c
> index d6a51f0c335f..7e3f74d53b47 100644
> --- a/drivers/iio/pressure/hsc030pa.c
> +++ b/drivers/iio/pressure/hsc030pa.c
> @@ -406,7 +406,7 @@ int hsc_common_probe(struct device *dev, hsc_recv_fn recv)
>  	struct hsc_data *hsc;
>  	struct iio_dev *indio_dev;
>  	const char *triplet;
> -	u64 tmp;
> +	s64 tmp;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
> diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc030pa.h
> index d20420dba4f6..f1079a70799f 100644
> --- a/drivers/iio/pressure/hsc030pa.h
> +++ b/drivers/iio/pressure/hsc030pa.h
> @@ -10,6 +10,8 @@
>  
>  #include <linux/types.h>
>  
> +#include <linux/iio/iio.h>
> +
>  #define HSC_REG_MEASUREMENT_RD_SIZE 4
>  
>  struct device;
> diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
> index e2b524b36417..b5810bafef40 100644
> --- a/drivers/iio/pressure/hsc030pa_i2c.c
> +++ b/drivers/iio/pressure/hsc030pa_i2c.c
> @@ -4,14 +4,16 @@
>   *
>   * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
>   *
> - * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf [hsc]
> - * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/common/documents/sps-siot-i2c-comms-digital-output-pressure-sensors-tn-008201-3-en-ciid-45841.pdf [i2c related]
> + * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/common/documents/sps-siot-i2c-comms-digital-output-pressure-sensors-tn-008201-3-en-ciid-45841.pdf
> + * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-sleep-mode-technical-note-008286-1-en-ciid-155793.pdf
>   */
>  
> +#include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/i2c.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/types.h>
>  
>  #include <linux/iio/iio.h>
>  
> diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
> index a719bade8326..8d3441f1dcf9 100644
> --- a/drivers/iio/pressure/hsc030pa_spi.c
> +++ b/drivers/iio/pressure/hsc030pa_spi.c
> @@ -4,13 +4,16 @@
>   *
>   * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
>   *
> - * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
> + * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-spi-comms-digital-ouptu-pressure-sensors-tn-008202-3-en-ciid-45843.pdf
> + * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-sleep-mode-technical-note-008286-1-en-ciid-155793.pdf
>   */
>  
> +#include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
>  #include <linux/stddef.h>
> +#include <linux/types.h>
>  
>  #include <linux/iio/iio.h>
>  


