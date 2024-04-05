Return-Path: <linux-kernel+bounces-132596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD17A899705
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E2A1C2277C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2001422DF;
	Fri,  5 Apr 2024 07:52:30 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978741422A9;
	Fri,  5 Apr 2024 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303549; cv=none; b=TBkmBl60Um1LGMz2OBISBRYOVv+u5CbEm+Vy+JNxEQsNX3WXkJFTCDIq6SrRqC18AciVzNjkcX0ISHstSv1r3k7qvNGd7G8Hyjfymbz8wO+htb2oHGtTfUauS+pSrGt4/J2Pkkg2lkao7gHjFUd/RDB69ADkJYx1E/Fb5mFvpC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303549; c=relaxed/simple;
	bh=DekmYTDdP+foBZ3QszVaw87bEdiNyHkyN25oulzeP5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Acj5gWfkeaJgQN56rqiVFzTcc2j5xarNl3cnIHkgLoDxuzX3kWVgg1faDkAPu/f/0Fey7iHdE+yUdArvNz6qZ7DvIJZEukgzXoaALSX8o5wsEZZjZhPqvalwX0Kjd49Sg780E3jkIBqPnfoEUG6GNlezc+es3MDEsYTCV1S1/l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rseN2-00FU5O-N5; Fri, 05 Apr 2024 15:52:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 15:52:37 +0800
Date: Fri, 5 Apr 2024 15:52:37 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: jitter - Use kvfree_sensitive() to fix
 Coccinelle warning
Message-ID: <Zg+txTXOpUFp3yH1@gondor.apana.org.au>
References: <20240327222507.42731-3-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327222507.42731-3-thorsten.blum@toblux.com>

On Wed, Mar 27, 2024 at 11:25:09PM +0100, Thorsten Blum wrote:
> Replace memzero_explicit() and kvfree() with kvfree_sensitive() to fix
> the following Coccinelle/coccicheck warning reported by
> kfree_sensitive.cocci:
> 
> 	WARNING opportunity for kfree_sensitive/kvfree_sensitive
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  crypto/jitterentropy-kcapi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

