Return-Path: <linux-kernel+bounces-14322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAB0821B57
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F1BB21DEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D0BEAF6;
	Tue,  2 Jan 2024 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y67F9vST"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1F4EAEA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6da47688fd9so553961b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 04:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704197081; x=1704801881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N76OjKLOgBDpHQZl6Q0vBRfZ3upph3nCrsYFs7Cd9m8=;
        b=Y67F9vSTmO4dvCOpTTm2s4rfFMMUN1CCAoef9Y9GnFNQ/ZFwAloE5oIgmxvcf3DkmY
         TcGFcQnp7z1yieSYabOnGgI9LGdwemSH8RdTmmGXWNV++YtBFlvE5UOjHUZIZ0V/rkpO
         EQlmX0w+CzXbTxS9DwblyQHysfIGTaFCItK20m8ZeOEXH23Y48IRZFkQvlKyUVlTYOTn
         WYJ1zUtC/D3Io9ZN8GKowF8TuUqMo4REjn1sMEzFl7HYM1KjZN+c6pGz5Bsxp11vb/FC
         xuf1M6SkrOa8YeOMw3P2lxOtn3L+AQJbzyXmBvMqvl/4qLNk2aIsr2mWAXvZyvZ5QvxQ
         b7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704197081; x=1704801881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N76OjKLOgBDpHQZl6Q0vBRfZ3upph3nCrsYFs7Cd9m8=;
        b=Y8TNaVuGtIBKIziTW50glp0G2gjQlM8VWMDZet/8da7Vic2oNtzYo4bxa9dm1hlplE
         L0s7wqLw5IaJURc83Er/7eHxULEfnidryXD1GOaG+MplVytBSHpra9znRnbkaVXlgmiq
         2/KpazHk043XpU773wpWyJDoIObpgRoMnzZHUbYAU5Yje1LmBqJ2/V4iZ2UhQ05BL+5E
         P3FFB8SatF/chX+w9qNfa47wZ/dX7QJQUKsS8AkyAY0g14Bh0vU3TRZYCKs9TI7tlwx4
         Cl5c2rRKt18aC+ESRgmpQb0bq1/gH0iZZJ0AOQftHzMAztcNjuJCKoTvkP46VIoagru0
         65sw==
X-Gm-Message-State: AOJu0Yywk+DhGolQV4lFgSSodex6tLhR9zd4vjsDg+uO82WJfyA1lPKh
	Z0+KxwvJ7reW6Cy4vV+uxpUcpf06puKRORmTso+R4m5Sk2umfA==
X-Google-Smtp-Source: AGHT+IEj8/MeJc6HIYq1FfB5T22NdbVaEpyPDqxtITGxOgk+wa/CS1OG2MvJd2fh+DCi0d0/v4YDh7LCmUKpEjM3f9E=
X-Received: by 2002:a62:e717:0:b0:6d9:9de5:d121 with SMTP id
 s23-20020a62e717000000b006d99de5d121mr5349441pfh.27.1704197080752; Tue, 02
 Jan 2024 04:04:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228093321.5522-1-quic_jinlmao@quicinc.com> <12ce6e5d-6e4d-fb99-eb82-dece97423bfb@arm.com>
In-Reply-To: <12ce6e5d-6e4d-fb99-eb82-dece97423bfb@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 2 Jan 2024 12:04:29 +0000
Message-ID: <CAJ9a7Vgi=ELOhXNF97KrBtV5ef8khwWqzWKevrYW2RtBBtsppw@mail.gmail.com>
Subject: Re: [PATCH] coresight: Add coresight name support
To: James Clark <james.clark@arm.com>
Cc: Mao Jinlong <quic_jinlmao@quicinc.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Tingwei Zhang <quic_tingweiz@quicinc.com>, Yuanfang Zhang <quic_yuanfang@quicinc.com>, 
	Tao Zhang <quic_taozha@quicinc.com>, Leo Yan <leo.yan@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

As James mentions this is clearly a V2 of a previous patch - please
mark as such in future.

Adding to what James has already said:-

