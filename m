Return-Path: <linux-kernel+bounces-118544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD30288BC71
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A28B2232F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60FDC2E9;
	Tue, 26 Mar 2024 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjJFeM/x"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544ED17C9;
	Tue, 26 Mar 2024 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441838; cv=none; b=MrXX7H2jQp8WKNfDhSCIb50Vg+GdSpvl93+I+mdkOhkR+Jvn6SVpuM4PS0C9ahpFYu10+aR2wGfsuS4nGItYWc6qlEnS4lvojKcyKfK6UXE5f/ogqs4eN0ONCZwPzrEhVg6A5/rst0OMecjIoUbyEfXAnQSqmE2N95G2nAqYkRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441838; c=relaxed/simple;
	bh=6VPDA+PMisBVXjlIjgb098mX0wgpz+kF+GQ3qr5PvKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6Z3PNqNmnfzRotDnfa3rCeeEr92GP7enGLyGPxFby1GZz7AsiohTs+8XZDs5socHWyKbT5A9YdqOkLuAIYdHwr/670gwG/gbUFfV4i9SK2Yxb7EBoI/uycxqCURgLjwDYp+35pZ+pZGfLhJexIxuJHnBPNqlhvrFri9KrcDWNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjJFeM/x; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-430b870163eso58189411cf.1;
        Tue, 26 Mar 2024 01:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711441836; x=1712046636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQNNudEt3wJLbqZOHESyaBm0XKGrjZUhNl5wxbVBy4U=;
        b=NjJFeM/xPg+s9d4IkkFF/XvExBbkseyFxbd99sahfEDI6q4JAajaGmVKxj2dq8eW89
         f/B4YGzv+rqhiqUh3aeYmn/uc7/ZBed0AepC+YLlkU/TQBu/yGxp7ciU9IHik3ZcyTwl
         uEik+q9B7lEmON1NxopnAEJhGgbTArHa4ko0L5TOVnBL8eh8WJa5cdkP3XcEOX6xr8xX
         mIwbry4yWhYa9NjTEeRD1/P9LVDtcDHzc9grKkmRd0F8bqXSY8w2tgvr+SKjHCScSWdl
         Qt/cWKRc+IwrugDW00wnTvfn//AgJfwsZBjZciQzfBty8N18xf7GpmJsaWEXMz+C5Rv/
         VFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711441836; x=1712046636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQNNudEt3wJLbqZOHESyaBm0XKGrjZUhNl5wxbVBy4U=;
        b=VqyObP+YGwXFD+C7v7eh5ZvoiJLPtF8Xo0wfd1TIDozz/5UIbnuwko4IMhtVmrAw/+
         76CFcRFs70d2mWfXBvA2573Luhkf7n0TqRKUnS18X6lRtimgTLc2ocvBqpVj+sMyGIjY
         23FhlWW5y8FDczQRZYGbxFE4wpxxcIgkQMTKayyR53UxBApaQIJpzwR/Ir/Lmc0zryI8
         jqKrvha4ms1VTY2wKs12kYWOeUDgvWGUOxXGo91L9tDIIZnL5wfj1/0KXCIPLOLuD2oM
         qtuVkoTsIFzBNATIziayUVOJmgAOfz00g5Ryxw2RvqH3huPgKFs6fdBFThytpb5spaYy
         cgVA==
X-Forwarded-Encrypted: i=1; AJvYcCVntlzAIwO8FvMRBgbiXxc5TqkDZ8MWi69QMubtuujxKw8lz9rRvrT3WKPzt6G7e2/wd6+MPo3v9aEK1o1x6ivx5PXTf85dR2s2HE83kytL+PCfhIhbv3jwJLD7RHmP6SjIgxTxRwwS0P7uNz7T4VdB/zBoHc9aeSDuZDVuPAylv4TuVeyJ+1rQOgu7bhMOi0W4Cy+FHur8ZGxqVS0/VMKI3Ah6L7TfoAgh
X-Gm-Message-State: AOJu0YynClImOiyN/Mj05TSIh6bvGWjGrXVLs8EcXDg9mIAPf7KUnhWr
	4i3Vv+B56tF8QcdMsiVfdn1JN3ZhhidzLhjVL9hXjd/D6PPBmiE+hbEsVHb86OZuDQSKHbFsQBr
	CtyTql5h+GahEJhzcC2w+bo5PB30=
X-Google-Smtp-Source: AGHT+IFk6irZp2aZRbS4dA3Z7x5qxN+RpzYLBI+PLz6iWY/Fr4QPAYIc+Utnm4+SuxPou5jq52RA13hLp9Z9c+44jhQ=
X-Received: by 2002:a05:622a:2a0b:b0:431:7500:e92d with SMTP id
 hc11-20020a05622a2a0b00b004317500e92dmr307130qtb.28.1711441836223; Tue, 26
 Mar 2024 01:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240322144355.878930-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <OSAPR01MB15871221D42B6CEAA08168C386362@OSAPR01MB1587.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB15871221D42B6CEAA08168C386362@OSAPR01MB1587.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 26 Mar 2024 08:29:04 +0000
Message-ID: <CA+V-a8sL9+ZCdWtqrFn9KF4f+jXJ5BBSqOkSCfAAe-LSLJxF0A@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
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

On Mon, Mar 25, 2024 at 4:21=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Hi Prabhakar,
>
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
>
minItems 1 case is already handled above.

Cheers,
Prabhakar

