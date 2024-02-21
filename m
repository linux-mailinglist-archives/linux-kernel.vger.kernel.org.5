Return-Path: <linux-kernel+bounces-75555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D671585EB1B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3381F28982
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9207F133985;
	Wed, 21 Feb 2024 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxjvrMMI"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D412DD81;
	Wed, 21 Feb 2024 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551358; cv=none; b=oO5k34ddnqqxwmKoXCvb8IUiCSxHK0KprAsUzG+8M9CIxKwfej8gMUbyB4MEYZy7Xcp6wsfH7BgDTa7c3t2WkYzp4mZJLb8M6ewfMsPW12saKuTNmj42dM8h98kBUb0HJLh9aRH8EydR9Mvgqie3XTb7OkH/ADZOdM7bPWVa44E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551358; c=relaxed/simple;
	bh=7kAfcN1/13WrOj7hm7Y4/wFCohh865CFE4P/KUkvp1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ9W/S4jyJGaaYvE6kmuMEP20SgK+f3rB6MfRgYQu6/bIGFUtE+Kfd32zX+c5oFkctZGWANoq5nO1/Mj+5Nocyb+uXYtHdWY2imv87GPTw/EeCTeGqHxJ2D+0dXDEgk9d4U0ISCY6roKthUA+ajR7A7ic8FwS/qNFZ5qavqmyb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxjvrMMI; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c488a5af5eso6964539f.1;
        Wed, 21 Feb 2024 13:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708551356; x=1709156156; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hEhygBtosGq+EZCjwlVt0RPtsTFLG976dZg39gbKTO0=;
        b=MxjvrMMIEUwucQ17vwd1WU657hQ3Mm/unPdh9zSRwzcimFA0yUD8FAOLu8iYnRz9P0
         vZQOub1Qpr3nRaHhDXIVA+QwLmtW6FPuElHS/mtn2k8ypdW9xX4bTI8eyBMJcTIHvRyh
         E9+wO0PjkpbWDpJHMepg/81PHMr4VGEgvHyw/+lOxQYBgwjsK868aGtXfvJ6p69HsUJx
         z/R1Q2uY7b97PPcGBVWtxlrxt+kaYO6mss9BnbwiRrtuTNgr6+LH8Lc44oocoKUAreJC
         isQC8kPnhh0xiYdNPLMeAdI6714LYR4sCoWh8D4pvrmY8rnO2qtgzxFBI0oeyEykgp4Z
         h+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551356; x=1709156156;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEhygBtosGq+EZCjwlVt0RPtsTFLG976dZg39gbKTO0=;
        b=eagmxiH88QEgN2sfeU8tc9ur4z3BoIcnD9SLGjQ0zpUOqNDZZh8GywJxbBtBHcCkJy
         pSgaTMrehvYlIWFuxwLSj+m7Sn39uLkHwVBF5Zq6O/DcgPuPdijNd9eTohese8aLN2tE
         BtEwf7yJW6b9ti2MPHJVqaduK8ufGm/TKvCLS31EhmRElZE2WqcjALiECJ4jHOZmRfoe
         KqLDksQYhL9BYoQQVwayL2ONnN5Bi9FdnWQO/ZTyZjqRFRaaUZtoQU5rjltRoJuj9C8A
         0Cr51WqK3XWCPMJb5nDiqqqM8gQPXQqxKViQXF6iNJHPPZSALvDKiyVzjVk0/BV04SLA
         n0/g==
X-Forwarded-Encrypted: i=1; AJvYcCWuw0QrLmmRumJi2PxUvMCY/0nbMRV3m1h4TaUi4kcfUeTR3N/G/iOgaGyuRHKEpqDNEhgAD+q4A8ZDj+RBH0jgokKjayDAb5FZNPWSQ4xUWVIn3IGnkzxRfJqB7zugrc9JfaD1UwCwA+u/eBoaRT0m1l7JJGN7Gdaqp1hGA3/9S8pe6+9FuJN/unIcXR6/sxSgwtEEYLX3z2PmQbzuF4pM1E0hYRXMZXESqa+F
X-Gm-Message-State: AOJu0Yzi+wEBAYtX7uHT0kiKQV6E4TxRlrva4A6xsmNoj55iHmMfAyDZ
	WoDtuzoYMfNFrU4khwuZc4ZHwu+8LCVx9OdmE3rmGBFcd3ctTprCidKktZjT
X-Google-Smtp-Source: AGHT+IFmF1+6vZPUdEg3sXIJoAZI1kHF31CDjrsju8l+yXoRnYkhWW8unvAUdMdGtN7NXXgO7XVipQ==
X-Received: by 2002:a6b:6f15:0:b0:7bf:e57f:3ecf with SMTP id k21-20020a6b6f15000000b007bfe57f3ecfmr657115ioc.0.1708551356458;
        Wed, 21 Feb 2024 13:35:56 -0800 (PST)
Received: from localhost ([2a02:168:59f0:1:63b6:5e21:e19f:4684])
        by smtp.gmail.com with ESMTPSA id f32-20020a0284a3000000b00473c8573648sm3007942jai.146.2024.02.21.13.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:35:56 -0800 (PST)
Date: Wed, 21 Feb 2024 22:35:50 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Shervin Oloumi <enlightened@chromium.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] landlock: Warn once if a Landlock action is requested
 while disabled
Message-ID: <20240221.b8dcd9590c37@gnoack.org>
References: <20240219191804.2978911-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219191804.2978911-1-mic@digikod.net>

Hello!

I think this is a good idea.
Some minor implementation remarks below.

On Mon, Feb 19, 2024 at 08:18:04PM +0100, Mickaël Salaün wrote:
> Because sandboxing can be used as an opportunistic security measure,
> user space may not log unsupported features.  Let the system
> administrator know if an application tries to use Landlock but failed
> because it isn't enabled at boot time.  This may be caused by bootloader
> configurations with outdated "lsm" kernel's command-line parameter.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Fixes: 265885daf3e5 ("landlock: Add syscall implementations")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/syscalls.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index f0bc50003b46..b5b424819dee 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -33,6 +33,18 @@
>  #include "ruleset.h"
>  #include "setup.h"
>  
> +static bool is_not_initialized(void)
> +{
> +	if (likely(landlock_initialized))
> +		return false;

Optional stylistic remark; I try to avoid predicate functions which
have a "negated" meaning, because double negations are slightly more
error prone.  (We return false here, so Landlock is not not
initialized.)

> +
> +	pr_warn_once(
> +		"Disabled but requested by user space. "
> +		"You should enable Landlock at boot time: "
> +		"https://docs.kernel.org/userspace-api/landlock.html#kernel-support\n");
> +	return true;
> +}
> +
>  /**
>   * copy_min_struct_from_user - Safe future-proof argument copying
>   *
> @@ -173,7 +185,7 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>  	/* Build-time checks. */
>  	build_check_abi();
>  
> -	if (!landlock_initialized)
> +	if (is_not_initialized())
>  		return -EOPNOTSUPP;

Technically, any Landlock user needs to go through the
landlock_create_ruleset() system call anyway; it might be enough to
just add it in that place and leave the other system calls as they
were.  Then you could also omit the special function.

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

–Günther

