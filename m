Return-Path: <linux-kernel+bounces-10516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE95A81D565
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62056B218D6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E0D14A80;
	Sat, 23 Dec 2023 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p2ZOEY/N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287712E47;
	Sat, 23 Dec 2023 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=WhHixi2VZpDBVLftarK1q7P/+5qNlOuePs7odpBRn3Q=; b=p2ZOEY/NVK6ni17P7SCHFCqOkX
	Jf+wx4r85sublaH1FlECpxiseI01AzmGtaABJw38POe+Qr3k6oF7yZGM3Kg/d0cX3Eo4OtzUBLv5c
	WhhlNSDRhs5MeovdKpHzHsGVeZ5T6Myjz624BdyG7SZp4kQvLRRPfSNGHoDvxEOYXxgaWonOTJCxM
	Xe/KDPSmw05dxrByFuitCYiZ9hRj3BLtr9PEY8PD+wDD4EMWAUafcoSN0dvJnf8U/XIGBymm0VM2U
	xooWt95cOATUHLM/yTPklik9hd4l/FiGmu0sPjeAhwZeAZkLk1/siPAAj/wWXJ+4NfGjBv9aNuJ8o
	0QCjkWwg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rH64D-008EuA-37;
	Sat, 23 Dec 2023 17:45:42 +0000
Message-ID: <fd99702a-a380-4c5f-bf6a-40b1eb912cf8@infradead.org>
Date: Sat, 23 Dec 2023 09:45:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] crypto: skcipher - remove excess kerneldoc members
Content-Language: en-US
To: Vegard Nossum <vegard.nossum@oracle.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>
References: <20231223083459.3025561-1-vegard.nossum@oracle.com>
 <20231223083459.3025561-2-vegard.nossum@oracle.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231223083459.3025561-2-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/23/23 00:34, Vegard Nossum wrote:
> Commit 31865c4c4db2 ("crypto: skcipher - Add lskcipher") moved some
> fields from 'struct skcipher_alg' into SKCIPHER_ALG_COMMON but didn't
> remove the corresponding kerneldoc members, which results in these
> warnings when running 'make htmldocs':
> 
>   ./include/crypto/skcipher.h:182: warning: Excess struct member 'min_keysize' description in 'skcipher_alg'
>   ./include/crypto/skcipher.h:182: warning: Excess struct member 'max_keysize' description in 'skcipher_alg'
>   ./include/crypto/skcipher.h:182: warning: Excess struct member 'ivsize' description in 'skcipher_alg'
>   ./include/crypto/skcipher.h:182: warning: Excess struct member 'chunksize' description in 'skcipher_alg'
>   ./include/crypto/skcipher.h:182: warning: Excess struct member 'stat' description in 'skcipher_alg'
>   ./include/crypto/skcipher.h:182: warning: Excess struct member 'base' description in 'skcipher_alg'
> 
> SKCIPHER_ALG_COMMON already has the documentation for all these fields.
> 
> Fixes: 31865c4c4db2 ("crypto: skcipher - Add lskcipher")
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/crypto/skcipher.h | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
> index ea18af48346b..8831fcf8f1da 100644
> --- a/include/crypto/skcipher.h
> +++ b/include/crypto/skcipher.h
> @@ -108,16 +108,6 @@ struct skcipher_alg_common SKCIPHER_ALG_COMMON;
>  
>  /**
>   * struct skcipher_alg - symmetric key cipher definition
> - * @min_keysize: Minimum key size supported by the transformation. This is the
> - *		 smallest key length supported by this transformation algorithm.
> - *		 This must be set to one of the pre-defined values as this is
> - *		 not hardware specific. Possible values for this field can be
> - *		 found via git grep "_MIN_KEY_SIZE" include/crypto/
> - * @max_keysize: Maximum key size supported by the transformation. This is the
> - *		 largest key length supported by this transformation algorithm.
> - *		 This must be set to one of the pre-defined values as this is
> - *		 not hardware specific. Possible values for this field can be
> - *		 found via git grep "_MAX_KEY_SIZE" include/crypto/
>   * @setkey: Set key for the transformation. This function is used to either
>   *	    program a supplied key into the hardware or store the key in the
>   *	    transformation context for programming it later. Note that this
> @@ -152,15 +142,9 @@ struct skcipher_alg_common SKCIPHER_ALG_COMMON;
>   * @exit: Deinitialize the cryptographic transformation object. This is a
>   *	  counterpart to @init, used to remove various changes set in
>   *	  @init.
> - * @ivsize: IV size applicable for transformation. The consumer must provide an
> - *	    IV of exactly that size to perform the encrypt or decrypt operation.
> - * @chunksize: Equal to the block size except for stream ciphers such as
> - *	       CTR where it is set to the underlying block size.
>   * @walksize: Equal to the chunk size except in cases where the algorithm is
>   * 	      considerably more efficient if it can operate on multiple chunks
>   * 	      in parallel. Should be a multiple of chunksize.
> - * @stat: Statistics for cipher algorithm
> - * @base: Definition of a generic crypto algorithm.
>   * @co: see struct skcipher_alg_common
>   *
>   * All fields except @ivsize are mandatory and must be filled.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

