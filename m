Return-Path: <linux-kernel+bounces-29414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A81830DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112261F21C43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD7B24B4A;
	Wed, 17 Jan 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqtXpwHh"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA924B2F;
	Wed, 17 Jan 2024 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523212; cv=none; b=dZpXhPlbynjl9jy51bjrWhwRt8Yo3IhNrDld0fHJgva4DyjzFz/rt5Xwitk2i2txUIwxT/QGOBBbz33hT3HhxqXihbl2mno5eTwBII8Q7F3rkg+gppEoZEeEuRG1+EJEtL6NFF8g7wi0AWERw5X1DgktFYbpF4+hMbqBOd6gL0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523212; c=relaxed/simple;
	bh=jGM28CC2YWMbqnoVLLqFN+N4yr4yanJQQwPKgy2CviA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:X-Google-Original-Message-ID:Date:From:To:Cc:Subject:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=DTzXSItZWWxqqctj7GplFd60CZ25ntzyCz94yNGCSm+KxyPTs8Wr22B/en5YxjdEOvQm/rgZA0W1GH7yzGqTYmCiU+8Dv1xzukr7TjLRhUbpVprSK9enzfRe2/VZ4ZVlreebeYdwA4X59RDz1VovGN7XCBLRowgmWmziVvWOvic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqtXpwHh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e7065b692so42130345e9.3;
        Wed, 17 Jan 2024 12:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705523208; x=1706128008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P8rf2SDpeJIDnLRy/4kZh4YbVZ8HNJJqeRRnm/LfsEg=;
        b=IqtXpwHhDiYv5u03XtQExMKkOQ1v3O+ZI8zN3Pt9l0Pn39es5f3SE1W+BEt367/fqR
         MYkvJlt8yhxgCtA1YD56Mg/ocfQI8jfL6hfMAY5TGNMrGTMG3vsFJRlpkzzLezyAiI4p
         S4Gckg0u9oafHaQCYoibG7Rc8K3ePOJWFauphaJSfzLK3KTtEiMjhwSQNueJkhUtCLY1
         t9uH6P8BjMVcqDCfEagrUf9tZuSaImmQRsP9njwnl3x8ekWNx6VJOnn++jo+c409D/iU
         n3Bm/wHRGIpBmEP5pD+dCuENoDrio0SuLil0eTw/euG0PXzjzObtIxI3Y5XvNxkFfnNx
         +hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705523208; x=1706128008;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8rf2SDpeJIDnLRy/4kZh4YbVZ8HNJJqeRRnm/LfsEg=;
        b=TXdvxyp1/eIQiA9OHO5N+xYaRSVgkvsVdgRrTjfw14hbb6HzCf6/mSRsSZD8Ow0yvr
         0K9AzFZABsuFLJQT1kX13nYXqAULsm9nuJ+ojv1x5LclsjJ2SDFsDWNJK/otmSGr69Dx
         JV3kTiDjes+KIXtep8zGdBkT1/tbMIuW2pu4x2A3bXRJl/api1IYAYcl/jNhO6/UKQC4
         BUD4m9BYrJkaOT48xbw6wIlnZvW96dbmiwlnB8b7INLVxb6NcEfcjXZ0m4XtGn86sj2T
         t66PKAGb6VxR7edpfwRIuQmdrkjqyZJ3iHn6WLGYzStF+AakSa35vRb9tua2LO2viH/F
         Vzvw==
X-Gm-Message-State: AOJu0YyoATPPOGCnV0vYnI9weFzdrL3TCPGTx1EwFSTeXu6XR8yG7o5o
	N4Dl29i4vEru/CDg361cpmQ=
X-Google-Smtp-Source: AGHT+IG3pkOgSDyG+Mim9jG1CanLVxlpdPUceoeyNtzuTV3xqSw0NqiLc1i5iKJYa6LT/U+Zz9yseA==
X-Received: by 2002:a05:600c:2215:b0:40d:88f2:fe7c with SMTP id z21-20020a05600c221500b0040d88f2fe7cmr5184282wml.77.1705523208064;
        Wed, 17 Jan 2024 12:26:48 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b0040e77ce8768sm11653057wmr.16.2024.01.17.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 12:26:47 -0800 (PST)
Message-ID: <65a83807.050a0220.506d0.65fd@mx.google.com>
X-Google-Original-Message-ID: <ZagyqhEwZnMWHnn6@Ansuel-xps.>
Date: Wed, 17 Jan 2024 21:03:54 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Robert Marko <robert.marko@sartura.hr>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Luo Jie <quic_luoj@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH RFC v3 1/8] dt-bindings: net: document ethernet
 PHY package nodes
