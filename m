Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDB87F5C91
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbjKWKik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjKWKia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:38:30 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4AD10D1;
        Thu, 23 Nov 2023 02:38:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32df66c691dso484521f8f.3;
        Thu, 23 Nov 2023 02:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700735914; x=1701340714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3tUVyHGP1WjRDJGX9CdkL5LLVHa/NoNDy1qrQLyl8FI=;
        b=eUOnitVmU/QEBju5hafZvyPCW2tuBUJej7AXWP6wb24PEhudQHWw5Yi5MjwMIlC9tC
         tJ7ZGcomqwsC9AExZal6ff7XxcVkQ6NDOjIyVMy5x0TBTd3XH+YGWgqo4P1hyQMRps8W
         ctbo/Vi4jB8oqIolZJ3Qxgoi7LhibJiHZTymCWW/lgLViZQHQNdlGlALtvas4Y8MXT/q
         UQhpZKuM9w84xBzv4rd8aih3OAtpmCrABwQ4bCeUvLKFc+V453EPhpxxs4nrGwDpNi5z
         W5DIuOqisZvCljAyVuP2abs3NL3kGWfjzysgfE8Qe/6ra072qxWHTNkwRgicn9VWLHRE
         0pkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700735914; x=1701340714;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tUVyHGP1WjRDJGX9CdkL5LLVHa/NoNDy1qrQLyl8FI=;
        b=js805RiDoYAgcJ/cBb/rM1ZDEWBtzkqlIn/t98kLbtjvMVxm1E25nja/WOuGsovb9k
         QVgALAlEeknVpsJ6jrpGRkED9W1y22wmBR+iztkv90q4469NMfRLS1t0fiMYVgQc60m+
         ienDWOvliU5QTKBpJWa/q87cVdMNw1kdgHRhR/VmLtro80viXbVjgWZv4rJKHqUgCKpc
         Sd2LvDVNhUwBiD6uiOEsz1xr/fpOm4REhenR6cPLrP0/VbpS7vdFMHKhAvjYocCABJPw
         OyYpTZ/B2pzzDb73xYXrWQaPJSXkydqQY8u6USrof3REoH5r3I4YMcGpeoMZja4RXHvI
         nHow==
X-Gm-Message-State: AOJu0Yzjh4Z0LsPL7IlqVE2VJJDgPqvTX9BG+7UYHblC0H3EYw/2QXWE
        Mgdd0x7KPO5ftBMA1kDhNSo=
X-Google-Smtp-Source: AGHT+IGUjvYu+WeYQkp7U08ioiooONMJDQgJFQxfglLmlgoXQt1BuDElx7HSiWi0TffENVRQPMMpjQ==
X-Received: by 2002:adf:e992:0:b0:332:dfeb:76ab with SMTP id h18-20020adfe992000000b00332dfeb76abmr1048229wrm.60.1700735914167;
        Thu, 23 Nov 2023 02:38:34 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id w3-20020a5d5443000000b003140f47224csm1287597wrv.15.2023.11.23.02.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:38:33 -0800 (PST)
Message-ID: <655f2ba9.5d0a0220.294f3.38d8@mx.google.com>
X-Google-Original-Message-ID: <ZV8qxCbjilsVIoDS@Ansuel-xps.>
Date:   Thu, 23 Nov 2023 11:38:31 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh@kernel.org>,
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
        Vladimir Oltean <olteanv@gmail.com>,
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
 <6a030399-b8ed-4e2c-899f-d82eb437aafa@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a030399-b8ed-4e2c-899f-d82eb437aafa@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 04:30:48AM +0100, Andrew Lunn wrote:
