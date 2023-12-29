Return-Path: <linux-kernel+bounces-12930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B89B281FCD2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 04:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44EA1C214AE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1900823A1;
	Fri, 29 Dec 2023 03:30:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A8A1FA8;
	Fri, 29 Dec 2023 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rJ3ZJ-00FGAJ-9f; Fri, 29 Dec 2023 11:29:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 Dec 2023 11:30:04 +0800
Date: Fri, 29 Dec 2023 11:30:04 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/2] crypto: shash - remove excess kerneldoc members
Message-ID: <ZY49PJbpLvvk8zVr@gondor.apana.org.au>
References: <20231223083459.3025561-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223083459.3025561-1-vegard.nossum@oracle.com>

On Sat, Dec 23, 2023 at 09:34:58AM +0100, Vegard Nossum wrote:
> Commit 42808e5dc602 ("crypto: hash - Count error stats differently")
> moved some fields from 'struct shash_alg' into HASH_ALG_COMMON but
> didn't remove the corresponding kerneldoc members, which results in
> these warnings when running 'make htmldocs':
> 
>   ./include/crypto/hash.h:248: warning: Excess struct member 'digestsize' description in 'shash_alg'
>   ./include/crypto/hash.h:248: warning: Excess struct member 'statesize' description in 'shash_alg'
>   ./include/crypto/hash.h:248: warning: Excess struct member 'stat' description in 'shash_alg'
>   ./include/crypto/hash.h:248: warning: Excess struct member 'base' description in 'shash_alg'
> 
> HASH_ALG_COMMON already has the documentation for all these fields.
> 
> Fixes: 42808e5dc602 ("crypto: hash - Count error stats differently")
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  include/crypto/hash.h | 4 ----
>  1 file changed, 4 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

