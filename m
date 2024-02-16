Return-Path: <linux-kernel+bounces-68648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C709857DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F33F1C23C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917B112A16A;
	Fri, 16 Feb 2024 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOIC0/dV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C781B966;
	Fri, 16 Feb 2024 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090709; cv=none; b=JYCD6uJWh5pGiKZqx3L/CtNozK09SG4lp4+k5oj1lD2TN5GjB0oZZyNf2kogj8pTNsW20AU25IvTii0sXkLFfYNDWHBSp8FPzu2FFNOiYPQBymtbHNCto0Tf2nNqawjPJty8YEemSKrltT5C5+pKKgnDDAPsH+Ob3zbcyJ1u/80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090709; c=relaxed/simple;
	bh=1u9HwamzWLOm9AMbpv7x1BatZRX6+yB9Jmf2+70ZxCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKqqYSdufq87zI+4O9DAkOX13t1ERHlYZjITz1hQ9dBKnUYEJPs57sR8yy8C+UtrQ60+0zJlP7EpMFo6Wmldp2cUJplOKuVX5GBNy7KyvVmCVw2bY97X9S2EkzA01hzkYiMG+IYFQAHC9bgQxg/m9jSF8jPba/9N4kPKaNl6hJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOIC0/dV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003F7C433C7;
	Fri, 16 Feb 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708090709;
	bh=1u9HwamzWLOm9AMbpv7x1BatZRX6+yB9Jmf2+70ZxCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eOIC0/dVvZxnqVJu25rVJGRMzQVkBX+NLonF1mB6rBXjiS74yPS8A8SFRvJ5trq1Q
	 fH4TqdwTr1mXPNd2ko6fTLjHBAJkC7etcguYz0DfUr84WbUyR+UmW3TeLMT9zZaUfy
	 +ueglii2LAnw0tc2/gZ197NdnuOmUTuxmkWTAQeV9X/RgjouHRCX2MwI0ERB5Wou6b
	 T6xOT7JWsnWf/pU7lhWHbNjoX0Dm+3XZCL/i2jUlzUFLf4hp6U+UqHiE7t20NqlhhN
	 3R7DCRbtRogSOEEhGBrLstZQa7SWBZg8NR3yyRqbrOXh09t3acaHEz3meKe/TS3mEP
	 uH7KjqqnU3JiA==
Date: Fri, 16 Feb 2024 13:38:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Liam Beguin <liambeguin@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Maksim Kiselev <bigunclemax@gmail.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Marius Cristea
 <marius.cristea@microchip.com>, Mark Brown <broonie@kernel.org>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Okan Sahin <okan.sahin@analog.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <20240216133816.18c42c99@jic23-huawei>
In-Reply-To: <20240214063736.88283-2-mike.looijmans@topic.nl>
References: <20240214063736.88283-1-mike.looijmans@topic.nl>
	<1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.da2f422c-5c6b-41b4-8916-d1a90f0f0973@emailsignatures365.codetwo.com>
	<20240214063736.88283-2-mike.looijmans@topic.nl>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 07:37:36 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> Skeleton driver for the TI ADS1298 medical ADC. This device is
> typically used for ECG and similar measurements. Supports data
> acquisition at configurable scale and sampling frequency.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
Hi Mike,

One final thing noticed on a (hopefully) last read through.

/sys/bus/iio:device0/name is going to read ads1298 whichever
chip is detected.

Would be more useful to users if it identified the actual
part given that is easily read from the ID register.

Jonathan

> ---
> 
> Changes in v4:
> Explain rdata_xfer_busy better and remove post-decrement
> Reset assert explanation and add cansleep
> Additional style changes
> 
> Changes in v3:
> Indentation fixups
> Remove unused headers
> Remove #define leftovers
> Use devm_get_clk_optional_enabled
> Use ilog2 instead of fls()-1
> Magic "23" replaced
> Explain the extra "0" in read/write register
> use guard() from cleanup.h
> use REGCACHE_MAPLE
> 
> Changes in v2:
> Remove accidental "default y" in Kconfig
> Indentation and similar cosmetic fixes
> Magic numbers into constants
> Short return paths in read_raw and write_raw
> DMA buffer alignment
> Bounce buffer is u32 instead of u8
> Avoid races using claim_direct_mode
> Check errors on all register accesses
> Immediate SPI restart to reduce underruns
> "name" is chip name, not unique

I missed this until having a final read through but it's not the chip name
in the driver currently - the name is always ads1298 despite there being a handy
ID register that tells us what we actually have.


> 
>  drivers/iio/adc/Kconfig      |  11 +
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/ti-ads1298.c | 766 +++++++++++++++++++++++++++++++++++
>  3 files changed, 778 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads1298.c

> +
> +static const char *ads1298_family_name(unsigned int id)
> +{
> +	switch (id & ADS1298_MASK_ID_FAMILY) {
> +	case ADS1298_ID_FAMILY_ADS129X:
> +		return "ADS129x";
> +	case ADS1298_ID_FAMILY_ADS129XR:
> +		return "ADS129xR";
> +	default:
> +		return "(unknown)";
> +	}
> +}

..

> +static int ads1298_probe(struct spi_device *spi)
> +{

..

> +
> +	priv->tx_buffer[0] = ADS1298_CMD_RDATA;
> +	priv->rdata_xfer.tx_buf = priv->tx_buffer;
> +	priv->rdata_xfer.rx_buf = priv->rx_buffer;
> +	priv->rdata_xfer.len = ADS1298_SPI_RDATA_BUFFER_SIZE;
> +	/* Must keep CS low for 4 clocks */
> +	priv->rdata_xfer.delay.value = 2;
> +	priv->rdata_xfer.delay.unit = SPI_DELAY_UNIT_USECS;
> +	spi_message_init_with_transfers(&priv->rdata_msg, &priv->rdata_xfer, 1);
> +	priv->rdata_msg.complete = &ads1298_rdata_complete;
> +	priv->rdata_msg.context = indio_dev;
> +
> +	indio_dev->name = spi_get_device_id(spi)->name;

I was going to just tweak this whilst applying.  Using the spi device id often
ends up being fragile in the long term because of the split between the different
ID tables and the mess that happens if fallback compatibles are in use and
the spi IDs are missing (you will get a warning about this at runtime
but it'll carry on anyway).

Easier to just hard code the name for now and when you have multiple
devices supported, add this to a chip_info type structure.
Or we could make it support the more specific name given the detection above.
Is there a reason to not do that given a more accurate name is
easy to work out and may be useful to a user?

Jonathan


