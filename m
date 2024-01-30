Return-Path: <linux-kernel+bounces-45149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A916842C30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D888B284DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2625179940;
	Tue, 30 Jan 2024 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL1QkB6q"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92C679933;
	Tue, 30 Jan 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641023; cv=none; b=h46Sd96P1cLI3lmKV0pxFGBmrnm+lui2Ufeq12YCDqQbxuWXcQmmjQ/apjc2Wv6Jl/zyQwh2OC5e+R4a2yj8Jfgk/8uSSEdXbXt+K0r324lzEGyRnKWnnWxxQLOg+czeUNwdt0J/zvyRxdOxKH4Ky0F8NtbEtS7RRIerEZPiiss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641023; c=relaxed/simple;
	bh=apvqXFiYRWCsQF+0IOypeUkPltVkXaWUhN0Km/fwNGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjljNyVGyE+pVpjqm05ex4oaFmEjt5sELfUIaSpHPz/WxmzjsMBvzW4lw5Ry7S5a4BYwJseEG2Tho19o5M3U9kkT7ZX9O2qmkj5k3CLUUgrxWvk6OMkP98eG3sIby9q1dc2o3vLXKM6LfvACnUKAhtqpubNj/7I9KqqWwFqf5DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IL1QkB6q; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5102b00c2cdso3837125e87.3;
        Tue, 30 Jan 2024 10:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706641020; x=1707245820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WnPPP9gYwbIuo1o6aZoujXAzAvI1Caar+xkvAzwhO4w=;
        b=IL1QkB6qwzVSjg0wF6K9x3DvRSfeyN6pGL2Bu+qiDsO71mS5f6UXkrF5zB1nfPwc2L
         wCg7w5IFUYs5FoFes6l0/n/YmfDjvEViVDBbxbgfAmKerf8Gvq+7CQaQMfVRFZRmKDnD
         xBbXwHJleFtIEkzhntV+sstk/sem3WJN9dL93lemVubTwuUHEBOEXFEc33oPeXkQwn/5
         N53qL0tr0hnzjP+Q2KSqqhNRq8WPHDzTURcyaSvkp+mATawBYt+3OeHZbnqeSdogZwy1
         K4/2m1z/3lK3z/uUyCA9n/PmG5fcpxSIM9T+nMyefc9hEvN4kCdUSatBfJD/o6xqfBOM
         CfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641020; x=1707245820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnPPP9gYwbIuo1o6aZoujXAzAvI1Caar+xkvAzwhO4w=;
        b=VHY7yopZnGKvb1Cmn8ADP4lYhUHPj8E8kcgK3sSqriNuLp6nnb5zZGoCeEABJq2c9N
         y/TSIRhNFyLYuA/KmTmNS6u6vDxCdXbyAKc/99leCn8HYCTVpXq1bN56BVwhtQpULGRJ
         LxC2CYJnPbEULxbt15ws2xndz8+mZgEQ78Nx0Xc3Yvdvx2TXp8RiAnlcihZEGHXDieXd
         mPVyzL+QycB+6+eJQeeDZcgKPJAvNbSpHMtX5mfWAaNVWQsGr02WxtGmbwuyoFQFfFf/
         gjAU7BPss9XK1GPkm9JuU3dLcqnoiPvoua3qzUoKbIP4LZL/UgOAaPGJvp83P+dDmxlZ
         z7xA==
X-Gm-Message-State: AOJu0YyG+kffQbkcIoMU9XgzV95HjZuT+WE5meOp5lLo/R46+SLTXeb5
	+r6TbnV8VP91Xin8vH4N6P1boVwO0Tkl3d3t4AsRMVTIgwU+fX7V
X-Google-Smtp-Source: AGHT+IE3xr4rtv5MU4W4Zo8/7ZFviWGE4HTIZshULPmezl6/XqzcQv1JPSSdasRHlznLHelOdXXGkA==
X-Received: by 2002:a05:6512:6d0:b0:511:17d2:8bc0 with SMTP id u16-20020a05651206d000b0051117d28bc0mr3046779lff.41.1706641019564;
        Tue, 30 Jan 2024 10:56:59 -0800 (PST)
Received: from localhost ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4c44000000b0033aeda49732sm6045845wrt.33.2024.01.30.10.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:56:58 -0800 (PST)
Date: Tue, 30 Jan 2024 18:56:57 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 78/82] mm/vmalloc: Refactor intentional wrap-around test
Message-ID: <0e101d46-70ea-4577-8de5-bfce23a1e9bd@lucifer.local>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-78-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-78-keescook@chromium.org>

On Mon, Jan 22, 2024 at 04:27:53PM -0800, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
> 	VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 7932ac99e9d3..3d73f2ac6957 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3750,7 +3750,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
>  	addr = kasan_reset_tag(addr);
>
>  	/* Don't allow overflow */
> -	if ((unsigned long) addr + count < count)
> +	if (add_would_overflow(count, (unsigned long)addr))
>  		count = -(unsigned long) addr;
>
>  	remains = count;
> --
> 2.34.1
>

Looks good to me,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

