Return-Path: <linux-kernel+bounces-40736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E2783E500
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF171F21439
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A769250FD;
	Fri, 26 Jan 2024 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDbd/c5Z"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CA250E8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307371; cv=none; b=g4oAA0yBXwZtnVp4tEXKrSfLkTjJyO5dkiT1uSsJI2ByJM51KeU7OaANy/I1BRxkvXdh9W5ptLZ5ipquQLLuGD+JyEwAaKroscxaSz1dH5L2ZadIXPl6LakT4eZ+4FqI8GKCUwT20GyKn0yXHD5lKI1pgqAI99ZrYHkVfBgGdOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307371; c=relaxed/simple;
	bh=nAhawsEsqsCcYVI70CFznEmT+o0U/Fr8IYx1ftWwQBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9hzogxdyz1qaetZEMuOtD3+a+TmSbLP6IGSJsnLzgPcA5Kfkt7MroRVk33+rEyvoHrHSpG/HhbN8d91/vy4HMzalWofPg2e+VWm0VqOzis3ROePHdzpgaJlFrU2Vmy7zV6gh4VnRsrQhq8W0qJrC80CHymSat8GoyRMhcSqqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PDbd/c5Z; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6432ee799so1102202276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706307368; x=1706912168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8bNr7T/Lt7XgOwTMWUS4eY73fyol+sxeCZ+LiWLeDes=;
        b=PDbd/c5Z0zU8OA3zDfQt2phmH3qCZaxjt2EV055Ih7RXyk0WCNhsLfS5AtrsYA+bl0
         PdeUzS8s1mzV09huzGBSFO4CGtN1PkGIfCtcMtjFeNWT8licxwzY4oxMczGRYY2gXZnT
         Aef53uRDYalsJkQEugUGpri5UISm0MV66i9+cugn8xYXQ+ciow9prCOzg99dEmPbcJ5t
         qBHi+qzzls7syk+F0331dEY4ZpviPVzc1LdzyFsTrQcOnADJkDJrgm1gWYcrW2Vu74Qi
         Lk+AWmKAtqgmRwHi84Ns4ly44BI5pxKXWicLTFIT+xdkRw9U7xGj/asLpXH+sKcZ0HjN
         Y01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706307368; x=1706912168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bNr7T/Lt7XgOwTMWUS4eY73fyol+sxeCZ+LiWLeDes=;
        b=A2tLr2+uY2HdFGRi2vpGdpqGl0ASMm4uWx/iZyRImMSyEu3NfvponWTBbmdt5h7m7v
         mlPX/qoKUU2cUh+qjYk6dGyjRWHBM168l/661oluiq7V7pS7ynq4xhnZVjJ4Pk0R1euj
         s/8m1oRwtAs7ZdqN3MA6JHrYxFkmHlJTIzim10JuMkuSupNuW2LPsWRXJ+cl8cfWBGqE
         WUHBBT12pscdaNO5UBQ5Dk84EjaVjWCXf0TqBcmx43OxO2vx9pzfnD3wX6ObBBScRYLl
         TaUqIyes6fnjGLDU3t2Lc8/yQ+e7trgjlF3jPaEiL8ivUG3TDZAVNuLyHR2uojDZkzyA
         ePZw==
X-Gm-Message-State: AOJu0YyK2bSEncFPYgTxwt2msU6F+EwoYPTM35C+Ipo/w4uQQTnv59Gw
	aOUdhpMwoyhSFS3FwwAQyC+SRpUM3eiQ46QWuLLbFuZ8PK5ElXg5J0CBL6EFlXsIrKGcIZ4avIH
	RJg5BWm5bgbwzP/j9QoZUqhSisGthmKwiMifJA0kb9BBg80pP
X-Google-Smtp-Source: AGHT+IGH9PIpDz86GiZJM/3ppwDCWLHJvH4MBuLirKV+K5VXuQ0BbMh9OPE5LvfC/zo87pjPEP8Xg7xOoK4CmBCjreY=
X-Received: by 2002:a25:bcc5:0:b0:dbe:3ddf:57e8 with SMTP id
 l5-20020a25bcc5000000b00dbe3ddf57e8mr623154ybm.55.1706307368333; Fri, 26 Jan
 2024 14:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122124243.44002-5-brgl@bgdev.pl> <170627361652.398.12825437185563577604.tip-bot2@tip-bot2>
 <20240126210509.GA1212219@dev-arch.thelio-3990X>
In-Reply-To: <20240126210509.GA1212219@dev-arch.thelio-3990X>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 26 Jan 2024 23:15:57 +0100
Message-ID: <CACMJSesVR_3-PBt1ScricSKNMRzH5gesqtTVW3mqN=gg0-O-7w@mail.gmail.com>
Subject: Re: [tip: irq/core] genirq/irq_sim: Shrink code by using cleanup helpers
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-tip-commits@vger.kernel.org, 
	maz@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 22:05, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, Jan 26, 2024 at 12:53:36PM -0000, tip-bot2 for Bartosz Golaszewski wrote:
