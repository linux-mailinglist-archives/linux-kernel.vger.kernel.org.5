Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902E67F7A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjKXRYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjKXRYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:24:50 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14CE1733;
        Fri, 24 Nov 2023 09:24:55 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c5b7764016so24449651fa.1;
        Fri, 24 Nov 2023 09:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700846694; x=1701451494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=86tKz1Q4LYdvZSL821UYqvZ1E+Vs2suOjdSlFDKg1/8=;
        b=YGURQQx5Ck9nKf2Loip//EUw+TE1pEq6eT7Hdv6mm9CawXCBMoLWU6Djajo1lDX5ya
         42gUmhtgwub3uzNbjoUhm5B4NvvZoOUszIiy84ImgmdOHrphYBL21vRznc4ltrf2NPuk
         TeLYV3SdE6L/lgzNqUAsT4EFnCQKkXaztv/ZmmoImxG6Bys3ymD3AllVtypwu+9GwU2w
         og0WeoDnTvT/IasDV7SxOjNUSJnkcyEaSrRaBze5zB0+0KitY/ZvtvTGib7qHRrbEf8i
         byr5ojhlhThXura+dsX0oVRUpVLD/Fc1S3ocDm2sjpMxK+6pNJNEvJAbxJdVAj+bx4JP
         tlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700846694; x=1701451494;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86tKz1Q4LYdvZSL821UYqvZ1E+Vs2suOjdSlFDKg1/8=;
        b=oF9bDfafRDKIAjITzP5oPCUVtG8RZSKtLdgo0f9sj03r2/kt7eaKBhALXdzablxMB4
         xWFhR1+tiu1fziwg+p18PNuaJOnvgQMNYVtWP/LoBIqpUzXrgZn4xbJDBTyH/nLFnKRS
         rX8DkH4BqafjAoZvvXnPisS/C4LPnNbXrsq0sFzSQaZGIPzmtbpWs/+EhpgDYjxc6kNQ
         HDN6IT/t1+Bl62CEV2XlwlLOCVIxZ5yGsFGN9sggB8nFy+wC9ljikMwZXoNXXRlklRoV
         12P1CK87P1kPVnnDGZvpK7Machrlf8WkqdZCGMRl5P2WVy0mD+5bBUohm/HfDw1POy8T
         O1Hg==
X-Gm-Message-State: AOJu0Yx0YBru3Azm3k5TKGaJ2/xt0DPQVTNgyjjvWIIjtxGPk4bnEbpJ
        sVolskVVRR/x5huIye0T0Fg=
X-Google-Smtp-Source: AGHT+IEopNg1bkDdaMgE8n5KVyqBjO4Si81wIjY+cipwPm3gPod9pAi90+vjNlfX53s+A7JfV68zWg==
X-Received: by 2002:a05:651c:1045:b0:2c8:8b61:ea13 with SMTP id x5-20020a05651c104500b002c88b61ea13mr3169138ljm.18.1700846693798;
        Fri, 24 Nov 2023 09:24:53 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id q19-20020a05600c46d300b004064e3b94afsm6382196wmo.4.2023.11.24.09.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 09:24:53 -0800 (PST)
Message-ID: <6560dc65.050a0220.182b5.650c@mx.google.com>
X-Google-Original-Message-ID: <ZWDObJsELmCs9G8o@Ansuel-xps.>
Date:   Fri, 24 Nov 2023 17:25:16 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH 03/14] dt-bindings: net: document ethernet
 PHY package nodes
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
 <20231120135041.15259-4-ansuelsmth@gmail.com>
 <c21ff90d-6e05-4afc-b39c-2c71d8976826@lunn.ch>
 <20231121144244.GA1682395-robh@kernel.org>
 <a85d6d0a-1fc9-4c8e-9f91-5054ca902cd1@lunn.ch>
 <655e4939.5d0a0220.d9a9e.0491@mx.google.com>
 <20231124165923.p2iozsrnwlogjzua@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124165923.p2iozsrnwlogjzua@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 06:59:23PM +0200, Vladimir Oltean wrote:
