Return-Path: <linux-kernel+bounces-18951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38320826595
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F102B21285
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FC011184;
	Sun,  7 Jan 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPHYZJfY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0B10A35;
	Sun,  7 Jan 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so1259191f8f.1;
        Sun, 07 Jan 2024 10:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704652210; x=1705257010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CsMQHwEB3XjO8qN22Ypc9Zv6bys283cpFk0qTDgoWq4=;
        b=MPHYZJfY9k8SYK6JoWrXrZj2BvIaJhGRHPZkl2iHp7qfTDIQ+/E+EdppZwJhQS+6Dq
         N+Gs0L2hTQULDfqHuJaAHy2hULIPEIcorbDmICBIEWgRWVWcfKlAeM9y19x5ZBHrK2Qt
         CguwV2cwLVUHu+D/i+pU/QTOJ0vrZRHffiluooOpsZxSZRr0tHiFuzDddM8ACK+JRyT2
         blkWPjKKwQcbU+FA7KcHvIwdkdRdOWyyKsVydmockWOxJJcXMdV89uoY5foJUNa/rXze
         7gcKw5rmwxJlYMlpn4wc6G5S8oJFIhv4Rw+sVitRvw9UPVD1zf0UxYpOSPOsGZKycQB6
         UfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704652210; x=1705257010;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsMQHwEB3XjO8qN22Ypc9Zv6bys283cpFk0qTDgoWq4=;
        b=ohkVEt1Xx+/FPcoz3Q4vBshNT5gy8I3a6fAtBZm1O/x/iW+hvbtSK26qoAh4qdkObo
         bmYldBPtBwo+pVqmf5fExKXr3KdDABVFIIoY6fTvuETYRVF7EY5hkuoK9/ZtuKUPzRaT
         PJgUAfRiHxBkvTJGeJQTLHM8thFo6xaOUaAi7qQwDxy3PTGOwVkYu5Rog1xKOb2TZiTC
         tFI1uas7sO4arGiQbZgKMTWHKcXn3yOuQt6mpKSiobYqhZKKs2an19x/F7F4XY7N6TRe
         jyiCEcoz4NrlZ/AlFxtqgtUopCsQC37MRmdqYEY6fiTrM5xp42NIjTcOL3m35Q3YAdVl
         wCGw==
X-Gm-Message-State: AOJu0Yx1PoE3n9omWcNqG/6vI4j59wHwOjHtFTx0GRyvCv9vEcWZwUJE
	eNGkDmfl7el4OOGPXK7oHi4=
X-Google-Smtp-Source: AGHT+IHremZEvv9LCEmtm+PU6uzHWnQUFW1U8uWMvK4tn/Hp8UKQRwfSSupODZgYaunUn547sbLIVg==
X-Received: by 2002:adf:d00f:0:b0:336:ea07:af52 with SMTP id t15-20020adfd00f000000b00336ea07af52mr1458044wrh.20.1704652209789;
        Sun, 07 Jan 2024 10:30:09 -0800 (PST)