1) Mapping between the canonical names used in the drivers and the
information as to the precise device is as easy as running 'ls' on
/sys/bus/coresight/devices:-

root@linaro-developer:/home/linaro/cs-mods# ls -al /sys/bus/coresight/devices/
total 0
drwxr-xr-x 2 root root 0 Jan  2 11:27 .
drwxr-xr-x 4 root root 0 Jan  2 11:27 ..
lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu0 ->
../../../devices/platform/soc@0/858000.cti/cti_cpu0
lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu1 ->
../../../devices/platform/soc@0/859000.cti/cti_cpu1
lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu2 ->
../../../devices/platform/soc@0/85a000.cti/cti_cpu2
lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu3 ->
../../../devices/platform/soc@0/85b000.cti/cti_cpu3
lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_sys0 ->
../../../devices/platform/soc@0/810000.cti/cti_sys0
lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_sys1 ->
../../../devices/platform/soc@0/811000.cti/cti_sys1
lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm0 ->
../../../devices/platform/soc@0/85c000.etm/etm0
lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm1 ->
../../../devices/platform/soc@0/85d000.etm/etm1
lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm2 ->
../../../devices/platform/soc@0/85e000.etm/etm2
lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm3 ->
../../../devices/platform/soc@0/85f000.etm/etm3
lrwxrwxrwx 1 root root 0 Jan  2 11:42 funnel0 ->
../../../devices/platform/soc@0/821000.funnel/funnel0
lrwxrwxrwx 1 root root 0 Jan  2 11:42 funnel1 ->
../../../devices/platform/soc@0/841000.funnel/funnel1
lrwxrwxrwx 1 root root 0 Jan  2 11:42 replicator0 ->
../../../devices/platform/soc@0/824000.replicator/replicator0
lrwxrwxrwx 1 root root 0 Jan  2 11:42 tmc_etf0 ->
../../../devices/platform/soc@0/825000.etf/tmc_etf0
lrwxrwxrwx 1 root root 0 Jan  2 11:42 tmc_etr0 ->
../../../devices/platform/soc@0/826000.etr/tmc_etr0


2) The patch set must contain the usage and specification in the .yaml
 file(s) of the property used.

However, there was a standard property called 'name' which is
deprecated - see
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html
section 2.3.11. I do not believe that adding another 'name' property
would be accepted by the DT maintainers.

3) the 'device_node' structure has a 'name' field that contains the
node name in the DT approved "node-name@unit-address" format.This
contains whatever node names you used in the dt.  Why not use this if
a change has to be made and find some conditional to activate it.

However, given point 1) above, the problem is solved and the patch
adds no new information not already available.

Regards

Mike

