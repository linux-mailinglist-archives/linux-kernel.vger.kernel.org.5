Return-Path: <linux-kernel+bounces-66896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA19856342
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC76A2888BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A119012CDA7;
	Thu, 15 Feb 2024 12:33:45 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5C07869B;
	Thu, 15 Feb 2024 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000425; cv=none; b=rl2DtR0XbB8rvDQQ0V/ezhGlI//i37NmW8TRo8LNTHF1/0X+B8FgOXClzEEfKtx/CiSO826R80MK/pQNlKhoX8W4yIShq9tq/nkGeDo7uo2QKDbRYjyRGrbAsg1HZAjTPSMQgMZ7QxqQ8sJZVsSJ2BBj4V8mAunB1VJ9Bd0Avw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000425; c=relaxed/simple;
	bh=tumVkbmYHjiMso8FRssuLkZqhEKqtxL4JwgYChENVQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ER+Ejw5QqCNVSmmVkWSxd9Vy56y+fmE2mFsMYL57agPCGLYB7sSHw2ioVlclFYsl+TEQYv7Mqr4nP+v/oP1N68GGrwPTk9LzdEZR+L1fxZ50OTAwpDoSI4qjR6FQJKWkU1VmgK7ouDEXoeOcGBK5Hs3QMjb8zpV/AV655xyvR6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60777bcfed2so6234507b3.1;
        Thu, 15 Feb 2024 04:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708000421; x=1708605221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bzPODMA1rvwegafLTiQ2nS4T13Tcbv5dv5Yj9ti6KQ=;
        b=XYui6De1oDyUqaD0uIM8pl4N31bAVCpEbUlz9yy1ObXJ96et3IR1KFXT1DpsSHy/Vf
         BoKQ18+5EYrlbtTdTqm8Fo/Xlbdb4nZHuIWGeQbICtDo8pOCuGqvBhj9PuFAy8xmxr5H
         kBZvGmm7uDy5NNbBHK4dacVmP8qHS9oFKfnPssNx44t0b2yiE04A2kaFem7erkU14xc7
         upZxlsl3Fdr6YLNOkgId8tNbP1wwmCIdiPGyxAFM4u9HsFX9w83M8jlnjGIX2kCuL4bz
         DJVjlrnHEoqofk+lDTLvfaSGpFLJ6+yh9wDqjQZNaoMPgGfHMmCidvDQjYLy2L+nzaJa
         5G7g==
X-Forwarded-Encrypted: i=1; AJvYcCV03hJf0J5ShAajJocTI/SDbUCcGUe3aU0URTh0Dj6zJWUEKuRTcSKH/cnus2Eh1fwDiSh0+1i9tF1fcus9ync9i+J0l/injz6b2UBu
X-Gm-Message-State: AOJu0YyEqM/Ky/KaV7zFQS/XaZ9MRNgAjSXJ2tQE+X44kj5i6RKTbzzX
	CTvenScuCSjiBLpwUYlOzVMsm1YEaITT4BVI2qE2U8Sp/s0OaE0UoLsojqaFOuo+2g==
X-Google-Smtp-Source: AGHT+IHNeBdLniWhEV+qbKpdC2L9Unu14kcThbHJjNP1K9RUnzDjbLm5gMfLF3ZfnRbGyzW7iD88KQ==
X-Received: by 2002:a81:9851:0:b0:5f6:cfc3:f5a3 with SMTP id p78-20020a819851000000b005f6cfc3f5a3mr1568377ywg.50.1708000421662;
        Thu, 15 Feb 2024 04:33:41 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id l7-20020a81d547000000b006042345d3e2sm212611ywj.141.2024.02.15.04.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 04:33:41 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso819975276.3;
        Thu, 15 Feb 2024 04:33:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyhrdl/UzXEuarfngmq4poL9NNmp8DQIeuiexVSqSrSJuD/H0aK13Xf5eJKgsND6TzPFfqIqw1WyJoBvesFYQQHJM+7T75MgRhdJwy
X-Received: by 2002:a25:b204:0:b0:dcc:76a0:503b with SMTP id
 i4-20020a25b204000000b00dcc76a0503bmr1297999ybj.13.1708000421218; Thu, 15 Feb
 2024 04:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-11-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVtqWBi4Y1tj74m4V4kp-3cFe_FphKKeY7zOkrbMVkKRg@mail.gmail.com>
 <Zc4Au5Q_rOAx7_4Y@smile.fi.intel.com> <Zc4BVIwpAqJYPuTH@smile.fi.intel.com>
In-Reply-To: <Zc4BVIwpAqJYPuTH@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 13:33:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUR8i_08bz_B6HTzD4yx4URaC5aGG6byYNbmLmM0Gb4=w@mail.gmail.com>
Message-ID: <CAMuHMdUR8i_08bz_B6HTzD4yx4URaC5aGG6byYNbmLmM0Gb4=w@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] auxdisplay: linedisp: Provide a small buffer in
 the struct linedisp
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Thu, Feb 15, 2024 at 1:19=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Feb 15, 2024 at 02:17:00PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 15, 2024 at 11:40:44AM +0100, Geert Uytterhoeven wrote:
> > > On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > +       linedisp->buf =3D buf ? buf : linedisp->curr;
> > > > +       linedisp->num_chars =3D buf ? num_chars : min(num_chars, LI=
NEDISP_DEFAULT_BUF_SZ);
> > >
> > > I think it would be safer to return an error if buf =3D=3D NULL and
> > > num_chars < LINEDISP_DEFAULT_BUF_SZ.
> >
> > I think you meant >=3D ?

Oops, yes/

> >
> > > Else a careless driver that doesn't check linedisp->num_chars might
> > > overflow the buffer.
> >
> > Okay, check has been added.
>
> Hold on, but I have min() being called, isn't it enough?

Yes you have.

A careless driver might not use linedisp->num_chars later, but instead
just hardcode e.g. memcpy(linedisp->buf, source, LARGE_BUF_SIZE).

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

