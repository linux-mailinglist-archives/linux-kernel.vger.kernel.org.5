Return-Path: <linux-kernel+bounces-21444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22670828F2D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3CB1F2617E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA803DB9D;
	Tue,  9 Jan 2024 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSgQggyx"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436393DB9C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36074b286d6so20756835ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 13:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704836955; x=1705441755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wo7A9qf9LB8OT3yWghmU76DKbvJhNKbcUKlH0RAw79k=;
        b=pSgQggyxqdrOEfbKTdGt9A1dJvBEFb3VsNIPstbgBt70UhU6+tp6jucTnrJ1Iiz5Q7
         Fh1Qq6Kaj/LOVAJsgHPIu1X7Ulo/ruzhLKFRJqiUiPyLGK7WBh/f+LztRTbH1wjuxH+P
         wx6eEDav1UP/U98UaVmfNu9/5nLJbnla3z6Oeq2MJ5g9f1JQndUJYV7/eoqdgaj04k1h
         TFNdmclHNWpDRLWF3DSqcANXORykBT0i2ylsz4SDd6c9o6Iqgwkqx5t+sdyQazEXlWB5
         3lDu/KjFURBjiN91utW/6raS1V80NiG61OU/DJVXbvWqAuTHUuH4Iic+M1ePVSVNUqiK
         wiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704836955; x=1705441755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo7A9qf9LB8OT3yWghmU76DKbvJhNKbcUKlH0RAw79k=;
        b=rx3oH6zWm4hotXsEs58XIwaPsRMsTjbjG4WZAhTSshJ0e+D5TqvM70eUFbsL8wbWNr
         fXUcviSoMZylAMxfChdaXytNSflcqJE/uswRafgNYwGOSyEBn8WZCkOH/ngKfzBKyE65
         f/CuORGrNcAJgNGLqgTRFJ1NEr/hfTMTmASmIszOWueOTTeOuVTjphLdo/oChqSmaENc
         DhkJ4MHQBBUy32+o5zN7syUXch+TDOf3R/zC+cny3F6yjnYmgwhxm0pDRWy3F8Sw0HKk
         8N3SnJkZAyfb+SpEIj+VZgKAXHGJ5n7+a5StUAvrWpEx6v7fN9+O0lxEVrDSgCBg2nhb
         Fk2A==
X-Gm-Message-State: AOJu0YxAz2aTJTJ57CgvXdECsB8FbiolrKLY/vdULZ6fupKvWlAs18Mw
	cFNDRyowkc75Qf9+0wntgH9YKHIkDgZD
X-Google-Smtp-Source: AGHT+IGL4IMYm3sze+Q8vWqEdPeDAvIFBsLjeBFO7fQBnNQmpX0zX+Ih0rK6+6Vtp61CZ8WVjAKCVA==
X-Received: by 2002:a05:6e02:168c:b0:360:5d99:65b5 with SMTP id f12-20020a056e02168c00b003605d9965b5mr132829ila.21.1704836955117;
        Tue, 09 Jan 2024 13:49:15 -0800 (PST)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id y4-20020a92c984000000b0035ff9825323sm838799iln.30.2024.01.09.13.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 13:49:14 -0800 (PST)
Date: Tue, 9 Jan 2024 21:49:10 +0000
From: Justin Stitt <justinstitt@google.com>
To: Tanzir Hasan <tanzhasanwork@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nick DeSaulniers <nnn@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] lib/string: shrink lib/string.i via IWYU
Message-ID: <20240109214910.oeopqq5j2gyl33dc@google.com>
References: <20231214-libstringheader-v2-0-0f195dcff204@google.com>
 <20231214-libstringheader-v2-2-0f195dcff204@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214-libstringheader-v2-2-0f195dcff204@google.com>

Hi,

On Thu, Dec 14, 2023 at 09:06:13PM +0000, tanzirh@google.com wrote:
> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list changing indirect includes to direct includes.
> IWYU is implemented using the IWYUScripts github repository which is a tool that is
> currently undergoing development. These changes seek to improve build times.
>
> This change to lib/string.c resulted in a preprocessed size of
> lib/string.i from 26371 lines to 5259 lines (-80%) for the x86
> defconfig.
>

Tanzir, I wonder if you could include some of the symbol names used for
some of these more esoteric headers. Let me describe what I mean:

Andy talks about "why <vdso/...>" and perhaps some comments (in your
patch message, not in the source itself) about which symbols are being
used from these headers would serve useful. I believe IWYU can generate
this information and should clear up some confusion or lead to better
suggestions from reviewers if we understand why a header is being
included.

At any rate, this builds for me doing randconfigs on x86_64 with these
KCONFIG_SEEDs
1: 0x3DD9D136
2: 0xB4440EE4
3: 0x98778270
4: 0x8C237F26
5: 0x244F8A64
6: 0x5A5C5E5C
7: 0xA77896BC
8: 0x9B5FF0D5
9: 0x24F23F6A
10: 0x35C0A107

I applied your patch on top of 5db8752c3b81bd33.

Tested-by: Justin Stitt <justinstitt@google.com>
> Link: https://github.com/ClangBuiltLinux/IWYUScripts
>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> ---
>  lib/string.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/lib/string.c b/lib/string.c
> index be26623953d2..7fe1acefb1a1 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -16,16 +16,16 @@
>
>  #define __NO_FORTIFY
>  #include <linux/types.h>
> -#include <linux/string.h>
> -#include <linux/ctype.h>
> -#include <linux/kernel.h>
> -#include <linux/export.h>
> +#include <linux/bits.h>
>  #include <linux/bug.h>
>  #include <linux/errno.h>
> -#include <linux/slab.h>
> -
> +#include <asm/rwonce.h>
> +#include <linux/linkage.h>
> +#include <linux/stddef.h>
> +#include <vdso/limits.h>
> +#include <linux/string.h>
> +#include <linux/ctype.h>
>  #include <asm/unaligned.h>
> -#include <asm/byteorder.h>
>  #include <asm/word-at-a-time.h>
>  #include <asm/page.h>
>
>
> --
> 2.43.0.472.g3155946c3a-goog
>
Thanks
Justin

