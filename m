Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087B57FD339
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjK2JuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjK2Jtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:49:47 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CCE1999;
        Wed, 29 Nov 2023 01:49:17 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b4f6006d5so11365845e9.1;
        Wed, 29 Nov 2023 01:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701251356; x=1701856156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=66nT2oOs9hwRfLJpvpIoPxs492CUA1F2zIY8oJPXmF8=;
        b=Zd2TBOwQHSmbB8+X0oM5/RE/K3oUYtzuY4EvalJa+k3yg79HjiN8ZX0CRRFDwRRvFJ
         I8DnZncj+3ZBI1DHi5OBLSYR8mO90AJXTUQleWQJAxvbGpvkit6tK0HQtwIo7FUd+CId
         D/Tq/NWMjBbhvJBjQtxF/qB5lQNQx8D2VB5r1R6bwL3DgUFsYn3plxz7DDzzTBlc6Peo
         RMycnZdxf9RoAJs5hhSC4KoaEhi9XjxlnTsUR2MvBpYMis3H/0bD5IbOnnKCJCMKn/7l
         4lDj6T2W22lug6bORAYDdZplzOavuWmjwmKmyCjNXfXqVXea+Cv6zMDPuClnpkv/Qt4D
         NJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701251356; x=1701856156;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66nT2oOs9hwRfLJpvpIoPxs492CUA1F2zIY8oJPXmF8=;
        b=FebaUCfOrCjGiBmQus9x2MtdHJ2eCTJ4iO2LMZQTBTDF/pX/s3/jW115PuavXEIdZn
         vtFwbQvtU9po6QvVgKQPKs7ALLEXknPIJ7FdYH6k8JWHfQGZAcaMczic+8PeE/3s6Tby
         BH+sGBp+qqyhAbi/evgZU9yRcU+gPSyTuAEO7M4VWBCL1uKfErJDzxUBaZHLi+dmV97U
         p8/9OkW51CX4GYvRLtTF51Vzz/rgKAy7XnfuLD3LcCxDCL13yxFBWio7fXd9lPGQncao
         W1yv2ZX66k4ND492/TFwMcj+Nd9aGh9WoXTKYSQADMmkpV2T3NO+wgHG8Q6YtMd0M319
         hFqA==
X-Gm-Message-State: AOJu0Yzx3xDr764VwIjyKCSyatoszr5UKrUQO/KYb6Jv9W55iEV0xRb3
        6yZcQJZyNSFfs2zBojPvjY4J2HZxPSI=
X-Google-Smtp-Source: AGHT+IF54aFHBaIN3vElNqQGOxBoZOqFtZLyaSwx1V6rMit1/UE0qnBNSDtEZmCBE5S7pqM8G1ohQw==
X-Received: by 2002:a05:600c:524a:b0:40b:4ba1:c502 with SMTP id fc10-20020a05600c524a00b0040b4ba1c502mr3602156wmb.37.1701251355650;
        Wed, 29 Nov 2023 01:49:15 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b0040b4110f548sm1592873wmo.23.2023.11.29.01.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:49:15 -0800 (PST)
Message-ID: <6567091b.050a0220.44fc8.41fb@mx.google.com>
X-Google-Original-Message-ID: <ZWcJGQEvH-9H2f6p@Ansuel-xps.>
Date:   Wed, 29 Nov 2023 10:49:13 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH 09/14] net: phy: at803x: remove specific qca808x
 check from at803x functions
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-10-ansuelsmth@gmail.com>
 <ZWcHzAXyIl++F1Sm@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWcHzAXyIl++F1Sm@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 09:43:40AM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 29, 2023 at 03:12:14AM +0100, Christian Marangi wrote:
> > Remove specific qca808x check from at803x generic functions.
> > 
> > While this cause a bit of code duplication, this is needed in
> > preparation for splitting the driver per PHY family and detaching
> > qca808x specific bits from the at803x driver.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/phy/at803x.c | 107 ++++++++++++++++++++++++++-------------
> >  1 file changed, 71 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> > index 8f5878ccb1a8..475b96165f45 100644
> > --- a/drivers/net/phy/at803x.c
> > +++ b/drivers/net/phy/at803x.c
> > @@ -1043,24 +1043,6 @@ static int at803x_config_aneg(struct phy_device *phydev)
> >  	 */
> >  	ret = 0;
> 
> Doesn't this become unnecessary?
> >  
> > -	if (phydev->drv->phy_id == QCA8081_PHY_ID) {
> > -		int phy_ctrl = 0;
> > -
> > -		/* The reg MII_BMCR also needs to be configured for force mode, the
> > -		 * genphy_config_aneg is also needed.
> > -		 */
> > -		if (phydev->autoneg == AUTONEG_DISABLE)
> > -			genphy_c45_pma_setup_forced(phydev);
> > -
> > -		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->advertising))
> > -			phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
> > -
> > -		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
> > -				MDIO_AN_10GBT_CTRL_ADV2_5G, phy_ctrl);
> > -		if (ret < 0)
> > -			return ret;
> > -	}
> > -
> >  	return __genphy_config_aneg(phydev, ret);
> 
> ... since you can just call genphy_config_aneg() here now?
> 
> > @@ -1845,6 +1815,47 @@ static int qca8327_suspend(struct phy_device *phydev)
> >  	return qca83xx_suspend(phydev);
> >  }
> >  
> > +static int qca808x_config_aneg(struct phy_device *phydev)
> > +{
> > +	int phy_ctrl = 0;
> > +	int ret;
> > +
> > +	ret = at803x_config_mdix(phydev, phydev->mdix_ctrl);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Changes of the midx bits are disruptive to the normal operation;
> > +	 * therefore any changes to these registers must be followed by a
> > +	 * software reset to take effect.
> > +	 */
> > +	if (ret == 1) {
> > +		ret = genphy_soft_reset(phydev);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	/* Do not restart auto-negotiation by setting ret to 0 defautly,
> > +	 * when calling __genphy_config_aneg later.
> > +	 */
> > +	ret = 0;
> > +
> > +	/* The reg MII_BMCR also needs to be configured for force mode, the
> > +	 * genphy_config_aneg is also needed.
> > +	 */
> > +	if (phydev->autoneg == AUTONEG_DISABLE)
> > +		genphy_c45_pma_setup_forced(phydev);
> > +
> > +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->advertising))
> > +		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
> > +
> > +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
> > +				     MDIO_AN_10GBT_CTRL_ADV2_5G, phy_ctrl);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return __genphy_config_aneg(phydev, ret);
> > +}
> 
> ... but is it _really_ worth duplicating the entire function just to
> deal with the QCA8081 difference? On balance, I think the original code
> is better.
> 
> Overall, I'm getting the impression that you have a mental hang-up about
> drivers checking the PHY ID in their method drivers... there's
> absolutely nothing wrong with that. When the result of trying to
> eliminate those results in bloating a driver, then the cleanup is not
> a cleanup anymore, it creates bloat and makes future maintenance
> harder.

For some AT803x ID it might be O.K. but here we are mixing all kind of
thing and you already noticing the state of this driver with the priv
changes. Again it's all to facilitate the last 2 patch of this series.

> 
> Sorry, but no, I don't like this patch.

-- 
	Ansuel
