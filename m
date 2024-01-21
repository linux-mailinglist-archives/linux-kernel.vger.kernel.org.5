Return-Path: <linux-kernel+bounces-32079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9220183563B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EEA1F22C62
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4006374FB;
	Sun, 21 Jan 2024 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCA7S9cy"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48968374E3
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705849918; cv=none; b=REPu+yziuuLfnYIZcxGdoUOgz6Fbjf/LgLUtRUrgkriey2Funu31kstyNqkcc+evrLvgxtdOM3I6+Xu5XDb46yBF4Ot6O6VjJa9xBsY4yjr5RPSz0EMCJ14ovDEMxdLme8k3nUh1pFTWaNmEcHbCJIVhABqq0V1gizgPFxZrU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705849918; c=relaxed/simple;
	bh=IW2tNpqRtWukPmnZrLV5bI9vGtftSglMUWS4rmTJWqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2hSNRW45JIdddx8F4Gl7uSaJ4LFxKcLPpddPpNqsH2tTLQjrdlBxSWZasRgoduweaqSoV6RTlzx6gdo9eQ2tXK6k5Yq5PAjpkSJcnq7Huyo0Nh0olTgUJgxAU28zleQ+PODcodEuyiP3UC3SJt2e3ms3IanA7AmBpePRuXg5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCA7S9cy; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50eab4bf47aso1738543e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 07:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705849914; x=1706454714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+yj1AHvkEM0T6peXvl2abVUiirRYEugftyA4GeUYHQ=;
        b=jCA7S9cyOso1zdAMjlXaCVs8AvBUC5o/3YREcRDSI8vXlZzCQAOx7KfA3AdUT/wAA8
         F7ZvULA4wbNWmVX+wwF781Trycv3kiFPbe3FYcTI0FTXEQjQXDnz1tsgxRlhu+vjiIHj
         WPKVjx4TNXk2bmHaHv0Y++PD8k4WSWICdS30WlQWsNnhPvl0hS2lqfU7p8gpmJZ1pBm6
         m4YKnaQLmjO/uWydm4+S5IuFTdGT041qLdGj4qHwVUQErlBYh6XQc/xvuk438oX9VXv9
         aEyzRYJh6I9Q/+X/2jAyo4h0HZFsWHZ9oV+Dk4ie1dUo3+WS/slJAqo3lD9VXbY+YWRV
         543w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705849914; x=1706454714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+yj1AHvkEM0T6peXvl2abVUiirRYEugftyA4GeUYHQ=;
        b=WhQsq3zCvDAjvkcqbAso2L4NjLabIHMUDBMuHWV2iTKCQjAeXa0L1WB2/dlgrnEyML
         u8bS53I5nJxvXUnFq2UlR+N0BHRo2ek+vFdcNLZEcZCjEfDauHS/h7C1OKp9YJZlEs5E
         covIJkRblCK6BHExGi3NN0YzkNURSYlUObgY79aFNLvnpYen5vICRwUyOQGgDIPK4lGn
         D058+0c3D18Ajc8F66mtc8hWzEcq8nK5b2v9cnIJuBCIrIzEl8XE8ehin6rdDGWkUqi7
         MuhsNsB6pCQxVvpB4REwFq9Jv0qZj6/TgliPIlqz6SP9U9LnFAm8FqbUmOMOfYfTPpxW
         ZZ/Q==
X-Gm-Message-State: AOJu0YzoSTmailJpTE2lXqIUDtlUonYRPlHoxeehCyrD/2rEruvhVfI1
	rfsdxDXsR1TTy/Gqz6qnxet1VO20DgtX6ihtWg8GyXaunsPywFMy63yrb9naNf4wmOO3mIReHcG
	zG3d61baXtiIuai4GwXshi5Em8PM=
