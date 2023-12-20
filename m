Return-Path: <linux-kernel+bounces-6990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AF481A040
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333221C20B15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C66C374D1;
	Wed, 20 Dec 2023 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jmovdpk6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FB4358B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c6e2a47f6so58803365e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703080175; x=1703684975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ih34x4InGk88oDWRnsxRncm3q1vebeIOmiotxCM5pDA=;
        b=Jmovdpk6u35xnk5pFqig02SdTqsabQldyKAozeZfP1SMwW76fTMloWYr4btiNL95IY
         gsbJjYy6zMfWDMvrPqvReCmmnlFaYS/ve0R/VNiLqBE2TJNmsH7erP6ccxcQYdocHJpG
         2gVH9bM7Gky1HXpLjEQqDLZYRDujjD5kmvH1jl9PT7uvUoSt+8RIhZwVeLk0oJcdYu+T
         qLWnZlS6Twfy+Ko8ANf2u25+SzqI35ZALZowej9WbcF0FxJyvePtPeG9Wjp1l0N59Mrw
         pcAmORaYdM1s0Gm+Qv9Zjq1DvW3DCynUEgvJQmXHqnY4WEErqdrn+HAkjNb/KkIMH0Fg
         rqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703080175; x=1703684975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih34x4InGk88oDWRnsxRncm3q1vebeIOmiotxCM5pDA=;
        b=OO9VTGseRYPjJk/TQZ7DFEitup+bP4imagbHyHr2toVq0y3hSWAj/Vd9l9BOLHM/bW
         ArxN1BH53jO9ysH3WW7XQ65PxyUyuZbrK+zh8zCOiZG/lgRwLesg00onmMasDtSkZ9vJ
         3sSQ5n0NGGIFdTWDUUtdzVOCB/Vs7OAFaaSCfDOWUvkOoBej8Io1sxDyEUk1efWD9bsM
         apljP3mXLC9ia7ZwoHoP8AW4WdAZnorXi8nw6Al+xkfhksCMI1Xp582hqzC5iMmCIgml
         lO2WU6Ae7sUZ28jrhc7zrXfEg5nx4iZUaNPFlxLAR55NzqlTKpv+87Oz00Z9MqYajQmI
         pC/A==
X-Gm-Message-State: AOJu0YwhdKi/spVsxQSvnbUEmEEOZ/X1ZAHsg9n7xBteWl8Kxbc3dvX9
	QD9maSt1A4EVSpujjCJorWtyKw==
X-Google-Smtp-Source: AGHT+IGwrWFAfuw/3nKJpG6xKX7J59/w3QAQjYWaEjBcrbaLwiCn3ycI1rxvf4Jda5pngeRU/t4DmQ==
X-Received: by 2002:a7b:c4d4:0:b0:40c:32e8:e253 with SMTP id g20-20020a7bc4d4000000b0040c32e8e253mr4751991wmk.363.1703080175004;
        Wed, 20 Dec 2023 05:49:35 -0800 (PST)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d6111000000b0033660f75d08sm10964603wrt.116.2023.12.20.05.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:49:34 -0800 (PST)
Date: Wed, 20 Dec 2023 13:49:30 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v8 0/2] Introducing trace buffer mapping by user-space
Message-ID: <ZYLw6okkDJq9Pi2O@google.com>
References: <20231219184556.1552951-1-vdonnefort@google.com>
 <20231219153924.2ff9c132@gandalf.local.home>
 <ZYLmvmzLOBfrrsSu@google.com>
 <20231220082932.1b391355@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220082932.1b391355@gandalf.local.home>

On Wed, Dec 20, 2023 at 08:29:32AM -0500, Steven Rostedt wrote:
> On Wed, 20 Dec 2023 13:06:06 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > @@ -771,10 +772,20 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> > >  static void rb_wake_up_waiters(struct irq_work *work)
> > >  {
> > >  	struct rb_irq_work *rbwork = container_of(work, struct rb_irq_work, work);
> > > -	struct ring_buffer_per_cpu *cpu_buffer =
> > > -		container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
> > > +	struct ring_buffer_per_cpu *cpu_buffer;
> > > +	struct trace_buffer *buffer;
> > > +	int cpu;
> > >  
> > > -	rb_update_meta_page(cpu_buffer);
> > > +	if (rbwork->is_cpu_buffer) {
> > > +		cpu_buffer = container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
> > > +		rb_update_meta_page(cpu_buffer);
> > > +	} else {
> > > +		buffer = container_of(rbwork, struct trace_buffer, irq_work);
> > > +		for_each_buffer_cpu(buffer, cpu) {
> > > +			cpu_buffer = buffer->buffers[cpu];
> > > +			rb_update_meta_page(cpu_buffer);
> > > +		}
> > > +	}  
> > 
> > Arg, somehow never reproduced the problem :-\. I suppose you need to cat
> > trace/trace_pipe and mmap(trace/cpuX/trace_pipe) at the same time?
> 
> It triggered as soon as I ran "trace-cmd start -e sched_switch"
> 
> In other words, it broke the non mmap case. This function gets called for
> both the buffer and cpu_buffer irq_work entries. You added the
> container_of() to get access to cpu_buffer, when the rbwork could also be
> for the main buffer too. The main buffer has no meta page, and it triggered
> a NULL pointer dereference, as "cpu_buffer->mapped" returned true (because
> it was on something of the buffer structure that wasn't zero), and then here:
> 
> 	if (cpu_buffer->mapped) {
> 		WRITE_ONCE(cpu_buffer->meta_page->reader.read, 0);
> 
> It dereferenced cpu_buffer->meta_page->reader
> 
> which is only God knows what!
> 
> > 
> > Updating the meta-page is only useful if the reader we are waking up is a
> > user-space one, which would only happen with the cpu_buffer version of this
> > function. We could limit the update of the meta_page only to this case?
> 
> I rather not add another irq_work entry. This workaround should be good
> enough.

I meant, to only do in rb_wake_up_waiters()

  if (rbwork->is_cpu_buffer) 
  	rb_update_meta_page(cpu_buffer)

And skip the meta-page update for the !is_cpu_buffer case?

> 
> Thanks,
> 
> -- Steve

