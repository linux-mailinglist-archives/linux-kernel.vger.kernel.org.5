Return-Path: <linux-kernel+bounces-39336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A91A83CEE8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBAA2817E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C609213AA29;
	Thu, 25 Jan 2024 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="TpK/Xp7b"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0811CA89;
	Thu, 25 Jan 2024 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219514; cv=none; b=dPC5P19L8QCeE/qjiyJ9NXn2ZKgPOkzV6ghkAmB4m79O7PH0h6SStwQIvtdgE5nHUulU/J2OEBk3OARSiYtbODv4mkLMtuRnv3vcp3xorihQtSXh/U+FKmqrs2NQYdYYUb6KQDYszN8S5lMAiv+iyAlKao+Fi882xz8O3Bq1a7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219514; c=relaxed/simple;
	bh=YccAIs5+eKoIM8aZbL704pzmyaTaxluVYunl5Ycvuuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyBx+NOY5vm5+8h3xjU3q34Ohg/gHrSGlg9zwoEOdZitTQPK1YfJwMAztVSjoCeXs5dWPVqBUcSiAlu5D+qyOyZTkPtNjqJr30KENHRZF1i3DeUK+8DUTwExw3O111JFykR+0EO8UtVPNrMlkmnviHaWcS5G5AaJuJ1S0FfIlqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=TpK/Xp7b reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d75c97ea6aso9214705ad.1;
        Thu, 25 Jan 2024 13:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706219511; x=1706824311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x7YugiGqyACgZ8BoOpvuyIqSm8sxgRt91vAvWw1Pxvo=;
        b=E5hWp8WFfnrRjxspX1ckbQ7CsrqfN0t6/5c2+yClIc1nM2WsZpPyqjd7Y403zSoSbr
         N/IFM33cvDn7cQhBAyzAjwKM7HXd45R1pBRnJ9tgHwLuvUupylAUQOl/xTKhir8TkcgV
         2CYgopDA5NB5FA0RDMZYVofPT0TJiBuqW/G4ZgCFcc6iKIdRdli0oLt+PDiEceBJyZrz
         bvRnJqsROBT33zpwFv+SEPzUXMGZQ14r3bEZzgjGArOWWtKGbI2u4dnFPRb7X7wI4aou
         u91qpOUOm1WXcyYBvpEupTcZh3T/5ddSKN2ySxjJvEgXCuRERd34qELRKxlOGfk9fAwv
         dqcw==
X-Gm-Message-State: AOJu0YycXp52kwdFDbbcZ2xymAZ3ALIsErHlv3eHprp4FAUmRPAbhGyH
	eekrRYjDQQ/Anhiwcd775Esr7oDbdJeGavA89tNfucNnnNJRUsYtwHLf3hOpDTOQrQ==
X-Google-Smtp-Source: AGHT+IEO4Ca7IIS8HyRsZLqQaRomzbzWA6oYNT7lpBgQtnq5A614O4JmmXGSLHy5+jyxw06bENQtXQ==
X-Received: by 2002:a17:902:be13:b0:1d7:7adf:85d3 with SMTP id r19-20020a170902be1300b001d77adf85d3mr261093pls.29.1706219511547;
        Thu, 25 Jan 2024 13:51:51 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001d71b72770asm10754554plh.158.2024.01.25.13.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 13:51:50 -0800 (PST)
Date: Thu, 25 Jan 2024 18:52:07 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706219509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x7YugiGqyACgZ8BoOpvuyIqSm8sxgRt91vAvWw1Pxvo=;
	b=TpK/Xp7bKfvfk7v6yRF+V8ulhhYIEchzKwiSK7CvPyaeQ6r5zeiPu3pKpyUQkeGUtyL1Ky
	+8/CXTCbIuIjxLcsY4olfFtiKU7gZQ/DIOFK++7K6KRl5IhciedYJ4/CTHG1ZYM88uCG5P
	Pbn6bQsCHteGQ1tJAywzsVyyF8RTMDKk0EPx/EKj40FWIZSQLzFP3/0Sp2Yl3t3WbiTe07
	sfQje9216tF4IWs8B6OfNYtpCHPMKzSJ4sIovt6Kw6m8QlLK7He8D32F5oPP5TRJq/ox8v
	WnD3EKlFnBQ2xE1PrI+3AtBChgtIxVCd33Jit9h03k2hGKv7ZloI2HsnYdVcZQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2 2/3] tracing: initialize trace_seq buffers
