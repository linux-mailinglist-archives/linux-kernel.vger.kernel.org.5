Return-Path: <linux-kernel+bounces-76379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B96785F670
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB221C22497
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBB3405CE;
	Thu, 22 Feb 2024 11:03:49 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36F3FB28;
	Thu, 22 Feb 2024 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599828; cv=none; b=d05GxKuYKVnuY5wGLRnY7AiLMgZj8UxpR9tEmTwRWmWulQTYtUNI2mOfdTkJRAM8elh3iS0oCAond9m4rhQ8CoqTtNg2BtPT3pe+7VuTLiKh7RrWR/k4XqEX2H0ei3JURou/DDzex6UAVvWSQGzdTgle8Lus8cPP6DbNNm9h0d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599828; c=relaxed/simple;
	bh=aNAwGVMzCtDmcWms4Hkn6L2Tl9jXaV68YPv9Gtk3Zn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVBPEy5ky2FvDCvBOziA5RANlf4TATiMytfhOzPmdNjlUcapr12iZFStCF5tajfamQL+4e2swG+tYRIoyZ4KLNlT+zm7nyr1epB9hHEaxEOPfo5cxqMDCW6nM7Z3c2U8fmF8MWNlOqGA40ZoJMiPq1EkAf8q7RU/QLELg2VL0JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59fc31c57easo1460504eaf.1;
        Thu, 22 Feb 2024 03:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599826; x=1709204626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXkwWsXr4UdyVJ+x/CTV7FyUGw1hmJ/jv3iQsxVs2Nw=;
        b=RGUDP95CKHK9EI1ndsEqms2QZRHlZ7l/vs2Kis5ZtqBD2yDO9tCRWDdCs/+AVuNx3s
         sHeHoe3Yu8c4mr6h4/iQlK1VNHijv2q/byQ86H49gcw06QKx8SGK+UtK800t1lRGZqMj
         bpnmbCM3IN/TH/5wP2+Z4Ya2InNb6QhMylfJokUNYOM/m1J/vZmybGhgEwEysvQQne+G
         ac1DuI4sW/iVPL63hnMSlZpxeU3XVsvnAl3qCGbMjjjPTeziBra3U8pReaJASxFbzk7i
         qQdAuJbWANb5qa2iHSlNhLqvzuECJNp8ZjeEifDPzT2J1MGqJ2IUVvf0zejZl2sOWua0
         Gevg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3OW8LcJ9zgzcmcrfhlUe0rZqUrcRxxcxcZNsJt3FguujqUk1+6dobYb50F6Qj86O6S+/HlFjDlRTp8SOvz7lnplko4MW8YXOyFqrNvSDxzmQOvV+8nyrxRSqN9/JDkxGFmNSox/+eaaREIeDTQeMBhU4aiT/aLca21+F17RYbVRP
X-Gm-Message-State: AOJu0YyJEIObLCnT2Pjk9Jq/VZsit1x1sBpPRk7qo+EvDbrflI2mW5ik
	KeXkhHV27+ssV+zzlwrTkkq/v/nty9ZXicNQpZoZobIwb2AXQLGXWtGMOZCwqJwE7q0vxetfu8T
	USDC2lxVllI0gBZPN/F4s3NlsdHQ=
X-Google-Smtp-Source: AGHT+IGW70+tG0pf3+12r0GUl/ulAMYk6uVLfk/r13isOmFbmA8hFbldDl8U8xoL2jlwrzlWROzbtVb7cOU3oAgO6o0=
X-Received: by 2002:a05:6820:134d:b0:59f:881f:9318 with SMTP id
 b13-20020a056820134d00b0059f881f9318mr25764823oow.0.1708599826346; Thu, 22
 Feb 2024 03:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4551531.LvFx2qVVIh@kreacher> <2262393.iZASKD2KPV@kreacher>
 <ffa37950-d850-44e2-a33e-837466238d6d@linaro.org> <CAJZ5v0hqCbxChYmvADZJAFiuS1yPnRmj6ZZJfD032tnLB7ZZAA@mail.gmail.com>
 <ccf63280-bad1-4450-bf36-44cd1dcb69b2@linaro.org>
In-Reply-To: <ccf63280-bad1-4450-bf36-44cd1dcb69b2@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 12:03:34 +0100
Message-ID: <CAJZ5v0hju2ZQsqBYMcs+_TDB+7aH=_Lo7BwqJ=WX1VMkHK38jA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] thermal: core: Store zone ops in struct thermal_zone_device
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:58=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 22/02/2024 11:52, Rafael J. Wysocki wrote:
> > On Thu, Feb 22, 2024 at 11:47=E2=80=AFAM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 14/02/2024 13:45, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> The current code requires thermal zone creators to pass pointers to
> >>> writable ops structures to thermal_zone_device_register_with_trips()
> >>> which needs to modify the target struct thermal_zone_device_ops objec=
t
> >>> if the "critical" operation in it is NULL.
> >>>
> >>> Moreover, the callers of thermal_zone_device_register_with_trips() ar=
e
> >>> required to hold on to the struct thermal_zone_device_ops object pass=
ed
> >>> to it until the given thermal zone is unregistered.
> >>>
> >>> Both of these requirements are quite inconvenient, so modify struct
> >>> thermal_zone_device to contain struct thermal_zone_device_ops as fiel=
d and
> >>> make thermal_zone_device_register_with_trips() copy the contents of t=
he
> >>> struct thermal_zone_device_ops passed to it via a pointer (which can =
be
> >>> const now) to that field.
> >>>
> >>> Also adjust the code using thermal zone ops accordingly and modify
> >>> thermal_of_zone_register() to use a local ops variable during
> >>> thermal zone registration so ops do not need to be freed in
> >>> thermal_of_zone_unregister() any more.
> >>
> >> [ ... ]
> >>
> >>>    static void thermal_of_zone_unregister(struct thermal_zone_device =
*tz)
> >>>    {
> >>>        struct thermal_trip *trips =3D tz->trips;
> >>> -     struct thermal_zone_device_ops *ops =3D tz->ops;
> >>>
> >>>        thermal_zone_device_disable(tz);
> >>>        thermal_zone_device_unregister(tz);
> >>>        kfree(trips);
> >>
> >> Not related to the current patch but with patch 1/6. Freeing the trip
> >> points here will lead to a double free given it is already freed from
> >> thermal_zone_device_unregister() after the changes introduces in patch
> >> 1, right ?
> >
> > No, patch [1/6] doesn't free the caller-supplied ops, just copies them
> > into the local instance.  Attempting to free a static ops would not be
> > a good idea, for example.
>
> I'm referring to the trip points not the ops.

Ah, sorry for the confusion.

> The patch 1 does:
>
> tz =3D kzalloc(struct_size(tz, trips, num_trips), GFP_KERNEL);
>
> Then the last line of thermal_zone_device_unregister() does:
>
> kfree(tz);
>
> That includes the trip points in the flexible array.

Right.

> Now in thermal_of_zone_unregister(), we do:
>
> trips =3D tz->trips;

I missed this.

> thermal_zone_device_unregister(tz);
> kfree(trips);
>
> Hence double kfree, right?

Indeed, so patch [1/6] is missing a thermal_of change to stop freeing
trips separately.  Let me send an update of just that patch.

