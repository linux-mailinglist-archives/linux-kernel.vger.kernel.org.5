Return-Path: <linux-kernel+bounces-30228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18063831BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 792FAB26284
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9931DA3B;
	Thu, 18 Jan 2024 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZlETpj+u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B9439B;
	Thu, 18 Jan 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589505; cv=none; b=ZKuvVPmO+HtmKa9qPGdWtR3dpiw1bi29SJ2BEBFEKvDNloFP3xumr7l9I8wvxxCo2DvRkaLIGoCZSYlVRjiVyUyOk70zJsXT+Vg0b3iitUdJSdY/S/xrObJDsLOn52x6oQPAa8ZWhVARiPlV3fBsG86nv2d/QCfbjRbswVS8eRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589505; c=relaxed/simple;
	bh=sxik3Bd+uEArtL+u+/GfOU7QQ9XdRR+jLrak/mZRDX0=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=gNqe+VK8cidDqFzWKKFrCHsRI1mNPghdqp+ZRAKDt9nkcKEilFTb7fBp+q/aakhXz9IhUnPQ9FUZJIBmeMk3kDljF0xTmVWvEPcnO1XiUUfQFO0zEFddHVd3twXSJ+JuWx37JZzhx9Xb8wJMAia826TNg5je7j/JTUSYVZbURnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZlETpj+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D2CC433F1;
	Thu, 18 Jan 2024 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705589504;
	bh=sxik3Bd+uEArtL+u+/GfOU7QQ9XdRR+jLrak/mZRDX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlETpj+uEftppa7SN349ZlsUFnWEKboupqxfOrPiR9gU0DtMz1czOuDhfSuDa3oqB
	 oiN1S/p2UlXfsax95yw83A2bnlfFVhFm/lEr48ohSQuOp/FLcVTJNCkby6wPs+K66V
	 DLLNHlzTC7cSvZODeTaW4iuyqUlBVEf+fHS+FOAc=
Date: Thu, 18 Jan 2024 15:51:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacob Lott <jklott.git@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	wei_wang@realsil.com.cn, micky_ching@realsil.com.cn
Subject: Re: [PATCH] staging: rts5208: Fix coding style issues
Message-ID: <2024011809-upstart-provider-6c88@gregkh>
References: <03b524b7-8e66-4180-b22a-aa641acbaac3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03b524b7-8e66-4180-b22a-aa641acbaac3@gmail.com>

On Thu, Jan 18, 2024 at 09:42:51AM -0500, Jacob Lott wrote:
> Help text in a module should describe the module and give
> some guidance on whether or not to enable it.
> 
> The BIT macro should be used instead of 1UL << n. This
> makes the code more readable and easier to maintain.
> 
> Signed-off-by: Jacob Lott <jklott.git@gmail.com>
> ---
>  drivers/staging/rts5208/Kconfig     | 10 +++++++---
>  drivers/staging/rts5208/rtsx_card.h |  4 ++--
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/Kconfig
> b/drivers/staging/rts5208/Kconfig
> index b864023d3ccb..bb293cbf6230 100644
> --- a/drivers/staging/rts5208/Kconfig
> +++ b/drivers/staging/rts5208/Kconfig
> @@ -3,7 +3,11 @@ config RTS5208
>         tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
>         depends on PCI && SCSI
>         help
> -         Say Y here to include driver code to support the Realtek
> -         PCI-E card reader rts5208/rts5288.
> +      Choose Y here to enable support for the Realtek PCI-E card reader
> RTS5208/5288.
> +         This driver facilitates communication between the Linux kernel and
> the Realtek
> +         PCI-E card reader.
> 
> -         If this driver is compiled as a module, it will be named rts5208.
> +         If you opt to compile this driver as a module, it will be named
> rts5208. Selecting
> +         N will exclude this driver from the kernel build. Choose option Y
> if your system includes
> +         the Realtek PCI-E card reader rts5208/rts5288. When in doubt, it
> is generally safe
> +         to select N.
> diff --git a/drivers/staging/rts5208/rtsx_card.h
> b/drivers/staging/rts5208/rtsx_card.h
> index 39727371cd7a..9d2504fddb13 100644
> --- a/drivers/staging/rts5208/rtsx_card.h
> +++ b/drivers/staging/rts5208/rtsx_card.h
> @@ -338,7 +338,7 @@
>  #define DMA_DIR_FROM_CARD              0x02
>  #define DMA_EN                         0x01
>  #define DMA_128                                (0 << 4)
> -#define DMA_256                                (1 << 4)
> +#define DMA_256                                BIT(4)
>  #define DMA_512                                (2 << 4)
>  #define DMA_1024                       (3 << 4)
>  #define DMA_PACK_SIZE_MASK             0x30
> @@ -542,7 +542,7 @@
> 
>  #define BLINK_EN                       0x08
>  #define LED_GPIO0                      (0 << 4)
> -#define LED_GPIO1                      (1 << 4)
> +#define LED_GPIO1                      BIT(4)
>  #define LED_GPIO2                      (2 << 4)
> 
>  #define SDIO_BUS_CTRL          0x01
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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

