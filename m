Return-Path: <linux-kernel+bounces-88786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185F86E696
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD351F23FF8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A2F46B7;
	Fri,  1 Mar 2024 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4McovRZ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028524417
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312503; cv=none; b=pBUz17YV4/zCoWZvdsgJ7HRdPqdOnZ/IP+C2KFmxD27Jl/2fYfkOUTfQfyvFKCtXW30/GFa2o3wYuGMNPK2YjTQlOondctrrLcJJX4tQhvpnOzNEWG7nh7TsJ+sO/AS5TFrDXHy8/Sm3yuTUkdmIgd3B+Uc3nUvXHEW0JxIjnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312503; c=relaxed/simple;
	bh=4n8ceEv6Q5ediHfdFs5AkThnNMy3m/KB032Gll00g78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1M/CcbXsfPFki/aB9Q8n6/kA4/OWFCpaJSmzTD0o3aI+5dpEW/2io/GWSobKY0dMmGEllTpxP8YUlJeHFRQ+U07SEA5/mcmOhdnIChQjIfNhxIngeEmglcbyLA/l/4d3by2E/Q+oqYAm/4CDr+VQ0ArX5ZpPh3pRa8gIKGJKFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x4McovRZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a449c5411e1so106949266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709312500; x=1709917300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yXl+fhGWmqpXUkYfoGJfgxrC/Y54D2lC6NLr66whDt4=;
        b=x4McovRZ1YgPqBq+Xg+Uy8IN19QebV34fUrnyPR/x8BofSbhWWD9ZXelAWtO6bplKf
         6esODOpseYFFhbtklasHCUII8E1mzh+dDSDF5kUhDr9WcGmSuZSMfAHVerrC6BGefFlb
         bkYB/LZ8z62x86LpgQ7ehZCoD0fZhMTYkh9FzRcojn4MuI0sTrK9Ut0JMhldDD6JYFKC
         OA5TvXhweH0ZguQGJrdGo/b+iG5qOq0lq3ftSrRH1b6j3qqZMa0fMUjpKedRbrn6ReDS
         tYL13Mxrz20NabsVeNz3v2KABt0naiQo4Mm3l9e9vu6koL/Fnt+GA28Ax5Zk8EXsF2jx
         oxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709312500; x=1709917300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXl+fhGWmqpXUkYfoGJfgxrC/Y54D2lC6NLr66whDt4=;
        b=Jid63H+B86JQJCt1a2gfd0umecuAuEIunDwBrNYu5IdPmsy0L32ZKNzSEqCa1NyN4d
         5u/59cGtAyk+DrFdkFulVwp/Ie9EXQWnXJ0OyL98fnqTWyIqwLVpq1klR2H4DL63DYli
         Sfk+x+0ckkZX4Lw1UAztZ+J0UqIFHHICZqV0hsMhRCwSsAta7YRBcqZyByhqfPee0E5h
         vuMCfGILnzteOg7ENEvUFCciSUWow7x8F6q+UilFZSKFijl9pY6dMuhSReffDb2VsQMa
         pfSTshgHQxgphfnD6gTFlN30Qmjq+0vK0gIxdsayFUI5KocTHD6+jB3bVQ8B7VPAcQQi
         e1kg==
X-Forwarded-Encrypted: i=1; AJvYcCX02XNDX/9xRF25MQe0pqQMXmE1aRvflszK38/Eog4bTxr4QRCmc8OMw37QyAQNv/v4Ze3Lj+jy4X+JzbiNQwJ6qBUCuRjgmbU7kBap
X-Gm-Message-State: AOJu0YzG/sJyYB3x07nEZrdvYYy6HjkzutNsCBbyIytt0pdRb0W9ibX0
	+gWmOcY3Yl2YNz/uBFPCArdFmjLXX+Q6vjZNWYvZnjkleUa8fuBqEBQEDyhmMW4=
X-Google-Smtp-Source: AGHT+IFGat9UXgkHbrn1IFjTtMxIE8O4RGfV+O/IUsZ8Ep40Xr1elDiVdFGMlUy74J4zM3dAirtmhQ==
X-Received: by 2002:a17:906:f355:b0:a3e:c738:afa2 with SMTP id hg21-20020a170906f35500b00a3ec738afa2mr1843445ejb.76.1709312500414;
        Fri, 01 Mar 2024 09:01:40 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id q12-20020a1709066acc00b00a440846650bsm1856780ejs.184.2024.03.01.09.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:01:40 -0800 (PST)
Date: Fri, 1 Mar 2024 20:01:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	kernel@collabora.com, kernel-janitors@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: core: correct type of i to be signed
Message-ID: <c7db3fa0-d5a2-43aa-8038-0a722f2b8f26@moroto.mountain>
References: <20240301144517.2811370-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301144517.2811370-1-usama.anjum@collabora.com>

On Fri, Mar 01, 2024 at 07:45:16PM +0500, Muhammad Usama Anjum wrote:
> The i should be signed to find out the end of the loop. Otherwise,
> i >= 0 is always true and loop becomes infinite.
> 
> Fixes: 6a9eda34418f ("mtd: spi-nor: core: set mtd->eraseregions for non-uniform erase map")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/mtd/spi-nor/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 65b32ea59afc6..46bc45b80883f 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3373,7 +3373,7 @@ static u32
>  spi_nor_get_region_erasesize(const struct spi_nor_erase_region *region,
>  			     const struct spi_nor_erase_type *erase_type)
>  {
> -	u8 i;
> +	s8 i;

I have a patch in my output which also addresses this bug but you beat
me to the punch.  Declaring iterators as "u8 i;" is a canonical bug.

https://staticthinking.wordpress.com/2022/06/01/unsigned-int-i-is-stupid/

regards,
dan carpenter


