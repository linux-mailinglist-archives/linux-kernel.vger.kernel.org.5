Return-Path: <linux-kernel+bounces-20004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2F382781D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5191F2370E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C1954F83;
	Mon,  8 Jan 2024 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JYU751VI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2229054F86
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso2095923e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704740852; x=1705345652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=We+XtMZMnhJFuy/p3AKTQ8zg8vFcYw6TH96BXfabyL8=;
        b=JYU751VIn5PDVLDT3sK7O8pNGfZtZ5nozSM3Ovd1TMZj/2efjLgzGVK7RrPuJ4xdxP
         Ci6uLBN0qladaRGnzbNHZE329fSK9y53yYdA2zYFdrMD0B9ScO+YfUwTpaHnVqsD/K9j
         AlmCjyqU1wYHraqexsCNxLljmkgblHTHNTyig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704740852; x=1705345652;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=We+XtMZMnhJFuy/p3AKTQ8zg8vFcYw6TH96BXfabyL8=;
        b=vOw5jjAAFjXuru8IJ/XdYHEELinvFtwz4qwfg728B62VCcs1mxKoVH4BmECpSAHRnT
         zy9pOTvPljm2rlJ1iRq2nEklfkniJdQCMcOf+67Q4Osqn7n95nen/kYqm/LE2GjA7Oez
         kt65KX5el2ZTKODLRFyv3cnJz1nG0080sq3O1N4ZrjuRcOJM0qBGHLpmJkWYUrCXBpR/
         3aKxGN1NjgjXK3Vpmx3vf4oCBlMQDJxMvjTblrKWBsvdlfeopSuRoUMgMrFgwhiJa367
         a4+gRlnyKhGj9XPlLLTBt9A8wOfefXUQtHm/7P9GgPJ/9k4At0QDRK+CEdsPslpBWUmy
         q/0w==
X-Gm-Message-State: AOJu0Yy2pN4uB7JhDsJ0p2lViGemxy9o0JusfarEG/49RSGRvv+nIfka
	NXIlMYzTUux1lXSo4L12QHMJGj5PghwNeaNU+OAOJbzOWk4Z
X-Google-Smtp-Source: AGHT+IE6K+PJmc05Cj2mfH6Z0awrQ5vPUI8t9ls4UXkSW1jFYmXRo/oPc5DYPkXg/yMzj1tghV81uta6x1BjWADCF2w=
X-Received: by 2002:a05:6512:3d15:b0:50e:7cbe:cf36 with SMTP id
 d21-20020a0565123d1500b0050e7cbecf36mr1203074lfv.40.1704740851950; Mon, 08
 Jan 2024 11:07:31 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jan 2024 11:07:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANg-bXAVm01qoGUL2hUN9=3eK5o6c6BKtTUL82WiLL8cxFeaLA@mail.gmail.com>
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
 <CAE-0n50zkwZ8nguUJcL1gjbuavhSU_rLxfGhanxB4YA7N34hLQ@mail.gmail.com>
 <CANg-bXByhaSngW2AAG9h6DYHpiTUvh8+yw3LPU6ZQSCb62M-wg@mail.gmail.com>
 <CAE-0n52u68wMHJGe8=jz4Y1y2=voycFEY15keebz9tPDDBgiqA@mail.gmail.com>
 <CANg-bXDzLJgWLuH8Xj4GLYG=AVfcbmi_EfrA7DaHj4F6i350DA@mail.gmail.com>
 <CAE-0n52365_AYgjaXyV7+oB8WgaJVp5oCUzdsq7NquZsR08XXw@mail.gmail.com> <CANg-bXAVm01qoGUL2hUN9=3eK5o6c6BKtTUL82WiLL8cxFeaLA@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 8 Jan 2024 11:07:31 -0800
Message-ID: <CAE-0n50nNXSybfAnOgAk4g8hOma7=yLG8+y9PpHaXXSUE-zfsw@mail.gmail.com>
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

Quoting Mark Hasemeyer (2024-01-03 20:55:41)
> > > > > > Does using the pm wakeirq logic require the use of 'wakeup-source'
> > > > > > property in DT? A quick glance makes me believe it isn't needed, so
> > > > > > please split that part out of this patch as well.
> > > > >
> > > > > No, 'wakeup-source' is not required, it provides an indication to the
> > > > > driver that the IRQ should be used for wake, which then enables the pm
> > > > > subsystem accordingly. If 'wakup-source' is not used, we're back to
> > > > > square one of making assumptions. Specifically in this case, it would
> > > > > be assumed that all SPI based EC's are wake capable.
> > > >
> > > > Is that the wrong assumption to make? My understanding of the DT
> > > > property is that it is used to signal that this device should be treated
> > > > as a wakeup source, when otherwise it isn't treated as one. In this
> > > > case, the device has always been treated as a wakeup source so adding
> > > > the property is redundant.
> > >
> > > For SPI, it's not the wrong assumption. I was trying to drop the
> > > assumption though to match ACPI/LPC behavior.
> >
> > Ok. Is the EC always a wakeup source? Not the EC irq, the EC device.
>
> Yes. The powerd daemon enables the EC for wake [1]. At least on ACPI systems.
> [1] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/81b23aeac510655f27e1d87b99b12c78146e7c37:src/platform2/power_manager/powerd/daemon.cc;l=611
>
> > > Regardless,
> > > I can update the SPI code to assume a wake capable IRQ. But I'd like
> > > to keep the prerequisite device tree patches unless there's a good
> > > reason to drop them. Specifying 'wake-source' certainly doesn't hurt
> > > anything, and there are other improvements to the OF
> > > subsystem/documentation.
> >
> > I don't see any harm in having wakeup-source in the binding, but I'd
> > prefer it is behind a different compatible string as optional, and
> > introduced when we need to have an EC that doesn't wake up the system.
>
> The 'wakeup-source' property is already optional. See patch 04 in this
> version of the series which updates the documentation surrounding the
> property. Or are you suggesting a completely new string so that we can
> be forever backward compatible? If that's the case, the property would
> indeed have to have inverted logic signifying a device that is *not*
> wakeup capable. It feels wrong to have to do something like that.

