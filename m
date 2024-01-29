Return-Path: <linux-kernel+bounces-42546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AF98402E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0022F2842C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DA857865;
	Mon, 29 Jan 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBKp1PZV"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8A75730C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524671; cv=none; b=P9ZmQd+0h69UUE0+juCgVy/gx0pXxcPWeuy5l0ef8wXOOIoiM0KiiAO4lv1AqsyGPOjBISxKqnrzgTq/YX/e/zBXDZEWVYNefVShJOrRCLCwwEPLPsqemWdUCsQ+VtBZtqTnyoNV8WqM9Cysa+qCCFqr71yY+EGjxI9MxcQ3BKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524671; c=relaxed/simple;
	bh=1wRdObldpz8Oy1Sjei4zAT/euERB6gBBuM0OId3eFno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbNSwSm1T3tdhr//tjuFBjDf+70BdKXU4RO8sTCHvyb+KMoVhPINQBp+D/HNUw/NPuEtwN1Gc8r5El6RlAZ9i6Vs48D8eerx3aAQhJ7svW5d8nIem13ecsh9IpOeoxTUBtEhPpnRDo9B6ZTpg/657LH3qDCMgQ1tWgTOqxgl4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EBKp1PZV; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-603dc95b8f3so4819637b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706524668; x=1707129468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SN0szkxowObuhuLjknKCW5v8Er8Wqapia+3YQTLOHeI=;
        b=EBKp1PZVxtMwI2bFqwYCSwBkt7nmeYGQaN6CO7A/8Pi8G/M0UDXjMcvtHFQQwP90Ja
         6FaNOFqkcGkrFxj0qb6CcngE8OIr5Y0KNNQ/5qIlFEduSNVVb87xZ5zS4vCeRpUHt8hp
         rZee9sBeVSk4St26/DwDUCoaaxFIb/mDiNqcCJnYeLXGbVcgNvWqHLbzF2c8K/qQ6Izl
         jLlp5jTMXxh8c+qZZv2ed9v1tiMcYClfeZORDs7FCB3hNG/SO46Y7ZMftFIZpDUwa4Vb
         1QkVZUObq3yYDu/YPE6GJn6BsAnyJGqzG30kG+0yghXnGuzZFUQX5KzkTTb3yga61qaJ
         f8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706524668; x=1707129468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SN0szkxowObuhuLjknKCW5v8Er8Wqapia+3YQTLOHeI=;
        b=Lusaz76mfHEVW7sLiUkFf09+ezn+Tc7wdMq7gZ9btCck/SOdgSXy2oW6oWXvc5aCcm
         LTO4G2/3lt0XLW2M6AJW4rrMfUtWA0pPLMcRk3bGAoDooHz20wJ1PQZ651j4fwy4TQiG
         cgMdUAVC/jlNiem0O3AR/PnfkgGY6VSwX5PY37XVDWbeWjfHnm2dmfPt2mIGGLCABhgJ
         F5RPNbUyc1uScZcJY49trPFwuVoDQ2vehb5IpvG+h523o1z1rCOF9izheEoyzRvslTQb
         ax/KzVgUljHmg9aQUbU4cedn/ZeO0SlfdO1fDSt0EiVvpvryyLvgr/m1MhPjAiXhs2ML
         IlEA==
X-Gm-Message-State: AOJu0YxjCahSNxR1jKlmscpUC9d4nCaBfQY9Co+h6erSdsdiHhWHpr79
	u9zPE+u23D9ntdpfcq9cwnzAFnjuNY7J6b+SLaObzp/XVs8UO73stXQRmLCrvbwBrrwQ7ISj6VM
	4ZOwWMVCo9Ik2oP8sN+581ARmUTU7aGr5+6LzIg==
