Return-Path: <linux-kernel+bounces-48262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B187D84593E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3202951D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6575D47D;
	Thu,  1 Feb 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErIa5eCa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D05D460
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795259; cv=none; b=IMbU4LUUzUpJ1GtY8YGb2H4cYE2Qdt4wYkEYiHwjvuf7hISwhHRZNHD+v4lS9rGcNeugWW3xm+li2n19hybhruh9r7cO3K9nKHAW5Uy6C3TMq3RURRJsC//z6qnFVdwXinVR28PuwvCd547OZDkVOGz3YEeKnsKf6IPy+m5s9uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795259; c=relaxed/simple;
	bh=6V78DR2Nb/jUbKBHuJ0negCG/TVk5A4NkslQ23DMV5E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WvN3Hfccp+QCs96HF2orBIuwtz7ZcFDpLBbyoEFoHwOXOMRpKEpwseBrzKgmGjzWpeLo44z93H3a0gfyTg8F4Sx0e+ZDtllOwZuz/BRxq2vH2fnuxVffHaZeUvMSOnk88J14V8jNiTzCYv5z8ZFPBfoCmAj2+R1jeSS9WPqiWhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErIa5eCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DD6C433F1;
	Thu,  1 Feb 2024 13:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706795259;
	bh=6V78DR2Nb/jUbKBHuJ0negCG/TVk5A4NkslQ23DMV5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ErIa5eCayveF4ltSAHPvQOQmDzAkzBDu7U5MABEd/JPZe40+Nh+k33hDl/FdkBMip
	 eWM1L9aAF9HwI30N861NZUw/FX7d3Fm27ztSE74DRh9SA4f6At1B9cVZIUyyIq30/F
	 Lxh+j5XqEFAhIvAuXR8yWhEMdItAHIRrjep2UiV9zZRHM8C+GzexQv60AChySCKQuS
	 UrR9fJ08zQM/z5w5DW1DK9FfQqJP1BlQ0SQdpQCD4CGpaTlP0X43Y9L6jxUpRfM6kb
	 fdX2kKbKO/QDpTDzNh40TimiqZcp+1aqvtAjPLTi9FlA+WI8Hky8jb9jXyn1vii7K4
	 pvDSjUUsc2YVw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Feb 2024 14:47:34 +0100
From: Michael Walle <mwalle@kernel.org>
To: Flavio Suligoi <f.suligoi@asem.it>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
 <pratyush@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard
 Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mtd: spi-nor: everspin: add em004lxb entry
In-Reply-To: <20240201131710.797505-2-f.suligoi@asem.it>
References: <20240201131710.797505-1-f.suligoi@asem.it>
 <20240201131710.797505-2-f.suligoi@asem.it>
Message-ID: <9a22148dd786dd1c37f10412b574aae8@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> Add the Everspin EM0004LXB 4Mb (512KB) Industrial STT-MRAM Persistent
> Memory.

Out of curiosity, what is your use case here? Usually, I push back on
this small MRAM devices in SPI-NOR in favor of the at25 driver. But
this datasheet lists octal dtr with 200mhz, which seems a bit ridiculous
for 512kB. The at25 driver only supports single bit SPI of course.

I'm not sure in which mode you are using this device, though. The DS
shows a non-volatile configuration register (Table 10, offset 0) and
it's default value is single bit SPI.

> This device is JEDEC compatible (JESD251 and JESD251-1), but it is not
> able to provide SFDP information.
> 
> Link: https://www.everspin.com/file/158244/download

No newline.

> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  drivers/mtd/spi-nor/everspin.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/everspin.c 
> b/drivers/mtd/spi-nor/everspin.c
> index 5f321e24ae7d..4741930ce9a8 100644
> --- a/drivers/mtd/spi-nor/everspin.c
> +++ b/drivers/mtd/spi-nor/everspin.c
> @@ -31,6 +31,14 @@ static const struct flash_info everspin_nor_parts[] 
> = {
>  		.size = SZ_512K,
>  		.sector_size = SZ_512K,
>  		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> +	}, {
> +		.id = SNOR_ID(0x6b, 0xbb, 0x13),
> +		.name = "em004lxb",

No name. We prefer to only have the ID for parts which has JEDED IDs.

> +		.size = SZ_512K,
> +		.sector_size = SZ_512K,

This should probably be removed (and then default to the 64k erase
size).

> +		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR | SPI_NOR_HAS_LOCK |

Don't use SPI_NOR_NO_ERASE for new devices. Eventually, I like to get 
rid of
this flag. This device is emulating the erase instruction, so it should 
work
without.

SPI_NOR_NO_FR is wrong here. The DS says it supports fast read.

Please also have a look at [1] for the required tests.

-michael

> +			 SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6,
> +		.no_sfdp_flags = SPI_NOR_SKIP_SFDP,
>  	}
>  };

[1] https://docs.kernel.org/driver-api/mtd/spi-nor.html

