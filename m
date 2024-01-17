Return-Path: <linux-kernel+bounces-28661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6511C830182
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCA41C22D72
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C2D12B8F;
	Wed, 17 Jan 2024 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTm8n2iT"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08812B69
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481334; cv=none; b=X+HfTfaZChLIKicglgtKII6qDV8WVBmNdja/SBP004lRCmF9UltF9ilS513uUKR75NEd6u7JPGaNyTmbccTGsKLfhwHYFzQlYDdMTjBxSkwND7B3jtGL8l7oRelaLCtACTuTXWtEpTxehd8uwkG2lxKw1mPTqs90l9AcuURFKak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481334; c=relaxed/simple;
	bh=rFMZactVUZhTf1WH+X2o25MBxTJMjE9AEhBmUmA9bPk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=SoVC8R894EBWP65fG/9Ysbnptcsh81tKpeCWSaJyYZAY6GgYtqLDFbWHuK1EydrdGRFaUA8XdMIZtwnQQ2TR3k++JxbD+BjY1chfW3MgstM4gpCFXS6hjRCFZgteIyxQSMjRebh6qhSYfYuIZwZemrTzFhKxM4Yq18jSaaWZ3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTm8n2iT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5578485fc0eso10080004a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 00:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705481331; x=1706086131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vUTM4o3fZN7gUWoFikj1qVv9UyKwB86FfJajB2beEo=;
        b=dTm8n2iTHTG2A4ebcjbd84NOY5Hfz6LuYnway70vLpUvRV1doMGyrR04AT9U+7/1+k
         nPB4p04Ipb3GKZCmJQcgBSk5mpWB9KMnhFHF58H2NXccc9cXgDGsv92bUuSFqvuODEl5
         Ra7Zj4CSkGMug/MzaRBAtcZvmRCg1KdJ+ymhHFu+MMWfd+SEwPIIQlsZjyAwQCm0x4oO
         9rvE6Ext3Rhy0RDl+QDnw9vOUc+nHUai6QPlK3xEQgspnvyTBFeWGCCXSgKq7UUSQcli
         7dTu1fY1hcK39Vk2V//5lWFMSK7mxmd8vCzEuIkshYrUG9GLlIfDKf3R8PBh+MwoqVsZ
         B9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705481331; x=1706086131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vUTM4o3fZN7gUWoFikj1qVv9UyKwB86FfJajB2beEo=;
        b=SpGwfFXQYOc9nX2D3C9OsVw/VWfU0sckQGVl2YmknUU2C/jC6m9404Df3s7JVtR9bs
         R1ewwq89Qw37bfNCPxme7+kSsRBgGh4AQ6mKtFMFIpnyVFT7g3Gkwywz7wlxPlAAnB0p
         Wj0qT43JYIQvwBJLTFVvAx4Zbm/MhEpv8Zey6dVwVx+Rl35/3PK3rjq1T6hHLACGdJzB
         nhZeyq5Lw4f3AIJLXksVxAAeYoa9wRgws5b3/YQV3Vvzb5Qwj+MEhJmgNTLKOor57hXS
         MQ1+yR630KK8lN09/bmHRWA4VO3naOO/y+f/xVRWl0qnn9t/9iH/qF6hJUm6hgEeoOfK
         RoHQ==
X-Gm-Message-State: AOJu0YwYVaDwb7w/Oxujk7gTjJCwtUr/SokLYz7oW3oJ/TfNpf/QeKf9
	tvXh07zOEB7RXhzyyHE+IcY2kmZg813RogcNbAk=
X-Google-Smtp-Source: AGHT+IF/Kwj3mHfJFUKTeB8bvumYIdZ4dhZuMbaFuKVWjAoMPsaTZKXQu5nb1cDtCdukthjZONqR3KXytdi227qJfF8=
X-Received: by 2002:aa7:c993:0:b0:557:1196:b249 with SMTP id
 c19-20020aa7c993000000b005571196b249mr4627080edt.14.1705481330557; Wed, 17
 Jan 2024 00:48:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103081042.1549189-1-alexs@kernel.org> <xhsmhy1d5ids9.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAJy-AmnLR-Gw1zbRC_W1aCG5Ouy8VRunW2++mYFBGeJ7Po5viw@mail.gmail.com>
In-Reply-To: <CAJy-AmnLR-Gw1zbRC_W1aCG5Ouy8VRunW2++mYFBGeJ7Po5viw@mail.gmail.com>
From: Alex Shi <seakeel@gmail.com>
Date: Wed, 17 Jan 2024 16:48:14 +0800
Message-ID: <CAJy-Ammg6Cj18f76bEd9Ht3=pijgXxkeKs=1X6ju1M0HvsCwhw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/stat: correct the task blocking state
To: Valentin Schneider <vschneid@redhat.com>
Cc: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org, curuwang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alex Shi <seakeel@gmail.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=884=E6=97=A5=E5=
=91=A8=E5=9B=9B 19:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jan 4, 2024 at 6:38=E2=80=AFPM Valentin Schneider <vschneid@redha=
t.com> wrote:
> >
> > On 03/01/24 16:10, alexs@kernel.org wrote:
> > > From: Alex Shi <alexs@kernel.org>
> > >
> > > The commit 80ed87c8a9ca ("sched/wait: Introduce TASK_NOLOAD and TASK_=
IDLE")
> > > stopped the idle kthreads from contributing to the load average. Howe=
ver,
> > > the idle state time still contributes to the blocked state time inste=
ad of
> > > the sleep time. As a result, we cannot determine if a task is stopped=
 due
> > > to some reasons or if it is idle by its own initiative.
> > >
> > > Distinguishing between these two states would make the system state c=
learer
> > > and provide us with an opportunity to use the 'D' state of a task as =
an
> > > indicator of latency issues.
> > >
> >
> > get_task_state() already reports TASK_IDLE as 'I', which should be what
> > userspace sees (e.g. via /proc/$pid/stat). This is also the case for th=
e
> > sched_switch and sched_wakeup trace events.
> >
> > I assume what you mean here is you first turn to schedstats to check
> > whether there is any abnormal amount of blocking, and then if there is =
any
> > you turn to tracing, in which case you'd like the schedstats to not mak=
e
> > things look worse than they really are?
>
> Yes, switch/wakeup or others could help to figure out real blocked
> time, but with this change, schedstats could give a neat and elegant
> way.

For all of the shortages I can imagine, we can't treat blocked and
sleep states as before,  and that may force some scripts to change on
these things, but giving 2 states the correct way is better way, and
make sleep/block state more meaningful and helpful in normal usage.
Are there any concerns on this?

Thanks
Alex

