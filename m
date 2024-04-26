Return-Path: <linux-kernel+bounces-159547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F89D8B3011
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF461F229E0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821F813A40B;
	Fri, 26 Apr 2024 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="HWw0of0G"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CFE380
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714111819; cv=none; b=UboTe5lj4Ny3grLFheYYu50q99/u1C3UGpWzT4ne0resptZYHP+DA9nisRfVnyq6lFHvtkCOlLlYh8oak+RdZdUOi9VSXtUz+Ccrk9rVB2+nmx58CYtMlI7YL/Q9k+pkOf7yCuSsgR1IW8SiGnOryKRBUqtbhi1m/N1JUP6c4zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714111819; c=relaxed/simple;
	bh=MRp7rRl45aaqTCC0cgb2u8XfHafGzvKMjysIi13KJmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlPuHw1asufhYuDqPijWfk9GzuumZgQe7aNQWsaDTlRNDoyJfSEfYkb15wlUfQlK0VEihYVPfUHJwus7OKBCFJgV4ikqRQU+ZrV75mIegPxYUzpJ3qUlC1IlGiZrE85QJsXqc9qwvcFL+k4QDgGvOk2ApxX6IymBj+HRgOQGEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=HWw0of0G; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6114c9b4d83so15432787b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1714111815; x=1714716615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJ1GdTZvweAfdVmldBDNtC2yfd/6DMLGLYkaIty7Abc=;
        b=HWw0of0GZDTGFjXCKgN6vjoZbqTpBVQPSAzQOn0fZda9nhER1z3cfz4Etn/YVI7LFm
         toE44xX2ffVTdEGHaFse+2ZFDObAu/tBYVl1fRvFEjpH+l2l1sk4gzLtASzvxf9Yzd4J
         HIaMAAF/+/XSwv2Ab+mquW9q9JH1nP6N6LfYy/mnJYZJN5UYoR8HXdIt3hkidlR5puvR
         wIqUrQRALC12pvR2gtda23KhxyBtlVn7YxzVE7kQyqR8NgMvbHR4NolWdVnAOm979Ic/
         bg3LL1B6mM+xvPpUuvtqar4snCRkykqlFFFBOfuzfJVPp+OxdamHs+njGQthGQ9QTRjg
         Rntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714111815; x=1714716615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJ1GdTZvweAfdVmldBDNtC2yfd/6DMLGLYkaIty7Abc=;
        b=f42HpfmmVHHdq+jwOZDjnniG0IoAFRBp08m8soUnH5b4sNEaeZ2IECldAOBlVruAXy
         qp/RDulUeoQE5P6fuY3+u8puSXPca/DRNshe9LZk1pWlS1w+K9SJd2W550ZLvdVGvee9
         Cr0Pl/FNu9CQyOj9F2r63K7ryrVlE/IdGSwfKXpsEZRdWut8szY8LSUX+bBvp7X9zxzo
         Y6wKh0293Uy/7U4IY1cT30yX1yu5BO5TfUIAu5x5hyhLbsxeVHbqPiLK7UEYzhyjUBEH
         hIxV2xzTbviI3sVlD4ygBsSTxMPZvmScbik1mO3oNv2X9vzAo0dK/bcYZ6I86IXe9QIm
         29jg==
X-Gm-Message-State: AOJu0YzXvov1VsMkLioHFtkbn0Ur1VZ5Jps7hKZ8YB7L5xbdq1pa5hfW
	AjLjIdDG6erVGo4p/6i1d/hGo4Tzsqc1Y81VBfqcXhTr2DO0t3vW9tqTMlRy0dR8E77pZDjOWT7
	J3ZvzLg==
X-Google-Smtp-Source: AGHT+IGqT4BQLhS1EccC/yb4gJT4fZ83/SEZHaYKLBbvve/r5PoI8jUZCiqtXaDNClg7d4gfijqg5Q==
X-Received: by 2002:a05:690c:f06:b0:61a:b23a:fb03 with SMTP id dc6-20020a05690c0f0600b0061ab23afb03mr1868957ywb.45.1714111815449;
        Thu, 25 Apr 2024 23:10:15 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id l64-20020a819443000000b00614f87bd41asm3961035ywg.56.2024.04.25.23.10.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 23:10:15 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1928144276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:10:14 -0700 (PDT)
