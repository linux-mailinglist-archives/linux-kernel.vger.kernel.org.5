Return-Path: <linux-kernel+bounces-142138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0378A27FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D24287251
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693DB4C602;
	Fri, 12 Apr 2024 07:27:40 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D3D487A9;
	Fri, 12 Apr 2024 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906860; cv=none; b=ix/Z6Jt14NrQJ3ESJPL4DULGkRYBDUU91wP3SfsRrm6fttEkHyckMnOwHc2J3cCxeYa7i6uscW0Dkre/YHDqTMSgIoEuYiSYTH6/G5hesCB9pQLxai7rWfA8sno62Ucs84KVmXKrBhENN6GRdo7kxixclkyJGose9H3CeFuHMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906860; c=relaxed/simple;
	bh=2OviW5wY8rtGUKJyuExDpNFM2KDWYSH4za587jUcloI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bru3YFdcltyTQarQf/7WjgTmfCOPHrOWm8unBhyj97wF938W6PODaR95U6VltQt+bHEfgdUxobz9GpYlQbHnijmz515mMtg+Ip4XRUlx8WBy9PeJwtu3SCjXfrhhEOMLRmR94L+1UjCtbKGf8aZVodFjMdCm6tJjdkgS5WBkr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rvBJs-000lZk-3J; Fri, 12 Apr 2024 15:27:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Apr 2024 15:27:49 +0800
Date: Fri, 12 Apr 2024 15:27:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] crypto: algboss: remove NULL check in
 cryptomgr_schedule_probe()
Message-ID: <ZhjidWaJW7m8/6HQ@gondor.apana.org.au>
References: <20240401122258.111414-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401122258.111414-1-r.smirnov@omp.ru>

On Mon, Apr 01, 2024 at 03:22:58PM +0300, Roman Smirnov wrote:
> The for loop will be executed at least once, so i > 0. If the loop
> is interrupted before i is incremented (e.g., when checking len for NULL),
> i will not be checked.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
>  crypto/algboss.c | 3 ---
>  1 file changed, 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

