Return-Path: <linux-kernel+bounces-40248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4EE83DD2A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522E8289F13
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B951DA40;
	Fri, 26 Jan 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0lDK0EL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A11A1D6A7;
	Fri, 26 Jan 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281943; cv=none; b=ks306yN1P/KjwyfZBnj/ki3EMNbl68SbNiFAyFeZnRvVT8hlNvOOxZfW4yq2RxqSuvoGmAOF05e3WqQlpgOGF6DTsX9zcdHhpQU+5XO5jImCNC6rb4mQ7ELQJbKXPL2qj5KL1WCPn+zGqo54e3KiUoGBQJZpuwrV7rOHGRvBCrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281943; c=relaxed/simple;
	bh=ZzvFcIgUv66hnr7o2ZQrOKg9TmffFvQoI2kqc4OG7eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+L1D2TZeEH/uRa8F2008E4iY19vl7b4BYqOhxMGZDmrGEiJ7dEOPzs1zdNAyho9Qrdd82HUzHVd4FcwdbKUFcm62aFkH5iICQH/hQcmXZp4XxsS7gk3iP4ag3BmJrpFMpdKhQVQVDdik0TgSXqZXcK1YiWROmjBdW2GIaW8H4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0lDK0EL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB004C433F1;
	Fri, 26 Jan 2024 15:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706281942;
	bh=ZzvFcIgUv66hnr7o2ZQrOKg9TmffFvQoI2kqc4OG7eA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q0lDK0EL7/urYBbTOJt7yK2oZR6RrwJn8sTlkU1cnSrGaak5H9BWtWXrUzsNPgJWR
	 aUyxTpPx5T8lDzFpzJm/gJBsQS9t0m0YlldQCH3vg8ufdCEv/VgpqAcxjvI8VybPT4
	 ozWGMplAQ6QVGBmmiERhWp+LUa5Uqh0kpFp9uZTtPQPkLrtqrGIFDbDP6eMjk+b+ML
	 WXMvf1VBeYGR2SxXnwj2g5PX/IiKZ34qP8R3M8Jbic1wy6Gh+s9R+sO7Nf6ay+fuFa
	 tV8k2gTis4qMF+zQWJshFbawOVRi38B/88tVJ0Z0UUuC5R8njjiPpvrwL2agQ0M/j9
	 VT704llz6lDVQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf206e4d56so4524991fa.3;
        Fri, 26 Jan 2024 07:12:22 -0800 (PST)
X-Gm-Message-State: AOJu0YyHUK1Kzc47FsgBktbOH+PwBl32xVD76KfFeaiAUQeVi1GJiiFD
	uVjEjHlGXnsmHOKlCj5Gm3n5ukJTT+0Jcr2hgwlX4PvfVx4Y0Ps5jiDC3b0zn7QHlB8dfvQ3fXh
	8GDyNv/8nNXlwCrVCcCMEG9xleg==
X-Google-Smtp-Source: AGHT+IGREK4XmjCNNNrRn0lSi06DN7xy1IT3OfgAbMi81ljYEvKn2df/Sm2jW+A9dzS7YzuSsITsCfiqsxGy8Y0KNkA=
X-Received: by 2002:a2e:9d89:0:b0:2cd:633c:55d6 with SMTP id
 c9-20020a2e9d89000000b002cd633c55d6mr750055ljj.25.1706281940761; Fri, 26 Jan
 2024 07:12:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122173514.935742-1-robh@kernel.org> <BN9PR18MB4251944C1AE34057DACD7556DB742@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20240123224324.GA2181680-robh@kernel.org> <20240125100331.5d3ce739@xps-13>