X-Received: by 2002:a25:b1a2:0:b0:de5:4eef:542d with SMTP id
 h34-20020a25b1a2000000b00de54eef542dmr1914263ybj.57.1714111813984; Thu, 25
 Apr 2024 23:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net> <8c55dba5-6308-685e-13da-e728197d8101@quicinc.com>
In-Reply-To: <8c55dba5-6308-685e-13da-e728197d8101@quicinc.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 26 Apr 2024 08:10:02 +0200
X-Gmail-Original-Message-ID: <CAAObsKD4-k7Ya4Mi=vEPaC9DucbnVGDO5SaEUt-_o2_Bg+_FgA@mail.gmail.com>
Message-ID: <CAAObsKD4-k7Ya4Mi=vEPaC9DucbnVGDO5SaEUt-_o2_Bg+_FgA@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 8:59=E2=80=AFPM Jeffrey Hugo <quic_jhugo@quicinc.co=
m> wrote:
>
> On 4/24/2024 12:37 AM, Tomeu Vizoso wrote:
> > If we expose a render node for NPUs without rendering capabilities, the
> > userspace stack will offer it to compositors and applications for
> > rendering, which of course won't work.
> >
> > Userspace is probably right in not questioning whether a render node
> > might not be capable of supporting rendering, so change it in the kerne=
l
> > instead by exposing a /dev/accel node.
> >
> > Before we bring the device up we don't know whether it is capable of
> > rendering or not (depends on the features of its blocks), so first try
> > to probe a rendering node, and if we find out that there is no renderin=
g
> > hardware, abort and retry with an accel node.
> >
> > Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> > Cc: Oded Gabbay <ogabbay@kernel.org>
>
> I hope Oded chimes in as Accel maintainer.  I think Airlie/Vetter had
> also previously mentioned they'd have opinions on what is Accel vs DRM.
>
> This gets a nack from me in its current state.  This is not a strong
> nack, and I don't want to discourage you.  I think there is a path forwar=
d.
>
> The Accel subsystem documentation says that accel drivers will reside in
> drivers/accel/ but this does not.

Indeed, there is that code organization aspect.

> Also, the commit text for "accel: add dedicated minor for accelerator
> devices" mentions -
>
> "for drivers that
> declare they handle compute accelerator, using a new driver feature
> flag called DRIVER_COMPUTE_ACCEL. It is important to note that this
> driver feature is mutually exclusive with DRIVER_RENDER. Devices that
> want to expose both graphics and compute device char files should be
> handled by two drivers that are connected using the auxiliary bus
> framework."
>
> I don't see any of that happening here (two drivers connected by aux
> bus, one in drivers/accel).

Well, the text refers to devices, not drivers. The case we are talking
about is a driver that wants to sometimes expose an accel node, and
sometimes a render node, depending on the hardware it is dealing with.
So there would either be a device exposing a single render node, or a
device exposing a single accel node.

Though by using the auxiliary bus we could in theory solve the code
organization problem mentioned above, I'm not quite seeing how to do
this in a clean way. The driver in /drivers/gpu/drm would have to be a
DRM driver that doesn't register a DRM device, but registers a device
in the auxiliary bus for the driver in /drivers/accel to bind to? Or
are you seeing some possibility that would fit better in the current
DRM framework?

> I think this is the first case we've had of a combo DRM/Accel usecase,
> and so there isn't an existing example to refer you to on how to
> structure things.  I think you are going to be the first example where
> we figure all of this out.

Yep, I will be grateful for any ideas on how to structure this.

> On a more implementation note, ioctls for Accel devices should not be
> marked DRM_RENDER_ALLOW.  Seems like your attempt to reuse as much of
> the code as possible trips over this.

Indeed, thanks.

Cheers,

Tomeu

> -Jeff

