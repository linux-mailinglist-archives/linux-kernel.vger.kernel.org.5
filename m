Return-Path: <linux-kernel+bounces-30301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFEC831CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CBC284526
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65D0286B1;
	Thu, 18 Jan 2024 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Os1pFQWL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15081DA35;
	Thu, 18 Jan 2024 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593063; cv=none; b=p/pmszJmAVIR5/HvfnJosLJmGCYFoO0XNiIu7Umh9hwxZ9U+iknT2Gvmqc+6QpdoXnLcHdMmidta8eyG766aqvKqIMnvSRmW8dwbQ97avvWzd1PAqWKJ4y6M9KOqXrKFBx7kgfCW33U0F5odqugLhn6DvIJUMTqBa/ae9ntOjjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593063; c=relaxed/simple;
	bh=i7QMK4xNmUlb/uOg6tklgUsItoJCol15VXLsf5LHIzo=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=qaBjn2auKyVFtS6EkjvSUtm8b5Jdc7kBo4jaZRA4k0OYrl5Vrl6PxJAVrmXG+ouzEO6inokBYKnaEO/QVsUQkniiP7HD5XHwIY+1z/M2r8/FK0+fKR0g/4LfRTCn2r48RiEp0JhEXNF3Ot+a82aN5TQnNAVxWz10xOnl9J6zBXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Os1pFQWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9A7C433C7;
	Thu, 18 Jan 2024 15:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705593061;
	bh=i7QMK4xNmUlb/uOg6tklgUsItoJCol15VXLsf5LHIzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Os1pFQWLAs6HL5sCelpJgswM+4HzYO7cHmxQGsdNOwTyD1xmYFT0goriQ1r6bzmrh
	 7Fqs6NY4z78VJqthHqPhjechpDpILEo6nN3+n6vKMMe4CvCcZSleNcuPZf4cEVPwXT
	 Lxh2tA1d2h1swPnnSoVnSGI2BauvWEI0xSV8eNZQ=
Date: Thu, 18 Jan 2024 16:50:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacob Lott <jklott.git@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Add more details to Kconfig help
Message-ID: <2024011848-daycare-handrail-88a6@gregkh>
References: <20240118154044.68425-1-jklott.git@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118154044.68425-1-jklott.git@gmail.com>

On Thu, Jan 18, 2024 at 10:40:44AM -0500, Jacob Lott wrote:
> The current help text is short and triggers a
> warning from checkpatch.pl.  This patch adds more
> details to the help text which should provide better information
> for whether or not to enable the driver.
> 
> Signed-off-by: Jacob Lott <jklott.git@gmail.com>
> ---
>  drivers/staging/rts5208/Kconfig | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/Kconfig b/drivers/staging/rts5208/Kconfig
> index b864023d3ccb..76a083fbe401 100644
> --- a/drivers/staging/rts5208/Kconfig
> +++ b/drivers/staging/rts5208/Kconfig
> @@ -3,7 +3,11 @@ config RTS5208
>  	tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
>  	depends on PCI && SCSI
>  	help
> -	  Say Y here to include driver code to support the Realtek
> -	  PCI-E card reader rts5208/rts5288.
> +      Choose Y here to enable support for the Realtek PCI-E card reader RTS5208/5288.
> +	  This driver facilitates communication between the Linux kernel and the Realtek
> +	  PCI-E card reader.
>  
> -	  If this driver is compiled as a module, it will be named rts5208.
> +	  If you opt to compile this driver as a module, it will be named rts5208. Selecting
> +	  N will exclude this driver from the kernel build. Choose option Y if your system includes
> +	  the Realtek PCI-E card reader rts5208/rts5288. When in doubt, it is generally safe
> +	  to select N.
> \ No newline at end of file
> -- 
> 2.34.1
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

