Return-Path: <linux-kernel+bounces-148858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8638A8833
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5D6284A52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537EB1487CC;
	Wed, 17 Apr 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciwVHW4n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8457313F42C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369171; cv=none; b=cGXYdDWcFKXyIA9POhab04NWbtPg3C9bmMLI5lu6ph3x196IeC5mhqK4/sdTaz9bl+yp4W2Oge1AQahLpKqVleKeePlWC8AKP07ENv1nXkrfEx4729tMBXZkNvO0pJSmatoZEn8yD7sYv4suHmFnJZ8n1uhrE8LN7etdSDUJ/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369171; c=relaxed/simple;
	bh=PPbz4GQko4hF53ZUDpAq+ldibdDOErHuto8pYcPk6q4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ap0LeXU4gAzTvLamMQTxPPVU8QcmTZn4Cr3vzg/DX21OuRz30da2BNygyUJKmMEf9y4ixeeXQMnvPSB+5tIhzwculqzsIsKqpitUuOpmChSJMhGHDpYl6x28Qy2DRz7s5MAXTY2/WBVKxBJCh2F18sudZNoFQRC3cQW/nhOIuTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciwVHW4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD53DC072AA;
	Wed, 17 Apr 2024 15:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713369171;
	bh=PPbz4GQko4hF53ZUDpAq+ldibdDOErHuto8pYcPk6q4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ciwVHW4n6USeccR2haG+D9uXoealdrd0Z+p3ZSgcrNU41N+kELim1UB/hvy0LvOcz
	 LeHPNW3ddo4z4H0/t2ZtSd24wleMkGWd7wAujY42CmqIxhNEdZPorzVjueE5CHtTpx
	 u6nDRs7PIkmzrg4ilIPlsYIOZ/0hP46tVzjVhGnw3BOMD62Tj1+Y2QDMniZpY7mXN5
	 5jr2vHcCOFF/mMMY+5WMXiltp2w1pPb22BZkUNwerGMrPhPDHAGWvduDGP4f2dJY/O
	 9dK5gZFCrBUPRtkigrvWm78FqcL2KeVulVIl+PnfOLcnt7uYy+oHH5iK9FZUYvS8Q4
	 8qSJKPs4YDNbw==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Pratyush Yadav" <pratyush@kernel.org>,  "Tudor Ambarus"
 <tudor.ambarus@linaro.org>,  "Miquel Raynal" <miquel.raynal@bootlin.com>,
  "Richard Weinberger" <richard@nod.at>,  "Vignesh Raghavendra"
 <vigneshr@ti.com>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>
Subject: Re: [RFC PATCH v1 6/6] mtd: spi-nor: introduce support for
 displaying deprecation message
In-Reply-To: <D0MHEH8OOS44.2PPBZ3LFU4QG3@kernel.org> (Michael Walle's message
	of "Wed, 17 Apr 2024 16:52:42 +0200")
References: <20240412134405.381832-1-mwalle@kernel.org>
	<20240412134405.381832-7-mwalle@kernel.org>
	<mafs0jzkw6oq1.fsf@kernel.org> <D0MHEH8OOS44.2PPBZ3LFU4QG3@kernel.org>
Date: Wed, 17 Apr 2024 17:52:48 +0200
Message-ID: <mafs0bk686l67.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 17 2024, Michael Walle wrote:

> Hi,
>
> On Wed Apr 17, 2024 at 4:36 PM CEST, Pratyush Yadav wrote:
>> On Fri, Apr 12 2024, Michael Walle wrote:
>>
>> > SPI-NOR will automatically detect the attached flash device most of the
>> > time. We cannot easily find out if boards are using a given flash.
>> > Therefore, introduce a (temporary) flag to display a message on boot if
>>
>> Why temporary? There will always be a need to deprecate one flash or
>> another. Might as well keep the flag around.
>
> Mh, yes I agree. That also means that this flag will not have any
> users (most) of the time (hopefully ;) ).
>
>> Also, this patch/series does not add any users of the deprecated flag.
>> If you have some flashes in mind, it would be good to add them to the
>> patch/series.
>
> This is just an RFC to see if whether you Tudor agree with me :) But
> I was about to add it to the evervision/cypress FRAMs.
>
>> I like the idea in general. Do you think we should also print a rough
>> date for the deprecation as well?
>
> Might make sense, any suggestions?

How about a simple string to flash_info?

/**
 * struct flash_info - SPI NOR flash_info entry.
 * @id:   pointer to struct spi_nor_id or NULL, which means "no ID" (mostly
 *        older chips).
 * @name: (obsolete) the name of the flash. Do not set it for new additions.
 * @size:           the size of the flash in bytes.
 * @deprecation_date: The date after which the support for this flash will be
 *                    removed.
 * [...]
 */
