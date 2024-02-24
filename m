Return-Path: <linux-kernel+bounces-79368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD4986213E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590E51F261FC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F003B17C9;
	Sat, 24 Feb 2024 00:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tIe1yYW0"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62D64A;
	Sat, 24 Feb 2024 00:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734764; cv=none; b=KfNilr1NdMhQxuJizPPYw0AnUU5s0wSfGWropvKhAvrJBiDUysI6vQ99ZiePlP4oXnYUviE3i5o/NwgF3txnrXmrQ7MjWDkPRU4X8S9qZPWfI0snmBaARab1WaePC8JKlvViA9GuKk4D2n6Ekn8SCodCGxXwnQIW0qt9VLYE8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734764; c=relaxed/simple;
	bh=VrNohUUSx8cBnq5eU2CAEJgH3nu+6+ys7gg7/BNoZ4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGCqbcglFyPZu/LyT/WURxcuC8g6JIyinmxos4V5H4XydhgRZBe/P4rZcJ0ypYYRThMDz7KynuNNC3FX1lVRFx4IKQm4WaYR8REy3MKCTdmszdqBTHh4Ss+mda7dTddCC6ZS9W4n5Fe5e/zhXoLX/DUjDGsyOanjglPcTAkbZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tIe1yYW0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Dx7zrhHLsAdQeaJExVmm/VOXzleLyB01AMqnRTGdNKg=; b=tIe1yYW0CiTrdNgAsu0NhwnCee
	1IjE93h8YIgyAFuQNwQWV3kDXk9QsDjggo+hSZMGGHUfe99iyC6Y50PzFs/eICt3+neYG8kuEtFKV
	t8LNB4ovCzYB0khDej+bMa3gD42JPHfY9Hw4uFSe6auRV4gpoyEYbhhveAX79QLtB6udq/iWR88b2
	PsHxEWipY04BQE+rKjGXzIziNe+yuVX/mP7a8CFrZCRt7zll7cqph9JJyz8eo6DXDoYoX+7xXO/pX
	q+Tup+/IxZ0GNs/orI98haaog79NeXlbZTtf8vJqOvbnstDFlyMkQwfGgviN8YDkkyIR396+wsBNe
	BjSXJ/LQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdfy6-0000000BhCA-11Mi;
	Sat, 24 Feb 2024 00:32:42 +0000
Message-ID: <c22a19fa-6295-4392-a3fb-2a485a575291@infradead.org>
Date: Fri, 23 Feb 2024 16:32:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] sparc32: Do not select GENERIC_ISA_DMA
Content-Language: en-US
To: sam@ravnborg.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sparclinux@vger.kernel.org, linux-parport@lists.infradead.org,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
References: <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
 <20240223-sam-fix-sparc32-all-builds-v1-5-5c60fd5c9250@ravnborg.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240223-sam-fix-sparc32-all-builds-v1-5-5c60fd5c9250@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/24 11:36, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> sparc32 do not support generic isa dma, so do not select the symbol.
> Without this fix, the following patch would break the build with a
> missing prototype.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> Fixes: 66bcd06099bb ("parport_pc: Also enable driver for PCI systems")

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> ---
>  arch/sparc/Kconfig | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 734f23daecca..d08a5662ea60 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -138,10 +138,6 @@ config HIGHMEM
>  	default y if SPARC32
>  	select KMAP_LOCAL
>  
> -config GENERIC_ISA_DMA
> -	bool
> -	default y if SPARC32
> -
>  config PGTABLE_LEVELS
>  	default 4 if 64BIT
>  	default 3
> 

-- 
#Randy

