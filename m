Return-Path: <linux-kernel+bounces-16247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2FE823B98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1CF28827B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E6A18B00;
	Thu,  4 Jan 2024 04:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ayevH5qT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9104815EA6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5edfcba97e3so1425977b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 20:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704344152; x=1704948952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FSGKxtpAayAcHObQDlsqsv0BU3tFHlXJLbZKNWj+7ms=;
        b=ayevH5qTCLmtPdXljKi+/dXnP3FV0UPdKfeBX/TtMsZLOwVtgt/oQNHprF6aVCB/P5
         mreopH9hG/Um6+LA1ckJUrOK0IV34wtC8GNmFS6P4IJfGuE3l9bqUKe/z4Bmiupp/l8v
         NWdY7zutsTGnNorS/clx+7YA7aqf5vZTVIq0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704344152; x=1704948952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSGKxtpAayAcHObQDlsqsv0BU3tFHlXJLbZKNWj+7ms=;
        b=BB66WNN3KqhOEqYseBBtDoWeW7ioH50nLJxQSGqjHGTQMNWt/MR4vlgeS+HoAgQe//
         LVMmysORpGJZ7F4X5yGb3uScpEbcONl2Kmp63UH92eptFSJ8kJj8cma+fdAr27GKgFEy
         /GXb1P4vYkLE0rsg9a7J659dnZNJ+awedGzDwAamjWllosJpWfCftl0L8IGeBJGFEzVL
         pkCWRmumx0wqpFStTGOIDGZsa976+egGOf9JJg/1nD2JpEyZxR/4h44v5hT5UZe4KSAi
         IU7DMalQ+yWQVte6UwxVDJkeWW+oyGv2/HiO3t5pyeRgqXdcdFBqu2aSQo+JMMBcU9PD
         6DOA==
X-Gm-Message-State: AOJu0Ywl9Y4UwD0UJz7OHtBAuBXaTi7dQOp8bu8HwYBLH7dWaHm4agMq
	polj6p4Lxbngr9SRbh+g4hHR5qyMWFy2k2zBh8B54w3RgbdA
X-Google-Smtp-Source: AGHT+IEhxXj9nei6hm7QKNjakE0j9auM+VIHYHWIPNtlJlVEeu7Ar+6WuGQqpRBguFh1aTI89xgZzRPIbWdjItkGO3Q=
X-Received: by 2002:a81:5d43:0:b0:5f3:2c5e:462f with SMTP id
 r64-20020a815d43000000b005f32c5e462fmr101358ywb.51.1704344152353; Wed, 03 Jan
 2024 20:55:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
 <CAE-0n50zkwZ8nguUJcL1gjbuavhSU_rLxfGhanxB4YA7N34hLQ@mail.gmail.com>
 <CANg-bXByhaSngW2AAG9h6DYHpiTUvh8+yw3LPU6ZQSCb62M-wg@mail.gmail.com>
 <CAE-0n52u68wMHJGe8=jz4Y1y2=voycFEY15keebz9tPDDBgiqA@mail.gmail.com>
 <CANg-bXDzLJgWLuH8Xj4GLYG=AVfcbmi_EfrA7DaHj4F6i350DA@mail.gmail.com> <CAE-0n52365_AYgjaXyV7+oB8WgaJVp5oCUzdsq7NquZsR08XXw@mail.gmail.com>
In-Reply-To: <CAE-0n52365_AYgjaXyV7+oB8WgaJVp5oCUzdsq7NquZsR08XXw@mail.gmail.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Wed, 3 Jan 2024 21:55:41 -0700
Message-ID: <CANg-bXAVm01qoGUL2hUN9=3eK5o6c6BKtTUL82WiLL8cxFeaLA@mail.gmail.com>
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

> > > > > Does using the pm wakeirq logic require the use of 'wakeup-source'
> > > > > property in DT? A quick glance makes me believe it isn't needed, so
> > > > > please split that part out of this patch as well.
> > > >
> > > > No, 'wakeup-source' is not required, it provides an indication to the
> > > > driver that the IRQ should be used for wake, which then enables the pm
> > > > subsystem accordingly. If 'wakup-source' is not used, we're back to
> > > > square one of making assumptions. Specifically in this case, it would
> > > > be assumed that all SPI based EC's are wake capable.
> > >
> > > Is that the wrong assumption to make? My understanding of the DT
> > > property is that it is used to signal that this device should be treated
> > > as a wakeup source, when otherwise it isn't treated as one. In this
> > > case, the device has always been treated as a wakeup source so adding
> > > the property is redundant.
> >
> > For SPI, it's not the wrong assumption. I was trying to drop the
> > assumption though to match ACPI/LPC behavior.
>
> Ok. Is the EC always a wakeup source? Not the EC irq, the EC device.

