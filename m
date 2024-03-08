Return-Path: <linux-kernel+bounces-96927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E5B876342
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8021C21574
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247C45676F;
	Fri,  8 Mar 2024 11:25:20 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC056745;
	Fri,  8 Mar 2024 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897119; cv=none; b=NoGu+wVU/b+kZN0UJo405VgjkbEmHpj1bEJD4Qn2gwiWYC8xdAmMJD123cteTmzaW9vVPnBVgLXoW1XyMyad7ndwBtP9bXmlt6QGSq0j5vHqr+x0ZYP5uEWlqZeTr8xghYmaNHQmPhZMU2Hc19gNmfK+Dfnghi0TIMRqc6w18N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897119; c=relaxed/simple;
	bh=Dc0Oz+8kdc0d502VQiwtcwUjZNXgV3uxWsH1cAVngtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHBmjIDL5EvL6imiNFT7JYOxNpTu6d2eS0MxYxRQONwtYce5iWEo1HGcc0kFeqOH5uPBI+HtQ+7Kfp8Z8VuaPjaH7fp21AwCkmuyXkU/V+ZafeShJ+bFxFt9gcTaCWHFzq2y2dId0l0JPcAfXkimNsy0kwBlS+NHkTMMJmDx6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1riYLf-004tK3-Vp; Fri, 08 Mar 2024 19:25:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Mar 2024 19:25:27 +0800
Date: Fri, 8 Mar 2024 19:25:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v2 0/2] [PATCH v2 0/2] crypto: fix missing
 CRYPTO_ALG_ASYNC for async drivers
Message-ID: <Zer1p043jRiDQzNY@gondor.apana.org.au>
References: <20240229101449.227921-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229101449.227921-1-21cnbao@gmail.com>

On Thu, Feb 29, 2024 at 11:14:47PM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Fix missing CRYPTO_ALG_ASYNC cra_flags for hisilicon and intel iaa
> drivers.
> 
> -V2:
>  * collect Acked-by of Tom and Yang, thanks for reviewing!
> 
> Barry Song (2):
>   crypto: hisilicon/zip - fix the missing CRYPTO_ALG_ASYNC in cra_flags
>   crypto: iaa - fix the missing CRYPTO_ALG_ASYNC in cra_flags
> 
>  drivers/crypto/hisilicon/zip/zip_crypto.c  | 1 +
>  drivers/crypto/intel/iaa/iaa_crypto_main.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> -- 
> 2.34.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

