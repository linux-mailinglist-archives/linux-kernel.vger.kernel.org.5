Return-Path: <linux-kernel+bounces-88526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0D986E2E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8081F25E57
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5146EB69;
	Fri,  1 Mar 2024 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Buwd025d"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F916EB53
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301485; cv=none; b=dFoMsuAf5Y2japucKSgaH4k5pCov9oIQEz5N72kUOHdlLK3xk5Dj4Ax5YSDJT7SZ/d6a7Spu4YCmdKd4AIhljSi+e5ec8ajPL7qNAyiKZYD547kustEMlERXfK8k7K7OLieQ9CgTGmbNnEBuGPyoGyjNzIl4LAviA/zBhMghEPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301485; c=relaxed/simple;
	bh=IPkY5L5RvHJV1+kyAKGEQuHC7FG1YODBkrabsiOsUrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYanLoBCnR7ngA/+PTMX1mP/tywhAq7q0jhDsGkDPiWhNdOyL4vz3+zTAnF3n2sfGXMaUXYstTJBLDLOOjaWFzEGiEbnOogcn+WVzmoRTZkzLp6UiRxlkOqhQAd6Ndfp8MPds3ldD1sQYu7kS3ElDmPZbOqNeWi6PV/ujiRQfWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Buwd025d; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44ad785a44so47386066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 05:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709301481; x=1709906281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E0u91w8xPXhxXtF4btdFsaDQ5OLM7qFWjI0WycLEt84=;
        b=Buwd025d9Xl2Rhzs1nGMJ5PFbTq8eFbdhuMYCTJo7WmAFu2+5dC/2OK6PoVDrURp17
         dWJdBeFwETp30d9O0lKsShX/goq80khmYyTznaL2RqXEO/jWZzs/c6xpBEFfbEOrzcwl
         tBjqFzdsE5KPlUC2cBxRw0Wjb4fHXmyhVHmPtj0QmFrznRrriRw3quyOEoL1ga/JT7UP
         mkU5MKmwGuVeQOsNnkg46c9fbVwjsby7T4omztj2Wc/cin2WigetodrISeIG/xu9ft+r
         xQSOnYIcBhfqUfpdgV/NWlrf1KR03f38BCkuF1c0fXeoX00+tDNR9Zm/X5Ebhsx06NGq
         5Gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709301481; x=1709906281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0u91w8xPXhxXtF4btdFsaDQ5OLM7qFWjI0WycLEt84=;
        b=ERTvDpVFJga9c50mP4vwM0wgLocMWBAm5U/b4m+mhBXdIgnwGKcyNt7ZItCuuuK0xH
         ap6REtZLWPgAPuBRF96YtQBRU8g6PruLm+dKNxITiW1HAupenibQb5mGqDREaxPFnp2E
         Yopk45bB9gCtK3STbhorTNnc0uiZX0tXG/4ODXVUzGt0V+s/YY2aC3I0C4+O6oyXsrvq
         VPLIwZmKiot6ARrHWdNndjyH8JYTcNrp5mKdHyZFbWQqr0Ni6X9l66pptTa/64LJuJkI
         gCUtYyGKx0r/+XfebZIq9YY/6M3cYUcJ2D+iDAEvxgIZrbuZ9AdSbauiXJfY9c4ZNG5c
         KsYg==
X-Forwarded-Encrypted: i=1; AJvYcCWGiLjBRCuONq6L8rBsIHwOmfyaabfn4gWobBiFz0wIlI4CWsPRLi3grAi9a0QoL4qMQmT0BOt9pZTJldAnnp1stctaAt6cvWDbCoaU
X-Gm-Message-State: AOJu0YytCFB9yj6Rb7eplQWGTdVU50WnQmPqR20omOhjDh78HfiEk3au
	xgfyROdemwyOTJ6B9QSjmNLcP7YYgcLd7ZmQUWNUnh2h/w0FSuBZSOALsLu2M/Q=
X-Google-Smtp-Source: AGHT+IHf1tPOQvA+FPKFde3BMg8jlnT9sLtCzvVElZwgZ/tPTZA1mc7u2ubzS6RwkLnxTE656fNMZA==
X-Received: by 2002:a17:906:68c8:b0:a44:6c15:1e7d with SMTP id y8-20020a17090668c800b00a446c151e7dmr1381343ejr.70.1709301481470;
        Fri, 01 Mar 2024 05:58:01 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id k3-20020a1709061c0300b00a3e0b7e7217sm1722473ejg.48.2024.03.01.05.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:58:01 -0800 (PST)
Date: Fri, 1 Mar 2024 14:57:59 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Uros Bizjak <ubizjak@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH printk v2 23/26] panic: Mark emergency section in warn
Message-ID: <ZeHe530CHrf1vFWH@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-24-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-24-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:23, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Mark the full contents of __warn() as an emergency section. In
> this section, the CPU will not perform console output for the
> printk() calls. Instead, a flushing of the console output is
> triggered when exiting the emergency section.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

It will change the behavior immediately even before having
any nbcon console. But it makes sense to be consistent.
Let's try it ;-)

Reviewed-by: Petr Mladek <pmladek@suse.com>

Some comments below just to document my thoughts.

> ---
>  kernel/panic.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 86813305510f..d30d261f9246 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -667,6 +667,8 @@ struct warn_args {
>  void __warn(const char *file, int line, void *caller, unsigned taint,
>  	    struct pt_regs *regs, struct warn_args *args)
>  {
> +	nbcon_cpu_emergency_enter();

This will disable preemtion. But it should not cause any big problems.
The messages should be stored quickly when the consoles are not called.

>  	disable_trace_on_warning();
>  
>  	if (file)
> @@ -697,6 +699,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,

There is called check_panic_on_warn() in this context. It might call
panic(). I first thought that printk() would still defer the consoles.
But it actually won't because vprintk_emit() checks NBCON_PRIO_EMERGENCY.

All is good in the end. I just feel that the rules, when vprintk_emit()
flushes the consoles, are pretty complicated. I am a bit nervous that
anyone could break it in the future. Well, I can't think of any
approach which would make it more regression-proof.

The only way might be to do not be so perfect and simplify the logic.
Well, the current logic makes perfect sense. Let's try it.
Maybe, I am just tired today ;-)

>  
>  	/* Just a warning, don't kill lockdep. */
>  	add_taint(taint, LOCKDEP_STILL_OK);
> +
> +	nbcon_cpu_emergency_exit();
>  }
>  

Best Regards,
Petr

