Return-Path: <linux-kernel+bounces-15995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F928236C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB9F1B23D2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08331D54C;
	Wed,  3 Jan 2024 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NhwSuw62"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668B11D544
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50eaabc36bcso360578e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704314814; x=1704919614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2SUiPUpfXbQPYtDppv003Wo/zS4sUJe1O0Ol3kkYD0=;
        b=NhwSuw62FhEXHYrNO1ZLn10qyW8PVyS1dZP9otYWyo3f4ivOkyoGZv6wu4Quavwve2
         yi633nze2jKtibpd3HXcJKHRxYu7//qlGSbFkbH7z467ALy1w3J6L+7l9GY8K/5P538p
         nuzrzH+PlkkKr6PJjoU0OdVAoDHrvLqPvmsmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704314814; x=1704919614;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2SUiPUpfXbQPYtDppv003Wo/zS4sUJe1O0Ol3kkYD0=;
        b=qDq/VkY5BZq3yTwrCHAibIM0Lt1hpqYZNZuTzRb4KubALuVN6dG1p276dKRuR43ZQt
         uWT6XyzSAG4S13wbmvZ/Fi5oTsBNOnkaDEut/6Dk9hwOmNyrSVY2oEgADUi+MAQp2mIN
         AVWeKAzoBl80maKn0dr25VTglpJiyrPQBCzp2Dt7mqrC2oGmidis8OqU/a3u/P5GoxtM
         WRg6Sdus4KRqm+vN7KWLZoltxOWl1APYsCZ5gNlpBnSmuq81IA00ZJ/qcG1d/T6pc+Tf
         J5SZaa+Gpm4FHTDfpeabtaZ+tyEZ+xgFMIMIJlItv9CUTzE5909ZlIWlJOKyiV4UOzzB
         MbJg==
X-Gm-Message-State: AOJu0Yw4pjPD4Cl2eXDtOqSF51AqN14IkjVLiu7kljbq9dvDQEoGKIi2
	pEBHUvomsAFbAyqSHw20Bt5gWVmR0qrnaTOhVdc1IIRwG6k0
X-Google-Smtp-Source: AGHT+IEL6YpyRWxiJB56Mj1G9vUivs9gzJmo9hJG/jxYWzbu1KA4cDO7v518BLcEFVFbtTR0lx3OBDOH5vNxQKfgvOg=
X-Received: by 2002:a05:6512:e84:b0:50e:7b2c:6818 with SMTP id
 bi4-20020a0565120e8400b0050e7b2c6818mr9757087lfb.26.1704314814405; Wed, 03
 Jan 2024 12:46:54 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jan 2024 12:46:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANg-bXByhaSngW2AAG9h6DYHpiTUvh8+yw3LPU6ZQSCb62M-wg@mail.gmail.com>
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
 <CAE-0n50zkwZ8nguUJcL1gjbuavhSU_rLxfGhanxB4YA7N34hLQ@mail.gmail.com> <CANg-bXByhaSngW2AAG9h6DYHpiTUvh8+yw3LPU6ZQSCb62M-wg@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 3 Jan 2024 12:46:53 -0800
Message-ID: <CAE-0n52u68wMHJGe8=jz4Y1y2=voycFEY15keebz9tPDDBgiqA@mail.gmail.com>
Subject: Re: [PATCH v4 24/24] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
To: Mark Hasemeyer <markhas@chromium.org>
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

Quoting Mark Hasemeyer (2024-01-03 09:47:17)
> > The DMI quirk looks to be fixing something. Most likely that should be
> > backported to stable kernels as well? Please split the DMI match table
> > part out of this so that it isn't mixed together with migrating the
> > driver to use the pm wakeirq logic.
>
> The DMI quirk is used to list boards whose IRQ should be enabled for
> wake, regardless of what their firmware says. Currently the driver
> always enables the EC IRQ for wake anyway, so there shouldn't be a
> need to backport the DMI quirk on its own. Splitting out the DMI quirk
> into its own patch would break Brya/Brask's ability to wake if they
> were to run a kernel w/o the DMI patch. I chose not to split it out to
> keep the change atomic, and avoid introducing any regressions.

