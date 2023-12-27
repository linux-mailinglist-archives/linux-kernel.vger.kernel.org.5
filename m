Return-Path: <linux-kernel+bounces-12248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD73E81F1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7D8282E35
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CE747F72;
	Wed, 27 Dec 2023 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bh1Qn2j2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148CE47F4D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5eb072c0b69so25836087b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 12:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703709967; x=1704314767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fVDgWJyq2vOmIjdOR8AJqO+EWu6/v9sa3TFBqXWfDD0=;
        b=Bh1Qn2j23YiFbcAtOLLtfFC05EtX8S9vc9G1g+aAjMtysKRaLtL+hMxsLUYixE00Os
         h6z0KKr6K+AjhGry6UswPFWITrGAU3PWkkKhVam5GJnvDg7d08Y3f/A3LG/omsMSUCVr
         WJr0+RHyDjSLVNmgNZZ8psgp0mVRVsCRkCh/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703709967; x=1704314767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVDgWJyq2vOmIjdOR8AJqO+EWu6/v9sa3TFBqXWfDD0=;
        b=wBNx96S3kMR4EzYxE8p4UD6UZ6ox+17nBlDhmY1jcNhVhC4mx46mBqzwVt8g3LC+ca
         /tmqNHkwzHc0IQEpiW8sDffYFe6eBXqw6leSgQyH+43EehBlGxWI4P60Qgf15b6Vfsb5
         VpwkohAyXWT96HP4uzFWlOsvYHRrSS62IT2k73Bv7+/eLDlSqijpQSVN/qM3QFI9GeUF
         iNFo1cgN0Tt8UGabM/m6NO3KpubAndNjLanDxRE9kO+ogyUwU0D9hhjmy897WonYQ/rq
         BFlDgDTH2dyzoq6nedKPqvqCXj8ABLdQ1SkXpg5k0hIpBB5WRYIcDFzsOP9GMtGOebln
         Ra+A==
X-Gm-Message-State: AOJu0YyGM3FRbNfSKJk8/pjWI1YI2QNth9zKif1YOcvCXsaU9vJkv3ew
	5LG43KjVhGlxLvTQGe/1JZboupPPVA6A7lnEQJgMDCsGB+0b
X-Google-Smtp-Source: AGHT+IEFqMT0cNiuNHYB4w/tWOWcrd94D2AcGcmnGOnqQ7+bMGPqypdIdUBb9fxsCLohmVCwiJXtBlug6m8t4Hajfgs=
X-Received: by 2002:a0d:ca4d:0:b0:5e7:a5c4:d9db with SMTP id
 m74-20020a0dca4d000000b005e7a5c4d9dbmr5847203ywd.51.1703709967172; Wed, 27
 Dec 2023 12:46:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid> <ZYvDshfJ-jnWNEY5@google.com>
In-Reply-To: <ZYvDshfJ-jnWNEY5@google.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Wed, 27 Dec 2023 13:45:56 -0700
Message-ID: <CANg-bXB0k-Z1PjAuW=vX3oR7T02g3z+d7ppdzfL-Cj7T+EQ6EA@mail.gmail.com>
Subject: Re: [PATCH v3 24/24] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Raul Rangel <rrangel@chromium.org>, 
	Benson Leung <bleung@chromium.org>, Bhanu Prakash Maiya <bhanumaiya@chromium.org>, 
	Chen-Yu Tsai <wenst@chromium.org>, Guenter Roeck <groeck@chromium.org>, Lee Jones <lee@kernel.org>, 
	Prashant Malani <pmalani@chromium.org>, Rob Barnes <robbarnes@google.com>, 
	Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> >       /* Retrieve GpioInt and translate it to Linux IRQ number */
> > -     ret = acpi_dev_gpio_irq_get(adev, 0);
> > +     ret = acpi_dev_get_gpio_irq_resource(adev, NULL, 0, &irqres);
> >       if (ret < 0)
> >               return ret;
> >
> > -     ec_uart->irq = ret;
> > -     dev_dbg(&ec_uart->serdev->dev, "IRQ number %d\n", ec_uart->irq);
> > +     ec_uart->irq = irqres.start;
>
> How about keep using `ret`?

The return value for 'acpi_dev_get_gpio_irq_resource' is different: 0
on success, negative errno on failure.

> > @@ -301,7 +306,14 @@ static int cros_ec_uart_probe(struct serdev_device *serdev)
> >
> >       serdev_device_set_client_ops(serdev, &cros_ec_uart_client_ops);
> >
> > -     return cros_ec_register(ec_dev);
> > +     /* Register a new cros_ec device */
> > +     ret = cros_ec_register(ec_dev);
> > +     if (ret) {
> > +             dev_err(dev, "Couldn't register ec_dev (%d)\n", ret);
> > +             return ret;
> > +     }
>
> It doesn't need the change after moving device_init_wakeup() and
> dev_pm_set_wake_irq() into cros_ec_register().
>
> Drop it?

Will do.

