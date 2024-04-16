Return-Path: <linux-kernel+bounces-147329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A178A729A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE0D1C21277
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BC5133983;
	Tue, 16 Apr 2024 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwtyXygl"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03ED1327ED
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289557; cv=none; b=R5oTWoSng8VhUldjUHU572CDAB0CaMM5MJV42FsWDSDKr6M3mHPZV3vBlJWMrjVGZwF3UjXt6ZK4S6MONATteoInva8kQ0XX5R1c1sohMKchH/2c+/785WrRLuGXSdMxDD3uWQbQ/i2Fp9Db93HfVdw4D/1z/4za3rDwHr32+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289557; c=relaxed/simple;
	bh=o9HyLcklcw6qXIEmpaLNIUhCnHYpytbuOpal8ZZ3TRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kz+4ctnf7xRGg187BFSJwZUn30GgTZcqsknU3U+fP2rQtW/pmlhvNdJqkDQq3GaRBQa0zPefImOxnPq3rEk0HAdPLk9E3LCg2ZeZJ2LbkbT7T+Mj082zZbekZFz58J1Kw6pS5N0a+3DS1hwJ/p9IjJbHnKvgs0MKkkn92EBNZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwtyXygl; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so16967276.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713289555; x=1713894355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JeTAsENhmGxz6+PK9ZT/1dVcAVprad3zPiwx2Dlp4rA=;
        b=iwtyXyglelsdXjw2eHFudaEy/QcJaesQ6qlseXfDYr/pTeMP6H19MHrkoxt2rEuVjH
         O0rlnuHIzRORepeUz0wYsytR1cOI32cjIC2nBnld4Hy6QdIbrArBX2EoYNQLAE447M1c
         HlDftxrk25bvJ+tlQslZqCKM8v9xM0LEXShbut/29jCqB4pCPw8sQ/Rvig22rVgzdlsh
         Zd4iTOvrF/fQyEDg8+RleuPdPDRgVqrTTooSnEXZfhrDU0tViFanvOlTn7qbbmW9JT9c
         sdb0071KreY5fmdVbE8Ezux8CXMIlzeQOvnTmyVSx3on+rlena2SE+AHJkdZprovTFbj
         2Rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713289555; x=1713894355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeTAsENhmGxz6+PK9ZT/1dVcAVprad3zPiwx2Dlp4rA=;
        b=I41/ljYOGmiZk4R11ZkO1cGZycpwftPKMivlLmM/5W+SyR1217/qCBfGiPxgrsdQ87
         PcwtCytpZD2aeQ8FgDjaQ6jKmKK3voZMmTMrw0I4pYU5AdMLQ7VSfk/2Qfg6jOV02Fvf
         PKjK4Mdc7l94GJcTYJtt59WD2pdCxshnH1+mgtUHMHULqPw476g+URgVUTLXHf7JLb37
         e+hsh22r34u9CNgO8iZXLVtIyjytYyUfjA1hgkTdaCBKBpzrkHx0ab4hGilOy/73S2Xs
         PxkazEbfXv32GH8jS76DX1/6Bj30iOur+CsQHSn3L7WOYDYyCC6JYaVKzDj41FPo9WGm
         L6jw==
X-Forwarded-Encrypted: i=1; AJvYcCXqNA0LBVyPUfVQ5Si3nKEAtMbXb7y9GMzMfxLeklv4VKObP94LxX5IDOTRt7U3/rqGMpoEvjLwfOWRvj1wh3xsEuNIjNfKTg0csPus
X-Gm-Message-State: AOJu0YxHLl1QjNw9jxGqTzq0xQbeNZ44OHhDKlF7aOKl/+IZLUMSf22L
	QECUg81jMx0g2divdu8ROnmekdRntz9V2AHDZ7j4fYG/Sm35yXOE
X-Google-Smtp-Source: AGHT+IHVPEUgR+SZR98fzT/rCUVcLjb4H783BOfJQ44dE07On8wl+wA0pgIzCQ4NdjzCQxkEypGgzw==
X-Received: by 2002:a05:6902:390:b0:dcf:a4a8:5fb3 with SMTP id f16-20020a056902039000b00dcfa4a85fb3mr2335820ybs.11.1713289554526;
        Tue, 16 Apr 2024 10:45:54 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:2767:ac3e:3052:cd0])
        by smtp.gmail.com with ESMTPSA id u40-20020a25ab2b000000b00dcd307dc310sm2583223ybi.56.2024.04.16.10.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:45:54 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:45:53 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: tglx@linutronix.de, rafael@kernel.org, akpm@linux-foundation.org,
	maz@kernel.org, florian.fainelli@broadcom.com,
	chenhuacai@kernel.org, jiaxun.yang@flygoat.com, anup@brainfault.org,
	palmer@dabbelt.com, samuel.holland@sifive.com,
	linux@rasmusvillemoes.dk, daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] cpumask: introduce cpumask_first_and_and()
