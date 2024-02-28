Return-Path: <linux-kernel+bounces-85422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F045D86B5B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6ABB2885E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A7F13541F;
	Wed, 28 Feb 2024 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPHRCKu0"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838F6EF17;
	Wed, 28 Feb 2024 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140672; cv=none; b=B4gkyX6i7BAVIxYbK/ugrareJaHeRQklc+qBLfo97HkTFpetzEWyGXNZiMLYJeXGtVS2rIUXZYcOxf5qdPOIBycHw3HtapVLEKOxE1mbvEMy85OJ4CZ3oEX2+3dUTYy4tKZ+feF/g0BEjnAV20BQmpyQ3esh5ZyrGLspTVYUfD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140672; c=relaxed/simple;
	bh=xocoGi8jKEcXqPEtTlyaHDUAiTj4nvNkNUKJpHO28io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3mJax1JmMv88+XdxhRsKcKRUgYggR3FRKq6pYxb8BUQLHF1l/eLVGfNxRNfCuYNANrBu1y6uDQer10k8DC3rxcsxcnb4PrDC9vonnUA92LMkcC9yxdcofRMtt6A9N4VHAGO0HnYsd9RbM7OQJu68BTwNonwMVyLGp1voy+Daoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPHRCKu0; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28a6cef709so2672666b.1;
        Wed, 28 Feb 2024 09:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709140669; x=1709745469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xocoGi8jKEcXqPEtTlyaHDUAiTj4nvNkNUKJpHO28io=;
        b=lPHRCKu0dQiur2urFt/phjmcxUJ1wizPoJ/ifvAs4ylJD1oh/AK7plFtjonha06gZV
         TzsMlfPiXb56TLxNpOv2D3l6PKApPqNAtobaicTYZooPRUk9OccuuJCu+aSnAlJBcBHZ
         9AKpF6V2SZFTFPb1MRNf7aA8jkyG7OC5TJsvPJ8GTUOwateT9GHbs5q0R9e9jlBdClOB
         MnUfUHoediAY0r44rMe7pnr9Ddbe6IpFTHqnyiFQ/jo53nqqIXRLbGWGPKE0k7EbJFCT
         LiMyLSWPMA84PPvlQsLR+AJgODOBlRd3VY0iLbP3GWYABgpecnbo3CGU0nr7yK8GxxGq
         AE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709140669; x=1709745469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xocoGi8jKEcXqPEtTlyaHDUAiTj4nvNkNUKJpHO28io=;
        b=UoUIpZFZBhvmLxBy1kyz9AufZ0NNA7LN67UWCV0Jw7IwWcMIbjmLvTngClC2l7IZPd
         xGc13hJLGtj6VSxxR0xK0JrCXElxnXGWhve+aLeFZkGotxjmYDjLEWbvjhNkDJ3TAfQq
         XieSYyzwzrSLGDZ3OfIZWwSauQZAwqbAsnUIPuhZSmLi3BHc5Fb6y+LX6vIigZhzjkgX
         +bgYK3QX8AeBEtb8sKCX4rtbFrf3TULYUE6I3wZ6kDiNP8k0iPV0w8N3SU7HAffKmNmh
         MEzVu/VBcAZaFDlUFJ4dkvBPFk/fBZVwZHQt+/lIRtykuddPuNSyt/URrtzmGteAc8oy
         UFbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnFbn9LLiZXuKRJ76DNHGzPpGh91ir7yf3Urc0Sgdsm3voLjbFePYh/6++hkUrLfDDGGCbfNHJN+IvXRomOuLD7v6q6UfV22GCdMrbGwGcGNFNP2kQ3sX7RUMG+p1PZDZtCjI+XY54gf5l92HH7dkxi8Ki2p/Q100v3L7r+m7i3OJ++9nU
X-Gm-Message-State: AOJu0YyquCUlTk/5jyNK1OHBldY/WyxGjb/KLeKxZROmBeP9joQL2evM
	WliaQW1VGJjg3Rx/2RqG3mjwexEcPhezhOpwRFevUl9O8eoGq+/PqfhtuR0o6yCer4mn2fQhW1W
	SHb4iXyx9BZVKZXDasBR53lChF9c=
X-Google-Smtp-Source: AGHT+IFjbMeUiMmh+ASt59pWEkhNEGqIxUc5Cn9H7DqKZvTv9qyojAX2JuTlbI9fMFKSxGAxUhpxUu34ayPjbjE+CM8=
X-Received: by 2002:a17:906:c353:b0:a3f:52dc:7872 with SMTP id
 ci19-20020a170906c35300b00a3f52dc7872mr214495ejb.62.1709140668947; Wed, 28
 Feb 2024 09:17:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227013221.21512-1-zhi.mao@mediatek.com> <20240227013221.21512-3-zhi.mao@mediatek.com>
 <CAHp75VciCJuoOwC8ozanWYqSCM=vWpiaqymJ2-gQfrSt5Ts6fQ@mail.gmail.com>
 <b4889fad324ec88eb3a22f51b0aa512cc93bd2cb.camel@mediatek.com>
 <CAHp75Vd=X9e4rOJabF4AbzGRZAF4BiNJa-C4ivOoQb7kAMy3vQ@mail.gmail.com> <Zd8g81wBXyfMvPhB@kekkonen.localdomain>
In-Reply-To: <Zd8g81wBXyfMvPhB@kekkonen.localdomain>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2024 19:17:12 +0200
Message-ID: <CAHp75VfXY=Hv_o_CYe8sNYoBa1vtYWuk4Sz1M91XUp0cf4HjnA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] media: i2c: Add GC08A3 image sensor driver
To: "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
Cc: =?UTF-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>, 
	"heiko@sntech.de" <heiko@sntech.de>, 
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"yunkec@chromium.org" <yunkec@chromium.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>, 
	"gerald.loacker@wolfvision.net" <gerald.loacker@wolfvision.net>, 
	=?UTF-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?= <shengnan.wang@mediatek.com>, 
	"hdegoede@redhat.com" <hdegoede@redhat.com>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	=?UTF-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?= <Yaya.Chang@mediatek.com>, 
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

On Wed, Feb 28, 2024 at 2:03=E2=80=AFPM sakari.ailus@linux.intel.com
<sakari.ailus@linux.intel.com> wrote:
> On Wed, Feb 28, 2024 at 11:22:13AM +0200, Andy Shevchenko wrote:
> > > Another, I also reviewed some other sensor driver code(such as
> > > gc0a08/gc2145 and imx/ov), they are all the same.
> >
> > They are also problematic. So what?
>
> The situation is the same in a large number of drivers, also outside the
> media tree. It's also not trivial to figure out which header should be
> included and it tends to be that if it compiles without warnings,
> developers won't bother trying to figure out what should still be changed=
.

I spent about 20 minutes reading the code. Yes, for inexperienced
developers it can take 3x longer, but still, much longer time was
spent on writing that code to begin with. So, the headers are a part
of the evolution of the code. And now it's pure technical debt with no
excuses to not fulfill.

TL;DR: It's (rightfully) assumed that the developer *knows* their code.

> I wonder if this could be automated by using the C preprocessor and a
> small Perl script. :-)

There is a Google project coming from Clang people or so, but I have
no idea of the state of affairs.


--=20
With Best Regards,
Andy Shevchenko

