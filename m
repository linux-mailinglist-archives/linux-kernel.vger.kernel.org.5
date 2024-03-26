Return-Path: <linux-kernel+bounces-118501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 283AA88BBDC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE5D1C324A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6916713341C;
	Tue, 26 Mar 2024 08:02:47 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888018C38;
	Tue, 26 Mar 2024 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440166; cv=none; b=MNurzVfPocsMdXMMdEbxezIgm9oywaQo6vmIwOg7/+EuXVKCceh+wg7s/QWAMtPHGpuBRAgneUoTkwKSXzpfbgV4IrCPUm2obMxppWFZwNDWZ5RcWiUC2Rd0PwiJGTd1sYIzr6+N9TpyBFL3ItbzstjUgGHwqaGXsKmQ2zL49Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440166; c=relaxed/simple;
	bh=05/Cgdd9jcscT26Btc4gZqpr6BtmMg5RiBx3hVkQtFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfil6BCUuVUWYT+8GLuWYE34RryTo9kZdxsZp+IzrH/oCHaBttXCp+dxSfmUHjTdy4SLhcmULR4GCqlhChdQ4yFujHq7hO5jr2CvPqbOGSUcgTLrAr4SFwUNz4GtFAUFkin8q9Ha570EZ4Y1VxSd2A51BUoni6wrRK15895vDLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60a0579a931so56426387b3.0;
        Tue, 26 Mar 2024 01:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711440163; x=1712044963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mckyb96OX2beYcxE9hMgQH/HkyGUUKnyCtMxkXiNMw0=;
        b=AXSFKJTtVNgqDMImC2Qa89i5HeplDr5eGUOwEXmGLZ1bExSFtQwqEMHPC3FuGQV/d8
         dGQpUs9x8jKi7SODeF0GIcrSgoa7bCf6uJZv9oEL1tHlqnVoxq2NrxbvRkHt3q87qKqj
         w+aU6cvF49UQiAv3Ew1oxV9JbVniUOpNkGOkwyzW84Dl/xU9TQHmT6trt2JAmBWkSQac
         plLW4qV1IFG2FYDs96EBbk9/8eFkEr+ITLnose7jdQP8qMNMGJR2R1lSbfEYjuPPHOaN
         Lc/dtwDmMMcXPk/DH/EZaO7of14Sh2OAkOMEcRRA84i5IqDED6T+wArHRS3Wy9l15H+T
         wRhg==
X-Forwarded-Encrypted: i=1; AJvYcCXWT5h1K8lWD+1OgZhYAEUVjO2ju5i72QaD6mvJyPael9ijGT+nBgbX0nHXprCbDyyAGhaX6RW2eHSfcVpdFM2zFs4ZOxl5c1+vJoc3u8iseK9WBlJUBeQFd/2x5SDOrW8q/Kpfj2yT6M3NoEb81zNJv32YTgyg8ToTB9x0EVx+XLOiSNe/q1X/tyyJGydG8pWuU6OzlbW/Mz2Y+ErTryIS3+jSOaYxHSSM
X-Gm-Message-State: AOJu0YxTuQf51Qxbd6NrPBJKj6z+c87qq4sSJoIjWtx01SDHg4YepPe8
	i/f3wK6Vo32uL02/nCMaLzrOo/SI0m6UWnrv/D7s2taYxNdWrS7XjxX9p+Z9fqE=
X-Google-Smtp-Source: AGHT+IG+g9E2AtI3Nl7Yt/OHW+crCse49TRXi0pzL9yyGovnzdCwMHTHy8+bzyiFkLoI4HPlJEsuHw==
X-Received: by 2002:a25:a2cf:0:b0:dcc:f0a:e495 with SMTP id c15-20020a25a2cf000000b00dcc0f0ae495mr7011473ybn.3.1711440163606;
        Tue, 26 Mar 2024 01:02:43 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id x3-20020a254a03000000b00dc74ac54f5fsm1359771yba.63.2024.03.26.01.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 01:02:42 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso4923416276.0;
        Tue, 26 Mar 2024 01:02:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVig2Hl4uIbhYrjuSElV9VFj4Eka+yyhLGayfzCgYvOcWdkRKsOkflKLjxr8p6gpe1GLtN1VLN8sGW4VENtOmzqu0IXepFp4Qaru2N4AYzW9hVhHCcSJ3CB2g6Ug8z/+Nvsjx0hz0s+grCNVSX24mB/+RMXYYUbCqxihNajEc4AvxOBNSPL6KhRMIXAV8nWWcC61RHAPXDXLADIUTAi/XxGyNq/W21DTXDL
X-Received: by 2002:a25:838c:0:b0:dcd:ba5a:8704 with SMTP id
 t12-20020a25838c000000b00dcdba5a8704mr7563802ybk.24.1711440162334; Tue, 26
 Mar 2024 01:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240322144355.878930-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <OSAPR01MB15871221D42B6CEAA08168C386362@OSAPR01MB1587.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB15871221D42B6CEAA08168C386362@OSAPR01MB1587.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 Mar 2024 09:02:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXtPPwzgwekKiuNF5MzDvLSOqvBXWgQd4tgPtTnnQp2VQ@mail.gmail.com>
Message-ID: <CAMuHMdXtPPwzgwekKiuNF5MzDvLSOqvBXWgQd4tgPtTnnQp2VQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Prabhakar <prabhakar.csengg@gmail.com>, 
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

Hi Biju,

On Mon, Mar 25, 2024 at 5:21=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
> > -----Original Message-----
> > From: Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: Friday, March 22, 2024 2:44 PM
> > Subject: [PATCH v4 2/5] dt-bindings: serial: renesas,scif: Validate 'in=
terrupts' and 'interrupt-
> > names'
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > This commit adds support to validate the 'interrupts' and 'interrupt-na=
mes'
> > properties for every supported SoC. This ensures proper handling and co=
nfiguration of interrupt-
> > related properties across supported platforms.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v3->v4
> > - Reverted back to v2 version of the patch.
> > - Used suggestion from Krzysztof for interrupts
> > - Restored RB tag from Geert
> >
> > v2->v3
> > - Listed interrupts and interrupt-names for every SoC in if check
> > ---
> >  .../bindings/serial/renesas,scif.yaml         | 73 ++++++++++++++-----
> >  1 file changed, 55 insertions(+), 18 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > index af72c3420453..eb2aa5e75e02 100644
> > --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > @@ -86,11 +86,6 @@ properties:
> >      oneOf:
> >        - items:
> >            - description: A combined interrupt
> > -      - items:
> > -          - description: Error interrupt
> > -          - description: Receive buffer full interrupt
> > -          - description: Transmit buffer empty interrupt
> > -          - description: Break interrupt
> >        - items:
> >            - description: Error interrupt
> >            - description: Receive buffer full interrupt @@ -98,21 +93,1=
7 @@ properties:
> >            - description: Break interrupt
> >            - description: Data Ready interrupt
> >            - description: Transmit End interrupt
> > +        minItems: 4
>
> I think here minItems is 1 as it is either 1 or 4 or 6

The single interrupt is handled by the first case in the oneOf (which
can probably be simplified by dropping the "items"?).

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

