Return-Path: <linux-kernel+bounces-102119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD6987AE93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146C4B2332D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848936A8C7;
	Wed, 13 Mar 2024 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePODYBR4"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583096027C;
	Wed, 13 Mar 2024 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349274; cv=none; b=H3R4Ye6kMXauyovk2159Z7l6gT6lnLURjfD73yR5BByLE4SaZw/TtasqLCeH81qx0H4nysVThoh0wnIAhegmolx9Hdev7Sja7bGAa4CgIfMgXY/VEiXA4kcZaCmh5yyYHjbnQ+sqOZMalnm1BbymQiUD4+I/K0TVjqHyXnBq4lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349274; c=relaxed/simple;
	bh=efq0+BVv6lDBikO5pTNyUvpb54N7jU6nicAO6peFQkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKMKv+WsSn7Q8ZhQfeg6mXaikcePuGXaS33CtyaBXH84dLpuiCCGVVCxLyzRP79r3jtaMboF7OXNuu3KYgorygyqbAMaq90vGIpaHoBd7tsj3L62BhNoQIDyw+e2WbP7P7i4QvYggrsFJsx//tu9cbZjgNihw6LhHp2kp4Zun4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePODYBR4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29bd0669781so96367a91.1;
        Wed, 13 Mar 2024 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710349272; x=1710954072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/uM9hQvAYtcrq7dslWiWMyu+XMvN5FG8fC6yazcC8Y=;
        b=ePODYBR4dpGGhn0cQmrgSWDpCy6E2Yki07/FdQiHD5+0IpYmxoq4X+JUWdd3neUw86
         F+LXGWo7ofdDIVUp9X4XIkIf6hhVtR6w7T8o9WJwaxMPaOXrRHfuPtUQrdGLVN6G1GI9
         AGCSZyLGvGKsgjvwOSh2KKyC3YgiiCZKPHyAAEP2v2wBwJh+hjHshcXdpDcsnYDZNi88
         xIZxXFZs9c4X6yj00NkUcyBV6DQm6FOws8DoYa8/0EIXGytFfYOBYz4G5iGRYY/koTna
         KbOZa7JyLBBZBtr4Wz8hIXadDjpDN7OgLQ/8KcnsbUAX/kcXVxmBnECVhiPsjVWmg4Un
         Kh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710349272; x=1710954072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/uM9hQvAYtcrq7dslWiWMyu+XMvN5FG8fC6yazcC8Y=;
        b=kJIgIZpHQmXp70o7l7eLgfVLJQTTAPZxWzz/cgj0fcW5dQ502Fjcq3Qd8KHpGSHxp1
         yXyDzj1KFOXqWuMItw02tog+pFYOA1Ei1Y3sImuXlKDNzX9HSpW6V/QPd9MWUtKxQe18
         kD6LzGQsN4LKPpYbiO9FwCnv9qPOEOl2nnRbi6oLv7bMpVbv53sTew/h48tuTJ1kcKLZ
         ycKI5FkpQCAg95rZhmRpvH02WcmZakfzDrfjLlRstK1kV/2MZvvWGjpTKmlFabP2X5rN
         c6fQ0LkEZF/U/h5zIA0IHFcDXxx7J+h0YW+GExQQnQmdOvDaAirVj8jDlLIYe8SHzSST
         WQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3NY27fqhmhX02cIGqAR/NHQGm6I9ktdglUaYCHzDIXGypEav7zGo1ZMoUmA6BkE1hHHZOE40YWn/H9phk11U5X9S7gUb73K9zPlJUUlrRtt9H7RXXdxQ3Atu8GMNscoMxFnRHXSl6TKc+IPOfhKQVgFWbxgxiDwMLR7zoBuS77Yo39j5Q
X-Gm-Message-State: AOJu0Yxy8C9wS9SfFVSQAli8Yuxtk5xI85Rsx5k8OBWpCXbv5UFNDUWV
	dhu7fpA/Ps1LBbI1Og8LROkok/4KhbXjVdmg8R0BZWW3L65q0ljWabj3pi9xBwFuGlsJZSZdqrT
	uCAwIvNySNyclxVDcZbsnEVY+xiwcPVz9
