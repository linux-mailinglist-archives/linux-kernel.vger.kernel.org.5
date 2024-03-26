Return-Path: <linux-kernel+bounces-118549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E10188BC7F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AC71C2B7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EE117BA6;
	Tue, 26 Mar 2024 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8PQDUQQ"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE979D3;
	Tue, 26 Mar 2024 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441960; cv=none; b=FkECaNqMOqSfHMcIC2fiXQb9eZuQ2loeaieXZE2kE2l84kGFe4fVfWWxW2UPzoVqMD8GQrtNtHIHzWuSdhQBV0Lzjr74i/W4svW7BJ2nMXaJMk4jL0JwDcuxFN6D5Ql25QsYvToy55pha6uqvOWVm4wO22CIbFsOwB7crvYlm68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441960; c=relaxed/simple;
	bh=uBkcnsfs+bfuok50+QW92QNvUqV0c0OCVYuoSTeE/j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9dCgvvPSuPG1s+Dyu0E9Ct0VJcmTrEgaJGC4ELGMxCYzsac42nsV3Oh/Q3l3SCSsazfdqby8sCM46fN04JgmICwp9AxBUQqymvUIHyRWOUk2BLW4o8HOW2E4WWXGfJeZpT0nVZXlJp7IOnLHy/yxVyY8gPfEWl0SQBtki/5qfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8PQDUQQ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-430c63d4da9so38582021cf.0;
        Tue, 26 Mar 2024 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711441957; x=1712046757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFgqR+6DFqE7zwVwqJGEmPZ4rIU8Z33MbwQq9wd6qDY=;
        b=O8PQDUQQ0CAEa0tj/gXxasy/Jhp47i+mru8APBb0NOccnud+vibl4WxjklK1/+R3QA
         VlEmtOJlyDwfMeF2ZlOm6mBstqLq/LYcNyfu8ny+3UvqJBs5tMS8l4/pVVfxJrqIkjF4
         7RDE8fK34CbbAGHRtHRWSfHp6wFTKzyAJXndW3YzE0H2heLalnVncf2SnkXLC9u61d6Z
         YRe6MF1hO2Vo3GLvypACo5DOe4liuNEzxkBLAw1BiF5rCn9O4JkHhxmeHPQMJ8AySsJA
         au2VyWGJTs5X2ShY8hZ3cyldy0vmkzNVEGdzsHo0b2J4sdBCb6c8Cjn5x8YEMIWxNfmz
         rUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711441957; x=1712046757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFgqR+6DFqE7zwVwqJGEmPZ4rIU8Z33MbwQq9wd6qDY=;
        b=N14LoJ8KkMyk+W2nwhVfZY8AhanYi/hhM7+RwR8SAf/uYq1TOhlSuYjmrfGrWNphJX
         fbjp6Dqx7KMTSv2uPmUhTBFbSgcfjJrdq5tepua1bo7MdjlqAgXJnb5d8LGoNRsKfLUb
         bj8cGngFxx4KlJjMi7k3xctYOS1uV9vn6QEoqW2O3/rWbkEgSsTN3NPcWrggb9GXJ9Eh
         xJ0lGrJb+fxEV/w3DaA9SiNasvsgN1VfGDW+dyMTqVLwoJKLeCq2kKY+EWcR/fJXLgUa
         M6gG5dvUZ1T7jdNIZB3jLINKcjx62x66ulmTpr73PJnPjyvTP0ZVs+iwsLc8atbxcdba
         /DMw==
