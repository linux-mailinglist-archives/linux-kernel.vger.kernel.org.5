Return-Path: <linux-kernel+bounces-62198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 716DE851CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB69D1F22446
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A306040BEE;
	Mon, 12 Feb 2024 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiSDRKBg"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C33EA69;
	Mon, 12 Feb 2024 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763040; cv=none; b=KmgE2TRccHnr7JWr1tYNLyaZYCqhKQHDeiC746j5AmTRyY1DK/xG7nTvSkI+4pUbQ73ebHWQgRrN603kStZ3pMajITM/CSQZZ7Q2w52gFgoVxksllaeJ3LL59oRW4xAAuCIZYDZWyf26uLaldnnM78m4MJbMLWuAaIqMAh4z9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763040; c=relaxed/simple;
	bh=Z9CNOqRLKvoHOjRw43D/91gLXSu7vFhS0B+8n0+qvXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUoinq+TcDw3kBT7gjvSywXpswRITVZLcq6TrUGw2L+WoNc91y5rp/d5TdlUByFxlU1GPkx+z4UUnhMzsk9FCQh5MHjpO14EKEREIhc0PgSZJB3TAcAepL2lLT0Nyh8+qI8imc+bpCwnN3XXp0X7Q/zhjCuS10F/a5bAtn8AYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiSDRKBg; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6077444cb51so4665267b3.1;
        Mon, 12 Feb 2024 10:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707763038; x=1708367838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Urk/xvX+UKbKGSqpVvdQe9PJXR++Pgpk6nNhD2JHitg=;
        b=eiSDRKBg+uM1R5sCIDscGdlG6Flja1mpbIF9fVdzIw4tIWA1bqGxLKJkDUuqUgcMTx
         8NH/JRU+pCONwiiEwfwb8gBuOEIEipdpuGPFcOgg4KjH4mBQ/kGCTiaDNiskIW+UXwBS
         VQ7CpXpsoaHrx3w7HYotQlDe6tdX7QmKOI+mZ9KsJp0hwBMOkKyheGMx6GWgxdCRQk+J
         33eMIavefXQhq2Gob7RRZZzGIPdfWVBDWzmfOZdjSKMp4D+RbJ7O1lN5oYijwY9VsR9B
         F7V473m45SQXQEsy1QVirhT0g/9mumeOAHFTPxIj2j+zH3781b60fVhg1gQBGl8ycRJC
         hj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763038; x=1708367838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Urk/xvX+UKbKGSqpVvdQe9PJXR++Pgpk6nNhD2JHitg=;
        b=QICTguyZHYUP1DKXGgYWM+wTpY3AX2bEyaNlN5eB8vO+w4EgDL5hhZV6ooM3xjjBhs
         klPutTZxAffWi/L+nJ/9r90S1EkvVvFGcX0TxXJ/rFoiVWcyS+MPMzcInSxa1LBN8NVV
         jO3c6msQFlwKHROxuOg+YllBM18vZwVB6UTF1nvzoXYPd13IoZha7on3M0JbmfGOpy2v
         QIc0/GmcW3605D4ZQZFruQfk1dHxS4aJyvko8uptiGgwX1MKg4/r+jnSVl8Rcv3OrMBk
         1150lmZcoUZ2ImCwa8ZUcv24wT3pn1TCUglE9qLvIPEVAfZN8zeVB8KGPd5vOIFobrge
         Iq7w==
X-Gm-Message-State: AOJu0YwZHdzEMoO30XpSdrDxj/9EylApuKK96oG8JbmWChnaN/Kon6R4
	wsvuj5t+yuxwd43/iYb0PdkLQjCso0yUrZBHM2tOtKwhcRAz8jiy
X-Google-Smtp-Source: AGHT+IEpd+QbpXDB2ycV1t5rD40xn6kwWMLP7zDSBdWBR9zSWASGH0Ugsa2ib4yux5Jw29DdKmxVfQ==
X-Received: by 2002:a0d:e845:0:b0:604:7bab:dac1 with SMTP id r66-20020a0de845000000b006047babdac1mr280436ywe.15.1707763037858;
        Mon, 12 Feb 2024 10:37:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3NpMjINqr6ODt3JXMsBQ2F7ZuSuRpJICxX/qJB2m9t0QalgdEtK0ncdpG0yVeSPZ/yP3zUrMapSAKaZj9rpBe2GZNRkETsKAD5rS+mENVDa89pdt9a4n7q5aiKdA8qolC3e31vAcyVX+cuf8qFx4B15M9rwRVbFa5hxEXSqiCUoIrFiCHBnlTsobXFzfu5JZqOvpN8C/IOL4rfQQvyXw2sC9ehwfFsMfM16UF7E4q50Le0Cff2D1q0R9DCqAt5O9uG1NvIaijR34dj+/roSDDzr3rRkVM6ODiyZ4WRI2+VHGFBJ5y/6mQUfeO2lvlCZ3yAWWjPGXPFXngsUduXc6DFtsriqURsX64W2MlhIGwJuy1fN8J45LYDAOj+QWczUN4sskDZF6ZglcGuUXogIWlE8WHANXvkL2c3kfA9+do50Z2EksJwGCMvEy3Q1EsivNvnIIVTjLsHGND3764tAOf/861BfL4wn/iJrO6QQ==
