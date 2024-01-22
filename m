Return-Path: <linux-kernel+bounces-34258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759D283767A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9031F27749
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BA41096F;
	Mon, 22 Jan 2024 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="GgXPwlO4"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F1E12B67;
	Mon, 22 Jan 2024 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963533; cv=none; b=okSOtOVaXGdNLHHuPPl2Nvqgvu0Hxr07Kk5pTwfWFXwALHOgR5nWOktieNz8o5Dpjlc76t90ZQjEiG4c3U4VlATosDHD0a0tsOZ02cMsCI5lNFxvOD91YCPeYI6nAoPh0piN+NI9POgWwXlgS+IJaBSVqtXI1OjTjUAtnHpwLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963533; c=relaxed/simple;
	bh=uVKmz9h/OPVcRNny8QAWUaBL2y/njiC5qx3NeyWv/hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsljMcsSLV4ZWNRnwdtLA1wxuk+8LmQ9NZay+ib6GVNqZn9ugD7yjuB41zQ+aOONSSxMwmfyKQGrRigkEennqlZtr+xE8UjDClLLjjjjw48jEvoiZNIvOpAe3Hqmezc9OmFBt43W5uZs6fQEw6rw6lbNmj1oBzNvbXC0F/wXdjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=GgXPwlO4 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2900c648b8bso2802268a91.3;
        Mon, 22 Jan 2024 14:45:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705963530; x=1706568330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IdeTCtlgIdzqbjh7TFsUI2fXXgYxT/7DC3A4SQ8BVbM=;
        b=JK63zDZHIzk3g8/v+QnhwY+LmwGEU7uza+ZMnOXewiODMgDmcGEszGN/YsqngUdDFj
         7gXgtF1B2He3D0javpKTezooG4/ahZghVduDnDgLScQt4ZPkMn16za0aqHK2I+CJF1sB
         +4VMFUXQzfU1LYflw3L3w+VQdMB50s1ZDPzz0oYDTx9coieHGNNLIrwj8FpMQi87zpvh
         Nh5Stl/O2BweL9LrEqhOsbhW31tzX0w+To5CS1JnHFJFsoxOn2rVW+Q5GQqlm2ePuNJK
         Q5855yQo9uTzTLzCxAlFgzf+gTdtjRHTrXwvckPkIQNd8gPYWHhOSx2ZwAyKnP+lPsIr
         +7dA==
X-Gm-Message-State: AOJu0Ywp/NZx10fh/Z/EcyckOx6WK+qGvpu3j7xfEaTmzZLGH9icgHj0
	2x9MLfXxFqY0z/f1k9Ow3xGNX+K+xwyqqhXW12lLZ+LjxXbXAnae
X-Google-Smtp-Source: AGHT+IEfqq9qzTssBN9tV93v5yCTSsodA2mcqtD3ZhEqT+vqodLoyFBbFc+loQ8v719r1iMLvQVjKA==
X-Received: by 2002:a17:90b:8b:b0:28d:bab1:e94a with SMTP id bb11-20020a17090b008b00b0028dbab1e94amr2377364pjb.32.1705963530058;
        Mon, 22 Jan 2024 14:45:30 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ph16-20020a17090b3bd000b0028e87ce1de0sm10097592pjb.51.2024.01.22.14.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 14:45:29 -0800 (PST)
Date: Mon, 22 Jan 2024 19:45:41 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1705963527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdeTCtlgIdzqbjh7TFsUI2fXXgYxT/7DC3A4SQ8BVbM=;
	b=GgXPwlO4c6bw0ksA2pbJPDAfBCo000O6q6nnoY7AmIZkxDBTuCxrdRM+wmsUL4m/YfZnlF
	MaKrQemZtIQ8LA7WjArnqh670qH8W87oBHjvu2tErP3kUNS9oedWmQj2MctTp03xaTfY49
	C9A1jguy91pWkLaAumUZgZ1I9sR4RI5sMfU5J75NyCxj8Jhafun1ZkGxyRsN6Af8MNIpiW
	LwrCECMejLEkHTl05zaqVOI3s6xr6mBjAn4By0B17w3IdGrqFKkyJRnJPUIJWxpPzrWCL5
	hnkldIxyopPYihABRiIHBudTNygECmYCsxthNKHpVMv8oZ5pFQjkYeBnnQvttA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: add trace_seq_reset function
