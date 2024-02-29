Return-Path: <linux-kernel+bounces-87062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC086CEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDA71F22184
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A206CC0A;
	Thu, 29 Feb 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ha7N0EG2"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAADC4AEF0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223550; cv=none; b=lP+rKnu0qvZd7l1lpVLMb4H5Jjfo76V2owUmIQ7xJGjRJ6FeD2htT84OBPYqa3ggSYZAizI6DEVtEwt2jn5qFCpWy15rFwxRjH8dOeRsxFPfDRS6011VC2fcrKlyC/2xCxN2u4qB40I+L0QAyCEzIJ8Gg0tDBQr8H2/0CHPQN18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223550; c=relaxed/simple;
	bh=k1JuEfQ4Qvc5ZNHTRMebE81KqehwYfeewXXa1d7VSMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPYBlNomUuW30PpqEwCx2DJmHlaK1UzLYj4Z3h1ipe/UP9OtGOBHdFta8xfrlxO7KjMLe81Qk0yShYqhmrHS9cnCPrQ2Z1yIocBfJcJ4Rd7athbFGGftjJ838s+YpLeSGbYdEoswx4hs+D2zBqG3pfKpyR+YVErSH8OBqk7HRMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ha7N0EG2; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so1624533a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709223546; x=1709828346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qs3PO5aoDIRi5/ut/q875qZ2ajqLnTLQUhetSuXcQz4=;
        b=Ha7N0EG2yyQfgvZtGOrzmrRrrdrylRA6qmoL06D6IjbWNrT5KITLjugEC9c4iuvHem
         ODvK/LDrSD1Z9fPmLrsyIMYHX+iwORQQxRVqr4rukpq/oY+8pVyGNTtFOMb6BFZO9Ajh
         GJKr7EGW8MGt1cVZj0+dotHU5xElKwi8rFwm2KzTQIXbz47R1MVQpKu72QLvhDXcQdHN
         923xfl2z6NS+oNK/jTnw7ROGTqsGn5dw/JzWEjSbte86F95EOjldBAULjDrtLpKtjwib
         FVDWE4pXTQG6Ctq87VerNwrSKmUUultDz+WU+AGfLTSUGiO3IvqvBk1bT0Met1J7Buvl
         4Img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709223546; x=1709828346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qs3PO5aoDIRi5/ut/q875qZ2ajqLnTLQUhetSuXcQz4=;
        b=C16etUoX+dMIbIAw1fXAWEjHdg9hKdbQom8l1FnC8669hvSk4WwimOhH4Igx4vpUwx
         eYqBh1aGDQ2s0RtH/U6ayZRQPgD8Jm53Y65V26P5KDnEscA9+KwvFe2Ns2QcNUoaec0a
         rpP3C09EtmvxujAqHpuS3oQiHlv1Pu4A6ZcvdR9oWuibqC5GAklxs0MgmFKf5wtyj+dk
         uyrn0XMhyzdyLGvLA2jILRGIDX0p+8J5KzfTh0pLDtrFXEAoUWZI1oxSDT90IDaw52mj
         io7yzAj6ZiXqRQuecKl8C+5e3Jwll+Ki5r+PYRYvZmChqGow1kkpTz35EWzBTsVziQER
         69Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUVGvidxa3R4dxcTEVPBbz0T7eOoFOur6ZYrB4latazpnQYMBVbxeZBv3jhW/6d2X9Oy7PwRHIcKt2y9yfzh9BMi7jFRIzDN/mIBx7Q
X-Gm-Message-State: AOJu0Yzgg85PrKA4Cu89fS6y1G7gzBDU3SXz+clnM2eEA0yQ3uajgbDN
	rNkcZNKXojFRo2u00juf6e6nqPvA1vaVFeYFMbC3QLgdaHFXYtxl5eWK+P2vJB0=
X-Google-Smtp-Source: AGHT+IFQBfCGw0EQlKBSOaNDY0QN0MDpVEyQ6AMU12dBjZoDsb1J/LF+LGLd2dgOy/xq4LoQ1uvNuQ==
X-Received: by 2002:a17:906:5ac9:b0:a43:dbd6:6862 with SMTP id x9-20020a1709065ac900b00a43dbd66862mr1989066ejs.73.1709223546204;
        Thu, 29 Feb 2024 08:19:06 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id s7-20020a170906bc4700b00a441701a0edsm822432ejv.51.2024.02.29.08.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:19:05 -0800 (PST)
