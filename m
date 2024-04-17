Return-Path: <linux-kernel+bounces-148680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668558A8602
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E27428375A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A212338DD3;
	Wed, 17 Apr 2024 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anjArfD6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93CC13A265
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364569; cv=none; b=azvAtAwBdnt1T1XmyQGvYaOQ+aoGQCJUcisdoNEvkzZAUtcEzHkPhGUn18QN9ZsUXax5Y5eCpYsuZkXxwqtwf6c2rALJmBuumnzg4GDqSCbtbES+xUIERK4XaLsd6xUnVxJoPpCqCciXpquxVST3Z03HZlrcwE6YBA/ENTcP1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364569; c=relaxed/simple;
	bh=+Y9JzAylpqFu2bRnmflUigQpLiwfuTJ/VegvAB2EcjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EXsuBnnRbitWR+/FcfG/YMvjbrni+0qZtprPxCDkebt+HnLQix79ZJViT/hiFU428XCM5e+4GiqYUHS3dDiC/k21tjBdt7CldlEGT1/x7Ph8HcBSG6aoHPDUZBO/tsiqeSEbsoMJdKKCxT60c0lR0HjM0oKn2fderTPyYKGR5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anjArfD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6F3C072AA;
	Wed, 17 Apr 2024 14:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713364568;
	bh=+Y9JzAylpqFu2bRnmflUigQpLiwfuTJ/VegvAB2EcjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=anjArfD6oxx6cZ4qCiZG864wcbmxykfLW+BETZ+XMQD+XcgrVnvSeTdx2jB4Apr/n
	 5ovg3ouCBrr84D1+CtJgiGng2wkoDTQkImulTZB80oJb+3jr86IPypSLiXsm2XewvE
	 +x5bg8vdu2oFCQzyz5p6m8geYsaC7KnX7scs89gjskEKJAcHAwpjrOL5lLB3pB+U+/
	 QY0AbML6ucdpVAtA6myQ5ciR8rJe/fliiOXbnWVVgQbw4TrpOAVuKr2l9ORtT9RZNq
	 zLYMBC6yeu6F0CBnjwLPmyffVi1Xw07u6QYlCk1Pqbc6NrlSH68tlq0gOYCpdeQC93
	 zNLfcSX/mubBw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH v1 6/6] mtd: spi-nor: introduce support for
 displaying deprecation message
In-Reply-To: <20240412134405.381832-7-mwalle@kernel.org> (Michael Walle's
	message of "Fri, 12 Apr 2024 15:44:05 +0200")
References: <20240412134405.381832-1-mwalle@kernel.org>
	<20240412134405.381832-7-mwalle@kernel.org>
Date: Wed, 17 Apr 2024 16:36:06 +0200
Message-ID: <mafs0jzkw6oq1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 12 2024, Michael Walle wrote:

> SPI-NOR will automatically detect the attached flash device most of the
> time. We cannot easily find out if boards are using a given flash.
> Therefore, introduce a (temporary) flag to display a message on boot if

Why temporary? There will always be a need to deprecate one flash or
another. Might as well keep the flag around.

Also, this patch/series does not add any users of the deprecated flag.
If you have some flashes in mind, it would be good to add them to the
patch/series.

I like the idea in general. Do you think we should also print a rough
date for the deprecation as well?

> support for a given flash device is scheduled to be removed in the
> future.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/mtd/spi-nor/core.c | 12 ++++++++++++
>  drivers/mtd/spi-nor/core.h |  1 +
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 58d310427d35..a294eef2e34a 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3312,6 +3312,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
>  						       const char *name)
>  {
>  	const struct flash_info *jinfo = NULL, *info = NULL;
> +	const char *deprecated = NULL;
>  
>  	if (name)
>  		info = spi_nor_match_name(nor, name);
> @@ -3326,6 +3327,17 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
>  			return jinfo;
>  	}
>  
> +	if (info && (info->flags & SPI_NOR_DEPRECATED))
> +		deprecated = info->name;
> +	else if (jinfo && (jinfo->flags & SPI_NOR_DEPRECATED))
> +		deprecated = jinfo->name;
> +
> +	if (deprecated)
> +		pr_warn("Your board or device tree is using a SPI NOR flash (%s) with\n"
> +			"deprecated driver support. It will be removed in future kernel\n"

Nit: "removed in a future kernel version"

> +			"version. If you feel this shouldn't be the case, please contact\n"
> +			"us at linux-mtd@lists.infradead.org\n", deprecated);
> +

Hmm, this isn't so nice. I'd suggest doing something like:

	/*
         * If caller has specified name of flash model that can normally be
         * ...
         */
	info = jinfo ?: info;

	if (info->flags & SPI_NOR_DEPRECATED)
        	pr_warn(...);

	return info;

>  	/*
>  	 * If caller has specified name of flash model that can normally be
>  	 * detected using JEDEC, let's verify it.
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 8552e31b1b07..0317d8e253f4 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -524,6 +524,7 @@ struct flash_info {
>  #define SPI_NOR_NO_ERASE		BIT(6)
>  #define SPI_NOR_QUAD_PP			BIT(8)
>  #define SPI_NOR_RWW			BIT(9)
> +#define SPI_NOR_DEPRECATED		BIT(15)

If you do agree with my suggestion of making it permanent, would it make
more sense to make it BIT(10) instead. Or BIT(9) once you move up the
others because we no longer have BIT(7).

>  
>  	u8 no_sfdp_flags;
>  #define SPI_NOR_SKIP_SFDP		BIT(0)

-- 
Regards,
Pratyush Yadav

