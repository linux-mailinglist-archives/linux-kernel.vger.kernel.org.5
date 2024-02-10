Return-Path: <linux-kernel+bounces-60361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244FE8503EC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DDFBB242D2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 10:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E656C364D5;
	Sat, 10 Feb 2024 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ASHIYiDl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6D539C;
	Sat, 10 Feb 2024 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707560882; cv=none; b=B9g69m5GUApwjcwELGH5OdLG36fnlVA4HV7DFnXeUlIx8gP5Mn3hwDvUhBaf+tnOPeghEVLZ8ko24o6afWA30p0YgZFASM85Hkk7cd22znOXntBkqu/BAkrviCIDxgmgdwggi9sfR4QFG4MkuUAbXn0sUbz+aKxNabENb7CZqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707560882; c=relaxed/simple;
	bh=A+hSr2K87yVCazRNOYr09pB+t+4coVba0QUB+8jbQXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cluXGvDzXupzn6rdOBjNzlgN0N9A5nFNd3EgGgqAmOZLHlkC23mAbUCgwXHlhiSUP/jtlqaPQqvSkF3fNa8X9Z8EoeItPZRyvMISSr2DLNLTdo6kZuCgyZDF4fVOw6PB6OQXPSF+GoAIYOEv/ijAqzAAj7ccKdcs9sRxecGrCOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ASHIYiDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A42EC433F1;
	Sat, 10 Feb 2024 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707560881;
	bh=A+hSr2K87yVCazRNOYr09pB+t+4coVba0QUB+8jbQXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ASHIYiDl93z5XptADsvR8tTQS2eUM/IAGTAsXXIPNl0Qt/W6oVMkK7zcdvuaMZ4Fm
	 4SeV+NUwIbTKflHlvXFzMKF5mKMo4xvvby+/wk7wdQXsGTTakE0OIY5A2G+6OW5wk7
	 y702u5mPEw+ohJOQD9OS6Mdk22aFUG0suzWQnky0=
Date: Sat, 10 Feb 2024 10:27:58 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: niko.mauno@vaisala.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	vesa.jaaskelainen@vaisala.com, geert@linux-m68k.org
Subject: Re: [PATCH] usb: core: Kconfig: Improve USB authorization mode help
Message-ID: <2024021043-nursing-unbridle-cea4@gregkh>
References: <20240209142951.27195-1-niko.mauno@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209142951.27195-1-niko.mauno@vaisala.com>

On Fri, Feb 09, 2024 at 04:29:51PM +0200, niko.mauno@vaisala.com wrote:
> From: Niko Mauno <niko.mauno@vaisala.com>
> 
> Update the default USB device authorization mode help text so that the
> meaning of the option and it's available values are described more
> accurately.
> 
> Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
> ---

Shouldn't there be a "Reported-by:" line here to give proper credit for
the developer who asked for this?



>  drivers/usb/core/Kconfig | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
> index f337aaea7604..4665df550d36 100644
> --- a/drivers/usb/core/Kconfig
> +++ b/drivers/usb/core/Kconfig
> @@ -126,10 +126,21 @@ config USB_DEFAULT_AUTHORIZATION_MODE
>  	  Select the default USB device authorization mode. Can be overridden
>  	  with usbcore.authorized_default command line or module parameter.
>  
> -	  The available values have the following meanings:
> -		0 is unauthorized for all devices
> -		1 is authorized for all devices (default)
> -		2 is authorized for internal devices
> +	  This option allows you to choose whether USB devices that are
> +	  connected to the system can be used by default, or if they are
> +	  locked down.
> +
> +	  With value 0 all connected USB devices with the exception of root
> +	  hub require user space authorization before they can be used.
> +
> +	  With value 1 (default) no user space authorization is required to
> +	  use connected USB devices.
> +
> +	  With value 2 all connected USB devices with exception of internal
> +	  USB devices require user space authorization before they can be
> +	  used. Note that in this mode the differentiation between internal
> +	  and external USB devices relies on ACPI, and on systems without
> +	  ACPI selecting value 2 is analogous to selecting value 0.
>  
>  	  If the default value is too permissive but you are unsure which mode
>  	  to use, say 2.

In looking this over, this last sentance really isn't a good suggestion,
as it will turn people's machine into one that by default, doesn't
accept external USB devices, which is probably NOT what they want at
all, and is NOT how Linux has worked for the past 20+ years.

So maybe a bit better clarification as what the normal default should be
here?

thanks,

greg k-h