struct flash_info {
	char *name;
	const struct spi_nor_id *id;
	char *deprecation_date;
	[...]
}

And then in everspin.c for example,

	{
		.name = "mr25h128",
		.size = SZ_16K,
		.sector_size = SZ_16K,
		.addr_nbytes = 2,
		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
		.deprecation_date = "2025-01-01",
	}, {

And in spi_nor_get_flash_info() (changed some wording of the message):

	info = jinfo ?: info;

	if (info->deprecation_date)
		pr_warn("Your board or device tree is using a SPI NOR flash (%s) with\n"
			"deprecated driver support. It can be removed in any kernel\n"
			"version after %s. If you feel this shouldn't be the case, please contact\n"
			"us at linux-mtd@lists.infradead.org\n", info->name,
			info->deprecation_date);

	return info;

This would also remove the need for SPI_NOR_DEPRECATED. But it would
make the flash_info 4 or 8 bytes larger.

What do you think?

>
>> > support for a given flash device is scheduled to be removed in the
>> > future.
>> >
>> > Signed-off-by: Michael Walle <mwalle@kernel.org>
>> > ---
>> >  drivers/mtd/spi-nor/core.c | 12 ++++++++++++
>> >  drivers/mtd/spi-nor/core.h |  1 +
>> >  2 files changed, 13 insertions(+)
>> >
>> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> > index 58d310427d35..a294eef2e34a 100644
>> > --- a/drivers/mtd/spi-nor/core.c
>> > +++ b/drivers/mtd/spi-nor/core.c
>> > @@ -3312,6 +3312,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
>> >  						       const char *name)
>> >  {
>> >  	const struct flash_info *jinfo = NULL, *info = NULL;
>> > +	const char *deprecated = NULL;
>> >  
>> >  	if (name)
>> >  		info = spi_nor_match_name(nor, name);
>> > @@ -3326,6 +3327,17 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
>> >  			return jinfo;
>> >  	}
>> >  
>> > +	if (info && (info->flags & SPI_NOR_DEPRECATED))
>> > +		deprecated = info->name;
>> > +	else if (jinfo && (jinfo->flags & SPI_NOR_DEPRECATED))
>> > +		deprecated = jinfo->name;
>> > +
>> > +	if (deprecated)
>> > +		pr_warn("Your board or device tree is using a SPI NOR flash (%s) with\n"
>> > +			"deprecated driver support. It will be removed in future kernel\n"
>>
>> Nit: "removed in a future kernel version"
>>
>> > +			"version. If you feel this shouldn't be the case, please contact\n"
>> > +			"us at linux-mtd@lists.infradead.org\n", deprecated);
>> > +
>>
>> Hmm, this isn't so nice. I'd suggest doing something like:
>>
>> 	/*
>>          * If caller has specified name of flash model that can normally be
>>          * ...
>>          */
>> 	info = jinfo ?: info;
>>
>> 	if (info->flags & SPI_NOR_DEPRECATED)
>>         	pr_warn(...);
>
> Actually, I had that, *but* I was thinking we might only check the
> detected flash and not the one specified in the device tree. But
> thinking about that again, I guess it makes sense because:
>  - that's the actually used flash driver
>  - having jinfo != info will print that other warning, thus this
>    case is hopefully very unlikely.
>
>>
>> 	return info;
>>
>> >  	/*
>> >  	 * If caller has specified name of flash model that can normally be
>> >  	 * detected using JEDEC, let's verify it.
>> > diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
>> > index 8552e31b1b07..0317d8e253f4 100644
>> > --- a/drivers/mtd/spi-nor/core.h
>> > +++ b/drivers/mtd/spi-nor/core.h
>> > @@ -524,6 +524,7 @@ struct flash_info {
>> >  #define SPI_NOR_NO_ERASE		BIT(6)
>> >  #define SPI_NOR_QUAD_PP			BIT(8)
>> >  #define SPI_NOR_RWW			BIT(9)
>> > +#define SPI_NOR_DEPRECATED		BIT(15)
>>
>> If you do agree with my suggestion of making it permanent, would it make
>> more sense to make it BIT(10) instead. Or BIT(9) once you move up the
>> others because we no longer have BIT(7).
>
> Or just BIT(7) and avoid any code churn :)

Yep, that works.

>
> -michael
>
>>
>> >  
>> >  	u8 no_sfdp_flags;
>> >  #define SPI_NOR_SKIP_SFDP		BIT(0)
>

-- 
Regards,
Pratyush Yadav