On Thu, 28 Dec 2023 at 11:26, James Clark <james.clark@arm.com> wrote:
>
>
>
> On 28/12/2023 09:33, Mao Jinlong wrote:
> > Add coresight name support for custom names which will be
> > easy to identify the device by the name.
> >
>
> I suppose this is more of a V2 because the subject is the same as the
> one sent earlier this year. But it looks like the discussion on the
> previous one wasn't resolved.
>
> With the main issues to solve being:
>
>  * It would be nice to use the existing root node name instead of adding
>    a new property. But at the same time DT nodes are supposed to have
>    generic names.
>
>  * This only works for DT and not ACPI
>
> To me it seems like adding the new property is just a "cheat" to get
> around not being allowed to have a specific name for the root node. But
> if we admit that we need a name I don't see the benefit of not putting
> the name where the node is already named.
>
> Using the root node name at this point would also undo the hard coded
> per-cpu naming of the CTI and ETM devices, so maybe it would be nice,
> but it's just too late. That means that a new field is necessary.
> Although that field could be a boolean like "use-root-name-for-display"
> or something like that. In the end it probably doesn't really make a
> difference whether it's that or a name string.
>
> And maybe the answer to the ACPI question is just that if anyone needs
> it, they can add it in the future. It doesn't seem like it would
> conflict with anything we do here.
>
> > Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> > ---
> >  .../hwtracing/coresight/coresight-cti-core.c  | 20 ++++++++------
> >  drivers/hwtracing/coresight/coresight-dummy.c | 10 ++++---
> >  .../hwtracing/coresight/coresight-platform.c  | 27 +++++++++++++++++++
> >  drivers/hwtracing/coresight/coresight-tpdm.c  | 10 ++++---
> >  include/linux/coresight.h                     |  1 +
> >  5 files changed, 53 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> > index 3999d0a2cb60..60a1e76064a9 100644
> > --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> > @@ -902,14 +902,18 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
> >       /* default to powered - could change on PM notifications */
> >       drvdata->config.hw_powered = true;
> >
> > -     /* set up device name - will depend if cpu bound or otherwise */
> > -     if (drvdata->ctidev.cpu >= 0)
> > -             cti_desc.name = devm_kasprintf(dev, GFP_KERNEL, "cti_cpu%d",
> > -                                            drvdata->ctidev.cpu);
> > -     else
> > -             cti_desc.name = coresight_alloc_device_name(&cti_sys_devs, dev);
>
> Can we put the new name stuff inside coresight_alloc_device_name()? Then
> it happens by default for every device.
>
> I know Suzuki said previously to do it per-device, but the new DT
> property is just "coresight-name", so it's generic. Rather than being
> specific like "cti-name". So I don't see the benefit of duplicating the
> code at this point if we do decide to do it.
>
> > -     if (!cti_desc.name)
> > -             return -ENOMEM;
> > +     cti_desc.name = coresight_get_device_name(dev);
> > +     if (!cti_desc.name) {
> > +             /* set up device name - will depend if cpu bound or otherwise */
> > +             if (drvdata->ctidev.cpu >= 0)
> > +                     cti_desc.name = devm_kasprintf(dev, GFP_KERNEL, "cti_cpu%d",
> > +                                                    drvdata->ctidev.cpu);
> > +             else {
> > +                     cti_desc.name = coresight_alloc_device_name(&cti_sys_devs, dev);
> > +                     if (!cti_desc.name)
> > +                             return -ENOMEM;
> > +             }
> > +     }
>
> >
> >       /* setup CPU power management handling for CPU bound CTI devices. */
> >       ret = cti_pm_setup(drvdata);
> > diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/hwtracing/coresight/coresight-dummy.c
> > index e4deafae7bc2..b19cd400df79 100644
> > --- a/drivers/hwtracing/coresight/coresight-dummy.c
> > +++ b/drivers/hwtracing/coresight/coresight-dummy.c
> > @@ -76,10 +76,12 @@ static int dummy_probe(struct platform_device *pdev)
> >       struct coresight_desc desc = { 0 };
> >
> >       if (of_device_is_compatible(node, "arm,coresight-dummy-source")) {
> > -
> > -             desc.name = coresight_alloc_device_name(&source_devs, dev);
> > -             if (!desc.name)
> > -                     return -ENOMEM;
> > +             desc.name = coresight_get_device_name(dev);
> > +             if (!desc.name) {
> > +                     desc.name = coresight_alloc_device_name(&source_devs, dev);
> > +                     if (!desc.name)
> > +                             return -ENOMEM;
> > +             }
> >
> >               desc.type = CORESIGHT_DEV_TYPE_SOURCE;
> >               desc.subtype.source_subtype =
> > diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> > index 9d550f5697fa..284aa22a06b7 100644
> > --- a/drivers/hwtracing/coresight/coresight-platform.c
> > +++ b/drivers/hwtracing/coresight/coresight-platform.c
> > @@ -183,6 +183,18 @@ static int of_coresight_get_cpu(struct device *dev)
> >       return cpu;
> >  }
> >
> > +static const char *of_coresight_get_device_name(struct device *dev)
> > +{
> > +     const char *name = NULL;
> > +
> > +     if (!dev->of_node)
> > +             return NULL;
> > +
> > +     of_property_read_string(dev->of_node, "coresight-name", &name);
>
> Do you need to update the binding docs with this new property?
>
> Also a minor nit: Maybe "display-name" is better? "Coresight" is
> implied, and the node is already named, although that node name isn't
> used for display purposes, but this one is.
>
> Thanks
> James



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

