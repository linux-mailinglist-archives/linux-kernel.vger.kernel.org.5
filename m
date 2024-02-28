Return-Path: <linux-kernel+bounces-85506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9A186B6C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A81B20E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5915F79B94;
	Wed, 28 Feb 2024 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3dRhrQ5"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C9F79B86;
	Wed, 28 Feb 2024 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143614; cv=none; b=W8+kSYafaUihM2spSDcynO1a00gmUw7f3jxSeJeB7YNUOvts3DF0K6LAfUEkGWuV8fwz3+o8X47jNb+pm4rxQmFmjbZes/qGQyPeBOWIeDTFESY5/ftfF4/igWUoleYLpiD8d++OVxdxBiHwLlWezFSWK47QNEzCbEuJpcI8lnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143614; c=relaxed/simple;
	bh=Geinf3iXIsRtEPoobTh+JUtNobeS9O6vzLYAbzH6HdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIp3A2dwYI9JTOqI7XK3/BnrScVr3ip+7E2es8Ttb+zjUPJDbG8FV9jrAJM5IHT2GTrMkbwFuDn6D1tQZjFW9IZ6yFDfUkPcvdj5THsnxW4w+WqP1lpDh9MOGkV5A4HqEFaK9AQy++YlkTmgUdL/3Ct//HrVaH74Fv1h1YTmB28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3dRhrQ5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3e8c1e4aa7so10462566b.2;
        Wed, 28 Feb 2024 10:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709143611; x=1709748411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Geinf3iXIsRtEPoobTh+JUtNobeS9O6vzLYAbzH6HdU=;
        b=e3dRhrQ5nEFQTfJ5BOZgNbWOaevnwftwYnimwno6c+9bT8k/gf4G3jGUInw8AUVyqn
         uJtp79YdUPOfZzHn9LJi7uLXiZ/kf1BhbCvTsjkyYCMufi7KST4MhlVA74Xup0+Kcd0v
         O+X/DqrXUYORPdLz5spA7Mfoyhbhe8fi4gzAEqv1bJFNbz0DBWMJKtbRgVZi8kUO90vW
         zBSKZBsIXeSgpUmtKtk7Da4HZPHW0kcj3t2TS+Lrrm2nPuZWI8/XBzIWANXol+iNCRQ9
         tvaJ9Pk6X0MTp3UivlZkHetB6Ul8Y+b+ckE0FP7frEa0Nr7QW+o6B0XjdYtzN+7jZm41
         vRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143611; x=1709748411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Geinf3iXIsRtEPoobTh+JUtNobeS9O6vzLYAbzH6HdU=;
        b=nu3ryhoGWQtBl0KF0OXxsZUxFWfOsf8soAhpyY1eLdlLlPLyHgtRk30rfPLNp/ZoPz
         V+5/+neElEMdNKmTtuQZH0P7x3UCBzcqnfEhoxQwTM0Zr7PLFYd16Ne1ozI2s+0whTCZ
         NVQm27/FHXUC8RS1VoHWH1tsv/2lnK2NrCXv66N9cu9zOxNYcPSkNBf/O+aTNrD7RnAU
         4bcmTVaubrhHDhdNtSnol2HOjGahQvVDgTSNqmuIi0YfH5KF1LU0gEGHqYgJV/KqtBQ0
         FDK8BTxtqUBBsrZuusO7bXRviV7AvR019jvVNwPANy8OvXWnRvMEQMywTdKO+vUK9tX8
         r2/g==
X-Forwarded-Encrypted: i=1; AJvYcCXyhL9/dvHSfsq2VZKl58xfrZKmIuGRrBK6uS3cCjgY9WFU6rvXR3cpwmdnYKRBBFNq/3ufGVOYnZScNLtQEXZX1cJnaovopor0GO4DAcrjQi7m94ojvqtMiFlkrOUEvWBnWUaqdfSUzOKRBAuL8+HrrhVPxERmRVNj8okkzvXdNWCEdZMi
X-Gm-Message-State: AOJu0Ywlj5mytFXXF7y8xzmty0iabFX5RQ5AB+5kxH9hFvcxjliJOvRq
	/0Om4UoUWvprFPyBuFJWpVgK/gI0RuitK0t4QvbqLqYgcLhb68VkiGxbDAIaXzfMeQ5JXG/SFyw
	7zpYJT4mk9pA5dzzp+f142tWTSC8=
