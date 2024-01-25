Return-Path: <linux-kernel+bounces-39241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E205283CD46
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F1BB211D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE569137C24;
	Thu, 25 Jan 2024 20:19:22 +0000 (UTC)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F5313664C;
	Thu, 25 Jan 2024 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213962; cv=none; b=F+RbDwgmp1wOvf8sLGAu0ApsV44QF/n7PqR9kOoy15RqY/5ydyhlI1kEVmUy8dijIOLJEHDtvO+xcaueRMdg1eWP1UkgvtUA9oPa7vmPnEHF6Q8K+3NQVuAWkD2ClUTKss81D+YVhoaakZ4p4Wzk5PD4NXK2ak9/bU+6CTITkNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213962; c=relaxed/simple;
	bh=ipLhhFgZ90F56vmCiTIpx4S2UFI4/MpHlqyOUteNJhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lg6ZweFIwIiXg1whYwWkAD9lOx+uuAJ9h0YtvskZaZ4dJk8MIgQUbQzmgMN79YnMn4llzM/lhfbkkXEoROuvM6g0Dwo3+WcDfVyWkuYVx89JCNWBlggFZsxXFl+samFjyTtVzrpOBzlwA9IDndRdomUuHmnINHBBx6MwVhnjkGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-214df50177fso14513fac.1;
        Thu, 25 Jan 2024 12:19:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706213960; x=1706818760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvJqcfERuxA2PaIU85t1WCbw/9zN6boVzq5sjthkjTM=;
        b=gbA3pABPggjlWLNrWqeECoXGlI7BIDDiwaB8WGS8xv8XAVIWNk5zGKXl21cGVp9WK8
         DxDvCqpT45YVK+t0DzU39i4eWUf1G8qvYv8AXlB1RArUxHvMSZO87UmuARg1tFZBMfrm
         f1L5DL364J150VPwg7xDaUJZWnFHbD4H+3GUghjB86eQRVEP8ic4xoiE9y3Dxaaq/ueR
         J2oOpLtkSq8ctl0zj5F3DJqVJHrviabNo0+1BOhzcjUwXiUBHFQuZ0YZOslDuouwwALx
         rkoNoXNZmDgg7DR48OOmrgHNZDILW56pwOc8moxyqBdlQF6SIhbfBnB9/l8+vp/O3OOp
         QbnA==
X-Gm-Message-State: AOJu0Yy/JArVd1Gpurw8YMSUxxzMrHugKA1jh87lz8/Ct4LL2cX+lAhI
	ORYlqXRzMw6HkNk31V7YEAd6KveO5aNRqXrpsYeYLnnY38Hr6QYQWfL1H1EsWWURBbpGo9QHA1R
	LS4qH7/5VoXfSCe/ox8eXNoqxiv3NqPjf
X-Google-Smtp-Source: AGHT+IGWGV0TETbCAHavAE2MNTfYdcxX+qzT+1/hAwhWt3HGJrZmfldHoA/xcoKuNVUB0bzSIGnvbfNpsk1hiVC4oA8=
X-Received: by 2002:a05:6871:53ca:b0:214:b796:73c with SMTP id
 hz10-20020a05687153ca00b00214b796073cmr447136oac.5.1706213959875; Thu, 25 Jan
 2024 12:19:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170359668692.1864392.6909734045167510522.stgit@mhiramat.roam.corp.google.com>
 <170359669607.1864392.5078004271237566637.stgit@mhiramat.roam.corp.google.com>
 <20240117090706.3522d23763fab9dcea21aee1@kernel.org> <CAJZ5v0gqWRsSGQZp7tz-0Kw6od+fjd_iof4Rj7fkBy80ySkcEQ@mail.gmail.com>
 <CA+ASDXOwfUrqRDVx_Fi62ERCLRPF+ixD014vE21Sm4mLF_j12A@mail.gmail.com> <20240125094320.13a0844614375deb8bb06db6@kernel.org>
