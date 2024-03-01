Return-Path: <linux-kernel+bounces-88589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D3F86E3C9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A7B1F25831
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E763E3A8CD;
	Fri,  1 Mar 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YDtnCS6U"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A952439FD3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304945; cv=none; b=On3HiJ4iz7uG8GMXXAgyEhfOvFMYCix6CeIfKVyHxJpvQw81ITN6SUqa3gJoVWQtyBqhRQQwzasno+E/Q3lPN2wOrvGug5l3+8zCJf9DRtsH5EqfEqoABQogvQyrjaRHJRjofadZolbgJIZAs7D5nSDeWuFkdo2tV9nWJxhrufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304945; c=relaxed/simple;
	bh=bQPdpPe0bjXh5wstbmCtzYaFXP4PTikZ/bU5Ac9ViQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpgQS/Y6TgLZqNhbXw7KzYGbSYioxlApevRtgHeFbS/QYdJn2NIMvc4ByyoaSEwXUgIBJUqFFgsOmd5c9X2IGr+p3VLXcGB58tsfknGhOCI1G7WciTVXEShyYuDD5B6Ikgc3cncRquLf7Bx0/YyiLiWT+WFJgafCO8CFVtKMkmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YDtnCS6U; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso3096334a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709304940; x=1709909740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tIdvsOfUKigwUprBnAYJrg7BhyQSgXD8z+5MkxF4Fcg=;
        b=YDtnCS6Usfr0mWdlPq0HrZq1CgCd5JHgFhqWWzRyT6iuJEiUXUIFoNaN3k1YJgEHM6
         QuduC310vYPfLW+2A+oHKEhtXlPV/XAYQNABVeUrqdwiNN0xUb073Ohy6/aBqwQU2L6C
         ibyoX2+TlKL/8d4xpj9mpb6RqaBHLbTrPuFN+pBK/hCqSD/2O1CJfJo1FffY0m5nIiR3
         lrQbrdlXgh2ky6FGW7yVijUmc3CrC6HaDuOovMUFMNZQYUHw7ZA8ZVlxhOUeF5vvB8+4
         JjS5b68AcRXzCndFnScIHMSp0U73VVb8qY6dCKbesVRvpOcPURBLj6bc9jQcrH/SXz98
         dG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709304940; x=1709909740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIdvsOfUKigwUprBnAYJrg7BhyQSgXD8z+5MkxF4Fcg=;
        b=lydpgmrhYDu+mKH3x01I8lbAILwsOmtMwrNXQ9fRb5gOx5vMmlvlDgfJS9e6uPoh+4
         JoMFO4BF/hEA0BKlJ9Sj9Yfv+XhLB++VcAx8sL18OK3q6HUXk5+Sdwktk4Q2ChL9YwLm
         ty4pndmnJRvrfTQNwKXTnGqd/Cb8yZUMmv4rLU3suolt3K+PWly7QoC18TGpujmNMeyD
         0g45JDgeYRunPNooMFDFCWz3QyhBALLwknowfCRsjty8gHjpss9wZrbYO7EQyLc+WV8+
         RHgxotq7i2zs3ztQhUsm57tLWGtNYVn7qV+XfBNV6+U30zYeiukX85CE3b295kxJNx+7
         d4tA==
X-Forwarded-Encrypted: i=1; AJvYcCVF4hWDMGXe1CPfdWOUBs5qs2K93b+S7VcjLpYHuUzUUhFtX6AHX+JEOsrX0TsJKQ4vGQ6UuqDEvDuv6SOoCSQg79vC/9BDWYzqA1fc
X-Gm-Message-State: AOJu0Yx/9kg/QOlWPAoKvSNMoQJYQjwWwkRqeooQdmGKjbmuNOwyBXes
	dejvimXVSHW8Y3aMpXLijuKS76E9QXL6F20m+quFx5r27RxZrZaZw7bUesoaBsA=
X-Google-Smtp-Source: AGHT+IHXPpirruhlTLk18RVZ6uCATf2zdAg1Y5a36wFlwpUqJt3ac59k4WUnDm1pPa+9H2jCSSgblg==
X-Received: by 2002:aa7:c648:0:b0:566:f52a:c69c with SMTP id z8-20020aa7c648000000b00566f52ac69cmr127992edr.26.1709304939952;
        Fri, 01 Mar 2024 06:55:39 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id c6-20020a056402100600b0056536eed484sm1633305edu.35.2024.03.01.06.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:55:39 -0800 (PST)
Date: Fri, 1 Mar 2024 15:55:37 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH printk v2 24/26] panic: Mark emergency section in oops
Message-ID: <ZeHsaU4CbwJSEOtG@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-25-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-25-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:24, John Ogness wrote:
> Mark an emergency section beginning with oops_enter() until the
> end of oops_exit(). In this section, the CPU will not perform
> console output for the printk() calls. Instead, a flushing of the
> console output is triggered when exiting the emergency section.
> 
> The very end of oops_exit() performs a kmsg_dump(). This is not
> included in the emergency section because it is another
> flushing mechanism that should occur after the consoles have
> been triggered to flush.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/panic.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index d30d261f9246..9fa44bc38f46 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -634,6 +634,7 @@ bool oops_may_print(void)
>   */
>  void oops_enter(void)
>  {
> +	nbcon_cpu_emergency_enter();
>  	tracing_off();
>  	/* can't trust the integrity of the kernel anymore: */
>  	debug_locks_off();
> @@ -656,6 +657,7 @@ void oops_exit(void)
>  {
>  	do_oops_enter_exit();

The comment above oops_enter() function says:

/*
 * Called when the architecture enters its oops handler, before it prints
 * anything.  If this is the first CPU to oops, and it's oopsing the first
 * time then let it proceed.
 *
 * This is all enabled by the pause_on_oops kernel boot option.  We do all
 * this to ensure that oopses don't scroll off the screen.  It has the
 * side-effect of preventing later-oopsing CPUs from mucking up the display,
 * too.
 *
 * It turns out that the CPU which is allowed to print ends up pausing for
 * the right duration, whereas all the other CPUs pause for twice as long:
 * once in oops_enter(), once in oops_exit().
 */

and indeed do_oops_enter_exit(); does the waiting.

IMHO, we should enter() the emergency context after waiting in
oops_enter(). And exit() it before waiting in oops_exit(). Aka


 void oops_enter(void)
 {
 	tracing_off();
 	/* can't trust the integrity of the kernel anymore: */
 	debug_locks_off();
 	do_oops_enter_exit();
+ 	nbcon_cpu_emergency_enter();
 
 	if (sysctl_oops_all_cpu_backtrace)
 		trigger_all_cpu_backtrace();
 }

 void oops_exit(void)
 {
+	nbcon_cpu_emergency_exit();
 	do_oops_enter_exit();
 	print_oops_end_marker();
 	kmsg_dump(KMSG_DUMP_OOPS);
 }


>  	print_oops_end_marker();
> +	nbcon_cpu_emergency_exit();
>  	kmsg_dump(KMSG_DUMP_OOPS);
>  }

Otherwise, it looks good.

Best Regards,
Petr

