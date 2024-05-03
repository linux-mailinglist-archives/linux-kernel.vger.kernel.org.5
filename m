Return-Path: <linux-kernel+bounces-167531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2B18BAAEC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F500282DDB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AEC152781;
	Fri,  3 May 2024 10:42:41 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDEA15250C;
	Fri,  3 May 2024 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732961; cv=none; b=UvV6S691oS1THcXy+0BsSHQOekBA/KzdyVqlQCbkoj+MDfOefRbw2U3NXW09MiPFYeeNngcZBkp7xJyn9QH/cSvutirpeztaMES3k8dd82vtff8MvjJbkBkewhWh7QmKpWvkQGnbwbUjaufpRZ+cE0AZCg0JOXR+V1OSTCRkUrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732961; c=relaxed/simple;
	bh=IF0o7c41DFafCgpye59ZvL3nnFXY6ts7lGfBd2TDJ10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khtbkO3gaUXHNSM0XGTvN9K5YzW7qAWDOQNe/PNQ4OncpLyotAgiOuCyzE+jqSxnmqLHSd7bmvTYMYOWu0Uo71huPjUEzamnEbFuhdn4GpdwPwfBgMEUv3UOaEg8/au1mM0D35fhomJLndcYKU1auImVOschKHn/UQSU71CEk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s2qMw-009vKi-2g;
	Fri, 03 May 2024 18:42:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 May 2024 18:42:23 +0800
Date: Fri, 3 May 2024 18:42:23 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: davem@davemloft.net, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] crypto: atmel-sha204a - remove unused includes
Message-ID: <ZjS_j-s6F2h3jflL@gondor.apana.org.au>
References: <20240427001439.12726-1-l.rubusch@gmail.com>
 <20240427001439.12726-3-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427001439.12726-3-l.rubusch@gmail.com>

On Sat, Apr 27, 2024 at 12:14:36AM +0000, Lothar Rubusch wrote:
> Remove unnecessarily included headers.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/crypto/atmel-sha204a.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
> index c77f482d2..5c3fef6e9 100644
> --- a/drivers/crypto/atmel-sha204a.c
> +++ b/drivers/crypto/atmel-sha204a.c
> @@ -5,17 +5,8 @@
>   * Copyright (c) 2019 Linaro, Ltd. <ard.biesheuvel@linaro.org>
>   */
>  
> -#include <linux/delay.h>
> -#include <linux/device.h>
> -#include <linux/err.h>
> -#include <linux/errno.h>
>  #include <linux/i2c.h>
> -#include <linux/init.h>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/scatterlist.h>
> -#include <linux/slab.h>
> -#include <linux/workqueue.h>
>  #include "atmel-i2c.h"

These do not seem to be redundant.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

