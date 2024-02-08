Return-Path: <linux-kernel+bounces-58721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2177A84EA81
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24741F23DE3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142194F21A;
	Thu,  8 Feb 2024 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3PsG9zX"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21224F5EC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427766; cv=none; b=LUv2PeUZOUPz4Sv11uXVvGADtW4rmYtEZP97sOb3Qgiz+81JXrjlGe1OcU7qf8L1aGoatK7BK+0LrzxzZIvvR8Ch4BwFzP+jGrnXw19H4PrOAnoQJMz329hiy9dnESjbaln6izx6cVPoLTZP+Gsch2V2cGCNmVW7/+LXveLJrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427766; c=relaxed/simple;
	bh=k4Qjd4VTrme/q3N5w4mBZNedSc5IAlaFUDmOanXt4fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qs6e5+rcO1I88IVOS5CmmUXOVoNWC5+afWOra91VuS/PMXsFlv9/Kt782ZKK9H7YCKGjd6Nxt6l9sXIQeKAP3EidHYQo7a7Un9d0prSKD/EWndIO2nmmOQOcbhgdKcBRG+Eoh6YmNe6s69yQni18+fHIBL5QnLu4BCEkHbmuoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m3PsG9zX; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-604b27e3bd2so2707487b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 13:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707427763; x=1708032563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4Qjd4VTrme/q3N5w4mBZNedSc5IAlaFUDmOanXt4fs=;
        b=m3PsG9zX90QhRA6wVavFjgQpHgf7iI3KQ6VuROiaopox+k5Pj6EcRSmU/Sv9c8hvgA
         FwoCrKe0hXpGuDbek2vGGDsxGfHZ44X++SrE20i5vHQqbmrmZI6HsNyAwt6Tsyj9FQUt
         sy4TBacBHZR678Ts8LGGvyk3zxYoPX10uc3371nZgOnT63T84CO6os8DffBjTEaMulid
         JAslF8WFdyVc98uxqx7m7G2uAeH//QO2ObB8yq01EhY2C54ey4xQ7hFIhQBwC2Lj1BiA
         AGswBe+oloAWOav1F5JlnB23YuGxFI+4Jt6D16Dq92fiM5cJhyG7umCVi5EVa+wUaS+P
         R79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707427763; x=1708032563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4Qjd4VTrme/q3N5w4mBZNedSc5IAlaFUDmOanXt4fs=;
        b=goxMQO3eeCf6vg4ym2kE8+HSwH2wQd86r7Igp1SXFbAW04cbfqB1o/5Yc0fnH7dtr4
         INCKXuzV+eEfbhhm2fe9OfzCLWMYVLrBrZRjpIOq077t2hJhOMy6666rV6GMmgqEl7je
         SZIAcagTjAGJEo+83DY6FqHFqoSs1OLnB+ZqhNebL/woDd6jncwHSqfxRbmVXlqE91ed
         nIBGrc1vZTeGlGKnKtMPPSvLsF1C5fwNQETP4YeDMtrcBsq0bFRWY0Pqyyaf16JAnp9N
         Yz3bMd1bBBKak1PcihxhLEXuVNEra1ZQ5oIbGKghUEYRAFkRPg2hx/HBppJ9Wr07e4N0
         YYeg==
X-Forwarded-Encrypted: i=1; AJvYcCUtoGIX9/w2MIgvtdGitXXjNX3BmedBCpD5n6KGhseLi0UxlodUUZvwJMsw8ZNR2+rwPCth4tVP8kGaq1XGdQZDTm73DVbaPiPRLF/6
X-Gm-Message-State: AOJu0YxFhLxWux6hHwYkgM1cK7njDL7Xo94in7xUdkytfYLRYKZ8ZO76
	5PCm5v37Wi1KACT293DOyDjGVcWimVr3seoJvJPtbkGrVMr08lgVZp+HkZGNY1T7+o1WhOXJXH4
	Qv1ttpbclrqei4usF99hPMrzywqeEteveEyRTqg==
X-Google-Smtp-Source: AGHT+IFXP22UNl6HGodNdyxCVyIl57xwSa1qrcuFLa7AiuRdaK1CrwevQo6eVvRY3I8f1f+LXDY+AXrRH8sbZkURbwY=
X-Received: by 2002:a0d:cc47:0:b0:604:4586:4039 with SMTP id
 o68-20020a0dcc47000000b0060445864039mr2737694ywd.13.1707427763661; Thu, 08
 Feb 2024 13:29:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-j7200-pcie-s2r-v1-0-84e55da52400@bootlin.com>
 <20240102-j7200-pcie-s2r-v1-1-84e55da52400@bootlin.com> <20240116074333.GO5185@atomide.com>
 <31c42f08-7d5e-4b91-87e9-bfc7e2cfdefe@bootlin.com> <CACRpkdYUVbFoDq91uLbUy8twtG_AiD+CY2+nqzCyHV7ZyBC3sA@mail.gmail.com>
 <95032042-787e-494a-bad9-81b62653de52@bootlin.com>
In-Reply-To: <95032042-787e-494a-bad9-81b62653de52@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 8 Feb 2024 22:29:11 +0100
Message-ID: <CACRpkdY2wiw1zH8FsEv7S1FW044PBSXpLPqanF5yyH1R4oteEA@mail.gmail.com>
Subject: Re: [PATCH 01/14] gpio: pca953x: move suspend/resume to suspend_noirq/resume_noirq
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, Vignesh R <vigneshr@ti.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@axentia.se>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Tom Joseph <tjoseph@cadence.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, 
	gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
	thomas.petazzoni@bootlin.com, u-kumar1@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 5:19=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:
> On 1/28/24 01:12, Linus Walleij wrote:

> > I guess you could define both pca953x_suspend() and
> > pca953x_suspend_noirq() and selectively bail out on one
> > path on some systems?
>
> Yes.
>
> What do you think if I use a property like for example "ti,pm-noirq" to
> select the right path ?
> Is a property relevant for this use case ?

That's a Linux-specific property and that's useless for other operating
systems and not normally allowed. PM noirq is just some Linux thing.

*FIRST* we should check if putting the callbacks to noirq is fine with
other systems too, and I don't see why not. Perhaps we need to even
merge it if we don't get any test results.

If it doesn't work we can think of other options.

Yours,
Linus Walleij

