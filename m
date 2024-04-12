Return-Path: <linux-kernel+bounces-141949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DFE8A256E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562B91C2226C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E817BDD;
	Fri, 12 Apr 2024 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fPLuL2Aj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBB2F4A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898571; cv=none; b=fwh0wEGenn62l0adxabAGHvWyeoAhtyqEJ2ckYmOE90YNPFQjUOP18ab9B1eaOJOFaP8Abb/i0QCPvVO+Pc2qUOZ1QhLT2+K2OBF3e//mUaraOVreN3gWyPWVNe7IqOSr0+KtvVog+meI6Xu8XYe1Xxk+U/uUB9coaOl9mnXUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898571; c=relaxed/simple;
	bh=MKNCtwSQJuB4c5LHlnL0fln7IJzQZxo9/zbNyOoJa/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUCyDnniX39zGwrMnt9KuQpjyjKMD7EOAv6w2vXmf/ANDsZi1j1ou9y9ia2aJBbikyN0ioIcm9GB/GUCR3Mg+dGEs0hI8q0niCKJ3Bl6/EegQzAHGAfAeJdyYx+yYTe1D7sp45/31vX30z24T9bAXvNOj/fDoxF6iN4Q02bjDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fPLuL2Aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD69C2BBFC;
	Fri, 12 Apr 2024 05:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712898571;
	bh=MKNCtwSQJuB4c5LHlnL0fln7IJzQZxo9/zbNyOoJa/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPLuL2Aj7KxVeIof60tzda09pZHgjNBm6ynQgAo+EDi4tdfgO21E+IxT1RMVCSYR4
	 ywtm1OvGINDZ16pgzd9jwx+HPnViNLcc4fKL9/ZwZJKLiNghtHW2fzkkXNgaDc0h8+
	 mkit6n9Wj8jdBUjx7T3qGDJeJHH7mRCugjzdNkX8=
Date: Fri, 12 Apr 2024 07:09:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v1] misc: sgi_gru: indent SGI_GRU option help text
Message-ID: <2024041235-seizing-thirty-6ce9@gregkh>
References: <20240412050502.65326-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412050502.65326-1-ppandit@redhat.com>

On Fri, Apr 12, 2024 at 10:35:02AM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Fix indentation of SGI_GRU option's help text by adding
> leading spaces. Generally help text is indented by couple
> of spaces more beyond the leading tab <\t> character.
> It helps Kconfig parsers to read file without error.
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  drivers/misc/Kconfig | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> v1:
>   - s/\t/ / at line #431
>   - CC public mailing list

v1 was the private version you sent, this is v2, right?




> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 4fb291f0bf7c..a6565c42a7b9 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -293,21 +293,21 @@ config SGI_GRU
>  	depends on X86_UV && SMP
>  	select MMU_NOTIFIER
>  	help
> -	The GRU is a hardware resource located in the system chipset. The GRU
> -	contains memory that can be mmapped into the user address space. This memory is
> -	used to communicate with the GRU to perform functions such as load/store,
> -	scatter/gather, bcopy, AMOs, etc.  The GRU is directly accessed by user
> -	instructions using user virtual addresses. GRU instructions (ex., bcopy) use
> -	user virtual addresses for operands.
> +	  The GRU is a hardware resource located in the system chipset. The GRU
> +	  contains memory that can be mmapped into the user address space.
> +	  This memory is used to communicate with the GRU to perform functions
> +	  such as load/store, scatter/gather, bcopy, AMOs, etc.  The GRU is
> +	  directly accessed by user instructions using user virtual addresses.
> +	  GRU instructions (ex., bcopy) use user virtual addresses for operands.
>  
> -	If you are not running on a SGI UV system, say N.
> +	  If you are not running on a SGI UV system, say N.
>  
>  config SGI_GRU_DEBUG
>  	bool  "SGI GRU driver debug"
>  	depends on SGI_GRU
>  	help
> -	This option enables additional debugging code for the SGI GRU driver.
> -	If you are unsure, say N.
> +	  This option enables additional debugging code for the SGI GRU driver.
> +	  If you are unsure, say N.
>  
>  config APDS9802ALS
>  	tristate "Medfield Avago APDS9802 ALS Sensor module"
> @@ -428,7 +428,7 @@ config LATTICE_ECP3_CONFIG
>  	tristate "Lattice ECP3 FPGA bitstream configuration via SPI"
>  	depends on SPI && SYSFS
>  	select FW_LOADER
> -	default	n
> +	default n

This line should just be deleted in a separate patch as it is the
default.

Can you do this as a patch series for v3 please?

thanks,

greg k-h