Message-ID: <6neth2iwpcmemb7rvkkagp7mvpoan3nbsr24ohb4ftk3kwtir7@tnebxelahg77>
References: <20240125201621.143968-1-ricardo@marliere.net>
 <20240125201621.143968-4-ricardo@marliere.net>
 <20240125154432.4ba9e997@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125154432.4ba9e997@gandalf.local.home>

Hi Steve,

On 25 Jan 15:44, Steven Rostedt wrote:
> On Thu, 25 Jan 2024 17:16:21 -0300
> "Ricardo B. Marliere" <ricardo@marliere.net> wrote:
> 
> > Now that trace_seq_reset have been created, correct the places where the
> > buffers need to be initialized.
> 
> This patch would need to come first. You don't ever want to intentionally
> create a broken kernel.

Indeed, sorry for the lack of attention.

> 
> Also, the change log should be:
> 
>   In order to extend trace_seq into being dynamic, the struct trace_seq
>   will no longer be valid if simply set to zero. Call trace_seq_init() for
>   all trace_seq when they are first created.

Ack.

> 
> > 
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  kernel/trace/trace.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> 
> You also need to initialize iter.seq in ftrace_dump()

Thanks a lot for reviewing, I will send a v3.
-	Ricardo


> 
> -- Steve
> 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index d4c55d3e21c2..9827700d0164 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -4889,6 +4889,9 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
> >  
> >  	mutex_unlock(&trace_types_lock);
> >  
> > +	trace_seq_init(&iter->seq);
> > +	trace_seq_init(&iter->tmp_seq);
> > +
> >  	return iter;
> >  
> >   fail:
> > @@ -6770,6 +6773,7 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
> >  	}
> >  
> >  	trace_seq_init(&iter->seq);
> > +	trace_seq_init(&iter->tmp_seq);
> >  	iter->trace = tr->current_trace;
> >  
> >  	if (!alloc_cpumask_var(&iter->started, GFP_KERNEL)) {
> > @@ -6947,6 +6951,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
> >  	trace_iterator_reset(iter);
> >  	cpumask_clear(iter->started);
> >  	trace_seq_init(&iter->seq);
> > +	trace_seq_init(&iter->tmp_seq);
> >  
> >  	trace_event_read_lock();
> >  	trace_access_lock(iter->cpu_file);
> > @@ -8277,6 +8282,9 @@ static int tracing_buffers_open(struct inode *inode, struct file *filp)
> >  	if (ret < 0)
> >  		trace_array_put(tr);
> >  
> > +	trace_seq_init(&info->iter.seq);
> > +	trace_seq_init(&info->iter.tmp_seq);
> > +
> >  	return ret;
> >  }
> >  
> > @@ -10300,6 +10308,9 @@ void trace_init_global_iter(struct trace_iterator *iter)
> >  	iter->temp_size = STATIC_TEMP_BUF_SIZE;
> >  	iter->fmt = static_fmt_buf;
> >  	iter->fmt_size = STATIC_FMT_BUF_SIZE;
> > +
> > +	trace_seq_init(&iter->seq);
> > +	trace_seq_init(&iter->tmp_seq);
> >  }
> >  
> >  void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
> > @@ -10712,6 +10723,9 @@ void __init early_trace_init(void)
> >  			tracepoint_printk = 0;
> >  		else
> >  			static_key_enable(&tracepoint_printk_key.key);
> > +
> > +		trace_seq_init(&tracepoint_print_iter->seq);
> > +		trace_seq_init(&tracepoint_print_iter->tmp_seq);
> >  	}
> >  	tracer_alloc_buffers();
> >  
> 

