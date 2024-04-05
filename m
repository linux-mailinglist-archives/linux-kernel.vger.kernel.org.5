Return-Path: <linux-kernel+bounces-132607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799F9899731
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD4D1F212C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9A6142E83;
	Fri,  5 Apr 2024 07:57:32 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E958142900;
	Fri,  5 Apr 2024 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303852; cv=none; b=QeLvfEikO+hug0LhSpxNiT6LcTdfJTBoL+BKW3D4aXM2vZSWTPDFF+gvcn4r0qeUbmbzN7WViVgRVPOUN6ELJVyBWmensXHp1wb1w8bw40zgSzLK6yzcz45KGf9HxVM32tXnUzGkpgEP4S7AsRH1IHbHJC7D4g3xRQEjw7e6dGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303852; c=relaxed/simple;
	bh=7Vn9VEqbS8cU0vqLnnlgZy2zbQCpBjLi56AWPBzffs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1O0k7DsD15UoiS6qNHMwv+ACkXAcxb84O+ZVZ0ESKRiP3R1StXxiRrMxgVKv4UfsnYrDql2eOrJzBYiPP4i7uUbX+qlsee33slJRMuxWt27GV0YUpWMH/G/JHU9ycUOTHCdSKUR/Ll54yGA9YG01B/VZSSvwgHXiFkUUGUvRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rseRv-00FUCt-Mb; Fri, 05 Apr 2024 15:57:24 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 15:57:40 +0800
Date: Fri, 5 Apr 2024 15:57:40 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: jitter - Replace http with https
Message-ID: <Zg+u9DQrm0KLYGj/@gondor.apana.org.au>
References: <20240328190511.473822-3-thorsten.blum@toblux.com>
 <20240329155345.2015-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329155345.2015-2-thorsten.blum@toblux.com>

On Fri, Mar 29, 2024 at 04:53:45PM +0100, Thorsten Blum wrote:
> The PDF is also available via https.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - Fix the commit diff because I made a mistake when breaking up changes
>   into individual patches
> ---
>  crypto/jitterentropy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

