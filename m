Return-Path: <linux-kernel+bounces-75860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E585EFF2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A8B1F23B96
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98E917560;
	Thu, 22 Feb 2024 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hreMZrV7"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632028EF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708572818; cv=none; b=DtM/XtZ2exyNwrcF50xF/+M+ta41A8vVneC1QAywm/JNMrbnjeleQnpoXWs4D6AbpB/M+bFZCpamfXbNDoD0OmcBZKQCcea+kkr5+2mEBH9CEAX9hDAOGJNVUhxpoYs1w/sWgyOWfspKRdBq4bx7lPzXDC41TSJAuo7v1X9jyF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708572818; c=relaxed/simple;
	bh=URHjr+ChHdQ1rHEgj2w8H31cO+/r5r4OAqaQksqRx6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fm99R+KIJdby1AdZFp1WzBTfZ3gR5l+KgGm7FZz0JqdyjZ+cDMHOGal4Bj4cd+FxIUksq9G88MCU/i9dADhUriP30las2Yeb3IuRw4hVcKwKNOMIi6xvKffwVXTMSYgJYcfrEY2Dwoxytl8W/WgrPSFpVI4mkS59IxNpsuk7eZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hreMZrV7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e47c503fb5so2183341b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708572816; x=1709177616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHAMwOUToAwFkBITdyqsQLlGeV+NzFx4M5PdSc3kuRE=;
        b=hreMZrV7bL9lKd9UIoAdmVlkd6c8Cl3ac1qi8+PZ4RqRkXcGbQLxSwZVARrFoMlLRP
         Ezs77dtu0h3NFXW/dH3o2R8mCiJ/ktXuEASrWz/2QHAiF9spEjjfXuu4nSeKS8UbJQaO
         adb7wuh9AxborLKPRNIyhD/IbPjQpjrMNBYk3OAXoJUlIqt4hmWQDp3/VnghpzMP2Fr0
         hpBoz2eoVQOMp5V1iI9myRMJZreir1Q95YCq8EkwDjaWc0Q0/ZigBvEgnfBjwJy5w0zz
         nZkH+qV6hCqoiRcRAc3MwbsRBB1WLB205udWsbBC4O2uPvP7ezWZHgb/avD3N/YxsFco
         WOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708572816; x=1709177616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHAMwOUToAwFkBITdyqsQLlGeV+NzFx4M5PdSc3kuRE=;
        b=AHycHfyk5eP+DX5RDTSjL0b7mNfTJ2+YNJFABFrG+6oitakpqj+8OfopbtJFuXqXwy
         asGa5aKc9Qr/sexqSUVLpaWUzhe1RcBNNGKjuHy8x+qvlHY5AV+S8jwDIza8PhFt5EMr
         BJGj4WRiZlajUmrKrfAEmqaNmkejA4KBDG7oCbiIEpTaEx9lQTXzSNXODjBSMVLJW+rR
         GdZatgY9YHIkgrB5D19Ogapr/sp+k5hNmU1G6E8VDUNS/y0UMY1yMKBP+kZC93LuvSfR
         oJDPIXov3moeMoNUfSxfLhT76Ptqy9UA9EAGj+kyI5lCylTEoBHdiOnr6GNskvmOF3hK
         E/zw==
X-Forwarded-Encrypted: i=1; AJvYcCW05Ir3RHEgMIWkp8LzM/YQIwHAPGcWykNqzOz9ZKjHKynUP3/D0SosMVuCYBOqZvklJh8H5Za9HON45pGpxw9TQ6QG+c31fdzvpYno
X-Gm-Message-State: AOJu0YxqIw10pCTpQHQlQu1NRRABzaX0rBVn7YiE8YEOJQja50ritSOz
	NJEQcVwfkIXlFWJ2bCHcuG6SW9yaIa9n8JDySrSYmizp94LhN925LXxL9yClOAooMoP5i6vORSG
	Z9JDGYEtcldY1cfeCqlc8UtToFA6rRJxoAtG0/g==
X-Google-Smtp-Source: AGHT+IHO6r6XN0homLx3kTbgEJ1s87Hf/cfhSNWXD7ItOEoeWhdD8ege76NGwlURHiS8wYSf9720b3lx7s5OiQYicuc=
X-Received: by 2002:a05:6a21:3a87:b0:1a0:c5e4:f685 with SMTP id
 zv7-20020a056a213a8700b001a0c5e4f685mr3399855pzb.33.1708572815988; Wed, 21
 Feb 2024 19:33:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221174333.700197-1-tj@kernel.org>
In-Reply-To: <20240221174333.700197-1-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Thu, 22 Feb 2024 11:33:24 +0800
Message-ID: <CAJhGHyCJS7Pb_5dwTQtcZ25yOVzxFULJEYT4o3id_3xdj32EYA@mail.gmail.com>
Subject: Re: [PATCHSET v2 wq/6.10] workqueue: Implement disable/enable_work()
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Tejun

+cc tglx

On Thu, Feb 22, 2024 at 1:43=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

> 4cb1ef64609f ("workqueue: Implement BH workqueues to eventually replace
> tasklets") implemented workqueues that execute work items in the BH conte=
xt
> with the goal of eventually replacing tasklet.
>
> While the existing workqueue API covers the basic queueing and canceling
> operations, tasklet also has tasklet_disable*() which blocks the executio=
n
> of the tasklet until it's re-enabled with tasklet_enable(). The interface=
 if
> fairly widely used and workqueue currently doesn't have a counterpart.
>
> This patchset implements disable/enable_work() and the delayed_work
> counterparts to address the gap. The ability to block future executions i=
s
> something which some users asked for in the past, and, while not essentia=
l
> as the caller can and often has to shutdown the queuer anyway, it's a nic=
e
> convenience to have. Also, timer grew a similar feature recently with
> timer_shutdown().
>

From the last patch:
> - tasklet_disable_nosync()      -> disable_work()
> - tasklet_disable[_in_atomic]() -> disable_work_sync()

I think it is a misuse-prone conversion.

A developer familiar with tasklet_disable() might happily use disable_work(=
)
and, to her/his surprise, leave the running works unsynced.

And tasklet_disable_nosync() is used at only 3 places while tasklet_disable=
()
is used a lot.  I think the shorter name for the most common cases is bette=
r.

Moreover, IMHO the unsynchronized variants of tasklet/work disabling functi=
ons
never have a strong scenario. I think it should be discouraged.

Although it will be inconsistent with the name of cancel_work[_sync](),
I still suggest:
tasklet_disable_nosync() -> disable_work_nosync()
tasklet_disable() -> disable_work().

Even cancel_work_sync() is used a lot more than cancel_work(), so I
also suggest rename cancel_work() to cancel_work_nosync() and leave
cancel_work_sync() unchanged (at least for a while).

[changed topic:]

I feel uncomfortable with tasklet_disable_in_atomic() implicitly
being implemented in disable_work_sync().

I think it is a revert of the commit ca5f62511895 ("tasklets: Provide
tasklet_disable_in_atomic()") in which tglx discouraged the usage of
tasklet_disable_in_atomic() and marked it "error prone".

And even tasklet_disable_in_atomic() is implemented in disable_work_sync(),
I prefer to sleepable-wait than spinning-wait when disable_work_sync() is
called in a sleepable context for BH work item.

All the above is just my feeling, not reasoning, nor rejection of the patch=
es.

Thanks
Lai

