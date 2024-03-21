Return-Path: <linux-kernel+bounces-109874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632308856EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8751F1C21816
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D33056448;
	Thu, 21 Mar 2024 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJaK6ZXW"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1262754F86;
	Thu, 21 Mar 2024 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711015006; cv=none; b=PcWbFRXmlG17VBM8IVs+VUkjY0VToXruObwtPJRRgMNkGKfZAXO6W0Xfs4J+0XgLagjFLIQZ/CYhuCbv4w5CCKjxFcdPgnQ05uopx3Ha0S0fp2oRkCoOMerZfiPYvHzJschY/0A4CxZ++myxxYYxiboA2wwPSd5dVk6FKoUSN8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711015006; c=relaxed/simple;
	bh=X+vay/ufd0X59BZKgQtvlB9hrVh25YaX+Tq0N2WVlVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTwEOviWy2P9JTvpnGucNtzObWOneSLYWjYcHhtMD2hLqKwKOoJNgJMV1pfK8XuirrY4L1YXE2Z6/YVm6iKN34pLAh7Tb7BDXRjnsIikbhFYsRZqWzMAZiA7/T7VcGpUm/yXWId09vs27luvX8O641FKlX4sQavtZ3Vbhwe95l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJaK6ZXW; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4d435a60217so296572e0c.0;
        Thu, 21 Mar 2024 02:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711015004; x=1711619804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fRFePWYUc68B3PsZK1/PkJRWXlxCxxTCy2WfNf/nvc=;
        b=ZJaK6ZXWGqoIrZ0/oVWZZF+jW3Na/aDCYgFWxkogxEQfp0GTZio5i5rr509N7AoGxy
         RenKAtDaMD/b+wXf8Mg2gfqFE3iUYHU6Tt+iFVBFpra/KSp3+B7DYuGRAweOJtyRwD5z
         eu/WS0F/4nsjARAS9M/rQOEYIVIP39+VIIOIwdtTBrkWTMc4C1syBXETQ9aSFRmG0kpO
         NHAkyRc8IJtyCsDaW5dKxrTVS3VrJB7JbCAIWJRtyHEBTbMmJDdE7hBl7al7P4ZzXQHP
         qGJuccn9t1/9pgSUM1yguLxV5VKfpiqL4IxGPpfAXOFGOgm+xFgegd+1StYTfmK4oZGG
         F7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711015004; x=1711619804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fRFePWYUc68B3PsZK1/PkJRWXlxCxxTCy2WfNf/nvc=;
        b=w3FSjrmKPTY45Exiz1bwuis196EGN+HmZ1L0W43vQ9kECG9cCNDTYPQqwemupSSinD
         IS2FGglKBz5KvlYZ9dkfTCSP6STHSSfEc8Td/O9pXiG74odaN/f3jie9NCn+J+h/hc9u
         2tsUOLsu6iiN5HvCi9dSUT32RI8y+N9Uux/vTDrtUNm4WSyWhzYwcgtXKyDMQOV8t5US
         ZVbTMICDIgNCG14R68+FJQ54O2EByynZAd0X1XbqcFvv8H5AOdFlvj3k8qvweNo03XIW
         wOPvdrnemAcqHrkedT+chHSdiBEUEWQGVn18EEG8WiC9sGsziI6H9nGZXBD0m9tnU3WJ
         2r2w==
X-Forwarded-Encrypted: i=1; AJvYcCXGH8NZUfrZNxDarJp8VfbwpQj0y/AKyX1hWYw6Wx79RHLtJsKdvaXJHTg5nBkfGYbkbEkFhivNPDO9wv4BRjxk1n+sRpJJuqYbxNE2+ND/6W8/FhHfBbM8bdlr3ZOg/kPU3P6hpXY5ShU5PQq69lC/nDmf0NzuHs9ukCXwnyAvI9SbgfWelUcDBZaJRLQ+zmMaRfaWsBLko/ZPj2xGlGvnPRbkEL0IzN3L
X-Gm-Message-State: AOJu0YxMnu9J1sewe70zXMs44Qi+gZrl6NKa39unipDWppWO7YK6NlCk
	QNMl/bbaJ7XSZKbmJBH4UMzzwbmKNjafdeZ/nd83skPr0pK/E6bEJ5dJnClaEuiM3L1sSdajFsU
	8TlSrXbZ/qvTtkGn6oxWzxPH8cBQ=
