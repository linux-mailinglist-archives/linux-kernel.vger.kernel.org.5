Return-Path: <linux-kernel+bounces-30298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0035831CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A292B2240D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486CD286AF;
	Thu, 18 Jan 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JChyktMY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A51DA34;
	Thu, 18 Jan 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592932; cv=none; b=eDbXtHuY1Xw6Ep6TkSnCe75ko2msXwS1arZyjMyDEUXkx3irFqPdgKoANFgk1C+OloCS4COQ+XWwEQO/sHduoXjcL9qVG9aQkyk0vFJngk6q7Od0FVW0eLaRcyOrkAbfVc+xFx5+BLeh5ZS0Q0YBS6bJigZrpP95AN6B4A8KY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592932; c=relaxed/simple;
	bh=zvIGHtNN87jVrZooYFiuwK3ThRsvPkR63aDCg7i5nUU=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=HbxHU+qPPfT3hroptc9e7TAfLZd+Rx8nGXhSb8vDvWgpvPtT2GRD3r++hTHdIksY2fHzATSoSLJlVSXE3QbEeZgoE1DdPguuuCNety/Alhwol08FaWrgo2KEKxTfo6mhv2jRxr4Av98CxxVfwsHNtSpUf+/sg0jkMvicXWHZotg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JChyktMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BADC433F1;
	Thu, 18 Jan 2024 15:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705592932;
	bh=zvIGHtNN87jVrZooYFiuwK3ThRsvPkR63aDCg7i5nUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JChyktMYYOT1oRLgLV5htQbOXhLj5QolZDT5YzNs+S212L/MkMDwsrHMkQCl6CZqJ
	 agff39FPNVnphciJskx/naco4KeMSzQpj896CC4D3WXPUSI15mtWtVR3gxKU0D2UFX
	 dSBUtiJuA5ZwGSet0s0YVQEFYCqXEQJESY1Scemw=
Date: Thu, 18 Jan 2024 16:48:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacob Lott <jklott.git@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Add more details to Kconfig help
Message-ID: <2024011854-hardship-undivided-b714@gregkh>
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

Please wrap your lines at 72 columns.

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

No tab?  Didn't checkpatch complain about this when you ran it on this
patch?

> +	  This driver facilitates communication between the Linux kernel and the Realtek
> +	  PCI-E card reader.
>  
> -	  If this driver is compiled as a module, it will be named rts5208.
> +	  If you opt to compile this driver as a module, it will be named rts5208. Selecting
> +	  N will exclude this driver from the kernel build. Choose option Y if your system includes
> +	  the Realtek PCI-E card reader rts5208/rts5288. When in doubt, it is generally safe
> +	  to select N.

Wrap your lines properly here at 80 columns.

thanks,

greg k-h

