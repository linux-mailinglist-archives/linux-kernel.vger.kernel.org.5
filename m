Return-Path: <linux-kernel+bounces-10515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD6381D562
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3DF282CB3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A6412E52;
	Sat, 23 Dec 2023 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nc64KeSX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD812E4C;
	Sat, 23 Dec 2023 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=OAZZUJXpLeNstNwhdG1ZZmqbS7rxoqyh/Hlt8uKIHOs=; b=nc64KeSXNthZ6WGe2F1XWhtqKm
	SiRqKdO3PAaFlrhP/n06Vwro4sYOiilPM5RS99Bbx6eSfhxQWHibWaYrhWzfE1lgv3jKWo3hO8SLZ
	Qeu2vvG/MQ5rTKFxBEOTEz8B2gEJZ4MibHYsG/owiD5n+ZnbpXm87+UdpDsD0rytc9XTKWWtwZlUt
	bw4ZX3gEYtruHjcJx0FwwdpqXLUvZ1Tyhd4u1IjKt4KlS9DJFMouc4Hgo19d0hhMuO6mZMl/wNt73
	4HF4TDF2SKetyC5XiqTCJdMatmil+6cB0UQZFdyOuJcxpcweZQD18CglYTJixlcL26NVMitfw+8aK
	PPdZNB3A==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rH64G-008EuA-1t;
	Sat, 23 Dec 2023 17:45:44 +0000
Message-ID: <7d7fab4f-71e0-4bc2-b622-c2048c32b3f6@infradead.org>
Date: Sat, 23 Dec 2023 09:45:44 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] crypto: shash - remove excess kerneldoc members
To: Vegard Nossum <vegard.nossum@oracle.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>
References: <20231223083459.3025561-1-vegard.nossum@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231223083459.3025561-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/23/23 00:34, Vegard Nossum wrote:
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

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/crypto/hash.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/crypto/hash.h b/include/crypto/hash.h
> index c7bdbece27cc..5d61f576cfc8 100644
> --- a/include/crypto/hash.h
> +++ b/include/crypto/hash.h
> @@ -212,13 +212,9 @@ struct shash_desc {
>   *	      This is a counterpart to @init_tfm, used to remove
>   *	      various changes set in @init_tfm.
>   * @clone_tfm: Copy transform into new object, may allocate memory.
> - * @digestsize: see struct ahash_alg
> - * @statesize: see struct ahash_alg
>   * @descsize: Size of the operational state for the message digest. This state
>   * 	      size is the memory size that needs to be allocated for
>   *	      shash_desc.__ctx
> - * @stat: Statistics for hash algorithm.
> - * @base: internally used
>   * @halg: see struct hash_alg_common
>   * @HASH_ALG_COMMON: see struct hash_alg_common
>   */

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

