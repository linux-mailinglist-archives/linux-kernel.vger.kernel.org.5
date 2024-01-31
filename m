Return-Path: <linux-kernel+bounces-47014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E59B8447F3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707BC1C24AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA7D3A1A5;
	Wed, 31 Jan 2024 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="f5ZG4o+n"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA5381D6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706729102; cv=none; b=GkhPg1vQ16crqwKNCwYDvKgqi3ZyEV4cQnBNEAUJnn+iwt1uVjCXDn7RlkCAO7C/dBpCYb7V1dIvcUrj3XauHK2MB5EOdNusekx5H8e7BUG5L9O1KMOK+4mjPMbQLcjM08lNAmW5I5ShOu4+Cad1HrtB8BGTcLXLLtoxFELx2zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706729102; c=relaxed/simple;
	bh=fgjO+ZKPSjohHXcq26Lv87wcORUzsg9ZFuQOiM8cecY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwXYxPcJQk3bQkX6UBK9APIuFW5isNZLhRPnn1MA0pF4oB5ZaWnaRfopHPlGaou1bKbPVeMLqupmLNC2m07f6xaoWgitr2srLoLw8TFq4xchjsBhph0+tiFfvyGWXwhnPo37yiifYeFbYm9/4muD6q3yClKJQuDzNDKzWDOPJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=f5ZG4o+n; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d5c25267deso72431241.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1706729099; x=1707333899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4I3eBOyzNlkmUL9oB23DTt0cGT4r7iaUTvk9/UqUMsU=;
        b=f5ZG4o+nTiQvQFxgHUSyV2KA4wEtFGxmsKM4W4P09gBZokXcyIPj27HFlEdudUQrm+
         4zjBF1K8HvEVHbZjakxvToGEGoqfy57dUktuqSfFgS+bXJ1Hyq5WzmzsR3f+d3er7+9X
         SitKPcYm2Np85wmqYOm7lkJQUw7dt3KRZleNciINvaUGO8EeGnbetjagy+mqJyJ27U3k
         QgRvbAxAhYFElOQ5QEviIq6hMag+p6TUHbEgGmwqIh/QXbPuvZo8h7tGjkn4VtMoqVdb
         /El+Tfo474mAxa7iL6ybX6lOBOTKRk7nnZ6yGv3S+F7DwzLMi7duXUdbIy3m+6InxuZi
         BRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706729099; x=1707333899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4I3eBOyzNlkmUL9oB23DTt0cGT4r7iaUTvk9/UqUMsU=;
        b=NnrpWJn2QHasD5u/1kOdmPD+K/wnlBvlWIC+iSrSHPtCBmSbZEHRNXI1CAQqLYzEl6
         G4rT4EQhVH5EZCwG1Wray6sPCZwkERJHxUx5+x+ZUDswMjnhr97BIyc3cdH7v82ebK11
         k7w4Kq4L9qW/RMMGNA0oOp0EGr7gKBaC/DOoAfTAUv/krYugKmQyKBAlGLGu6OnG+klx
         4T3JJhYRvFk4IqOs1yUc1CKlfEHiH1ykR16gFAPm+ocZF6Qx3HmAJK9uA+VcPwyousbT
         8a/D5doFWcE/eZJuPgGqwQa+mbBunrxk0Xl3cgXbt0+YdV8YsHnf/KoGuTfPzUwnZDYw
         pv7g==
X-Gm-Message-State: AOJu0YyfAKpiRsCFXAIkRxAHC0u7L5NuSihQ/9DAuewKgJ8wppTvxVZE
	iRoLp0TQovk9Xc/rU4gsaAmeUY9bI+aUU9p5Q38YN8aEzjaIqqnbwcPnJc4OSLqAeJCr7XAxYbF
	2UULhUVf+551ZwPuI2xs1B2BqmhSEkwPSFofTjyaGPX2uRRuwlmg7
X-Google-Smtp-Source: AGHT+IEVhi6ebAkmJ9Cn1RS6VHS6zer5DzSjHlqlbl4RLPCAcXnZnGdP0Y3tq8suiuJKnGPDAf5yLU0Epv/bzhB21ig=
X-Received: by 2002:a05:6122:3981:b0:4b6:d4a0:5841 with SMTP id
 eq1-20020a056122398100b004b6d4a05841mr2760413vkb.6.1706729099713; Wed, 31 Jan
 2024 11:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127105410.GA13787@redhat.com> <ZbUngjQMg+YUBAME@tycho.pizza>
 <20240127163117.GB13787@redhat.com> <ZbU7d0dpTY08JgIl@tycho.pizza>
 <20240127193127.GC13787@redhat.com> <ZbVrRgIvudX242ZU@tycho.pizza>
 <20240127210634.GE13787@redhat.com> <20240129112313.GA11635@redhat.com>
 <CALCETrUFDkt+K9zG8mczxzAFy9t-6Mx5Cz-Sx+it6a4nt+O0pg@mail.gmail.com>
 <20240131184829.GE2609@redhat.com> <20240131191405.GF2609@redhat.com>
In-Reply-To: <20240131191405.GF2609@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 31 Jan 2024 11:24:48 -0800
Message-ID: <CALCETrXTHsyiR6Bav7bXCCHny0Z2Bn90fTUL9__KTftESQ9=7w@mail.gmail.com>
Subject: Re: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On 01/31, Oleg Nesterov wrote:
> >
> > On 01/31, Andy Lutomirski wrote:
> > Please note
> >
> >       /* TODO: respect PIDFD_THREAD */
> >
> > this patch adds into pidfd_send_signal().
> >
> > See also this part of discussion
> >
> >       > > +   /* TODO: respect PIDFD_THREAD */
> >       >
> >       > So I've been thinking about this at the end of last week. Do we=
 need to
> >       > give userspace a way to send a thread-group wide signal even wh=
en a
> >       > PIDFD_THREAD pidfd is passed? Or should we just not worry about=
 this
> >       > right now and wait until someone needs this?
> >
> >       I don't know. I am fine either way, but I think this needs a sepa=
rate
> >       patch and another discussion in any case. Anyway should be trivia=
l,
> >       pidfd_send_signal() has the "flags" argument.
> >
> > with Christian in https://lore.kernel.org/all/20240130112126.GA26108@re=
dhat.com/

I missed that.  Whoops.

On Wed, Jan 31, 2024 at 11:15=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> Forgot to mention...
>
> And I agree that pidfd_send_signal(flags =3D> PGID/SID) can make
> some sense too.
>
> But this a) doesn't depend on PIDFD_THREAD, and b) needs another
> patch/discussion.
>
> But again, I am not sure I understood you correctly.
>

Hmm.

When one works with regular (non-fd) pids / pgids etc, one specifies
the signal domain at the time that one sends the signal.  I don't know
what pidfds should do.  It seems a bit inefficient for anything that
wants a pidfd and might send a signal in a different mode in the
future to have to hold on to multiple pidfds, so it probably should be
a pidfd_send_signal flag.

Which leaves the question of what the default should be.  Should
pidfd_send_signal with flags =3D 0 on a PIDFD_THREAD signal the process
or the thread?  I guess there are two reasonable solutions:

1. flags =3D 0 always means process.  And maybe there's a special flag
to send a signal that matches the pidfd type, or maybe not.

2. flags =3D 0 does what the pidfd seems to imply, and a new
PIDFD_SIGNAL_PID flag overrides it to signal the whole PID even if the
pidfd is PIDFD_THREAD.

Do any of you have actual use cases in mind where one choice is
clearly better than the other choice?

--Andy

