Return-Path: <linux-kernel+bounces-16146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 445548239AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACECF1F24F6D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CB7652;
	Thu,  4 Jan 2024 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZpaJxDI8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFBB371
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e741123acso9116075e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 16:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704328175; x=1704932975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFX55NQWA+9lL7CtE2Bgpp65JEIghVU5OMsa8HjOyp8=;
        b=ZpaJxDI8SVeVzdenMGTQZ8ekZDGt0d910p7LdD9yFJPtNogw6pRiIuU3q56T4i8ZtC
         IWHWlgPyZaUgknwD1+/GtIKNFL+wIs3QPyfXc4hTDjsWzGUNLuji5kPbDej3CrnLROaP
         vGNq1vgAFP1xivFFzplloGo5x0M3cypGfGAgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704328175; x=1704932975;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFX55NQWA+9lL7CtE2Bgpp65JEIghVU5OMsa8HjOyp8=;
        b=W2AkhmV3GHnuma5h94vKYCKLcNMBNvQY8tklxte427RQSl9fi+X6WaQ1dU2jLiZKnT
         pyRqy09JJQr9f5tAl6wgIM0kGAGPvXgZlFEYj9Ds8csiFYN2GbzYlf5vxptbr3uZHlye
         WWeQg8ukO9g6sNdjkAWowqx1P/KIh3L6/Le3Ezh5nyEeIL/tsDkuw5PaXW6Wd+HswZmV
         j1EP2zQcorlmpfYIWX1BzVUdv/Yu8O0RXGFFq18tFBc9WSIVMpYaUfyP+ZNLYhHv3X2k
         eevBvXG/L6rqK8DLN6ttxgOq4h9EuQQMGnnQGfpVMAZXkU5upKkwNgRM4Bs/MMRB4GAC
         0GHQ==
X-Gm-Message-State: AOJu0YxyKfg3XWoLZOgwgXZ5N8UpvgX/WUHBEtl7/ZGBTx6KwVleToqr
	X8Nkq8V51jillRJzpUPPwvKT4W5TZkBE5JEwNtlaVbHq10ra
X-Google-Smtp-Source: AGHT+IHJJyzZPwDkfITirK0m6vyTs69alIHAu0jXzx5SlO3epP170om0Wn1HKVZuBB+QyfqhNlKJ61gulVRgzQQWO9Y=
X-Received: by 2002:a05:6512:3e24:b0:50e:6b5d:59fa with SMTP id
 i36-20020a0565123e2400b0050e6b5d59famr9614253lfv.4.1704328174770; Wed, 03 Jan
 2024 16:29:34 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jan 2024 16:29:34 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANg-bXDzLJgWLuH8Xj4GLYG=AVfcbmi_EfrA7DaHj4F6i350DA@mail.gmail.com>
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
 <CAE-0n50zkwZ8nguUJcL1gjbuavhSU_rLxfGhanxB4YA7N34hLQ@mail.gmail.com>
 <CANg-bXByhaSngW2AAG9h6DYHpiTUvh8+yw3LPU6ZQSCb62M-wg@mail.gmail.com>
 <CAE-0n52u68wMHJGe8=jz4Y1y2=voycFEY15keebz9tPDDBgiqA@mail.gmail.com> <CANg-bXDzLJgWLuH8Xj4GLYG=AVfcbmi_EfrA7DaHj4F6i350DA@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 3 Jan 2024 16:29:34 -0800
Message-ID: <CAE-0n52365_AYgjaXyV7+oB8WgaJVp5oCUzdsq7NquZsR08XXw@mail.gmail.com>
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

Quoting Mark Hasemeyer (2024-01-03 14:25:25)
> > The DTS patch would go through the platform maintainer tree and be
> > pulled into the soc tree and sent up to mainline from there. The
> > platform/chrome patch would go through chrome platform tree and then to
> > mainline. The bisection hole will be real.
>
> I thought it would all get merged in the next merge window. How are
> bifurcations like this normally dealt with? Does one wait for the
> first series of patches to land in mainline before submitting
> dependent patches? That could take two merge windows.

