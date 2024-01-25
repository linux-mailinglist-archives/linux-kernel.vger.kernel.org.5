Return-Path: <linux-kernel+bounces-38988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F134283C962
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341F31C26194
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CFB7316D;
	Thu, 25 Jan 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QEd+Tp4+"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5622130E47
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202030; cv=none; b=aTciYH3iUgzjUT0z4CXovFJGS9XDf34Vlwdf0u60kwPOlojQFq3QDH6MtSD1OV74iJveO9EEV6ZZ9i9d1VocuI7rCKyl9uYYVAZ88fsR28trbvXkH6lOxdhdcOM9wAqLQqy+ItRozMcGqsI+Dv/I2IN8OwzgW5JDzvtsB1WlFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202030; c=relaxed/simple;
	bh=ePieDYL3uIG/HhT3PlTc39v/a1zKuqWP17FuqmEJCAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXdlHv/EP9rb2fZtQUOxeiwhIQxPV5aLbT4v27Npr4y2dckZxwXqSCLdRy3aopYH0F6EzcsMgqtVaCt3nPzRtYC63AR6mz8ezssoiI1sSCdgIdXrrprS1XxQ3pywAL4mjlDKWjrmXMMl7yBM0FSFWOYxmpICS4auVJ4WehExOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QEd+Tp4+; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ccec119587so89310531fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706202026; x=1706806826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqouqsPzOwdJ26Qu00uuxhf3ud38wTMCNuEwNKCWK0A=;
        b=QEd+Tp4+UrEWTpPBnXInSSCeB6Y3LueYGqCChD8BD/wo+mODVWtFKaNRVgvMug3dUC
         E9/209qyMqP6dtnGIajVlM8C0esfU++USRZ7UhLoIi5dnQaIiTLknpEh/loY8zIK/GfQ
         A0tr/bp504IPD3ZJbbjvj7Yftux4L+33efuqfVcfh3K3WfWYAOaD78yyYtaOteuyz1V0
         EM9J6rm4yx1iTcHGJhzX1RePf0kyBanBE+iQb+V8O9vu/moSfeKwKGCsP6ddiwyyNpkW
         KzCgWx4sSEZ051pTIkVx/BK1D/V+kTV8HhOK/hxLNYV8JtgIe6sQ9LCp3xIxF1OzdYAA
         Z5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202026; x=1706806826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqouqsPzOwdJ26Qu00uuxhf3ud38wTMCNuEwNKCWK0A=;
        b=eBBtrQPkFeM6Cx8dVNelFNCNXqXjX2hVZxVv90WS7mmjRkfPG0W9WQvPMAMcKAcAot
         738J1VUTNjtpYRNtne1X4QGwUtm2vWoW3hihv1QZ9TuRTiYfO+yHUbx7TYhVDKEAgGcZ
         W4lZWmoPP+29VOavsl6ZfbQXP6aMRlXQgaGDh6rAelqfM0yU0qYavZpVp8TRRkG2WtuI
         pRgXZpTqdbKtzyGn4wAKPeB6DYfM+FUtDvzrs7EcXShnhjaax+tJiO7I1C/FZt5R4f+x
         TdaTw4vkomH1rzkeZhmSdvnqkHe/cqGogQa5UU2u7MR9VCo9CwZoccTUH17aiZKp51i9
         6hGg==
X-Gm-Message-State: AOJu0YxJXigr4WCt0Qs/VsCeyLyBHwskVF4DSJBDrcMb7w85VeyZJ6/q
	DOvqBq5kybaXNk75ZyLTN8W1syRt12yYXFGwqD8oTVSmTAd+uckr+msPt82eEdxeC8x/p394rB0
	MNCTiZEPFghE3oNC74OmQM56JD5gNHPH19ec9Rg==
X-Google-Smtp-Source: AGHT+IHtpe9kK7qdjl9E5I4YRV61CKQ33C8xXigBPo5I26kSLhgh+jCa5+EyIWftdVIkuYTurXgpBMAeND+pfSQOMMo=
X-Received: by 2002:a2e:8887:0:b0:2cf:2fb0:978 with SMTP id
 k7-20020a2e8887000000b002cf2fb00978mr1048122lji.45.1706202025578; Thu, 25 Jan
 2024 09:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125165416.1987576-1-leyfoon.tan@starfivetech.com>
In-Reply-To: <20240125165416.1987576-1-leyfoon.tan@starfivetech.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 25 Jan 2024 22:30:13 +0530
Message-ID: <CAK9=C2VKiSBX4349jRL0m+XAtT27KSW3GGH+xhaM4ZQoEsAgzg@mail.gmail.com>
Subject: Re: [PATCH] clocksource: timer-riscv: Clear timer interrupt on timer initialization
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, atishp@rivosinc.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ley Foon Tan <lftan.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:25=E2=80=AFPM Ley Foon Tan
<leyfoon.tan@starfivetech.com> wrote:
>
> In the RISC-V specification, the stimecmp register doesn't have a default
> value. To prevent the timer interrupt from being triggered during timer
> initialization, clear the timer interrupt by writing stimecmp with a
> maximum value.
>
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> ---
>  drivers/clocksource/timer-riscv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index e66dcbd66566..a75a74647344 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -172,6 +172,9 @@ static int __init riscv_timer_init_common(void)
>
>         sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
>
> +       /* Clear timer interrupt */
> +       riscv_clock_event_stop();
> +

The riscv_timer_init_common() is called only on boot HART.

I suggest doing riscv_clock_event_stop() in riscv_timer_starting_cpu()
just before enable_percpu_irq().

I also suggest adding an appropriate Fixes tag in the commit description.

Regards,
Anup

>         error =3D request_percpu_irq(riscv_clock_event_irq,
>                                     riscv_timer_interrupt,
>                                     "riscv-timer", &riscv_clock_event);
> --
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

