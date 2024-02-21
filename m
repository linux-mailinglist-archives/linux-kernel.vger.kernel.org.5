Return-Path: <linux-kernel+bounces-74485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7057C85D50D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0BC2891A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22614D58A;
	Wed, 21 Feb 2024 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XeYfHNBG"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A127E3D569
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509344; cv=none; b=gkM5BCgLTnhdCZHqy/M9T1xTdv2DjbxatgAwERwNKOUUm0IkTBWrmCzEr5wckbVAwo2gml1TuNfaKgPzWp6Yyaf3aame9UjF1WNe35kdt3rm1YF9f36JjKk5OFTMMs6Lr37D2MoarHFBhRmTG3y9Gph7h7y4fF/Hfud2s+xnB0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509344; c=relaxed/simple;
	bh=JgZLBZQcJ9RFD+71cHou/Nio6U+OakhP53IZQMwrPfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQhzB5hbPV2M2lD4n4gMvAF+9kkMb9XCJAijcUxRC+VeF/G+MVOUWF0ORmcT7fBJS84vrN8xRc11wRVXdhMWqqAnREaiuPhiwhs8zUdm4XMnq5XE/ReMBaM75VXZACXkAhG0YgsR3L8xuhUhI+zuNjvvMWcYseZVwlFzDkbKAVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XeYfHNBG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-564d9b0e96dso1850809a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708509340; x=1709114140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MKaWUA238AHD6XbVPnmRsVUt8mKri+iu5YZ+VjxH69E=;
        b=XeYfHNBGePyvRUl00gjiF88z9mvaZ9mIHnBOhkU8DCZHm4wiRlIGHZ+1HMrdyc5Pdi
         5WcnvYGF4d469oX+mlo8RsqmXNlNcCnnBQBRXjJFBb+nnUG1UVnlJ9jrkU/g0SN4fFb5
         LBVVb/e6Pylb8X2rb16YvHBNCNQKnrt7dhohyip62ltubqcdDVbAkAYl2Eucu/iC8IxH
         woxIG6hxEvas1TVcoH4AJ7xCzIVFxDs9D05muM4GBxF41YJ1hm4qUslk8/ZPwbylmDGB
         ScH1Nwtbkowe+uSQa7N48jdCq/HxUdFXIiVKAXTivMh3d74qEQGmdB5EsO8WgHm4DuLv
         G5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708509340; x=1709114140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKaWUA238AHD6XbVPnmRsVUt8mKri+iu5YZ+VjxH69E=;
        b=jy1fs8XTbuIuXTFRfCjp6UEevXsi2MbOjL4cfxyPjF9Gf61fZpgPYHLf6GHwbWlOQW
         4/M3dWhayGtPeUN5Ksf2F2mKMktiVnveJ9m0BqzLuKnM0/YCTZSjZZ7U8jP6e3VwSciV
         0jer/sCxf4tqxeOMJrJmKTTzFgUXbrw7Tosn+PS4Y9cP4WAZZaBr5hx8Zv8Rq8YAwclh
         usqLYnUOenYA86Xzj8kvWKYJkmn8YsLedObYfvQIgQqPrNa1MfEEQPi+c9QOqjApSMvE
         eEpZ0pIWebNDrzohqquLvmXfUN9fe/xNaExilzi1SFPWJCi2xJxcrQ4jutXCeXZ/oi9Z
         vXbg==
X-Forwarded-Encrypted: i=1; AJvYcCVTd99RZJSFkvAguFHci0pc6xg4qp45+kfYAqyMxTBQChjFnGfSJMDKlZbjcNwxeP4H2Pm5O8VIsPwIwwRHoOtFqXAn75hXS86p63TU
X-Gm-Message-State: AOJu0Yx9UcpZ7fZre3OapFT7oRkQNMCdqyUlJb/rNXBgVaNSudfLXxT8
	NueHJu73OtiJtccAKFMwFy5Ws2nI/AnMrcpgCfKF2K6hZu6flUWaz5DQzB59QAI=
X-Google-Smtp-Source: AGHT+IHKbL3OsCklwT8Lkyw6/niEJsdATAQX+tx3g6PPL9b9Cz6tw5fhhgTIO5ABfBzd2tsQWXZS0A==
X-Received: by 2002:aa7:c390:0:b0:560:db41:7ef4 with SMTP id k16-20020aa7c390000000b00560db417ef4mr12347132edq.0.1708509339903;
        Wed, 21 Feb 2024 01:55:39 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id y5-20020aa7d505000000b0056200715130sm4418022edq.54.2024.02.21.01.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:55:39 -0800 (PST)
Date: Wed, 21 Feb 2024 10:55:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH printk v2 07/26] printk: Check
 printk_deferred_enter()/_exit() usage
Message-ID: <ZdXB-7E7kTyFGhDU@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-8-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-8-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:07, John Ogness wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Add validation that printk_deferred_enter()/_exit() are called in
> non-migration contexts.
> 
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -159,13 +159,16 @@ __printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
>  
>  extern void __printk_safe_enter(void);
>  extern void __printk_safe_exit(void);

It seems that these two does not longer need to stay in
the global linux/printk.h. The declaration can be
moved to kernel/printk/internal.h (with 'extern' removed).

> +extern void __printk_deferred_enter(void);
> +extern void __printk_deferred_exit(void);
> +
>  /*
>   * The printk_deferred_enter/exit macros are available only as a hack for
>   * some code paths that need to defer all printk console printing. Interrupts
>   * must be disabled for the deferred duration.
>   */
> -#define printk_deferred_enter __printk_safe_enter
> -#define printk_deferred_exit __printk_safe_exit
> +#define printk_deferred_enter() __printk_deferred_enter()
> +#define printk_deferred_exit() __printk_deferred_exit()
>  
>  /*
>   * Please don't use printk_ratelimit(), because it shares ratelimiting state
> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index 6d10927a07d8..8d9408d653de 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -26,6 +26,18 @@ void __printk_safe_exit(void)
>  	this_cpu_dec(printk_context);
>  }
>  
> +void __printk_deferred_enter(void)
> +{
> +	cant_migrate();
> +	this_cpu_inc(printk_context);

I would prefer to call __printk_safe_enter() here to make
it clear that they update printk_context the same way
and have the same effect.

Let's make compiler to do the inlining.

> +}
> +
> +void __printk_deferred_exit(void)
> +{
> +	cant_migrate();
> +	this_cpu_dec(printk_context);

ditto

> +}
> +
>  asmlinkage int vprintk(const char *fmt, va_list args)
>  {
>  #ifdef CONFIG_KGDB_KDB

With the two changes:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

