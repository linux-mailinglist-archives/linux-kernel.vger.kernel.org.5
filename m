Return-Path: <linux-kernel+bounces-95864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474E9875443
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22C5288E61
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D59C12FB33;
	Thu,  7 Mar 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJ80NUNi"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0811DA27;
	Thu,  7 Mar 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829426; cv=none; b=gz4S7HRZK0OgIC/ZSZ3d+VREBuzuNlRBuvE5OCoZIPinFp343q0/LGExwQzT7Ad0F5sYUXXlHp2wc3J7qjMrOrMb3xdoUNJuFV76iq3zYWXSk+xPOSR0s1HeoJN6L6tzPSJVfepEQ7KbxabS6Fc68i2z+LaHpoJQsjvYiUvuEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829426; c=relaxed/simple;
	bh=R7uLcewIPcCbOUA5r2domMq49Hm7h9Eduw6Ebo4E+5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBaxzLUE7RElLcvNl0J8In+usCyQPXaFjbVWG/s777WllOJBomAFHTJLJby5Aqb6vcsNXBcWgGthOb31YSCcXElKpGRd8iXAM0vmnwzqWM5xCBBGpChy+L9mZrRDtKaruNDVWT5a9YrA8Ws8qBCl7tMO1kfi7CTIDhGai3nNV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJ80NUNi; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e445b4f80bso537673a34.0;
        Thu, 07 Mar 2024 08:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709829424; x=1710434224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRR3aMrPNTHPyKTnpZBfnYrcMUQU7aCizh88lK2tEOw=;
        b=fJ80NUNiUmKnSTARnjTsPNUA+JlWDmHIon6TBUJytnwrGpb3Ho8LnEcSKZBuMjS8pZ
         kkK7dYyY6q0A6TJCJScBkUSANhR0HDzmyxo7ByneSsMPF1zKcD33g7zeNd2QkcNJk4hE
         rCFOu0JrLrD2MzxwU8V5Tr2N1jk0QLHl71RRFDGbfvkrh8XEwApKOrBAaVpqEMnU3cKL
         xCeCyQRMiXQoSgfnayXRrygUd5Gpm9jxlm3jvCUGCSpIkslkR7zZEwlEvGJ/Vb0efp3M
         CXL221ajBI+YbmNUXNAmErdmkTm8vT3fFZ8l34aJLfS+rZTruxBplMNw5NWsOxNQMsPd
         de0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709829424; x=1710434224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRR3aMrPNTHPyKTnpZBfnYrcMUQU7aCizh88lK2tEOw=;
        b=q4x/t3VelqAANEIZEu8tsY58Mk7gePb8sMshdYARdlcLlBVK4t1gtiPOonQcSSzihx
         OmpLmy/Y+9WvH2fTg8f1Z2xzww7qb1ZUHzANZ+SDuNpXxQMfkx2DsG+u/dLX3EcYqi8s
         l15j0rdF1xEwxwkbBRFAd0ReS2W/Xt3SmlWz9E6wfbu6N+LjLepoSCbiHbPBeNM8Gt2H
         ToP7sLzVt8zQP+tzbMXr2C6AfQLwmsofIWkLInsoaV9rDxVomIdosIUq5aBxlbEJzgXK
         IxqTC0KwT8wUNyKoCG+emBKITP5t8EOq3Dkva2ZzHGFEfkLQXRyfg8kl81LK0GIK9/U7
         bu9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWq8/uoQgSNSqhGH5YrjXF98LYVxv3OG+rU/+Qd4hAGz1dVsWbkoPhwWoSv/9Xfp70lKBYg1Db+kHfTO19daLgVF6B8UrGYBzrZlS/sHvGGbmhlND4GU2pIqx7IKzmlH0Ql+1ika9fPI2LiObdPJgVsW5AYt9nkyzFRJu8aT2zNaoyudQ8=
X-Gm-Message-State: AOJu0YwYoVnuI5NTQSYOddKuIrNmIuWXqKUYfUzx3wHcgnK/94RCjNgh
	eopK9LETkx9IxLj9bv2UDOyqr5y4aJnZ+KtqXW1Axvoaf9X8iBPw+3J1nz6cEqQ0FZPXX5FEIAw
	A1sImKMut1/cprNwrTPYFRS/MCsg=
