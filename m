Return-Path: <linux-kernel+bounces-147332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2C48A729E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868E81C210AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E751339A4;
	Tue, 16 Apr 2024 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhylNDim"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248A4133406
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289790; cv=none; b=esFbpnqU4EjRTI1l7HN+M1LubaP9LGxtiYm6nHwgvjaoVDw2lhKZnHPWpd6CNB0AMoz0PY7Tm02MsnXeP+ZDquQSIbmzIIS1R3UKKQijQwwXmz4MXpGI6Xxgsfk26bTje36lz0wJL/vG/IHMUuaH0Gom/aeFQhAohATW2R2lpZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289790; c=relaxed/simple;
	bh=P2UTUbEl642qFgpAIeFvtPleLL04SGpM9dzbOQiG1bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0Ni1XM3Qr1HpZyjavCumcwsTo1MHoWcyHuHlxHNnJfxaNYRtRn4jx6r1hmZn0k3hChfdRrtvZWleEik9v/FgqzKoIyWy0ThypWqadtYix0RKhzv04skSGpfoIYsxqtQjeKTqJtWV4CkwV8lH+dDBIvCJ8VsFyYh3Q/x07PwHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhylNDim; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61ab6faf179so33864307b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713289788; x=1713894588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OeoegoV3xpDkLCIRZ5JpY1HyOhfbZrTazm3NOgMMTTE=;
        b=jhylNDimYVUO1AC4uQ+7h1oqBYzEaNItpRl2iqIre3cy7eg+fje1UODLZrPYURL8xn
         aIZz2VF0+gdVeVaRAWoMt7cSZcflOSnQ1CTQtzNOIxKP+s8s+DJSzMUE3NLzvdvNGO2P
         yuR4p9wb9aWdpzdHsmrILV2ywhV9heV48dCrYO8XCQIedBEijZQXCkhFjo5G2XuhBVk+
         IBGDNAfR35G3KRpDmIGav/KigDZIkIhOftBM6f16Ke6wo72BabnJpWT7Z5C3GBHNb8Ng
         37sqcRmOMs7eHTkH7aGTx2C8EIrmM7rcPjue0Lp6nMmv2P09P3N3f7SC4OnZWxHzNdkk
         Y+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713289788; x=1713894588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeoegoV3xpDkLCIRZ5JpY1HyOhfbZrTazm3NOgMMTTE=;
        b=hA6bDfZHKotH826XUwxhI1lZI3hQcw18ViauKXnHES2uwDsGf/zXDZPRjtsnsipieu
         yWA/UHC0zuVNoXGcrXR5yUV1+USrfuB9gzoRrB6+NP+3THeLg/aJfI8scIAPqmg/DdW9
         3MsmheIhPA/vcEoCOBd6dZArwQ7zwxUo3LGklSMcyeenXYdkVpovNABtxXsCyDL9iSG3
         PMcakz37l2H0FpFws1L/0dxS4lHZ/bActlA3NLO8pRn3u1bbZZQocylrC7lNq6qEFX/Q
         qx8gJZ/81MX0K369M0aoFa36jaVH9oEnZqolaXTdzKqS8QOcwSDmFIegCHmyyOYML92q
         LD5g==
X-Forwarded-Encrypted: i=1; AJvYcCXOcOzCUXbtUqMWvJ98x+Ciyx8UcKe8eCdBClc+FYXfk6x8XikcbOkw51lwOsWTBG4x7f6TYskK1v+K6hnC8pZSICa/Eour3QrS145p
X-Gm-Message-State: AOJu0Yz5lNyf4j9iXw6reD9W/tTOuZgtUoz6gDaFsErVYZj21MvR//oi
	0zpc7S4UPc7q4/Z+pq30Ey1HUM+ndxwbmHV5jBSkskkTgTCoeRLQ
X-Google-Smtp-Source: AGHT+IHmQ6tYh5XzwcyrSnrSKz+o7z/+9VP/TlDgBnXZeBagjn7Ox1ODgympUKv4VFM+kSmjUIb5ew==
X-Received: by 2002:a81:9f03:0:b0:615:800d:67b2 with SMTP id s3-20020a819f03000000b00615800d67b2mr12344044ywn.29.1713289787854;
        Tue, 16 Apr 2024 10:49:47 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:2767:ac3e:3052:cd0])
        by smtp.gmail.com with ESMTPSA id b1-20020a81bc41000000b006156ced7476sm2530859ywl.62.2024.04.16.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:49:47 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:49:46 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: tglx@linutronix.de, rafael@kernel.org, akpm@linux-foundation.org,
	maz@kernel.org, florian.fainelli@broadcom.com,
	chenhuacai@kernel.org, jiaxun.yang@flygoat.com, anup@brainfault.org,
	palmer@dabbelt.com, samuel.holland@sifive.com,
	linux@rasmusvillemoes.dk, daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] cpumask: introduce cpumask_first_and_and()
