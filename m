Return-Path: <linux-kernel+bounces-132010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF10898EA0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BFC1B28237
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FAB1332A7;
	Thu,  4 Apr 2024 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsG8/Haq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871E317997;
	Thu,  4 Apr 2024 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257525; cv=none; b=KpB7yMoiUyHlsMwyyGavm26cpdlk7zoXGr55Lgco5Jgmg8zo/C1CSSAkrwLZ9CBdy8cXLN0V6aivt2PxiiaRqpWq1wsvBUaH9Bvim/Up0M2o9Z1Ae1Op3nN+KBfEd316qLOtSlV8f7FZpoye9KfS5nSxkg6GjVY9D9+4Oz2/VjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257525; c=relaxed/simple;
	bh=Ad+WmrWDZH+uyKZBlmShx10JISDhkl/xsbS0yXDWUk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWHNIIfXzv316WAOr3SWrotOEU5YTHg6gtuesRKCNXEPwWAwzjdaOwC+O4wDYuoLiGV8EDMXkE5N1Eyi/84V6Xx1xipCXo+dRN5/u64eCRlcWuGzuEUj1Cp/TDXAtHU/IDP3OQ+yQgmkxL2J5VhlhJ1VHXteq2Xt8KUnoN3f3d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsG8/Haq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E2BC43601;
	Thu,  4 Apr 2024 19:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712257525;
	bh=Ad+WmrWDZH+uyKZBlmShx10JISDhkl/xsbS0yXDWUk4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XsG8/HaqIvyCJuoOQFKDwECV3OYkmZu8A9rTkM0MG1JRLMcx2zd4tfudpgJ1khL5x
	 W+eu2v9TwL0NLzO2sR2mJuTAlhsti+X9UKivX7Y4jlEdKcYGcLFiJ4MNHOd4KrG1pN
	 92ek6+WUmBdMNJSG73zkIdUOVnJ3tYoU6vOkYZvYKfDO4laRXrNwNdyGG4LNYP+uex
	 2BCu7o4bpDFUtql84t4Qb3iRpuU8jB7cR0mrN7W6ZzZmRCu+KuRAtjXT/zFuvp2ftQ
	 WNKHosJmJnrih1p+QQjmnEKXEGtt8y3yQfVUjbfJWoibbSKsJfZ2csrhGZkVrfo8h+
	 n9xXNLXvn5euw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a4930d9c48so235831eaf.1;
        Thu, 04 Apr 2024 12:05:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcuQXUx3nJbzcN5MJSfyX8OOaF4zdmnzGUIqRSGVsVXKIaughZI6bpB9gHEeZU3+NAQC1/xD9h7lIWspFmK/1VuP0vKVV0uqVFANQ1WLtW+fR9d4BPXGu4qLrdx/y+Y9r9ZKvGG0E=
X-Gm-Message-State: AOJu0Yw0EECsEQSO0pAAFrony6xao8cW8fsKpNtDsTzrv4UjbSEozoXv
	BzewvgDodYs5G/BIvNqe6/Yv4E0HaBio8h2L7HeobSgO9Ire3Wb2L3phrMngpLYbogFW0EKESLk
	faf+ENFGeskhbsuqc73kPoJeJpdo=
X-Google-Smtp-Source: AGHT+IHw4k4WanAoMWlqbMjVDfiDJN8txdomLinvsfjLzaoY0TxyxKEy28w6X6kRMZd7IprazV5/dSqGVCX1BuW3tCU=
X-Received: by 2002:a05:6820:2205:b0:5a4:6e23:e335 with SMTP id
 cj5-20020a056820220500b005a46e23e335mr3756823oob.0.1712257524264; Thu, 04 Apr
 2024 12:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404104200.1672208-1-vincent.guittot@linaro.org> <7ecd3ec9-6990-4d3e-84ae-d0d3a1cccb78@arm.com>
In-Reply-To: <7ecd3ec9-6990-4d3e-84ae-d0d3a1cccb78@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Apr 2024 21:05:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iXZug9pcFbps8v0xpz6hwbcH8+_esOOTD=wgrmcfCDhA@mail.gmail.com>
Message-ID: <CAJZ5v0iXZug9pcFbps8v0xpz6hwbcH8+_esOOTD=wgrmcfCDhA@mail.gmail.com>
Subject: Re: [PATCH] PM:EM: fix wrong utilization estimation in em_cpu_energy()
To: Lukasz Luba <lukasz.luba@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com, 
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com, 
	pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com, 
	xuewen.yan94@gmail.com, rafael@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 1:05=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
> Hi Vincent,
>
> On 4/4/24 11:42, Vincent Guittot wrote:
> > Commit 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove divis=
ion")
> > has added back map_util_perf() in em_cpu_energy() computation which has
> > been removed with the rework of scheduler/cpufreq interface.
> > This is wrong because sugov_effective_cpu_perf() already takes care of
> > mapping the utilization to a performance level.
> >
> > Fixes: 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove divis=
ion")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   include/linux/energy_model.h | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/include/linux/energy_model.h b/include/linux/energy_model.=
h
> > index 770755df852f..70cd7258cd29 100644
> > --- a/include/linux/energy_model.h
> > +++ b/include/linux/energy_model.h
> > @@ -245,7 +245,6 @@ static inline unsigned long em_cpu_energy(struct em=
_perf_domain *pd,
> >        * max utilization to the allowed CPU capacity before calculating
> >        * effective performance.
> >        */
> > -     max_util =3D map_util_perf(max_util);
> >       max_util =3D min(max_util, allowed_cpu_cap);
> >
> >       /*
>
> LGTM. It was developed in parallel IIRC and that change which removes
> the extra margin to the util was lost from my radar. I can see it
> landed first.
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 6.9-rc material, thanks!