> On Wed, Nov 22, 2023 at 07:32:22PM +0100, Christian Marangi wrote:
> > On Tue, Nov 21, 2023 at 03:45:42PM +0100, Andrew Lunn wrote:
> > > > > I do think we need somewhere to put package properties. But i don't
> > > > > think phy-mode is such a property. At the moment, i don't have a good
> > > > > example of a package property.
> > > > 
> > > > What about power supplies and reset/enable lines?
> > > 
> > > Yes, good point. I can imagine some packages sharing regulators. Reset
> > > might also be shared, but it makes things messy to handle.
> > >
> > 
> > Sooooo.... Sorry if I insist but I would really love to have something
> > ""stable"" to move this further. (the changes are easy enough so it's
> > really a matter of finding a good DT structure)
> > 
> > Maybe a good idea would be summarize the concern and see what solution
> > was proposed:
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
> Yes.
>

Thanks.

> >        We will have a PHY node with the same address of the PHY package
> >        node. Each PHY node in the PHY package node will have reg set to
> >        the REAL address in the mdio bus.
> 
> Basically Yes. I actually think the first sentence is not 100%
> correct. It could be all the package configuration registers are in
> the base address, without an actual PHY. The PHYs then follow at
> addresses above it. I can also imagine a case where the first PHY in
> the package is not used, so its not listed at all. So i think it
> should be "We often have a PHY node with the same address of the PHY
> package node."
> 

Just to add details, also the opposite can happen. Where the last PHY in
the bundle is used for global configuration but is not defined. This is
another reason I wanted the global-phy proprerty, having to reference
them even if they are not used better describe the actual PHY address
used in the mdio bus. If the PHY is handled internally and omitted in DT
then people might think that address is not used.

> > 3. phy-mode is problematic.
> > 
> >    It's an optional value to enforce a specific mode for each PHY in the
> >    package. For complex configuration the mode won't be defined.
> > 
> >    Solution:
> >     - Rename it to package-phy-mode to make it less confusing.
> > 
> >     - Add an additional function that PHY package can use to make custom
> >       validation on the mode for every PHY attached (in the PHY package).
> > 
> >       Would make it less clear but more flexible for complex
> >       configuration. Maybe both solution can be implemented and the
> >       special function is used if the mode is not defined?
> 
> The description you give is that there are two SERDES, and both could
> be connected to a MAC. What does package-phy-mode represent then? 
> 
> Luo Jie patch for the qca8084 seems to have the same issue. It has two
> SERDES/PMA, and both could be connected to the MACs. So it seems like
> QCA devices don't actually fit this model. If we want to describe the
> package link mode, we probably need to list each PMA, and have a
> property in the PMA node indicating what link mode the PMA is
> operating at.
> 
> At least for the moment, its not clear we actually need this at
> all. It seems like the phy-mode is all we need. The PHY driver should
> know what values are valid per port, and so can validate the value.
> 

Just to be more precise qca807x can operate in 3 different mode:
(this is controlled by the MODE_CFG bits)
- QSGMII: 5 copper port
- PSGMII: 5 copper port
- PSGMII: 4 copper port + 1 combo (that can be both fiber or copper)

When mode is set to QSGMII each PHY needs to have the matching mode or
we have no traffic. It makes it difficult driver side to understand what
mode should be enforced with all kind of parsing or magic in private
struct.

Maybe for this specific case would be ok to introduce a simple specific
proprerty? Like qca,qsgmii_mode ?

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
> 
> We do need a compatible for the package. The kernel is unlikely to use
> it, but the validation tools will. Each package can have its own DT
> properties, so we need a .yaml to describe those properties. So i
> would expect to have a "qca807x-package" compatible, which then lists
> the tx driver strength etc. The PHYs within the package don't need
> compatible, they are just linux PHYs, probed using the same code as
> PHYs outside of a package.
>

Since the idea is add OF support for the PHY we also need a generic
compatible for it.

Is it ok to have something like

compatible = "ethernet-phy-package", "qca807x-phy-package";

With "ethernet-phy-package" a must and "qca807x-phy-package" used only
if additional property are used.

My current idea was to use select and base everything on the possible
PHY compatible (and it does work, tested by adding bloat in the DT
example and seeing if the schema was rejected). Had this idea since the
compatible would never be used.

-- 
	Ansuel