> > The following commit has been merged into the irq/core branch of tip:
> >
> > Commit-ID:     590610d72a790458431cbbebc71ee24521533b5e
> > Gitweb:        https://git.kernel.org/tip/590610d72a790458431cbbebc71ee24521533b5e
> > Author:        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > AuthorDate:    Mon, 22 Jan 2024 13:42:43 +01:00
> > Committer:     Thomas Gleixner <tglx@linutronix.de>
> > CommitterDate: Fri, 26 Jan 2024 13:44:48 +01:00
> >
> > genirq/irq_sim: Shrink code by using cleanup helpers
> >
> > Use the new __free() mechanism to remove all gotos and simplify the error
> > paths.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Link: https://lore.kernel.org/r/20240122124243.44002-5-brgl@bgdev.pl
> >
> > ---
> >  kernel/irq/irq_sim.c | 25 ++++++++++---------------
> >  1 file changed, 10 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> > index b0d50b4..fe8fd30 100644
> > --- a/kernel/irq/irq_sim.c
> > +++ b/kernel/irq/irq_sim.c
> > @@ -4,6 +4,7 @@
> >   * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >   */
> >
> > +#include <linux/cleanup.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> >  #include <linux/irq_sim.h>
> > @@ -163,33 +164,27 @@ static const struct irq_domain_ops irq_sim_domain_ops = {
> >  struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
> >                                        unsigned int num_irqs)
> >  {
> > -     struct irq_sim_work_ctx *work_ctx;
> > +     struct irq_sim_work_ctx *work_ctx __free(kfree) = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
> > +     unsigned long *pending;
> >
> > -     work_ctx = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
> >       if (!work_ctx)
> > -             goto err_out;
> > +             return ERR_PTR(-ENOMEM);
> >
> > -     work_ctx->pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
> > -     if (!work_ctx->pending)
> > -             goto err_free_work_ctx;
> > +     pending = __free(bitmap) = bitmap_zalloc(num_irqs, GFP_KERNEL);
>
> Apologies if this has already been reported elsewhere. This does not
> match what was sent and it causes the build to break with both GCC:
>

I did not see any other report. I don't know what happened here but
this was a ninja edit as it's not what I sent. If Thomas' intention
was to move the variable declaration and detach it from the assignment
then 'pending' should at least be set to NULL and __free() must
decorate the declaration.

But the coding style of declaring variables when they're first
assigned their auto-cleaned value is what Linus Torvalds explicitly
asked me to do when I first started sending PRs containing uses of
linux/cleanup.h.

Bartosz

>   In file included from include/linux/compiler_types.h:89,
>                    from <command-line>:
>   kernel/irq/irq_sim.c: In function 'irq_domain_create_sim':
>   include/linux/compiler_attributes.h:76:41: error: expected expression before '__attribute__'
>      76 | #define __cleanup(func)                 __attribute__((__cleanup__(func)))
>         |                                         ^~~~~~~~~~~~~
>   include/linux/cleanup.h:64:25: note: in expansion of macro '__cleanup'
>      64 | #define __free(_name)   __cleanup(__free_##_name)
>         |                         ^~~~~~~~~
>   kernel/irq/irq_sim.c:173:19: note: in expansion of macro '__free'
>     173 |         pending = __free(bitmap) = bitmap_zalloc(num_irqs, GFP_KERNEL);
>         |                   ^~~~~~
>
> and Clang:
>
>   kernel/irq/irq_sim.c:173:12: error: expected expression
>     173 |         pending = __free(bitmap) = bitmap_zalloc(num_irqs, GFP_KERNEL);
>         |                   ^
>   include/linux/cleanup.h:64:23: note: expanded from macro '__free'
>      64 | #define __free(_name)   __cleanup(__free_##_name)
>         |                         ^
>   include/linux/compiler-clang.h:15:25: note: expanded from macro '__cleanup'
>      15 | #define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
>         |                         ^
>   include/linux/compiler_attributes.h:344:41: note: expanded from macro '__maybe_unused'
>     344 | #define __maybe_unused                  __attribute__((__unused__))
>         |                                         ^
>   1 error generated.
>
> This was initially noticed by our CI:
>
> https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/7671789235/job/20915505965
> https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integration2/builds/2bVGKZUmat8fRr582Nh8hNA6FXD/build.log
>
> Cheers,
> Nathan
>
> > +     if (!pending)
> > +             return ERR_PTR(-ENOMEM);
> >
> >       work_ctx->domain = irq_domain_create_linear(fwnode, num_irqs,
> >                                                   &irq_sim_domain_ops,
> >                                                   work_ctx);
> >       if (!work_ctx->domain)
> > -             goto err_free_bitmap;
> > +             return ERR_PTR(-ENOMEM);
> >
> >       work_ctx->irq_count = num_irqs;
> >       work_ctx->work = IRQ_WORK_INIT_HARD(irq_sim_handle_irq);
> > +     work_ctx->pending = no_free_ptr(pending);
> >
> > -     return work_ctx->domain;
> > -
> > -err_free_bitmap:
> > -     bitmap_free(work_ctx->pending);
> > -err_free_work_ctx:
> > -     kfree(work_ctx);
> > -err_out:
> > -     return ERR_PTR(-ENOMEM);
> > +     return no_free_ptr(work_ctx)->domain;
> >  }
> >  EXPORT_SYMBOL_GPL(irq_domain_create_sim);
> >

