Return-Path: <linux-kernel+bounces-79373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3C686214F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A346B211BE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9E71864;
	Sat, 24 Feb 2024 00:49:22 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B2139D;
	Sat, 24 Feb 2024 00:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708735762; cv=none; b=cmRu2iO4NoWwYzvhi8RovZNclggNJc26G3WeeL4Zp/rX5Dwn4+b0GI2yPYMrfady1E04DebMYLNOoMQJmKXazkTW62v2SszI6XiaRoXlaQO8aGP+HYvQGC0Pq/j6RfZJ7TZ/cviTzHQAZIY8oyMztYlvgj0AAEDWWYBXT2wHSGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708735762; c=relaxed/simple;
	bh=nbmZWpPqfG/KrNGegvMUC1ADVAxjqbKT0SXh/9sYYNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzGZPyvwFwy+zeuqeWM7Jnv0d5U+ZQw+kOsGEFc73IyI8V8ObXK+Pd48s4kClOnvvGBPjaQvbsR3uIVplwkT8YL9j+6zJqO5E4Zwr8yUXbz2ZF3P6qj8pmq0x0t+LQGyoIxH1af28qQHPcrzAxph3oxewRylr4TN6v6ErQ1bAro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rdgE0-00HDuA-NK; Sat, 24 Feb 2024 08:49:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 24 Feb 2024 08:49:23 +0800
Date: Sat, 24 Feb 2024 08:49:23 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com, sfr@canb.auug.org.au,
	damian.muszynski@intel.com, mun.chun.yep@intel.com,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] Documentation: qat: fix auto_reset section
Message-ID: <Zdk9Eyoy0ko3Qwm+@gondor.apana.org.au>
References: <20240212130532.50350-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212130532.50350-1-giovanni.cabiddu@intel.com>

On Mon, Feb 12, 2024 at 01:05:09PM +0000, Giovanni Cabiddu wrote:
> Remove unneeded colon in the auto_reset section.
> 
> This resolves the following errors when building the documentation:
> 
>     Documentation/ABI/testing/sysfs-driver-qat:146: ERROR: Unexpected indentation.
>     Documentation/ABI/testing/sysfs-driver-qat:146: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Fixes: f5419a4239af ("crypto: qat - add auto reset on error")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-kernel/20240212144830.70495d07@canb.auug.org.au/T/
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-qat | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

