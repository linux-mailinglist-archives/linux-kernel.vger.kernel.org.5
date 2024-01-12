Return-Path: <linux-kernel+bounces-24909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A482C48B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA002B24139
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3944D17570;
	Fri, 12 Jan 2024 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU0gdRsk"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF717569;
	Fri, 12 Jan 2024 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7ce415b5492so1872301241.0;
        Fri, 12 Jan 2024 09:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705079713; x=1705684513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkseUqPo8OXQ3YOG2VTgeQHbmBTlfvlda5FttZ/w2HE=;
        b=BU0gdRske5sEcPRZiDZAZ9wfpmC01sS+A7WZGh+y7jBvkc7rk2YJPOt3Ofh8zrd0u+
         huw+KJrOZmJ41xaJQpjUf7jDQ8Jr2CGSrGagnbOSrnEO08CozNZmmkxN7NMGmfgE1lnu
         8T96B8byIzkTadvH9I3HrXJ3XN0+V0KqaATNZ/dcpH1EgB/71h0JTaFV1AmqqwQ8L0iU
         39LDIwE++44yjITXFag8YDlYJoa/GRJMvTFo8I2qFO9tZyaHZDizt/bXjBU1r1EfpURp
         g3WEuAt/R6QtQkblmzD1alNYe3La0JJ1fd5YfxQ3ZzL9x2WQU3BdVLgAxfu14rCRqo6P
         QRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705079713; x=1705684513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkseUqPo8OXQ3YOG2VTgeQHbmBTlfvlda5FttZ/w2HE=;
        b=kVvLxz9EIz0Z6Iu5cFLtPLGcBI7V236gy0mLls4qX+hNvG7nHlEkdKuyWznd3FuQDn
         ueBGZbA9+0t9MmuRTibt+mzElo7YHHGvoHueTHR5voCo23gva6jr1XSR2dP60kHpaHdI
         R0N4XcGhyTBHyNwSklJWxS4VG9QIzhGwE/ChMCG6J+DVpxVzVnShtbLbgSWkBDTa4E1R
         TrXL/DjBEkEjAxtYngvhr50SIreVxr+MKE8fEZyAUSV7PKA/L4D14Puj2dqLqOBJXv6U
         bHz4bNlmliN+SIMCEOJf2qzCKBqERLD3rA/2sDRNA5mSiqp5WQJHCVQWEji5wonDCmr5
         r0vA==
X-Gm-Message-State: AOJu0YxJJJ3zmhLDY9s82ylTmd1vd9JKIzcll9CrzGWu0o9Q9gdOQQyN
	Qr+FKBkyAH14Ep5lVYPIRqHNicwtl3sljRc3jus=
X-Google-Smtp-Source: AGHT+IEtyS+zRiryoiEol1GpjC1w298O0gfObrmREKMAHHDiKjWPg5utyGaAszkNnTgUD0jUCqxwBLwFcY9rn2/AIc0=
X-Received: by 2002:a05:6122:400f:b0:4b6:e339:31b3 with SMTP id
 ca15-20020a056122400f00b004b6e33931b3mr1348367vkb.27.1705079712913; Fri, 12
 Jan 2024 09:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112142621.13525-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240112142621.13525-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYCPR01MB112699FAB53E6E4647893516B866F2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <CA+V-a8smkiub9ACDsqxv0z8yF_iLVEXG2OHwS7iJ+tmsdmTQ6g@mail.gmail.com> <TYCPR01MB11269F75A63DB020297DF21DA866F2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB11269F75A63DB020297DF21DA866F2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 12 Jan 2024 17:14:46 +0000
Message-ID: <CA+V-a8tsxoaLfxCHmViyewYVbtZMkDAkYjUUYAoH_2MDi2ugBw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] pinctrl: renesas: pinctrl-rzg2l: Add the missing
 port pins P19 to P28
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 5:10=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
>
>
> > -----Original Message-----
> > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: Friday, January 12, 2024 5:06 PM
> > Subject: Re: [PATCH v4 3/4] pinctrl: renesas: pinctrl-rzg2l: Add the
> > missing port pins P19 to P28
> >
> > Hi Biju,
> >
> > Thank you for the review.
> >
> > On Fri, Jan 12, 2024 at 2:31=E2=80=AFPM Biju Das <biju.das.jz@bp.renesa=
s.com>
> > wrote:
> > >
> > >
> > > Hi Prabhakar,
> > >
> > > > -----Original Message-----
> > > > From: Prabhakar <prabhakar.csengg@gmail.com>
> > > > Sent: Friday, January 12, 2024 2:26 PM
> > > > Subject: [PATCH v4 3/4] pinctrl: renesas: pinctrl-rzg2l: Add the
> > > > missing port pins P19 to P28
> > > >
> > <snip>
> > > >
> > > > +/**
> > > > + * struct rzg2l_variable_pin_cfg - pin data cfg
> > > > + * @cfg: port pin configuration
> > > > + * @port: port number
> > > > + * @pin: port pin
> > > > + */
> > > > +struct rzg2l_variable_pin_cfg {
> > > > +     u32 cfg:20;
> > > > +     u8 port:5;
> > >
> > >  u32 ??
> > This is done based on the feedback provided previously by Geert [0].
> >
> > > > +     u8 pin:5;
> > >
> > >  u32 ??
> > >
> > ditto.
> >
>
> As per[0] suggestion is,
>
> As cfg only contains the lower bits (PIN_CFG_*), I think you can fit
> everything in a u32:
>
>     u32 cfg: 20;
>     u32 port: 5;
>     u32 pin: 3;
>
Ouch my bad, i'll send a v5 with this change.

Cheers,
Prabhakar

