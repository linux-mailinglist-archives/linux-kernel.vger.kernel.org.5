Return-Path: <linux-kernel+bounces-142555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4898A2D14
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A11B2161E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FB4537E6;
	Fri, 12 Apr 2024 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2Co/ig4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185742AA2;
	Fri, 12 Apr 2024 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712920114; cv=none; b=NhTmR0fp4jargjOGkpA/G1+9rrfAWNuSzxH9MV0Wzwt6fHzqAfgHQT1W03FaDirxl3zAhWSYcXW7F+cCcvQyVYiGuUKKHNEQCbel7VTfqHffoGq3Zlb+xSk5Dc+5pUB0PjiqlmlYlgXJuu7kawNKdD4Oa0oMhJOPtdERTF9lH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712920114; c=relaxed/simple;
	bh=aZygeNBLEEDvbPmqCRdbWqGVMAlMZFqaBfZ8Ykze24A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3zCBcJlon8cM21A5THsahofqAqSwQAl8GuUrwz41nAjvxnKxPnUhTbYDdafVR5H2g3awyte/S8566OCt3C6qHFo3CDPu8OjMEO/epKMfzc6Be6UXyf9kBEfeDQp99gK/oD38eIHaLdnPWYBoIu2IHlpYW0xass7HIugfUyi/Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2Co/ig4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A23C113CD;
	Fri, 12 Apr 2024 11:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712920113;
	bh=aZygeNBLEEDvbPmqCRdbWqGVMAlMZFqaBfZ8Ykze24A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B2Co/ig4fQDui8awDdlQ0XScFHJIuAiFcojLdIMiUsEyOgqaSdIXxvrkz4jilWHfS
	 djWEcQyzBCmSfpP1BTlgocWtcVKeDWfACCJ//olPguRtir6zWVNXJWnlzw6eJeEF1V
	 JRpveal4oxI7nG+d8Tu+xv1NsSMukzalRSWPAqOLKAGMwu6j93OeZ4ByObH4RBm1xm
	 vEd+71IgOzcUu13veNgSH59EHFTxOWA0nH8ah7plgHzgNQwgJqs8AhFbrFW8WMYEdw
	 gFjDk1sYuL94r/NCCFIHykBbeV2Hr9wNrSEUm55UDJ9/BUZvegPIkRNi7jqK7i3OaX
	 H+MaLimsCJCXA==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ea0a6856d7so232322a34.1;
        Fri, 12 Apr 2024 04:08:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDB5tcT/cNwF3vtDz6O+vGGWCHkxHD3Dm22VuLr7Syxzh8hKZZENZH8e1+V5M1sp7lJiwjhZGVXEIG6+NuEGOQjnL4RX07sg8D0B29ZqsfM7KMc5kt5B6nSx/8FPj5cMHw26NIB2M=
X-Gm-Message-State: AOJu0YzMQu0xuBRMByLyZJ8x/GkS+XE8TwvZp9VxgkWw+vRrQ2HEqSMy
	SRvA8eaOIpb5e7gB0ON+116mEVLuoaBPxdH9z/n9YpoRWNj+kIq1eriP59+dMO3coD//mx4ESdD
	nZT8wpH9QQC67NSA6WLzy10NMhmk=
X-Google-Smtp-Source: AGHT+IHrlRrBdOMWR/yEt0NRmSyQw6EkKYYcIWaW0NioL2FpGlMBM79s2nKjhwOs0cukIeughxSYMsnjm8uwIUwRn04=
X-Received: by 2002:a05:6870:7a6:b0:22d:fb4b:9d11 with SMTP id
 en38-20020a05687007a600b0022dfb4b9d11mr2454769oab.4.1712920112998; Fri, 12
 Apr 2024 04:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b97964653d02225f061e0c2a650b365c354b98c8.1712900945.git.viresh.kumar@linaro.org>
In-Reply-To: <b97964653d02225f061e0c2a650b365c354b98c8.1712900945.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Apr 2024 13:08:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hsrG1WHwUDSCbUtxQSjdQV_f30xiQHUE_A=jK9ZSyOVA@mail.gmail.com>
Message-ID: <CAJZ5v0hsrG1WHwUDSCbUtxQSjdQV_f30xiQHUE_A=jK9ZSyOVA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: exit() callback is optional
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, sensor1010@163.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 7:49=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> The exit() callback is optional and shouldn't be called without checking
> a valid pointer first.
>
> Also, we must clear freq_table pointer even if the exit() callback isn't
> present.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 66e10a19d76a..fd9c3ed21f49 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1679,10 +1679,13 @@ static void __cpufreq_offline(unsigned int cpu, s=
truct cpufreq_policy *policy)
>          */
>         if (cpufreq_driver->offline) {
>                 cpufreq_driver->offline(policy);
> -       } else if (cpufreq_driver->exit) {
> -               cpufreq_driver->exit(policy);
> -               policy->freq_table =3D NULL;
> +               return;
>         }
> +
> +       if (cpufreq_driver->exit)
> +               cpufreq_driver->exit(policy);
> +
> +       policy->freq_table =3D NULL;
>  }
>
>  static int cpufreq_offline(unsigned int cpu)
> @@ -1740,7 +1743,7 @@ static void cpufreq_remove_dev(struct device *dev, =
struct subsys_interface *sif)
>         }
>
>         /* We did light-weight exit earlier, do full tear down now */
> -       if (cpufreq_driver->offline)
> +       if (cpufreq_driver->offline && cpufreq_driver->exit)
>                 cpufreq_driver->exit(policy);
>
>         up_write(&policy->rwsem);
> --

I have applied this patch (for 6.10 because I don't think it is
urgent) because it addresses both issues with missing ->exit() driver
callback checks.  I honestly don't think it would be better to apply a
separate patch for each of them.

Thanks!