X-Google-Smtp-Source: AGHT+IFw5UzsVwCkEa5Ebt+OpMsZ0dn0dUQgqYd+DyDP8nNB43gw/+iUEP1XFjBVYRIVBuRvpISAOxzb+vrN5SvPklc=
X-Received: by 2002:a05:690c:d8e:b0:5e9:5538:d930 with SMTP id
 da14-20020a05690c0d8e00b005e95538d930mr5455648ywb.47.1706524668065; Mon, 29
 Jan 2024 02:37:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122124243.44002-5-brgl@bgdev.pl> <170627361652.398.12825437185563577604.tip-bot2@tip-bot2>
 <20240126210509.GA1212219@dev-arch.thelio-3990X> <CACMJSesVR_3-PBt1ScricSKNMRzH5gesqtTVW3mqN=gg0-O-7w@mail.gmail.com>
 <Zbd6LPDRFxCWZnqb@gmail.com>
In-Reply-To: <Zbd6LPDRFxCWZnqb@gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 29 Jan 2024 11:37:37 +0100
Message-ID: <CACMJSet0s+FqMDucvHi7x3Q6MSexUNH7_2eE8+g-gS=Z+CXVdw@mail.gmail.com>
Subject: Re: [tip: irq/core] genirq/irq_sim: Shrink code by using cleanup helpers
To: Ingo Molnar <mingo@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	linux-tip-commits@vger.kernel.org, maz@kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 11:13, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Bartosz Golaszewski <bartosz.golaszewski@linaro.org> wrote:
>
> > On Fri, 26 Jan 2024 at 22:05, Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > > Committer:     Thomas Gleixner <tglx@linutronix.de>
> > > > CommitterDate: Fri, 26 Jan 2024 13:44:48 +01:00
> > > >
> > > > genirq/irq_sim: Shrink code by using cleanup helpers
> > > >
> > > > Use the new __free() mechanism to remove all gotos and simplify the error
> > > > paths.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > > Link: https://lore.kernel.org/r/20240122124243.44002-5-brgl@bgdev.pl
> > > >
> > > > ---
> > > >  kernel/irq/irq_sim.c | 25 ++++++++++---------------
> > > >  1 file changed, 10 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> > > > index b0d50b4..fe8fd30 100644
> > > > --- a/kernel/irq/irq_sim.c
> > > > +++ b/kernel/irq/irq_sim.c
> > > > @@ -4,6 +4,7 @@
> > > >   * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >   */
> > > >
> > > > +#include <linux/cleanup.h>
> > > >  #include <linux/interrupt.h>
> > > >  #include <linux/irq.h>
> > > >  #include <linux/irq_sim.h>
> > > > @@ -163,33 +164,27 @@ static const struct irq_domain_ops irq_sim_domain_ops = {
> > > >  struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
> > > >                                        unsigned int num_irqs)
> > > >  {
> > > > -     struct irq_sim_work_ctx *work_ctx;
> > > > +     struct irq_sim_work_ctx *work_ctx __free(kfree) = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
> > > > +     unsigned long *pending;
> > > >
> > > > -     work_ctx = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
> > > >       if (!work_ctx)
> > > > -             goto err_out;
> > > > +             return ERR_PTR(-ENOMEM);
> > > >
> > > > -     work_ctx->pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
> > > > -     if (!work_ctx->pending)
> > > > -             goto err_free_work_ctx;
> > > > +     pending = __free(bitmap) = bitmap_zalloc(num_irqs, GFP_KERNEL);
> > >
> > > Apologies if this has already been reported elsewhere. This does not
> > > match what was sent and it causes the build to break with both GCC:
> > >
> >
> > I did not see any other report. I don't know what happened here but
> > this was a ninja edit as it's not what I sent. If Thomas' intention
> > was to move the variable declaration and detach it from the assignment
> > then 'pending' should at least be set to NULL and __free() must
> > decorate the declaration.
> >
> > But the coding style of declaring variables when they're first
> > assigned their auto-cleaned value is what Linus Torvalds explicitly
> > asked me to do when I first started sending PRs containing uses of
> > linux/cleanup.h.
>
> Ok - I've rebased tip:irq/core with the original patch.
>
> Do you have a reference to Linus's mail about C++ style definition
> of variables? I can see the validity of the pattern in this context,
> but it's explicitly against the kernel coding style AFAICS, which
> I suppose prompted Thomas's edit. I'd like to have an URL handy when the
> inevitable checkpatch 'fix' gets submitted. ;-)
>

Sure, here's one rant I was the target of:
https://lore.kernel.org/all/CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com/

Bartosz

