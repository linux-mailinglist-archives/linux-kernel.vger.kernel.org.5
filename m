Return-Path: <linux-kernel+bounces-167389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 828528BA8D8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4896B213A8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB9714A0B3;
	Fri,  3 May 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMSq2D6g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE5F256D;
	Fri,  3 May 2024 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725339; cv=none; b=TrtXphBUgVuJrzEXqZ7oVLCV2ZvEKDtb/Bz4vZUJT3lVsc9EdcUYv3XSZZLgRbumoDveaZUI61kkO98fxSwcS6gvD6Yvw9rAecWVV320X3FPHI8AlHRmUo11bIShJLsDEbppfneVKhJCi49Ik271aoGNqEVuZZ1RMs/HJqc0HXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725339; c=relaxed/simple;
	bh=oYoXBaepxrJr5EoCU8mDU5X+2+X70FUndJR12vKlwd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+qqJbLXyth4B4OtMNn6mwpNt8N9PCDilehbAaAVv5ATFrH91BTZoBCBzFr26Fq7Nw7mTFs2PFUNfz5yWDGQWUbkcO3nYgpLyszFFfVbCCf7+gViaz82ITj3NmTyZbLrd9Uco+Q6m9GYSPpTMb0yN3ovMCeWIeLmRCJwaR44ERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMSq2D6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCDBC116B1;
	Fri,  3 May 2024 08:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714725338;
	bh=oYoXBaepxrJr5EoCU8mDU5X+2+X70FUndJR12vKlwd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMSq2D6gqFnvK6n1qRKkPTjtFweV//RV/4QjUqc7CEWSynWzEqjp5SokOZ7195jyI
	 g8+IauRlKjbAFipXNqjF3pTIW6vEPkv07Zx4kJsI+nXZtn6n+sCRIZrTo5RelbLcS7
	 VOffA4d+96Ztoh1tUgTy3HCRqoOf9YqSwGRj1a5Ukc0SmAO6W8FCplQolhGU/Np8ov
	 hpC5UPlpaKVIg91sz5sA86nDrDV3nOJBABiNJQwuzLQOQ+1RTWjuXsBusB/nxQmKRN
	 5pblM4S2O6oLPyIvfITvJJ6FE0mzdPzbySEjtq+4b3kwzd4eeVPZ7ymCytsZcRJpj8
	 zdvhWy6+kqBIQ==
Date: Fri, 3 May 2024 09:35:34 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v17 12/13] realtek: Update the Makefile and
 Kconfig in the realtek folder
Message-ID: <20240503083534.GL2821784@kernel.org>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
 <20240502091847.65181-13-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502091847.65181-13-justinlai0215@realtek.com>

On Thu, May 02, 2024 at 05:18:46PM +0800, Justin Lai wrote:
> 1. Add the RTASE entry in the Kconfig.
> 2. Add the CONFIG_RTASE entry in the Makefile.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/Kconfig  | 17 +++++++++++++++++
>  drivers/net/ethernet/realtek/Makefile |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
> index 93d9df55b361..57ef924deebd 100644
> --- a/drivers/net/ethernet/realtek/Kconfig
> +++ b/drivers/net/ethernet/realtek/Kconfig
> @@ -113,4 +113,21 @@ config R8169
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called r8169.  This is recommended.
>  
> +config RTASE
> +	tristate "Realtek Automotive Switch 9054/9068/9072/9075/9068/9071 PCIe Interface support"
> +	depends on PCI
> +	select CRC32

Hi Justin,

I believe that you also need:

	select PAGE_POOL

As the driver uses page_pool_alloc_pages()

FWIIW, I observed this when using a config based on make tinyconfig with
PCI and NET enabled, all WiFi drivers disabled, and only and only this Ethernet
driver enabled.

> +	help
> +	  Say Y here if you have a Realtek Ethernet adapter belonging to
> +	  the following families:
> +	  RTL9054 5GBit Ethernet
> +	  RTL9068 5GBit Ethernet
> +	  RTL9072 5GBit Ethernet
> +	  RTL9075 5GBit Ethernet
> +	  RTL9068 5GBit Ethernet
> +	  RTL9071 5GBit Ethernet
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called rtase. This is recommended.

The advice above to chose Y and M seem to conflict.
Perhaps this can be edited somehow.

> +
>  endif # NET_VENDOR_REALTEK
> diff --git a/drivers/net/ethernet/realtek/Makefile b/drivers/net/ethernet/realtek/Makefile
> index 2e1d78b106b0..0c1c16f63e9a 100644
> --- a/drivers/net/ethernet/realtek/Makefile
> +++ b/drivers/net/ethernet/realtek/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_8139TOO) += 8139too.o
>  obj-$(CONFIG_ATP) += atp.o
>  r8169-objs += r8169_main.o r8169_firmware.o r8169_phy_config.o
>  obj-$(CONFIG_R8169) += r8169.o
> +obj-$(CONFIG_RTASE) += rtase/
> -- 
> 2.34.1
> 
> 