Message-ID: <Zh65Uf3oWPS1/kyC@yury-ThinkPad>
References: <20240416085454.3547175-1-dawei.li@shingroup.cn>
 <20240416085454.3547175-2-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416085454.3547175-2-dawei.li@shingroup.cn>

On Tue, Apr 16, 2024 at 04:54:48PM +0800, Dawei Li wrote:
> Introduce cpumask_first_and_and() to get intersection between 3 cpumasks,
> free of any intermediate cpumask variable. Instead, cpumask_first_and_and()
> works in-place with all inputs and produce desired output directly.
> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>

Acked-by: Yury Norov <yury.norov@gmail.com>

> ---
>  include/linux/cpumask.h | 17 +++++++++++++++++
>  include/linux/find.h    | 27 +++++++++++++++++++++++++++
>  lib/find_bit.c          | 12 ++++++++++++
>  3 files changed, 56 insertions(+)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 1c29947db848..c46f9e9e1d66 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -187,6 +187,23 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
>  	return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
>  }
>  
> +/**
> + * cpumask_first_and_and - return the first cpu from *srcp1 & *srcp2 & *srcp3
> + * @srcp1: the first input
> + * @srcp2: the second input
> + * @srcp3: the third input
> + *
> + * Return: >= nr_cpu_ids if no cpus set in all.
> + */
> +static inline
> +unsigned int cpumask_first_and_and(const struct cpumask *srcp1,
> +				   const struct cpumask *srcp2,
> +				   const struct cpumask *srcp3)
> +{
> +	return find_first_and_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
> +				      cpumask_bits(srcp3), small_cpumask_bits);
> +}
> +
>  /**
>   * cpumask_last - get the last CPU in a cpumask
>   * @srcp:	- the cpumask pointer
> diff --git a/include/linux/find.h b/include/linux/find.h
> index c69598e383c1..28ec5a03393a 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -29,6 +29,8 @@ unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1, const unsign
>  					unsigned long n);
>  extern unsigned long _find_first_and_bit(const unsigned long *addr1,
>  					 const unsigned long *addr2, unsigned long size);
> +unsigned long _find_first_and_and_bit(const unsigned long *addr1, const unsigned long *addr2,
> +				      const unsigned long *addr3, unsigned long size);
>  extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
>  extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
>  
> @@ -345,6 +347,31 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
>  }
>  #endif
>  
> +/**
> + * find_first_and_and_bit - find the first set bit in 3 memory regions
> + * @addr1: The first address to base the search on
> + * @addr2: The second address to base the search on
> + * @addr3: The third address to base the search on
> + * @size: The bitmap size in bits
> + *
> + * Returns the bit number for the first set bit
> + * If no bits are set, returns @size.
> + */
> +static inline
> +unsigned long find_first_and_and_bit(const unsigned long *addr1,
> +				     const unsigned long *addr2,
> +				     const unsigned long *addr3,
> +				     unsigned long size)
> +{
> +	if (small_const_nbits(size)) {
> +		unsigned long val = *addr1 & *addr2 & *addr3 & GENMASK(size - 1, 0);
> +
> +		return val ? __ffs(val) : size;
> +	}
> +
> +	return _find_first_and_and_bit(addr1, addr2, addr3, size);
> +}
> +
>  #ifndef find_first_zero_bit
>  /**
>   * find_first_zero_bit - find the first cleared bit in a memory region
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 32f99e9a670e..dacadd904250 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -116,6 +116,18 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
>  EXPORT_SYMBOL(_find_first_and_bit);
>  #endif
>  
> +/*
> + * Find the first set bit in three memory regions.
> + */
> +unsigned long _find_first_and_and_bit(const unsigned long *addr1,
> +				      const unsigned long *addr2,
> +				      const unsigned long *addr3,
> +				      unsigned long size)
> +{
> +	return FIND_FIRST_BIT(addr1[idx] & addr2[idx] & addr3[idx], /* nop */, size);
> +}
> +EXPORT_SYMBOL(_find_first_and_and_bit);
> +
>  #ifndef find_first_zero_bit
>  /*
>   * Find the first cleared bit in a memory region.
> -- 
> 2.27.0