X-Google-Smtp-Source: AGHT+IFJQktXHafepx7m2ZI9QAsBmwKMITqcJJIw//kIMZ1qNUrVo2cXeWwX3DelxvQp+xNWB9FVPEmJ0rR4dSgR1Bg=
X-Received: by 2002:a05:6871:782:b0:21e:e5db:7964 with SMTP id
 o2-20020a056871078200b0021ee5db7964mr370234oap.23.1709829423970; Thu, 07 Mar
 2024 08:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306201045.1475-1-justin.swartz@risingedge.co.za>
 <20240306201045.1475-2-justin.swartz@risingedge.co.za> <CAMhs-H9WyQZsvEvCfUcZ0_eU8--EzxEmaxR50wdRFDGP3E64ZQ@mail.gmail.com>
 <13e3063facfea3407dba23b74b0a56db@risingedge.co.za>
In-Reply-To: <13e3063facfea3407dba23b74b0a56db@risingedge.co.za>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Thu, 7 Mar 2024 17:36:51 +0100
Message-ID: <CAMhs-H_eUKm7C40oCzuKwwEMZAcOJ-g4MghAfkGAmxRM0AXPUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mips: dts: ralink: mt7621: add serial1 and serial2 nodes
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mips@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Justin,

On Thu, Mar 7, 2024 at 4:15=E2=80=AFPM Justin Swartz
<justin.swartz@risingedge.co.za> wrote:
>
> Hi Sergio
>
> On 2024-03-07 12:04, Sergio Paracuellos wrote:
> > Hi Justin,
> >
> > On Wed, Mar 6, 2024 at 9:11=E2=80=AFPM Justin Swartz
> > <justin.swartz@risingedge.co.za> wrote:
> >>
> >> Add serial1 and serial2 nodes to define the existence of
> >> UART1 and UART2.
> >>
> >> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> >> ---
> >>  arch/mips/boot/dts/ralink/mt7621.dtsi | 38
> >> +++++++++++++++++++++++++++
> >>  1 file changed, 38 insertions(+)
> >>
> >> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi
> >> b/arch/mips/boot/dts/ralink/mt7621.dtsi
> >> index dca415fdd..2069249c8 100644
> >> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> >> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> >> @@ -128,6 +128,44 @@ serial0: serial@c00 {
> >>                         pinctrl-0 =3D <&uart1_pins>;
> >>                 };
> >>
> >> +               serial1: serial@d00 {
> >> +                       status =3D "disabled";
> >> +
> >> +                       compatible =3D "ns16550a";
> >> +                       reg =3D <0xd00 0x100>;
> >> +
> >> +                       clocks =3D <&sysc MT7621_CLK_UART2>;
> >> +
> >> +                       interrupt-parent =3D <&gic>;
> >> +                       interrupts =3D <GIC_SHARED 27
> >> IRQ_TYPE_LEVEL_HIGH>;
> >> +
> >> +                       reg-shift =3D <2>;
> >> +                       reg-io-width =3D <4>;
> >> +                       no-loopback-test;
> >> +
> >> +                       pinctrl-names =3D "default";
> >> +                       pinctrl-0 =3D <&uart2_pins>;
> >> +               };
> >> +
> >> +               serial2: serial@e00 {
> >> +                       status =3D "disabled";
> >> +
> >> +                       compatible =3D "ns16550a";
> >> +                       reg =3D <0xe00 0x100>;
> >> +
> >> +                       clocks =3D <&sysc MT7621_CLK_UART3>;
> >> +
> >> +                       interrupt-parent =3D <&gic>;
> >> +                       interrupts =3D <GIC_SHARED 28
> >> IRQ_TYPE_LEVEL_HIGH>;
> >> +
> >> +                       reg-shift =3D <2>;
> >> +                       reg-io-width =3D <4>;
> >> +                       no-loopback-test;
> >> +
> >> +                       pinctrl-names =3D "default";
> >> +                       pinctrl-0 =3D <&uart3_pins>;
> >> +               };
> >> +
> >
> > Please follow the preferred order for properties described in dts
> > coding style [0]. I know that there is some mess around the properties
> > order in some nodes with the current dtsi file but we did not have
> > coding style before and now we have it, so I think we should follow it
> > at least for new additions.
>
> No problem. I see you've already "Acked-by" patch 1 (adding pinctrl
> properties to serial0) of this set, so would it be a better move to
> submit a new patch set that would look something like:
>
>   1. add pinctrl-name and pinctrl-0 to serial0 [no changes from what I
> sent]
>   2. reorder serial0 properties according to the DTS style guidelines
>   3. add serial1 and serial2 with the correct property order

This would be ok, thank you.

Best regards,
    Sergio Paracuellos

