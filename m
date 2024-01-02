Return-Path: <linux-kernel+bounces-14153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE1821875
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF5A1F21C8B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E5053A9;
	Tue,  2 Jan 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYvx74rG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378A5C8C7;
	Tue,  2 Jan 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28271c5eb5so2105466b.0;
        Tue, 02 Jan 2024 00:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704184934; x=1704789734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8CwfhciTLcDiE7Z2boNc1lfBQV0c29+edCvxD3xhxw=;
        b=lYvx74rGS2+xGM6c3Z//l6T6BeTRAXsOucdNZtAad71mDcYYZHVgn5bDTHarAKzd7U
         kL6Ha/dSDjFPRHEqE//0yCptVED61e/1VHkgQzhKct61aIOeP3A2scPTZCvJGgazNB+x
         8XPk5hkPE+BuhexrPLV5+gMnoLMM+XjlcWBfhX3A3b8lU0hILFc08FKcz8joLx0oFPSv
         x+Y96yroBBmNMyQk7fXG3odjBWrbH0ie7Ck79uYg57LsTyLqYoUvIzLXdJbo/FsBSFzy
         lmNxuZRWHjlAFnf30+YfJgLKKsKCpnlkpkct3hrV3RL8JKcYp38P/ivrECqj/wnoGs7E
         2qDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704184934; x=1704789734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8CwfhciTLcDiE7Z2boNc1lfBQV0c29+edCvxD3xhxw=;
        b=PX64XSVLKMKnPA3AeQD7yjpyqxAr4liK8XsZ6sxn1zypA70EqOEMGTSG71c89lYA8t
         NJbB+4ZGUeD9ds67Ixiww7KNVP0AEoPwlAaplOaIj5ANOctrS62CWcXnaV1sPwT0h9dt
         Yzt92bM/E2oPARClI64d6ZHexH4+EY544AcHPdwVebwWYzrA6ZsVzDXMqzfrhhcXPlYW
         5Ekf0EmR/4eTkysSyEVY3GcD3YNXyfQwqaGb7RqUNe/eigIySVeEbrvHYoS1e8qacgdt
         37DfP4ry7LaGei2SmE7zJau6F7EiIURpa+W5Ma5f8cPQYch16RD4snKFthEU1fACdHYg
         8cuA==
X-Gm-Message-State: AOJu0YyGQ32RVYbC9xOcv9W4sibmLXDenOGqyP3TdOI5aHq841ih+BqD
	vGYCsyRxNQpp2HQZsazIm951PztFtK+VBX2XIb8=
X-Google-Smtp-Source: AGHT+IF0Je5njR/YwKTdhQb9U6w8Kntqq0Wc5pbJCaNzaq6nIzQOU8CyuYjXOabufWuRIbCfNLe74OjYjOZXwN3njYY=
X-Received: by 2002:a17:906:3a4b:b0:a23:5914:9c6c with SMTP id
 a11-20020a1709063a4b00b00a2359149c6cmr16249150ejf.1.1704184934176; Tue, 02
 Jan 2024 00:42:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921090027.11136-1-Wenhua.Lin@unisoc.com> <20230921090027.11136-2-Wenhua.Lin@unisoc.com>
 <c8b9fef7-e27c-6760-52a8-04045dcdc0ec@linux.alibaba.com>
In-Reply-To: <c8b9fef7-e27c-6760-52a8-04045dcdc0ec@linux.alibaba.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Tue, 2 Jan 2024 16:42:02 +0800
Message-ID: <CAB9BWhdFgEfgPZ4wcz8RZmyqDGQDYKvk+Rt2LSfz4aPd1_u1dA@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] gpio: sprd: In the sleep state, the eic debounce
 clk must be forced open
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 5:08=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 9/21/2023 5:00 PM, Wenhua Lin wrote:
> > In the sleep state, Eic debounce has no clock and the clk of
> > debounce needs to be forced open, so that eic can wake up normally.
> >
> > Fixes: 2788938b7946 ("gpio: eic-sprd: Make the irqchip immutable")
>
> Are you sure this is the right Fixes tag? This commit did not change EIC
> debounce logics.
>
> The changes look good to me.

This modification turns on the debounce clock, and we will modify the
submission
description on patch v3. Thank you for your review.

>
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >   drivers/gpio/gpio-eic-sprd.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.=
c
> > index 84352a6f4973..bfa8a4c7515a 100644
> > --- a/drivers/gpio/gpio-eic-sprd.c
> > +++ b/drivers/gpio/gpio-eic-sprd.c
> > @@ -23,6 +23,7 @@
> >   #define SPRD_EIC_DBNC_IC            0x24
> >   #define SPRD_EIC_DBNC_TRIG          0x28
> >   #define SPRD_EIC_DBNC_CTRL0         0x40
> > +#define SPRD_EIC_DBNC_FORCE_CLK              0x8000
> >
> >   #define SPRD_EIC_LATCH_INTEN                0x0
> >   #define SPRD_EIC_LATCH_INTRAW               0x4
> > @@ -214,6 +215,7 @@ static int sprd_eic_set_debounce(struct gpio_chip *=
chip, unsigned int offset,
> >       u32 value =3D readl_relaxed(base + reg) & ~SPRD_EIC_DBNC_MASK;
> >
> >       value |=3D (debounce / 1000) & SPRD_EIC_DBNC_MASK;
> > +     value |=3D SPRD_EIC_DBNC_FORCE_CLK;
> >       writel_relaxed(value, base + reg);
> >
> >       return 0;

