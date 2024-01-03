Return-Path: <linux-kernel+bounces-15817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B938233BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D591C23C1C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5850A1C680;
	Wed,  3 Jan 2024 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a/Irkqzf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C71C296
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbdb8e032f7so549202276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 09:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704304048; x=1704908848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RVBLFxuGTc+CJdWVVnYhZKqmQ6RkuH4h4mf4hp3TRsc=;
        b=a/IrkqzfLHVdMZNSK6JFSEqeiM0Tc8JeBQWkaIFxl018a4KoDfKqndVPYh/mThnUJg
         bXIglnlrvqO0ZoLOXMyM2BIS2fHYTziXLbmimANhv6sMoS2nomnPsqKViiA8v/dgGW5M
         6IJgG5tPXtCv67cEp1I3e4qRyZifXpleDKSd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704304048; x=1704908848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVBLFxuGTc+CJdWVVnYhZKqmQ6RkuH4h4mf4hp3TRsc=;
        b=FTJDsv13ZBrgzCiWd24vvQSZzyc6DADPNWKMK0BPnkD+svCDdJDIuqsgznPyXsmG42
         muC6PNZt6Mq30+fkJGFRSAwb9cDBGmi4L6hnUI/RTQbO276w2uEJyup3DnTLf9HTcJTl
         2vk4FiTrYrOCpAfxbayvFYqiJNcdeTRw1JO57DzELasq7fWNlxmdB+2LenbxhYoFLw8N
         QSnvSrVkJYIgDBu2a+bhWVV43fNqb20GiJ5BxfEbR+qjS3ShVbBxJBHgjQxDMwlG1yby
         +3Vy5jZ7MywgHmlYiQyd9P2lUSGLG/JNs/qR/rA/se+RJ18IZ8pMA5lZacRDdRRsxQLk
         4E5g==
X-Gm-Message-State: AOJu0Yz2puPvpUCthvcJwNXTyT7hkNqyBAWStgjRzXvmr1W7eqFJ2s9A
	Kzy/FU1M0NgwDugjqg+Horw6seGhPH9pjoDEjHb1HIIv3VJ4
X-Google-Smtp-Source: AGHT+IFRuIbKnoz7RMdbYdyxgvgzIsiQXh8vVqlgSECP6teJxilGE94r+rf+Sktx73a1K2m11pLoxUEDXJHiLml5GfY=
X-Received: by 2002:a25:8c91:0:b0:dbd:43:3e43 with SMTP id m17-20020a258c91000000b00dbd00433e43mr848903ybl.42.1704304048063;
 Wed, 03 Jan 2024 09:47:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid> <CAE-0n50zkwZ8nguUJcL1gjbuavhSU_rLxfGhanxB4YA7N34hLQ@mail.gmail.com>
In-Reply-To: <CAE-0n50zkwZ8nguUJcL1gjbuavhSU_rLxfGhanxB4YA7N34hLQ@mail.gmail.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Wed, 3 Jan 2024 10:47:17 -0700
Message-ID: <CANg-bXByhaSngW2AAG9h6DYHpiTUvh8+yw3LPU6ZQSCb62M-wg@mail.gmail.com>
Subject: Re: [PATCH v4 24/24] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
To: Stephen Boyd <swboyd@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Raul Rangel <rrangel@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Bhanu Prakash Maiya <bhanumaiya@chromium.org>, 
	Chen-Yu Tsai <wenst@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Prashant Malani <pmalani@chromium.org>, Rob Barnes <robbarnes@google.com>, 
	chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> The DMI quirk looks to be fixing something. Most likely that should be
> backported to stable kernels as well? Please split the DMI match table
> part out of this so that it isn't mixed together with migrating the
> driver to use the pm wakeirq logic.

The DMI quirk is used to list boards whose IRQ should be enabled for
wake, regardless of what their firmware says. Currently the driver
always enables the EC IRQ for wake anyway, so there shouldn't be a
need to backport the DMI quirk on its own. Splitting out the DMI quirk
into its own patch would break Brya/Brask's ability to wake if they
were to run a kernel w/o the DMI patch. I chose not to split it out to
keep the change atomic, and avoid introducing any regressions.

> > For device tree base systems, it is not an issue as the relevant device
> > tree entries have been updated and DTS is built from source for each
> > ChromeOS update.
>
> It is still sorta an issue. It means that we can't backport this patch
> without also backporting the DTS patch to the kernel. Furthermore, DTS
> changes go through different maintainer trees, so having this patch in
> the kernel without the DTS patch means the bisection hole is possibly
> quite large.

