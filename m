Return-Path: <linux-kernel+bounces-159041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0268B288C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7551C21CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982BB1514CB;
	Thu, 25 Apr 2024 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3PNXc21"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D012C463;
	Thu, 25 Apr 2024 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071322; cv=none; b=IXKAyDMSJbkrt6yL0M5KyqGAUUivI2gvvHjh/7wG/rTe69v6mXJdoCBgXb51w/UolM2J2S8QWAv1EIk4D9ugYGWy6qem2/ZrR/EC3OvZWwSRXrKR62ZU6tzt1MPW2g8JkkN2EXjqGFddrxUeD9+2TzSRzYZEoPiW0sFdAPK2ckA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071322; c=relaxed/simple;
	bh=KxmqUt8F4G/yFxz+7kc5MS3j/R0QuocSr2+7FqOmYCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zb8d51HHqaSjbwmrsnq9piOdADxeiHqqBLFVeODMCr3H/harT1hThFsVrVsZ2dSJw99PMS3xQpY7VmBQU00PSKWD5NDxIGWA61b+nfT1lplj//j2MrNR068LpXTi7ZCUEp3VYnd6uSvySkKl1y1ujKd/6Jwprxk3RUEqxCQybso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3PNXc21; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4dcc7c1055bso426136e0c.0;
        Thu, 25 Apr 2024 11:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714071320; x=1714676120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEcc77KCdofgKqsZ5QkU1749SvUlrYrgYmbv43ylHCc=;
        b=R3PNXc21UZReHh15nBNsyKFwiAR7mZ7zoJIIgirhxnVDKIEoEi4zXCgwwlDhSpg0Ws
         uFYmXO+iP7F+/lQaSmiuCWzvMSaY6Wf6wrEA3z+llkZd9xGVfSCbHBP5PwTXDN8VrpCl
         3xoQWDlxcqEwsR2Qm4jdygLsCU2EMfeOZD2LBlPnAxFKQZLEOgd22uGAuQE/FcAO0UCi
         dgM2U/QaxSIRiwu2zoe+wOlU9+9Li852EdazkjviO7mbM6mq3bbqKNgTZOQQmpMV2KmL
         n5fD9GhjdTheSrVHXOTpSW8R/sZf/3RqkWj7IvpeqX3bc6Ryxo8qvyIaPuS/JZh2k6bM
         1jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714071320; x=1714676120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEcc77KCdofgKqsZ5QkU1749SvUlrYrgYmbv43ylHCc=;
        b=c+zq8B8b/nyvqn4DzTlRtehRy3Zbc0+dapCEuFpkPU94Y4ryVkwgOm4ztPJoTKoQal
         YPSRO2jzMFfNMbHUlYE0xhhQtAZmgJtxqjKYKuGvt7S9ox79G7V47MZLXZ5ZIuxvlMoQ
         MZe6JuUpCiDwu611lHzOQTH1DBDA7VC3dS9ThhYsArLfeLdZzJI2kzNI3TQ6nujTi1S+
         XpCQ4odHbs35Cc3Q4RDHe97Jf2lRJRkC4wdpNfAXCyOl1CHYJ1xG6wEvQeoWso5P9++d
         +HuIfGLHCG0TD7t0zNn756o40nuskLdO+8ukBL8BTsgoXKJczvnabd62MOPSJPeXm69r
         a7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm2eVz0UM45rY0jDwM44yf+JsB3HhLn0nMVX25ZWflNQCxWVRkh7DeM88nFBwUGMFxItt52YZ2e0azFrd9Li8xZxrTxez0JNTyAdp14ukzzP2zufaNuqln4hhz2zk9OfcL8mJrcJ6fZJumbKu66ByK1+LOdoNDNtGwt9FncQuWy+9TWVmPhyU2oeq3VAKszbFFwpIhkRjtiVZAF3KKAPeJXoKdYf3s
