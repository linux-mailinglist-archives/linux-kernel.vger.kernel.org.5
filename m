Return-Path: <linux-kernel+bounces-95318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F42874C27
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB9428241E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2982B85274;
	Thu,  7 Mar 2024 10:18:58 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB89C1CD29;
	Thu,  7 Mar 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806737; cv=none; b=PSJUaH7NtEwYfdX0cjNmzCUPJpoWaPkPdDXqh+vmqrWSwjQWisZevWeKpptPKrVnga+8ycmXZ1Ms4+6qJ+3M6W5bV3IvaTuPUt5B2plshyAsyxbrGu7bTrP+aPQu03kuoqHsF4W8NUPk0H8Y+plL6VuPGSknLgy1R6hTRM/fsQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806737; c=relaxed/simple;
	bh=Tr2jABHwaPv0XKS9X+du0kPHNrc+9jC+LNj9TEVmYHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAnDAEsatShNT3UeTkX2tKvxmyeB49YM7Gq8magLhbjxjNGqinRQCOZVAtPXI9QGxd+SPGoYJS8/38nBG5sR7pr6/PzBKtEUNZnRAmSJfEi8FDAC9E0foxS3mkXrl8ErbrcgjcNC2AwwbodkWPaIJrf506p0VTKkZGmbF2p8xn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60978479651so8036037b3.3;
        Thu, 07 Mar 2024 02:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709806734; x=1710411534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSpIvgOST+NLPxwfJ000osD5e8g9z4oXLc9KN9aMlGo=;
        b=uOQlyJjajyJSnIAOqpE46Bxf6MBF+OJl1ZmR/xKFpiHYuPV6u44us7vPZEfTH5IhDe
         7siGahCSal/bumBR8m/6A+26QcahulauoilpFyoaQuAH12Z13Bx2GEIzpRU4WK6jQrE6
         +5GiM/lHNGdSHjlQN/P9Quy5MtTfAZOideFKtY05TNVaj0VFzaZUroVhA4MbAftDqcb3
         q522GezDHObWUsXo0zBfPrZn+XcpX/WdnyGUVS5kgKh8LeNU8N/zHEynUwzdP4w3FfpP
         q9HunW1xy+rXltOOMe+xtj3Gb5pzoEeZc3pPI1PrdMqOtH+0Y+LRTmFYd8eaUwsrDH/1
         EyuA==
X-Forwarded-Encrypted: i=1; AJvYcCUaMUD1Ha4TYNZ6GRCeVZu4LJ4UZr7nCZKxClTyZhaP7dgNlof7HgT++Sjy4eZLcoyUIL+Irry0NU5Ri2fCx/12dsqOskSj++UJ7qPHps0zLMu+Hj9QN+U9kaz890YsoB9869qQXjLMhUMCmFtBnUr+D3hWKa83+CzqdBbdHB9zPhprl0B7aWndhfTNxSy3uMCGdbfmUyIiPDIx5+M1eMTbNbuofihmVhhH
X-Gm-Message-State: AOJu0Yz8DzM67wy8AHH7noMti1RG9jju3Y73wTb5xhFTN9eYCw0xfX0g
	XN9yuW+wivFQKyS7WaV9bK4SDFhQGGczzvmZVGKKC7aWHcBQT9PTTbY0rjk117M=
X-Google-Smtp-Source: AGHT+IGc8kV+SEZu0QwjriiPMQ03bWg0OlOJWS9az3ODfpknj6uTnCnFpY+EnvT7+PnEU6rd8t0G3A==
X-Received: by 2002:a0d:e657:0:b0:609:ee51:2062 with SMTP id p84-20020a0de657000000b00609ee512062mr1723458ywe.46.1709806734352;
        Thu, 07 Mar 2024 02:18:54 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id f70-20020a81a849000000b00607fe5723e6sm4106271ywh.109.2024.03.07.02.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:18:53 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6087d1355fcso5102997b3.0;
        Thu, 07 Mar 2024 02:18:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsHDbwNKhPhnL3t0bGYKUD3KVWl4NbrVm3IWcHnCdMFRqesQkEpr78UUowQU9hdA0IS1KX3hUbya7JIPc4w15hDgVPz6T3nRIzqMwYIkvfk+1sN1456VGJyTUwKTKlan8RlTVBPSl/UdnX+oOK0cvd2xkiO4BksWKhUBEFyOHj2ZIEQ2p6dJyL5KONZUGQZcx3F7hUTK45F0T2nCG/8hYP+QAf03hitXy/