It's usually fine to land in the respective maintainer trees because the
driver is written to be compatible with either version of the DT.

>
> > >
> > > > Does using the pm wakeirq logic require the use of 'wakeup-source'
> > > > property in DT? A quick glance makes me believe it isn't needed, so
> > > > please split that part out of this patch as well.
> > >
> > > No, 'wakeup-source' is not required, it provides an indication to the
> > > driver that the IRQ should be used for wake, which then enables the pm
> > > subsystem accordingly. If 'wakup-source' is not used, we're back to
> > > square one of making assumptions. Specifically in this case, it would
> > > be assumed that all SPI based EC's are wake capable.
> >
> > Is that the wrong assumption to make? My understanding of the DT
> > property is that it is used to signal that this device should be treated
> > as a wakeup source, when otherwise it isn't treated as one. In this
> > case, the device has always been treated as a wakeup source so adding
> > the property is redundant.
>
> For SPI, it's not the wrong assumption. I was trying to drop the
> assumption though to match ACPI/LPC behavior.

Ok. Is the EC always a wakeup source? Not the EC irq, the EC device.

>
> > Making the patch series dependent on the
> > property being present makes the driver break without the DT change. We
> > try to make drivers work with older DT files, sometimes by adding
> > backwards compatibility code, so the presence of the wakeup-source
> > property should not be required to make this work.
>
> Do we have use cases where Chromebooks are running older DTBs? I get
> the idea in theory, but don't grasp why it's needed here.

It's to make the kernel bisectable while the DTB and driver patches are
merged through different trees.

> Regardless,
> I can update the SPI code to assume a wake capable IRQ. But I'd like
> to keep the prerequisite device tree patches unless there's a good
> reason to drop them. Specifying 'wake-source' certainly doesn't hurt
> anything, and there are other improvements to the OF
> subsystem/documentation.

I don't see any harm in having wakeup-source in the binding, but I'd
prefer it is behind a different compatible string as optional, and
introduced when we need to have an EC that doesn't wake up the system.
Otherwise it's all future coding for a device that doesn't exist. It's
also a potential landmine if the driver patch is backported somewhere
without the DTS patch (maybe the DTS is not upstream?). Someone will
have to debug why wakeups aren't working anymore.

>
> > What is the goal of this patch series? Is it to allow disabling the
> > wakeup capability of the EC wake irq from userspace? I can see a
> > possible problem where we want to disable wakeup for the EC dynamically
> > because either it has no child devices that are wakeup sources (e.g. no
> > power button, no keyboard on ARM) or userspace has disabled all the
> > wakeup sources for those child devices at runtime. In that case, we
> > would want to keep the EC irq from waking up the system from suspend. Is
> > that what you're doing here?
>
> The root of this patch series stems from a bug where spurious wakes
> are seen on Skyrim.

Are all 24 patches needed to fix spurious wakeups? Why can't we do a DMI
match table for Skyrim devices and disable the wakeirq logic on that
platform? That would be a much more focused and targeted fix, no?

> Copying some wording from the DTS patches:
> "Some Chromebooks use a separate wake pin, while others overload the
> interrupt for wake and IO. With the current assumption, spurious wakes
> can occur on systems that use a separate wake pin. It is planned to
> update the driver to no longer assume that the EC interrupt pin should
> be enabled for wake."
>
> This patch series will allow us to disable the ec_sync pin as a wake
> source on Skyrim as it already uses a dedicated wake gpio.

Aha! This last sentence is the detail I've been looking for. Please put
these details in the commit text.

"Skyrim devices are experiencing spurious wakeups due to the EC driver
always enabling the irq as a wakeup source but on Skyrim devices the EC
wakeup signal is a dedicated gpio separate from the irq."

Please be direct and specific instead of writing in general terms.

