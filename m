Return-Path: <linux-kernel+bounces-26319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F16B82DE74
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255D61F22BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1CA18037;
	Mon, 15 Jan 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7w/YXgX"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7650B18026
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3366e78d872so9243389f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705339754; x=1705944554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ai5BEuPBgJdRUr8PwxmyQI4MRR3hi69bZDDPThy9FXk=;
        b=K7w/YXgXoP4jiEK9rA9GOQO5th77Q9Ds0Lm0w7UBciW6O0fkpIC46VaPgZ0271bY7X
         a76gZd7XsE1iEpKitUT4VBg8JQNF4wMjOjNwYHUJ4yN9sQbhje0PB179VCgaN/dBdhoK
         L1sNY0q2Sy07irpYAXQVHSO83XCG/pRzWXTwxzJopF5HVtunirpGWl5dcdPNtK6YjD77
         s8wCtxQt4Qj4988M8fwZEuYgmurYX9+DHEfAWyinFPYcvku2qSGlZdOehJ5earlRo7B7
         ICikpBY/XkkZgunsaH98qZtibrS3x5g1hOMjmB9fF3N+nS83xv8xHX1ujhSUl2BgDzoR
         Wfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705339754; x=1705944554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ai5BEuPBgJdRUr8PwxmyQI4MRR3hi69bZDDPThy9FXk=;
        b=IPh1k0KZbhqE2pvNe194jTPjNYmp1EdSV3S9eFZ26uXqUJ2gPWEhLnplX8V0R7a/t+
         m6pW4bM9qz5P0IjBmM7wahbIojl9ahcoBzYGEPaGLHMi1/GCt4USsTy4En3eOZrymd5i
         V59cw5ZldXVK4VdXvzMtL4GtEzdVNwwtjAZHIt1w3yvUC4qg2Lkbu67FyIkB3w7a1P2h
         qJbWZ0J2BMiXfrd1ctosIZaguRi/LS9JOI34n8sFPNJHa/AEZ2hPq0lCdx3YzPSo2fDk
         ogtiFMx0xFzVze43lsBRgfLowwkkoTRbOgTsfAQSbxPnRFR9xYJ/eMi78RDQs6ez1F5N
         QuXQ==
X-Gm-Message-State: AOJu0YyWtXtxCQiUBZ1U1IghlFCjGCA8av03foA6REnfjiU7vH3y08k8
	CPLXusH08516jyibxlyrZlKXlgbqO97N
X-Google-Smtp-Source: AGHT+IFQTaDfvf7v3WP26b0V479Wm8BRZn2Vmv1GF0ymy/YLy1f98HYllWIsxZJjjmAHCSoowZ4KTQ==
X-Received: by 2002:a5d:47c1:0:b0:337:ae47:a25b with SMTP id o1-20020a5d47c1000000b00337ae47a25bmr355426wrc.189.1705339753626;
        Mon, 15 Jan 2024 09:29:13 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id v23-20020a5d5917000000b00337876596d1sm12348245wrd.111.2024.01.15.09.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 09:29:13 -0800 (PST)
Date: Mon, 15 Jan 2024 17:29:09 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com
Subject: Re: [PATCH v11 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZaVrZWGgmBNbsNba@google.com>
References: <20240111161712.1480333-1-vdonnefort@google.com>
 <20240111161712.1480333-3-vdonnefort@google.com>
 <20240115134303.1a673e37b8e7d35a33d8df52@kernel.org>
 <ZaVRO76JxaHjPwCi@google.com>
 <20240115110938.613380ca@rorschach.local.home>
 <20240115112359.65dcecbf@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115112359.65dcecbf@rorschach.local.home>

On Mon, Jan 15, 2024 at 11:23:59AM -0500, Steven Rostedt wrote:
> On Mon, 15 Jan 2024 11:09:38 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > No. The ring buffer logic should not care if the user of it is swapping
> > the entire ring buffer or not. It only cares if parts of the ring
> > buffer is being swapped or not. That's not the level of scope it should
> > care about. If we do not want a swap to happen in update_max_tr()
> > that's not ring_buffer.c's problem. The code to prevent that from
> > happening should be 100% in trace.c.
> 
> What needs to be done, and feel free to add this as a separate patch,
> is to have checks where snapshot is used.
> 
>   (All errors return -EBUSY)
> 
> Before allowing mapping, check to see if:
> 
>  1) the current tracer has "use_max_tr" set.
>  2) any event has a "snapshot" trigger set
>  3) Any function has a "snapshot" command set

Could we sum-up this with a single check to allocate_snapshot? If that is
allocated it's probably because we'll be using it?

That would simply add the requirement to echo 0 > snapshot before starting the
memory map?

The opposite could be to let tracing_alloc_snapshot_instance() fail whenever a
mapping is in place?

> 
> Fail if any of the above is true.
> 
> Also in reverse, if the buffer is mapped, then fail:
> 
>  1) a tracer being set that has "use_max_tr" set.
>  2) a "snapshot" command being set on a function
>  3) a "snapshot" trigger being set on an event.
> 
> For the last two, we may be able to get away with just a below as well.
> Adding the tr->flags bit. We could also add a tr->snapshot count to
> keep track of everything that is using a snapshot, and if that count is
> non-zero, mapping fails.
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2a7c6fd934e9..f534f74ae80f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1175,6 +1175,12 @@ static void tracing_snapshot_instance_cond(struct trace_array *tr,
>  		return;
>  	}
>  
> +	if (tr->flags & TRACE_ARRAY_FL_MAPPED) {
> +		trace_array_puts(tr, "*** BUFFER IS MEMORY MAPPED ***\n");
> +		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
> +		return;
> +	}
> +
>  	local_irq_save(flags);
>  	update_max_tr(tr, current, smp_processor_id(), cond_data);
>  	local_irq_restore(flags);
> 
> 
> -- Steve
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 

