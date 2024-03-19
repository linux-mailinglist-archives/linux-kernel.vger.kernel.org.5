Return-Path: <linux-kernel+bounces-107826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16235880228
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D7E1C22FC9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998DE85268;
	Tue, 19 Mar 2024 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jehr51D2"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56085265;
	Tue, 19 Mar 2024 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865175; cv=none; b=FUMGnHXhrZrcKslYGUUO8sIGsOT6KSy8QTnbyfjKMxj4dE4eNvpeQ14jur/DNHlUkEB5qfplqFbY6KzisAJ0y/9uEEV8+Z0ZZnV40n1F9Ek+VC7p1frnZtGuhyYBVGOgx4q7kN5Hl3tXe4ZHuSmB3dOy6v/CpDfEV7XI7q1sWDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865175; c=relaxed/simple;
	bh=VFaRQas0gSrfP0qC172CcOje6IBtZpzaLgn68X7typs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avnVmbZOoVzlTYA3F7z5fS3qoWCfd9uB6Kwr263wlKO4FHPU8iE7GL23Z4kf07dnCtSu30XmYKPWfK8iDuZlvsErHPjUK+9q9HyzsmlS6xNTTM6y/8AEs8/oAxroZpixib9jFqL/FVVk+DF/CZuGftkgzkQBmkyE3mu56Ql3WSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jehr51D2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1def142ae7bso39071395ad.3;
        Tue, 19 Mar 2024 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710865171; x=1711469971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Epr0Xv4Q3hfU6xbN2E2KtYBZZdf7JymwhQQwouieY7s=;
        b=jehr51D2+XSPEUdph5sP1wCoe2sw8uZWkb9J0eQRrjyyKzveMA0oLS/w+JP/tX4Wi5
         S7zc883Fg5Lr1LI8+Dq5aWTv3x1Q5xJC/XiO6rfvIjalmLOFK8Ll5qt2xumc76Hyp0D9
         UciDCjCTsUV9gYDw8NOmWT+nOiuClhMjZKvRc30IQiuSr8D0W9oVbMImD7HF3jhstBHx
         vjoJz4skasY2zMIsn3525jTYcB5JpGNvRI4HrYSv3fSeOnrHnCh3UGsQ1+bKboSPGtlA
         K8Uwu247TDHxLzqUQKOOBp3ut4RCkIBogsSa5B2xARyApps9M/33v8nxDhKbHRhaHzZJ
         VOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710865171; x=1711469971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Epr0Xv4Q3hfU6xbN2E2KtYBZZdf7JymwhQQwouieY7s=;
        b=cRbNDCJKXENyv5l4MlI7uUsB4H1796ntuUn6Cqmc6RRpr4eGycQxwYq7ggx4U+3Wg8
         JxEaSAcSeM7hWu0OdhZvV9ozR9FJzkpcUM0PZmyUeg/rSDRFmyJmzKr8OcxRrhlK7BW/
         KR5voC6Xx9sdC1XcCoiP0oZLV7lYhuLhMdfoBLI0vF8SGUTVwxf/PZjS1/4pNImTP0PI
         L8XjqHF3BVhG049MH0ds3FJKCzHTZoQak2KQPcrM/3o/cHw74coKnK8olyrHg0yqzxy9
         1Pzh8h9BddseRAnW73eC8crpjkYG/ikrVxej5iV93dSmt4hqWoNCpDpDZcT5SCF2c6cI
         kwxA==
X-Forwarded-Encrypted: i=1; AJvYcCUYnUUi5Ze7gFWmPxXtfgQzjkVNjKtg+6i1yK4uNTJ6ByjbNPMndj5pYG22hVkBcjT5B7npRktATq/3GagtPhFLDMC076AjdKU0NDXIZNa35VuDm+L8Pewuzi6Y1YexuguOLHti2Oy3IoP0AjiOTnWQMDYnqAlF5/nHgJOsNYPE2pBXqL0v
X-Gm-Message-State: AOJu0YzVb3YPk3vzH3myUM1RNAvDIV69JVvFagFf/nEpl22tS8OjU/mv
	nI29m8/r/j3joQfx8MJbHN1T/wpEutAQejExYaz2LuLWUsUUxOMnqJuhM7HSiAI0sd3SXGrXNSl
	k6tnmbH00FdAttsBwg9YWtBE85IF8lfCh
X-Google-Smtp-Source: AGHT+IGFjpRbnCDyRCQ1z3277NWH9fPOrpACKz4p44EkTlkRUxbeqzQQ5mQ1iMoSUIughS59YHq7ZIPUJGj7zKNSrLA=
X-Received: by 2002:a17:903:1c9:b0:1de:f32d:f5ba with SMTP id
 e9-20020a17090301c900b001def32df5bamr15251700plh.42.1710865171367; Tue, 19
 Mar 2024 09:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318181728.2795838-1-andrii@kernel.org> <20240319132057.78e60d15e4fd07dbef3b14a9@kernel.org>
In-Reply-To: <20240319132057.78e60d15e4fd07dbef3b14a9@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Mar 2024 09:19:19 -0700
Message-ID: <CAEf4BzaFfQeD8TY7pXEyX4h5UeAg0HZpx8psJF=Z6GJmr3VF5w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] uprobes: two common case speed ups
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, bpf@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, oleg@redhat.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 9:21=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> Hi,
>
> On Mon, 18 Mar 2024 11:17:25 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > This patch set implements two speed ups for uprobe/uretprobe runtime ex=
ecution
> > path for some common scenarios: BPF-only uprobes (patches #1 and #2) an=
d
> > system-wide (non-PID-specific) uprobes (patch #3). Please see individua=
l
> > patches for details.
>
> This series looks good to me. Let me pick it on probes/for-next.

Great, at least I guessed the Git repo right, if not the branch.
Thanks for pulling it in! I assume some other uprobe-related follow up
patches should be based on probes/for-next as well, right?

>
> Thanks!
>
> >
> > v1->v2:
> >   - rebased onto trace/core branch of tracing tree, hopefully I guessed=
 right;
> >   - simplified user_cpu_buffer usage further (Oleg Nesterov);
> >   - simplified patch #3, just moved speculative check outside of lock (=
Oleg);
> >   - added Reviewed-by from Jiri Olsa.
> >
> > Andrii Nakryiko (3):
> >   uprobes: encapsulate preparation of uprobe args buffer
> >   uprobes: prepare uprobe args buffer lazily
> >   uprobes: add speculative lockless system-wide uprobe filter check
> >
> >  kernel/trace/trace_uprobe.c | 103 +++++++++++++++++++++---------------
> >  1 file changed, 59 insertions(+), 44 deletions(-)
> >
> > --
> > 2.43.0
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