Message-ID: <Zh66OpVlYL2p0Jbn@yury-ThinkPad>
References: <20240416085454.3547175-1-dawei.li@shingroup.cn>
 <20240416085454.3547175-2-dawei.li@shingroup.cn>
 <Zh65Uf3oWPS1/kyC@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh65Uf3oWPS1/kyC@yury-ThinkPad>

On Tue, Apr 16, 2024 at 10:45:54AM -0700, Yury Norov wrote:
> On Tue, Apr 16, 2024 at 04:54:48PM +0800, Dawei Li wrote:
> > Introduce cpumask_first_and_and() to get intersection between 3 cpumasks,
> > free of any intermediate cpumask variable. Instead, cpumask_first_and_and()
> > works in-place with all inputs and produce desired output directly.

Still there: s/produce/produces

But whatever. Also, I think this patch would better go with the rest
of the series, right?

> > 
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> 
> Acked-by: Yury Norov <yury.norov@gmail.com>
> 
> > ---
> >  include/linux/cpumask.h | 17 +++++++++++++++++
> >  include/linux/find.h    | 27 +++++++++++++++++++++++++++
> >  lib/find_bit.c          | 12 ++++++++++++
> >  3 files changed, 56 insertions(+)
> > 
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index 1c29947db848..c46f9e9e1d66 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -187,6 +187,23 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
> >  	return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
> >  }
> >  
> > +/**
> > + * cpumask_first_and_and - return the first cpu from *srcp1 & *srcp2 & *srcp3
> > + * @srcp1: the first input
> > + * @srcp2: the second input
> > + * @srcp3: the third input
> > + *
> > + * Return: >= nr_cpu_ids if no cpus set in all.
> > + */
> > +static inline
> > +unsigned int cpumask_first_and_and(const struct cpumask *srcp1,
> > +				   const struct cpumask *srcp2,
> > +				   const struct cpumask *srcp3)
> > +{
> > +	return find_first_and_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
> > +				      cpumask_bits(srcp3), small_cpumask_bits);
> > +}
> > +
> >  /**
> >   * cpumask_last - get the last CPU in a cpumask
> >   * @srcp:	- the cpumask pointer
> > diff --git a/include/linux/find.h b/include/linux/find.h
> > index c69598e383c1..28ec5a03393a 100644
> > --- a/include/linux/find.h
> > +++ b/include/linux/find.h
> > @@ -29,6 +29,8 @@ unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1, const unsign
> >  					unsigned long n);
> >  extern unsigned long _find_first_and_bit(const unsigned long *addr1,
> >  					 const unsigned long *addr2, unsigned long size);
> > +unsigned long _find_first_and_and_bit(const unsigned long *addr1, const unsigned long *addr2,
> > +				      const unsigned long *addr3, unsigned long size);
> >  extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
> >  extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
> >  
> > @@ -345,6 +347,31 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
> >  }
> >  #endif
> >  
> > +/**
> > + * find_first_and_and_bit - find the first set bit in 3 memory regions
> > + * @addr1: The first address to base the search on
> > + * @addr2: The second address to base the search on
> > + * @addr3: The third address to base the search on
> > + * @size: The bitmap size in bits
> > + *
> > + * Returns the bit number for the first set bit
> > + * If no bits are set, returns @size.
> > + */
> > +static inline
> > +unsigned long find_first_and_and_bit(const unsigned long *addr1,
> > +				     const unsigned long *addr2,
> > +				     const unsigned long *addr3,
> > +				     unsigned long size)
> > +{
> > +	if (small_const_nbits(size)) {
> > +		unsigned long val = *addr1 & *addr2 & *addr3 & GENMASK(size - 1, 0);
> > +
> > +		return val ? __ffs(val) : size;
> > +	}
> > +
> > +	return _find_first_and_and_bit(addr1, addr2, addr3, size);
> > +}
> > +
> >  #ifndef find_first_zero_bit
> >  /**
> >   * find_first_zero_bit - find the first cleared bit in a memory region
> > diff --git a/lib/find_bit.c b/lib/find_bit.c
> > index 32f99e9a670e..dacadd904250 100644
> > --- a/lib/find_bit.c
> > +++ b/lib/find_bit.c
> > @@ -116,6 +116,18 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
> >  EXPORT_SYMBOL(_find_first_and_bit);
> >  #endif
> >  
> > +/*
> > + * Find the first set bit in three memory regions.
> > + */
> > +unsigned long _find_first_and_and_bit(const unsigned long *addr1,
> > +				      const unsigned long *addr2,
> > +				      const unsigned long *addr3,
> > +				      unsigned long size)
> > +{
> > +	return FIND_FIRST_BIT(addr1[idx] & addr2[idx] & addr3[idx], /* nop */, size);
> > +}
> > +EXPORT_SYMBOL(_find_first_and_and_bit);
> > +
> >  #ifndef find_first_zero_bit
> >  /*
> >   * Find the first cleared bit in a memory region.
> > -- 
> > 2.27.0

