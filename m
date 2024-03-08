Return-Path: <linux-kernel+bounces-96924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD58D876338
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0581F220B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C51F55E7A;
	Fri,  8 Mar 2024 11:24:47 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA2C55E62;
	Fri,  8 Mar 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897087; cv=none; b=mXN4dvrpUif6eiF2nz+uShPGjhJvXeIUJVJwj8rGV0R6gUUK3dI50f2L9y46stsmREFjSh9FQSZM51ik7++VkcypTCeXKbmHBVaHWUD1Otbv0yvK7Tzv9fEifFufBbaNTo8RMRJSbbOdIsxWoHKe95R7H6b2mszCZcJFjZ/gk8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897087; c=relaxed/simple;
	bh=JPtAA/QfB0zPaLOFsJoaTNHfye7eAvB6NuQtshvniSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iW6QFWuJNXziuWxkoAjbQ1KWMREZjeQAbYWwOKEEOizvpmpUcsvyO6z/HzGRz+SkMwAMG8B+5DPYeOPdrl2jDJ9YyqvA0wR3nKd/3ErVSt76a57ZSn+xEpFuO+b9Vk+mrQXvkv5y5Kbe5P2uhXiLbrUqnt2QtDYZ3N1fPTHTNiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1riYL5-004tId-GC; Fri, 08 Mar 2024 19:24:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Mar 2024 19:24:51 +0800
Date: Fri, 8 Mar 2024 19:24:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Martin Kaiser <martin@kaiser.cx>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: hisi - use dev_err_probe
Message-ID: <Zer1g+79hvU6Xu1w@gondor.apana.org.au>
References: <20240226185700.39411-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226185700.39411-1-martin@kaiser.cx>

On Mon, Feb 26, 2024 at 07:57:00PM +0100, Martin Kaiser wrote:
> Replace dev_err + return with dev_err_probe.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/char/hw_random/hisi-rng.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