Ok, thanks for clarifying. I understand now that it is to workaround the
firmware on those boards where the driver didn't care before.

>
> > > For device tree base systems, it is not an issue as the relevant device
> > > tree entries have been updated and DTS is built from source for each
> > > ChromeOS update.
> >
> > It is still sorta an issue. It means that we can't backport this patch
> > without also backporting the DTS patch to the kernel. Furthermore, DTS
> > changes go through different maintainer trees, so having this patch in
> > the kernel without the DTS patch means the bisection hole is possibly
> > quite large.
>
> Correct, this patch doesn't make sense to backport on its own. It is
> dependent on the entire patch series (more than just the DTS changes).
> I'm not super familiar with how patches flow through different
> maintainer trees. But I'd imagine this patch series makes its way to
> torvalds/master in some sort of sane manner where earlier patches land
> before later (dependent) ones?

The DTS patch would go through the platform maintainer tree and be
pulled into the soc tree and sent up to mainline from there. The
platform/chrome patch would go through chrome platform tree and then to
mainline. The bisection hole will be real.

>
> > Does using the pm wakeirq logic require the use of 'wakeup-source'
> > property in DT? A quick glance makes me believe it isn't needed, so
> > please split that part out of this patch as well.
>
> No, 'wakeup-source' is not required, it provides an indication to the
> driver that the IRQ should be used for wake, which then enables the pm
> subsystem accordingly. If 'wakup-source' is not used, we're back to
> square one of making assumptions. Specifically in this case, it would
> be assumed that all SPI based EC's are wake capable.

Is that the wrong assumption to make? My understanding of the DT
property is that it is used to signal that this device should be treated
as a wakeup source, when otherwise it isn't treated as one. In this
case, the device has always been treated as a wakeup source so adding
the property is redundant. Making the patch series dependent on the
property being present makes the driver break without the DT change. We
try to make drivers work with older DT files, sometimes by adding
backwards compatibility code, so the presence of the wakeup-source
property should not be required to make this work.

>
> > We should see a patch
> > for the DMI quirk, a patch to use wakeup-source (doubtful that we need
> > it at all though), and a patch to use the pm wakeirq logic instead of
> > hand rolling it again.
>
> I don't know if I'm convinced this should happen. I'm open to it, but
> see my previous comments.
>
> > >                 ec_spi->end_of_msg_delay = val;
> > > +
> > > +       ec_spi->irq_wake = spi->irq > 0 && of_property_present(np, "wakeup-source");
> >
> > Is there any EC SPI device that doesn't want to support wakeup?
>
> I don't know for sure. If so, the EC driver doesn't currently support
> it because it assumes wake capability.
>
> > I'd
> > prefer we introduce a new property or compatible string to indicate that
> > wakeup isn't supported and otherwise always set irq_wake to true. That
> > way DT can change in parallel with the driver instead of in lockstep.
>
> We could introduce a custom binding? IMHO, using inverted logic like
> that kind of goes against the grain with how ACPI and kernel are
> currently structured. And I don't love how it would make the SPI EC
> driver inverted from the other interfaces. I'd rather go back to just
> assuming all SPI based EC's are wake capable. But even then, why
> assume? This gives us flexibility to disable wakeirqs and drops
> unnecessary assumptions. It also lays the groundwork for new boards
> that may behave differently. For example, an ACPI based SPI EC.

What is the goal of this patch series? Is it to allow disabling the
wakeup capability of the EC wake irq from userspace? I can see a
possible problem where we want to disable wakeup for the EC dynamically
because either it has no child devices that are wakeup sources (e.g. no
power button, no keyboard on ARM) or userspace has disabled all the
wakeup sources for those child devices at runtime. In that case, we
would want to keep the EC irq from waking up the system from suspend. Is
that what you're doing here?

