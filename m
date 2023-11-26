Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B467F94C6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 19:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjKZSHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 13:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZSHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 13:07:31 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC959C8;
        Sun, 26 Nov 2023 10:07:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-332c7d4a6a7so2352133f8f.2;
        Sun, 26 Nov 2023 10:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701022056; x=1701626856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zl+M3ujotUrkbHG7gvMPXrII3hwKGjjL5Pw7/H1vhVQ=;
        b=IFkNTsoNa4b6npeb77bULGANZQHEysrgaBsDEiPBT2VCWXRNmwu0+OzPfUIHE7+4v8
         SV7WbD+b4R6eI9eos1gjYwisuwsIJRB3Ec37rVBjcqAFOy17wnJlP+zXxWEx7MhKJ5GP
         6VTA98Ed2wxXHyPIxPeYEZ1Re/tQwGEuh1T9crXIKIsIvT5r6Ly9zFAaBNhAr+DBMUox
         RccefJP2Zquuoz8wwem04Ri7ZWCEUsYO8ndmt63bisIbqJ0F5iRPHegVznw8X3y2cFgE
         9Kudblt0jCJuxW11Uq0KHPJj5cWMrjmPSwUgbW6vOsONipYiOYqb83f2vC50laBs6lAc
         ZVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701022056; x=1701626856;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zl+M3ujotUrkbHG7gvMPXrII3hwKGjjL5Pw7/H1vhVQ=;
        b=wCWTilfoXHmqqw1a80J20AQJ0wKXHCBT2aVor4iXKA5O7Yb45HCNTB7vgWVoFNI1KT
         zYXD5Ovabz9mbO2KS/Y1Th5PpEU3Tbs4k+awTjPSy/p4LMryHDlpPRObKNQ1s7M6zJnS
         aS8rhJfnMljZE5/9Sd7h/wQF8Xb1i/AlY9bG5VYFVl8KSWLEG6Qy674XZqU1oAFjHaQb
         Xmr11oOurfDa4KDntVEi2NvZtUhtzT21WuTa3S5nEX6pCCMFxtY+MWB5ZjDBenJC8YXr
         YMp0ke+brBFeN0m22SGwKDvVWpK1V7B29SqZ4U8/5YPSSDIibFpAWw+w37xfpc5wCk/b
         9+Eg==
X-Gm-Message-State: AOJu0YzbsNCJa5sexDADc1nFakwuZn/Iizk0qa6/RM431zajfoutVVul
        uK76yrdWvYmbrEVojDeio5o=
X-Google-Smtp-Source: AGHT+IG0FFsJGGhhTWzGSACte3rPzwIixb1ruSxLBpRtpROcrwk2bs2Bf+ZjEthT0xuSejr6v/ZRJg==
X-Received: by 2002:adf:f111:0:b0:332:eb19:951c with SMTP id r17-20020adff111000000b00332eb19951cmr5839512wro.19.1701022055687;
        Sun, 26 Nov 2023 10:07:35 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5552000000b0032f7e832cabsm6508886wrw.90.2023.11.26.10.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 10:07:35 -0800 (PST)
Message-ID: <65638967.5d0a0220.28475.43b3@mx.google.com>
X-Google-Original-Message-ID: <ZWOJZA7WNk8psZEG@Ansuel-xps.>
Date:   Sun, 26 Nov 2023 19:07:32 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/3] net: phy: extend PHY package API to support
 multiple global address
References: <20231126003748.9600-1-ansuelsmth@gmail.com>
 <cc37984c-13b1-4116-99f8-1a65546c477a@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc37984c-13b1-4116-99f8-1a65546c477a@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 07:04:26PM +0100, Andrew Lunn wrote:
> > @@ -1648,20 +1648,27 @@ EXPORT_SYMBOL_GPL(phy_driver_is_genphy_10g);
> >  /**
> >   * phy_package_join - join a common PHY group
> >   * @phydev: target phy_device struct
> > - * @addr: cookie and PHY address for global register access
> > + * @base_addr: cookie and base PHY address of PHY package for offset
> > + *   calculation of global register access
> >   * @priv_size: if non-zero allocate this amount of bytes for private data
> >   *
> >   * This joins a PHY group and provides a shared storage for all phydevs in
> >   * this group. This is intended to be used for packages which contain
> >   * more than one PHY, for example a quad PHY transceiver.
> >   *
> > - * The addr parameter serves as a cookie which has to have the same value
> > - * for all members of one group and as a PHY address to access generic
> > - * registers of a PHY package. Usually, one of the PHY addresses of the
> > - * different PHYs in the package provides access to these global registers.
> > + * The addr parameter serves as cookie which has to have the same values
> 
> addr has been renamed base_addr.
> 
> > + * for all members of one group and as the base PHY address of the PHY package
> > + * for offset calculation to access generic registers of a PHY package.
> > + * Usually, one of the PHY addresses of the different PHYs in the package
> > + * provides access to these global registers.
> >   * The address which is given here, will be used in the phy_package_read()
> > - * and phy_package_write() convenience functions. If your PHY doesn't have
> > - * global registers you can just pick any of the PHY addresses.
> > + * and phy_package_write() convenience functions as base and added to the
> > + * passed offset in those functions. If your PHY doesn't have global registers
> > + * you can just pick any of the PHY addresses.
> 
> 
> I would not add this last sentence. We want a clearly defined meaning
> of base_addr. Its the lowest address in the package. It does not
> matter if its not used, it should still be the lowest address in the
> package.
> 
> > + * In some special PHY package, multiple PHY are used for global init of
> 
> I don't see why they are special.
> 
> > -static inline int phy_package_read(struct phy_device *phydev, u32 regnum)
> > +static inline int phy_package_read(struct phy_device *phydev,
> > +				   unsigned int addr_offset, u32 regnum)
> >  {
> >  	struct phy_package_shared *shared = phydev->shared;
> > +	int addr;
> >  
> > -	if (!shared)
> > +	if (!shared || shared->base_addr + addr_offset > PHY_MAX_ADDR)
> >  		return -EIO;
> >  
> > -	return mdiobus_read(phydev->mdio.bus, shared->addr, regnum);
> > +	addr = shared->base_addr + addr_offset;
> > +	return mdiobus_read(phydev->mdio.bus, addr, regnum);
> 
> This might be a little bit more readable:
> 
> static inline int phy_package_read(struct phy_device *phydev,
> 				   unsigned int addr_offset, u32 regnum)
> {
> 	struct phy_package_shared *shared = phydev->shared;
> 	int addr = shared->base_addr + addr_offset;

Isn't this problematic if shared is NULL?

I can add 2 if condition and set addr in between only after shared not
NULL check is done?

> 
> 	if (!shared)
> 	if (!shared || addr > PHY_MAX_ADDR)
> 		return -EIO;
> 
> 	return mdiobus_read(phydev->mdio.bus, addr, regnum);
> }
> 
>

-- 
	Ansuel
