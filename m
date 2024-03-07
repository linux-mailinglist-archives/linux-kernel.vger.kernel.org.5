Return-Path: <linux-kernel+bounces-95306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442E6874C02
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC132810E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AA412837A;
	Thu,  7 Mar 2024 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko0L1xpZ"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E3E42047;
	Thu,  7 Mar 2024 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806193; cv=none; b=hX1i7Mf1ls0W+lmzYQLEc1dQbYuOT1AgaJbtUpiLga1XXvgM8MfrlXH5iiCW8leBItZn2kG2DbTr7MvscH7cZaCD30yQ6xBFI3Y9G0t7hgyn+QpCISae1ZMucEvmQnTxdAjeBdAg+SdZvfjyH1W5MfZ3xg5LIl2rdAAfyKUONr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806193; c=relaxed/simple;
	bh=Z+XySDX0I1MFB4UakJ/SQ8XJmBT0WkwC0syBLztsRw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGM9kcVzxQBJ6Rdz5PZdXwfCN9ANbAMIa1qj3MYCkKbb3fNhRDcvYsFk9fJnaCnd18St38nxNFn5wfSAyT+eOJexMRqdVsYvBeOhuBhvWuIWzTt5bIERLrGPZzIh0zm8EaqazX51RqCMezIT9bXZQSp4dKHNZiITG6DVDAbyfy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ko0L1xpZ; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4d33b077ec9so207880e0c.0;
        Thu, 07 Mar 2024 02:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709806190; x=1710410990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR8Uqmn7JuK/Fgsx24JIz7SwVeJRfKgv1wRP9GFweFE=;
        b=ko0L1xpZ3s35z78cOVWDo7JNwdY7udMDkNxkhjqHqPdlTN67JKHBlu+5T5aoLLjnPY
         7fZMFAZ/QYNcLcOS+qPS6/sxCQabbwRolNCquDw9VOuZ4PLEhpDRP6GI8T3CnhykiJqi
         dLxFVjHx4U05B659XHaJA2zlBCUePL+z94jkx+rZK+ZE+jF9vsudemvHczwf98evxkq5
         WVeC92cO9xvmLT0WXCboh+R1BOmYigFnZeux3osMjH4j8KZwwbp4OsFR61DFimegQD+N
         KQEyO0Kifxjb1Lh66i2AcFpQvMgTMkEFfBsym+IYO36Riggp3q6As0Iqf+7pCCX358PM
         i77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709806190; x=1710410990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QR8Uqmn7JuK/Fgsx24JIz7SwVeJRfKgv1wRP9GFweFE=;
        b=uhMgKpqwaNdHtyAybnt5944P5WWjpSzFRe1T/IdoR4tJ+DOjwo/xtu4rvYn0pZRsmZ
         kluFTNTzWUEKzg1irrJQtNmZEDfxMRpAjdgkU7Jl5MsVnOqJDf+rQb6uZytdr6k+N6GX
         ikt1odITqXmMSbABNW7m4lTknoZuhpchjJYYxEe1pmbEAhiI4WlKcdVlqQBqBicBraUB
         QRUGKO6GENprSC8F5sXcRlr+2ilc8jlA23ec6rSYjL+jYSP3jSk2ey+Tpy32qCRquuZr
         24OtMMReXi/6p/Fc+iJDktjduq1WG5vBgIPDe+CK+MAU1N40jnncURBIhJ0Q6zgt2Je3
         Hm8w==
X-Forwarded-Encrypted: i=1; AJvYcCULHZ+SJP7HrRe1fiEW41njmb/DI6MDFSt5GgKSIzX+jpU4RXg1HY0Ph0zX7YaT0b3KRg+TMe9zoxD6lOzuHzHxrBOQB4Q858fUv2fNVm4MXOK7sbijxIDETFBWYLqaHfBfVKq55tJ2TvgML7fW0FJqDN36zXB8HLR8oHPD1qJxEJ+eSHarWeBSCpmqyxO7T9sardDWm2e36qeO5f/Kv5Ez5XRA3Gi27vN+
X-Gm-Message-State: AOJu0Yymz5OxL1rXVW7bVS9tC4237rikxE0j1Te1vaAT37SrhBMhRkyA
	iKJVoZrhOhDo5vDwltiPINM5ZR18ksEjnYoygPECJNUQ68wGgkMqUciZfkEZc3benXNrA82CAo4
	zkHWUoa8gt72UnuN3t+DbMaw1Sgs=
