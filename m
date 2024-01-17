Return-Path: <linux-kernel+bounces-28395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD27E82FE09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6351F25F74
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E63747C;
	Wed, 17 Jan 2024 00:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHG1b+kE"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A0B5247;
	Wed, 17 Jan 2024 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705451796; cv=none; b=d0kEt5UdR5In2PLcCUiva5IxtqmOV4cBpMKCGt+g7J7lhWguAipjd4oQ0EItp8Z89mDtne546MBt8uiB81B+oXIIYuLROh9FXOOtlr8EeA53eC1UvxEW1xAGsswovGkQX8f5NyeuzYHYKEyVrhbzLeXwNXTUzuqv+OzMAORl1a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705451796; c=relaxed/simple;
	bh=o4POb72ml8BP2sSwXjmCv/XaBq2X0kq0mmVRl+iVTKA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:X-Google-Original-Message-ID:Date:From:To:Cc:Subject:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=oy8iVERhJWjFOigbU2aGJ2ns1xS6NNkKhKIGHpaHvq3lDKjgI8Fmo+56xPuWaiJ0P3Z9McLHbaFcj/fexqN9qmX3qX9AjUwklYNYXXiau/nWRIUshkWGaGPqpC5k4v1fWX4ObpA0uL+U8pJ66KzYfFDrMHYHMEzHJ5oPPAAYsYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHG1b+kE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3377d45c178so5182556f8f.2;
        Tue, 16 Jan 2024 16:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705451792; x=1706056592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KIn0gCmXZ0lxMlQGGnzRf82yHu6dGB0sxsIjteoQakg=;
        b=mHG1b+kERZS1G6izZBVwpXyzjfZCXakP23Tr/p1KG2A/qXMBMLdvtK+9iaHEkZdZoC
         VslN0HMbVNk+XDAjWn/6AfkSkh1Z61vGzACl7t/ruU3tnRVxMjejygKB8n6I8tFROjTC
         423dNjhxQQLq9Vg4AmgtfALGfo0WEztoHVgo/sPt2iM3oGLrayELDD2xjzYnBDYiofYF
         sEdSDKWZFHCEcmSE7oPy7xG4gXSlSwBlHUs53bHOM2JVti3UVZdFRspC20bU0/zjJTve
         VftqPjrcg/3DSWM0fKW2ndzGr0+3AAfFKj5O9NJHc2I7Ed5M70qia1Cl07Ig6If9JsfG
         yUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705451792; x=1706056592;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIn0gCmXZ0lxMlQGGnzRf82yHu6dGB0sxsIjteoQakg=;
        b=ckXtPb/PUXJRFcaRccTkVMKKRGmzDxX80HLd2o9ACp1xJSqQ/NZLYurbDa6v7InzBp
         hYF71VWS+7F8saEgyYA+8pr24kgbQMaxLGLAB1KI4HW+jeVnasRZgfZMhbi5fwmCmvi0
         BEi1bc5omSfCj6f24EMQGfusbdSAPKLf3EntX6/FxRJbYAwHucF1egZE+F5/AmxVsDiP
         buo+BRYyPJ+ANUHxh5kTZdBID4o4vODP7pzo0I6BfANcSBSW/ODJXQChFaTATP1WNsl0
         q2eRYT9kmMQpcC7kLTjkxGgfRTDMoUGc0u6byONOvVx22A43mh+X6FYmcDjiF+RC4CmA
         tTGg==
X-Gm-Message-State: AOJu0YxywgNqHxGcr9KpR/OZtWOYvgoEpFkTVtKRduE9auVMAQLQHsAp
	vliGZrMKOtaMGJvmLhUhai4=
X-Google-Smtp-Source: AGHT+IGZXiVBSI9rEk4Tdqko5QtIpx9MEPXVIIgt/eTZP2+LCMfjt7M0UWwZE6xsruV8+nQfO4NwGw==
X-Received: by 2002:adf:fa0e:0:b0:337:5b60:dca9 with SMTP id m14-20020adffa0e000000b003375b60dca9mr4353405wrr.94.1705451792219;
        Tue, 16 Jan 2024 16:36:32 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id l14-20020adffe8e000000b00336755f15b0sm310897wrr.68.2024.01.16.16.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 16:36:31 -0800 (PST)