X-Gm-Message-State: AOJu0Yx8UXSURWlbdlDf61hL2k7Vyj4Y+LNNIko0ndgs5Z4WVqDAegg8
	DoODjLbo8aXT9Riwj7HRh8yIuT1l4s7usZnnYGXDo+18csjZI0968LGzgGHtcsNZTTox9yav06f
	pSChY+TeuAhAO0klsKv3m9j7P6Aw=
X-Google-Smtp-Source: AGHT+IH3cOqIGPXstDyU3923hybok8dAgkstSnmJLdFF2hNDRjN4yiEFqkBac1FjonK9+ljxBsrX6YCYEFlx6EWRM4o=
X-Received: by 2002:a05:6122:201c:b0:4c9:a9c9:4b3b with SMTP id
 l28-20020a056122201c00b004c9a9c94b3bmr321734vkd.9.1714071318808; Thu, 25 Apr
 2024 11:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423182428.704159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240423182428.704159-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <7a3d4b8a-e89e-499e-92b7-9f63fbc84011@kernel.org> <CA+V-a8uz0OrsM1AxqtpeHB0f1+F6aEqHGp_t3_OPhh0ZqJ26HQ@mail.gmail.com>
 <CAMuHMdV=CTUQNm6OZN0Ck-nXKme8vZ2Ld2rDxHfQZkP2VdnNeQ@mail.gmail.com>
In-Reply-To: <CAMuHMdV=CTUQNm6OZN0Ck-nXKme8vZ2Ld2rDxHfQZkP2VdnNeQ@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 25 Apr 2024 19:54:37 +0100
Message-ID: <CA+V-a8t+G07MXjgHw23-+hQ_OB0Qu+QxeSPwHoy9t1DHChbN+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: renesas,sdhi: Group single const
 value items into an enum list
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Thu, Apr 25, 2024 at 6:11=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Apr 25, 2024 at 5:44=E2=80=AFPM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Wed, Apr 24, 2024 at 6:42=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> > > On 23/04/2024 20:24, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Group single const value items into an enum list.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> > > > ---
> > > > v1->v2
> > > > - Updated commit message
> > > > - Grouped single const value items into an enum list.
> > > > ---
> > > >  .../devicetree/bindings/mmc/renesas,sdhi.yaml  | 18 +++++++-------=
----
> > > >  1 file changed, 7 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yam=
l b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > > > index 29f2400247eb..2bf90095742b 100644
> > > > --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > > > +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > > > @@ -13,15 +13,13 @@ properties:
> > > >    compatible:
> > > >      oneOf:
> > > >        - items:
> > > > -          - const: renesas,sdhi-sh73a0  # R-Mobile APE6
> > > > -      - items:
> > > > -          - const: renesas,sdhi-r7s72100 # RZ/A1H
> > > > -      - items:
> > > > -          - const: renesas,sdhi-r7s9210 # SH-Mobile AG5
> > > > -      - items:
> > > > -          - const: renesas,sdhi-r8a73a4 # R-Mobile APE6
> > > > -      - items:
> > > > -          - const: renesas,sdhi-r8a7740 # R-Mobile A1
> > > > +          - enum:
> > >
> > > You wanted to drop the items, but I still see it here.
> > >
> > Ah, I missed that.
> >
> > > > +              - renesas,sdhi-sh73a0  # R-Mobile APE6
> > > > +              - renesas,sdhi-r7s72100 # RZ/A1H
> > > > +              - renesas,sdhi-r7s9210 # SH-Mobile AG5
> > > > +              - renesas,sdhi-r8a73a4 # R-Mobile APE6
> > > > +              - renesas,sdhi-r8a7740 # R-Mobile A1
> > > > +              - renesas,sdhi-mmc-r8a77470 # RZ/G1C
> > >
> > > Keep list alphabetically ordered.
> > >
> > This list is sorted based on SoC, I will sort it  alphabetically.
> >
> > Geert is that OK with you?
>
> Usually we sort alphabetically by compatible value.
>
Thank you for the confirmation.

> (FTR, sh73a0 is sometimes called r8a73a0).
>
Got that.

Cheers,
Prabhakar

