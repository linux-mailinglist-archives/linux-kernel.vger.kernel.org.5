Return-Path: <linux-kernel+bounces-143830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB318A3DEC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0781F21756
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981DB4CB2E;
	Sat, 13 Apr 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcMsgQRc"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6F482D7
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713028454; cv=none; b=lP74jl/OyLE2bFI76Je7RpwGO8/pLD24M+vpzmPU5fJ3xJ9ynRjALkN9evfcudPzKz1MkWwfMVxPcvDAEX0KxmEZtEUVRqmlSvPHcrYvIh+XhvnxdDgphrzBK0ILjmMkmVRSQz2RFms9HV9AMZu4yUU573dVXYPvBW+9v2vNZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713028454; c=relaxed/simple;
	bh=XcTA/luCjnxFy1jTuldTqBkbaCVB2SCFFFKdCPF41D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGQwgLvdTaGSFEsXR6BCAg+QwTFHyWSl85rWy5so3UZbEf2kmn1qDyPK1/AuwqI1B03fcSW5pRjv+crK4l7z9+5fcSd7QaCqGJ7PoMACIVDA4pt2BUl2a2Xlf0f4zr5Ttp8NySm8mqPjJFFi1u9jHEk4QUC+L81/GVh44t88AmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcMsgQRc; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbed0710c74so1578059276.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713028451; x=1713633251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NNXqxRVe9CVDdGjQD7K7O+b7VqxredJ801rqRgpXoHs=;
        b=JcMsgQRc8IR1wSLV888l3xVOHyZ+pV204B2fFWoEWLDRHNe+HoxlZarJ0BfOzSGpP5
         41rLWrMKaJFRBvGw2Qi0QxKpdye3Jx2owbHR53MbWwWZyHzM+S/RBiyeaUpJfKKw5NRA
         A7pyqvZjmyVlcyvPxMJ4vCwhVNjy1DVhi80pP/kduPt50esBQY4mOQV0kraB+hh5DkP8
         UlpetfW7CG7zu/18Cho50jaQxOvoMrGKdIgzzAwMf7tEftpMZtZuQEZ0390ZJ+dyraiw
         gv2i5PjCyZ41fCM02WKR7f8VJp8tygjr+b7EPP/k3Kc/VIAm+ufy1DdbAa9TjjJpGx2I
         LzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713028451; x=1713633251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNXqxRVe9CVDdGjQD7K7O+b7VqxredJ801rqRgpXoHs=;
        b=LCT3pHP8FqAEfJHh+Uf5gZLQIExIxjf5S6S3irdGPoZFzKD8Nw8eiOnxNir9mqip57
         0A/mQ+VaHOZ8W05gVVFlKZmNrBF3EnIiTaE4Y6cWSwzvDymV4zLHIrTKyPqocIOW1+jy
         N446FQIDGQ5ImzRb8IpMAl3KqBqIZX3/dufkDjwj9RDAs1oO3nQSbBK4HQwof60aer7v
         qEjHu7dM4+0mpy0hGP56iZP2AK7CYxGohSU0GF2EPdh6T9HfwWhuYSAj6K4f0zz01v8s
         jqkzmIaKgRqa3wbIUUZnMJT3hylV+jqwnoKudDWH0Cii7AkIzLOId3ZYmIRDhoqcOkBC
         mQNw==
X-Forwarded-Encrypted: i=1; AJvYcCWnu1EIL+7OoMRGkdBcZAxai7m0oREri2Aiygk//Njwo/1t1NtMS3vCK1ss6NpAIfS07D6JlXX9lDG7I+7KAF/Lxgx9FDfDm11/hQvv
X-Gm-Message-State: AOJu0Ywc+b/xcfQZuh0mbFdJeQz0fAIES/Pl8ltbWjJhoIruAGjK+ixR
	8wrIW16oo/Vah48fIH5WBK4YBWcezHCkmxuquTQYPzgc8NoLl5Jh
X-Google-Smtp-Source: AGHT+IFPKq/7ygU3GL+7hvY+3YeqGWGW2Apesd2kZj994pHTyKtN1Ipb9nqqqKt8ef/Se5U4ULs7Nw==
X-Received: by 2002:a05:6902:1024:b0:dcd:19ba:10df with SMTP id x4-20020a056902102400b00dcd19ba10dfmr6222959ybt.56.1713028451509;
        Sat, 13 Apr 2024 10:14:11 -0700 (PDT)
Received: from localhost ([69.73.66.55])
        by smtp.gmail.com with ESMTPSA id u125-20020a256083000000b00dcdb7d232f9sm1262587ybb.4.2024.04.13.10.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 10:14:11 -0700 (PDT)
Date: Sat, 13 Apr 2024 10:14:10 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Chin-Chun Chen <chinchunchen2001@gmail.com>
Cc: linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
	Chin-Chun Chen <chinchunchen2001@gmail.com>
Subject: Re: [PATCH v2] include/linux/bitops.h: Fix function fns
Message-ID: <Zhq9YpzCbvom3GFx@yury-ThinkPad>
References: <20240413061204.10382-1-chinchunchen2001@gmail.com>
 <20240413155635.11486-1-chinchunchen2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413155635.11486-1-chinchunchen2001@gmail.com>

On Sat, Apr 13, 2024 at 11:56:35PM +0800, Chin-Chun Chen wrote:
> Modified the function fns to resolve a calculation error by reducing n first to correctly determine the n-th set bit instead of n+1.
> 
> This commit improves the accuracy and reliability of the code.

No it doesn't. Accuracy and reliability is tested in lib/test_bitmap.c.
Have you tried to run it before sending this patch?

What error did you mean? How does pre-decrement over post-increment fix it?

> ---
> Changes since v1:
> * Clarified the commit message.
> * Fixed the incorrect operation.
> 
> Signed-off-by: Chin-Chun Chen <chinchunchen2001@gmail.com>
> ---
>  include/linux/bitops.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 2ba557e067fe..5842d7d03f19 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -258,7 +258,7 @@ static inline unsigned long fns(unsigned long word, unsigned int n)
>  
>  	while (word) {
>  		bit = __ffs(word);
> -		if (n-- == 0)
> +		if (--n == 0)
>  			return bit;
>  		__clear_bit(bit, &word);
>  	}
> 
> base-commit: 8f2c057754b25075aa3da132cd4fd4478cdab854

What does this 'base-commit' mean?

Chin-Chun, if it's your first attempt to contribute to a public
project, you're very welcome. But you have to be more descriptive
on the error you're facing and trying to fix. The best practice is
to provide a test together with a fix.

Thanks,
Yury

--

It may be just my paranoia after UMN and xz stories, but... I
googled for this person and the email and found that it didn't
appear in public domain before now. Let's see...

