Return-Path: <linux-kernel+bounces-88465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABB586E1F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B633E1F23159
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C96C6D1B5;
	Fri,  1 Mar 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PIMASKnL"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026915A8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299711; cv=none; b=CWZcYcWESqirLUBwmwhQFHwRNT3KDkhdqB3HUAatqob3hAI84996vULnDmSOByCT/AsaGb7i2gqk4/RAP1fe5WAb2oPgkCmCXC2QtMibZRshWQG3Ys5UBOwBtFcRFNqKIkw3lNwoymKH8vNQDPYj20PuRWDyliDPT6HYhYnh5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299711; c=relaxed/simple;
	bh=C82GIYdPIX/9KXb/6EVXJCBLaeThEB6Jdu6tVjBwaaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kazfBOV+hU6HCse9vYt87M6GFCLYs/09iKXK94owcx8lyY2ZnXBfhXvh2t+zO4p5Bh+SWjLwlX7kQRsIT3paeSGEiyxj8EQk2lTmHnTmLVkpsr072HLCAs0FsxXK3o0Bjo9iA7z11z85RmGVUJSy8r/vcqan4kyjOiDUaFzjgfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PIMASKnL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4467d570cdso170424466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 05:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709299706; x=1709904506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UstNxARM/Jq0Kfll2ll531rYqIyiCVbmd3JUwI6bHV0=;
        b=PIMASKnLIux8fWD60LGfHJdzPBcrdZT9KoouapvbhnYV/GiY3F4bb5eQV589m+CCWS
         ImaMToO+IZAkCDsganDNiaRVFhtW6AbrkxI3nJ3tsQsjSbQhw2ik8zAnvQFLqFXZ/cQ5
         J2zJrwxLlfnwVBuvUeCWVjB4BvKDmVSr/XbbmPvsaqwpUcXpTOkvJn4VI83UmxyP0T73
         CepmAiSuQqiAiX00w9Niu177tBgKQuKg/073OJrweTrYQu8ZniEIdyM64NiC5SSMx/ss
         zAGz3bbKwo3QCpGT8x73YTLep7G7Q5Y4iQ4ORj4GGWXZZjY7Kpj9RX6YRDvq5iYwg1/g
         YSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709299706; x=1709904506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UstNxARM/Jq0Kfll2ll531rYqIyiCVbmd3JUwI6bHV0=;
        b=GU9cgVvjSDxCQs5q98EZuk5ogbkiHZ+ElQ1MxgAjsX+Q1EeKSsDW7a7iLfj4GBVESh
         rbotwi5/tk9Rfi10Rud/eLcqgl08zKVG2G2uLHBqSwQcOBXrYuPr+Hwp8tU9iCvB+5yN
         /faj1QhmPfl50J7HCwwgnw9jKCUBMA/haFlE2dXEr1IbW/KWAK6/Kkwvtq7tkI2lxliX
         3zJfbvuVDUHlfuNyX6vMM4mVBI7vEYuMWURnxu+umoCsjdue5KzlFoEKcxQNpgoL3CiH
         Z2BkhiT2kiYSRw2qTSfqnztSdH1q/1FWzgElVWFpNoSU6S+W3C0Ul/3JB5EKoh8PnGIE
         lylQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6eFVqcoEfW51znnB1seaWjQkjtdnX1cwaQcXy8t/c+vkgk6AqSeGgNJuvIx4KJWtiEBkeSIYv5LTNG+xpAqbxLxjELx/6BxsXNsHY
X-Gm-Message-State: AOJu0YwzSEdhcVf6EKChPApnK8pJe7opAyILW0E+89fv7Os1s4kgTbtu
	uX32grXJ9GRul0SHi3BE3hChx7ORlcnNp4baiFaTOBX99WjIXiijfdm4c/yXiqQ=
X-Google-Smtp-Source: AGHT+IGbJIS/8PI2XKT6J9WS3s7fDfe/axYkYXxI7jnSISoxs30pQew2QyNpGdxVAszA03sEF8iFBA==
X-Received: by 2002:a17:906:3c4a:b0:a3f:cf38:e906 with SMTP id i10-20020a1709063c4a00b00a3fcf38e906mr1109636ejg.13.1709299706341;
        Fri, 01 Mar 2024 05:28:26 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id gg8-20020a170906e28800b00a44804f2b1dsm751962ejb.68.2024.03.01.05.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:28:26 -0800 (PST)
Date: Fri, 1 Mar 2024 14:28:24 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 22/26] printk: nbcon: Implement emergency
 sections
Message-ID: <ZeHX-KN5Sn82te_C@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-23-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-23-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:22, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> In emergency situations (something has gone wrong but the
> system continues to operate), usually important information
> (such as a backtrace) is generated via printk(). Each
> individual printk record has little meaning. It is the
> collection of printk messages that is most often needed by
> developers and users.
> 
> In order to help ensure that the collection of printk messages
> in an emergency situation are all stored to the ringbuffer as
> quickly as possible, disable console output for that CPU while
> it is in the emergency situation. When exiting the emergency
> situation, trigger the consoles to be flushed.
> 
> Add per-CPU emergency nesting tracking because an emergency
> can arise while in an emergency situation.
> 
> Add functions to mark the beginning and end of emergency
> sections where the urgent messages are generated.
> 
> Do not print if the current CPU is in an emergency state.
> 
> Trigger console flushing when exiting all emergency nesting.
> 
> Note that the emergency state is not system-wide. While one CPU
> is in an emergency state, another CPU may continue to print
> console messages.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2404,16 +2404,29 @@ asmlinkage int vprintk_emit(int facility, int level,
>  		 * printing of all remaining records to all consoles so that
>  		 * this context can return as soon as possible. Hopefully
>  		 * another printk() caller will take over the printing.
> +		 *
> +		 * Also, nbcon_get_default_prio() requires migration disabled.
>  		 */
>  		preempt_disable();
> +
>  		/*
> -		 * Try to acquire and then immediately release the console
> -		 * semaphore. The release will print out buffers. With the
> -		 * spinning variant, this context tries to take over the
> -		 * printing from another printing context.
> +		 * Do not emit for EMERGENCY priority. The console will be
> +		 * explicitly flushed when exiting the emergency section.
>  		 */
> -		if (console_trylock_spinning())
> -			console_unlock();
> +		if (nbcon_get_default_prio() == NBCON_PRIO_EMERGENCY) {
> +			do_trylock_unlock = false;

This would cause calling defer_console_output() in this printk().
I think that we do not want it. It is done later by
nbcon_cpu_emergency_exit(). I think that we want something like:


		/*
		 * Try to acquire and then immediately release the
		 * console semaphore. The release will print out
		 * buffers. With the spinning variant, this context
		 * tries to take over the printing from another
		 * printing context.
		 *
		 * Skip it in EMERGENCY priority. The console will be
		 * explicitly flushed when exiting the emergency section.
		 */
		if (nbcon_get_default_prio() != NBCON_PRIO_EMERGENCY) {
			if (console_trylock_spinning())
				console_unlock();
		}


> +		} else {
> +			/*
> +			 * Try to acquire and then immediately release the
> +			 * console semaphore. The release will print out
> +			 * buffers. With the spinning variant, this context
> +			 * tries to take over the printing from another
> +			 * printing context.
> +			 */
> +			if (console_trylock_spinning())
> +				console_unlock();
> +		}
> +
>  		preempt_enable();
>  	}

Otherwise, it looks good.

Best Regards,
Petr

