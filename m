Return-Path: <linux-kernel+bounces-45223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5E5842D56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EA81F256A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B11369E00;
	Tue, 30 Jan 2024 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noxo0Dsr"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD524214;
	Tue, 30 Jan 2024 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644447; cv=none; b=tGvJ4ufqYuvB73o646Ltsd4GN1zRZmf1/5NSIzIZ/NQvdKQiwW+4twKEv9I9krOJJTR/MzQktYegwDIDDdnh1NVbYDK8WzyA1VIZC5zCxlmyeh+tx7OKC2rvtm+or5KEnokSNHeFxz4k9pYDJ5OF700fGxfn+PC5A3Yej1JMmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644447; c=relaxed/simple;
	bh=QRuAGiKg2Gt5kMYsmgpV2NrhDQiqSPKbxLU+UZ+R/wM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L63Knv+2bNPJcJWEbf6FrMVbUoxvIPsLKZod9L5X5hNsXlkU4eg2Ps9lEVmXrpNyj4zUDZBUYX2dspDjcAaFg1Ulf5v7fu0NUzE+qvE+ng4TVWIpiZ5PPcn6dAT1TiN2RNPf8TFW5ylEwEyybes5n+0QxLFpyH+Z9bWDXnOOct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noxo0Dsr; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51117bfd452so2431399e87.3;
        Tue, 30 Jan 2024 11:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706644444; x=1707249244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D3wO7BFSthurTRKjqrvhcV7JSVxdDru5aDJKbt2OZqE=;
        b=noxo0DsrXM6VaKBORQBxYCIv5b8JEmp/U31qMY9ZPAtgFQSoJL4F8/82tPStMXi5ta
         e8bjrNy6Byg+rASM6X2g2cF9GJTAoaFtjoB53kNyelZu5CRzRQUi9XaQ+a5Nj+cAsgyh
         MlZKYgtZ+CKvgXVZXWASMx6S9fg26XZ1x2kGqXUmmbskT9q8hmlmAGUg8dw0fgqIQPNn
         XYX4cgYFX3H57KI/5/LDbjy4GL/95eZYbA0/6XHLuFCxEHDKHk4iwaioZ2kA3TWzxspR
         7AN+DPmBv6ieZK87XS+R/GYGNCDqeFTpcDVsNsG2kfyGklhcCVEv7l9/h5AW29XFvTD5
         3zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706644444; x=1707249244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3wO7BFSthurTRKjqrvhcV7JSVxdDru5aDJKbt2OZqE=;
        b=RBAnfEPdicdsrgxhELy0TuT1DTULHUiKXlHCTmKeDe0xj7naGNbIpYQ26JChleFJAL
         Yl9tCR2AwYfPcGBnhLIdjJx9n8SLAbBltR01NJUQve22BjGv7SsnsQjZdE4m7apdfRJG
         S0++lqoRQggmkWE97U5r1EHsUu9q64e4Q8XCQvqvFPb3fS33M+wpDfUYFnb8MOx6C9/D
         vFu+qnDDs8weNrQkx/1MokITF36vCE75Ieh1LW9BjmqdTd3GEit/cpP0yN1CGBPaI6XY
         qI32j31R4FFujhkAkKRIlfega5zDGqi3qddeAG4iA+xX/7jfuudNrR12xeZvpqnqzYb9
         fb5Q==
X-Gm-Message-State: AOJu0Yw7AkxyUfUz6E91ObjOuHJglluLSYNUThtUcKutJQS32o9EvjHo
	jTKn1MoSW+gE+le+s9Ok9jyrtFEPYWPiM+93zZgS+sSzc4+VD+7D
X-Google-Smtp-Source: AGHT+IFEQrZhBM8T+DeRxci0XROcHTplnv/b6ZUuxFUOtUSJIq+cU8fmycOszrb5TMPUF77QkIkzjg==
X-Received: by 2002:ac2:55a8:0:b0:510:27a7:cccd with SMTP id y8-20020ac255a8000000b0051027a7cccdmr7129548lfg.2.1706644443488;
        Tue, 30 Jan 2024 11:54:03 -0800 (PST)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id h5-20020a197005000000b0051120a8eb3fsm148533lfc.10.2024.01.30.11.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:54:03 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 30 Jan 2024 20:54:00 +0100
To: Lorenzo Stoakes <lstoakes@gmail.com>, Kees Cook <keescook@chromium.org>
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 33/82] mm/vmalloc: Refactor intentional wrap-around
 calculation
Message-ID: <ZblT2OjkPcZQEw7A@pc636>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-33-keescook@chromium.org>
 <24526e13-2df6-47ea-865f-b5a5594bc024@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24526e13-2df6-47ea-865f-b5a5594bc024@lucifer.local>

On Tue, Jan 30, 2024 at 06:55:57PM +0000, Lorenzo Stoakes wrote:
> On Mon, Jan 22, 2024 at 04:27:08PM -0800, Kees Cook wrote:
> > In an effort to separate intentional arithmetic wrap-around from
> > unexpected wrap-around, we need to refactor places that depend on this
> > kind of math. One of the most common code patterns of this is:
> >
> > 	VAR + value < VAR
> >
> > Notably, this is considered "undefined behavior" for signed and pointer
> > types, which the kernel works around by using the -fno-strict-overflow
> > option in the build[1] (which used to just be -fwrapv). Regardless, we
> > want to get the kernel source to the position where we can meaningfully
> > instrument arithmetic wrap-around conditions and catch them when they
> > are unexpected, regardless of whether they are signed[2], unsigned[3],
> > or pointer[4] types.
> >
> > Refactor open-coded unsigned wrap-around addition test to use
> > check_add_overflow(), retaining the result for later usage (which removes
> > the redundant open-coded addition). This paves the way to enabling the
> > unsigned wrap-around sanitizer[2] in the future.
> >
> > Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> > Link: https://github.com/KSPP/linux/issues/26 [2]
> > Link: https://github.com/KSPP/linux/issues/27 [3]
> > Link: https://github.com/KSPP/linux/issues/344 [4]
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Uladzislau Rezki <urezki@gmail.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  mm/vmalloc.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index d12a17fc0c17..7932ac99e9d3 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1223,6 +1223,7 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
> >  	unsigned long align, unsigned long vstart)
> >  {
> >  	unsigned long nva_start_addr;
> > +	unsigned long sum;
> >
> >  	if (va->va_start > vstart)
> >  		nva_start_addr = ALIGN(va->va_start, align);
> > @@ -1230,11 +1231,11 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
> >  		nva_start_addr = ALIGN(vstart, align);
> >
> >  	/* Can be overflowed due to big size or alignment. */
> > -	if (nva_start_addr + size < nva_start_addr ||
> > +	if (check_add_overflow(nva_start_addr, size, &sum) ||
> >  			nva_start_addr < vstart)
> >  		return false;
> >
> > -	return (nva_start_addr + size <= va->va_end);
> > +	return (sum <= va->va_end);
> >  }
> >
> >  /*
> > --
> > 2.34.1
> >
> 
> Looks good to me,
> 
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
Same here. One small nit though. The "sum" variable is not something
that it suits for. IMO, we should use a better name and replace it:

"nva_offset"?

--
Uladzislau Rezki

