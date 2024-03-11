Return-Path: <linux-kernel+bounces-98937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAF587813E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805301F22CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93963FB86;
	Mon, 11 Mar 2024 14:04:26 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADCD3FB2E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165866; cv=none; b=NQup9S2Xr06shtZK1zLsBTODH4vdGAFxf3TE7hsohOlGOyjmhd3WDTw3bSb2/9HTSbiB0NexLlA4Lq8+QQGiN1r0ScCJbHA+2jnNPa18Dpib1VIxJJT4+7N2Tz2JQB4Wn8PF9Q4woyopxz82BCCPWHm4DGRv+NPkyuJC/i83X8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165866; c=relaxed/simple;
	bh=Llu4HnXUgpYVrm6rtIdbKc+cL6h4GteJq9IJb6Oy2+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOUtvH8G9xJncyXJeFxLNDTyA27jopgV5PHy7p0trxURP78Tnp9UunCHFzWNw6AIiRnmW64ZgqXjDz259IvlVRo600x7hdBFQmDGGAS5XD/TRIzp5Q9JHz5DXuJrWkLGXMNyIc3Dl/mxeSSf2Jh5hrpAj3cagFy/RTqWa2nPLN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60a0a54869bso20492277b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710165862; x=1710770662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzLXwIVWLQf055SWSXkN052ooqv0U35mFYFMQAsjB/s=;
        b=bbQjUKVkXomeaALEyFBVNcpVo1oQddxrm9D9rRxXDcWWkPaUTy7lst3yParmOJh04G
         nBtA79S2lb/WjB+PQQM0HywbazSvukTEtT+S2FWhFImmQOf5B8mjMkx9nckxKTnvmugg
         960MfwNfycrvIcOeEMa5j3jSXUPINouw3/qUq1LvcHAuWW8UAuM4pQ4gaX/qqOC2xTKv
         Da0Mg7NbMH2kQnYTEB+M7BjV4/kbVSD0pSJGgXNa1M5t0klf4D9ukcDvtFQT8ZzQiOfC
         q8D+HlNdDk9qmG1ii8AhE7T2vwhUfEsI+8YfdhwCGGb7bMqE1MWT0ePTGWaBKtUzUa5m
         Xf+g==
X-Forwarded-Encrypted: i=1; AJvYcCWnXjuS3dz5Ql9zcEEDV17gegwoULT1AtdGbxR7+rYiA4K9Iu3EGOeFWK6N/Cu6QvM2egbtFEE3Hm5O9MKJNoSP+SPPOpExeMmNLZcf
X-Gm-Message-State: AOJu0YwBAiMgbpw1TIyhK2OphptjwfdaL0qbtMYI5AaFm3rmXca6K2Pi
	mwJvKl3Z6ABcbFfNMsAmPrQhTWAX1N6FuCUgRSDP3xM2Ld6Xd7FaRl1p7J4p90k=
X-Google-Smtp-Source: AGHT+IFS6TVYJFlw1rDuEYy2MU9TZR3vLxaD76dUNMgJug6SzG8yBKUR8Ke1t0QS60g3CuuYdeHvbw==
X-Received: by 2002:a81:8497:0:b0:60a:4cba:ada1 with SMTP id u145-20020a818497000000b0060a4cbaada1mr545911ywf.7.1710165861963;
        Mon, 11 Mar 2024 07:04:21 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id u123-20020a0deb81000000b0060a0662ccc3sm1361832ywe.90.2024.03.11.07.04.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 07:04:21 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so4998572276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:04:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9EyTahSv7upt8//O1BqNyzXIOSpG0Ltt67Jq14PF+KIwjPyCH0kv5CORuhUMPoI3nlGWTwubkJcikH6B7Md8ZWylv4Pp5m0Fwa2EM
X-Received: by 2002:a25:41c1:0:b0:dc6:daa4:e808 with SMTP id
 o184-20020a2541c1000000b00dc6daa4e808mr5213321yba.12.1710165861507; Mon, 11
 Mar 2024 07:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f713d82fe6526288f51fc138cd16681cec6b43a6.1710164592.git.geert@linux-m68k.org>
 <8f27c774-7197-48da-a6f2-6d375bd848f0@app.fastmail.com>
In-Reply-To: <8f27c774-7197-48da-a6f2-6d375bd848f0@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Mar 2024 15:04:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWJJuEHo08gJwrxiLv2P-US6sfEz83PZHnAcB4es68BjQ@mail.gmail.com>
Message-ID: <CAMuHMdWJJuEHo08gJwrxiLv2P-US6sfEz83PZHnAcB4es68BjQ@mail.gmail.com>
Subject: Re: [PATCH] fork: Use THREAD_SIZE_ORDER
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Mon, Mar 11, 2024 at 2:48=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
> On Mon, Mar 11, 2024, at 14:44, Geert Uytterhoeven wrote:
> > Use the existing THREAD_SIZE_ORDER definition instead of calculating it
> > from THREAD_SIZE and PAGE_SIZE.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >  kernel/fork.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 0d944e92a43ffa13..e79fdfe1f0bf4953 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -252,9 +252,9 @@ static int memcg_charge_kernel_stack(struct vm_stru=
ct *vm)
> >       int ret;
> >       int nr_charged =3D 0;
> >
> > -     BUG_ON(vm->nr_pages !=3D THREAD_SIZE / PAGE_SIZE);
> > +     BUG_ON(vm->nr_pages !=3D THREAD_SIZE_ORDER);
> >
>
> That doesn't look right, THREAD_SIZE_ORDER not the number of
> pages but the the log2 of it, right?
>
> I think you want '(1 << THREAD_SIZE_ORDER)', but at that point
> it doesn't actually look simpler than the existing code.

Thank you for pointing out my silly mistake.

/me hides in a brown paper bag, with a coffee machine.

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

