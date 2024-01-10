Return-Path: <linux-kernel+bounces-22214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D60F829AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6A31F21BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0CF4879F;
	Wed, 10 Jan 2024 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP3DVEC/"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40BF482FC;
	Wed, 10 Jan 2024 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso5283982e87.1;
        Wed, 10 Jan 2024 05:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704892213; x=1705497013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dcp3BdvYnFjEQy7q3wABGIgUqH9mmv2OBJ3xCim2kMY=;
        b=PP3DVEC/TCmIqGDc3WbZW+M7kWv7ZjvaG/wD4ErVV3iLTD+oIS25qLCx2vnmuSVaUi
         d8t/YQAdgQDi1toDdpfzywxbiKKFg6478mq2egPuqAAxKERJIEzwRZhgyVTbSbJuEqJP
         yCCDzIH3gFBu/p/ooSUO3O+utB9f6jCyfNi+V53mWcy9CVtZzBTsHb5ysNw/P1UJcsMA
         GXF40qDaciu5RzZCArIfNSz/s4v1YmUgw2LfJqt56Wwz/UUo5SPSGSCxDfsb6u1Mca1s
         LFWR9CKE6sVJgGlBpVIXz2wdnA2g18WnUNzNDYYVeRcn3tFrfCCExdzBliPsu5gdNS9M
         anSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704892213; x=1705497013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dcp3BdvYnFjEQy7q3wABGIgUqH9mmv2OBJ3xCim2kMY=;
        b=joEgOZjTKTJFMwA/AexTUWWeRo3eCp6WX3kOupbMrtaZJp+wcV00/otycMI+/72tYO
         iqXLbOE/8vcvHO4Qfhn8kpSzdiEfJImnLjhDXji3mkBp0qAL4XgbTYUdZotZltaQP46D
         O1+wHFi/ezlWV3isREYS989J4fyRtnMUNZi0tOvRE1UBrNsJAAh+OybDmEOwYwNoVVWU
         pjqsTBVtKhGosvEzkhILmsE3/ZeQUcZoyYfbbnUMcTQazWR5mYMbnYw+xx8qzSSXsypW
         6vPR6HWDDJTr1fsJDeyNZYmz4xtxkd6mZDoXT3erSRh2hF9PlRyyKxP9gWPCVl5pl/Lj
         fwag==
X-Gm-Message-State: AOJu0Yxi29Wbz5c2SuO96IabKRYY/xXRiYfGxUSutBCyTtb1d51FFbEC
	YNhPgl32/gBRdvJHlWgkzlo=
X-Google-Smtp-Source: AGHT+IETwxojo0uhH0QtUD/lTz3fm8rpHRKidhtMuw5Jxb2NGO+a6RYpyBJ5linEVx7czgUHB+Te6w==
X-Received: by 2002:a19:ca0b:0:b0:50e:bb4d:e502 with SMTP id a11-20020a19ca0b000000b0050ebb4de502mr452352lfg.122.1704892212552;
        Wed, 10 Jan 2024 05:10:12 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u21-20020a170906069500b00a2a67731f31sm2075239ejb.109.2024.01.10.05.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 05:10:12 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 10 Jan 2024 14:10:10 +0100
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florent Revest <revest@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ftrace: Fix DIRECT_CALLS to use SAVE_REGS by default
Message-ID: <ZZ6XMk-k6NL0eInV@krava>
References: <170484558617.178953.1590516949390270842.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170484558617.178953.1590516949390270842.stgit@devnote2>

On Wed, Jan 10, 2024 at 09:13:06AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> The commit 60c8971899f3 ("ftrace: Make DIRECT_CALLS work WITH_ARGS
> and !WITH_REGS") changed DIRECT_CALLS to use SAVE_ARGS when there
> are multiple ftrace_ops at the same function, but since the x86 only
> support to jump to direct_call from ftrace_regs_caller, when we set
> the function tracer on the same target function on x86, ftrace-direct
> does not work as below (this actually works on arm64.)
> 
> At first, insmod ftrace-direct.ko to put a direct_call on
> 'wake_up_process()'.
> 
>  # insmod kernel/samples/ftrace/ftrace-direct.ko
>  # less trace
> ...
>           <idle>-0       [006] ..s1.   564.686958: my_direct_func: waking up rcu_preempt-17
>           <idle>-0       [007] ..s1.   564.687836: my_direct_func: waking up kcompactd0-63
>           <idle>-0       [006] ..s1.   564.690926: my_direct_func: waking up rcu_preempt-17
>           <idle>-0       [006] ..s1.   564.696872: my_direct_func: waking up rcu_preempt-17
>           <idle>-0       [007] ..s1.   565.191982: my_direct_func: waking up kcompactd0-63
> 
> Setup a function filter to the 'wake_up_process' too, and enable it.
> 
>  # cd /sys/kernel/tracing/
>  # echo wake_up_process > set_ftrace_filter
>  # echo function > current_tracer
>  # less trace
> ...
>           <idle>-0       [006] ..s3.   686.180972: wake_up_process <-call_timer_fn
>           <idle>-0       [006] ..s3.   686.186919: wake_up_process <-call_timer_fn
>           <idle>-0       [002] ..s3.   686.264049: wake_up_process <-call_timer_fn
>           <idle>-0       [002] d.h6.   686.515216: wake_up_process <-kick_pool
>           <idle>-0       [002] d.h6.   686.691386: wake_up_process <-kick_pool
> 
> Then, only function tracer is shown on x86.
> But if you enable 'kprobe on ftrace' event (which uses SAVE_REGS flag)
> on the same function, it is shown again.
> 
>  # echo 'p wake_up_process' >> dynamic_events
>  # echo 1 > events/kprobes/p_wake_up_process_0/enable
>  # echo > trace
>  # less trace
> ...
>           <idle>-0       [006] ..s2.  2710.345919: p_wake_up_process_0: (wake_up_process+0x4/0x20)
>           <idle>-0       [006] ..s3.  2710.345923: wake_up_process <-call_timer_fn
>           <idle>-0       [006] ..s1.  2710.345928: my_direct_func: waking up rcu_preempt-17
>           <idle>-0       [006] ..s2.  2710.349931: p_wake_up_process_0: (wake_up_process+0x4/0x20)
>           <idle>-0       [006] ..s3.  2710.349934: wake_up_process <-call_timer_fn
>           <idle>-0       [006] ..s1.  2710.349937: my_direct_func: waking up rcu_preempt-17
> 
> To fix this issue, use SAVE_REGS flag for multiple ftrace_ops flag of
> direct_call by default.

nice catch

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Fixes: 60c8971899f3 ("ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/ftrace.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b01ae7d36021..c060d5b47910 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5325,7 +5325,17 @@ static LIST_HEAD(ftrace_direct_funcs);
>  
>  static int register_ftrace_function_nolock(struct ftrace_ops *ops);
>  
> +/*
> + * If there are multiple ftrace_ops, use SAVE_REGS by default, so that direct
> + * call will be jumped from ftrace_regs_caller. Only if the architecture does
> + * not support ftrace_regs_caller but direct_call, use SAVE_ARGS so that it
> + * jumps from ftrace_caller for multiple ftrace_ops.
> + */
> +#ifndef HAVE_DYNAMIC_FTRACE_WITH_REGS
>  #define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_ARGS)
> +#else
> +#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
> +#endif
>  
>  static int check_direct_multi(struct ftrace_ops *ops)
>  {
> 