X-Received: by 2002:a0d:e816:0:b0:609:fd34:c280 with SMTP id
 r22-20020a0de816000000b00609fd34c280mr4807ywe.21.1709806732961; Thu, 07 Mar
 2024 02:18:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305171600.328699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdW0MxqxRwULhLsRtnYXYK8NYxq-uU7E2BscbvPh3axYFg@mail.gmail.com>
 <CA+V-a8vKo8ADB_R==vgBhVpSH43DOzdeA_NhZ1BCBdNuam3UmQ@mail.gmail.com>
 <CAMuHMdWX=OZJ3DE0vb4=k=6yH_L5JhusLRpVqJkJ0Xv3oT8_TQ@mail.gmail.com>
 <CA+V-a8uq=gw0_EVT3_CZD0TO+-DnSqXJtFakFcNWHOfq58g4aA@mail.gmail.com> <CA+V-a8vunmsUfGkFO30nwvqFkiks7vceLgG1jo7TcsFajeckmQ@mail.gmail.com>
In-Reply-To: <CA+V-a8vunmsUfGkFO30nwvqFkiks7vceLgG1jo7TcsFajeckmQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Mar 2024 11:18:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU0pTGg72r4+PkwyTin6pp1kApHruJUE5oSrdGucLYV7Q@mail.gmail.com>
Message-ID: <CAMuHMdU0pTGg72r4+PkwyTin6pp1kApHruJUE5oSrdGucLYV7Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: renesas,scif: Document R9A09G057 support
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Thu, Mar 7, 2024 at 11:09=E2=80=AFAM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, Mar 6, 2024 at 10:21=E2=80=AFAM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Wed, Mar 6, 2024 at 10:15=E2=80=AFAM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Wed, Mar 6, 2024 at 11:06=E2=80=AFAM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > > On Wed, Mar 6, 2024 at 9:53=E2=80=AFAM Geert Uytterhoeven <geert@li=
nux-m68k.org> wrote:
> > > > > On Tue, Mar 5, 2024 at 6:16=E2=80=AFPM Prabhakar <prabhakar.cseng=
g@gmail.com> wrote:
> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > Document support for the Serial Communication Interface with FI=
FO (SCIF)
> > > > > > available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF in=
terface in
> > > > > > the Renesas RZ/V2H(P) is similar to that available in the RZ/G2=
L
> > > > > > (R9A07G044) SoC, with the only difference being that the RZ/V2H=
(P) SoC has
> > > > > > three additional interrupts: one for Tx end/Rx ready and the ot=
her two for
> > > > > > Rx and Tx buffer full, which are edge-triggered.
> > > > > >
> > > > > > No driver changes are required as generic compatible string
> > > > > > "renesas,scif-r9a07g044" will be used as a fallback on RZ/V2H(P=
) SoC.
> > > > >
> > > > > If you declare SCIF on RZ/V2H compatible with SCIF on RZ/G2L, you
> > > > > state that the current driver works fine (but perhaps suboptimal)=
,
> > > > > without adding support for the extra 3 interrupts?
> > > > >
> > > > Yes the current driver works without using the extra interrupts on =
the
> > > > RZ/V2H. The extra interrupts on the RZ/V2H are just sort of duplica=
te
> > > > ie
> > > > - Transmit End/Data Ready interrupt , for which we we have two
> > > > seperate interrupts already
> > > > - Receive buffer full interrupt (EDGE trigger), for which we alread=
y
> > > > have a Level triggered interrupt
> > > > - Transmit buffer empty interrupt (EDGE trigger), for which we alre=
ady
> > > > have a Level triggered interrupt
> > >
> > > Thanks for the confirmation!
> > >
> > > > Are you suggesting to not fallback on RZ/G2L and instead make RZ/V2=
H
> > > > an explicit one so that in future we handle these 3 extra interrupt=
s?
> > >
> > > In light of the confirmation above, I am _not_ suggesting that.
> > >
> With the introduction of validation checks for interrupts, falling
> back to "renesas,scif-r9a07g044" for RZ/V2H will be difficult for
> validating interrupt count.
>
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - renesas,scif-r7s9210
>               - renesas,scif-r9a07g044
>     then:
>       properties:
>         interrupts:
>           minItems: 6
>
>         interrupt-names:
>           minItems: 6
>
> With the above check RZ/V2H fall into this if block,
>
> Is there any way I can specify to match two compat strings?

if r9a09g057 then ... else if r7s9210 || r9a07g044 then ...?

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