X-Google-Smtp-Source: AGHT+IFQunO5Ddr5/x6qr7CHbsVb3yfVhNAGP4GKq2A+bjpvt6jiw5DKWscr7mb1kQ69tcjliN1BbAY+GJHboIDxVDA=
X-Received: by 2002:a05:6122:c89:b0:4d3:313b:902a with SMTP id
 ba9-20020a0561220c8900b004d3313b902amr8280826vkb.12.1709806189809; Thu, 07
 Mar 2024 02:09:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305171600.328699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdW0MxqxRwULhLsRtnYXYK8NYxq-uU7E2BscbvPh3axYFg@mail.gmail.com>
 <CA+V-a8vKo8ADB_R==vgBhVpSH43DOzdeA_NhZ1BCBdNuam3UmQ@mail.gmail.com>
 <CAMuHMdWX=OZJ3DE0vb4=k=6yH_L5JhusLRpVqJkJ0Xv3oT8_TQ@mail.gmail.com> <CA+V-a8uq=gw0_EVT3_CZD0TO+-DnSqXJtFakFcNWHOfq58g4aA@mail.gmail.com>
In-Reply-To: <CA+V-a8uq=gw0_EVT3_CZD0TO+-DnSqXJtFakFcNWHOfq58g4aA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 7 Mar 2024 10:08:43 +0000
Message-ID: <CA+V-a8vunmsUfGkFO30nwvqFkiks7vceLgG1jo7TcsFajeckmQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: renesas,scif: Document R9A09G057 support
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Wed, Mar 6, 2024 at 10:21=E2=80=AFAM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Geert,
>
> On Wed, Mar 6, 2024 at 10:15=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> >
> > Hi Prabhakar,
> >
> > On Wed, Mar 6, 2024 at 11:06=E2=80=AFAM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Wed, Mar 6, 2024 at 9:53=E2=80=AFAM Geert Uytterhoeven <geert@linu=
x-m68k.org> wrote:
> > > > On Tue, Mar 5, 2024 at 6:16=E2=80=AFPM Prabhakar <prabhakar.csengg@=
gmail.com> wrote:
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Document support for the Serial Communication Interface with FIFO=
 (SCIF)
> > > > > available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF inte=
rface in
> > > > > the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
> > > > > (R9A07G044) SoC, with the only difference being that the RZ/V2H(P=
) SoC has
> > > > > three additional interrupts: one for Tx end/Rx ready and the othe=
r two for
> > > > > Rx and Tx buffer full, which are edge-triggered.
> > > > >
> > > > > No driver changes are required as generic compatible string
> > > > > "renesas,scif-r9a07g044" will be used as a fallback on RZ/V2H(P) =
SoC.
> > > >
> > > > If you declare SCIF on RZ/V2H compatible with SCIF on RZ/G2L, you
> > > > state that the current driver works fine (but perhaps suboptimal),
> > > > without adding support for the extra 3 interrupts?
> > > >
> > > Yes the current driver works without using the extra interrupts on th=
e
> > > RZ/V2H. The extra interrupts on the RZ/V2H are just sort of duplicate
> > > ie
> > > - Transmit End/Data Ready interrupt , for which we we have two
> > > seperate interrupts already
> > > - Receive buffer full interrupt (EDGE trigger), for which we already
> > > have a Level triggered interrupt
> > > - Transmit buffer empty interrupt (EDGE trigger), for which we alread=
y
> > > have a Level triggered interrupt
> >
> > Thanks for the confirmation!
> >
> > > Are you suggesting to not fallback on RZ/G2L and instead make RZ/V2H
> > > an explicit one so that in future we handle these 3 extra interrupts?
> >
> > In light of the confirmation above, I am _not_ suggesting that.
> >
With the introduction of validation checks for interrupts, falling
back to "renesas,scif-r9a07g044" for RZ/V2H will be difficult for
validating interrupt count.

  - if:
      properties:
        compatible:
          contains:
            enum:
              - renesas,scif-r7s9210
              - renesas,scif-r9a07g044
    then:
      properties:
        interrupts:
          minItems: 6

        interrupt-names:
          minItems: 6

With the above check RZ/V2H fall into this if block,

Is there any way I can specify to match two compat strings?

Cheers,
Prabhakar