X-Google-Smtp-Source: AGHT+IGS3HgPdlXdCKerNWxvvRRQVEd5FD9Httx3Fx7LHzwMRUK822/VRu6sF2lPXrq3U/IBQR8bJiWnsyAgWP5X7Tw=
X-Received: by 2002:a05:6122:c97:b0:4ca:80c5:7544 with SMTP id
 ba23-20020a0561220c9700b004ca80c57544mr4686116vkb.4.1711015002465; Thu, 21
 Mar 2024 02:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240318172102.45549-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVR=t+QW+kqh3HswJ_8T2Dos381VL8vJvdqiC4RZDRRZw@mail.gmail.com>
In-Reply-To: <CAMuHMdVR=t+QW+kqh3HswJ_8T2Dos381VL8vJvdqiC4RZDRRZw@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 21 Mar 2024 09:56:16 +0000
Message-ID: <CA+V-a8uorWK=Vi=N_CSCTjwn+fhFy4cBsNyA=818Nnwj3mq0Vg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] serial: sh-sci: Add support for RZ/V2H(P) SoC
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Tue, Mar 19, 2024 at 8:21=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Mar 18, 2024 at 6:22=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add serial support for RZ/V2H(P) SoC with earlycon.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v2 - > v3
> > - new patch
>
> Thanks for your patch!
>
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -290,7 +290,7 @@ static const struct sci_port_params sci_port_params=
[SCIx_NR_REGTYPES] =3D {
> >         },
> >
> >         /*
> > -        * The "SCIFA" that is in RZ/A2, RZ/G2L and RZ/T.
> > +        * The "SCIFA" that is in RZ/A2, RZ/G2L, RZ/T and RZ/V2H.
> >          * It looks like a normal SCIF with FIFO data, but with a
> >          * compressed address space. Also, the break out of interrupts
> >          * are different: ERI/BRI, RXI, TXI, TEI, DRI.
>
> and RZ/V2H has more interrupts than RZ/A1, RZ/G2L and RZ/T...
>
> In addition, RZ/V2H does not support synchronous mode (does not matter
> for the driver) and modem control signals.
>
> Currently, sci_init_pins() does write ones to the SCPTR bits that are
> reserved and marked as "write zero" on RZ/V2H. I am not sure how bad
> that is.  You could avoid that by adding a check for .hasrtscts, but
> that may have impact on other SoCs/boards, where currently e.g. RTS#
> is always programmed for output and active low...
>
Oops I had totally missed this difference, thanks for catching that.

> So if you really need to avoid writing to these bits, the only safe
> way may be to add a new SCIF type.  But perhaps I'm over-cautious? ;-)
>
As we are adding a SoC specific compat string we can update this if we
see an issue, but I'm happy to do that change now too. Please let me
know what would you prefer.

Cheers,
Prabhakar
> > @@ -3224,6 +3224,10 @@ static const struct of_device_id of_sci_match[] =
__maybe_unused =3D {
> >                 .compatible =3D "renesas,scif-r9a07g044",
> >                 .data =3D SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE)=
,
> >         },
> > +       {
> > +               .compatible =3D "renesas,scif-r9a09g057",
> > +               .data =3D SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE)=
,
> > +       },
> >         /* Family-specific types */
> >         {
> >                 .compatible =3D "renesas,rcar-gen1-scif",
> > @@ -3554,6 +3558,7 @@ OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early=
_console_setup);
> >  OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
> >  OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210", rzscifa_early_consol=
e_setup);
> >  OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a07g044", rzscifa_early_cons=
ole_setup);
> > +OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a09g057", rzscifa_early_cons=
ole_setup);
> >  OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup)=
;
> >  OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup)=
;
> >  OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup)=
;
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

