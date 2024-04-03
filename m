Return-Path: <linux-kernel+bounces-130234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A5F8975CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8D4B2152D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076BB1534F3;
	Wed,  3 Apr 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4IGjT8J"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB96152E10;
	Wed,  3 Apr 2024 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163507; cv=none; b=Ip0qiXKi5hdk61kXG4QvNlBPDMcpKDStM2cOoW72lfvGvWrTRRGtwU3ORZMFgnivNyo+00baY2kdBZTJxvGRbsmHebrYj+qYl327xko1g6iIWaexlc4UG6WRv/B0YiQEt0TALkHnJzLXmJxrlPju1oUYmZI2Kw9F1s0GHeu63Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163507; c=relaxed/simple;
	bh=KLz6OqbRCAgFQiXEjJMZjUoHqrDuXWhfnhfFCT+kHZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHR1k3pG+MtKFgFPg+6fGghrSrNSqdd4zcUA4Ukuuk2uaq31UzqE+zQQ47HGPmHzjSrh1Rs2ZrIQuKNFMyH9OEuNExMin9h/ZtcF7UBdf2Sh2+UOVXrUVn1oMiFr4uPnSDXpxU2q2z+Q9HfpZ8/R93GzXc5kmJfKzfN+3ZS/+eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4IGjT8J; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6eaf1005fcaso3251100b3a.3;
        Wed, 03 Apr 2024 09:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712163505; x=1712768305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yguKOLxlKrQU5jjIYUXqoMHR/GugHTZ27gnX6ZVvXgU=;
        b=f4IGjT8JFFIoDnjvFDSqFIwgZ6+J8MfChnPyGfQBiK/W+8erhT0j/a/arNS7wSWK2i
         zPELPGv8dVhXjRkJBuLYuJ0lRl5BjvXUAQw10/TNrsLV2wsOx2gNGviBzpghTjczmCKk
         6xd6lBNtbRz58aWetYMEb5bnYwrFossNInDP5q9m0N79E+7xpOR9NHMrAANEciHcDJMN
         5JJxeD8YanpXP/mCzksHl44pGJnQNya2Q1sAxfVETmqlTiHxowDA0AM2yEP1rac5XjQ6
         0ZziYG0icCCv1PSq6EvRr7rJCgF9ZLUMs3O7z2mDokX0+5Tv60kY/fxw0ENXXXSk0Jn8
         kCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712163505; x=1712768305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yguKOLxlKrQU5jjIYUXqoMHR/GugHTZ27gnX6ZVvXgU=;
        b=U5NPHVITrL3vbWUx5YVVTz/Ie9D1UDo6jst/M93azhXP7bJh8UOw1ygPukloMCbZIk
         LFFHwOG6SZI2mTya/UB4jbExfAVjZeeRH/3QWSHVk2GJWVDuezTT+5c5r1fFCQouHGOC
         NVX7jLGLp+szHgt1o2fABzEBmpxn7EqrnTjFJ4x5RyVaESARL9SDYrAduFZ56SfBVTBp
         2JCWhiszupyHR1RE+PgYShbge+X19w7t7j8t8ABml0GNZ5yFWzLQZZzyssHddmBpN929
         +6QhGXQ79jW38WJ9mHSSZEp58aDwvhvRI1InyVKG7/zw0uRN6B9XDWBHtFP3CoVCrEFH
         Pynw==
X-Forwarded-Encrypted: i=1; AJvYcCW1bVucnFRJXEOLJNDtDmR5ejp8t143yJRM7xbglVbEHZhixrVgFNJS1DCfs5KN1I5oTelztm+ygUbh2vBZ6SAMBMBiAGDfayQoqxtrycFduVaQJeWBJX9/yI5f4iKvMccBfYsVZ5Igjs1Bza8pn06Fh2+LHG3u8sjEV0WoSvI0f4Y5klca
X-Gm-Message-State: AOJu0YyhYIL/L45tMlnhuYxkZorndkboITW5JUc9eM9s80WlYnNOktoH
	kf6DC9z+7Zuy48er69S7UUudZLKkFlsMmwPd95anFrsLYjt8SyhCSf60qYungbHmbtdaydu4lOa
	JsQTWESYvJ3vTmhYOhkwb/pn5NF8=
