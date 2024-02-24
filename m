Return-Path: <linux-kernel+bounces-79377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF05686215C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1771C20B8D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803521864;
	Sat, 24 Feb 2024 00:52:02 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBC015A4;
	Sat, 24 Feb 2024 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708735922; cv=none; b=O4i4UMg2pMvgf9RWmQbkvy3AgOOJfwZhobe85DwFw4vhg9lM6JUk90IEMbKS8DxZmzg7eFZyGA+X0Rnzb1KZs+kqEDd0tpPDb1GFihTgVPi+FSpQIcSMFHuHx+aEbIYCf9pszOKm8TP/F/ytkRefveGQFI+aThKSy/c9RJ/r2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708735922; c=relaxed/simple;
	bh=3K9lwvOBcdm9n/J6vVoyRne+vNASUIpIcrlL2CSh++M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwS6c7EqrLWlcuVVx8usAohkZuNkKSIKJUfojzUaGWBuQvcdvaJ3GrgicKGkq2uif1za+3UtWbikPVU/uNZRede5/7SnQCtwv65+byvAneyDS1H7nQ/XjBda9TUXvlgjTrHQH3LvlEwEVuqqvPNq3tRC2kcfmrEzb89KFuDyEz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rdgGY-00HDz8-Qf; Sat, 24 Feb 2024 08:51:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 24 Feb 2024 08:52:01 +0800
Date: Sat, 24 Feb 2024 08:52:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
	Robert Elliott <elliott@hpe.com>,
	Christoph Biedl <bugzilla.kernel.bpeb@manchmal.in-ulm.de>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: fix CRYPTO_JITTERENTROPY help text
Message-ID: <Zdk9sVuc7CIBFAgA@gondor.apana.org.au>
References: <20240217165513.24061-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217165513.24061-1-rdunlap@infradead.org>

On Sat, Feb 17, 2024 at 08:55:13AM -0800, Randy Dunlap wrote:
> Correct various small problems in the help text:
> a. change 2 spaces to ", "
> b. finish an incomplete sentence
> c. change non-working URL to working URL
> 
> Fixes: a9a98d49da52 ("crypto: Kconfig - simplify compression/RNG entries")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218458
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: Robert Elliott <elliott@hpe.com>
> Cc: Christoph Biedl <bugzilla.kernel.bpeb@manchmal.in-ulm.de>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> ---
>  crypto/Kconfig |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