Isn't this patch series making the wakeup-source DT property required
for all existing DT nodes? I'm saying that the property is implicit
based on the compatible string "google,cros-ec-{spi,rpmsg,uart}", so
we shouldn't add the property explicitly. Just rely on the compatible
string to convey the property's existence.

>
> > Otherwise it's all future coding for a device that doesn't exist.
>
> I agree adding 'wakeup-source' is future coding for a device that
> doesn't exist. It does provide (pseudo) feature parity with ACPI
> systems though. See my comment below about ACPI GpioInt/Interrupt
> resources.
>
> > It's
> > also a potential landmine if the driver patch is backported somewhere
> > without the DTS patch (maybe the DTS is not upstream?). Someone will
> > have to debug why wakeups aren't working anymore.
>
> I can change the SPI driver so it doesn't look for the 'wakeup-source'
> property, keeping existing behavior where wakeirq is assumed. So there
> should be no issues with backporting.
>
> > > > What is the goal of this patch series? Is it to allow disabling the
> > > > wakeup capability of the EC wake irq from userspace? I can see a
> > > > possible problem where we want to disable wakeup for the EC dynamically
> > > > because either it has no child devices that are wakeup sources (e.g. no
> > > > power button, no keyboard on ARM) or userspace has disabled all the
> > > > wakeup sources for those child devices at runtime. In that case, we
> > > > would want to keep the EC irq from waking up the system from suspend. Is
> > > > that what you're doing here?
> > >
> > > The root of this patch series stems from a bug where spurious wakes
> > > are seen on Skyrim.
> >
> > Are all 24 patches needed to fix spurious wakeups? Why can't we do a DMI
> > match table for Skyrim devices and disable the wakeirq logic on that
> > platform? That would be a much more focused and targeted fix, no?
>
> It would be more focused and targeted, but I don't think it's the
> correct fix. Skyrim is not the quirk. The driver is incorrectly
> enabling the IRQ for wake even though a GPE exists for the EC to wake the AP.
> ACPI defines keywords to specify GpioInt and Interrupt
> resources as wake capable, and until recently [2], we were not
> flagging the respective resources correctly. Most ACPI Chromebooks
> have a dedicated GPE for wake, and enabling the IRQ for wake is
> unintentional IMHO.

I'm no expert in ACPI so sorry if I'm misunderstanding. The driver
unconditionally enables wake on the irq. Most other chromebooks have
added some other interrupt (GPE?) for wakeup purposes, which is
different from the irq used for IO? And this patch series tries to
figure out if enable_irq_wake() is going to fail on those devices so it
can only enable irq wake if the irq supports it? When does calling
enable_irq_wake() not return an error to properly indicate that the irq
can't wake? On skyrim devices, where presumably it needed to be marked
in ACPI differently? Or does that platform really support wake on the
irq, but we also have a GPE so enabling wake on the irq is not failing?

Having to backport 24 patches to fix a bug is not good. Can the driver
look for both an IO interrupt and a GPE and then assume the GPE is for
wakeup and the interrupt is for IO?

> [2] https://review.coreboot.org/c/coreboot/+/79373
>
> > > Copying some wording from the DTS patches:
> > > "Some Chromebooks use a separate wake pin, while others overload the
> > > interrupt for wake and IO. With the current assumption, spurious wakes
> > > can occur on systems that use a separate wake pin. It is planned to
> > > update the driver to no longer assume that the EC interrupt pin should
> > > be enabled for wake."
> > >
> > > This patch series will allow us to disable the ec_sync pin as a wake
> > > source on Skyrim as it already uses a dedicated wake gpio.
> >
> > Aha! This last sentence is the detail I've been looking for. Please put
> > these details in the commit text.
> >
> > "Skyrim devices are experiencing spurious wakeups due to the EC driver
> > always enabling the irq as a wakeup source but on Skyrim devices the EC
> > wakeup signal is a dedicated gpio separate from the irq."
> >
> > Please be direct and specific instead of writing in general terms.
>
> Sure, I can update the commit text :-)
>
> In summary, there are a lot of comments that suggest different
> solutions. Here are the options I see:
> 1. Skyrim DMI quirk
> 2a. Update EC SPI driver to assume wake capable regardless of
> 'wakeup-source' property being present
> 2b. Remove 'wakeup-source' entries from DTS

One disconnect I have is that 'wakeup-source' isn't only talking about
the interrupt in DT. It's indicating that the device itself is a wakeup
source. The interrupt controller hierarchy decides which interrupts are
wakeup capable. It sounds like in ACPI the wakeup capability is encoded
in the interrupt descriptor? DT is different here. As I stated earlier,
the EC device has always been a wakeup source, so having the DT property
there is redundant.

> 3. Leave the existing solution

How is 3 an option? I thought this patch series was fixing a bug.

>
> I'm arguing for 2a (without 2b). This keeps backward compatibility
> while adding an indication that the EC is wake capable and keeps
> closer feature parity with the ACPI/LPC interface. FWIW, others have
> already reviewed/ack'd the dts patches.

