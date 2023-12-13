Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93596811935
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbjLMQYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLMQYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:24:17 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DEF93;
        Wed, 13 Dec 2023 08:24:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c32df9174so63134645e9.3;
        Wed, 13 Dec 2023 08:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702484662; x=1703089462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j0B/xLjyRK3LtGRhTP4eV+dFPdocr084C+aw+lu9fRI=;
        b=i7qL967RkohUUt4Iws8BUTPJ10itZMI33oiqpGHfuEyEqah0dg+mfmQz6bkbbsbOXY
         FHMgcj/E4pw0cDtAIfs7JF18YXF0B3et2ARdl6qBEyMb+El686MCgCxe+L8rI1BHsp3k
         B5cwyBEKXFUpuaafmjJxhkyWqINXYzgG+NgQVtL2pW5B3h53yf9oSG929vMf7OWihS+/
         anVWq0YLxisNGE6MvSjz6tCE/pNkAYABG/D5dW0ymx/3BSzX3Nh4bxy3tIcena1Q9TuT
         aBmGauthUXTkVTbcymKPT5Lb0nczB14jvMLZqk93tL7/7ho9NeffpccRTyiyGHZZhPDY
         MDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484662; x=1703089462;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0B/xLjyRK3LtGRhTP4eV+dFPdocr084C+aw+lu9fRI=;
        b=W4YVIzelIyMNAYb6ZG59ImbvCTz7Maw1DX1BufTOG4kcMDX6fNTVaSbKggg85Xldu7
         PciZXchoGaLarewnEGO2pf6FdMhPtlRecM99Okpq/CiR2UEgSGLZwH50XN+2ICgeD+2H
         yxI5OgINW/7WpjWoNfFM787dK/PbOBTVv5gC4pjDrVnninjw6XKVQKBC/XqUnhZ14H+P
         xJKWpEDN/lyHZNPHcjQHcSdg6mxb2xg+AHhMcVW5Q6Gi+X46t/EIPAYXJuPTW/IySMVY
         hB89ZdTC1XLNfUX6EmBtnwkBcsKOnpOX/7rC2CyO4Nq1WMsZlSTgKInH7Irr7A/tFo7w
         dIDA==
X-Gm-Message-State: AOJu0Yx32B+e8xKY08+jQiaiCGN9NR/u3a5OX1YHOPN0cKZsCek5mKaG
        dWbUeUUlkmOTr1/q8qDf+mo=
X-Google-Smtp-Source: AGHT+IFoFekhPR/5x+lc91ymAKcq7wUOjTQmxYyloUFXxNPV+4YHnwln3b2BomU1YaOWVqZ/t6Y90g==
X-Received: by 2002:a05:600c:16d4:b0:40c:2787:5718 with SMTP id l20-20020a05600c16d400b0040c27875718mr2936959wmn.278.1702484661438;
        Wed, 13 Dec 2023 08:24:21 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b0040b2b38a1fasm21179234wmb.4.2023.12.13.08.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:24:21 -0800 (PST)
Message-ID: <6579dab5.050a0220.8552a.d827@mx.google.com>
X-Google-Original-Message-ID: <ZXnasiw6mEPYMuSJ@Ansuel-xps.>
Date:   Wed, 13 Dec 2023 17:24:18 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v6 1/3] net: phy: extend PHY package API to
 support multiple global address
References: <20231213105730.1731-1-ansuelsmth@gmail.com>
 <ZXnRlERUGhwxKJxi@shell.armlinux.org.uk>
 <6579d2cc.050a0220.e6ea.d8cf@mx.google.com>
 <ZXnX6GuooQQwu8Bs@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnX6GuooQQwu8Bs@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 04:12:24PM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 13, 2023 at 04:50:33PM +0100, Christian Marangi wrote:
> > On Wed, Dec 13, 2023 at 03:45:24PM +0000, Russell King (Oracle) wrote:
> > > On Wed, Dec 13, 2023 at 11:57:28AM +0100, Christian Marangi wrote:
> > > > -static inline int phy_package_read(struct phy_device *phydev, u32 regnum)
> > > > +static inline int phy_package_read(struct phy_device *phydev,
> > > > +				   unsigned int addr_offset, u32 regnum)
> > > >  {
> > > >  	struct phy_package_shared *shared = phydev->shared;
> > > > +	int addr = shared->base_addr + addr_offset;
> > > >  
> > > > -	if (!shared)
> > > > +	if (addr >= PHY_MAX_ADDR)
> > > >  		return -EIO;
> > > 
> > > If we're going to check the address, I think we should check it
> > > properly, which means also checking whether it's become negative.
> > > 
> > > Alternatively, we could consider making "addr" and "base_addr"
> > > unsigned types, since they should never be negative. However,
> > > that probably should be done as a separate patch before this one.
> > >
> > 
> > Maybe I'm confused but isn't already like that?
> > On phy_package_join base_addr is already checked if it's negative (and
> > rejected)
> > 
> > addr_offset is unsigned so it can't be negative.
> 
> True, but with base_addr being an int, addr_offset being unsigned int,
> and addr being an int, if addr_offset is a very large number,
> 2-complement arithmetic will have the effect of treating it as a
> negative number.
> 
> So, base_addr=0, addr_offset=~0 results in addr being -1.
> 
> If "addr" were unsigned int, and as we've already established,
> "base_addr" can't be less than zero because of the checks already done
> (thus it can also be unsigned int) then we'll end up with the checks
> you're adding automatically doing the right thing, because...
> 
> base_addr=0, addr_offset=~0 results in addr being ~0 (a large
> positive unsigned number).
> 

Oh ok... now it makes sense. So I guess I should change "addr" to
unsigned.

Considering I'm changing addr in phy_package_shared to base_addr would
it be ok to change that also to unsigned (doesn't make sense to have
that int) in this patch? Or should I create first a small patch before
this to change addr type?

-- 
	Ansuel
