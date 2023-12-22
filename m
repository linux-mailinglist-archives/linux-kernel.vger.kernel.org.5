Return-Path: <linux-kernel+bounces-10070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C598F81CF8F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07351C213F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCD42EAF5;
	Fri, 22 Dec 2023 21:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="frWj5maN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C742EAE1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5d226f51f71so22086287b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 13:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703281903; x=1703886703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NeI6c38cgpwlUN996udLFmgW+EctHzXbCAsfLYiPUqE=;
        b=frWj5maNQP1O6m8ekUzZyXjpDdNF8/8M1/llFa+KTj/ZBOYucfRjZCeOjUOp8MAWuz
         u69g2qcgaXtjiqNEPh8zLke8Qmw6LvcMFb2lQUHm8i1Bo+4535jnbXpMEPqLvQYDa5wH
         JmytbicvFsJ2Epru2JZoFC/SD+axhrebkSNzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703281903; x=1703886703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NeI6c38cgpwlUN996udLFmgW+EctHzXbCAsfLYiPUqE=;
        b=bCg4FSwKMQGmUs7ANbMAUuU844JtGLM6fHOoGMnJD4eB2EeGTt8BOU79Fr7Tz4HeRA
         vaebveSYTL7MoFqGx7aJrlnVnYTK804csBEPnryNswgsusXvANrt3bWWy7bvRSL+7mXB
         tq7F5LlMzx6oldS3sn6/O23vr4gJ26YRXX8SWVNGaHvV/Pf4BU/n5jeUlets6lypmdGu
         R8KmFdkTgb0woiVd6FV6BccUIgZegUV6jnj+E7kATFURpsHGcBMh74kjshpJlbiHk681
         fzpuFpNKTLMkGUFJbO3YuUfEiarZRKGMqxO1CPdgA2jFO/9mIwlRNBKs9PjuiIr8C2Xf
         cqog==
X-Gm-Message-State: AOJu0YxXQGgUoLDxCxOHEVnCfGjGbCT6QlEvvV7x6pVCqe8fkWA2w4FV
	K/A90uWwYn9DQhrqI9rdyQfRSL03isuErbJrfUkNZ29nG7HW
X-Google-Smtp-Source: AGHT+IHj3dEztmYYX8u+1byE/xGSG248QDUY0GB/Re/55iYfEHh1UIBA8cb+ucJJrF5IN4dMRbTFU2aAhtGUSB0QEII=
X-Received: by 2002:a81:a04e:0:b0:5d7:1940:dd7e with SMTP id
 x75-20020a81a04e000000b005d71940dd7emr1872300ywg.84.1703281903502; Fri, 22
 Dec 2023 13:51:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.21.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid> <ZYRawMwhtimA-rkD@smile.fi.intel.com>
In-Reply-To: <ZYRawMwhtimA-rkD@smile.fi.intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Fri, 22 Dec 2023 14:51:32 -0700
Message-ID: <CANg-bXA+kboBGVwqQrW+7zPGgwCwd-cTbnjy4213Lf4pKWpdLA@mail.gmail.com>
Subject: Re: [PATCH v2 21/22] platform: Modify platform_get_irq_optional() to
 use resource
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Raul Rangel <rrangel@chromium.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, David Gow <davidgow@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

> >   * For example::
> >   *
> > - *           int irq = platform_get_irq_optional(pdev, 0);
> > + *           int irq = platform_get_irq_resource_optional(pdev, 0, &res);
> >   *           if (irq < 0)
> >   *                   return irq;
> >   *
> >   * Return: non-zero IRQ number on success, negative error number on failure.
>
> Why do we need the irq to be returned via error code?

We don't really. It just matches the convention of
'platform_get_irq()' and 'of_irq_to_resource()'.

> >       int ret;
>
> Missing blank line, have you run checkpatch.pl?

Yes, I normally run checkpatch.pl. I may have missed the warning or it
didn't catch it. I'll add it.

>
> > +     if (IS_ERR_OR_NULL(r))
> > +             return -EINVAL;
>
> If we ever have an error pointer in r, I prefer to see
>
>         if (!r)
>                 return -EINVAL;
>         if (IS_ERR(r))
>                 return PTR_ERR(r);
>
> But Q is the same as earlier: when would we have the error pointer in @r?

I don't see when we would. I'll drop it.

> Can we save this and be consistent with above fwnode API return code check?
>
> > +                     ret = ret ?: r->start;
> >                       goto out;
> > +             }
> >       }

Yep!

