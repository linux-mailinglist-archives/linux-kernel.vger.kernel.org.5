Return-Path: <linux-kernel+bounces-79369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E442B862142
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9171C25196
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5025A17CE;
	Sat, 24 Feb 2024 00:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w///kqWz"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A4A59;
	Sat, 24 Feb 2024 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734868; cv=none; b=mmeeH/MgJBzoz2lcVZ8cf/T1xXy+5n5Mw48NLUdZNqxSEm1p7xFcH00m2e9Upxpa1UyUq9wAUUAumd/Wg74l0dUqRi1eMqQZsnulD7mgH2NPpq7u2GLDW8iPtTIiZelbM8nehuSaLOP627NYnijg2cUQkoIIqnSlunR5oBNuwb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734868; c=relaxed/simple;
	bh=NyZC7DMt9AaOWyzhLHalvlIineDokNGezKhcwMO0G0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlPcIVXDfXO5oH7Ux09nUbxu22DjiBiqIx5MRJt/hZIZrU/qCuBEtuqtf3i6K/X/n2zK9BTI46Ej+JaQTqInO6YsZ6Epe4PD6VQiXo6cDorzOUL854eT17oYF5z8K/rqOCE5+D2Jw3Dz0hwqR17jvDqczDWEnCfJbw5hS/LcmgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=w///kqWz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+78lHf6wE1V3WvNZO4eC3Ft1qvYeNcUsJdGOhWgLsHc=; b=w///kqWz7t4I9I5u3Ax8UN47Qh
	tgOJUr6O1eUMIuIJyXxuKnQ1ziqZslIU5GaIqI/djIYeEoc9mQbf7LXRKOiSxjtAYWedd9hcKe3SH
	1K0KR6TbPzUF83VqncPipDwAbRGOcCRjqmRDk/HljYzvcNJlQw07wtI1WPtDb7hXXLb7FhETQDZ8W
	ljzsvIkmN78gxdV9CZiR+1qKEuPLXAJwB+3fYdYJkHWILyCD2KhryCvZJHcQPR4dOWZA+Zd+jixyJ
	Fm6aN6pkq92EtpPu2yJkY9yOhSaIjaW/BASxRGJ/LPODLcFICL59hJpdRHRGLAuKbvCc+s7LDvcWM
	9LY+68mA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdfzl-0000000BhS0-0u0z;
	Sat, 24 Feb 2024 00:34:25 +0000
Message-ID: <874c4cbb-d904-4aa3-9c87-cb3d639d3661@infradead.org>
Date: Fri, 23 Feb 2024 16:34:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] sparc32: Fix parport build with sparc32
Content-Language: en-US
To: sam@ravnborg.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sparclinux@vger.kernel.org, linux-parport@lists.infradead.org,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
 <20240223-sam-fix-sparc32-all-builds-v1-6-5c60fd5c9250@ravnborg.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240223-sam-fix-sparc32-all-builds-v1-6-5c60fd5c9250@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/24 11:36, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> include/asm/parport.h is sparc64 specific.
> Rename it to parport_64.h and use the generic version for sparc32.
> 
> This fixed all{mod,yes}config build errors like:
> 
> parport_pc.c:(.text):undefined-reference-to-ebus_dma_enable
> parport_pc.c:(.text):undefined-reference-to-ebus_dma_irq_enable
> parport_pc.c:(.text):undefined-reference-to-ebus_dma_register
> 
> The errors occur as the sparc32 build references sparc64 symbols.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> Closes: https://lore.kernel.org/r/20230406160548.25721-1-rdunlap@infradead.org/
> Fixes: 66bcd06099bb ("parport_pc: Also enable driver for PCI systems")
> Cc: stable@vger.kernel.org # v5.18+

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/sparc/include/asm/parport.h    | 259 +-----------------------------------
>  arch/sparc/include/asm/parport_64.h | 256 +++++++++++++++++++++++++++++++++++
>  2 files changed, 263 insertions(+), 252 deletions(-)
> 


-- 
#Randy