X-Forwarded-Encrypted: i=1; AJvYcCXy+dxH+EgkApn8vbMISrN8IS6gGHRwww7UDzRBhRXMO7iZDEPY5RsqN8BbmqF/tOmuE3fJ3ugc6yrDv7MQ98vmZZLsYciSv/savWaaksvE1CJbG6txMQZwhPtK46TBSFLOy0daskgnZtbfXx9y1u2l317J2mbX3fxq3wkjF3mNt6NIvgM7rZ8+Rw9g4zS4NzUw8fJluVbhHu8T6nd+xXav4ZeNwoxdrdCa
X-Gm-Message-State: AOJu0YzeWDrOtsC+C1ak0ppRKrOSRca+RlK61cYA79MAVnqPMh7lp0SD
	E5cIew9J4hmZgGDunTwfXEHlN8Smw24WxzJESF+bWvVvV8W/LaDTLJoest996I7C8qDCQKEeBjq
	2jJ8swxT1fj/Dy4xCAprBji/rOUY=
X-Google-Smtp-Source: AGHT+IEppq/TDWxmDZwX8xnsUTdUyiiz8SiX4T+0lbhvS8JnYNFDZgFX4jYTV7odTIjgaqrFvAqGrJFMxLYf+GCLWiI=
X-Received: by 2002:a05:622a:1b90:b0:431:518a:6125 with SMTP id
 bp16-20020a05622a1b9000b00431518a6125mr594994qtb.27.1711441957468; Tue, 26
 Mar 2024 01:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240322144355.878930-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSAPR01MB15871221D42B6CEAA08168C386362@OSAPR01MB1587.jpnprd01.prod.outlook.com>
 <CAMuHMdXtPPwzgwekKiuNF5MzDvLSOqvBXWgQd4tgPtTnnQp2VQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXtPPwzgwekKiuNF5MzDvLSOqvBXWgQd4tgPtTnnQp2VQ@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 26 Mar 2024 08:31:06 +0000
Message-ID: <CA+V-a8vCr-bafOBumi3-P+Efin0YiG_AXWMkDTZpmRH_S+dbyw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, Mar 26, 2024 at 8:02=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Biju,
>
> On Mon, Mar 25, 2024 at 5:21=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.=
com> wrote:
> > > -----Original Message-----
> > > From: Prabhakar <prabhakar.csengg@gmail.com>
> > > Sent: Friday, March 22, 2024 2:44 PM
> > > Subject: [PATCH v4 2/5] dt-bindings: serial: renesas,scif: Validate '=
interrupts' and 'interrupt-
> > > names'
> > >
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > This commit adds support to validate the 'interrupts' and 'interrupt-=
names'
> > > properties for every supported SoC. This ensures proper handling and =
configuration of interrupt-
> > > related properties across supported platforms.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > v3->v4
> > > - Reverted back to v2 version of the patch.
> > > - Used suggestion from Krzysztof for interrupts
> > > - Restored RB tag from Geert
> > >
> > > v2->v3
> > > - Listed interrupts and interrupt-names for every SoC in if check
> > > ---
> > >  .../bindings/serial/renesas,scif.yaml         | 73 ++++++++++++++---=
--
> > >  1 file changed, 55 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.ya=
ml
> > > b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > > index af72c3420453..eb2aa5e75e02 100644
> > > --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > > +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > > @@ -86,11 +86,6 @@ properties:
> > >      oneOf:
> > >        - items:
> > >            - description: A combined interrupt
> > > -      - items:
> > > -          - description: Error interrupt
> > > -          - description: Receive buffer full interrupt
> > > -          - description: Transmit buffer empty interrupt
> > > -          - description: Break interrupt
> > >        - items:
> > >            - description: Error interrupt
> > >            - description: Receive buffer full interrupt @@ -98,21 +93=
,17 @@ properties:
> > >            - description: Break interrupt
> > >            - description: Data Ready interrupt
> > >            - description: Transmit End interrupt
> > > +        minItems: 4
> >
> > I think here minItems is 1 as it is either 1 or 4 or 6
>
> The single interrupt is handled by the first case in the oneOf (which
> can probably be simplified by dropping the "items"?).
>
Agreed, I'll make this change as a separate patch or squash it here if
I have to re-spin the series.

Cheers,
Prabhakar

