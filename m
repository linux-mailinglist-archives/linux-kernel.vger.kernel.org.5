Return-Path: <linux-kernel+bounces-125172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE568921A1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA621C25FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C0A86269;
	Fri, 29 Mar 2024 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="keXmtlkH"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A02F50;
	Fri, 29 Mar 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729740; cv=none; b=MzoN7y9RdB5UxM01aY+BFFoqb1swGEMad5P3tIEDNyNvh4iwVCdz1b3xCgEUblB7GutOnIFfmSvDlxKtXRt407oCjJv3fyOau4HVry4vofIreg54v9nvPU2lHdi3YNw6l5oOtuvtlB61ssby05dNSQ/cvCSCFGQDawmjpg7fAlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729740; c=relaxed/simple;
	bh=D4lkSIwLrSZzchcTHNden2QebIR93rBwjAWQCypsPzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OV6LsgDk7ncG3Nsc4fgBfZOwQm9cwYbHRJE++K6uO5vd5weWwMFr5LP9SgRNlNzyaOhKLgocd7Mi5NOgOmPehwNKWN2KYaU1l2YUGbXLvAnritCU1xmZmwD3Ho15hYzqRcDZvAmD84SEmTxCsSY4mbQrhkfFDzpBqEV/GWMPwWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=keXmtlkH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=K1z6VjAbwgNLmy6sA2L74GZZgz0FrddHbVCWVuEAPJA=; b=keXmtlkHe5vA4dRuzXac3Bqqjd
	kM2/w0+BcCbe1P8/4yy/6fc3k9PtIPxpdXv0zt5yzkzxss0njsKognuUvEEyZSHlouFvpBRzRVXmC
	CUT8OQe9REPhV1RYCVc9MQMdVcsv5vb/jidQi84w707ByCxaVejk7R67eCi7x7155ktcwjUKGtvxT
	ekUCak89+1JILaWgbwfKMlWmkat6Ylsm8RV4yzZnPZV99AM2hmZSGNxOFQ7Fg9llO1yXh/vC+oPVw
	IaolgdDubGxXG3S4Gpwm8H7cjW8VmE70ClSXLVpZ6urb5pYXORrD+Tz7Q81Eaq/nVBNsVh8UtNGlo
	TJcWuxxA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqF68-00000001JWf-3Icn;
	Fri, 29 Mar 2024 16:28:56 +0000
Message-ID: <3eb1b3a5-ecdc-4720-b9c2-16a18a3a5e2f@infradead.org>
Date: Fri, 29 Mar 2024 09:28:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rhashtable: Improve grammar
Content-Language: en-US
To: j.neuschaefer@gmx.net, Thomas Graf <tgraf@suug.ch>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240329-misc-rhashtable-v1-1-5862383ff798@gmx.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240329-misc-rhashtable-v1-1-5862383ff798@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/29/24 09:26, Jonathan Neuschäfer via B4 Relay wrote:
> From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> 
> Change "a" to "an" according to the usual rules, fix an "if" that was
> mistyped as "in", improve grammar in "considerable slow" ->
> "considerably slower".
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/rhashtable.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> index 5b5357c0bd8c4..8463a128e2f48 100644
> --- a/include/linux/rhashtable.h
> +++ b/include/linux/rhashtable.h
> @@ -633,7 +633,7 @@ static inline struct rhash_head *__rhashtable_lookup(
>   * @params:	hash table parameters
>   *
>   * Computes the hash value for the key and traverses the bucket chain looking
> - * for a entry with an identical key. The first matching entry is returned.
> + * for an entry with an identical key. The first matching entry is returned.
>   *
>   * This must only be called under the RCU read lock.
>   *
> @@ -655,7 +655,7 @@ static inline void *rhashtable_lookup(
>   * @params:	hash table parameters
>   *
>   * Computes the hash value for the key and traverses the bucket chain looking
> - * for a entry with an identical key. The first matching entry is returned.
> + * for an entry with an identical key. The first matching entry is returned.
>   *
>   * Only use this function when you have other mechanisms guaranteeing
>   * that the object won't go away after the RCU read lock is released.
> @@ -682,7 +682,7 @@ static inline void *rhashtable_lookup_fast(
>   * @params:	hash table parameters
>   *
>   * Computes the hash value for the key and traverses the bucket chain looking
> - * for a entry with an identical key.  All matching entries are returned
> + * for an entry with an identical key.  All matching entries are returned
>   * in a list.
>   *
>   * This must only be called under the RCU read lock.
> @@ -699,7 +699,7 @@ static inline struct rhlist_head *rhltable_lookup(
>  }
>  
>  /* Internal function, please use rhashtable_insert_fast() instead. This
> - * function returns the existing element already in hashes in there is a clash,
> + * function returns the existing element already in hashes if there is a clash,
>   * otherwise it returns an error via ERR_PTR().
>   */
>  static inline void *__rhashtable_insert_fast(
> @@ -1130,7 +1130,7 @@ static inline int rhashtable_remove_fast(
>   *
>   * Since the hash chain is single linked, the removal operation needs to
>   * walk the bucket chain upon removal. The removal operation is thus
> - * considerable slow if the hash table is not correctly sized.
> + * considerably slower if the hash table is not correctly sized.
>   *
>   * Will automatically shrink the table if permitted when residency drops
>   * below 30%
> 
> ---
> base-commit: 4cece764965020c22cff7665b18a012006359095
> change-id: 20240329-misc-rhashtable-d7578e8f2ed5
> 
> Best regards,

-- 
#Randy