X-Google-Smtp-Source: AGHT+IGqCUKLUrCIqeeTuQKg18uGXt+e9JAE407QXXnquhO5PN84ug2tdpfnaTg8POFQBmOLWwJRLQqMXdviUBL+V0c=
X-Received: by 2002:a05:6512:3f23:b0:50f:c24:39f8 with SMTP id
 y35-20020a0565123f2300b0050f0c2439f8mr2133641lfa.6.1705849914011; Sun, 21 Jan
 2024 07:11:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
 <20240117031212.1104034-5-nunes.erico@gmail.com> <20240121095604.2368-1-hdanton@sina.com>
 <CAKGbVbtww65w+sr7OiccawRkGt-p3MRWaWNU=nkQTaqdyMxqVA@mail.gmail.com>
In-Reply-To: <CAKGbVbtww65w+sr7OiccawRkGt-p3MRWaWNU=nkQTaqdyMxqVA@mail.gmail.com>
From: Erico Nunes <nunes.erico@gmail.com>
Date: Sun, 21 Jan 2024 16:11:41 +0100
Message-ID: <CAK4VdL2oRsvCMAWsMyvT+MpPz5e=7=mVtMWAbJKopLEOM0_A+w@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] drm/lima: handle spurious timeouts due to high irq latency
To: Qiang Yu <yuq825@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 12:20=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrote:
>
> On Sun, Jan 21, 2024 at 5:56=E2=80=AFPM Hillf Danton <hdanton@sina.com> w=
rote:
> >
> > On Wed, 17 Jan 2024 04:12:10 +0100 Erico Nunes <nunes.erico@gmail.com>
> > >
> > > @@ -401,9 +399,33 @@ static enum drm_gpu_sched_stat lima_sched_timedo=
ut_job(struct drm_sched_job *job
> > >       struct lima_sched_pipe *pipe =3D to_lima_pipe(job->sched);
> > >       struct lima_sched_task *task =3D to_lima_task(job);
> > >       struct lima_device *ldev =3D pipe->ldev;
> > > +     struct lima_ip *ip =3D pipe->processor[0];
> > > +
> > > +     /*
> > > +      * If the GPU managed to complete this jobs fence, the timeout =
is
> > > +      * spurious. Bail out.
> > > +      */
> > > +     if (dma_fence_is_signaled(task->done_fence)) {
> > > +             DRM_WARN("%s spurious timeout\n", lima_ip_name(ip));
> > > +             return DRM_GPU_SCHED_STAT_NOMINAL;
> > > +     }
> >
> > Given 500ms in lima_sched_pipe_init(), no timeout is spurious by define=
,
> > and stop selling bandaid like this because you have options like locati=
ng
> > the reasons behind timeout.
>
> This chang do look like to aim for 2FPS apps. Maybe 500ms is too short
> for week mali4x0 gpus (2FPS apps appear more likely). AMD/NV GPU uses
> 10s timeout. So increasing the timeout seems to be an equivalent and bett=
er
> way?

Indeed 500ms might be too optimistic for the sort of applications that
users expect to run on this hardware currently. For a more similar
reference though, other embedded drivers like v3d and panfrost do
still set it to 500ms. Note that this patch is just exactly the same
as exists in Panfrost today and was already discussed with some common
arguments in the patches of this series:
https://patchwork.freedesktop.org/series/120820/

But I would agree to bump the timeout to a higher value for lima. Some
distributions are already doing this with module parameters anyway to
even be able to run some more demanding application stacks on a Mali
400.

Another thing we might consider (probably in a followup patchset to
not delay these fixes forever for the people hitting this issue) is to
configure the Mali hardware watchdog to the value that we would like
as a timeout. That way we would get timeout jobs going through the
same error irq path as other hardware error jobs and might be able to
delete(?)/simplify this software timeout code.

In the meantime for v2 of this series I'll make the change to account
for the multiple pp irqs. So do you agree it is ok to leave
drm_sched_stop() as it is at least for this series?

Thanks all for the reviews

Erico

