Return-Path: <linux-kernel+bounces-122791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF99E88FD53
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EFD8B21F10
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE927D079;
	Thu, 28 Mar 2024 10:46:09 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B57D075
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622768; cv=none; b=Hb/NB81fvrnodgd5Blxr9MA/0eT+o4KD5N9YDrdrqM1CeMoUbaHt8LqJY5HmS417TLwb+tPFu4cZk5RndVuhMssXEP860j+gaPdRb3uXqvAxYi1BoKZkJDqHtcNDXmUdunYccz0haf3XuCHw5boIVx8L2uXV5tbeb37yWGl9zxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622768; c=relaxed/simple;
	bh=U9jZKJGf5L61jQ+gncOJxk3GbqL/e9r7u7YK6cBrxw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKIoFwsyvMBwV1et0vTCmK8prS1G1ofoHIGQglZp7fQeymiRU448iJwI5NU2V1MHYFoHduF0uCRmqUXESqzI3/tg4LjIoXJ8ClmcatdpOBX2E7IvpUznIUK9jXjHCRYqBmsA3RWOj0IHmWdi+8ly/ra/DnzKYzNGmIlUqHIQmlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rpnGc-00C8Ci-Sf; Thu, 28 Mar 2024 18:45:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Mar 2024 18:46:11 +0800
Date: Thu, 28 Mar 2024 18:46:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Karina Yankevich <k.yankevich@omp.ru>
Cc: "David S. Miller" <davem@davemloft.net>, s.shtylyov@omp.ru,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] crypto: drbg - make drbg_kcapi_{ctr_bcc,kcapi_sym}()
 return void
Message-ID: <ZgVKc/yEhRwaXAn0@gondor.apana.org.au>
References: <20240305184322.337015-1-k.yankevich@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305184322.337015-1-k.yankevich@omp.ru>

On Tue, Mar 05, 2024 at 09:43:16PM +0300, Karina Yankevich wrote:
> drgb_kcapi_sym() always returns 0, so make it return void instead.
> Consequently, make drbg_ctr_bcc() return void too.
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Signed-off-by: Karina Yankevich <k.yankevich@omp.ru>
> ---
>  crypto/drbg.c | 38 ++++++++++++--------------------------
>  1 file changed, 12 insertions(+), 26 deletions(-)

Please resend this to linux-crypto@vger.kernel.org.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

