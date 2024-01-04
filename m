Return-Path: <linux-kernel+bounces-16586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAD08240A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDE01C23FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312262135C;
	Thu,  4 Jan 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO2LdRv9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF72134E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28b1095064so47473366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 03:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704367779; x=1704972579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mal6k+RmsnZAWWsIjGD0I1QkVmbv9FereFIDnUdqh6U=;
        b=HO2LdRv9aElnfd4iFBjsijKO6z6u4N2iwBFxUVAPeGlXTeUcXMCTuBXMtMd5C+J7uo
         YDvqYtslRqOMdoYVtV/ouTKSe5UFdowwkEhimOpUoai+pvb7jHJqUR1pgi8hf8TVC3sC
         Xve/sxzuymVs8pwVwiK09J4ZVk62pImpGAPbbEywheJcQvIqRIF5CMcE56xPSEDBPuXM
         cLEjhnkhPk8RxvpzOUUbWOU4binh3ulEspU2zKPHvP36LMytAWBgOoSrfyNnsmPfOBKD
         k3F32QZoC+oHGIVB+gohoBIlewmGMvfDiHqZ+qwBft4NEV+irLXS3Up6+9Bebz/9+F2e
         MNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704367779; x=1704972579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mal6k+RmsnZAWWsIjGD0I1QkVmbv9FereFIDnUdqh6U=;
        b=fq8fEAQdmINJkXZAkbyc0ZgAzBsWZaMDxD/WPwI+OOxRn93YzzNaS6zupo4RSlLw72
         b6poO5pmVusuOxqHMp29vrSjvXadbhxvGdba/kzs/GZjcriwrhryBbqm58bXosbUIlIF
         +Qj0G6dG+O5gvxeRFqEqdfKyvY4/bdlUD9cX9AeXgOA5P8SCQNc3MbfgFYscjk632D16
         1OGKgYgalz62ssRJG16oF4QHsw5PaX3jjdT/3n/H9SrCzIMw0YU3usrlaJOFrV8zUC/0
         FTGmQ6h/2u079nHGi+FCE6HGfQMhtHTtR/LmKPT5lCTpJbCh75DwMDUeP5x76pTCsLvQ
         zc3g==
X-Gm-Message-State: AOJu0YwrzbOREnQsVvximkCzXnoPH+X8fb3auh1L6UdO7C19QXy9/Hj7
	PN22lSsuAvIY7N8vkKc7FSRljkUaKMgPsFdSVkQ=
X-Google-Smtp-Source: AGHT+IHj+ASlUtQrszGSgf/XT3a/8/wMzbswp1ODHW6pRQdJhCWAzLc9mH0twuu1wnMLSqzp3l73sAVLbpXD9+roY7Q=
X-Received: by 2002:a17:907:807:b0:a28:6611:513c with SMTP id
 wv7-20020a170907080700b00a286611513cmr218111ejb.141.1704367778992; Thu, 04
 Jan 2024 03:29:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103081042.1549189-1-alexs@kernel.org> <xhsmhy1d5ids9.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhy1d5ids9.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Alex Shi <seakeel@gmail.com>
Date: Thu, 4 Jan 2024 19:29:02 +0800
Message-ID: <CAJy-AmnLR-Gw1zbRC_W1aCG5Ouy8VRunW2++mYFBGeJ7Po5viw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/stat: correct the task blocking state
To: Valentin Schneider <vschneid@redhat.com>
Cc: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org, curuwang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 6:38=E2=80=AFPM Valentin Schneider <vschneid@redhat.=
com> wrote:
>
> On 03/01/24 16:10, alexs@kernel.org wrote:
> > From: Alex Shi <alexs@kernel.org>
> >
> > The commit 80ed87c8a9ca ("sched/wait: Introduce TASK_NOLOAD and TASK_ID=
LE")
> > stopped the idle kthreads from contributing to the load average. Howeve=
r,
> > the idle state time still contributes to the blocked state time instead=
 of
> > the sleep time. As a result, we cannot determine if a task is stopped d=
ue
> > to some reasons or if it is idle by its own initiative.
> >
> > Distinguishing between these two states would make the system state cle=
arer
> > and provide us with an opportunity to use the 'D' state of a task as an
> > indicator of latency issues.
> >
>
> get_task_state() already reports TASK_IDLE as 'I', which should be what
> userspace sees (e.g. via /proc/$pid/stat). This is also the case for the
> sched_switch and sched_wakeup trace events.
>
> I assume what you mean here is you first turn to schedstats to check
> whether there is any abnormal amount of blocking, and then if there is an=
y
> you turn to tracing, in which case you'd like the schedstats to not make
> things look worse than they really are?

Yes, switch/wakeup or others could help to figure out real blocked
time, but with this change, schedstats could give a neat and elegant
way.

Thanks!
>

