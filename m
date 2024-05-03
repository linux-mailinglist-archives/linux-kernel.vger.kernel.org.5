Return-Path: <linux-kernel+bounces-167178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADB98BA543
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3561C21F6E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CAC15EA6;
	Fri,  3 May 2024 02:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmmHGhv7"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA3712E78
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 02:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702756; cv=none; b=m6q13ETMigHuzpLPSRYuhsvU2KFNCT3kPIrdvtiW7bl7Cpr8iN9jhYk6IT59Nfjn/vr7h5ICCVmF3n7hiS5UTcFI5QkQDHpGRme1bFhA89DZ5uJpxy7ydFLb3IKMS7Egko6moU0j7glZVGPqH7DuI2D2zo9/qSBfEPWleMaN2fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702756; c=relaxed/simple;
	bh=JJ+RCaEAAhlDChYBmeURVjNFhKSKrBAif0kUS5G0LrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdToyBvdGtz3fbXbUKKLU2wiA286y2nnDY+bccjlbjWB7PXBFMJ77yfd9trinGk5rAFz2JaVPd3rIcTt8VUQZAv2NE/T8X7w1fNok6lrDqFJ6oLV+YTVkm5nSbApRNQJMdKI5dWUW2p5AKWY8SAa7g+xuUPwHvHd8Bq7VFKli1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmmHGhv7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b33953a163so609640a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 19:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714702754; x=1715307554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2jPgqeYvIrTI/ZMFkiNcL7c1VtZkdfbZkpA1BybG2D0=;
        b=PmmHGhv74PCj+6p30QRZyy0JWpYOvFVY5v9mVrT7P0QN7CqO3e0Lq6zQ10by4vMrvA
         7scZaFEsPvybGQZ4KAva7nT3nfHuu7BVUybdfaKvj14+VBXyV/V2RQ/TgcwOIA+K/VUW
         9fzsMX/H9+G97ph9oPPVq+ViQck28QP9Ss8jypArxo93k09FpJXJXW5czXrc9qj8JHRZ
         3uQvOkPDNCRx//krm84QYdAA4mOAfR7r1WkNYvOp4TVMEoPYe8TyuGPZP2MTO1rn9E6r
         cCeWtgyXSHeXbO3iR8Rg7fBE4v/cnl0qE3C5N8qRs4/6vH5ubBLnjxOObAweQ5tCVjTw
         3HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714702754; x=1715307554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jPgqeYvIrTI/ZMFkiNcL7c1VtZkdfbZkpA1BybG2D0=;
        b=itjqoJ0xzzKRUSgZcZBMaaqgshCW93NIFbW+4lYVuIgPTawTyNRNqmekKA6khMkl2s
         g4o9/guBHZPGviEdncOfjBAi2VZjvX36wd/XQIm+VNzLJkcMcvZkGhPugM8sXHBFlUO2
         oWn72CQPSHIaW/hzRXQUB2uebcixP+AXlSGGY+yWg6dj7vanHXQTpdLqdeOIq1bHz0+9
         l78CYFN8DjipPBTbPNKJn6bErX64dMkbC0cAAN4k/pTv+qkNpUIESGbm3UcH/PT00aHN
         Lry4OYLkFp3tPNfhL1y9hwe8tRrqZlxg7Wh4yrMowMfUYwyfxwAvtlj6+j2gAASL3mRr
         Th/A==
X-Gm-Message-State: AOJu0YzZ1HAF28XjZEJojf/eBalceBTlnbdYWH+k5aYCYApL6etxd0b/
	XYkTAs+Sk9mjljI9HhkAr5AnpnOAijiyFpaiMTgXvBNS0lE5rRheYodvThzM
