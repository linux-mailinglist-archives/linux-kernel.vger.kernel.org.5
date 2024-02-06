Return-Path: <linux-kernel+bounces-54627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F3A84B1B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C7A1F244C8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9275F12D776;
	Tue,  6 Feb 2024 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kkyj0Nmt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D660212D75F;
	Tue,  6 Feb 2024 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213525; cv=none; b=jxAYmqVeoecSkL3iq9msKeywUqfWZ8+OE18K0DA3PcVjWuRNMvumThP3O2KLea+yagOej//3xzhGrDbZTToU8WdSxenAF+1BMSdesdpS3FLw0fvRPGFo7E3OaO40g38jz0PA3rEjXTAU2MRJfo3a6TIK4KHDBK7TxamyuCD1N/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213525; c=relaxed/simple;
	bh=KIw9pkwtzkhaYD3K7hUNGz3stRQS87xMY9nZNhbOoZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdmoW5nNo8x92jQO/OnVybcWyeOuRSM3w3Mn2bfEMDCaIvJWGUasj74Yxkim/UiloPOaPOVqzAyr+ZdpxnXuKwzoe6Inb8oxqWOuOZGBiLkPPXz9UoiBr/YUbLwVLDhTqgKeSckZVi/UYlVTUzLxP+07aP9WctigrWC5PyqAY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kkyj0Nmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6CDC433F1;
	Tue,  6 Feb 2024 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707213525;
	bh=KIw9pkwtzkhaYD3K7hUNGz3stRQS87xMY9nZNhbOoZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kkyj0Nmtn5Vq9L1QSAB8+ysOyWl8xHDC/o6ySNtFlntKlNnSKHzlR/ekfHAbnlQ4D
	 Y2GkK3MqW//zdj9DGqyGVd4SJp2INPWmQW+Om9xgb3291nR5D2w6KHbt4xTXRMAYCA
	 BtSEolJQ6BGHl6EvvLR+t8Ni6WfBquO6jBOsTaGUx+kCAAr7WT8/WWThrCh4zdAdcE
	 +OwIqwlI0KxT7cSZesx5AKouDp5lx8EVsrDv0U+AG8gNWSsjFJgFXqon3aiQuuipRv
	 MQYowdIRiwhHlxm0hsGlnmbNP5/EhsFApmavZNr/aQeGbt97v/gFjMio4Z97+DwvP8
	 msOrTreFrUX/w==
Date: Tue, 6 Feb 2024 10:58:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ata: pata_parport: make pata_parport_bus_type const
Message-ID: <ZcICztae//cs8tep@x1-carbon>
References: <20240204-bus_cleanup-ata-v1-1-2bdc1fadf356@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-ata-v1-1-2bdc1fadf356@marliere.net>

On Sun, Feb 04, 2024 at 12:23:29PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the pata_parport_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/ata/pata_parport/pata_parport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
> index a7adfdcb5e27..9a2cb9ca9d1d 100644
> --- a/drivers/ata/pata_parport/pata_parport.c
> +++ b/drivers/ata/pata_parport/pata_parport.c
> @@ -464,7 +464,7 @@ static void pata_parport_bus_release(struct device *dev)
>  	/* nothing to do here but required to avoid warning on device removal */
>  }
>  
> -static struct bus_type pata_parport_bus_type = {
> +static const struct bus_type pata_parport_bus_type = {
>  	.name = DRV_NAME,
>  };
>  
> 
> ---
> base-commit: c8474c7273ac3bad718c33118aa82efb7b374f6e
> change-id: 20240204-bus_cleanup-ata-bd1625fdab09
> 
> Best regards,
> -- 
> Ricardo B. Marliere <ricardo@marliere.net>
> 

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.9

