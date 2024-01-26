Return-Path: <linux-kernel+bounces-39873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8142B83D6E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B521C2E1CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FF05A0FF;
	Fri, 26 Jan 2024 09:03:16 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C05914E;
	Fri, 26 Jan 2024 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259795; cv=none; b=NjxpPctKJ8KiBThSgOC1qI1TVp0Eods6R8XHdhOh/icv1EYWScftdk3npxkd+NEvE7EyfW6gFfE+3sFvMeE4IhDic+0oIYYdNaijVPSisMuoeoJVeDBF6tVlOuw1o8k43Y7/P8LFQXG8RZ0oe0g7UIQVSb4nd4NkHcT1ZhvIwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259795; c=relaxed/simple;
	bh=lAVrKCrBsmf631tjJel0PbdSbeF9q5q6NX1y3OhMR/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PavG7STHKDpp+TTWytQSTMo6uZlLRlAIKWmWAdlMJW99jKUcOu0IbhNdaXFdxKl2kUgyzcWUmEeM53TTywD5yaFeo/q91GjIJfDL7+dncxd6IWy14ETEZhQxvcyUH9IGz471nPKzP/Lep1PgsPiigeFqRCSAuGCFtBWnE6Gmj4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTI7A-006Ell-Us; Fri, 26 Jan 2024 17:03:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 17:03:21 +0800
Date: Fri, 26 Jan 2024 17:03:21 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] crypto: pcbc: remove redundant assignment to nbytes
Message-ID: <ZbN1WYSIKqJl6Zu9@gondor.apana.org.au>
References: <20240116104302.2241325-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116104302.2241325-1-colin.i.king@gmail.com>

On Tue, Jan 16, 2024 at 10:43:02AM +0000, Colin Ian King wrote:
> The assignment to nbytes is redundant, the while loop needs
> to just refer to the value in walk.nbytes and the value of
> nbytes is being re-assigned inside the loop on both paths
> of the following if-statement.  Remove redundant assignment.
> 
> Cleans up clang scan build warning:
> warning: Although the value stored to 'nbytes' is used in
> the enclosing expression, the value is never actually read
> from 'nbytes' [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  crypto/pcbc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

