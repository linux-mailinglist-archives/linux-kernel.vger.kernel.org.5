Return-Path: <linux-kernel+bounces-59664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ABE84FA10
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EF21C27387
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DC6127B78;
	Fri,  9 Feb 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+xR5KrN"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E0C7B3DA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497315; cv=none; b=jnrCiRAcoeKn6emCOfuADQs9bh2HSu9mxP5KgUns77wxuP578FDoLfl6fyLxzA8gyjiavSyplLqfGSHtERJeTEySZuq0HSXPuYk2rYwo9NxRiM/QipCxcoY+efCw2yLPbIcTBa/V0CASqhFNwIC4HHP4r7wQX3wkuGsIIfA1OxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497315; c=relaxed/simple;
	bh=FPNyBmY5ytlw890hHmQ2+MhpPZ9PzuiywFzMAas7OFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt95m817QnHz9Ur1A0HnlE9ISR5a7aEde2Nv2n/gF+nlXepCSysK5DwDlxFZ9z4P8ledLiqUsFzVDLJ+oIx90Vj/HdzbTO0HnZWRpR0JPTGpEO++QOMDuuFC76fsEz3gWREWYa8rkt58BFt2VtQbUhECNqB29E+kV+3ph389GVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+xR5KrN; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-604ac794c01so9729637b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707497313; x=1708102113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BDoPqGVOIDy3+wcfjHtZEb4REQzExwRWYroEz4tWuME=;
        b=S+xR5KrNxGZA5E0/gF0mF5HmRRhQjTDg4rehzs2DcWpUpXNaE8M87TfFkkh9n1jvHj
         Z9y++iJeLV8shxT6duVXZUJ9CAAO5on+NM8HrvB5RzY5/QO5Y7AwPE32zfzCw6vRpuO/
         5PwMH2vdTJ8Oluyj/P1F7Rg8mOkoH6JV9GiqlPT2CTh4lgBF4McNQTIOPgYTL/hE4YfN
         SlE/kVAXiadQkCPPQjcCYwkeOgD4V8x8cK4LyuIb20P32xJftwjgLbC0bAi0mkOzG8kq
         GrjAVY5m0Bj89O2vJKesYOJvT8vdKqnt0wJsqPAoSIWcZpcf9XyIl2VGWA4PU3KxJXnB
         2Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707497313; x=1708102113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDoPqGVOIDy3+wcfjHtZEb4REQzExwRWYroEz4tWuME=;
        b=aLHfuhfWIeU9Qz9MuhsSbMps4UjsrUw/g4c0Knwpf+8rVIROTzGg41nbP5bayK0K+g
         y27gLogVQNqB+mnRidLmU2J5KJXXTs3HAuJWoN6+5hlbXcVhXAPhrnm4zFP7h3OpdwJ2
         dGKAD6rqgi4jBipRyLTitzqK3eXtnptXdOMKSJjWzif7bcAoqgnhljojvEpo7BH3TEFc
         CiKPeuh9DGxZ9ATiuu8Y2FbTlpds1dNbPF2YXLG/hF+BK+9SP4iiX7Ps7qCv6LY8KAIH
         HDKvlZPalJESXJf2xOcfMVpBZzuTUkB79l6d04EDkZHii7Gi9TW3wW/lJvAnunE0LEdq
         iXHQ==
X-Gm-Message-State: AOJu0YwnQUvmkKpkZcbmb0b/nDYVWtIxYT5JT79t6BRqalWbSeZ3mOdO
	i2ThQkzGooA7nE3Zvg1k0Gn2uLw285QfgFjxUSNUeQwRDJx1gD1r
X-Google-Smtp-Source: AGHT+IGHAnv5j3jjPmcR0JvcThZ6kL5WrGr+U2/FCDlRiQcke87L3mDwYTKNqb9aPzjJNAz1t/g7uw==
X-Received: by 2002:a25:8686:0:b0:dc6:e622:f52 with SMTP id z6-20020a258686000000b00dc6e6220f52mr1943504ybk.31.1707497313092;
        Fri, 09 Feb 2024 08:48:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1a/+E+9DbNMri1t+AZUcIPf+wUz5mu1p6q31+fZg7aHGQ+BTynXWQVqxWa3/iQqp4U4MVW5MrWnWSm0WmQ19DldbgQ2tEZz0/3YNdMdDlGtqViDcAmRH0VWc4bxs6hnQkMMNvvq0rm+gf7lWdpRehASNNnUAzTj6o6TglEqnf1ukaIx5e0mn0UwNjf9xuEOzBnRYhMW86aYSk8C0HYiIx2RyurvnbhgYV3SDQcBKaIghNqJcXnKTZGkIMNNe2eUf/lA73dsI65yIvzp2tnUCZ
Received: from localhost ([2601:344:8301:57f0:be3a:6fd4:1110:3284])
        by smtp.gmail.com with ESMTPSA id l12-20020a5b0b8c000000b00dc74ac54f5fsm217643ybq.63.2024.02.09.08.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:48:32 -0800 (PST)
Date: Fri, 9 Feb 2024 08:48:31 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/3] bits: Introduce fixed-type BIT
Message-ID: <ZcZXXzEBxvyH470g@yury-ThinkPad>
References: <20240124050205.3646390-1-lucas.demarchi@intel.com>
 <20240124050205.3646390-3-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124050205.3646390-3-lucas.demarchi@intel.com>

On Tue, Jan 23, 2024 at 09:02:04PM -0800, Lucas De Marchi wrote:
> Implement fixed-type BIT() to help drivers add stricter checks, like was
> done for GENMASK.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

Reviewed-by: Yury Norov <yury.norov@gmail.com>

> ---
>  include/linux/bits.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index cb94128171b2..5754a1251078 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -24,12 +24,16 @@
>  #define GENMASK_INPUT_CHECK(h, l) \
>  	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>  		__is_constexpr((l) > (h)), (l) > (h), 0)))
> +#define BIT_INPUT_CHECK(type, b) \
> +	((BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> +		__is_constexpr(b), (b) >= BITS_PER_TYPE(type), 0))))
>  #else
>  /*
>   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
>   * disable the input check if that is the case.
>   */
>  #define GENMASK_INPUT_CHECK(h, l) 0
> +#define BIT_INPUT_CHECK(type, b) 0
>  #endif
>  
>  #define __GENMASK(t, h, l) \
> @@ -44,4 +48,9 @@
>  #define GENMASK_U32(h, l)	__GENMASK(u32, h, l)
>  #define GENMASK_U64(h, l)	__GENMASK(u64, h, l)
>  
> +#define BIT_U8(b)		((u8)(BIT_INPUT_CHECK(u8, b) + BIT(b)))
> +#define BIT_U16(b)		((u16)(BIT_INPUT_CHECK(u16, b) + BIT(b)))
> +#define BIT_U32(b)		((u32)(BIT_INPUT_CHECK(u32, b) + BIT(b)))
> +#define BIT_U64(b)		((u64)(BIT_INPUT_CHECK(u64, b) + BIT(b)))
> +
>  #endif	/* __LINUX_BITS_H */
> -- 
> 2.43.0

