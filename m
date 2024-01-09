Return-Path: <linux-kernel+bounces-20499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BC8827FCD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63CE1F25367
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4945CB669;
	Tue,  9 Jan 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="duaD3bbO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96258323B;
	Tue,  9 Jan 2024 07:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECC0C433C7;
	Tue,  9 Jan 2024 07:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704786974;
	bh=+sbZJVs3h3X4NHYaV/cceIgd2DaNJqv4yInDmP1TWfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=duaD3bbOGbX3VrRDjhwxfVeJhwE/g7mZPqbI4Qo5RtavldHub0H4F2wlK48q1p3EG
	 wZqPIKx1sg4Z22/bYkcdf57J9klXMw9Mx7mmMU4lYY5k3j08fp2dVum0wMGbXTZEON
	 HucGTohDA1k7QLFRtZNpCH+z+iYz8cJPuLp91Bx0=
Date: Tue, 9 Jan 2024 08:56:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lizhe <sensor1010@163.com>
Cc: ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org,
	u.kleine-koenig@pengutronix.de, robh@kernel.org,
	john.ogness@linutronix.de, tglx@linutronix.de, frank.li@vivo.com,
	zhang_shurong@foxmail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v7] serial: linflexuart: Remove redundant uart type
 assignment
Message-ID: <2024010958-headscarf-eldercare-ece3@gregkh>
References: <20240109043426.3756-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109043426.3756-1-sensor1010@163.com>

On Mon, Jan 08, 2024 at 08:34:26PM -0800, Lizhe wrote:
> in linflex_config_port() the member variable type will be
> assigned again. see linflex_connfig_port()
> 
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  drivers/tty/serial/fsl_linflexuart.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
> index 3bdaf1ddc309..c5a04a168c15 100644
> --- a/drivers/tty/serial/fsl_linflexuart.c
> +++ b/drivers/tty/serial/fsl_linflexuart.c
> @@ -837,7 +837,6 @@ static int linflex_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	sport->dev = &pdev->dev;
> -	sport->type = PORT_LINFLEXUART;
>  	sport->iotype = UPIO_MEM;
>  	sport->irq = ret;
>  	sport->ops = &linflex_pops;
> -- 
> 2.25.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