X-Google-Smtp-Source: AGHT+IEjnw0tJc9UdPr6IJqBYIx7kpdEGy3PmCOgMXNokVl6z9lw/zArTEKFrql0wiqYP6S2cV4Pdu06JjQh1v2y2DE=
X-Received: by 2002:a17:906:ad99:b0:a43:ebbb:9e78 with SMTP id
 la25-20020a170906ad9900b00a43ebbb9e78mr339746ejb.55.1709143611218; Wed, 28
 Feb 2024 10:06:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227013221.21512-1-zhi.mao@mediatek.com> <20240227013221.21512-3-zhi.mao@mediatek.com>
 <CAHp75VciCJuoOwC8ozanWYqSCM=vWpiaqymJ2-gQfrSt5Ts6fQ@mail.gmail.com>
 <b4889fad324ec88eb3a22f51b0aa512cc93bd2cb.camel@mediatek.com>
 <CAHp75Vd=X9e4rOJabF4AbzGRZAF4BiNJa-C4ivOoQb7kAMy3vQ@mail.gmail.com>
 <Zd8g81wBXyfMvPhB@kekkonen.localdomain> <CAHp75VfXY=Hv_o_CYe8sNYoBa1vtYWuk4Sz1M91XUp0cf4HjnA@mail.gmail.com>
 <170914163823.252503.15921889437591940623@ping.linuxembedded.co.uk>
In-Reply-To: <170914163823.252503.15921889437591940623@ping.linuxembedded.co.uk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2024 20:06:14 +0200
Message-ID: <CAHp75Ve=gRhRMN-3JyEZ3EX3oU72buGhGTx6jukgwOzO=KRjNA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] media: i2c: Add GC08A3 image sensor driver
To: Kieran Bingham <kieran.bingham@ideasonboard.com>, Jonathan Cameron <jic23@kernel.org>
Cc: sakari.ailus@linux.intel.com, =?UTF-8?B?WmhpIE1hbyDmr5vmmbo=?= <zhi.mao@mediatek.com>, 
	"heiko@sntech.de" <heiko@sntech.de>, 
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"yunkec@chromium.org" <yunkec@chromium.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>, 
	"gerald.loacker@wolfvision.net" <gerald.loacker@wolfvision.net>, 
	=?UTF-8?B?U2hlbmduYW4gV2FuZyDnjovlnKPnlLc=?= <shengnan.wang@mediatek.com>, 
	"hdegoede@redhat.com" <hdegoede@redhat.com>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	=?UTF-8?B?WWF5YSBDaGFuZyDlvLXpm4XmuIU=?= <Yaya.Chang@mediatek.com>, 
	"mchehab@kernel.org" <mchehab@kernel.org>, 
	"jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>, 
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	"10572168@qq.com" <10572168@qq.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 7:34=E2=80=AFPM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
> Quoting Andy Shevchenko (2024-02-28 17:17:12)
> > On Wed, Feb 28, 2024 at 2:03=E2=80=AFPM sakari.ailus@linux.intel.com
> > <sakari.ailus@linux.intel.com> wrote:
> > > On Wed, Feb 28, 2024 at 11:22:13AM +0200, Andy Shevchenko wrote:
> > > > > Another, I also reviewed some other sensor driver code(such as
> > > > > gc0a08/gc2145 and imx/ov), they are all the same.
> > > >
> > > > They are also problematic. So what?
> > >
> > > The situation is the same in a large number of drivers, also outside =
the
> > > media tree. It's also not trivial to figure out which header should b=
e
> > > included and it tends to be that if it compiles without warnings,
> > > developers won't bother trying to figure out what should still be cha=
nged.
> >
> > I spent about 20 minutes reading the code. Yes, for inexperienced
> > developers it can take 3x longer, but still, much longer time was
> > spent on writing that code to begin with. So, the headers are a part
> > of the evolution of the code. And now it's pure technical debt with no
> > excuses to not fulfill.
> >
> > TL;DR: It's (rightfully) assumed that the developer *knows* their code.
> >
> > > I wonder if this could be automated by using the C preprocessor and a
> > > small Perl script. :-)
> >
> > There is a Google project coming from Clang people or so, but I have
> > no idea of the state of affairs.
>
> I've used iwyu (include-what-you-use) successfully on libcamera. But I
> don't know how this would translate to working on the kernel, with a
> more complex build system.

Jonathan tried that once. It needs to be heavily tweaked to be used in
the kernel project.

> But indeed, tooling already exists [0] to do these checks, and is package=
d
> in distros [1]
>
> [0] https://include-what-you-use.org/
> [1] https://manpages.ubuntu.com/manpages/focal/man1/iwyu_tool.1.html

--=20
With Best Regards,
Andy Shevchenko