Message-ID: <65a7210f.df0a0220.d10b2.1162@mx.google.com>
X-Google-Original-Message-ID: <ZachDLzFEWQV8lhl@Ansuel-xps.>
Date: Wed, 17 Jan 2024 01:36:28 +0100
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f4ec2ff-4ef7-4667-adef-d065cfbc0a91@gmail.com>

On Sun, Jan 07, 2024 at 11:49:12PM +0200, Sergey Ryazanov wrote:
> Hi Christian,
> 
> On 07.01.2024 20:30, Christian Marangi wrote:
> > On Sun, Jan 07, 2024 at 08:00:33PM +0200, Sergey Ryazanov wrote:
> > > On 26.11.2023 03:53, Christian Marangi wrote:
> > > > Document ethernet PHY package nodes used to describe PHY shipped in
> > > > bundle of 4-5 PHY. The special node describe a container of PHY that
> > > > share common properties. This is a generic schema and PHY package
> > > > should create specialized version with the required additional shared
> > > > properties.
> > > > 
> > > > Example are PHY package that have some regs only in one PHY of the
> > > > package and will affect every other PHY in the package, for example
> > > > related to PHY interface mode calibration or global PHY mode selection.
> > > > 
> > > > The PHY package node MUST declare the base address used by the PHY driver
> > > > for global configuration by calculating the offsets of the global PHY
> > > > based on the base address of the PHY package and declare the
> > > > "ethrnet-phy-package" compatible.
> > > > 
> > > > Each reg of the PHY defined in the PHY package node is absolute and will
> > > > reference the real address of the PHY on the bus.
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >    .../bindings/net/ethernet-phy-package.yaml    | 75 +++++++++++++++++++
> > > >    1 file changed, 75 insertions(+)
> > > >    create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > > > new file mode 100644
> > > > index 000000000000..244d4bc29164
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > > > @@ -0,0 +1,75 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/net/ethernet-phy-package.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Ethernet PHY Package Common Properties
> > > > +
> > > > +maintainers:
> > > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > > +
> > > > +description:
> > > > +  This schema describe PHY package as simple container for
> > > > +  a bundle of PHYs that share the same properties and
> > > > +  contains the PHYs of the package themself.
> > > > +
> > > > +  Each reg of the PHYs defined in the PHY package node is
> > > > +  absolute and describe the real address of the PHY on the bus.
> > > > +
> > > > +properties:
> > > > +  $nodename:
> > > > +    pattern: "^ethernet-phy-package(@[a-f0-9]+)?$"
> > > > +
> > > > +  compatible:
> > > > +    const: ethernet-phy-package
> > > > +
> > > > +  reg:
> > > > +    minimum: 0
> > > > +    maximum: 31
> > > > +    description:
> > > > +      The base ID number for the PHY package.
> > > > +      Commonly the ID of the first PHY in the PHY package.
> > > > +
> > > > +      Some PHY in the PHY package might be not defined but
> > > > +      still exist on the device (just not attached to anything).
> > > > +      The reg defined in the PHY package node might differ and
> > > > +      the related PHY might be not defined.
> > > > +
> > > > +  '#address-cells':
> > > > +    const: 1
> > > > +
> > > > +  '#size-cells':
> > > > +    const: 0
> > > > +
> > > > +patternProperties:
> > > > +  ^ethernet-phy(@[a-f0-9]+)?$:
> > > > +    $ref: ethernet-phy.yaml#
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +
> > > > +additionalProperties: true
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    mdio {
> > > > +        #address-cells = <1>;
> > > > +        #size-cells = <0>;
> > > > +
> > > > +        ethernet-phy-package@16 {
> > > > +            #address-cells = <1>;
> > > > +            #size-cells = <0>;
> > > > +            compatible = "ethernet-phy-package";
> > > > +            reg = <0x16>;
> > > > +
> > > > +            ethernet-phy@16 {
> > > > +              reg = <0x16>;
> > > > +            };
> > > > +
> > > > +            phy4: ethernet-phy@1a {
> > > > +              reg = <0x1a>;
> > > > +            };
> > > > +        };
> > > > +    };
> > > 
> > > So, we ended up on a design where we use the predefined compatible string
> > > 'ethernet-phy-package' to recognize a phy package inside the
> > > of_mdiobus_register() function. During the V1 discussion, Vladimir came up
> > > with the idea of 'ranges' property usage [1]. Can we use 'ranges' to
> > > recognize a phy package in of_mdiobus_register()? IMHO this will give us a
> > > clear DT solution. I mean 'ranges' clearly indicates that child nodes are in
> > > the same address range as the parent node. Also we can list all child
> > > addresses in 'reg' to mark them occupied.
> > > 
> > >    mdio {
> > >      ...
> > > 
> > >      ethernet-phy-package@16 {
> > >        compatible = "qcom,qca8075";
> > >        reg = <0x16>, <0x17>, <0x18>, <0x19>, <0x1a>;
> > >        ranges;
> > >        ...
> > > 
> > >        ethernet-phy@16 {
> > >          reg = <0x16>;
> > >        };
> > > 
> > >        ethernet-phy@1a {
> > >          reg = <0x1a>;
> > >        };
> > >      };
> > >    };
> > > 
> > > Did you find some issues with the 'ranges' conception?
> > 
> > Nope it's ok but it might pose some confusion with the idea that the
> > very first element MUST be THE STARTING ADDR of the PHY package. (people
> > might think that it's just the list of the PHYs in the package and
> > remove the hardware unconnected ones... but that would be fault of who
> > write the DT anyway.)
> 
> Make sense. I do not insist on addresses listing. Mainly I'm thinking of a
> proper way to show that child nodes are accessible directly on the parent
> bus, and introducing the special compatibility string, while we already have
> the 'ranges' property.
> 
> But it's good to know Rob's opinion on whether it is conceptually right to
> use 'ranges' here.
>

