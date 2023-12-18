Return-Path: <linux-kernel+bounces-4344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAC8817BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AF41C227F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F372069;
	Mon, 18 Dec 2023 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hBXG+ze1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F648784
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbcd0928530so2252012276.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702931026; x=1703535826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oAOApaxX5w4YPf3CxKGTBU9zqwQMevlp45gnxWR7mxI=;
        b=hBXG+ze1V89ncabPvpqxY0t6HBydcMjlWw5eFdEF9nhLGhQpv0PZyeUJxA1OCzpkQE
         1S8tHa5dwX5UIEUpZFidEKsfOtozas0Btzh0+7L9s5xkQjzAM57MJwKYhOBzUb9ZnzI2
         knCZKmOzBuf8rdjNlPdpzpHWszqOG2GAN+fKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702931026; x=1703535826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAOApaxX5w4YPf3CxKGTBU9zqwQMevlp45gnxWR7mxI=;
        b=AxbJF1Sy8vfRobE/tcZkO0dx3RLCVN0fR7doiTKPUI9Q2nKsgr0cXgOMoarlj0AYmv
         RvG9hpKk9F2GX8aC6OJ7DdZqNk4k4+pHGaUqtMFAqTS7STZVvb2KB+uVm32Tte1+PU3i
         0x1NUoCY7nar7iQsfPQJJL1lUTIjQBWXfHdJL8d01dIRJslnARDN/hyjsc98d8VPdXgs
         ebEJVnVBTrfK1pJFDlZLeXl2vMBLKwg5jFKC/GrjyKHgGfek7j9j7hjcIyorUfWeIxOO
         Rle/6A1BN6JiXk7WMHmjVDLXGsupep1hToisxkaQVXdWbmCQIqokPYyOBo6L9KSPHOuU
         qP+Q==
X-Gm-Message-State: AOJu0Yx7CZDrsOxUgN9kJkacY0nFnNX1r9Mmxhnr6X21WcvtZV3pmFgN
	HwVWQVGdPk4y3xeip5ZXuSu1ClraZARPJ1dS1lqJbw==
X-Google-Smtp-Source: AGHT+IEt+RsWEZ0k7WD2yW2V6+Up28F0kW4UcAIX18iSq4Dw4Lz05Dv0gWQZMVDKPxQ//asJmbcwMtAQyj1thOJEGj8=
X-Received: by 2002:a25:9e11:0:b0:dbc:bff8:5228 with SMTP id
 m17-20020a259e11000000b00dbcbff85228mr5798639ybq.31.1702931025970; Mon, 18
 Dec 2023 12:23:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <20231213110009.v1.5.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid> <ZXoLbt7jNrmC0VbQ@smile.fi.intel.com>
In-Reply-To: <ZXoLbt7jNrmC0VbQ@smile.fi.intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Mon, 18 Dec 2023 13:23:35 -0700
Message-ID: <CANg-bXDUxMvm2tmHZVz4Mh=o3VMmO2ZTT2547RZEcwDkn2FUeQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] platform: Modify platform_get_irq_optional() to
 use resource
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Raul Rangel <rrangel@chromium.org>, 
	David Gow <davidgow@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

> > +             *r = (struct resource)DEFINE_RES_IRQ(ret);
>
> Why is the annotation needed?

It's not needed anymore. I'll remove it.

> > -     struct resource *r;
> > +     struct resource *platform_res;
> >
> >       if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
> > -             ret = of_irq_get(dev->dev.of_node, num);
> > +             ret = of_irq_to_resource(dev->dev.of_node, num, r);
> >               if (ret > 0 || ret == -EPROBE_DEFER)
> >                       goto out;
> >       }
>
>
> > +     if (has_acpi_companion(&dev->dev)) {
> > +             ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
> > +             if (!ret || ret == -EPROBE_DEFER) {
> > +                     ret = ret ?: r->start;
> > +                     goto out;
> > +             }
> > +     }
>
> Consider combine the above to use fwnode_irq_get() in the separate prerequisite
> change.

I like the idea. It doesn't look like 'struct fwnode_operations'
provides a way to retrieve information in a 'struct resource' format.
Perhaps this could be followed up on in a separate patch train?

>
> > +                     irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
>
> NIH resource_type().
>
> > +     }
> >       return ret;

Does NIH mean "not invented here"? resource_type() masks
IORESOURCE_TYPE_BITS, not IORESOURCE_BITS. I'm not quite sure what you
mean here.