Message-ID: <ny2sl7ke3mktdimdcfikmwel57fuoudezq6k6yamwqqitt6jqz@vpxgz473xrva>
References: <20240122182225.69061-2-ricardo@marliere.net>
 <20240122171024.4a434c73@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122171024.4a434c73@gandalf.local.home>

On 22 Jan 17:10, Steven Rostedt wrote:
> On Mon, 22 Jan 2024 15:22:25 -0300
> "Ricardo B. Marliere" <ricardo@marliere.net> wrote:
> 
> > Currently, trace_seq_init may be called many times with the intent of
> > resetting the buffer. Add a function trace_seq_reset that does that and
> > replace the relevant occurrences to use it instead.
> > 
> 
> Hi Ricardo!
> 
> It's also OK to add to the commit log that the goal of this is to later
> extend trace_seq to be more flexible in the size of the buffer it holds. To
> do that, we need to differentiate between initializing a trace_seq and just
> resetting it.
> 

Hi, Steve

Certainly. I also forgot to add your Suggested-by.

> 
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  include/linux/trace_seq.h    | 8 ++++++++
> >  include/trace/trace_events.h | 2 +-
> >  kernel/trace/trace.c         | 8 ++++----
> >  kernel/trace/trace_seq.c     | 2 +-
> >  4 files changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
> > index 9ec229dfddaa..c28e0ccb50bd 100644
> > --- a/include/linux/trace_seq.h
> > +++ b/include/linux/trace_seq.h
> > @@ -29,6 +29,14 @@ trace_seq_init(struct trace_seq *s)
> >  	s->readpos = 0;
> >  }
> >  
> > +static inline void
> > +trace_seq_reset(struct trace_seq *s)
> > +{
> > +	seq_buf_clear(&s->seq);
> > +	s->full = 0;
> > +	s->readpos = 0;
> > +}
> > +
> >  /**
> >   * trace_seq_used - amount of actual data written to buffer
> >   * @s: trace sequence descriptor
> > diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> > index c2f9cabf154d..2bc79998e5ab 100644
> > --- a/include/trace/trace_events.h
> > +++ b/include/trace/trace_events.h
> > @@ -227,7 +227,7 @@ trace_raw_output_##call(struct trace_iterator *iter, int flags,		\
> >  									\
> >  	field = (typeof(field))entry;					\
> >  									\
> > -	trace_seq_init(p);						\
> > +	trace_seq_reset(p);						\
> >  	return trace_output_call(iter, #call, print);			\
> 
> Note, p = &iter->tmp_seq
> 
> where it has never been initialized. To do this, we need to add:
> 
> 	trace_seq_init(&iter->tmp_seq);
> 
> where ever iter is created. You need to look at all the locations where
> iter is created ("iter =") and differentiate where it is first used from
> just passing pointers around.
> 
> The iter = kzalloc() will be easy, but for example, both seq and tmp_seq
> need to be initialized in tracing_buffers_open().

That makes sense, I will work on a v2.

> 
> Perhaps we need a:
> 
> 	if (WARN_ON_ONCE(!s->seq.size))
> 		seq_buf_init(&s->seq, s->buffer, TRACE_SEQ_BUFFER_SIZE);
> 	else
> 		seq_buf_clear(&s->seq);
> 
> 
> in the trace_seq_reset() to catch any place that doesn't have it
> initialized yet.

But that would be temporary, right? Kind of a "trace_seq_init_or_reset".
If that's the case it would be best to simply work out all the places
instead. Would the current tests [1] cover everything or should
something else be made to make sure no place was missing from the patch?

Thanks for reviewing!
-	Ricardo

--
[1] https://github.com/rostedt/ftrace-ktests