Received: from localhost ([2601:344:8301:57f0:85b5:dd54:cd99:b])
        by smtp.gmail.com with ESMTPSA id n133-20020a81728b000000b006041221d0ccsm1275634ywc.68.2024.02.12.10.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:37:17 -0800 (PST)
Date: Mon, 12 Feb 2024 10:37:15 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 RESEND 4/6] bitmap: Introduce bitmap_off()
Message-ID: <ZcplW2mXObOZUtR7@yury-ThinkPad>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
 <20240212075646.19114-5-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212075646.19114-5-herve.codina@bootlin.com>

On Mon, Feb 12, 2024 at 08:56:32AM +0100, Herve Codina wrote:
> The bitmap_onto() function translates one bitmap relative to another but
> no function are present to perform the reverse translation.
> 
> Introduce bitmap_off() to fill this hole.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  include/linux/bitmap.h |  3 +++
>  lib/bitmap.c           | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 99451431e4d6..5ecfcbbc91f4 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -65,6 +65,7 @@ struct device;
>   *  bitmap_remap(dst, src, old, new, nbits)     *dst = map(old, new)(src)
>   *  bitmap_bitremap(oldbit, old, new, nbits)    newbit = map(old, new)(oldbit)
>   *  bitmap_onto(dst, orig, relmap, nbits)       *dst = orig relative to relmap
> + *  bitmap_off(dst, orig, relmap, nbits)        *dst = bitmap_onto() reverse operation
>   *  bitmap_fold(dst, orig, sz, nbits)           dst bits = orig bits mod sz
>   *  bitmap_parse(buf, buflen, dst, nbits)       Parse bitmap dst from kernel buf
>   *  bitmap_parse_user(ubuf, ulen, dst, nbits)   Parse bitmap dst from user buf
> @@ -208,6 +209,8 @@ int bitmap_bitremap(int oldbit,
>  		const unsigned long *old, const unsigned long *new, int bits);
>  void bitmap_onto(unsigned long *dst, const unsigned long *orig,
>  		const unsigned long *relmap, unsigned int bits);
> +void bitmap_off(unsigned long *dst, const unsigned long *orig,
> +		const unsigned long *relmap, unsigned int bits);
>  void bitmap_fold(unsigned long *dst, const unsigned long *orig,
>  		unsigned int sz, unsigned int nbits);
>  
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 2feccb5047dc..71343967335e 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -682,6 +682,48 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
>  }
>  EXPORT_SYMBOL(bitmap_onto);
>  
> +/**
> + * bitmap_off - revert operation done by bitmap_onto()

This is definitely a bad name. I've no a better idea, but even
bitmap_onto_revert() would be better.

> + *     @dst: resulting translated bitmap
> + *     @orig: original untranslated bitmap
> + *     @relmap: bitmap relative to which translated
> + *     @bits: number of bits in each of these bitmaps
> + *
> + * Suppose onto computed using bitmap_onto(onto, src, relmap, n)
> + * The operation bitmap_off(result, onto, relmap, n) leads to a
> + * result equal or equivalent to src.

Agree with Rasmus. This should be well tested.

> + * The result can be 'equivalent' because bitmap_onto() and
> + * bitmap_off() are not bijective.
> + * The result and src values are equivalent in that sense that a
> + * call to bitmap_onto(onto, src, relmap, n) and a call to
> + * bitmap_onto(onto, result, relmap, n) will lead to the same onto
> + * value.

Did you mean "a call to bitmap_onto(onto, src, relmap, n) and a
call to bitmap_off(onto, result, relmap, n)"? 

I think the whole paragraph adds more confusion than explanations.
If a new function is supposed to revert the result of some other
function, I'd better focus on testing that it actually reverts as
advertised, and keep description as brief as possible.

> + * If either of @orig or @relmap is empty (no set bits), then @dst
> + * will be returned empty.

Is this an exception from the 'revert' policy? Doesn't look like that.
So, what for mentioning this specific case?

> + * All bits in @dst not set by the above rule are cleared.

The above rule is about empty @orig and @relmap, not about setting
bits. What did you mean here?

> + */
> +void bitmap_off(unsigned long *dst, const unsigned long *orig,
> +		const unsigned long *relmap, unsigned int bits)
> +{
> +	unsigned int n, m;      /* same meaning as in above comment */

In the above comment, n means the size of bitmaps, and m is not
mentioned at all.

> +	if (dst == orig)        /* following doesn't handle inplace mappings */
> +		return;
> +	bitmap_zero(dst, bits);

Can you add an empty line after 'return'.

> +	m = 0;
> +	for_each_set_bit(n, relmap, bits) {
> +		/* m == bitmap_pos_to_ord(relmap, n, bits) */

Don't think we need this comment here. If you want to underline that
m tracks bit order, can you just give it a more explanatory name. For
example, 'bit_order'.

> +		if (test_bit(n, orig))
> +			set_bit(m, dst);
> +		m++;
> +	}
> +}
> +EXPORT_SYMBOL(bitmap_off);
> +
>  #ifdef CONFIG_NUMA
>  /**
>   * bitmap_fold - fold larger bitmap into smaller, modulo specified size
> -- 
> 2.43.0

