Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9437FB9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344674AbjK1MMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344641AbjK1MMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:12:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B70AD56;
        Tue, 28 Nov 2023 04:12:14 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-332fd81fc8dso1703523f8f.3;
        Tue, 28 Nov 2023 04:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701173533; x=1701778333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=50dfb3OF2cAlmCtU+EgqKKElMGY5/1S4fCVfmkUTn2s=;
        b=GvmZhmfJ7YNRnl397X+KttTFQWoljVe7KveeDtuuZMEDpZIA0GBa64BTRs0dZ0Lykg
         7jySTq9r7Rp78aCh04ingBrQ+QZsBnh6XbeqLYBO8Y+aJ1jQ19VELYhTYF+nKuviZtqj
         VlPd4M0vcZ/PSn4B8lbcnPBPFSgvWKC7JLEDFALn7Z2bNyoKd49YI1+0OxnJb0zTft65
         AWJZWy7TOQlBpdfW2iL3zDTDC+RfsFA6v5ULN2zBzBiyTI3iFwrjVWVQKMzKaYWapzAn
         o5uB/E/dv2WDk8/UMDUfSUZDqhEVZeKe88mYFjAoGOlI+yqa/BjA1Fz5Kq7sUEdHl+Nj
         99FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701173533; x=1701778333;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50dfb3OF2cAlmCtU+EgqKKElMGY5/1S4fCVfmkUTn2s=;
        b=gUi70M3ngizdvKn+nff8S34V9H+UMzR4ucawwt3/tkElOVTJ44yJ3ui04My+Dfpg7B
         80A2Zn+Zt7F7aaDbJo3f6pNTyacOb1IklsRthqxa3cUuHSrCwspSVTkS2pCOH0nFMwHQ
         FW6VxP+Z+lb1+gmo5enkGGfSplfjozdiUjhPuwrgYdnEf2OnZR0tPGIHXUYyyP+wO/eA
         zwjDy1hUOFiqFzPjH0zwpYiW6V/aGB+9LfjwZTNqIvX/oI2Chd6NUaw0Y0dzUfXGWvJD
         k486lCOV9GtDRBOlqUZAHVSKtSCgtUQvhutuV7j8VJuk3eeIR34BTq2L5l7zkMw/+37+
         8wFw==
X-Gm-Message-State: AOJu0YwqAqK06nbURxwGeRdiPtKELhtu2QCTFGYTEtmW/CsfPRHdZDAT
        VaDHuLpyNf9kOKPcmXfCEB4=
X-Google-Smtp-Source: AGHT+IG8mOQKUjlQFp9zkVxQeOhCiybq8qLw7QScYhjZo4dYddCYSOR9yvSaselcI1oPVf6lMqLfjg==
X-Received: by 2002:a5d:58f3:0:b0:333:b8a:8ea7 with SMTP id f19-20020a5d58f3000000b003330b8a8ea7mr1448395wrd.49.1701173532821;
        Tue, 28 Nov 2023 04:12:12 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id df2-20020a5d5b82000000b0032fbe5b1e45sm14569599wrb.61.2023.11.28.04.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 04:12:12 -0800 (PST)
Message-ID: <6565d91c.5d0a0220.d1112.eb85@mx.google.com>
X-Google-Original-Message-ID: <ZWXZGg0PFotGsizp@Ansuel-xps.>
Date:   Tue, 28 Nov 2023 13:12:10 +0100
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
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 4/4] net: phy: add support for PHY package
 MMD read/write
References: <20231126235141.17996-1-ansuelsmth@gmail.com>
 <20231126235141.17996-4-ansuelsmth@gmail.com>
 <43255cdd-9e1e-472a-9263-04db0259b3cb@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43255cdd-9e1e-472a-9263-04db0259b3cb@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 01:51:05AM +0100, Andrew Lunn wrote:
> On Mon, Nov 27, 2023 at 12:51:41AM +0100, Christian Marangi wrote:
> > Some PHY in PHY package may require to read/write MMD regs to correctly
> > configure the PHY package.
> > 
> > Add support for these additional required function in both lock and no
> > lock variant.
> > 
> > It's possible to set is_c45 bool for phy_package_read/write to true to
> > access mmd regs for accessing C45 PHY in PHY package for global
> > configuration.
> 
> I would just use phydev->is_c45. I would be very surprised if you have
> a package with some PHYs being only C22 and some C45.
>

Was being more careful about this. Ok will base everything on phydev.
Maybe will add a comment that we assume the entire package is C22 or
C45.

> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v2:
> > - Rework to use newly introduced helper
> > - Add common check for regnum and devad
> > 
> >  include/linux/phy.h | 78 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> > 
> > diff --git a/include/linux/phy.h b/include/linux/phy.h
> > index 96f6f34be051..3e507bd2c3b4 100644
> > --- a/include/linux/phy.h
> > +++ b/include/linux/phy.h
> > @@ -2085,6 +2085,84 @@ static inline int __phy_package_write(struct phy_device *phydev,
> >  	return __mdiobus_write(phydev->mdio.bus, addr, regnum, val);
> >  }
> >  
> > +static inline int phy_package_read_mmd(struct phy_device *phydev,
> > +				       unsigned int addr_offset, bool is_c45,
> > +				       int devad, u32 regnum)
> > +{
> 
> I also don't know why this should be in the header file?
> 
>   Andrew

-- 
	Ansuel