In-Reply-To: <20240125094320.13a0844614375deb8bb06db6@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Jan 2024 21:19:07 +0100
Message-ID: <CAJZ5v0jLLTETrMpXE3h=Q9GyhDEcZH5f7v+yvyxhzhW8yQKyTQ@mail.gmail.com>
Subject: Re: [PATCH v7] PM: sleep: Expose last succeeded resumed timestamp in sysfs
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Randy Dunlap <rdunlap@infradead.org>, 
	suleiman@google.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 1:43=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Mon, 22 Jan 2024 18:08:22 -0800
> Brian Norris <briannorris@chromium.org> wrote:
>
> > On Fri, Jan 19, 2024 at 1:08=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > > On Wed, Jan 17, 2024 at 1:07=E2=80=AFAM Masami Hiramatsu <mhiramat@ke=
rnel.org> wrote:
> > > >
> > > > Gently ping,
> > > >
> > > > I would like to know this is enough or I should add more info/updat=
e.
> > >
> > > I still am not sure what this is going to be useful for.
> > >
> > > Do you have a specific example?
> >
> > Since there seems to be some communication gap here, I'll give it a try=
.
> >
> > First, I'll paste the key phrase of its use case from the cover letter:
> >
> >   "we would like to know how long the resume processes are taken in ker=
nel
> >   and in user-space"
> >
> > This is a "system measurement" question, for use in tests (e.g., in a
> > test lab for CI or for pre-release testing, where we suspend
> > Chromebooks, wake them back up, and measure how long the wakeup took)
> > or for user-reported metrics (e.g., similar statistics from real
> > users' systems, if they've agreed to automatically report usage
> > statistics, back to Google). We'd like to know how long it takes for a
> > system to wake up, so we can detect when there are problems that lead
> > to a slow system-resume experience. The user experience includes both
> > time spent in the kernel and time spent after user space has thawed
> > (and is spending time in potentially complex power and display manager
> > stacks) before a Chromebook's display lights back up.
>
> Thanks Brian for explaining, this is correctly explained how we are
> using this for measuring resume process duration.
>
> > If I understand the whole of Masami's work correctly, I believe we're
> > taking "timestamps parsed out of dmesg" (or potentially out of ftrace,
> > trace events, etc.) to measure the kernel side, plus "timestamp
> > provided here in CLOCK_MONOTONIC" and "timestamp determined in our
> > power/display managers" to measure user space.
>
> Yes, I decided to decouple the kernel and user space because the clock
> subsystem is adjusted when resuming. So for the kernel, we will use
> local clock (which is not exposed to user space), and use CLOCK_MONOTONIC
> for the user space.

The problem with this split is that you cannot know how much time
elapses between the "successful kernel resume time" and the time when
user space gets to resume.

As of this patch, the kernel timestamp is taken when the kernel is
about to thaw user space and some user space tasks may start running
right away.

Some other tasks, however, will wait for what happens next in the
kernel (because it is not done with resuming yet) and some of them
will wait until explicitly asked to resume by the resume process IIUC.

Your results depend on which tasks participate in the "user
experience", so to speak.  If they are the tasks that wait to be
kicked by the resume process, the kernel timestamp taken as per the
above is useless for them, because there is quite some stuff that
happens in the kernel before they will get kicked.

Moreover, some tasks will wait for certain device drivers to get ready
after the rest of the system resumes and that may still take some more
time after the kernel has returned to the process driving the system
suspend-resume.

I'm not sure if there is a single point which can be used as a "user
space resume start" time for every task, which is why I'm not
convinced about this patch.

BTW, there is a utility called sleepgraph that measures the kernel
part of the system suspend-resume.  It does its best to measure it
very precisely and uses different techniques for that.  Also, it is
included in the kernel source tree.  Can you please have a look at it
and see how much there is in common between it and your tools?  Maybe
there are some interfaces that can be used in common, or maybe it
could benefit from some interfaces that you are planning to add.

