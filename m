Return-Path: <linux-kernel+bounces-6934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9324819F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4741F1F2259D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDE82D622;
	Wed, 20 Dec 2023 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cCCxmkfv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2677C25758
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so57047565e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703077570; x=1703682370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1KyF5ztvGlUul0sGfnijy8bLBROmer8p4hV5ot40fg=;
        b=cCCxmkfvWEpO+dj5MZQIx6h9Ea4Z7G4jBFih2WAmHHIrTqxUzjtookWvXTOxOrejSV
         88y+EyiAJlfDPv1bprnp48Vd2oa5etEe/HbGx47EQIhBWfvNDCZoZ7BFuha2jOAS6tGr
         mGLpmEn3wqj9rbNGZLJ0NdffapvxtdDSh2W4mWQP7PnXQ+WhfBSdqNb6W7h53sldgmJl
         dwPr7h2iFSk8OGpqNT7y4CAHM1eEQ/hgqdSrT/p0iQwEVgYLKVs7JcMPiFNC3OxNoeJU
         fosds53Lg2mt5n07Xg6kkY28Z2jM2QdlP6VUo9f4E2YdVPXVwO5qToF9CtJHq348n7Cw
         JYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703077570; x=1703682370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1KyF5ztvGlUul0sGfnijy8bLBROmer8p4hV5ot40fg=;
        b=ielj/uxdmQPuEdEXrVgcLyZAjr2jH0qz7+Ig/eARMAr41ZyGWTf03o032LuZ5P6CTy
         RxAlVF/BZTGf7Hk1WsZPnpnn/Wmk+GlWGvtech+ymA0IdErqKz3jyMVT1YkJ74TD4sFe
         dClbrF2SFyW8LHbto+PbYoayVeZk4qjqFaP3k3bYM7IeZaAheRqJ/IWgal7oKegz/g3A
         8Y2eIz8d/Aikigbp/gZZp1rcrdlWIUuJKP8OzYxwb88gbGm3Sj6Sxk22x59tY4ZDuk36
         jw9mZpEhjhIpH2del427IcbE3nAlAGEs1JzesUTt34xkSOPgMVfLvZD28vIYlJLBk7sm
         9VEQ==
X-Gm-Message-State: AOJu0YwTMQORGycgB40GWVMWI5+MKRSvuJnL3NuksXTDbQOvLiOey0/K
	FKS4zjwn2E87FiIiMQ5lL1jv9ygoijqWelhmC/2Tdg==
X-Google-Smtp-Source: AGHT+IH3uj24ZNSaD5hcYEFoV2fK8kPLrDBuLewg3RMyX7UU++/1MXG6mYfw+NgWcZzOttdoYQ5I7w==
X-Received: by 2002:a05:600c:3acd:b0:40d:377c:3b7a with SMTP id d13-20020a05600c3acd00b0040d377c3b7amr513861wms.114.1703077570294;
        Wed, 20 Dec 2023 05:06:10 -0800 (PST)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b0040c411da99csm7414902wmq.48.2023.12.20.05.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:06:09 -0800 (PST)
Date: Wed, 20 Dec 2023 13:06:06 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v8 0/2] Introducing trace buffer mapping by user-space
Message-ID: <ZYLmvmzLOBfrrsSu@google.com>
References: <20231219184556.1552951-1-vdonnefort@google.com>
 <20231219153924.2ff9c132@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219153924.2ff9c132@gandalf.local.home>

On Tue, Dec 19, 2023 at 03:39:24PM -0500, Steven Rostedt wrote:
> On Tue, 19 Dec 2023 18:45:54 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > The tracing ring-buffers can be stored on disk or sent to network
> > without any copy via splice. However the later doesn't allow real time
> > processing of the traces. A solution is to give userspace direct access
> > to the ring-buffer pages via a mapping. An application can now become a
> > consumer of the ring-buffer, in a similar fashion to what trace_pipe
> > offers.
> > 
> > Attached to this cover letter an example of consuming read for a
> > ring-buffer, using libtracefs.
> > 
> 
> I'm still testing this, but I needed to add this patch to fix two bugs. One
> is that you are calling rb_wakeup_waiters() for both the buffer and the
> cpu_buffer, and it needs to know which one to use the container_of() macro.
> 
> The other is a "goto unlock" that unlocks two locks where only one was taken.
> 
> -- Steve
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 35f3736f660b..987ad7bd1e8b 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -389,6 +389,7 @@ struct rb_irq_work {
>  	bool				waiters_pending;
>  	bool				full_waiters_pending;
>  	bool				wakeup_full;
> +	bool				is_cpu_buffer;
>  };
>  
>  /*
> @@ -771,10 +772,20 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
>  static void rb_wake_up_waiters(struct irq_work *work)
>  {
>  	struct rb_irq_work *rbwork = container_of(work, struct rb_irq_work, work);
> -	struct ring_buffer_per_cpu *cpu_buffer =
> -		container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +	struct trace_buffer *buffer;
> +	int cpu;
>  
> -	rb_update_meta_page(cpu_buffer);
> +	if (rbwork->is_cpu_buffer) {
> +		cpu_buffer = container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
> +		rb_update_meta_page(cpu_buffer);
> +	} else {
> +		buffer = container_of(rbwork, struct trace_buffer, irq_work);
> +		for_each_buffer_cpu(buffer, cpu) {
> +			cpu_buffer = buffer->buffers[cpu];
> +			rb_update_meta_page(cpu_buffer);
> +		}
> +	}

Arg, somehow never reproduced the problem :-\. I suppose you need to cat
trace/trace_pipe and mmap(trace/cpuX/trace_pipe) at the same time?

Updating the meta-page is only useful if the reader we are waking up is a
user-space one, which would only happen with the cpu_buffer version of this
function. We could limit the update of the meta_page only to this case?

>  
>  	wake_up_all(&rbwork->waiters);
>  	if (rbwork->full_waiters_pending || rbwork->wakeup_full) {
> @@ -1569,6 +1580,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>  	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
>  	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
>  	mutex_init(&cpu_buffer->mapping_lock);
> +	cpu_buffer->irq_work.is_cpu_buffer = true;
>  
>  	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
>  			    GFP_KERNEL, cpu_to_node(cpu));
> @@ -6209,7 +6221,8 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu)
>  
>  	if (cpu_buffer->mapped) {
>  		WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped + 1);
> -		goto unlock;
> +		mutex_unlock(&cpu_buffer->mapping_lock);
> +		return 0;
>  	}
>  
>  	/* prevent another thread from changing buffer sizes */

