Return-Path: <linux-kernel+bounces-20926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6904282877A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179EA2864E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222CC39852;
	Tue,  9 Jan 2024 13:57:43 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142538FA3;
	Tue,  9 Jan 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbe78dbd1aso348611b6e.1;
        Tue, 09 Jan 2024 05:57:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808660; x=1705413460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJHgvOFzSW+JX3OnOy35lWmNxPoI3R11S86tQorDHH0=;
        b=DLrKJHtVG5KsYRHf2FQJXiI7N+CvxcwwV2lrZIxDDYaupXYtwFgr5+U4ImvI9QtAuW
         g/qBFqd1+LqrHTHjrMGQhMzEfX94kZIUVrnou+KfD+rRgKkGbUwmLpyQudvH72JPUNsu
         rtb7WPTSjKudrYCkuk9+iB1wN/AO3qb9V1En51rUPYfs3PEwwtW5YIuogkO1L2Lgv80Y
         hgKVDPvoUYXMcbBgPbm6Ez+9RH5dsXqVAFodKN1KT2IwvGhBxB4c77KrA4tW3x0GDykq
         bmXUP/aeTqx6ztpDI3oy+4ho3vPwo03rjW5nXr6vN948pLt66jpnzNaPpPuFts9uJo0B
         HWaQ==
X-Gm-Message-State: AOJu0YyJ3ntPXy7SpbNyRNgd3gqGybkftZLVxBnekkW0c2g+xu3zIMT5
	a6G3/muyHb4ebT3rD8STJB/J/k7KEH38w0VbnK8=
X-Google-Smtp-Source: AGHT+IEFYMQhUKEmFNS7nfNb1EAhYvSqIBMprKgVBkg9Vy+ACaB3INvDtbMYdXs1Ax8YyGBm5pfYkEsl24hSW3bH8X0=
X-Received: by 2002:a05:6870:65aa:b0:206:5411:f97b with SMTP id
 fp42-20020a05687065aa00b002065411f97bmr2250765oab.4.1704808660361; Tue, 09
 Jan 2024 05:57:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105181118.116292-1-erick.archer@gmx.com> <b12b56a9-2d20-4802-bbc8-43f4831b3113@embeddedor.com>
In-Reply-To: <b12b56a9-2d20-4802-bbc8-43f4831b3113@embeddedor.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jan 2024 14:57:29 +0100
Message-ID: <CAJZ5v0iXindsbwBJsiknXxLrq=94rq3p=H_ux2pGpqzmjyRWkA@mail.gmail.com>
Subject: Re: [PATCH] PM / QOS: Use kcalloc() instead of kzalloc()
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Erick Archer <erick.archer@gmx.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 7:17=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 1/5/24 12:11, Erick Archer wrote:
> > Use 2-factor multiplication argument form kcalloc() instead
> > of kzalloc().
> >
> > Link: https://github.com/KSPP/linux/issues/162
> > Signed-off-by: Erick Archer <erick.archer@gmx.com>
>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied as 6.8-rc1 material, thanks!

> > ---
> >   drivers/base/power/qos.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> > index 8e93167f1783..bd77f6734f14 100644
> > --- a/drivers/base/power/qos.c
> > +++ b/drivers/base/power/qos.c
> > @@ -201,7 +201,7 @@ static int dev_pm_qos_constraints_allocate(struct d=
evice *dev)
> >       if (!qos)
> >               return -ENOMEM;
> >
> > -     n =3D kzalloc(3 * sizeof(*n), GFP_KERNEL);
> > +     n =3D kcalloc(3, sizeof(*n), GFP_KERNEL);
> >       if (!n) {
> >               kfree(qos);
> >               return -ENOMEM;
> > --
> > 2.42.0
> >
> >

