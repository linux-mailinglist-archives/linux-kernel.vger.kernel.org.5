Return-Path: <linux-kernel+bounces-55772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA75A84C18B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDF21C23A74
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013C58C05;
	Wed,  7 Feb 2024 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONSqO9Sf"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A24DDAD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707267118; cv=none; b=akcLIscxVrl4wlnV/TmyrRFyWn/KO0fvc1cSK0NnAg1spvflhCLGZ1dTW7rRG+s+jlCuA/tFaQ3kKRHdcurVWxdMXwJC3LI40DmBHwdmsi4U4wpRYM2mIPJU0V8fgDXNsei04HO5BQy2tGk26VOlykct8Fm1ji8YsajuTkPioJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707267118; c=relaxed/simple;
	bh=zNJXxzOEtRt0uJXobHWSX6yUAHNaIahZf4y9z7/TbsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOvRm/kGinb5XGhocDVvz629XDnULEqCzd9FORABAjohsdT+lny4PM/X7kQkUeOpj7hfa8C8HLXzY0VsAVfTrOtKzCwlznk4k2ZkVuOgT9T8qTdXNIki9Xblu5ayX823jrBK7I5h8e3uwYkWAYb+xLwNGINay4a/5PVR4PZcX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONSqO9Sf; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-363c2edac5aso204365ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 16:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707267115; x=1707871915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=baJvcfh2d5K+Em7xs4mnjX+k4FKta+zMPcd+Ztd7ZXw=;
        b=ONSqO9SfoGbRMixn7fnRtS1G/1Jjc6fXjirkAxPoivDL7+XuZZZOYresRad+Cg7iW+
         2ETEDAxrbhT7qJSXFxXzSMHKZi2zSYGwMS60d/GDR0WfjavxCBplXd3CR5AuuQhCesrq
         moBVOiMthujXGMA7skBc13mGNV7mSpU55qOjZrk5oPBxfaKAhKhlpBWm9tKNNupQLavK
         RItb0afaNhRmQZIp+agUVQmYODJ/z4CX9eTs2tJbGxpyqqiFBBL96bLe0i0wb7MehWu8
         ecwr0GMiIMLCssVsFw9s5bza9ffAIHk36bjQQYpV54ukaJkfj3FJ7AW1ftQiFXDc4ycE
         0trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707267115; x=1707871915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baJvcfh2d5K+Em7xs4mnjX+k4FKta+zMPcd+Ztd7ZXw=;
        b=vZ3+j4OY58snWzitotTEC5tdn/Wt7uZlXlPAWWfld/Zlsj9hTmsZWLzsgxzcl+m2aS
         mDlybx4OGYlTjad2TpuDvKLR1/TSWynqVINN095KXrIIjlIGF0U19C+t3+KNre+Hr0eH
         QwqWLOIlZUrWT+gujY+AW+zLsxGYcfS23hAQ2ArF5E/d6fSoMjhlEDqVIqMbnbwLDwoa
         yNwmvyJkSd8C7gS+7Ep8xNxgADHxo7PJmKcg33tGfe/3KCoWnrv65doFjSrdkSY7FbL8
         8QyMOmCL8d9m49W99vBjLEkm6/K7Tmrq8nfOIAQzaAjCZg3gvMSZmCJLkGOAqHu40n37
         RGMw==
X-Gm-Message-State: AOJu0YxThS/J+NlMAyTpIlTS5Y12Tu34rphOQ905IqDralsd3KC3o1hy
	Z43g7/+7x10LYoC8BERPJuBbc9wk0S0Ny7L7N7IfXyKhkRDGdmEtHsGJcaejQg==
X-Google-Smtp-Source: AGHT+IGa9tcSPup65Y2Ws5SFq33Iafx0c5ApEjnuekYBaJ/6NAEsvxGWsB8LTJVVfveSZlywMiHiZg==
X-Received: by 2002:a92:dc10:0:b0:363:d953:a129 with SMTP id t16-20020a92dc10000000b00363d953a129mr1746208iln.25.1707267115441;
        Tue, 06 Feb 2024 16:51:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpfl7GfkjIT0OB4pGx9trasISF1+iPcKlXo1qDPQknWfHTqtIbJi2f5hVj0rQc5zx9SI2rbEy6dlI9jc0ym4OplbpgDs0c7/V1T1zwDOvK54r0fHyUQYCMYBtEJr44LRlMYz+c/W8ayPxf/rYquE/tE3ohp4I479wCwJV0w7YtikLrgny0+iT9LQUzB/lEx6BODMPoCybksTOYvFpsH05O2AzufbmZVubZKjt5z6tJmnssldAWpRywZv6mKuApFCNvglLZPnHE0HTHGrcySkGu7JKK8flu97ZuctM3Bm27WC3HTyplvO9zmh7HfkHjsmaulEzmwvz2lNdR6SbFZsn0WwNqpr//Tc+L225b1ybsDJD2idpsa/RV7gMuPgqFuvLAi9oRCnY15hprI6LDu6uaJYeFUiTucUuSJWVzgGO1f7rKa3Oo4T9P
Received: from google.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id s5-20020a92cc05000000b00363c8e5a1a1sm28357ilp.44.2024.02.06.16.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 16:51:54 -0800 (PST)
Date: Wed, 7 Feb 2024 00:51:51 +0000
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v3 3/4] string: Allow 2-argument strscpy_pad()
Message-ID: <20240207005151.lyrtgqd4wekolwe7@google.com>
References: <20240206142027.make.107-kees@kernel.org>
 <20240206142221.2208763-3-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206142221.2208763-3-keescook@chromium.org>

Hi,

On Tue, Feb 06, 2024 at 06:22:18AM -0800, Kees Cook wrote:
> Similar to strscpy(), update strscpy_pad()'s 3rd argument to be
> optional when the destination is a compile-time known size array.

This patch is diff'd against Patch 1/4 in this series, right? I wonder
why you split them up. If I hadn't literally just read that patch I
would be mildly confused.

I suppose one reason may be that 1/4 is a standalone change with a high
percentage chance of landing whilst this overloading magic may not land
as easily?

At any rate,
Reviewed-by: Justin Stitt <justinstitt@google.com>

>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/string.h | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 79b875de615e..9bd421ad92a4 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -79,6 +79,10 @@ ssize_t sized_strscpy(char *, const char *, size_t);
>  	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
>  #define __strscpy1(dst, src, size)	sized_strscpy(dst, src, size)
>
> +#define __strscpy_pad0(dst, src, ...)	\
> +	sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst))
> +#define __strscpy_pad1(dst, src, size)	sized_strscpy_pad(dst, src, size)
> +
>  /**
>   * strscpy - Copy a C-string into a sized buffer
>   * @dst: Where to copy the string to
> @@ -104,6 +108,18 @@ ssize_t sized_strscpy(char *, const char *, size_t);
>  #define strscpy(dst, src, ...)	\
>  	CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
>
> +#define sized_strscpy_pad(dest, src, count)	({			\
> +	char *__dst = (dest);						\
> +	const char *__src = (src);					\
> +	const size_t __count = (count);					\
> +	ssize_t __wrote;						\
> +									\
> +	__wrote = sized_strscpy(__dst, __src, __count);			\
> +	if (__wrote >= 0 && __wrote < __count)				\
> +		memset(__dst + __wrote + 1, 0, __count - __wrote - 1);	\
> +	__wrote;							\
> +})
> +
>  /**
>   * strscpy_pad() - Copy a C-string into a sized buffer
>   * @dest: Where to copy the string to
> @@ -124,17 +140,8 @@ ssize_t sized_strscpy(char *, const char *, size_t);
>   * * The number of characters copied (not including the trailing %NULs)
>   * * -E2BIG if count is 0 or @src was truncated.
>   */
> -#define strscpy_pad(dest, src, count)	({			\
> -	char *__dst = (dest);						\
> -	const char *__src = (src);					\
> -	const size_t __count = (count);					\
> -	ssize_t __wrote;						\
> -									\
> -	__wrote = strscpy(__dst, __src, __count);			\
> -	if (__wrote >= 0 && __wrote < __count)				\
> -		memset(__dst + __wrote + 1, 0, __count - __wrote - 1);	\
> -	__wrote;							\
> -})
> +#define strscpy_pad(dst, src, ...)	\
> +	CONCATENATE(__strscpy_pad, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
>
>  #ifndef __HAVE_ARCH_STRCAT
>  extern char * strcat(char *, const char *);
> --
> 2.34.1
>

Thanks
Justin

