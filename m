Return-Path: <linux-kernel+bounces-17419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C414824CEF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353D1286DF8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD72520EE;
	Fri,  5 Jan 2024 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl7EGVya"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA71FC8;
	Fri,  5 Jan 2024 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-55668ccbb87so335430a12.1;
        Thu, 04 Jan 2024 18:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704421694; x=1705026494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccOiYM9FLrb1L7l+W0Hq9BB2myR49TNvkRfKeDKACIo=;
        b=Zl7EGVyao7t6KXhBV4vTEdGyN9y0N60cwP5Bn2xb0gzNWpWR+jEvRw8B6X9pbokzn2
         m855+xSSwjyfr/cf6vJvVCMIK7Qs3HaI7NT/wARYrmmPA88xGFR4O7BsdSjMu3TPpbtc
         qYmp0ODh+nVjc6uqMN8HGK1b9pdRmwGZ4doS/ABpLaWRjeLkGrjyYTdOAz6jIlUMnq+A
         uL1pEzizbvUKEvo6+NEHQzbNOcVMMZD+ppUZCPwRh89cc2NyoQdOYHvMJi25KYuKuhEX
         7m7F/stGAAKCVnEQHD5uttzKhTxos8mohTTbjkxrKLL4fYBgHVXJwe1GpwTc7IRAHLmR
         LB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704421694; x=1705026494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccOiYM9FLrb1L7l+W0Hq9BB2myR49TNvkRfKeDKACIo=;
        b=toneSY0VBEib99m5ZpyEVmp1epIuXE/bFukj/HSE64KG1Cpwqz8xtThVDk24sXLUt8
         L+awoLrOcjNrwyRajPJ+LeR/ddvD3JOes6IRcjCduCgg+ZmoVSxROq/tP+k7N2UW3pgM
         LyH8poMLHNOSwZGcCZmPYqezMvelGsgH+kHXGeFB9r2yS/0+dJC6akPGLfhTVwbJTiYN
         z0xd4KfHODCbeOQs2YIst8T8aNm/nyL9C9jvmttz3CalmYWtn4mE0go8nCWGlsB8N6Kl
         7irygPVbU4iQChU7t5FvwW2j/kKXQVYFFVBo9YFRzWiTNbSh9qgaaGxtiIvgHJGKIB33
         K3uA==
X-Gm-Message-State: AOJu0Yxu9dB3yuy27wUd5P778j/I8EIehhFS7qdZo3QajZtIrCFUPt8y
	XMftX/FNHu9qlen4Ls+gbC/w2qYE24DEDHCeVi8=
X-Google-Smtp-Source: AGHT+IH7vLeO1VzORIF4y45mxMnkYzbKl0chApOBZroiwKHiy6VxpzABtQeC3XXhUSOho+a1mfsL7Wm3qo+VIbr/OjY=
X-Received: by 2002:a17:907:94c3:b0:a27:e2fc:5a67 with SMTP id
 dn3-20020a17090794c300b00a27e2fc5a67mr1618282ejc.7.1704421693620; Thu, 04 Jan
 2024 18:28:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104024244.12163-1-Wenhua.Lin@unisoc.com> <20240104024244.12163-2-Wenhua.Lin@unisoc.com>
 <CAHp75VfdCHnPovC+LJyVsh=SGTLXDoDowd+0z+0J-wDF2_yjCQ@mail.gmail.com>
 <CAB9BWhc0WyvMMudKcpuOw3=hqiWrC4e47fri6ywqYojULHnAdQ@mail.gmail.com> <CAAfSe-t3mj7ngwL_EZkp=YNWVdb1HhHjY6OY_xFWXieBp0vmOQ@mail.gmail.com>
In-Reply-To: <CAAfSe-t3mj7ngwL_EZkp=YNWVdb1HhHjY6OY_xFWXieBp0vmOQ@mail.gmail.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Fri, 5 Jan 2024 10:28:02 +0800
Message-ID: <CAB9BWhdE3G7P=g4C-kLhE96+GnMNOjnNNP8LszjHhY83e=ojFg@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] gpio: eic-sprd: Keep the clock rtc_1k on
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Wenhua Lin <Wenhua.Lin@unisoc.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 10:18=E2=80=AFAM Chunyan Zhang <zhang.lyra@gmail.com=
> wrote:
>
> On Fri, 5 Jan 2024 at 10:11, wenhua lin <wenhua.lin1994@gmail.com> wrote:
> >
> > On Thu, Jan 4, 2024 at 9:00=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Thu, Jan 4, 2024 at 4:43=E2=80=AFAM Wenhua Lin <Wenhua.Lin@unisoc.=
com> wrote:
> > > >
> > > > The eic debounce does not have a clock of rtc_1k in the sleep state=
,
> > > > but the eic debounce will be used to wake up the system, therefore =
the
> > > > clock of rtc_1k needs to be kept open.
> > >
> > > ...
> > >
> > > > +#define SPRD_EIC_DBNC_FORCE_CLK                0x8000
> > >
> > > BIT(15) ?
> > >
> >
> > Yes, writing 1 to bit15 of the register can ensure that the clock of
> > rtc_1k remains normally on.
>
> Andy's comment means that you should use BIT(15) instead of 0x8000.
>

OK, thank you very much for your explanation, I will make changes in patch =
v4.

> >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko

