Return-Path: <linux-kernel+bounces-96584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B92875E8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074141C21D21
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E3C4F1FA;
	Fri,  8 Mar 2024 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOuwsWFt"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301054EB5B;
	Fri,  8 Mar 2024 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883049; cv=none; b=narLkniEnN7DBz62tZFKmY1yeuYdZJUAWW1yKNiKyKQCYVhz3qD/tTvtLng6Dj+/ZDUTflpdu+QQRdrWBsThOQ9zBkuQHjCPUSypn/cFDrrtXYD1w3hbtvu9Ujb/DGkBFuVS+Ke25goTA0txG5V8eII9EKk3tXBc5ZA7TlN4wCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883049; c=relaxed/simple;
	bh=RQBubAAOrzeIJ1AVB3RO/dGryPeC9b+9MwRx7zozfzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbaGcyCKe216MOqFrpx9Tqfe2LiP7OhvFxLivep6UdQvgQP1UHuXJw9QOd6MDtEK1yU5w+jI7JPsxW2Pb52CHdiS0PQmoRnfGrFlgtVV0ydultY8BEdIHpL9NUSVBwIs1vk8kD5BtYRgIlassHoiEIOI4ie96F13jTCQa8bRBt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOuwsWFt; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-21f2f813e3bso1279107fac.0;
        Thu, 07 Mar 2024 23:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709883047; x=1710487847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haniZwft4cKI4inX+PJG9Yqt5S7i74415SjH5HntUuo=;
        b=ZOuwsWFt2KYkJHppLq3OqhxgIPC6mJ7wYZypBYgyFlAsLtWmvGzJ5RzecM/2PgNp5r
         MVf0CNwtEJ9FiDtFn444in/HgAyrUqNGAwxtYeTP76zI7MszFT/0jK6NK6GDQWEET8Tl
         Wwdh3LE8InhwwK3J8ND5cCH+VrO0id6C93ODaJ7tFIJJd7Asq8xVdNYucEiUNJvBvOhY
         5DTcZf1hE2XkTyeafLtzk+JUK7b3WmIYDY3G9tSe/3E2pNdQIfJq44dis4xliI0cqNdw
         NObPWrMPjEnfldBmTRcoc/xfEnpOVnUd1Ui84Se5u7ct9Db2TNw6g2vmzAxzzxTknFf6
         5PNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709883047; x=1710487847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haniZwft4cKI4inX+PJG9Yqt5S7i74415SjH5HntUuo=;
        b=xERimPO4v6Y6yPRuGfCtUttZPp9qQMO2Ni8v69oijGjKikzZuK7GxgB2GaEHqRYPIp
         0z+yjVdYFmKelyAOhj8KadZrC6TxhyGBF13FJzFeBLukzx0Y+0lYV04jhGuQOesCfAkV
         HeQTZd2SOv3WNmEM8TOoPGEQUqVc0XMhnmU6P6Dh3wjtnZ6xPddpelBFnr5MTJiPagQf
         dSm84oVVxd3TnFaea7wrxWThQOVn4pYD/+gVOu0ltkqSa+Iz8EbjWlGClGtqNDF7H0IB
         aglenFZDn7YSRpbNZMks+BbdIL4qY8oH1WGjc9YFamjCM/m4LS37EJSjYuSACdrBAPBC
         EZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCXxDmosrUXEIcRkLazgUkRH0ld4tMHJjGHbhZjec374eM6IakUi7vDTPlp1b3ZRV91zTO5KghDpxWjox71bKVHJX/K9U1Bm+PUaFffwUxkBtte6IRHwqHPULhiRD7/QUNsELPAVEN/Ov2AuDmhktc3OGsFh7B6u4W0cRc3jcfojcslFg3I=
X-Gm-Message-State: AOJu0YwVA0yCPlYFYiiHLqOM6fOj46gVgfU2oLs1wEuXnOuK2yTX1kr+
	G3T2rA8z5fSoyaSu+7ps6zYIRjKVvmrNjbbDFVYMU31fOPODVwZaKkODRu46+/s0BFxN34YGAkq
	smZPuQF0J8cw2mI/B/lPu54D9K40=
X-Google-Smtp-Source: AGHT+IGZiX9XYKiUBp+8l+Pz8MJ931cWf8obPtigppTRXErCR0+r4FF+RoS1m/WY/W7uarevs4qbHcVRWUViLmQcbVA=
X-Received: by 2002:a05:6870:a108:b0:221:88a7:d8a5 with SMTP id
 m8-20020a056870a10800b0022188a7d8a5mr1051515oae.7.1709883047312; Thu, 07 Mar
 2024 23:30:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMhs-H_eUKm7C40oCzuKwwEMZAcOJ-g4MghAfkGAmxRM0AXPUw@mail.gmail.com>
 <20240307190408.23443-1-justin.swartz@risingedge.co.za> <CAMhs-H-qHGEpjJqMu4J2SxBo1Sq3+yy74v-j=oH=P9sSt-19zg@mail.gmail.com>
In-Reply-To: <CAMhs-H-qHGEpjJqMu4J2SxBo1Sq3+yy74v-j=oH=P9sSt-19zg@mail.gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Fri, 8 Mar 2024 08:30:35 +0100
Message-ID: <CAMhs-H-S3DSaBbkRWpDEiKB=M2GjJE3xfsRXCJPWsz-YU58uRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mips: dts: ralink: mt7621: associate uart1_pins
 with serial0
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

On Fri, Mar 8, 2024 at 8:27=E2=80=AFAM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> On Thu, Mar 7, 2024 at 8:05=E2=80=AFPM Justin Swartz
> <justin.swartz@risingedge.co.za> wrote:
> >
> > Add missing pinctrl-name and pinctrl-0 properties to declare
> > that the uart1_pins group is associated with serial0.
> >
> > Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> > ---
> >  arch/mips/boot/dts/ralink/mt7621.dtsi | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts=
/ralink/mt7621.dtsi
> > index 35a10258f..dca415fdd 100644
> > --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> > +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> > @@ -123,6 +123,9 @@ serial0: serial@c00 {
> >                         reg-shift =3D <2>;
> >                         reg-io-width =3D <4>;
> >                         no-loopback-test;
> > +
> > +                       pinctrl-names =3D "default";
> > +                       pinctrl-0 =3D <&uart1_pins>;
> >                 };
> >
> >                 spi0: spi@b00 {
> > --
> >
>
>  Please add Acked-by/Reviewed-by tags when posting new versions.
>
> Thanks,
>     Sergio Paracuellos

Anyway:

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

