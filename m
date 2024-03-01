Return-Path: <linux-kernel+bounces-88608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5271D86E417
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A27B21875
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E1A6BFDE;
	Fri,  1 Mar 2024 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Soh8tyeI"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593DE67E8E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306013; cv=none; b=dlDXiNibhJjf1g/jDSZwzSS3otsidNzoUjhQh0GnuEIb8RXAgK7pA9UCSPytFZ3NqlWohk6hD2hRfr9oS213iyn98d8EB/qMRey91wJ4rxvWSIIZEBFww173JczTqIqfyVC6Y+rca7tGgJlLlhEqSBbrYocZVM9ljmw7ZeqY1/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306013; c=relaxed/simple;
	bh=PebnkUuVTIKrTfkdeZeFzM4Bp/iInDLtHpeJBmzIpLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYU2MRmT+UdZd3I/2T0QA7jjpMlPfuhixk9r3WCazhjSdZHYIE0ckdU0nzcBBSSbHI5fgZ1qERFaZfUjYw9n8fzBQbimqrXFqlf9RYChMMtfZLUILevfVrUxNJmYZQn8WXRH9ZgMcSyH3MYSFLjoWtgCbzsEToXsEd62rk8I670=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Soh8tyeI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a44665605f3so212050066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 07:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709306009; x=1709910809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HDkjb/3ycOtyX9DruBw4yM0aFf/SrD3+DOAhw0JNHrc=;
        b=Soh8tyeI0D7FXPUk4acDygDR8rdIBeb6zQgZTzYXsTP7oHd5AEwkoA4fWYOUQgUdfe
         RvVvvfnsYMZyj06Z7dVxBLTznRdBjoNXbuwLuiF0gsdmX/6p/aBaZmluF+UkXFT2p8Sy
         5Vjmv/wbIwUnlKFXmibUeHY3f6i+oJvVIPZfFQ2j5LOiR9PUlJM/xI6ILnZg+OZ699dv
         ZUQsX1x7f0dvbua260VRBrkS5tDYm1fEzSe87ahz8ZpyTJg0QajpIKYeKg/FH4yZuN4/
         lCo9LjBN4t8VP3DGZARGtdNM5LLB6vgNvNnObjyaE70RCqUYRwWnbxsIwi7xTnYGPU66
         CfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709306009; x=1709910809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDkjb/3ycOtyX9DruBw4yM0aFf/SrD3+DOAhw0JNHrc=;
        b=gJ3G7Li0bY83XOmI/Yp478sLuSisqpTnDz3Fwi0hdvznWc7zFtlynlAj/zdI+Uta5j
         RDpHJJWutXtA5ylgi2DzrH8JRpMzohpQg70BSAfH84gW841ZBTu1sH3xkpA1gCj0DGCl
         toNafnoejIzV8XriPFM0Gdr3LEBaYqOIgoDJlr4PVh15D1KuVPl0SLU8VcGxKC+hvEim
         +bT84YOrRQLtlq/K/DhFt1VxJaFxC5XxajxrZCFfzVGPi6lTJ/HQUQ3p0aDKhtPnwmcp
         TiHToEH6VGr0Kr9oztV8C9vQ/nFv7zcuzZSlUiJ8ov9p4ABwVPn5xQ0T1Ek2VZRcCoVw
         cE5A==
X-Forwarded-Encrypted: i=1; AJvYcCXEc+8iCLDTk4c0bkYrKZFrdPMQ1U1DeoYr62RJRlkErMwyuUuhQjR/IMqUDvlL/C2OI69Lktl/IzYBVSyPDFJ8B3aSH5HfBGeh6GCB
X-Gm-Message-State: AOJu0YzFG/XZtzx/FpczkhQJoZXYOe2phSZSPLdbqykdaPz6NFxHngWY
	oB+2y+ElN0p07Obg3pP5esF7Ma7+FP3oK5+iKtgkPxcdTCKK3jK+EIg4nF6hNWk=
X-Google-Smtp-Source: AGHT+IFTY55Wj25m0rpyyfxtHm3gpdleYksn/7veTld3RUy8XLWRBDSXZuFQrny/q9cL7tsHEE6O/g==
X-Received: by 2002:a17:906:6ac7:b0:a44:9aea:779f with SMTP id q7-20020a1709066ac700b00a449aea779fmr1132507ejs.44.1709306009182;
        Fri, 01 Mar 2024 07:13:29 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id le6-20020a170906ae0600b00a449b4f4aefsm488987ejb.178.2024.03.01.07.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:13:28 -0800 (PST)
Date: Fri, 1 Mar 2024 16:13:27 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v2 25/26] rcu: Mark emergency section in rcu stalls
Message-ID: <ZeHwl63uXDZ9ZBtt@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-26-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-26-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:25, John Ogness wrote:
> Mark an emergency section within print_other_cpu_stall(), where
> RCU stall information is printed. In this section, the CPU will
> not perform console output for the printk() calls. Instead, a
> flushing of the console output is triggered when exiting the
> emergency section.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

I was just curious about one thing. But it seems to work well.

print_other_cpu_stall() print backtraces on other CPUs via NMI.
The other CPUs would not see the emergency context. They would
call defer_console_output() because they are in NMI. As a result:

  + Legacy consoles might be flushed on other CPUs even before
    nbcon_cpu_emergency_exit() gets called.

  + nbcon consoles might still be flushed by the printk kthread
    until all messages get flushed directly by nbcon_cpu_emergency_exit()

As I wrote. The behavior is corrent. It was just not obvious to me.


> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -9,6 +9,7 @@
>  
>  #include <linux/kvm_para.h>
>  #include <linux/rcu_notifier.h>
> +#include <linux/console.h>
>  
>  //////////////////////////////////////////////////////////////////////////////
>  //
> @@ -604,6 +605,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	if (rcu_stall_is_suppressed())
>  		return;
>  
> +	nbcon_cpu_emergency_enter();
> +
>  	/*
>  	 * OK, time to rat on our buddy...
>  	 * See Documentation/RCU/stallwarn.rst for info on how to debug
> @@ -658,6 +661,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	panic_on_rcu_stall();
>  
>  	rcu_force_quiescent_state();  /* Kick them all. */
> +
> +	nbcon_cpu_emergency_exit();
>  }
>  
>  static void print_cpu_stall(unsigned long gps)

Best Regards,
Petr

