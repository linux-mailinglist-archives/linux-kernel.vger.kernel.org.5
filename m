Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363857F9090
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 01:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjKZAyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 19:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjKZAyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 19:54:33 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4B4DB;
        Sat, 25 Nov 2023 16:54:40 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32faea0fa1fso1704294f8f.1;
        Sat, 25 Nov 2023 16:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700960079; x=1701564879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ltQclqkFj/xMu+b5r26yFK5pByVqHfoEcMFbjZo3yyo=;
        b=jmRFj+VF6EEwKk/TBQbY0YwlDC+T6ru+aoU9/dzVGcV2A43P6S09e1Z0bmdlvZTyua
         3r4l7S/PKKNa0UMNEBGKo5mvAN3VY+g+507z2PWxtP9kKVlIFLNxchs2r+S1BFLIx4iV
         GgTCyxC3L+fXgGA8n4OcXSNydNWVX+LVVZu0lLjmqCzmuKpqmv7kMGi+6zfNa6F0rGUP
         qRh9qG+8OG6H15LsFk6UbZscclkRi7SsEOrw/cpFzumARkBeuQX0kIK8wWhDtUT8CZBQ
         w3o8dWu5xXQfSQ0PE+4+2QNFf6Jzvm3wSJvmMrgkgOtYmbkaNWGbY18NoxxkixgUyINW
         hvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700960079; x=1701564879;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltQclqkFj/xMu+b5r26yFK5pByVqHfoEcMFbjZo3yyo=;
        b=vrITdbEAJrjUTodEXPZuo64uZQYp3h+TPj0c4NuzNMHmXEaXaKmHIRmFsZS8qGOpqZ
         f21bPWCVPZ751J4R7FTXO5jQG4pKy8fzlAeIA8jXk1m9USkeuLKO1QVpDgRdPQMEABnu
         ke5y3z52Fg6MgMcokkN+5kkNDgHsszZDJphUzOQ0XOQ34XbhSEs5F3ZMC2Q9nm8o32rm
         WjSavQ6/kX5Lmr5uoP+REp50fz+Y/6srTC2FPnRawMRbawPVx7uknqT3JwVB5B6fBPn9
         0dUDsvx24fpDjIQZ3AbUWipT67lgC98LBXuvsevzMd3h/V5RDBVOcvvDJQ/8uvhzXiF+
         oVUg==
X-Gm-Message-State: AOJu0YzX8D0jSlZr1EjKGp9UT9wfVjTN9qXZpL8it+Iz1wO5Kj9C6uFu
        scu8rkA0cPyKD2pkAZKXHLk=
X-Google-Smtp-Source: AGHT+IF6snv08s8f4PF01FYyHM35UwJIJcI1gHOezRjJ0Gt00iosgCCUSDl8L8jpLsuCa7fHPwHxNg==
X-Received: by 2002:a05:6000:1001:b0:332:f9e8:ce15 with SMTP id a1-20020a056000100100b00332f9e8ce15mr736780wrx.4.1700960078599;
        Sat, 25 Nov 2023 16:54:38 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id j7-20020adfb307000000b00332e7f9e2a8sm5894567wrd.68.2023.11.25.16.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 16:54:38 -0800 (PST)
Message-ID: <6562974e.df0a0220.242f6.337e@mx.google.com>
X-Google-Original-Message-ID: <ZWKXS_NZePy80ytW@Ansuel-xps.>
Date:   Sun, 26 Nov 2023 01:54:35 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
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
Subject: Re: [net-next PATCH 3/3] net: phy: add support for PHY package MMD
 read/write
References: <20231126003748.9600-1-ansuelsmth@gmail.com>
 <20231126003748.9600-3-ansuelsmth@gmail.com>
 <637891aa-19fa-4f13-9ed2-f2e14a4b1ee2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <637891aa-19fa-4f13-9ed2-f2e14a4b1ee2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 04:52:19PM -0800, Florian Fainelli wrote:
> 
> 
> On 11/25/2023 4:37 PM, Christian Marangi wrote:
> > Some PHY in PHY package may require to read/write MMD regs to correctly
> > configure the PHY package.
> > 
> > Add support for these additional required function in both lock and no
> > lock variant.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   include/linux/phy.h | 74 +++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 74 insertions(+)
> > 
> > diff --git a/include/linux/phy.h b/include/linux/phy.h
> > index 984bca9a82f4..1799133c8387 100644
> > --- a/include/linux/phy.h
> > +++ b/include/linux/phy.h
> > @@ -2067,6 +2067,80 @@ static inline int __phy_package_write(struct phy_device *phydev,
> >   	return __mdiobus_write(phydev->mdio.bus, addr, regnum, val);
> >   }
> > +static inline int phy_package_read_mmd(struct phy_device *phydev,
> > +				       unsigned int addr_offset, int devad,
> > +				       u32 regnum)
> > +{
> > +	struct phy_package_shared *shared = phydev->shared;
> > +	struct mii_bus *bus = phydev->mdio.bus;
> > +	int addr, val;
> > +
> > +	if (!shared || shared->base_addr + addr_offset > PHY_MAX_ADDR)
> > +		return -EIO;
> 
> You might be off by one here, should not that >= PHY_MAX_ADDR here and
> below?

Thanks for the review. Yes PHY_MAX_ADDR is 32 so I should use >=.

(interesting choice to use 32 instead of 31 as MAX, guess an old mistake)

-- 
	Ansuel
