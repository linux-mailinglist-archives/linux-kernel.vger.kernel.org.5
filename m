Return-Path: <linux-kernel+bounces-159787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7A18B3406
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37625B20F99
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A126D13F00F;
	Fri, 26 Apr 2024 09:30:14 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71DC22338;
	Fri, 26 Apr 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123814; cv=none; b=rHbEhHELnU9YxmpN1iAEJzbeFymiAmntU4ag2TMlKsXnFrLwyyM3O4gYorxJcVEitDCeKQ9j4fN9s/MmsatmCjFIL7a6o/tXdcG3KpQI+v7T4JdO4kH8sV0u6cypK9u0fiQU8s/Nv5NgOUqt7Jn0UToVL7S7F54jzZPkNfgycZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123814; c=relaxed/simple;
	bh=9Fk/XaFOSfJRrwa4aCRMxANgroSVuupqGce5SlPP0+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKMh8Hbc7h7aRQL6ydUUqQtOE1c27ayM310Uf3w3wKhFo0VV0tKEB69cl4PyKEb3W9lmkXmksbZKawaYAUKPwOcJhDjSEsJDKrLWn/WW6ZrTCNCx0+HaHO9mEOzC0+m16COCDYZ4cCIVLTP5xTuPcGGWayTTuyBdT6+wNJ7P1dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1s0Hu8-006eIw-WB; Fri, 26 Apr 2024 17:30:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Apr 2024 17:30:23 +0800
Date: Fri, 26 Apr 2024 17:30:23 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hailey Mothershead <hailmo@amazon.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] crypto: aead,cipher - zeroize key buffer after use
Message-ID: <Zit0L/P7h5Q8VDlQ@gondor.apana.org.au>
References: <20240415221915.20701-1-hailmo@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415221915.20701-1-hailmo@amazon.com>

On Mon, Apr 15, 2024 at 10:19:15PM +0000, Hailey Mothershead wrote:
> I.G 9.7.B for FIPS 140-3 specifies that variables temporarily holding
> cryptographic information should be zeroized once they are no longer
> needed. Accomplish this by using kfree_sensitive for buffers that
> previously held the private key.
> 
> Signed-off-by: Hailey Mothershead <hailmo@amazon.com>
> ---
>  crypto/aead.c   | 3 +--
>  crypto/cipher.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

