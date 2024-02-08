Return-Path: <linux-kernel+bounces-58140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F5B84E1D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3221C26103
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C0D763EC;
	Thu,  8 Feb 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqE0hvwG"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF797D410
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398161; cv=none; b=t+i1xOrNim6Z1TyHCTzMr3sJ85V7Nh765M0ErOkphFwvDmKUdP9wJXqgstDAtm66CC6LsSsfSe0QBSX/E/Lg2OMS/8IRrmoiADOB91ze7F6P9UKAoFhl3C5NjKZXriDHVLNrxy6woXJ9h2RqyGGk9E+gvjrkhRIFX4JPLZRIIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398161; c=relaxed/simple;
	bh=JYAXOHhijzGveTgLECFMxWt2hP1TLJVns/dJDsdVzn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rb4AC5w2qJhYNCZ1HmRLfEzF4d7jGZlR67uaI9592iH85qPNamToO5s12VRhnozPhpZis9ZYT6hwbDHv98igIEtzl1z41ocbCCS5+N8+2czCqNHu1BAVmJeFYeA403EwzP5pbNpTIAfKa9YNFLlKFDgvM/rwjoVE9maILyAEr7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqE0hvwG; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso1302627a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707398159; x=1708002959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8Dp3BKeiZZKDAqJdXYO0Ke5gALNhbM/RCCF/9rM4yU=;
        b=ZqE0hvwGedeTUAog3feEeY1ZxJ4BlHJrsA4Qto3fDpjVSdq46VHr58S9EifnAaLLEG
         QfyZKhPhlC86wBzDeqNwF1ht5+tDRpoLZ4BXVoYqVCfZncyXya0Ei4ctInW/bed1s5k5
         CTcXzTfzs0b4RxAvyes8Akoo6abPdHlcqANVQv6PQdDH7qBo0Y3Y27Sv9RRl7FJlvpeN
         t+oOk5IgTEaKjusZdb5t18wLiNcAacOtw3ubxKgZY5q20/s4IG2UpXokvmTdaHitjzsq
         SrWFJkH6jcm+2o/jNtthwoN86u4bOekL7+IdS2oGtu9FRYGB/p3aommI2YmsZsHOPZPH
         CtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707398159; x=1708002959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8Dp3BKeiZZKDAqJdXYO0Ke5gALNhbM/RCCF/9rM4yU=;
        b=DM5A1xWvCCMQedQsBJ+Yqvr2FmnKz7khtUewDj04ivd7UURWLzCVnOb2/3EyFDFlYt
         za3wRUCNUDqxZOwRQ+lbDJnDvgvnaRVTbzB9k4eUbsVKQE44w3JS82lAbVG/dlrOhi7x
         pSs/m2ivh/IR59gHg+vo3OB3o2pO4h8/phm2kTXAkMc5MGa0+QjdwD0ctO/pJ7uts3/M
         fkNukVVV/jH7cf058vjh8MHAxOdFUO95GYwMyO0d+aEFzmyhuRY7MhxnbMzftP40R75y
         Of3tww7RecKCvya6Xrv80fMvPsWn2SEIl2Z5bfUw9URidLGucSAyD3GVFKhPWBaqsVp6
         ZBGg==
X-Gm-Message-State: AOJu0YzsUC3BPlAmFrstnPrUoJQMQzA839cAG+ojKFkVFKr5nIeeymP7
	RThThz45ordIl3mcvg567RviEy10VJEA2KnsmE2dv0MzE6kalaBrfbAUDMc9DV+jpiCGC5zI5U4
	vH9B0+AZv7OyScgaPkPCUwu4FdpY=
X-Google-Smtp-Source: AGHT+IE/CAKMPbroR8bnQix8tNmZwX1tZA2jxbhk7gQBcadNJRAkSVcjp7iPkE/azE/A4cvEvq7A64+NprUUb0rHG5w=
X-Received: by 2002:a17:90a:e2c2:b0:296:f9e9:5d45 with SMTP id
 fr2-20020a17090ae2c200b00296f9e95d45mr1709115pjb.32.1707398158977; Thu, 08
 Feb 2024 05:15:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212033259.189718-1-aford173@gmail.com> <20231212033259.189718-2-aford173@gmail.com>
 <CAHCN7xKKMzOtVaEXzgTgsO4yZF0JZ6=o+TFJOeTCza0fMGss2w@mail.gmail.com> <e2688a01-47d2-4f89-ab92-252f378d37ba@kontron.de>
In-Reply-To: <e2688a01-47d2-4f89-ab92-252f378d37ba@kontron.de>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 8 Feb 2024 07:15:47 -0600
Message-ID: <CAHCN7xL-a9EK0Zk4K8k4Eiktsop9+KN34rY=yOvjN_==WTqULw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: samsung-dsim: Fix porch calcalcuation rounding
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: dri-devel@lists.freedesktop.org, aford@beaconembedded.com, 
	Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Michael Tretter <m.tretter@pengutronix.de>, Marco Felsch <m.felsch@pengutronix.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 2:17=E2=80=AFAM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> On 25.01.24 19:44, Adam Ford wrote:
> > On Mon, Dec 11, 2023 at 9:33=E2=80=AFPM Adam Ford <aford173@gmail.com> =
wrote:
> >>
> >> When using video sync pulses, the HFP, HBP, and HSA are divided betwee=
n
> >> the available lanes if there is more than one lane.  For certain
> >> timings and lane configurations, the HFP may not be evenly divisible.
> >> If the HFP is rounded down, it ends up being too small which can cause
> >> some monitors to not sync properly. In these instances, adjust htotal
> >> and hsync to round the HFP up, and recalculate the htotal.
> >>
> >> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL=
 i.MX8MM with HDMI monitor
> >> Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > Gentle nudge on this one.  Basically this fixes an issue with the 8MP,
> > but it's still unknown why it doesn't work on 8MM or 8MN, but Frieder
> > confirmed there are no regressions on 8MM or 8MN.
>

Inki,

Is there something you need which is holding this back?  It's been
nearly two months since I posted the initial patch.

Thank you,

adam

> I only tested two specific display setups on i.MX8MM. So of course I
> can't confirm the absence of regressions in general.
>
> Anyway, I think this should be applied.

