Return-Path: <linux-kernel+bounces-146710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFD88A69AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB3B1C21091
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A421292FC;
	Tue, 16 Apr 2024 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPW985o9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBDA1DFEF;
	Tue, 16 Apr 2024 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267285; cv=none; b=bVp0ftU1qUvBajnuOtn3or9j4DMM5RDEzNs7gduVwFe67zKoxzGdYAG3nsC+Ljr+6CzXlNTzgLHDxwY1rKSlUk+cqnP0dOKHJXHbLk972si/JggC2P6nReDtUhXbvZ31lBjd74Nl+7JkrHbqTrAlELLAZxMfTLDE8gGwYz7p5k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267285; c=relaxed/simple;
	bh=JEB2ze4FTOdoPtrx7qGRWNXJdiwK6MLijfrzKDOzS+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKAZwADgRzPaxxdydD3R21m09KKSqYDYlfhjCEEiW/hjv1oKYFT6f3OCCkanL08elgaUN2McM9ozgmIbutEOJrbq8ppKYMup8mL0zuV4mZZIIxibxhZh/xO6SyyqCc8M0HwT5Pdjp9eBS9tCpe/IH7Mu5X4HNZjBhMqIqNR8Ijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPW985o9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D814AC3277B;
	Tue, 16 Apr 2024 11:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713267284;
	bh=JEB2ze4FTOdoPtrx7qGRWNXJdiwK6MLijfrzKDOzS+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tPW985o99XgdT5+tX0EwF2yFaLjiWldWohukQaA3emhWvxgHecbpM+E6vgsYklXZu
	 lxRbgEIvSmmL4SkikIUatHHtYPQk8J6/gZ+d99OCxPA8I2JSsJJ8a1DjhyxD+Q8zhH
	 2yFPORjIh2bN9cf6RCg3Sl+XrbmKV2ElPglrUYhikD6yOO5D3u72WktobOjEay1xZC
	 adMvtWpuwwyzxlXXgtC9pAzxTUtwL5KUIn6IhSg/Ext+jFvh0CU1Xrs2eoMkzM+Ybe
	 oqwpHrzc2y9Oj+y00e9/KD/ewnbcO64/h0w/BQFHOwr8+ujZGihFnEIeKJynkKstzT
	 JcPhxsa+jvCmw==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6eac2b144b3so1183541a34.0;
        Tue, 16 Apr 2024 04:34:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXk/35jrJGKspklnvj8tvntYLPqF0HNSZwm/VM2bqyc/+XLSF2QLugeasUJUjAkhyTLN6YoHsmqOWdtkVlXiuIdHzFbdAHYDvLuc83b9UVyEipP1428yvse6LsT1KcHR1M5pPVF8Yw=
X-Gm-Message-State: AOJu0Yw3QSQuA3G1TtR8rM36Lwtwvm+/S0mkT/E/PwpqpuS+zMtqXJIz
	eXzj2uEsbnAHCY3uQcPGvNfxjPznboX5N+6IFLG2ND/wi8TNLSO+9W+4lzk5EBoUsgOpMsw5Rcy
	MNGgo8VIFmRifr80fcmY5pFa9VBE=
X-Google-Smtp-Source: AGHT+IFNqiWoke4OcolARhwscUnn1kKtQJrYzcKsSCBgcNH5PmMnem/f7qJvG1YCbBid8j89jX5GZBomywu49X2Prdg=
X-Received: by 2002:a05:6870:d28d:b0:232:fa03:3736 with SMTP id
 d13-20020a056870d28d00b00232fa033736mr15052954oae.0.1713267284150; Tue, 16
 Apr 2024 04:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415094821.3060892-1-dawei.li@shingroup.cn>
In-Reply-To: <20240415094821.3060892-1-dawei.li@shingroup.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Apr 2024 13:34:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hgeRo0oVviN8GHNaR_wNOBxGyYF=S-2LU3GEOFSUzytQ@mail.gmail.com>
Message-ID: <CAJZ5v0hgeRo0oVviN8GHNaR_wNOBxGyYF=S-2LU3GEOFSUzytQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: Avoid explicit cpumask allocation on stack
To: Dawei Li <dawei.li@shingroup.cn>
Cc: daniel.lezcano@kernel.org, rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 11:48=E2=80=AFAM Dawei Li <dawei.li@shingroup.cn> w=
rote:
>
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
>
> Use cpumask_weight_and() to avoid the need for a temporary cpumask on
> the stack.
>
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  drivers/powercap/dtpm_cpu.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index bc90126f1b5f..6b6f51b21550 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -43,13 +43,11 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 =
power_limit)
>         struct dtpm_cpu *dtpm_cpu =3D to_dtpm_cpu(dtpm);
>         struct em_perf_domain *pd =3D em_cpu_get(dtpm_cpu->cpu);
>         struct em_perf_state *table;
> -       struct cpumask cpus;
>         unsigned long freq;
>         u64 power;
>         int i, nr_cpus;
>
> -       cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
> -       nr_cpus =3D cpumask_weight(&cpus);
> +       nr_cpus =3D cpumask_weight_and(cpu_online_mask, to_cpumask(pd->cp=
us));
>
>         rcu_read_lock();
>         table =3D em_perf_state_from_pd(pd);
> @@ -123,11 +121,9 @@ static int update_pd_power_uw(struct dtpm *dtpm)
>         struct dtpm_cpu *dtpm_cpu =3D to_dtpm_cpu(dtpm);
>         struct em_perf_domain *em =3D em_cpu_get(dtpm_cpu->cpu);
>         struct em_perf_state *table;
> -       struct cpumask cpus;
>         int nr_cpus;
>
> -       cpumask_and(&cpus, cpu_online_mask, to_cpumask(em->cpus));
> -       nr_cpus =3D cpumask_weight(&cpus);
> +       nr_cpus =3D cpumask_weight_and(cpu_online_mask, to_cpumask(em->cp=
us));
>
>         rcu_read_lock();
>         table =3D em_perf_state_from_pd(em);
> --

Applied as 6.10 material, thanks!