> On Wed, Nov 22, 2023 at 07:32:22PM +0100, Christian Marangi wrote:
> > Sooooo.... Sorry if I insist but I would really love to have something
> > ""stable"" to move this further. (the changes are easy enough so it's
> > really a matter of finding a good DT structure)
> > 
> > Maybe a good idea would be summarize the concern and see what solution
> > was proposed:
> 
> Sorry, I didn't follow the entire discussion. I hope I'm not too far off
> with my understanding of your problems.
> 
> I think you are hitting some of the same points I have hit with DSA.
> The PHY package could be considered an SoC with lots of peripherals on
> it, for which you'd want separate drivers. Just like a DSA switch would.
> I don't think it's exactly phylib's place to deal with that, just like
> it's not DSA's place to deal with complex SoCs, just with the switching
> IP (like the Ethernet PHY IP for phylib).
> https://lore.kernel.org/lkml/20221222134844.lbzyx5hz7z5n763n@skbuf/
> 
> Why does the ethernet-phy-package DT binding attempt to be so grand and
> generic? I would expect the 180 degree opposite. Make it have a _single_
> compatible of "qcom,qca807x" (but don't use an "x" wildcard, do specify
> the full package name).
> 
> Make it have a "reg" property which is the base MDIO address of the package.
> 
> Write an mdio_device driver that probes on that. The PHY core already
> knows that if a child on the MDIO bus has a compatible string of the
> normal form (not like "ethernet-phy-id004d.d0b2"), then it's looking at
> an mdio_device.
> 
> Make the OF node of the package have an "mdio" child with its own
> compatible string, which represents the place where PHYs are. The driver
> for the "mdio" child has a very simple implementation of the mii_bus
> ops, which just calls into the device parent (it can assume a certain
> parent implementation and private data structures).
> 
> Lateral to the "mdio" child node of the "qcom,qca807x" package node, you
> could put any other device tree properties that you want.
> 
> Make the mdio_device driver for "qcom,qca807x" use shared code if you
> want - but keep the device tree structure hardware-specific. Look at the
> compatible strings that e.g. the drivers/mfd/simple-mfd-i2c.c driver
> probes on. You could always change the driver implementation for a
> certain compatible string, but you'll be stuck with the ultra-generic
> compatible = "ethernet-phy-package", which has the problems that you
> mention.
>

The main reason is the fact that PHY package are already a thing and API
are already there (phy_package_join/leave...) so we just lack any way to
support this in DT without using specialized code in the PHY driver.

This is really completing the feature.

The only reason for the generic "ethernet-phy-package" compatible is to
have a solid detection of the node in PHY core. (I assume parsing the
node name might be problematic? Or maybe not now that we require adding
a reg to it)

Also I don't expect tons of special properties for PHY package, with the
current probe/config implementation, a PHY driver have lots of
flexibility in all kind of validation.

Consider that the additional global-phys and global-phy-names are
already expected to be dropped.
(we know the PHY package base address and we can calculate the offset of
the global phy from there in the PHY package probe)

And even the phy-mode has been scrapped for more specific solution...
(some assumption can be done on probe by checking the PHY mode and set
stuff accordingly or even do parsing in the PHY package node as we pass
the OF node of the phy package)

The PHY package node would be reduced to a simple compatible (and even
this can be dropped) and a reg.

I feel there is a big chance here to generalize it and prevent any kind
of mess with all kind of similar/equal code that just do the same thing.
(and we already have an example with the PHY package API usage with
every PHY having the same exact pattern for probe/config and nothing
describing that the PHY are actually a package in DT)

Hope it all makes sense to you.

> > 
> > Concern list:
> > 1. ethernet-phy-package MUST be placed in mdio node (not in ethernet,
> >    the example was wrong anyway) and MUST have an addr
> > 
> >    Current example doesn't have an addr. I would prefer this way but
> >    no problem in changing this.
> > 
> >    Solution:
> >      - Add reg to the ethernet-phy-package node with the base address of
> >        the PHY package (base address = the first PHY address of the
> >        package)
> 
> Correct, what I'm saying is compatible with this.
> 
> > 
> >        We will have a PHY node with the same address of the PHY package
> >        node. Each PHY node in the PHY package node will have reg set to
> >        the REAL address in the mdio bus.
> 
> If the real PHY IPs are children of the package rather than on the same
> level with it, I don't think this will be a problem. I wonder if some
> address translation could be done with the "ranges" device tree property.
> I've never seen this with MDIO though.
> 

I can check it, I would love some way to describe the address used by
the PHY package. (since everything will be handled internally with
offsets, would be good to define in DT that (for example) addrs from 0
to 5 are used). Some PHY might be not attached but still used for global
configuration of the PHY package.

> > 4. Not finding a correct place to put PHY package info.
> > 
> >    I'm still convinced the mdio node is the correct place.
> >    - PHY package are PHY in bundle so they are actual PHY
> >    - We already have in the mdio node special handling (every DSA switch
> >      use custom compatible and PHY ID is not used to probe them
> >      normally)
> >    - Node this way won't be treated as PHY as they won't match the PHY
> >      node name pattern and also won't have the compatible pattern for
> >      PHY.
> > 
> >    Solution:
> >     - ethernet-phy-package node is OK given a reg is defined.
> 
> I agree that it should sit under the MDIO node. I disagree with the idea
> of a standardized binding for PHY packages.

-- 
	Ansuel
