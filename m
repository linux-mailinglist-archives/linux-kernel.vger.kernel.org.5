Return-Path: <linux-kernel+bounces-12274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B56681F236
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B766C1C22677
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115AA481BB;
	Wed, 27 Dec 2023 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A0kTe/ge"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21388481B1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e7467eb93aso34539297b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 13:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703712567; x=1704317367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m7oxoJfsTMUP9iwmnTMSD6RQtzTxmt4yZyVBW24Hw70=;
        b=A0kTe/geseHObzVRa1x4hl96FH2oZTm8qPOcRLcrYkeOMEyg8Nc74L/vvhCrvYVWLS
         tBflfEP3dtAvpa2+0OBF9cr1AmlPXpt6ovL+sb7qwZxJ589ppByTagdGCIzjkYxzADuQ
         BvHIEgCu+kQLdNf15BQ9BvKqUUCOg6VKkHCx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703712567; x=1704317367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7oxoJfsTMUP9iwmnTMSD6RQtzTxmt4yZyVBW24Hw70=;
        b=WYhEesV60RDFWxVkFHowDWO75NPmhPjsSIwxwISXsRf/DHSJct+VOdlDXfI1Rfoyyw
         D+qbzzdLbnWqb0w8OIzW0eXDSiCWg/Dc+s7sbZf9Xn61KnHo9qoFTiEqQ/V9RwQDofMP
         v7UhOlAh1PWzpxojxJI/HEsM9vq8ZwjsQElhBuxxaZRHeDntZzqnxrPIyS84q9fNx6o2
         dcpaYpXTjyL6+84c9JMcw8qaa5lQPU9O6ymT8CVQuyrqmynzEu2FKu1qrWnN6BwePOOP
         tM4qv5B5PvG+OIEH+7hCNZSaMdk+eBESXtNE4GqULdsoIBxCc2yeRiW0wJj0s8/R7Wmr
         e3iA==
X-Gm-Message-State: AOJu0YxEyehbIzkZPiWBbeS1ZhH3A5NCL2w4/TfWnfYW+pTHLiwZZbDo
	hzT0TxYn99VfvxGMwd8aDG1dP2ZwA5S8Bsvq4jO1pAnnAe7zKnNDOuEZEhGojQ==
X-Google-Smtp-Source: AGHT+IHM6O2Ltk6OJKM1EuDk73I1Qwup3zWTsOzcOQ48Fb9Khu+LzhrvXXJA3vjtDJm/IZ2A1NJYfGfYQGsSn2lyOkU=
X-Received: by 2002:a05:690c:4606:b0:5ea:5340:fb0e with SMTP id
 gw6-20020a05690c460600b005ea5340fb0emr2233415ywb.4.1703712567158; Wed, 27 Dec
 2023 13:29:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid> <ZYxgQn8L7ENkc0AJ@smile.fi.intel.com>
In-Reply-To: <ZYxgQn8L7ENkc0AJ@smile.fi.intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Wed, 27 Dec 2023 14:29:16 -0700
Message-ID: <CANg-bXAN-DOZNsea7NNO4bFoZ6un44_upkseynS_dg5Odg6Whg@mail.gmail.com>
Subject: Re: [PATCH v3 24/24] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Raul Rangel <rrangel@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Bhanu Prakash Maiya <bhanumaiya@chromium.org>, 
	Chen-Yu Tsai <wenst@chromium.org>, Guenter Roeck <groeck@chromium.org>, Lee Jones <lee@kernel.org>, 
	Prashant Malani <pmalani@chromium.org>, Rob Barnes <robbarnes@google.com>, 
	Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> > -     irq = platform_get_irq_optional(pdev, 0);
> > -     if (irq > 0)
> > +     irq = platform_get_irq_resource_optional(pdev, 0, &irqres);
> > +     if (irq > 0) {
> >               ec_dev->irq = irq;
> > -     else if (irq != -ENXIO) {
> > +             if (should_force_irq_wake_capable())
> > +                     ec_dev->irq_wake = true;
> > +             else
> > +                     ec_dev->irq_wake = irqres.flags & IORESOURCE_IRQ_WAKECAPABLE;
> > +     } else if (irq != -ENXIO) {
> >               dev_err(dev, "couldn't retrieve IRQ number (%d)\n", irq);
> >               return irq;
> >       }
>
> Still I do not like ambiguity behind irq > 0 vs. irqres.start.
>
> For this, and if needed others, return plain error.
> Seems I gave the tag for the previous patch, consider
> that tag conditional (it seems I missed this).

What "others" do you mean? Modify platform_get_irq_resource_optional()
to return success/err? Or do you mean to modify all irq resource based
functions? of_irq_to_resource() already existed and returns the irq
number on success. Modifying it would mean updating all references to
it, in addition to modifying the fwnode abstraction layer (and its
references). I'm open to modifying
platform_get_irq_resource_optional(), but would like to avoid blowing
up this patch train any further.

> ...
>
> >       u16 proto_version;
> >       void *priv;
> >       int irq;
> > +     bool irq_wake;
> >       u8 *din;
> >       u8 *dout;
> >       int din_size;
> >       int dout_size;
> > -     bool wake_enabled;
> >       bool suspended;
> >       int (*cmd_xfer)(struct cros_ec_device *ec,
> >                       struct cros_ec_command *msg);
>
> Have you run pahole on this (before and after)?

Yes I did. The structure is not fully optimized, but this change keps
the overall size unchanged (328 bytes).

