Return-Path: <linux-kernel+bounces-19143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 679918268B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0474C1F21CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECC8C09;
	Mon,  8 Jan 2024 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXJYvnte"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD88BEB;
	Mon,  8 Jan 2024 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-55760f84177so175996a12.0;
        Sun, 07 Jan 2024 23:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704699421; x=1705304221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMUTVEWLD9rAe8ABai7E5sFz8lZUsa+4VnMsezRlEsE=;
        b=WXJYvntedVLtcTZjTSmSo6ia3HF8J4LHK0Y1NhM7WaApTuwAKI26EdLdJ4lZcK1R9a
         vyKE0h+VjXANayJTuoTIy08xFkrn0lHr+3shIJviE20BsBfB77fpzvZ94kTLsf0S59g1
         LPGRnj0jhZyQqPSjEWFSvJ1FGCHDF3LJeAUUu/EbClFePapo8kZvZcS3zpzuU/NGbhdO
         gCV0aPtWh2fy6jplfZPobUKsp063UuCdTKLCeZL4r4NFnwgDKaIGBhUgqUBorqH29jmy
         4WFwH6u5bXqcirmSaaA9mhnLJlwWjycaeRDvzmsubpjgRaayWVCIKf8p7IPbYOBZI9QB
         46xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704699421; x=1705304221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMUTVEWLD9rAe8ABai7E5sFz8lZUsa+4VnMsezRlEsE=;
        b=duijXvkTeJaoWdwHRK7TMAMATOe3BKj6q7C5Pnz04vcj1ynB0fv83sPLmhl1uLImfb
         j7nt9Vb/OuND1jorbS49f1yMH5Bw88AyV+G6lSXL1F3BmdCzFlh3iMF2BeML7hwNSk5p
         B7odEmxM/wT2rYB/mld0T+g41wSqOSkk2SoWek+h+BRuNW96jc074KXAuuVAeis9X4hQ
         3zZBcIMotlbGaQkkN7XALG4QPD1zKy6U0cyEt4BRYtpe3emOco+34WZqYJO36Ha/ijPi
         WoQvB7LIby5QpYGyGxcREVq8IGsyIzT605bdwvJpx2SyxlB7PxcLD8RDEgyl5/O0SL0Q
         K5Yg==
X-Gm-Message-State: AOJu0YxEsORWFHPA07GEI2OMEzkfvTRi806NP/HgDaTXdeifBWOCwn85
	+8U2TOiZ8GJjmbBHUSUAExFy7Dg19K8llSZg9KoOzQIWtHZvAg==
X-Google-Smtp-Source: AGHT+IHEpfi8DVMa4mVbICvPsxCEATNAA6QqZIobrWVsB/mXF83As2NP19BBj+NNBcrpRCREpsnJKxWxX3SlZXhdOrI=
X-Received: by 2002:a50:9345:0:b0:557:1b89:4f01 with SMTP id
 n5-20020a509345000000b005571b894f01mr3354909eda.2.1704699420800; Sun, 07 Jan
 2024 23:37:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104024244.12163-1-Wenhua.Lin@unisoc.com> <20240104024244.12163-2-Wenhua.Lin@unisoc.com>
 <CAAfSe-ty=BgDNxST7q=+0CR6pshP4LhgmEPeZLmasiS2UkTjYA@mail.gmail.com>
In-Reply-To: <CAAfSe-ty=BgDNxST7q=+0CR6pshP4LhgmEPeZLmasiS2UkTjYA@mail.gmail.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Mon, 8 Jan 2024 15:36:49 +0800
Message-ID: <CAB9BWhcCyJd5uYgFBEuY4kR+iPam68U6i21UUmhGX-hORH64Pg@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] gpio: eic-sprd: Keep the clock rtc_1k on
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 11:26=E2=80=AFAM Chunyan Zhang <zhang.lyra@gmail.com=
> wrote:
>
> On Thu, 4 Jan 2024 at 10:43, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
> >
> > The eic debounce does not have a clock of rtc_1k in the sleep state,
> > but the eic debounce will be used to wake up the system, therefore the
> > clock of rtc_1k needs to be kept open.
>
> It seems that this issue is not in the latest SoCs. I would suggest
> not changing for the time being.
>

OK, we will delete this modification on pacth v4.

> Thanks,
> Chunyan
>
>
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >  drivers/gpio/gpio-eic-sprd.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.=
c
> > index be7f2fa5aa7b..bdcb3510a208 100644
> > --- a/drivers/gpio/gpio-eic-sprd.c
> > +++ b/drivers/gpio/gpio-eic-sprd.c
> > @@ -24,6 +24,7 @@
> >  #define SPRD_EIC_DBNC_IC               0x24
> >  #define SPRD_EIC_DBNC_TRIG             0x28
> >  #define SPRD_EIC_DBNC_CTRL0            0x40
> > +#define SPRD_EIC_DBNC_FORCE_CLK                0x8000
> >
> >  #define SPRD_EIC_LATCH_INTEN           0x0
> >  #define SPRD_EIC_LATCH_INTRAW          0x4
> > @@ -223,6 +224,7 @@ static int sprd_eic_set_debounce(struct gpio_chip *=
chip, unsigned int offset,
> >         u32 value =3D readl_relaxed(base + reg) & ~SPRD_EIC_DBNC_MASK;
> >
> >         value |=3D (debounce / 1000) & SPRD_EIC_DBNC_MASK;
> > +       value |=3D SPRD_EIC_DBNC_FORCE_CLK;
> >         writel_relaxed(value, base + reg);
> >
> >         return 0;
> > --
> > 2.17.1
> >

