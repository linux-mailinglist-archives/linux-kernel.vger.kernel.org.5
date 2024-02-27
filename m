Return-Path: <linux-kernel+bounces-82463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 079928684F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391B51C20FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63457FF;
	Tue, 27 Feb 2024 00:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AGAbgpqS"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DE161;
	Tue, 27 Feb 2024 00:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708993439; cv=none; b=reMDjk/olIJOTFnWr+sMHnw2FAl+0rAgy0xcZyvEGOvWA2SpISxIA/i+woW6FB3I9crOpvTEJwHVhD2xhHv74vM4Wd6UedAea4lWLSYMOGyjqFS37QPPv5EWBfrn4jPbtOEkEMr8e5/TMcOLxdzuvuE89A/FKEiNH0hb5pcWKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708993439; c=relaxed/simple;
	bh=/R2KGYx4M73EQiEpagehkCmiSlAuBSA3ugAShXVnUzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myIeN+HG/0xb8L4jT6RJz3QwSB9u+cI/mLsY9fCtKyQORgUeTPdVuXpybaId7XxEuAfqQ5g8rUZpWeyvKA+5+kdW/WRRrxd01NZaPn2CF/4vWOLezl7KbrrZ1i3P6U8HN6PZl9hooe93nvDUbUY6HQanBZh7dt8BEEYl5Ly4tfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AGAbgpqS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=hZSVzQu3bZY/XxOV798gnatyz5RNs3nX5VK/VPEQ5F4=; b=AGAbgpqSJN0PNMbkqgRXAf2zyn
	DqLI7mxvbx4vZWaXyqCAenoM/+3kQN1kbvh6mXsJsjD0CStM6uIXVdVeOrJUy+4L217BXaobxX8UC
	t7Lp5wggQZNNGz70h1JK2IgfbBUhwePC48VoogydpT2M5KXRHtXXEoa7tIhWYDiZv/XN4XD0zg8L+
	1YLo2o2btpOueNSiclekbbzyxRWfAec19OSMDjq8XjI9aocNpYMY1P11JqvYAfVWRxKxKdjgrGtmW
	2ayUr2stDENxw3fwS8K7/ypykg6h3wq091xMsk/ARjjtD3mPOOY0UhRhcDDZZsrwkhgCb19LM1GbS
	2GM8HIfA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1relGD-000000035RB-2XFi;
	Tue, 27 Feb 2024 00:23:53 +0000
Message-ID: <ed115040-5417-4770-a9b7-43b5350851b9@infradead.org>
Date: Mon, 26 Feb 2024 16:23:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethernet: adi: Move select PHYLIB from NET_VENDOR_ADI
 to ADIN1110
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <99d4d711acfc020c8987e96145f2f1f323cbaa3b.1708947112.git.geert@linux-m68k.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <99d4d711acfc020c8987e96145f2f1f323cbaa3b.1708947112.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geert,

On 2/26/24 03:34, Geert Uytterhoeven wrote:
> The NET_VENDOR_* Kconfig options are used as gatekeepers.  Merely
> enabling such an option must not enable any other extra code.
> 
> Fixes: a9f80df4f5144030 ("net: ethernet: adi: requires PHYLIB support")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/net/ethernet/adi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/adi/Kconfig b/drivers/net/ethernet/adi/Kconfig
> index c91b4dcef4ec2f5f..760a9a60bc15c184 100644
> --- a/drivers/net/ethernet/adi/Kconfig
> +++ b/drivers/net/ethernet/adi/Kconfig
> @@ -7,7 +7,6 @@ config NET_VENDOR_ADI
>  	bool "Analog Devices devices"
>  	default y
>  	depends on SPI
> -	select PHYLIB
>  	help
>  	  If you have a network (Ethernet) card belonging to this class, say Y.
>  
> @@ -22,6 +21,7 @@ config ADIN1110
>  	tristate "Analog Devices ADIN1110 MAC-PHY"
>  	depends on SPI && NET_SWITCHDEV
>  	select CRC8
> +	select PHYLIB
>  	help
>  	  Say yes here to build support for Analog Devices ADIN1110
>  	  Low Power 10BASE-T1L Ethernet MAC-PHY.

I sent the same patch last night (local time):
https://lore.kernel.org/lkml/20240226074820.29250-1-rdunlap@infradead.org/

Hopefully one of them can be merged soon.

-- 
#Randy

