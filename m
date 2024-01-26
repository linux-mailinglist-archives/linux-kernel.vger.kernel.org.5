Return-Path: <linux-kernel+bounces-39875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C60A83D74C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5339FB30441
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F785B5A3;
	Fri, 26 Jan 2024 09:03:40 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFECA134AA;
	Fri, 26 Jan 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259819; cv=none; b=LdkeBJ37SaokNHU7309UMPyYc71s2SHhOtHbF20YH6a2SO3dfsnK+OPn01AyxvUP8DO/Xnjb0PMPpC1p/1IKjit6ry73A5kXT+QhJuL6i6YRWuUcn5jfEJC9Z0CeZZHEPhokXG1fALEAJ2RiER98mJiw9vWJ7XTK6UaNKmDGnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259819; c=relaxed/simple;
	bh=7xFbIanwiFTtGY//LDX808ByA8lWdyfDM75y/yqmAgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqSXCLMK/TPVY7fspfbZwJVpBn5e5Z08DwBSX9HDE6aiVqQ9BDDzzOVVdpTZV2gPTUCvrkyaOlOXnsa79coyUnXITyo0co8fklkumvhvEyYAZc1l0vijwIgLGiQhHF+h7BVJpwBwYGAuP0tRJ04opnlmyuRoCmYc58+l5hLJ/ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTI7W-006EnA-Vz; Fri, 26 Jan 2024 17:03:32 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 17:03:43 +0800
Date: Fri, 26 Jan 2024 17:03:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	"David S . Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] crypto: asymmetric_keys: remove redundant pointer
 secs
Message-ID: <ZbN1byLwTWzXo7ew@gondor.apana.org.au>
References: <20240118120745.2519762-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118120745.2519762-1-colin.i.king@gmail.com>

On Thu, Jan 18, 2024 at 12:07:45PM +0000, Colin Ian King wrote:
> The pointer secs is being assigned a value however secs is never
> read afterwards. The pointer secs is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> warning: Although the value stored to 'secs' is used in the enclosing
> expression, the value is never actually read from 'secs'
> [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  crypto/asymmetric_keys/verify_pefile.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