X-Google-Smtp-Source: AGHT+IHTE6X0LVH8ASvCKFEnF3zyk8i8X6E9Ba9T01S0m34UIrBolvIzYwfy2ssQWZdyAP2EhQNGTz/ngOSICO2Z68E=
X-Received: by 2002:a17:90b:815:b0:29b:ed0d:60fa with SMTP id
 bk21-20020a17090b081500b0029bed0d60famr8682057pjb.19.1710349272412; Wed, 13
 Mar 2024 10:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312210233.1941599-1-andrii@kernel.org> <20240312210233.1941599-4-andrii@kernel.org>
 <20240313131926.GA19986@redhat.com>
In-Reply-To: <20240313131926.GA19986@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Mar 2024 10:01:00 -0700
Message-ID: <CAEf4BzbiDi8UOryvP_OHwbfF5VEBtGNzTnFRwuJ8PN+rBRxi+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] uprobes: add speculative lockless
 system-wide uprobe filter check
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 6:20=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> I forgot everything about this code, plus it has changed a lot since
> I looked at it many years ago, but ...
>
> I think this change is fine but the changelog looks a bit confusing
> (overcomplicated) to me.

It's a new piece of code and logic, so I tried to do my due diligence
and argue why I think it's fine. I'll drop the overcomplicated
explanation, as I agree with you that it's inherently racy even
without my changes (and use-after-free safety is provided with
uprobe->register_rwsem independent from all this).

>
> On 03/12, Andrii Nakryiko wrote:
> >
> > This patch adds a speculative check before grabbing that rwlock. If
> > nr_systemwide is non-zero, lock is skipped and event is passed through.
> > From examining existing logic it looks correct and safe to do. If
> > nr_systemwide is being modified under rwlock in parallel, we have to
> > consider basically just one important race condition: the case when
> > nr_systemwide is dropped from one to zero (from
> > trace_uprobe_filter_remove()) under filter->rwlock, but
> > uprobe_perf_filter() raced and saw it as >0.
>
> Unless I am totally confused, there is nothing new. Even without
> this change trace_uprobe_filter_remove() can clear nr_systemwide
> right after uprobe_perf_filter() drops filter->rwlock.
>
> And of course, trace_uprobe_filter_add() can change nr_systemwide
> from 0 to 1. In this case uprobe_perf_func() can "wrongly" return
> UPROBE_HANDLER_REMOVE but we can't avoid this and afaics this is
> fine even if handler_chain() does unapply_uprobe(), uprobe_perf_open()
> will do uprobe_apply() after that, we can rely on ->register_rwsem.
>

yep, agreed

> > In case we speculatively read nr_systemwide as zero, while it was
> > incremented in parallel, we'll proceed to grabbing filter->rwlock and
> > re-doing the check, this time in lock-protected and non-racy way.
>
> See above...
>
>
> So I think uprobe_perf_filter() needs filter->rwlock only to iterate
> the list, it can check nr_systemwide lockless and this means that you
> can also remove the same check in __uprobe_perf_filter(), other callers
> trace_uprobe_filter_add/remove check it themselves.
>

makes sense, will do

>
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -1351,6 +1351,10 @@ static bool uprobe_perf_filter(struct uprobe_con=
sumer *uc,
> >       tu =3D container_of(uc, struct trace_uprobe, consumer);
> >       filter =3D tu->tp.event->filter;
> >
> > +     /* speculative check */
> > +     if (READ_ONCE(filter->nr_systemwide))
> > +             return true;
> > +
> >       read_lock(&filter->rwlock);
> >       ret =3D __uprobe_perf_filter(filter, mm);
> >       read_unlock(&filter->rwlock);
>
> ACK,
>
> but see above. I think the changelog should be simplified and the
> filter->nr_systemwide check in __uprobe_perf_filter() should be
> removed. But I won't insist and perhaps I missed something...
>

I think you are right, I'll move the check

> Oleg.
>

