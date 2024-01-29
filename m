Return-Path: <linux-kernel+bounces-42522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A409084028E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B801282DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A8E55E79;
	Mon, 29 Jan 2024 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9t3ppjR"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D825755E58;
	Mon, 29 Jan 2024 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523187; cv=none; b=GZKKb2qRu7XkiSqKTVQ5/3c2uFutmCl4bSBWKQ0tiUzRvWvvgBsGltR/3rceBxHdRPS+gqgHlbx4wZT4VrYeDG9KfhuiNabrhLaooivyStQLthbbe3rAU1z1iVTWdmEIdrzkmW5ByTyW8yKrykUMGC68th7w19xXwbNOvGwtkqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523187; c=relaxed/simple;
	bh=WdAQ1iY1kSuqBeRtoPKV93JSO2bOz2pmnfZ8DWSSTUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVY3LXOVw3tIJmjcWUHxCJlXxRZCaBBkPzUWbNV5rcHMExyTiOzdOQ2OPNUnIkB4RmupvTsthosVx3j8AKlZmA7UIbwTWjJiPrPkFtET3/OmVSBmxHRr5CkqZ+IujOysRSTN66JY5k0ToREssR1YfObKlpM35XLauklSLBCsRF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9t3ppjR; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51111e57a66so494848e87.3;
        Mon, 29 Jan 2024 02:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706523184; x=1707127984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVJamU9bQQ6+0WvzoygEwXeYOPfoMRXxP8XdjaJOfHo=;
        b=m9t3ppjRB0kHW+l3uStsuHANdDD9h4VL5w98xGPg4hwjGt1dEv4GLjdhTeYzfulmyB
         wGqYs9ZNhJf0U6ZMWOQouuIwvHnuzAG6v7x3h20wI/8bW/ZQw939o8vGgNMgD6JwHm/X
         0kA/36OTuF0gWybyolwU/wAuKfbrm7jvOu04GvyIVB0QuViSYIDf+u8Zqq4nhgiyO392
         /norghjRbNqpn0TiQFzr4C2wIHSnMvcVX82QEFo4Y28f663SdJuc5jPtSzJEVJSeaNt4
         QlBZucuA6zxMCLq6e3ru7deiWG66KM3nrcbgRfaMAX2aK40OnBdjJULMV/FX3vTgpa7T
         jE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706523184; x=1707127984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVJamU9bQQ6+0WvzoygEwXeYOPfoMRXxP8XdjaJOfHo=;
        b=mz8RPuk7KIW76r+7nho1HflJPls8Wc6HjzkbYXF1clMyjHOYYaFw4QRIFFvwFPj6Tu
         aO4ffW7gr3SKAwMcgYIOvtPty4wN+XWqvSkpGEWnCCsGhGZx8COqhaqmn7zMv2U5ivhu
         0waEox1F4RJVHrlZZush7KURrh8CmNOU5CToRro+YHIvrfxflFHEuLByuKNs6Tfwuni5
         p2BvQAPsAFSzU8lk5i+ZR03O47Ed7VyBvPF52sC2CHbywcSRbEJ3wk1MN8CTEmfwQYMx
         AvCwFM8flab9CiJA4+K2Clx9mqufeJ96aQIOnUcKzs8V6YV2wbFm9ikkx3uUJ86fs43y
         V/aQ==
X-Gm-Message-State: AOJu0Yx4NjE/rRWVIxSj/zbX5JqAZJVsrtJajIilHb/4aoPrsP99bJps
	T2wSq0FktKrFkCHy1ZWpQQSODoenxDvcSZx0GSnavuz7gH9J/gbaIAneXJNz3fI=
X-Google-Smtp-Source: AGHT+IFdEjHXLJVvIW+SMdTG2Eh3PVnYf4vY4vPdSfQP8hn7Xfuy1u2k7j1ZD2SMQdMEOw7vzHJ5Ww==
X-Received: by 2002:a05:6512:201c:b0:50e:ca2a:50f8 with SMTP id a28-20020a056512201c00b0050eca2a50f8mr3093547lfb.63.1706523183529;
        Mon, 29 Jan 2024 02:13:03 -0800 (PST)