Correct, this patch doesn't make sense to backport on its own. It is
dependent on the entire patch series (more than just the DTS changes).
I'm not super familiar with how patches flow through different
maintainer trees. But I'd imagine this patch series makes its way to
torvalds/master in some sort of sane manner where earlier patches land
before later (dependent) ones?

> Does using the pm wakeirq logic require the use of 'wakeup-source'
> property in DT? A quick glance makes me believe it isn't needed, so
> please split that part out of this patch as well.

No, 'wakeup-source' is not required, it provides an indication to the
driver that the IRQ should be used for wake, which then enables the pm
subsystem accordingly. If 'wakup-source' is not used, we're back to
square one of making assumptions. Specifically in this case, it would
be assumed that all SPI based EC's are wake capable.

> We should see a patch
> for the DMI quirk, a patch to use wakeup-source (doubtful that we need
> it at all though), and a patch to use the pm wakeirq logic instead of
> hand rolling it again.

I don't know if I'm convinced this should happen. I'm open to it, but
see my previous comments.

> > +static int enable_irq_for_wake(struct cros_ec_device *ec_dev)
> > +{
> > +       struct device *dev = ec_dev->dev;
> > +       int ret = device_init_wakeup(dev, true);
> > +
> > +       if (ret) {
> > +               dev_err(dev, "Failed to enable device for wakeup");
>
> Missing newline on printk message.

Ack.

>
> > +               return ret;
> > +       }
> > +       ret = dev_pm_set_wake_irq(dev, ec_dev->irq);
> > +       if (ret)
> > +               device_init_wakeup(dev, false);
> > +
> > +       return ret;
>
> I'd rather see the code formatted like this:
>
>         int ret;
>
>         ret = device_init_wakeup(dev, true);
>         if (ret) {
>                 dev_err(...);
>                 return ret;
>         }
>
>         ret = dev_pm_set_wake_irq(...);
>         if (ret)
>                 device_init_wakeup(dev, false);
>
>         return ret;
>
> Mostly because the first 'if (ret)' requires me to hunt in the variable
> declaration part of the function to figure out what it is set to instead
> of looking at the line directly above.

Sounds good :-)


> [...]
> > diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> >  struct cros_ec_spi {
> >         struct spi_device *spi;
> > @@ -77,6 +79,7 @@ struct cros_ec_spi {
> >         unsigned int start_of_msg_delay;
> >         unsigned int end_of_msg_delay;
> >         struct kthread_worker *high_pri_worker;
> > +       bool irq_wake;
>
> This is only used in probe. Make it a local variable instead of another
> struct member to save memory.

Ack.

>
> >  };
> >
> >  typedef int (*cros_ec_xfer_fn_t) (struct cros_ec_device *ec_dev,
> > @@ -689,9 +692,10 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
> >         return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_cmd_xfer_spi);
> >  }
> >
> > -static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
> > +static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi)
> >  {
> > -       struct device_node *np = dev->of_node;
> > +       struct spi_device *spi = ec_spi->spi;
> > +       struct device_node *np = spi->dev.of_node;
> >         u32 val;
> >         int ret;
> >
> > @@ -702,6 +706,8 @@ static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
> >         ret = of_property_read_u32(np, "google,cros-ec-spi-msg-delay", &val);
> >         if (!ret)
> >                 ec_spi->end_of_msg_delay = val;
> > +
> > +       ec_spi->irq_wake = spi->irq > 0 && of_property_present(np, "wakeup-source");
>
> Is there any EC SPI device that doesn't want to support wakeup?

I don't know for sure. If so, the EC driver doesn't currently support
it because it assumes wake capability.

> I'd
> prefer we introduce a new property or compatible string to indicate that
> wakeup isn't supported and otherwise always set irq_wake to true. That
> way DT can change in parallel with the driver instead of in lockstep.

We could introduce a custom binding? IMHO, using inverted logic like
that kind of goes against the grain with how ACPI and kernel are
currently structured. And I don't love how it would make the SPI EC
driver inverted from the other interfaces. I'd rather go back to just
assuming all SPI based EC's are wake capable. But even then, why
assume? This gives us flexibility to disable wakeirqs and drops
unnecessary assumptions. It also lays the groundwork for new boards
that may behave differently. For example, an ACPI based SPI EC.