References: <20231126015346.25208-1-ansuelsmth@gmail.com>
 <20231126015346.25208-2-ansuelsmth@gmail.com>
 <0926ea46-1ce4-4118-a04c-b6badc0b9e15@gmail.com>
 <659aedb1.df0a0220.35691.1853@mx.google.com>
 <0f4ec2ff-4ef7-4667-adef-d065cfbc0a91@gmail.com>
 <65a7210f.df0a0220.d10b2.1162@mx.google.com>
 <c81af808-d836-4054-b596-4a53b05f4c78@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c81af808-d836-4054-b596-4a53b05f4c78@gmail.com>

On Wed, Jan 17, 2024 at 09:39:25PM +0200, Sergey Ryazanov wrote:
> Hi Christian,
> 
> On 17.01.2024 02:36, Christian Marangi wrote:
> > On Sun, Jan 07, 2024 at 11:49:12PM +0200, Sergey Ryazanov wrote:
> > > Hi Christian,
> > > 
> > > On 07.01.2024 20:30, Christian Marangi wrote:
> > > > On Sun, Jan 07, 2024 at 08:00:33PM +0200, Sergey Ryazanov wrote:
> > > > > On 26.11.2023 03:53, Christian Marangi wrote:
> > > > > > Document ethernet PHY package nodes used to describe PHY shipped in
> > > > > > bundle of 4-5 PHY. The special node describe a container of PHY that
> > > > > > share common properties. This is a generic schema and PHY package
> > > > > > should create specialized version with the required additional shared
> > > > > > properties.
> > > > > > 
> > > > > > Example are PHY package that have some regs only in one PHY of the
> > > > > > package and will affect every other PHY in the package, for example
> > > > > > related to PHY interface mode calibration or global PHY mode selection.
> > > > > > 
> > > > > > The PHY package node MUST declare the base address used by the PHY driver
> > > > > > for global configuration by calculating the offsets of the global PHY
> > > > > > based on the base address of the PHY package and declare the
> > > > > > "ethrnet-phy-package" compatible.
> > > > > > 
> > > > > > Each reg of the PHY defined in the PHY package node is absolute and will
> > > > > > reference the real address of the PHY on the bus.
> > > > > > 
> > > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > > ---
> > > > > >     .../bindings/net/ethernet-phy-package.yaml    | 75 +++++++++++++++++++
> > > > > >     1 file changed, 75 insertions(+)
> > > > > >     create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..244d4bc29164
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > > > > > @@ -0,0 +1,75 @@
> > > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/net/ethernet-phy-package.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: Ethernet PHY Package Common Properties
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > > > > +
> > > > > > +description:
> > > > > > +  This schema describe PHY package as simple container for
> > > > > > +  a bundle of PHYs that share the same properties and
> > > > > > +  contains the PHYs of the package themself.
> > > > > > +
> > > > > > +  Each reg of the PHYs defined in the PHY package node is
> > > > > > +  absolute and describe the real address of the PHY on the bus.
> > > > > > +
> > > > > > +properties:
> > > > > > +  $nodename:
> > > > > > +    pattern: "^ethernet-phy-package(@[a-f0-9]+)?$"
> > > > > > +
> > > > > > +  compatible:
> > > > > > +    const: ethernet-phy-package
> > > > > > +
> > > > > > +  reg:
> > > > > > +    minimum: 0
> > > > > > +    maximum: 31
> > > > > > +    description:
> > > > > > +      The base ID number for the PHY package.
> > > > > > +      Commonly the ID of the first PHY in the PHY package.
> > > > > > +
> > > > > > +      Some PHY in the PHY package might be not defined but
> > > > > > +      still exist on the device (just not attached to anything).
> > > > > > +      The reg defined in the PHY package node might differ and
> > > > > > +      the related PHY might be not defined.
> > > > > > +
> > > > > > +  '#address-cells':
> > > > > > +    const: 1
> > > > > > +
> > > > > > +  '#size-cells':
> > > > > > +    const: 0
> > > > > > +
> > > > > > +patternProperties:
> > > > > > +  ^ethernet-phy(@[a-f0-9]+)?$:
> > > > > > +    $ref: ethernet-phy.yaml#
> > > > > > +
> > > > > > +required:
> > > > > > +  - compatible
> > > > > > +  - reg
> > > > > > +
> > > > > > +additionalProperties: true
> > > > > > +
> > > > > > +examples:
> > > > > > +  - |
> > > > > > +    mdio {
> > > > > > +        #address-cells = <1>;
> > > > > > +        #size-cells = <0>;
> > > > > > +
> > > > > > +        ethernet-phy-package@16 {
> > > > > > +            #address-cells = <1>;
> > > > > > +            #size-cells = <0>;
> > > > > > +            compatible = "ethernet-phy-package";
> > > > > > +            reg = <0x16>;
> > > > > > +
> > > > > > +            ethernet-phy@16 {
> > > > > > +              reg = <0x16>;
> > > > > > +            };
> > > > > > +
> > > > > > +            phy4: ethernet-phy@1a {
> > > > > > +              reg = <0x1a>;
> > > > > > +            };
> > > > > > +        };
> > > > > > +    };
> > > > > 
> > > > > So, we ended up on a design where we use the predefined compatible string
> > > > > 'ethernet-phy-package' to recognize a phy package inside the
> > > > > of_mdiobus_register() function. During the V1 discussion, Vladimir came up
> > > > > with the idea of 'ranges' property usage [1]. Can we use 'ranges' to
> > > > > recognize a phy package in of_mdiobus_register()? IMHO this will give us a
> > > > > clear DT solution. I mean 'ranges' clearly indicates that child nodes are in
> > > > > the same address range as the parent node. Also we can list all child
> > > > > addresses in 'reg' to mark them occupied.
> > > > > 
> > > > >     mdio {
> > > > >       ...
> > > > > 
> > > > >       ethernet-phy-package@16 {
> > > > >         compatible = "qcom,qca8075";
> > > > >         reg = <0x16>, <0x17>, <0x18>, <0x19>, <0x1a>;
> > > > >         ranges;
> > > > >         ...
> > > > > 
> > > > >         ethernet-phy@16 {
> > > > >           reg = <0x16>;
> > > > >         };
> > > > > 
> > > > >         ethernet-phy@1a {
> > > > >           reg = <0x1a>;
> > > > >         };
> > > > >       };
> > > > >     };
> > > > > 
> > > > > Did you find some issues with the 'ranges' conception?
> > > > 
> > > > Nope it's ok but it might pose some confusion with the idea that the
> > > > very first element MUST be THE STARTING ADDR of the PHY package. (people
> > > > might think that it's just the list of the PHYs in the package and
> > > > remove the hardware unconnected ones... but that would be fault of who
> > > > write the DT anyway.)
> > > 
> > > Make sense. I do not insist on addresses listing. Mainly I'm thinking of a
> > > proper way to show that child nodes are accessible directly on the parent
> > > bus, and introducing the special compatibility string, while we already have
> > > the 'ranges' property.
> > > 
> > > But it's good to know Rob's opinion on whether it is conceptually right to
> > > use 'ranges' here.
> > > 
> > 
> > I wonder if something like this might make sense... Thing is that with
> > the ranges property we would have the define the address in the PHY
> > Package node as offsets...
> > 
> > An example would be
> > 
> >      mdio {
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> > 
> >          ethernet-phy-package@10 {
> >              #address-cells = <1>;
> >              #size-cells = <0>;
> >              compatible = "qcom,qca807x-package";
> >              reg = <0x10>;
> >              ranges = <0x0 0x10 0x5>;
> > 
> >              qcom,package-mode = "qsgmii";
> > 
> >              ethernet-phy@0 {
> >                  reg = <0>;
> > 
> >                  leds {
> > 
> > 		...
> > 
> > With a PHY Package at 0x10, that span 5 address and the child starts at
> > 0x0 offset.
> > 
> > This way we would be very precise on describing the amount of address
> > used by the PHY Package without having to define the PHY not actually
> > connected.
> > 
> > PHY needs to be at an offset to make sense of the ranges first element
> > property (0x0). With a non offset way we would have to have something
> > like
> > 
> > ranges = <0x10 0x10 0x5>;
> > 
> > With the child and tha parent always matching.
> > 
> > (this is easy to handle in the parsing and probe as we will just
> > calculate the real address based on the base address of the PHY package
> > + offset)
> 
> On one hand it makes sense and looks useful for software development. On
> another, it looks like a violation of the main DT designing rule, when DT
> should be used to describe that hardware properties, which can not be learnt
> from other sources.
> 
> As far as I understand this specific chip, each of embedded PHYs has its own
> MDIO bus address and not an offset from a main common address. Correct me
> please, if I am got it wrong.
>

Correct, it's a quad PHY but each PHY have it's own address and they
can't be changed (they are incremental from the base one)

We have lots of device that have this (it's present in 99% of the the
ipq40xx and ipq807x SoC) and the common setup is putting the quad PHY
and connect only some port to it. (the address are occupiaed anyway just
the ethernet port is not connected)

Honestly I don't think it's a violation, IMHO quite the opposite. If DT
is there to describe the hardware, defining each PHY of the package as a
separate one is wrong and actually cause confusion by dropping entirely
any description that they are indeed in a package and that on the BUS
there may be address used without anything connected.

I'm more convinced with the ranges property as we can't put a size to
the reg property. (due to mdio node having address-cell to 0, changing
this will affect also every other phy node and that is problematic)

> > I hope Rob can give more feedback about this, is this what you were
> > thinking with the usage of ranges property?
> > 
> > (this has also the bonus point of introducing some validation in the PHY
> > core code to make sure the right amount of PHY are defined in the
> > package by checking if the number of PHY doesn't exceed the value set in
> > ranges.)
> 
> Yep, I am also would like to hear some clarification from Rob regarding
> acceptable 'range' property usage and may be some advice on how to specify
> the size of occupied addresses. Rob?
> 
> --
> Sergey

-- 
	Ansuel

