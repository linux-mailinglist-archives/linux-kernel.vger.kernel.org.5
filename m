Return-Path: <linux-kernel+bounces-30443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC46831ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B062C1C2617F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB982D611;
	Thu, 18 Jan 2024 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HZCO6SUB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251A12D605;
	Thu, 18 Jan 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600390; cv=none; b=Wm+FH56Be0NiWMv/9q3ura622VJcbsArYuqYat8AS2fYhjpNC3lGRkgVl3Dt3T6a6hP1SRjuQaKkscGydq17oSvgyr3yEKseZbl4dQa1s/6z6K4Jv/kcVqMjlbBv42vys3hb1dvVhyiTF0ruvYATNIQF5RgnEBf+vlwjpXrHDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600390; c=relaxed/simple;
	bh=mNh3OFF6x1XO22tu+xQC+TvfaQnN/eob1JCb1+82/KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGCygjug79WrsWwuyVJ2W6fsXJQcZVc9sa+T3TiTGXd5zEqCTmsiyLvE3jUU+AgAZEQWUTqrzy1I6NWuLfePX+Oi0tr1boYdNovAIUTPxTKOLOC4dRQ3dfLgGLWZ4RnUXyvRp2jrzU8wJuXER5Hp2RjaWBiiRl3NHb1G2C4ZEYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HZCO6SUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBC3C433C7;
	Thu, 18 Jan 2024 17:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705600389;
	bh=mNh3OFF6x1XO22tu+xQC+TvfaQnN/eob1JCb1+82/KE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZCO6SUBT6asO/d4lXdHFWSwVE8qCfBTgYEXDMi8nTw1Mt4GKPu2GPdb3dMmHAjK5
	 cTUPczyyiP9EgAneFbgvxd5zC2P51jFMVUoch70/pYyPLWCTrunXoUxKUSGfjxLYuB
	 T9dj3q6/K3nPSXG20vK5B0DxmODf1VNlFPKlMeFU=
Date: Thu, 18 Jan 2024 18:53:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacob Lott <jklott.git@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: rts5208: Add more details to Kconfig help
Message-ID: <2024011856-reluctant-vertigo-eb31@gregkh>
References: <20240118165447.78727-1-jklott.git@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118165447.78727-1-jklott.git@gmail.com>

On Thu, Jan 18, 2024 at 11:54:47AM -0500, Jacob Lott wrote:
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