I wonder if something like this might make sense... Thing is that with
the ranges property we would have the define the address in the PHY
Package node as offsets...

An example would be

    mdio {
        #address-cells = <1>;
        #size-cells = <0>;

        ethernet-phy-package@10 {
            #address-cells = <1>;
            #size-cells = <0>;
            compatible = "qcom,qca807x-package";
            reg = <0x10>; 
            ranges = <0x0 0x10 0x5>;

            qcom,package-mode = "qsgmii";

            ethernet-phy@0 {
                reg = <0>;

                leds {

		...

With a PHY Package at 0x10, that span 5 address and the child starts at
0x0 offset.

This way we would be very precise on describing the amount of address
used by the PHY Package without having to define the PHY not actually
connected.

PHY needs to be at an offset to make sense of the ranges first element
property (0x0). With a non offset way we would have to have something
like

ranges = <0x10 0x10 0x5>;

With the child and tha parent always matching.

(this is easy to handle in the parsing and probe as we will just
calculate the real address based on the base address of the PHY package
+ offset)

I hope Rob can give more feedback about this, is this what you were
thinking with the usage of ranges property?

(this has also the bonus point of introducing some validation in the PHY
core code to make sure the right amount of PHY are defined in the
package by checking if the number of PHY doesn't exceed the value set in
ranges.)

> > > And I would like to ask you about another issue raised by Vladimir [1].
> > > These phy chips become SoC with all these built-in PHYs, PCSs, clocks,
> > > interrupt controllers, etc. Should we address this now? Or should we go with
> > > the proposed solution for now and postpone modeling of other peripherals
> > > until we get a real hardware, as Andrew suggested?
> > 
> > Honestly I would postpone untile we have a clear idea of what is
> > actually part of the PHY and what can be handled externally... Example
> > setting the clock in gcc, writing a specific driver...
> > 
> > It's a random idea but maybe most of the stuff required for that PHY is
> > just when it's connected to a switch... In that case it would all be
> > handled in the switch driver (tobe extended qca8k) and all these extra
> > stuff would be placed in that node instead of bloating phy nodes with
> > all kind of clk and other stuff.
> > 
> > This series still require 2 more series (at803x splint and cleanup) to be
> > actually proposed so we have some time to better define this.
> > 
> > What do you think?
> 
> Fair enough! Let's postpone until we really need it. I noticed this
> PHY-like-SoC discussion in the V1 comments, and it was not finished there
> neither addressed in the latest patch comment. So I asked just to be sure
> that we were finished with this. Thank you for the clarification.
> 
> --
> Sergey
> 

-- 
	Ansuel

