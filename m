Return-Path: <linux-kernel+bounces-73098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD7185BD97
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBEF2863C5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40D56BFC6;
	Tue, 20 Feb 2024 13:48:54 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9127F69DF5;
	Tue, 20 Feb 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436934; cv=none; b=LOoucKdKh3ktGp6P3rYTCB7GX+nl0R7zUCDRUltjjrB9NZwFn+C9bw9AUn8sqsau+ZlJoi72aOe5+2KAeITZBoIAF8yX+xAM1zK7wQcNKJlEK+hp832RjXfE8UXtO5ag2dMp2klwAhKZq1uEC+n2ZeAg7Ox3NPsaTelrJ+FCki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436934; c=relaxed/simple;
	bh=R8CQ9W7KiCJlUPJJxbdnZY4IKamu9E2eH9DKa/kjNuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAxAT2u8ZcvGI/gsx8KY6+ihSvjvJesVJaDyJihAN5wMG3MEWG9QcV4fo/o9YinTfG9i5FQ5noUUlEW6pBhcSxVGBUoWWNrXPxJ2dlzfqwUS42S0NfcoHWxRTxai+XCHXSvqcCMajzbtj0sKC9+aaUZsI0/NRrT5VNKGzmHbGy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rcQUF-0007OK-00; Tue, 20 Feb 2024 14:48:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 22855C0A1E; Tue, 20 Feb 2024 14:48:33 +0100 (CET)
Date: Tue, 20 Feb 2024 14:48:33 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: merge CONFIG_MACH_TX49XX entries
Message-ID: <ZdStsYqTkYBhCS4M@alpha.franken.de>
References: <20240204141446.65055-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204141446.65055-1-masahiroy@kernel.org>

On Sun, Feb 04, 2024 at 11:14:45PM +0900, Masahiro Yamada wrote:
> The 'config MACH_TX49XX' entry exists in arch/mips/Kconfig with a
> prompt and one select statement, also in arch/mips/txx9/Kconfig with
> the other select statements.
> 
> Commit 8f8da9adebdf ("[MIPS] TXx9: Kconfig cleanup") added the second
> entry to arch/mips/txx9/Kconfig.
> 
> There is no reason to split it in the two locations.
> 
> Merge them into the entry in arch/mips/txx9/Kconfig.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/mips/Kconfig      | 4 ----
>  arch/mips/txx9/Kconfig | 3 ++-
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index a70b4f959fb1..b7c62f8d612e 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -881,10 +881,6 @@ config SNI_RM
>  	  Technology and now in turn merged with Fujitsu.  Say Y here to
>  	  support this machine type.
>  
> -config MACH_TX49XX
> -	bool "Toshiba TX49 series based machines"
> -	select WAR_TX49XX_ICACHE_INDEX_INV

this is inside the choice for selecting the platform. Removing it here
breaks the build. IMHO the merge must be here.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