In-Reply-To: <20240125100331.5d3ce739@xps-13>
From: Rob Herring <robh@kernel.org>
Date: Fri, 26 Jan 2024 09:12:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJcQgBY+o_rniMWmJ5=zA0aG1YSDCayQTp=Nw=xwRPMYg@mail.gmail.com>
Message-ID: <CAL_JsqJcQgBY+o_rniMWmJ5=zA0aG1YSDCayQTp=Nw=xwRPMYg@mail.gmail.com>
Subject: Re: [EXT] [PATCH net-next] net: marvell,prestera: Fix example PCI bus addressing
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Elad Nachman <enachman@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 3:03=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hello,
>
> > > > The example for PCI devices has some addressing errors. 'reg' is wr=
itten as if
> > > > the parent bus is PCI, but the default bus for examples is 1 addres=
s and size
> > > > cell. 'ranges' is defining config space with a size of 0. Generally=
, config space
> > > > should not be defined in 'ranges', only PCI memory and I/O spaces. =
Fix these
> > > > issues by updating the values with made-up, but valid values.
> > > >
> > > > This was uncovered with recent dtschema changes.
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/net/marvell,prestera.yaml | 4 ++=
--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/net/marvell,prestera=
yaml
> > > > b/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> > > > index 5ea8b73663a5..16ff892f7bbd 100644
> > > > --- a/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> > > > @@ -78,8 +78,8 @@ examples:
> > > >      pcie@0 {
> > > >          #address-cells =3D <3>;
> > > >          #size-cells =3D <2>;
> > > > -        ranges =3D <0x0 0x0 0x0 0x0 0x0 0x0>;
> > > > -        reg =3D <0x0 0x0 0x0 0x0 0x0 0x0>;
> > > > +        ranges =3D <0x02000000 0x0 0x100000 0x10000000 0x0 0x0>;
> > > > +        reg =3D <0x0 0x1000>;
> > > >          device_type =3D "pci";
> > > >
> > > >          switch@0,0 {
> > > > --
> > > > 2.43.0
> > > >
> > >
> > > This yaml has a mix-up of device P/N (belonging to AC3, BC2) and PCIe
> > > IDs (belonging to AC3X, Aldrin2)
> > > Looks like a part of the yaml was updated, and another part was not
> > >
> > > There is a reference here of actual usage of prestera switch device:
> > > https://github.com/dentproject/linux/blob/dent-linux-5.15.y/arch/arm6=
4/boot/dts/marvell/accton-as4564-26p.dts
> >
> > That doesn't match upstream at all...
>
> Yes, the DTS there are not up to date. I actually took mine (see below)
> from:
> https://github.com/dentproject/linux/blob/dent-linux-5.15.105/arch/arm64/=
boot/dts/marvell/delta-tn48m.dts#L133
> and fixed the Prestera representation (a root node does not make any
> sense).
>
> > > So actual ranges and reg could be used instead of made up ones.
> > >
> > > But the actual real life dts places the prestera at the top level of
> > > the dts, not under pci.
> > >
> > > I am not aware of any dts/dtsi using such kind of switch node under
> > > pcie node, similar to the example given in the yaml file, and did not
> > > manage to find any under latest linux-next for both arm and arm64 dts
> > > directories (please correct me here if I am wrong).
> >
> > Don't know. It seems plausible.
>
> The DT where this is used is public but not upstream, it was derived
> from the above link:
> https://github.com/miquelraynal/linux/blob/onie/syseeprom-public/arch/arm=
64/boot/dts/marvell/armada-7040-tn48m.dts#L316
>
> > > So the question here is if this pci example really necessary for the
> > > prestera device, or can be removed altogether (which is what I think =
is best to do).
> >
> > Miquel's commit adding indicates such devices exist. Why would he add
> > them otherwise?
> >
> > Anyways, I'm just fixing boilerplate to make the PCI bus properties
> > valid. Has nothing to do with this Marvell device really.
>
> I can't remember why the example in the schema is slightly different
> (must have seen an update) but here is the exact diff I used to get it
> working. Maybe the reg/ranges are loose though, TBH I've always been
> a bit lost by PCI DT properties.

Yeah, there aren't many examples to go on, but I'm trying to improve
the schema to better constrain PCI nodes to be correct.

>
> +       pci@0,0 {
> +               device_type =3D "pci";
> +               reg =3D <0x0 0x0 0x0 0x0 0x0>;
> +               ranges;
> +               #address-cells =3D <3>;
> +               #size-cells =3D <2>;
> +               bus-range =3D <0x0 0x0>;
> +
> +               switch@0,0 {
> +                       reg =3D <0x0 0x0 0x0 0x0 0x0>;
> +                       compatible =3D "pci11ab,c80c";
> ...
>
> Would something like this work better for the example?

While this is valid on its own, it's not with the example template.
The example has to have a host bridge node because the template is
just the default bus addressing and there has to be translation to PCI
addressing. To put it another way, we can only check 'reg' if the
parent node is valid, but with the above the parent node is wrong.

> FYI the pci@0,0 node is a child of
>
>         CP11X_LABEL(pcie0): pcie@CP11X_PCIE0_BASE
>
> from armada-cp11x.dtsi (which is upstream).

Right, that's the host bridge and then the root port node and then the
device. Whether there's a root port or not is outside the scope of
this binding, but if you want to show it that's fine.

Rob