X-Google-Smtp-Source: AGHT+IHNsVrSVIZo6bEpBTM/vcHtGu040s4ia/fBggdY+zmkg0/yrlCKCYBX1k+I9sesjeiuovDLhw==
X-Received: by 2002:a05:6a20:9695:b0:1af:667e:fe3c with SMTP id hp21-20020a056a20969500b001af667efe3cmr1403558pzc.1.1714702754192;
        Thu, 02 May 2024 19:19:14 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902ee4200b001ecc9a92e1csm2047580plo.267.2024.05.02.19.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 19:19:13 -0700 (PDT)
Date: Fri, 3 May 2024 10:19:10 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chin-Chun Chen <n26122115@gs.ncku.edu.tw>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>
Subject: Re: [PATCH 3/4] bitops: squeeze even more out of fns()
Message-ID: <ZjRJnvig6EDAaJ5K@visitorckw-System-Product-Name>
References: <20240502233204.2255158-1-yury.norov@gmail.com>
 <20240502233204.2255158-4-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502233204.2255158-4-yury.norov@gmail.com>

+Cc Chin-Chun Chen & Ching-Chun (Jim) Huang

On Thu, May 02, 2024 at 04:32:03PM -0700, Yury Norov wrote:
> The function clears N-1 first set bits to find the N'th one with:
> 
> 	while (word && n--)
> 		word &= word - 1;
> 
> In the worst case, it would take 63 iterations.
> 
> Instead of linear walk through the set bits, we can do a binary search
> by using hweight(). This would work even better on platforms supporting
> hardware-assisted hweight() - pretty much every modern arch.
> 
Chin-Chun once proposed a method similar to binary search combined with
hamming weight and discussed it privately with me and Jim. However,
Chin-Chun found that binary search would actually impair performance
when n is small. Since we are unsure about the typical range of n in
our actual workload, we have not yet proposed any relevant patches. If
considering only the overall benchmark results, this patch looks good
to me.

Regards,
Kuan-Wei

> On my Ryzen 9 5900X, the test_fns() benchmark runs binary fns() twice
> faster, comparing to linear one.
> 
> The fns8() returns 64 to make sure that in case of no bit found, the
> return value will be greater than the bit capacity of arguments of all
> fnsXX() functions up to fns64().
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/linux/bitops.h | 42 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 57ecef354f47..1c4773db56e0 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -247,17 +247,49 @@ static inline unsigned long __ffs64(u64 word)
>  	return __ffs((unsigned long)word);
>  }
>  
> +static inline unsigned long fns8(u8 word, unsigned int n)
> +{
> +	while (word && n--)
> +		word &= word - 1;
> +
> +	return word ? __ffs(word) : 64;
> +}
> +
> +static inline unsigned long fns16(u16 word, unsigned int n)
> +{
> +	unsigned int w = hweight8((u8)word);
> +
> +	return n < w ? fns8((u8)word, n) : 8 + fns8((u8)(word >> 8), n - w);
> +}
> +
> +static inline unsigned long fns32(u32 word, unsigned int n)
> +{
> +	unsigned int w = hweight16((u16)word);
> +
> +	return n < w ? fns16((u16)word, n) : 16 + fns16((u16)(word >> 16), n - w);
> +}
> +
> +static inline unsigned long fns64(u64 word, unsigned int n)
> +{
> +	unsigned int w = hweight32((u32)word);
> +
> +	return n < w ? fns32((u32)word, n) : 32 + fns32((u32)(word >> 32), n - w);
> +}
> +
>  /**
>   * fns - find N'th set bit in a word
>   * @word: The word to search
> - * @n: Bit to find
> + * @n: Bit to find, counting from 0
> + *
> + * Returns N'th set bit. If no such bit found, returns >= BITS_PER_LONG
>   */
>  static inline unsigned long fns(unsigned long word, unsigned int n)
>  {
> -	while (word && n--)
> -		word &= word - 1;
> -
> -	return word ? __ffs(word) : BITS_PER_LONG;
> +#if BITS_PER_LONG == 64
> +	return fns64(word, n);
> +#else
> +	return fns32(word, n);
> +#endif
>  }
>  
>  /**
> -- 
> 2.40.1
> 

