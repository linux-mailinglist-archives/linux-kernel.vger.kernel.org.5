Return-Path: <linux-kernel+bounces-122806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CBC88FD95
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3DA2295559
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5567D417;
	Thu, 28 Mar 2024 10:57:33 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47592B9C6;
	Thu, 28 Mar 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623452; cv=none; b=R7BMTlQ0gge+dzHQMUSu1tdr8hOqVgLzI+lOt0JlKA1STBEcj66hCDdUDcq3ND8gW2YgMm42x2mcX4d0fHBcLFz47nfs4YKJgvRi0uP0Cv0+KOxWv65oZrOKpD4IWDv7uvuab176VItML1S0cQS6nvnVlldAgIohxlgQMYbDefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623452; c=relaxed/simple;
	bh=K+jKmepheYLf7B+PQen90LTa9MtOFKvzKtiVr+CVvYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZPGECuAkNlANadRT4h4z07PX3Zrbtkkv2kjJV9NTNesLETyvf+dJXmDdwedMrljaTZbUwvm7ofTJeDY4WU87jeGXaoZ+8VugnzurKxqP2c7VbVkVXEw8GeHxaXFbixmc1e4m5mFnvApOmMLyZWLvKyrfCI6glmP4/lEi7XnobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rpnRd-00C8VP-9o; Thu, 28 Mar 2024 18:57:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Mar 2024 18:57:33 +0800
Date: Thu, 28 Mar 2024 18:57:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
	Steve Lin <steven.lin1@broadcom.com>,
	Rob Rice <rob.rice@broadcom.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] crypto: bcm/spu2 - Add buffer size check
Message-ID: <ZgVNHSZ8xmPqrSuL@gondor.apana.org.au>
References: <20240306110022.21574-1-amishin@t-argos.ru>
 <20240322205915.13305-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322205915.13305-1-amishin@t-argos.ru>

On Fri, Mar 22, 2024 at 11:59:15PM +0300, Aleksandr Mishin wrote:
> In spu2_dump_omd() value of ptr is increased by ciph_key_len
> instead of hash_iv_len which could lead to going beyond the
> buffer boundaries.
> Fix this bug by changing ciph_key_len to hash_iv_len.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 9d12ba86f818 ("crypto: brcm - Add Broadcom SPU driver")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v2: Fix commit message according to the Linux kernel rules
> 
>  drivers/crypto/bcm/spu2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

