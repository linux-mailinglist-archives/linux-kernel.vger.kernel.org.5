Return-Path: <linux-kernel+bounces-16204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23409823AAC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA17728684F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215A43D63;
	Thu,  4 Jan 2024 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHgfAuZs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CA54C60;
	Thu,  4 Jan 2024 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-40d87e9151dso162105e9.0;
        Wed, 03 Jan 2024 18:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704335507; x=1704940307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzz4kPTsnRWLGGf8mkZ9HFr+CQbeOz3xOX8NXuLLLhE=;
        b=WHgfAuZs5odI4di9GPBvoNw/ad74o9Ezs2piWD3BFOBe2lyLVwKSXdzZPPlEQpC4t5
         IqmZM9aqrRIx7XNUpeyVbcVwgj5p/ZFBatSuM0JX4WR72DT0OswrRG1V4grgS249BEaV
         Egd0skKDH9SpbmFUSAS5B8S95yTC7KgleMx6a96GIRdEMGtn51yKDsTwGl3A1Ski6Eep
         gH7I27B26RPqw5VwGAdPFdw9BqgGXHQUZb5uA/shfgUsrY+f7CM7x0I7orYDIHEQZHe5
         sLItNC+K3g9M/3Q+1ainvJRUxJ+EAv03/JQ+XFVRty5pFP27POlc6soIfPluxY4YIVk5
         Zh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704335507; x=1704940307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzz4kPTsnRWLGGf8mkZ9HFr+CQbeOz3xOX8NXuLLLhE=;
        b=qOytpmDqRwLu+5m4jpqAt6NeKA0VLKPvs7gTECJwl+5iu8EU8y619Y2WLHeoHrzYrP
         WM+eQTObfo87XaDNvIK3x3WPFJT8RgJfSh6XmnhfK1rrE0hEstgNvUnOwtHxooff3LT4
         Et03+DMPuJcSrdtFQ6Pq4wjPFJjLDoAbDkZ0xm8BqfxVtE8Bn/wAxjEZ3A+HAV34Ywxc
         vgG1fr/Ml4rwKo3xRy7Wyha19gUZloxdF3iHTe5/8LSsnAJ/+wIYV70DDg9YyB/MEcfG
         eSjuNnTb3SEiWBZzIcdI0ai91CzBgAjQ3CrsTDWB4eKX1RPme11GfJcNqPdpw7w0h7oq
         +fNA==
X-Gm-Message-State: AOJu0Yye1lkDESLGI9nf+ZMbPnup9P0sZmlxt9xxzz6L3l4f+RG4e+cs
	olsN5oeXQ/iug5sSuL14Xa8XAEp6ksBAspByobE=
X-Google-Smtp-Source: AGHT+IER8wdGd012f1RsAVUeFQYVW48liC7yw+qnDZ2kU8M3DY+UH0lvWNrNc0uskiGZQpvOzpgognHk8dpQCOzTdPM=
X-Received: by 2002:a05:6000:402a:b0:336:ee9e:fe15 with SMTP id
 cp42-20020a056000402a00b00336ee9efe15mr17128184wrb.3.1704335506622; Wed, 03
 Jan 2024 18:31:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921090027.11136-1-Wenhua.Lin@unisoc.com> <20230921090027.11136-4-Wenhua.Lin@unisoc.com>
 <ZQwomPRn0HaqHMgK@smile.fi.intel.com>
In-Reply-To: <ZQwomPRn0HaqHMgK@smile.fi.intel.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Thu, 4 Jan 2024 10:31:35 +0800
Message-ID: <CAB9BWhf2BqkA8DG2m+K=_oBo_zymZwmejnxyaC6wLZHD4HZ3dA@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] gpio: sprd: Modify the calculation method of eic number
To: Andy Shevchenko <andy@kernel.org>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 7:27=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> On Thu, Sep 21, 2023 at 05:00:26PM +0800, Wenhua Lin wrote:
> > When the soc changes, the corresponding gpio-eic-sprd.c
> > code needs to be modified, and the corresponding
> > Document must also be modified, which is quite troublesome.
> > To avoid modifying the driver file, the number of EICs
> > is automatically calculated by matching dts nodes.
>
> > Fixes: 2788938b7946 ("gpio: eic-sprd: Make the irqchip immutable")
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
>
> Same comment as per patch 1. Also, fixes needs to be grouped at the begin=
ning
> of the series. (I don't remember seeing Fixes tag in the patch 2.)
>
> ...
>
> > +#define SPRD_EIC_VAR_DATA(soc_name)                          \
>
> Misindented \

Thank you very much for your review.
I will fix this issue in patch v3.

>
> > +static const struct sprd_eic_variant_data soc_name##_eic_dbnc_data =3D=
 {       \
> > +     .type =3D SPRD_EIC_DEBOUNCE,                                     =
 \
> > +};                                                                   \
>
> ...
>
> >       struct sprd_eic *sprd_eic;
> >       struct resource *res;
>
> >       int ret, i;
> > +     u16 num_banks =3D 0;
>
> Preserve reversed xmas tree order.

Thank you very much for your review.
I will fix this issue in patch v3.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

