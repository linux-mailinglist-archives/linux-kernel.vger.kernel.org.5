Return-Path: <linux-kernel+bounces-93721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDD68733C0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1746D1C20892
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61F55F86C;
	Wed,  6 Mar 2024 10:15:29 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D165C911;
	Wed,  6 Mar 2024 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720129; cv=none; b=Az7ehyYFkjfb0nANamEKCgmN3TLVb6pR/yqCK9R8MWcdgxuvV9wAj+XJnMjd3Bn30ESx0WvgqYhTdp+DQCE2LuIONz2uNn2MKVEpzcth/Bin62gE1Pgrt++S3364apYNwy3AzNrdEsctD6l01CGTQiHKQlgak9DBFfRZ1viZU8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720129; c=relaxed/simple;
	bh=I71U9F907ca+UX52CGdxs+1CuiWgiZZoRLh6V7QsVkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6qna+cqkcSILw5qVFkwW6MPPphdg31afE7HldHAqbnzP2vBrcZ/nKsjxra6NbLtE+o2pQpH7vsLbOX86cu8SKlQ7DtdhlmxQSPUHhFq9GrCWGbGLXpn6nj9vLPgh1QaWMSUmI/WfDhGmJ7Y1wPfSLiUgj/iASjTNeLM05JCnNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc745927098so5903147276.3;
        Wed, 06 Mar 2024 02:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709720126; x=1710324926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcBNefSjjDwJxTNefMygd3O8myad/e3gTxirjLI090s=;
        b=ZeuFjL2ly5bwi3u8xXoM08qq6xGjG2ubwite39kGRFXr/v3rWLmjg33PUGMz0Xq05b
         JbQw25+jRSWdm5ZF/v0JLPozRm6kRGgqnKdXF42zK3qRwikgVhI+lw8A46F6m33NHuOR
         7aKv+qli2Qi+AycTXUb8eVZ8QVJKmeaLBSsrIgonMTzIF/mw/6ezowxVpm561a82CveU
         VtCiFq3diDSS/WfUMoQo/FihMEHceZCvoAZRWOvuSs1T7xvuPlX/imOz0yOQ3q5lu0MO
         hx/0HWxtAxiUFqiQJZsC99w9QQR8Gt0oY9Aj8OCfvJYzT8W8EfGvgmYN0Cq8e8EBfnGv
         bwsw==
X-Forwarded-Encrypted: i=1; AJvYcCWoYznNfTYK8XTY46cIHvlEczPyiwkAgtmwfWgdLK3zWiaNsPW8vxCrm+YTYI25XfGnEF4eAD2m2Sb880fjCwcEOLX87CVIYfBZpRsdKEp2/mLHtxM2NwQWWjTk/FGb5oeuQfBnS7CTI7NkV2M37AKWvwBtI3UxyxLbebtw5dwZuJPSI5TFCGPCKEUv45j65Ojwt6/0oCfNIukq8dmG619CLMZczGbqPB81
X-Gm-Message-State: AOJu0YzBxXm55Zr5u10EBP9G2x/WSEo2ZGkpekkCDytyyUz4ur+xArNa
	F/depuURjmVaYW2k0r2ZSZqJhu0w/gBVJYafRWSTvmxqgLMvWCHDdUHhX1HVKDk=
X-Google-Smtp-Source: AGHT+IHZz3CM908W1q5E8krejugYIgyffiSZH4xpolOW/9bo1ykoNdA7SMqwnyDr74aoEcTDDHavmg==
X-Received: by 2002:a05:6902:cc7:b0:dbd:4578:5891 with SMTP id cq7-20020a0569020cc700b00dbd45785891mr13184177ybb.65.1709720125875;
        Wed, 06 Mar 2024 02:15:25 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id v43-20020a25abae000000b00dcdb3dffa3dsm3126611ybi.39.2024.03.06.02.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 02:15:25 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso6942606276.1;
        Wed, 06 Mar 2024 02:15:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWlm6koUEBtm7oSd70ffPDee4coShlB+xMIB03OHYFLkJvQkl0g/gDGYT62+EM3TguPNwD8KEbAF3nS4PLQN2/pJ2XopEhgEBxWkDOxvbZPHNrmq3mAjZv7lXuJGLUu0I9KTkSfyZSKsC0k0fLENHbdr6K0kKzTax1Yb13s0ZgH73pzFkI56s+E6YTZbwvK6fTIpkuNum5L386/c6NiFj1gdEDtC5j5jEU
X-Received: by 2002:a5b:748:0:b0:dcf:6122:ccec with SMTP id
 s8-20020a5b0748000000b00dcf6122ccecmr12159302ybq.36.1709720125546; Wed, 06
 Mar 2024 02:15:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305171600.328699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdW0MxqxRwULhLsRtnYXYK8NYxq-uU7E2BscbvPh3axYFg@mail.gmail.com> <CA+V-a8vKo8ADB_R==vgBhVpSH43DOzdeA_NhZ1BCBdNuam3UmQ@mail.gmail.com>
In-Reply-To: <CA+V-a8vKo8ADB_R==vgBhVpSH43DOzdeA_NhZ1BCBdNuam3UmQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Mar 2024 11:15:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWX=OZJ3DE0vb4=k=6yH_L5JhusLRpVqJkJ0Xv3oT8_TQ@mail.gmail.com>
Message-ID: <CAMuHMdWX=OZJ3DE0vb4=k=6yH_L5JhusLRpVqJkJ0Xv3oT8_TQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: renesas,scif: Document R9A09G057 support
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Wed, Mar 6, 2024 at 11:06=E2=80=AFAM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, Mar 6, 2024 at 9:53=E2=80=AFAM Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:
> > On Tue, Mar 5, 2024 at 6:16=E2=80=AFPM Prabhakar <prabhakar.csengg@gmai=
l.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Document support for the Serial Communication Interface with FIFO (SC=
IF)
> > > available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interfac=
e in
> > > the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
> > > (R9A07G044) SoC, with the only difference being that the RZ/V2H(P) So=
C has
> > > three additional interrupts: one for Tx end/Rx ready and the other tw=
o for
> > > Rx and Tx buffer full, which are edge-triggered.
> > >
> > > No driver changes are required as generic compatible string
> > > "renesas,scif-r9a07g044" will be used as a fallback on RZ/V2H(P) SoC.
> >
> > If you declare SCIF on RZ/V2H compatible with SCIF on RZ/G2L, you
> > state that the current driver works fine (but perhaps suboptimal),
> > without adding support for the extra 3 interrupts?
> >
> Yes the current driver works without using the extra interrupts on the
> RZ/V2H. The extra interrupts on the RZ/V2H are just sort of duplicate
> ie
> - Transmit End/Data Ready interrupt , for which we we have two
> seperate interrupts already
> - Receive buffer full interrupt (EDGE trigger), for which we already
> have a Level triggered interrupt
> - Transmit buffer empty interrupt (EDGE trigger), for which we already
> have a Level triggered interrupt

Thanks for the confirmation!

> Are you suggesting to not fallback on RZ/G2L and instead make RZ/V2H
> an explicit one so that in future we handle these 3 extra interrupts?

In light of the confirmation above, I am _not_ suggesting that.
I just wanted a clarification: if the current driver would not operate
properly without changes, the fallback would not have been appropriate.
W.r.t. the extra interrupts, you can add support to the driver later,
if/when a need or desire ever arises.

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