Received: from gmail.com (1F2EF327.nat.pool.telekom.hu. [31.46.243.39])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b0040e54f15d3dsm13686429wmb.31.2024.01.29.02.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:13:02 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 29 Jan 2024 11:13:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	linux-tip-commits@vger.kernel.org, maz@kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [tip: irq/core] genirq/irq_sim: Shrink code by using cleanup
 helpers
Message-ID: <Zbd6LPDRFxCWZnqb@gmail.com>
References: <20240122124243.44002-5-brgl@bgdev.pl>
 <170627361652.398.12825437185563577604.tip-bot2@tip-bot2>
 <20240126210509.GA1212219@dev-arch.thelio-3990X>
 <CACMJSesVR_3-PBt1ScricSKNMRzH5gesqtTVW3mqN=gg0-O-7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACMJSesVR_3-PBt1ScricSKNMRzH5gesqtTVW3mqN=gg0-O-7w@mail.gmail.com>


* Bartosz Golaszewski <bartosz.golaszewski@linaro.org> wrote:

> On Fri, 26 Jan 2024 at 22:05, Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > > Committer:     Thomas Gleixner <tglx@linutronix.de>
> > > CommitterDate: Fri, 26 Jan 2024 13:44:48 +01:00
> > >
> > > genirq/irq_sim: Shrink code by using cleanup helpers
> > >
> > > Use the new __free() mechanism to remove all gotos and simplify the error
> > > paths.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Link: https://lore.kernel.org/r/20240122124243.44002-5-brgl@bgdev.pl
> > >
> > > ---
> > >  kernel/irq/irq_sim.c | 25 ++++++++++---------------
> > >  1 file changed, 10 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> > > index b0d50b4..fe8fd30 100644
> > > --- a/kernel/irq/irq_sim.c
> > > +++ b/kernel/irq/irq_sim.c
> > > @@ -4,6 +4,7 @@
> > >   * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >   */
> > >
> > > +#include <linux/cleanup.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/irq.h>
> > >  #include <linux/irq_sim.h>
> > > @@ -163,33 +164,27 @@ static const struct irq_domain_ops irq_sim_domain_ops = {
> > >  struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
> > >                                        unsigned int num_irqs)
> > >  {
> > > -     struct irq_sim_work_ctx *work_ctx;
> > > +     struct irq_sim_work_ctx *work_ctx __free(kfree) = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
> > > +     unsigned long *pending;
> > >
> > > -     work_ctx = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
> > >       if (!work_ctx)
> > > -             goto err_out;
> > > +             return ERR_PTR(-ENOMEM);
> > >
> > > -     work_ctx->pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
> > > -     if (!work_ctx->pending)
> > > -             goto err_free_work_ctx;
> > > +     pending = __free(bitmap) = bitmap_zalloc(num_irqs, GFP_KERNEL);
> >
> > Apologies if this has already been reported elsewhere. This does not
> > match what was sent and it causes the build to break with both GCC:
> >
> 
> I did not see any other report. I don't know what happened here but
> this was a ninja edit as it's not what I sent. If Thomas' intention
> was to move the variable declaration and detach it from the assignment
> then 'pending' should at least be set to NULL and __free() must
> decorate the declaration.
> 
> But the coding style of declaring variables when they're first
> assigned their auto-cleaned value is what Linus Torvalds explicitly
> asked me to do when I first started sending PRs containing uses of
> linux/cleanup.h.

Ok - I've rebased tip:irq/core with the original patch.

Do you have a reference to Linus's mail about C++ style definition
of variables? I can see the validity of the pattern in this context,
but it's explicitly against the kernel coding style AFAICS, which
I suppose prompted Thomas's edit. I'd like to have an URL handy when the
inevitable checkpatch 'fix' gets submitted. ;-)

Thanks,

	Ingo

