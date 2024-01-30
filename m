Return-Path: <linux-kernel+bounces-45148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE5C842C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13239B24B36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB61479938;
	Tue, 30 Jan 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgOmOP7E"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435B169970;
	Tue, 30 Jan 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640962; cv=none; b=hiKM5wrqJmwiMJbCvb26VAJYFJINSLNK+p3SAUb5Yt8vOjwGb+MiSnMR24yiD8EV/wJJM2ITvbtbjZrGIa+e8SoVWUVTuQbD2zeWVuB1zDSKvw05QVG0CzrADtK0k8Le3ILiVfraJERk7LdWdlXMy9DuVhwmA2zObVTCaJmKOes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640962; c=relaxed/simple;
	bh=IajRvK6xa6zcMigXZ81oaSzwCBJjNYkNXX/iLH/F7VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeNnVQlZlyX9TNbI7VrppEqhQ8CU7LKGp5m3mFfNUx+YENsOv5JDKNgc0mQ3cMdZrT9J/xtHS8uBvaYCObPXJotub41dwaW4F3AakscWtwsw9zSRv32MdHrN/aWR2mYQ8kKyu3KiH0GPU3WKQsuZrDYTS4i7U85aGr4Cs311Lro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgOmOP7E; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5102e2ab56eso3929331e87.2;
        Tue, 30 Jan 2024 10:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706640959; x=1707245759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5T7oVWNTbzcJm5kGNb2xtTeTLeD9NEFmJv4kRyhpmo=;
        b=jgOmOP7EsVZFqIcsxGNr5rK0GjGNLXnj+GlZ9QXS7EARwkxDHy9oqcSqKbFwPSF11H
         G+xulzovmbFkKzPp3xdfbdI00jDLT987VxpR8icGt9U1bXh0nitfFZ/CtUSjtjR6Qnpl
         prJTKH/YfQYbBjY3HZh+bX9uIewnYdtm+TP8vBZxUb5UEWumVT57k71dJHL8SfzMRx1i
         uv18rky01Mb5ZMBfAhLhccNGMqEeZiERynZo1/52+btlzrvDrM6aeNH6MZtU9GT5phtd
         RldDUp1McEUmnRVQSOob3Q6XYZaZCyWFSUowONQ9aiLBx7YVEVPLtOrGPT2H/gUcwVXw
         FkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706640959; x=1707245759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5T7oVWNTbzcJm5kGNb2xtTeTLeD9NEFmJv4kRyhpmo=;
        b=TdeAxUvxbd7TpZxd/6XC2fNI1lgFb9a/EVhhh/OjOez1V/dxt4g2I4lJz2K3x6IJ1r
         NxpQ+AJaJ3utVzdKXfTodRwzm3RwRaXOmoqyyk11UDoBK8OJ5FUFWr8IMDdGJEyU3ksO
         3ZWY+3HgxT1C/+3NZzA9gUddj+uUKTQzZy4yvQXuP89cAdXfFiV4o2N9lqqG6jYKW2z7
         kLcli06kLawWZs3g84ibNgjXRI3T9EqN9w1Rwn8V5+RDADGDx8BiocTLFCdS5FYlGE5M
         2pIsK7toKcCrMH0spcmtUK999YlkKeCUqh16PhZbPkEEKL8LMvt5zVAINU63LrCgaD81
         6ztw==
X-Gm-Message-State: AOJu0Yyo6ER8jP2IS+GzhMec+Hjn0fe6ijmpVVWRFcnz0mUjl3ndYPAU
	44YBr8Ef2V923pOQxtIK5durMUjHZbbIVoeTgkx/NTkp3vnR5viJ
X-Google-Smtp-Source: AGHT+IHHN9DiBk7/w48kKNwAmCfjXzBDMBPMseu8RFO/EHjOhrDkATiEM32qj1bBwtRAibpOMfBYcQ==
X-Received: by 2002:ac2:4208:0:b0:510:293e:83b with SMTP id y8-20020ac24208000000b00510293e083bmr5855937lfh.18.1706640959128;
        Tue, 30 Jan 2024 10:55:59 -0800 (PST)
Received: from localhost ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c199400b0040ef5f22710sm7708532wmq.4.2024.01.30.10.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:55:58 -0800 (PST)
Date: Tue, 30 Jan 2024 18:55:57 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 33/82] mm/vmalloc: Refactor intentional wrap-around
 calculation
Message-ID: <24526e13-2df6-47ea-865f-b5a5594bc024@lucifer.local>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-33-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-33-keescook@chromium.org>

On Mon, Jan 22, 2024 at 04:27:08PM -0800, Kees Cook wrote:
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
> Refactor open-coded unsigned wrap-around addition test to use
> check_add_overflow(), retaining the result for later usage (which removes
> the redundant open-coded addition). This paves the way to enabling the
> unsigned wrap-around sanitizer[2] in the future.
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
>  mm/vmalloc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d12a17fc0c17..7932ac99e9d3 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1223,6 +1223,7 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
>  	unsigned long align, unsigned long vstart)
>  {
>  	unsigned long nva_start_addr;
> +	unsigned long sum;
>
>  	if (va->va_start > vstart)
>  		nva_start_addr = ALIGN(va->va_start, align);
> @@ -1230,11 +1231,11 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
>  		nva_start_addr = ALIGN(vstart, align);
>
>  	/* Can be overflowed due to big size or alignment. */
> -	if (nva_start_addr + size < nva_start_addr ||
> +	if (check_add_overflow(nva_start_addr, size, &sum) ||
>  			nva_start_addr < vstart)
>  		return false;
>
> -	return (nva_start_addr + size <= va->va_end);
> +	return (sum <= va->va_end);
>  }
>
>  /*
> --
> 2.34.1
>

Looks good to me,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

