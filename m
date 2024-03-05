Return-Path: <linux-kernel+bounces-93073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0057872A78
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E50A1C21D0A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7221912D20D;
	Tue,  5 Mar 2024 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9dIxJmJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA73FB9B;
	Tue,  5 Mar 2024 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709679139; cv=none; b=FKJfTRdzP2EILQ65BHWGXIkBFDzqEb5lONZkNYeXqFlorc6VPPsrZwOw1y78TJD9Y0AZwrCVCAVVmpkKgaWK0AabAEcAL8uRfkAW9lMgC+VcSlS2lJYuoOTpSGZc4W3F+Z1Ts2+sxuzMI+j5gWwTt6qGK1BQxKonT7Wz3U/a6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709679139; c=relaxed/simple;
	bh=L1paJPYPLdt6AZvCF+Q8QCtBk4CJCgcJ8Mm+N8fc5fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjjmLmRO67KiN9QY3dSfX0gjJiz4HBG46CMPT9zN5FBwo7PFZnMYk+xSmkqU4W0cJ83g9aoKPNcP70FP1s0yogIXimZdq9+ygv68m1eZGCi3xCR2dKJUMgy9+AoSQIEYP4CvVgXjPeyvJ2YXFLW+BC24AlabuS9w3mCRrSOtDbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9dIxJmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B167C433C7;
	Tue,  5 Mar 2024 22:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709679139;
	bh=L1paJPYPLdt6AZvCF+Q8QCtBk4CJCgcJ8Mm+N8fc5fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9dIxJmJN+5NmuJ9Bny88Z/JitQ7V1cIgoYja22uXxbD8Tlt/AdydhGkZ+DQNxm2n
	 +wapWsFdetL6VR11v8+D/7VtkpXLnJfnGOdbtFaQA/rIAGCLwzu2iLDHAfODT4E17n
	 NXdCAZRp4uF9XQMUT33zqVAz1uwsXPz+J+X0cdIUaIak71C1/XRFl2byv94L+oawja
	 q8EsFOUoyxGRVMCg0mHL9w5LIypGO98iETDVqCRPWwvJcWD03+HgELbiNP8Wlf2eki
	 Jp/pg8f22Ie6XHP+wRmGAM++PXNzQoJfV0saKMM9ql2mVEfyCXw8Q23MBfLcX+HIrN
	 IEzWC0L8F4wWw==
Date: Tue, 5 Mar 2024 23:52:15 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Young <sean@mess.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [SPAM] [PATCH v1 5/5] media: ir-spi: Unify indentation and
 comment style
Message-ID: <hwtodfwrgonzzf2dpoqa3b5b3v66ypp7uu7upsnt6dx7weua2f@byxbgpxurhmf>
References: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
 <20240305174933.1370708-6-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305174933.1370708-6-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Tue, Mar 05, 2024 at 07:48:30PM +0200, Andy Shevchenko wrote:
> Unify the indentation and multi-line comment style.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/rc/ir-spi.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/rc/ir-spi.c b/drivers/media/rc/ir-spi.c
> index 801de3d108cc..8fc8e496e6aa 100644
> --- a/drivers/media/rc/ir-spi.c
> +++ b/drivers/media/rc/ir-spi.c
> @@ -36,8 +36,7 @@ struct ir_spi_data {
>  	struct regulator *regulator;
>  };
>  
> -static int ir_spi_tx(struct rc_dev *dev,
> -		     unsigned int *buffer, unsigned int count)
> +static int ir_spi_tx(struct rc_dev *dev, unsigned int *buffer, unsigned int count)

this goes over 80 characters, though. Not an error, but not worth
a change either.

I'm not going block the patch as the rest is OK.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Andi

>  {
>  	int i;
>  	int ret;
> @@ -57,7 +56,7 @@ static int ir_spi_tx(struct rc_dev *dev,
>  			return -EINVAL;
>  
>  		/*
> -		 * the first value in buffer is a pulse, so that 0, 2, 4, ...
> +		 * The first value in buffer is a pulse, so that 0, 2, 4, ...
>  		 * contain a pulse duration. On the contrary, 1, 3, 5, ...
>  		 * contain a space duration.
>  		 */
> @@ -146,9 +145,9 @@ static int ir_spi_probe(struct spi_device *spi)
>  	if (ret)
>  		dc = 50;
>  
> -	/* ir_spi_set_duty_cycle cannot fail,
> -	 * it returns int to be compatible with the
> -	 * rc->s_tx_duty_cycle function
> +	/*
> +	 * ir_spi_set_duty_cycle() cannot fail, it returns int
> +	 * to be compatible with the rc->s_tx_duty_cycle function.
>  	 */
>  	ir_spi_set_duty_cycle(idata->rc, dc);
>  
> @@ -177,7 +176,6 @@ static struct spi_driver ir_spi_driver = {
>  		.of_match_table = ir_spi_of_match,
>  	},
>  };
> -
>  module_spi_driver(ir_spi_driver);
>  
>  MODULE_AUTHOR("Andi Shyti <andi@etezian.org>");
> -- 
> 2.43.0.rc1.1.gbec44491f096
> 

