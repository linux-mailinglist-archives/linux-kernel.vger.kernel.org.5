Return-Path: <linux-kernel+bounces-44285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BBE841FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7761C267C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C23E5B5CE;
	Tue, 30 Jan 2024 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7tyjvqF"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F227059B4E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607724; cv=none; b=ufl29aPloMfQoV8cA2fdlnCkvxBjurJd1nJ3ldbq4LMBgnuhctenpjgOaIbxeWmLtt+OLAILZX0IF/I69XEb13yn1wsJfE8qLEst3KAOZppT9uKQ8+ukWxqqtTCAc9MfW2Jo+3xqmOfu//jSekq3AnYBajYl92i5zpfl/XFO0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607724; c=relaxed/simple;
	bh=1akIZWOlcQz+syP6eJskDVtQ9hEJTF7i2yELwffJV9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngecqcx4Law8L3j2D4IX5HUg4j9a7HnpzBqUHeTw0SFPLzW6pAEnUO/80hM2LzKqbzflG0BLES07Qzxs1lUV3ri3fdaSUV7533VX3b1d2vmfjvS1ZL4UW5PkfmGkg1A0fzf2sCNrUrp1qY74UyB92nF7vrxB0H/EijohjYHJvP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b7tyjvqF; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e132fef7baso689139a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706607722; x=1707212522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rk9FqAfnyxQRqiMY/FDbYczS/XhnGrLCQVOaYWAXTPo=;
        b=b7tyjvqFWrK9u+IEahyXrteOTwYngvzn19NLvnyZhEC43kaE3Ys7yZTMYIBuzXLYW9
         4ZL4dPALnjrkTnLMUNnqzqXH5bBFLUQZjxR9nqYkEW72NpAcU+TI3HmrMo/VsTNRrz/p
         8M6tiaDTAMBcwXGiuesXIYfNmQEl4TZHbS7BDItkSXP6y+WNApNTzpzGoIlIWmmmRrkg
         uZJR1ha74mzrR6c2bw08fRfo4xawveSD+ZHQLmBgdeBQCTNhh1Zs12SH1ThCMLmMTqyK
         SYSWTQ23M5a56xqLPwIgV+Db9lmRMrDqHX/NbXBOScKPdCZNS3NCpk+YSuC3IbrWltVe
         zJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706607722; x=1707212522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rk9FqAfnyxQRqiMY/FDbYczS/XhnGrLCQVOaYWAXTPo=;
        b=r5Px/biwLqBQeM/21PwPvO1ad/CKItXhFNVS2UY/U5ZX0VEZTik8P4TiZx8++Eqq2J
         3AdRBBHf6OhoXB3Z87dWVTUh/OslokwtZftuqifzRcMvQUGg7/p/ed94d7w9UUHVaQ1y
         7WyKKasaBwJZzzi7JSMpxVpXaw2ejoS1CMmnRIkZVnziJB45PNgEGzPgzGhxG38+QK47
         bTrrVHuaA0u3g4RUIv6+CHqIJFlC/XgRynYrXFF4J8JTndSR1bHiCjjGa90U9qPoWQH7
         vgztlkesOndLiytcYCQ6DLAuusu9VhBBIm/xahocXf+ldGzxd6SuXiCx3hpjtyHwTNSY
         ggLA==
X-Gm-Message-State: AOJu0YzSFDCwf2riEXM1+HdNZgGp2JVvP7+4K40+tTgiXAGGHotfjlL2
	brCJ7M2Ur5FUppT5mWI0wnyNgaFC/8pDzfGMkl3jW+Se/0lHe/q4BatX2gUKvTwpdDWKrKRO1zR
	5siJAP+0mXWLTMmmLCa1IOsSn0becMljGrctctbfDKZJ0XI9F
X-Google-Smtp-Source: AGHT+IEucuHNcABzoWSUH7+Zyp8HMepM//ptGnXltSWttspTAjrBy3yEPl8QDcLljQGO34yyCbNhb6T3DHCfrvJNldI=
X-Received: by 2002:a05:6808:ec1:b0:3bd:9a58:c6e3 with SMTP id
 q1-20020a0568080ec100b003bd9a58c6e3mr6908381oiv.52.1706607722045; Tue, 30 Jan
 2024 01:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105222014.1025040-1-qyousef@layalina.io> <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBYcVWxYOhWZjzcQUB1ebUBA-B30hvToqGBq6JnfRUZNg@mail.gmail.com>
 <20240124222959.ikwnbxkcjaxuiqp2@airbuntu> <CAKfTPtDxqcrf0kaBQG_zpFx-DEZTMKfyxBu_bzCuZ_UZhJwOnA@mail.gmail.com>
 <20240126014602.wdcro3ajffpna4fp@airbuntu> <CAKfTPtDqABnPDmt0COqyRpYSuj_WWwLrqL+Tbfa8J8b5u5eQtQ@mail.gmail.com>
 <20240128235005.txztdbdq2obyi4n6@airbuntu>
In-Reply-To: <20240128235005.txztdbdq2obyi4n6@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 30 Jan 2024 10:41:50 +0100
Message-ID: <CAKfTPtC0=MH7bCypeY1QFxt=pFbPxY9YLuuS8_dhkF31nR6ZWQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 00:50, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/26/24 15:08, Vincent Guittot wrote:
>
> > > TBH I had a bit of confirmation bias that this is a problem based on the fix
> > > (0ae78eec8aa6) that we had in the past. So on verification I looked at
> > > balance_interval and this reproducer which is a not the same as the original
> > > one and it might be exposing another problem and I didn't think twice about it.
> >
> > I checked the behavior more deeply and I confirm that I don't see
> > improvement for the use case described above. I would say that it's
> > even worse as I can see some runs where the task stays on little
> > whereas a big core has been added in the affinity. Having in mind that
> > my system is pretty idle which means that there is almost no other
> > reason to trigger an ilb than the misfit task, the change in
> > check_misfit_status() is probably the reason for never kicking an ilb
> > for such case
>
> It seems I reproduced another problem while trying to reproduce the original
> issue, eh.
>
> I did dig more and from what I see the issue is that the rd->overload is not
> being set correctly. Which I believe what causes the delays (see attached
> picture how rd.overloaded is 0 with some spikes). Only when CPU7
> newidle_balance() coincided with rd->overload being 1 that the migration
> happens. With the below hack I can see that rd->overload is 1 all the time

But here you rely on another activity happening in CPU7 whereas the
misfit should trigger by itself the load balance and not expect
another task waking up then sleeping on cpu7 to trigger a newidle
balance. We want a normal idle load balance not a newidle_balance

> (even after the move as we still trigger a misfit on the big CPU). With my
> patch only rd->overload is set to 1 (because of this task) only for a short
> period after we change affinity.
>
>         diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>         index df348aa55d3c..86069fe527f9 100644
>         --- a/kernel/sched/fair.c
>         +++ b/kernel/sched/fair.c
>         @@ -9707,8 +9707,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                                 continue;
>                         }
>
>         -               if (local_group)
>         -                       continue;
>         +               /* if (local_group) */
>         +                       /* continue; */
>
>                         if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
>                                 /* Check for a misfit task on the cpu */
>
> I am not sure what the right fix is, but it seems this condition is required
> for the 2nd leg of this if condition when we compare with load? I don't think
> we should skip the misfit check.
>
>
> Thanks
>
> --
> Qais Yousef

