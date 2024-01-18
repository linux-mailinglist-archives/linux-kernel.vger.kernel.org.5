Return-Path: <linux-kernel+bounces-30488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A8D831F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F49DB2206D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052152E401;
	Thu, 18 Jan 2024 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uYEAzXFN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A82E3F8;
	Thu, 18 Jan 2024 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604395; cv=none; b=Zr1qeDm7RYAYrvmKH4eAHzDPNIJUpl1NgDqkB3eb0GT5+H7nseeEpZlIoQecm5UwmP8tLRnDzHduMa3nmHNrL74bdxPdNOcrqSLWbomSFpbHz4NHQCM10lwYCVpZQhO4jS5e5LMvPAv8KPhpgE5GNIOeJZkFZwQEn4qgI2nzf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604395; c=relaxed/simple;
	bh=JrDbEJiAmEMkVSL2f4VBe7R8zB2xlRoKQCbjKC0tJkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6iXKnPR9r9H1VfSH1dokWNfc/QqdJ7yRCKptoe4LEGz/9jWRREQOe1kWB+HZeomnlMQeSUKAQowZO2LhCd5Ga7g+z82KAFzIUMpf9/Yr9Ms1YBGlUj1gGS6iZW+18SJBW4TikTEYrgSoAFHYySy3yT5XjAZiU5bCxLH/LBWKN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uYEAzXFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1078AC433F1;
	Thu, 18 Jan 2024 18:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705604394;
	bh=JrDbEJiAmEMkVSL2f4VBe7R8zB2xlRoKQCbjKC0tJkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uYEAzXFNqT/XNb1HCZokdSBjq3KXUJ2zl/ePNNGUIY6qaGxKytxRGXeNsGeZkUYwF
	 sfmH0FwW3qlDP/6sfQwii/OD3jSorvQgOoJ5B3DIbh1Qa6GmUA/+e4vIE4phT+dcBW
	 tckJ9eK9UO+fVEy9kotaYtWFXnSI9vc7wLw3+XbQ=
Date: Thu, 18 Jan 2024 19:59:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacob Lott <jklott.git@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: rts5208: Add more details to Kconfig help
Message-ID: <2024011829-gusto-absently-8192@gregkh>
References: <20240118175947.82297-1-jklott.git@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118175947.82297-1-jklott.git@gmail.com>

On Thu, Jan 18, 2024 at 12:59:48PM -0500, Jacob Lott wrote:
> The current help text is short and triggers a
> warning from checkpatch.pl. This patch adds more
> details to the help text which should provide better
> information for whether or not to enable the driver.
> 
> Signed-off-by: Jacob Lott <jklott.git@gmail.com>
> ---
>  drivers/staging/rts5208/Kconfig | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/Kconfig b/drivers/staging/rts5208/Kconfig
> index b864023d3ccb..c4664a26ba3b 100644
> --- a/drivers/staging/rts5208/Kconfig
> +++ b/drivers/staging/rts5208/Kconfig
> @@ -3,7 +3,11 @@ config RTS5208
>  	tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
>  	depends on PCI && SCSI
>  	help
> -	  Say Y here to include driver code to support the Realtek
> -	  PCI-E card reader rts5208/rts5288.
> +	  Choose Y here to enable support for the Realtek PCI-E card reader
> +	  RTS5208/5288. This driver facilitates communication between the Linux
> +	  kernel and the Realtek PCI-E card reader.
>  
> -	  If this driver is compiled as a module, it will be named rts5208.
> +	  If you opt to compile this driver as a module, it will be named rts5208.
> +	  Selecting N will exclude this driver from the kernel build. Choose option
> +	  Y if your system includes the Realtek PCI-E card reader rts5208/rts5288.
> +	  When in doubt, it is generally safe to select N.
> -- 
> 2.34.1
> 
> v3 fixes the tab spacing for line 6 in Kconfig


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