Yes. The powerd daemon enables the EC for wake [1]. At least on ACPI systems.
[1] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/81b23aeac510655f27e1d87b99b12c78146e7c37:src/platform2/power_manager/powerd/daemon.cc;l=611

> > Regardless,
> > I can update the SPI code to assume a wake capable IRQ. But I'd like
> > to keep the prerequisite device tree patches unless there's a good
> > reason to drop them. Specifying 'wake-source' certainly doesn't hurt
> > anything, and there are other improvements to the OF
> > subsystem/documentation.
>
> I don't see any harm in having wakeup-source in the binding, but I'd
> prefer it is behind a different compatible string as optional, and
> introduced when we need to have an EC that doesn't wake up the system.

The 'wakeup-source' property is already optional. See patch 04 in this
version of the series which updates the documentation surrounding the
property. Or are you suggesting a completely new string so that we can
be forever backward compatible? If that's the case, the property would
indeed have to have inverted logic signifying a device that is *not*
wakeup capable. It feels wrong to have to do something like that.

> Otherwise it's all future coding for a device that doesn't exist.

I agree adding 'wakeup-source' is future coding for a device that
doesn't exist. It does provide (pseudo) feature parity with ACPI
systems though. See my comment below about ACPI GpioInt/Interrupt
resources.

> It's
> also a potential landmine if the driver patch is backported somewhere
> without the DTS patch (maybe the DTS is not upstream?). Someone will
> have to debug why wakeups aren't working anymore.

I can change the SPI driver so it doesn't look for the 'wakeup-source'
property, keeping existing behavior where wakeirq is assumed. So there
should be no issues with backporting.

> > > What is the goal of this patch series? Is it to allow disabling the
> > > wakeup capability of the EC wake irq from userspace? I can see a
> > > possible problem where we want to disable wakeup for the EC dynamically
> > > because either it has no child devices that are wakeup sources (e.g. no
> > > power button, no keyboard on ARM) or userspace has disabled all the
> > > wakeup sources for those child devices at runtime. In that case, we
> > > would want to keep the EC irq from waking up the system from suspend. Is
> > > that what you're doing here?
> >
> > The root of this patch series stems from a bug where spurious wakes
> > are seen on Skyrim.
>
> Are all 24 patches needed to fix spurious wakeups? Why can't we do a DMI
> match table for Skyrim devices and disable the wakeirq logic on that
> platform? That would be a much more focused and targeted fix, no?

It would be more focused and targeted, but I don't think it's the
correct fix. Skyrim is not the quirk. The driver is incorrectly
enabling the IRQ for wake even though a GPE exists for the EC to wake the AP.
ACPI defines keywords to specify GpioInt and Interrupt
resources as wake capable, and until recently [2], we were not
flagging the respective resources correctly. Most ACPI Chromebooks
have a dedicated GPE for wake, and enabling the IRQ for wake is
unintentional IMHO.
[2] https://review.coreboot.org/c/coreboot/+/79373

> > Copying some wording from the DTS patches:
> > "Some Chromebooks use a separate wake pin, while others overload the
> > interrupt for wake and IO. With the current assumption, spurious wakes
> > can occur on systems that use a separate wake pin. It is planned to
> > update the driver to no longer assume that the EC interrupt pin should
> > be enabled for wake."
> >
> > This patch series will allow us to disable the ec_sync pin as a wake
> > source on Skyrim as it already uses a dedicated wake gpio.
>
> Aha! This last sentence is the detail I've been looking for. Please put
> these details in the commit text.
>
> "Skyrim devices are experiencing spurious wakeups due to the EC driver
> always enabling the irq as a wakeup source but on Skyrim devices the EC
> wakeup signal is a dedicated gpio separate from the irq."
>
> Please be direct and specific instead of writing in general terms.

Sure, I can update the commit text :-)

In summary, there are a lot of comments that suggest different
solutions. Here are the options I see:
1. Skyrim DMI quirk
2a. Update EC SPI driver to assume wake capable regardless of
'wakeup-source' property being present
2b. Remove 'wakeup-source' entries from DTS
3. Leave the existing solution

I'm arguing for 2a (without 2b). This keeps backward compatibility
while adding an indication that the EC is wake capable and keeps
closer feature parity with the ACPI/LPC interface. FWIW, others have
already reviewed/ack'd the dts patches.

