Return-Path: <linux-kernel+bounces-39856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B5483D6C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249211C2BE08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285EE14F55D;
	Fri, 26 Jan 2024 08:58:41 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4314F522;
	Fri, 26 Jan 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259520; cv=none; b=SslTdIbquBOz6miXEnKCyeAtPg3v3MUxlWBXkRByPCsOcZY89DyhR7dDRIkzqe1iiUldPuytOlI5NdatuaSNeSdxefWU4h9rXHQ5FoDmdtmwpoXYly0aCoipy17MvYRwOUND+Jn0zXss/U06CkyZQt5DojQ89yh8cr0uwtEhEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259520; c=relaxed/simple;
	bh=wot1yPJV87tUkM8CsZ2oaB+0f3xAXpRMa/ZMlXNaja8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efu3cpjveEOX4Xq9sY8vsqidY2lCRpiD2wZat98+cjp9ackNbpY80XIhy61N1jqy7q/zd1N8I1Np2OidEgs2hSNhrrC3FxmitGy2XnaxeuaSeacdKa46QcOUtzKUMPD/qdoJPzC/XEMkbhpZx1pB+nY0kSUnmyMmXaLsqZ3xNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTI2L-006EZR-QN; Fri, 26 Jan 2024 16:58:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 16:58:22 +0800
Date: Fri, 26 Jan 2024 16:58:22 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Danny Tsen <dtsen@linux.ibm.com>
Cc: linux-crypto@vger.kernel.org, leitao@debian.org, nayna@linux.ibm.com,
	appro@cryptogams.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
Subject: Re: [PATCH] crypto:vmx: Move ppc vmx diirectory to
 arch/powerpc/crypto.
Message-ID: <ZbN0LufXZ6YZmn3E@gondor.apana.org.au>
References: <20240102205856.370103-1-dtsen@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102205856.370103-1-dtsen@linux.ibm.com>

On Tue, Jan 02, 2024 at 03:58:56PM -0500, Danny Tsen wrote:
> Relocate all crypto files in vmx driver to arch/powerpc/crypto directory
> and remove vmx directory.
> 
> drivers/crypto/vmx/aes.c rename to arch/powerpc/crypto/aes.c
> drivers/crypto/vmx/aes_cbc.c rename to arch/powerpc/crypto/aes_cbc.c
> drivers/crypto/vmx/aes_ctr.c rename to arch/powerpc/crypto/aes_ctr.c
> drivers/crypto/vmx/aes_xts.c rename to arch/powerpc/crypto/aes_xts.c
> drivers/crypto/vmx/aesp8-ppc.h rename to arch/powerpc/crypto/aesp8-ppc.h
> drivers/crypto/vmx/aesp8-ppc.pl rename to arch/powerpc/crypto/aesp8-ppc.pl
> drivers/crypto/vmx/ghash.c rename to arch/powerpc/crypto/ghash.c
> drivers/crypto/vmx/ghashp8-ppc.pl rename to arch/powerpc/crypto/ghashp8-ppc.pl
> drivers/crypto/vmx/vmx.c rename to arch/powerpc/crypto/vmx.c
> 
> deleted files:
> drivers/crypto/vmx/Makefile
> drivers/crypto/vmx/Kconfig
> drivers/crypto/vmx/ppc-xlate.pl
> 
> This patch has been tested has passed the selftest.  The patch is also tested with
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled.
> 
> Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
> ---
>  arch/powerpc/crypto/Kconfig                   |  20 ++
>  arch/powerpc/crypto/Makefile                  |  20 +-
>  .../crypto/vmx => arch/powerpc/crypto}/aes.c  |   0
>  .../vmx => arch/powerpc/crypto}/aes_cbc.c     |   0
>  .../vmx => arch/powerpc/crypto}/aes_ctr.c     |   0
>  .../vmx => arch/powerpc/crypto}/aes_xts.c     |   0
>  .../vmx => arch/powerpc/crypto}/aesp8-ppc.h   |   0
>  .../vmx => arch/powerpc/crypto}/aesp8-ppc.pl  |   0
>  .../vmx => arch/powerpc/crypto}/ghash.c       |   0
>  .../powerpc/crypto}/ghashp8-ppc.pl            |   0
>  .../crypto/vmx => arch/powerpc/crypto}/vmx.c  |   0
>  drivers/crypto/Kconfig                        |  14 +-
>  drivers/crypto/Makefile                       |   2 +-
>  drivers/crypto/vmx/.gitignore                 |   3 -
>  drivers/crypto/vmx/Kconfig                    |  14 --
>  drivers/crypto/vmx/Makefile                   |  23 --
>  drivers/crypto/vmx/ppc-xlate.pl               | 231 ------------------
>  17 files changed, 46 insertions(+), 281 deletions(-)
>  rename {drivers/crypto/vmx => arch/powerpc/crypto}/aes.c (100%)
>  rename {drivers/crypto/vmx => arch/powerpc/crypto}/aes_cbc.c (100%)
>  rename {drivers/crypto/vmx => arch/powerpc/crypto}/aes_ctr.c (100%)
>  rename {drivers/crypto/vmx => arch/powerpc/crypto}/aes_xts.c (100%)
>  rename {drivers/crypto/vmx => arch/powerpc/crypto}/aesp8-ppc.h (100%)
>  rename {drivers/crypto/vmx => arch/powerpc/crypto}/aesp8-ppc.pl (100%)
>  rename {drivers/crypto/vmx => arch/powerpc/crypto}/ghash.c (100%)
>  rename {drivers/crypto/vmx => arch/powerpc/crypto}/ghashp8-ppc.pl (100%)
>  rename {drivers/crypto/vmx => arch/powerpc/crypto}/vmx.c (100%)
>  delete mode 100644 drivers/crypto/vmx/.gitignore
>  delete mode 100644 drivers/crypto/vmx/Kconfig
>  delete mode 100644 drivers/crypto/vmx/Makefile
>  delete mode 100644 drivers/crypto/vmx/ppc-xlate.pl

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

