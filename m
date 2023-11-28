Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973D77FB9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344622AbjK1MJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344381AbjK1MJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:09:22 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3E7182;
        Tue, 28 Nov 2023 04:09:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b397793aaso24700815e9.0;
        Tue, 28 Nov 2023 04:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701173367; x=1701778167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oGZ/AOFCUofp/Ip1CkJeKXSMao5eFIWJrE7N8FH5Dk4=;
        b=h3usQyvEcDxiGMbYnhFh+sY19pffIWnIa6aEI/xTNJnxg/Egci3WGZbeSz9AOc2G2Q
         HlTHrsYtapKcN6ZyPIu95Ry/1U81k2qNcwQ7fJxaptB2AS1wmthWrB3Kpib9pLdEvV3S
         vSMyFh6wF6xbh/4XVPt0lvnW4b1WH6P2sxuZfpMeP8IIe2jWcX7Vy7+2IG1ZdVK9YKkk
         64IcsrkDcizWVuwSj0/wX/5wkd/RENMSTQSDmKuQ4e1EauJgcCXUbfe/QLXAaJpVfzE+
         qSXs+Ef73UgJlKkFgwS5f4CRZsfrxQtopywGWYH/7AnAOGZ+2/7HKamZ6QdyqlBPPT3l
         EWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701173367; x=1701778167;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGZ/AOFCUofp/Ip1CkJeKXSMao5eFIWJrE7N8FH5Dk4=;
        b=iEyUdBfNC/5u+mejT0SLZ5qbCk88mAHXJ6Q5rSAj29Ar6bzyJsV3D6+sdjIJUkglRc
         T46Z9ybhG0flYJy/941dj7Ys5Tuo4RR438Cn/3o4QIEjmhrnTFQdj65ammu1Zm0ru5od
         sAdatcfVqV92QFL0kXaZoTL+G7ItrkCkm4ntohaSTVdf/PKjzG5Z90RCxyOGvJSw43Kl
         /Tlv2wBL/9HUdZlgOGqeNO/Ff1WEvGxDg83NDFVDRk2GC5GA2fIEtfWJ1Gup50eH3/JE
         1B7nFJ4Gykb13r22UQ/lWrENOLtce7i4KGLYDDSq3l5jqxxWRvA4TuQ3rUvvYClpZ4DB
         QD1g==
X-Gm-Message-State: AOJu0YzqPwsO7f5l2/lm9EddLmhydonjEaLF+jXxKPq4N5X1XpScBk3x
        IkvGwGHuyoQOBqeF2N1e61I=
X-Google-Smtp-Source: AGHT+IGbBBv6SLNWzhb+OGjrpkkr9ufbL/wiM7k+E/3ue7yfq8P984X8hsnAh2R7HaBI8aT4sqQLDQ==
X-Received: by 2002:a05:600c:5124:b0:40b:2ad8:579f with SMTP id o36-20020a05600c512400b0040b2ad8579fmr15342645wms.3.1701173366197;
        Tue, 28 Nov 2023 04:09:26 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c501300b0040b4c26d2dasm2231768wmr.32.2023.11.28.04.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 04:09:25 -0800 (PST)
Message-ID: <6565d875.050a0220.d709d.658b@mx.google.com>
X-Google-Original-Message-ID: <ZWXYcwbGdFX0vGMD@Ansuel-xps.>
Date:   Tue, 28 Nov 2023 13:09:23 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH RFC v3 2/8] net: phy: add initial support for
 PHY package in DT
References: <20231126015346.25208-1-ansuelsmth@gmail.com>
 <20231126015346.25208-3-ansuelsmth@gmail.com>
 <b28b5d10-08cd-4e30-9909-f37834d80c81@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b28b5d10-08cd-4e30-9909-f37834d80c81@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 01:39:02AM +0100, Andrew Lunn wrote:
> > +static int of_phy_package(struct phy_device *phydev)
> > +{
> > +	struct device_node *node = phydev->mdio.dev.of_node;
> > +	struct device_node *package_node;
> > +	u32 base_addr;
> > +	int ret;
> > +
> > +	if (!node)
> > +		return 0;
> > +
> > +	package_node = of_get_parent(node);
> > +	if (!package_node)
> > +		return 0;
> > +
> > +	if (!of_device_is_compatible(package_node, "ethernet-phy-package"))
> > +		return 0;
> > +
> > +	if (of_property_read_u32(package_node, "reg", &base_addr))
> > +		return -EINVAL;
> > +
> > +	ret = devm_phy_package_join(&phydev->mdio.dev, phydev,
> > +				    base_addr, 0);
> 
> No don't do this. It is just going to lead to errors. The PHY driver
> knows how many PHYs are in the package. So it can figure out what the
> base address is and create the package. It can add each PHY as they
> probe. That cannot go wrong.
>

No it can't and we experiment this with a funny implementation on the
QSDK. Maybe I'm confused?

Example on QSDK they were all based on a value first_phy_addr. This was
filled with the first phy addr found (for the package).

All OEM followed a template with declaring all sort of bloat and they
probably have no idea what they are actually putting in DT. We reverse
all the properties and we gave a meaning to all the values...

We quikly notice that the parsing was very fragile and on some strange
device (an example a Xiaomi 36000) the first PHY for the package was
actually not attached to anything. Resulting in all this logic of
"first_phy_addr" failing as by removing the first PHY, the value was set
to a wrong addr resulting in all sort of problems.

This changed a lot (the original series used a more robust way with
phandle, but it was asked to use base_addr and use offset in the PHY
addr, less robust still OK)

If we revert to PHY driver making the PHY package then we lose all kind
of ""automation"" of having a correct base addr. In PHY driver we would
have to manually parse with parent (as we do here) and check the value?

Why not do the thing directly on PHY core?

By making the PHY driver creating the package, we are back on all kind
of bloat in the PHY driver doing the same thing (parsing package nodes,
probe_once check, config_once check) instead of handling them directly
in PHY core.

Also just to point out, the way the current PHY driver derive the base
addr is problematic. All of them use special regs to find the base one
but I can totally see a PHY driver in the future assuming the first PHY
being the first in the package to be probed, set the base addr on the
first PHY and also assuming that it's always define in DT.

If we really don't want the OF parsing in PHY core and autojoin them,
is at least OK to introduce an helper to get the base addr from a PHY
package node structure? (to at least try to minimaze the bloat that PHY
driver will have?)

Also with the OF support dropped, I guess also the added API in this
series has to be dropped. (as they would be called after the first PHY
probe and that is problematic if for some reason only one PHY of the
package is declared in DT) (an alternative might be moving the
probe_once after the PHY is probed as we expect the phy_package_join
call done in the PHY probe call)

> If you create the package based on DT you have to validate that the DT
> is correct. You need the same information, the base address, how many
> packages are in the PHY, etc. So DT gains your nothing except more
> potential to get it wrong.
> 

For the sake of package join, only the reg has to be validated and the
validation is just if addrs makes sense. Everything else can be done by
PHY package probe once.

> Please use DT just for properties for the package, nothing else.
> 

-- 
	Ansuel