X-Google-Smtp-Source: AGHT+IGFlyvJRg6iSqPB84C6RD0yv5Pbdcf4qO65BoYxM7MP9xDxCLU/f67zCSS80H2+8nBmbQfVuqvAZp40VqGL8G0=
X-Received: by 2002:a05:6a20:1019:b0:1a7:2437:386f with SMTP id
 gs25-20020a056a20101900b001a72437386fmr225228pzc.61.1712163504911; Wed, 03
 Apr 2024 09:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402093302.2416467-1-jolsa@kernel.org> <20240402093302.2416467-2-jolsa@kernel.org>
 <20240403100708.233575a8ac2a5bac2192d180@kernel.org> <Zg0lvUIB4WdRUGw_@krava> <20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
In-Reply-To: <20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 09:58:12 -0700
Message-ID: <CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return probe
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 7:09=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Wed, 3 Apr 2024 11:47:41 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
>
> > On Wed, Apr 03, 2024 at 10:07:08AM +0900, Masami Hiramatsu wrote:
> > > Hi Jiri,
> > >
> > > On Tue,  2 Apr 2024 11:33:00 +0200
> > > Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > > Adding uretprobe syscall instead of trap to speed up return probe.
> > >
> > > This is interesting approach. But I doubt we need to add additional
> > > syscall just for this purpose. Can't we use another syscall or ioctl?
> >
> > so the plan is to optimize entry uprobe in a similar way and given
> > the syscall is not a scarce resource I wanted to add another syscall
> > for that one as well
> >
> > tbh I'm not sure sure which syscall or ioctl to reuse for this, it's
> > possible to do that, the trampoline will just have to save one or
> > more additional registers, but adding new syscall seems cleaner to me
>
> Hmm, I think a similar syscall is ptrace? prctl may also be a candidate.

I think both ptrace and prctl are for completely different use cases
and it would be an abuse of existing API to reuse them for uretprobe
tracing. Also, keep in mind, that any extra argument that has to be
passed into this syscall means that we need to complicate and slow
generated assembly code that is injected into user process (to
save/restore registers) and also kernel-side (again, to deal with all
the extra registers that would be stored/restored on stack).

Given syscalls are not some kind of scarce resources, what's the
downside to have a dedicated and simple syscall?

>
> >
> > >
> > > Also, we should run syzkaller on this syscall. And if uretprobe is
> >
> > right, I'll check on syzkaller
> >
> > > set in the user function, what happen if the user function directly
> > > calls this syscall? (maybe it consumes shadow stack?)
> >
> > the process should receive SIGILL if there's no pending uretprobe for
> > the current task, or it will trigger uretprobe if there's one pending
>
> No, that is too aggressive and not safe. Since the syscall is exposed to
> user program, it should return appropriate error code instead of SIGILL.
>

This is the way it is today with uretprobes even through interrupt.
E.g., it could happen that user process is using fibers and is
replacing stack pointer without kernel realizing this, which will
trigger some defensive checks in uretprobe handling code and kernel
will send SIGILL because it can't support such cases. This is
happening today already, and it works fine in practice (except for
applications that manually change stack pointer, too bad, you can't
trace them with uretprobes, unfortunately).

So I think it's absolutely adequate to have this behavior if the user
process is *intentionally* abusing this API.

> >
> > but we could limit the syscall to be executed just from the trampoline,
> > that should prevent all the user space use cases, I'll do that in next
> > version and add more tests for that
>
> Why not limit? :) The uprobe_handle_trampoline() expects it is called
> only from the trampoline, so it is natural to check the caller address.
> (and uprobe should know where is the trampoline)
>
> Since the syscall is always exposed to the user program, it should
> - Do nothing and return an error unless it is properly called.
> - check the prerequisites for operation strictly.
> I concern that new system calls introduce vulnerabilities.
>

As Oleg and Jiri mentioned, this syscall can't harm kernel or other
processes, only the process that is abusing the API. So any extra
checks that would slow down this approach is an unnecessary overhead
and complication that will never be useful in practice.

Also note that sys_uretprobe is a kind of internal and unstable API
and it is explicitly called out that its contract can change at any
time and user space shouldn't rely on it. It's purely for the kernel's
own usage.

So let's please keep it fast and simple.


> Thank you,
>
>
> >
> > thanks,
> > jirka
> >
> >
> > >

[...]

