Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318D38057C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbjLEOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjLEOnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:43:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3DA129;
        Tue,  5 Dec 2023 06:43:29 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c07ed92fdso29342275e9.3;
        Tue, 05 Dec 2023 06:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701787408; x=1702392208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGnImGdlNDTwdyaLU8r9UMvVcFSjoGXk6VpSezOFFzM=;
        b=j3Tjv78IhlfcCX1l+elEUF5WlRR4Nph2hhju40c7BmXyv547NzQwsIRliNefjYxlHQ
         A9WcYjyxV4rzK+q0mu/n5G0DbkRUe6c7z4/UZyOm03om5MHWAUPMVA/Y3YLqdwlFaBXL
         NO3yIHKt13ZVyEJ2m/EH+uaKsGgqD8zWmckUZKvQ28M2wWLpd0zz6eYC43tLK2hxzftl
         p1pHJZLkIvifYee4NEZYPtN8fDrkMlBBoEqRbR8ylTw32P2wP0/JNce+m04rGElczGIk
         fPe9yX2KeSVb0fchKPiGV2wO0jeE1mSeJcv1DpzPMPkecUElBitSE9JzoERlbBwTtDwk
         Os3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787408; x=1702392208;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGnImGdlNDTwdyaLU8r9UMvVcFSjoGXk6VpSezOFFzM=;
        b=kzz/mPw/2pZBCor40/fzA++1OGSnzHgGl30b+20MKzqbDrUQuBJhXwBQGc4gzrKVny
         rzHdr1X49/jCfSUfXHEz1hwIgVZ1vJ0+J2/PsgA1pDdFIC1fki7d5IoqFd4UQ8Eup5Ld
         RO/gh3qsJkiDn4jcrMsHSXfW4/G0FkJv8Pi3kKtOahNI2+tVj32Nxs2GJVs3bUfFgw5K
         dkUUdHLnvsicN0wM7nZlwAEBkhahXZsu0CpbsOe7ZRrxWnWjRW6FQEcVPAnz1Jl25oUX
         DPCvN/Ck7qcmmD9F52ML0aoryQCdTC6U4+XVa6SRvopqOR35bkkakhDZTw9GdooEvJPn
         c+LA==
X-Gm-Message-State: AOJu0YyzS8a6Q9N+t90bZoyk+yTfLySa+lhrLy2bL53xMvhCAB9dCCDL
        BD44lFrDCZ/MOPiZ6JhV4wk=
X-Google-Smtp-Source: AGHT+IFYpdumJgRJ2s4LxEC0YV9JgVEmFxq0CuMbAQyVRpaTC+PUMGgdvyhwQyU1Xoobg5XhyKXjWg==
X-Received: by 2002:a05:600c:4ec6:b0:40b:5e1e:b3b0 with SMTP id g6-20020a05600c4ec600b0040b5e1eb3b0mr559765wmq.46.1701787407594;
        Tue, 05 Dec 2023 06:43:27 -0800 (PST)
Received: from Ansuel-xps. (host-87-1-181-21.retail.telecomitalia.it. [87.1.181.21])
        by smtp.gmail.com with ESMTPSA id d13-20020a05600c34cd00b0040b540ff0a5sm19050660wmq.19.2023.12.05.06.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:43:27 -0800 (PST)
Message-ID: <656f370f.050a0220.8c4c5.8d3f@mx.google.com>
X-Google-Original-Message-ID: <ZW83DDRrX-zxf3kw@Ansuel-xps.>
Date:   Tue, 5 Dec 2023 15:43:24 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 08/12] net: phy: at803x: move specific at8031
 WOL bits to dedicated function
References: <20231201001423.20989-1-ansuelsmth@gmail.com>
 <20231201001423.20989-9-ansuelsmth@gmail.com>
 <bdbe618d4fd38469e4e139ce4ebd161766f2e4d5.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdbe618d4fd38469e4e139ce4ebd161766f2e4d5.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:32:55AM +0100, Paolo Abeni wrote:
> On Fri, 2023-12-01 at 01:14 +0100, Christian Marangi wrote:
> > Move specific at8031 WOL enable/disable to dedicated function to make
> > at803x_set_wol more generic.
> > 
> > This is needed in preparation for PHY driver split as qca8081 share the
> > same function to toggle WOL settings.
> > 
> > In this new implementation WOL module in at8031 is enabled after the
> > generic interrupt is setup. This should not cause any problem as the
> > WOL_INT has a separate implementation and only relay on MAC bits.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/phy/at803x.c | 42 ++++++++++++++++++++++++----------------
> >  1 file changed, 25 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> > index 02ac71f98466..2de7a59c0faa 100644
> > --- a/drivers/net/phy/at803x.c
> > +++ b/drivers/net/phy/at803x.c
> > @@ -466,27 +466,11 @@ static int at803x_set_wol(struct phy_device *phydev,
> >  			phy_write_mmd(phydev, MDIO_MMD_PCS, offsets[i],
> >  				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
> >  
> > -		/* Enable WOL function for 1588 */
> > -		if (phydev->drv->phy_id == ATH8031_PHY_ID) {
> > -			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> > -					     AT803X_PHY_MMD3_WOL_CTRL,
> > -					     0, AT803X_WOL_EN);
> > -			if (ret)
> > -				return ret;
> > -		}
> >  		/* Enable WOL interrupt */
> >  		ret = phy_modify(phydev, AT803X_INTR_ENABLE, 0, AT803X_INTR_ENABLE_WOL);
> >  		if (ret)
> >  			return ret;
> >  	} else {
> > -		/* Disable WoL function for 1588 */
> > -		if (phydev->drv->phy_id == ATH8031_PHY_ID) {
> > -			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> > -					     AT803X_PHY_MMD3_WOL_CTRL,
> > -					     AT803X_WOL_EN, 0);
> > -			if (ret)
> > -				return ret;
> > -		}
> >  		/* Disable WOL interrupt */
> >  		ret = phy_modify(phydev, AT803X_INTR_ENABLE, AT803X_INTR_ENABLE_WOL, 0);
> >  		if (ret)
> > @@ -1611,6 +1595,30 @@ static int at8031_config_init(struct phy_device *phydev)
> >  	return at803x_config_init(phydev);
> >  }
> >  
> > +static int at8031_set_wol(struct phy_device *phydev,
> > +			  struct ethtool_wolinfo *wol)
> > +{
> > +	int ret;
> > +
> > +	/* First setup MAC address and enable WOL interrupt */
> > +	ret = at803x_set_wol(phydev, wol);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (wol->wolopts & WAKE_MAGIC)
> > +		/* Enable WOL function for 1588 */
> > +		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> > +				     AT803X_PHY_MMD3_WOL_CTRL,
> > +				     0, AT803X_WOL_EN);
> > +	else
> > +		/* Disable WoL function for 1588 */
> > +		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> > +				     AT803X_PHY_MMD3_WOL_CTRL,
> > +				     AT803X_WOL_EN, 0);
> > +
> > +	return ret;
> 
> If I read correctly, the above changes the order of some WoL
> initialization steps: now WOL_CTRL is touched after
> AT803X_INTR_ENABLE_WOL. Is that correct?

Correct, as it was pointed out, in the previous revision the WOL was
enabled before setting the MAC leaving some timeframe where we had
interrupt that could be triggered by invalind MAC (and also in case MAC
setup was failing the WOL was laved enabled)

The current change should be safe enough as the WOL module is enabled at
the end of all the required setup preventing any kind of
misconfiguration if something fails before.

-- 
	Ansuel