Received: from Ansuel-xps. (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.gmail.com with ESMTPSA id e18-20020adfe7d2000000b003367a5b6b69sm5877811wrn.106.2024.01.07.10.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 10:30:09 -0800 (PST)
Message-ID: <659aedb1.df0a0220.35691.1853@mx.google.com>
X-Google-Original-Message-ID: <ZZrtsH3gQBjP7xxW@Ansuel-xps.>
Date: Sun, 7 Jan 2024 19:30:08 +0100
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0926ea46-1ce4-4118-a04c-b6badc0b9e15@gmail.com>

On Sun, Jan 07, 2024 at 08:00:33PM +0200, Sergey Ryazanov wrote:
> Hi Christian and Robert,
> 
> thank you for this great work!
> 
> Let me ask a couple of questions regarding the phy package conception.
> Please find them below.
> 
> On 26.11.2023 03:53, Christian Marangi wrote:
> > Document ethernet PHY package nodes used to describe PHY shipped in
> > bundle of 4-5 PHY. The special node describe a container of PHY that
> > share common properties. This is a generic schema and PHY package
> > should create specialized version with the required additional shared
> > properties.
> > 
> > Example are PHY package that have some regs only in one PHY of the
> > package and will affect every other PHY in the package, for example
> > related to PHY interface mode calibration or global PHY mode selection.
> > 
> > The PHY package node MUST declare the base address used by the PHY driver
> > for global configuration by calculating the offsets of the global PHY
> > based on the base address of the PHY package and declare the
> > "ethrnet-phy-package" compatible.
> > 
> > Each reg of the PHY defined in the PHY package node is absolute and will
> > reference the real address of the PHY on the bus.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   .../bindings/net/ethernet-phy-package.yaml    | 75 +++++++++++++++++++
> >   1 file changed, 75 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > new file mode 100644
> > index 000000000000..244d4bc29164
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/ethernet-phy-package.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Ethernet PHY Package Common Properties
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description:
> > +  This schema describe PHY package as simple container for
> > +  a bundle of PHYs that share the same properties and
> > +  contains the PHYs of the package themself.
> > +
> > +  Each reg of the PHYs defined in the PHY package node is
> > +  absolute and describe the real address of the PHY on the bus.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^ethernet-phy-package(@[a-f0-9]+)?$"
> > +
> > +  compatible:
> > +    const: ethernet-phy-package
> > +
> > +  reg:
> > +    minimum: 0
> > +    maximum: 31
> > +    description:
> > +      The base ID number for the PHY package.
> > +      Commonly the ID of the first PHY in the PHY package.
> > +
> > +      Some PHY in the PHY package might be not defined but
> > +      still exist on the device (just not attached to anything).
> > +      The reg defined in the PHY package node might differ and
> > +      the related PHY might be not defined.
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +patternProperties:
> > +  ^ethernet-phy(@[a-f0-9]+)?$:
> > +    $ref: ethernet-phy.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    mdio {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        ethernet-phy-package@16 {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +            compatible = "ethernet-phy-package";
> > +            reg = <0x16>;
> > +
> > +            ethernet-phy@16 {
> > +              reg = <0x16>;
> > +            };
> > +
> > +            phy4: ethernet-phy@1a {
> > +              reg = <0x1a>;
> > +            };
> > +        };
> > +    };
> 
> So, we ended up on a design where we use the predefined compatible string
> 'ethernet-phy-package' to recognize a phy package inside the
> of_mdiobus_register() function. During the V1 discussion, Vladimir came up
> with the idea of 'ranges' property usage [1]. Can we use 'ranges' to
> recognize a phy package in of_mdiobus_register()? IMHO this will give us a
> clear DT solution. I mean 'ranges' clearly indicates that child nodes are in
> the same address range as the parent node. Also we can list all child
> addresses in 'reg' to mark them occupied.
> 
>   mdio {
>     ...
> 
>     ethernet-phy-package@16 {
>       compatible = "qcom,qca8075";
>       reg = <0x16>, <0x17>, <0x18>, <0x19>, <0x1a>;
>       ranges;
>       ...
> 
>       ethernet-phy@16 {
>         reg = <0x16>;
>       };
> 
>       ethernet-phy@1a {
>         reg = <0x1a>;
>       };
>     };
>   };
> 
> Did you find some issues with the 'ranges' conception?
>

Nope it's ok but it might pose some confusion with the idea that the
very first element MUST be THE STARTING ADDR of the PHY package. (people
might think that it's just the list of the PHYs in the package and
remove the hardware unconnected ones... but that would be fault of who
write the DT anyway.)

> 
> And I would like to ask you about another issue raised by Vladimir [1].
> These phy chips become SoC with all these built-in PHYs, PCSs, clocks,
> interrupt controllers, etc. Should we address this now? Or should we go with
> the proposed solution for now and postpone modeling of other peripherals
> until we get a real hardware, as Andrew suggested?
> 

Honestly I would postpone untile we have a clear idea of what is
actually part of the PHY and what can be handled externally... Example
setting the clock in gcc, writing a specific driver...

It's a random idea but maybe most of the stuff required for that PHY is
just when it's connected to a switch... In that case it would all be
handled in the switch driver (tobe extended qca8k) and all these extra
stuff would be placed in that node instead of bloating phy nodes with
all kind of clk and other stuff.

This series still require 2 more series (at803x splint and cleanup) to be
actually proposed so we have some time to better define this.

What do you think?

> I'm asking because it looks like we have got a real hardware. Luo currently
> trying to push QCA8084 (multi-phy/switch chip) support, and this chip
> exactly contains a huge clock/reset controller [2,3].
> 
> 
> 1. https://lore.kernel.org/lkml/20231124165923.p2iozsrnwlogjzua@skbuf // Re:
> [net-next RFC PATCH 03/14] dt-bindings: net: document ethernet PHY package
> nodes
> 2. https://lore.kernel.org/lkml/20231215074005.26976-1-quic_luoj@quicinc.com
> // [PATCH v8 00/14] add qca8084 ethernet phy driver
> 3. https://lore.kernel.org/lkml/20231104034858.9159-1-quic_luoj@quicinc.com
> // [PATCH v12 0/4] add clock controller of qca8386/qca8084
> 
> --
> Sergey

-- 
	Ansuel