Date: Thu, 29 Feb 2024 17:19:04 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: READ_ONCE: was: Re: [PATCH printk v2 19/26] printk: Avoid
 console_lock dance if no legacy or boot consoles
Message-ID: <ZeCueLN0avUV0Yhr@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-20-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-20-john.ogness@linutronix.de>

Adding Paul into Cc.

On Sun 2024-02-18 20:03:19, John Ogness wrote:
> Currently the console lock is used to attempt legacy-type
> printing even if there are no legacy or boot consoles registered.
> If no such consoles are registered, the console lock does not
> need to be taken.
> 
> Add tracking of legacy console registration and use it with
> boot console tracking to avoid unnecessary code paths, i.e.
> do not use the console lock if there are no boot consoles
> and no legacy consoles.
> 
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -44,6 +44,16 @@ enum printk_info_flags {
>  };
>  
>  extern struct printk_ringbuffer *prb;
> +extern bool have_legacy_console;
> +extern bool have_boot_console;
> +
> +/*
> + * Specifies if the console lock/unlock dance is needed for console
> + * printing. If @have_boot_console is true, the nbcon consoles will
> + * be printed serially along with the legacy consoles because nbcon
> + * consoles cannot print simultaneously with boot consoles.
> + */
> +#define printing_via_unlock (have_legacy_console || have_boot_console)
>  
>  __printf(4, 0)
>  int vprintk_store(int facility, int level,
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -463,6 +463,13 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
>  /* syslog_lock protects syslog_* variables and write access to clear_seq. */
>  static DEFINE_MUTEX(syslog_lock);
>  
> +/*
> + * Specifies if a legacy console is registered. If legacy consoles are
> + * present, it is necessary to perform the console_lock/console_unlock dance
> + * whenever console flushing should occur.
> + */
> +bool have_legacy_console;
> +
>  /*
>   * Specifies if a boot console is registered. If boot consoles are present,
>   * nbcon consoles cannot print simultaneously and must be synchronized by
> @@ -3790,22 +3807,28 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  	seq = prb_next_reserve_seq(prb);
>  
>  	/* Flush the consoles so that records up to @seq are printed. */
> -	console_lock();
> -	console_unlock();
> +	if (printing_via_unlock) {
> +		console_lock();
> +		console_unlock();
> +	}
>  
>  	for (;;) {
>  		unsigned long begin_jiffies;
>  		unsigned long slept_jiffies;
>  
> +		locked = false;
>  		diff = 0;
>  
> -		/*
> -		 * Hold the console_lock to guarantee safe access to
> -		 * console->seq. Releasing console_lock flushes more
> -		 * records in case @seq is still not printed on all
> -		 * usable consoles.
> -		 */
> -		console_lock();
> +		if (printing_via_unlock) {
> +			/*
> +			 * Hold the console_lock to guarantee safe access to
> +			 * console->seq. Releasing console_lock flushes more
> +			 * records in case @seq is still not printed on all
> +			 * usable consoles.
> +			 */
> +			console_lock();
> +			locked = true;
> +		}
>  
>  		cookie = console_srcu_read_lock();
>  		for_each_console_srcu(c) {
> @@ -3836,7 +3860,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  		if (diff != last_diff && reset_on_progress)
>  			remaining_jiffies = timeout_jiffies;
>  
> -		console_unlock();
> +		if (locked)
> +			console_unlock();

Is this actually safe?

What prevents the compiler from optimizing out the "locked" variable
and reading "printing_via_unlock" once again here?

It is not exactly the same but it is similar to "invented loads"
described at
https://lwn.net/Articles/793253/#Invented%20Loads

The writes affecting printing_via_unlock are not synchronized
by console_lock().

Should we do the following?

/*
 * Specifies if the console lock/unlock dance is needed for console
 * printing. If @have_boot_console is true, the nbcon consoles will
 * be printed serially along with the legacy consoles because nbcon
 * consoles cannot print simultaneously with boot consoles.
 *
 * Prevent compiler speculations when checking the values.
 */
#define printing_via_unlock (READ_ONCE(have_legacy_console) ||     \
			     READ_ONCE(have_boot_console))


or

		if (printing_via_unlock) {
		[...]
			WRITE_ONCE(locked, true);
		}

Or am I too paranoid?

Best Regards,
Petr

