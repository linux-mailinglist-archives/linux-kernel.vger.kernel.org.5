Return-Path: <linux-kernel+bounces-160320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE68B3BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496A51C23ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D8F14AD3D;
	Fri, 26 Apr 2024 15:42:37 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30DD3610A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146157; cv=none; b=QkdBqVYr2CrANvgWFd8Eolj2aGSmsaNvXZbwKibZv2plMvXD6fx4mLnxUn+GWVR534130Am5fPTzReY+XVlH/SWoivD+lQ/cULBtYP4Q4NeFFxnETeCLrD6icOvR5VmJ06ZMlwvKLWh1Rlw8oJKJ40ESjT1LSTpmNrowvtX+WzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146157; c=relaxed/simple;
	bh=qpHQbn/SaC7jqpgIryzZAJsu+nyqrNFAaLzGRqyiHlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSEWlBr1dTpxrre5WZ7V7NCereayLs8hSn+9w20v26SHj6w6f41Bd68H6Jz/Gjs7+R4Vn5d8JPg7QQF5GHDNzKtpF5fv6p8pruhAKU4+eEzIpi7tXQIWi90RAJ8+JNIOYrgt07ZQctC5rfFkv4n0OyS7Gi1GnqQic54+efW5EeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-618769020bcso24925667b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714146153; x=1714750953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMcWRPznuA01PMZZ+lXGraQ9C1TAJ99gzxX5MPtCffc=;
        b=DVD3X6nIA5rOMTWLJTjDaoUjD1jKRHu++EmXCt9pOsJVU61mNVxydgjw1uYcrh3iy8
         V9RrsNaWEhvEe4ByupxF4v1Fe9ymdfJBwz5s26lQtm9qnZZINlwk8ZCsvTEtODRUryTy
         X8SsWCpZiW1iFrUc99w4gfxnrPwABmmyP7jMGoSl0mK/tHqurSRSONykK8KaLxoOcuK/
         l1kBFS2kMBWHuy/bzT/LVGAT9CvMa53+xKbuuSaz8ZqNO7PAICRCSJ76yzvOKRKLVzdh
         d06bPofiwiIUiQOxU8UwD87bhuJS51nLWgvv+hkHNzLvkF0fT9oBk46fe4UKiMKiP+Gk
         UYHg==
X-Forwarded-Encrypted: i=1; AJvYcCVuGuu4FThTKUS0RaVhy+H5yykEptklhkHo+GWufv0iKoOoEIPpgCiBKTFK1qjAtjUF4lFOqY1ijjTCERoiyOWrpmAL6tpFDyXo+43P
X-Gm-Message-State: AOJu0YwRJVbk9gE/NKWn784niln4aiEXuhIm1LkdR6ScjSUtX/foIfyi
	2R2sA86U5LEnv9l17EBvVKgx2qmuGUBBzAQLZ0hmwUqlXXhIzXloSarJzg1n
X-Google-Smtp-Source: AGHT+IHxsEUEza7TqtPrt8lDbClqOLgfu4OpcEYAvOXcud9iSvblNOQdreUegDjb9aknXgLI8xs7Bg==
X-Received: by 2002:a05:690c:6105:b0:61b:1b51:371f with SMTP id hi5-20020a05690c610500b0061b1b51371fmr3392600ywb.12.1714146153357;
        Fri, 26 Apr 2024 08:42:33 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id x30-20020a81af5e000000b0061b1f325755sm4106766ywj.123.2024.04.26.08.42.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 08:42:33 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso2288203276.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:42:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6IdpaKuiNQxuHnrmxTblIk5Rl6mv6iAoaCIRoV3EJlYtnbxn2nrgNu6XbWaN+qAPAv2N+YYXfQIcH+xo5DIYT5DCxAW0+j0DOeZZX
X-Received: by 2002:a25:86c2:0:b0:de4:7603:e888 with SMTP id
 y2-20020a2586c2000000b00de47603e888mr3266319ybm.29.1714146152923; Fri, 26 Apr
 2024 08:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230831121623.36293-1-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVoDDV-VgPJL75u_t3KeAPhb1xEFX2VigVC3oS51pG6wA@mail.gmail.com> <ZivJKZ8Pp_bfLcvO@smile.fi.intel.com>
In-Reply-To: <ZivJKZ8Pp_bfLcvO@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Apr 2024 17:42:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVsYdPnFD_LEdDez7JXYdh67DPoc2GhLNv29B6=65u6+g@mail.gmail.com>
Message-ID: <CAMuHMdVsYdPnFD_LEdDez7JXYdh67DPoc2GhLNv29B6=65u6+g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] zorro: Use helpers from ioport.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Fri, Apr 26, 2024 at 5:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Sep 04, 2023 at 11:31:03AM +0200, Geert Uytterhoeven wrote:
> > On Thu, Aug 31, 2023 at 2:16=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > We can use the DEFINE_RES_MEM_NAMED() macro and resource_contains() h=
elper
> > > instead of reimplementing them in the code. No functional change inte=
nded.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/zorro/zorro.c
> > > +++ b/drivers/zorro/zorro.c
> > > @@ -117,17 +117,13 @@ static struct resource __init *zorro_find_paren=
t_resource(
> > >         int i;
> > >
> > >         for (i =3D 0; i < bridge->num_resources; i++) {
> > > -               struct resource *r =3D &bridge->resource[i];
> > > -
> > > -               if (zorro_resource_start(z) >=3D r->start &&
> > > -                   zorro_resource_end(z) <=3D r->end)
> > > -                       return r;
> > > +               if (resource_contains(&bridge->resource[i], &z->resou=
rce)
> >
> > Missing closing parenthesis. What happened to your cross-compiler?
> >
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > i.e. will queue in the m68k for-v6.7 branch, with the above fixed.
>
> Seems never got queued, should I send a v2 with the above fixed?

Oops, will queue in the m68k tree for v6.10.
No need to resend, I still have a fixed copy in my local tree.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

