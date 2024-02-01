Return-Path: <linux-kernel+bounces-47670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936F4845105
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC5C285BFD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64B978B76;
	Thu,  1 Feb 2024 05:51:56 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E464A80;
	Thu,  1 Feb 2024 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766716; cv=none; b=bVKVN984CVwq/fl1LS81ZCdEQVz6bqwh/tWrsxk80HTe0vi+yW4v2+apT4J0NVA6QEpyPY+YiWNGLOiXOcge85Qmy+R/303irSu1fgxHUjBScMoXxmAR4GpU8BXOn9HQuQgQ815561omHdLfVuGRbd8qulFhgXejQJgsET2lGN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766716; c=relaxed/simple;
	bh=pB7E6jsVPvH8FyHd5rIlreiMws7ij1lqrILC5DieAGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb06LFHBXT4LXBFOyTqEW8bTqgFFgy9A8lFXlZqotsA1gPxP4NSuKTJ9kL7pBE0fQDDOEb8FvvIVaaQj5wnyYF6LK709Ay8C4cy8+P20wZ3bxkYOTsSSB38fnR2oD0jgeYLh/SYp9ODXsyzyjQdFZ1UkZ42qenH/exvqFnFAXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rVPzD-008Ubc-Uc; Thu, 01 Feb 2024 13:51:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 01 Feb 2024 13:51:57 +0800
Date: Thu, 1 Feb 2024 13:51:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Danny Tsen <dtsen@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust file entries after crypto vmx file
 movement
Message-ID: <ZbsxfYVKqxwn5gl5@gondor.apana.org.au>
References: <20240129131729.4311-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129131729.4311-1-lukas.bulwahn@gmail.com>

On Mon, Jan 29, 2024 at 02:17:29PM +0100, Lukas Bulwahn wrote:
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb944964be5..15bc79e80e28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10307,12 +10307,12 @@ M:	Nayna Jain <nayna@linux.ibm.com>
>  M:	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
>  L:	linux-crypto@vger.kernel.org
>  S:	Supported
> -F:	drivers/crypto/vmx/Kconfig
> -F:	drivers/crypto/vmx/Makefile
> -F:	drivers/crypto/vmx/aes*
> -F:	drivers/crypto/vmx/ghash*
> -F:	drivers/crypto/vmx/ppc-xlate.pl
> -F:	drivers/crypto/vmx/vmx.c
> +F:	arch/powerpc/crypto/Kconfig
> +F:	arch/powerpc/crypto/Makefile
> +F:	arch/powerpc/crypto/aes*

Are you sure about this? There are non-vmx aes* files in that
directory.  Perhaps something more specific is needed here?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

