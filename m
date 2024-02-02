Return-Path: <linux-kernel+bounces-50260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B173847681
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B22E1C262CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979C914C58B;
	Fri,  2 Feb 2024 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ21q9am"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316427701;
	Fri,  2 Feb 2024 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895869; cv=none; b=Bl6vrCD1iCUuILc5VrIevVNRs45RBcaXcTHB5aRAfXvWCD6wlJYgA/S9nXn7hDz50PrnPCOKXwQLT2YfYOQVFqdbYZKidVxB3TATyjMwXdiyPvZ1HfHNgJYetPboGh1GSDDsCF3c0hwVK5eo2S/FgzvhmODmF/I5AxomQkTm7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895869; c=relaxed/simple;
	bh=Pdnsr9+2aTvf1EMiyFp+4H7qXfNQ4E8H+asVKsuum5A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKJjrUzyl5yuwdfI8V926m4ipx7npR7Bs7IE/1G4Km4V9EZwRPsRk9o4ZUbu9gGMEC3zb3Ow4RTAIQJgK0q1sqT//RTg+ssQHbDVLxz1s+8M7nWH0+xQWDSh4sTOTBUSeDWSuEu2FFyXJncfu6r77w10aLywBKJYsGpEOG57KIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZ21q9am; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e76626170so19667885e9.2;
        Fri, 02 Feb 2024 09:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706895866; x=1707500666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5KTT/zunxG8GzgVbFJ4uE7KoPg76fkeeXqK9PnleRkg=;
        b=aZ21q9am7GkFajORI90lo7ZESEv8D1irznIzlOBew6GVXq+BJkCypIlJQJs5FMAimx
         CVn47mY6b9hi9uRgS/NHy4yrRytvsklEIW40gPaL2MCezCcG02+ylvC9LzvCpBUFCcSc
         9OFHF0yEawqweM2m+WvA3H+7XMiO1ooiMX6X4xc4kU07ufGqiSUKpbxDKasGU+kokuMb
         HvKkZXmv/fnvtDhI65+BMr/ntG3bXRW1ZKuDVIWFd5FUhR/fJ1MFx01P3H8U4FQHHKF2
         VYiFOBB4N3w2JltozCAbp/sDnaCniZLo766JYYon5UprldFpxmuIWU1oHLD9riheId67
         h0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895866; x=1707500666;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KTT/zunxG8GzgVbFJ4uE7KoPg76fkeeXqK9PnleRkg=;
        b=Pa0HB+/UFetPLqQ/I+y7ZJuqSI/HWWt1XYpmCs8pFB/nZQ7IC9t6FPkjOUIQKOedfu
         FdH5u1v60XCvo6u4nW/dzhjU9PzCTXDBQS7F+7knuBJmpyKa1WqnRZL+YA2tsPAbhiA+
         etw1Dy4J8bQWaPttgt1CuBNHabyBhnJ2toFHtLTGK395c2uXjXnUQdMp3XBjsXNNvW9u
         4htOcEpA4i4G/r7kqWx2cKTvQCCSeVhRLGEBczQu01eVPMFeuggjwhPiyeA7nyVF/HZW
         uOLYaw6pIjxt4hQCteRPpCIDjc5QDQPU87UsEaTmlGWk3irZh7QY+dizFZlTMJ11qo0y
         Od2w==
X-Gm-Message-State: AOJu0YxVVIKEedTPNJikyhomQwRLNFp7icWqDo+LijEWeQJ7Pm/WbB4X
	Q8rNZr30ywOXW4TT8qKhfeR6M63GelRuJ1Od+/cMAywZvmxhSYOm
X-Google-Smtp-Source: AGHT+IGdnuMot2+vVqfpCzZ0ZT2VGNnMEPQ4ewtjTmLiFkmFLcPKitSyufSe4qPV4HpRgNbR6OmwKw==
X-Received: by 2002:a05:600c:511e:b0:40e:b93c:940f with SMTP id o30-20020a05600c511e00b0040eb93c940fmr2046658wms.28.1706895865854;
        Fri, 02 Feb 2024 09:44:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVWB67qi2G6edSjgT3CD6s37LAqjU/3RwaPHGu+jxvNsAzGYKLJIeFk93bByBA8qXSfjxshhfanFSJdHcLdJ6vv5XJJNlZsAoNjnZF7Mi2b8RntVyUUvrLrpetzT+PLPCDnaceyZNJES7mVLTl246WnhNmAw8TN/run6/VX/tO6JtmFiHJ1oUg0AIsjg7ZAJeFDJyLdQ9qM0qgZt8Q8C3v/amVUov6JW7Ge5QKX0gpclXLHwZ/+6C7OBcqmdVVCLLUYvnJw2Oj14WQhsr6Q8BOtNGeY4GMx+eHFGrx0b/HgxvQv4cfcsuYhw1pHLoezL5KTbK+1Q/SVJW6bwXbElMBdJc4piwAINxNbkD5oNWoSnS4XajYHr7WdLvFzU0keC32wNpG99PNlRbBsm4k2Jk/sjh3IdLat2Ngt6+PugCCxICad5kmL9VjpX9hhQHtElXajAEShVTQB96gyIS0qmJNjjx5HrwbtZlN+zl0gCDsicShay7ayZdlKwxu94f8u7DYTnzMLdtZ9fgD4/jp2BW3imT+bVLVBS+L6B6dra4arJ+/mMJvKlv/mtYyhYpHXzdJDig==
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b0040fc26183e8sm545005wmb.8.2024.02.02.09.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:44:25 -0800 (PST)
Message-ID: <65bd29f9.050a0220.a175d.3d5f@mx.google.com>
X-Google-Original-Message-ID: <Zb0p9tKf5VRXyKc5@Ansuel-xps.>
Date: Fri, 2 Feb 2024 18:44:22 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 7/9] net: phy: qcom: add support for QCA807x
 PHY Family
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-8-ansuelsmth@gmail.com>
 <a530f40c-b8fd-4da1-b4df-f80ab05f0394@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a530f40c-b8fd-4da1-b4df-f80ab05f0394@lunn.ch>

On Fri, Feb 02, 2024 at 02:35:11AM +0100, Andrew Lunn wrote:
> > +static int qca807x_read_fiber_status(struct phy_device *phydev)
> > +{
> > +	int ss, err, lpa, old_link = phydev->link;
> > +
> > +	/* Update the link, but return if there was an error */
> > +	err = genphy_update_link(phydev);
> > +	if (err)
> > +		return err;
> > +
> > +	/* why bother the PHY if nothing can have changed */
> > +	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
> > +		return 0;
> > +
> > +	phydev->speed = SPEED_UNKNOWN;
> > +	phydev->duplex = DUPLEX_UNKNOWN;
> > +	phydev->pause = 0;
> > +	phydev->asym_pause = 0;
> > +
> > +	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
> > +		lpa = phy_read(phydev, MII_LPA);
> > +		if (lpa < 0)
> > +			return lpa;
> > +
> > +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> > +				 phydev->lp_advertising, lpa & LPA_LPACK);
> > +		linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
> > +				 phydev->lp_advertising, lpa & LPA_1000XFULL);
> > +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> > +				 phydev->lp_advertising, lpa & LPA_1000XPAUSE);
> > +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> > +				 phydev->lp_advertising,
> > +				 lpa & LPA_1000XPAUSE_ASYM);
> > +
> > +		phy_resolve_aneg_linkmode(phydev);
> > +	}
> 
> This looks a lot like genphy_c37_read_status(). Can it be used?
>

Yes but I had to expand genphy_c37_read_status. Hope it will be OK.

> > +
> > +	/* Read the QCA807x PHY-Specific Status register fiber page,
> > +	 * which indicates the speed and duplex that the PHY is actually
> > +	 * using, irrespective of whether we are in autoneg mode or not.
> > +	 */
> > +	ss = phy_read(phydev, AT803X_SPECIFIC_STATUS);
> > +	if (ss < 0)
> > +		return ss;
> > +
> > +	if (ss & AT803X_SS_SPEED_DUPLEX_RESOLVED) {
> > +		switch (FIELD_GET(AT803X_SS_SPEED_MASK, ss)) {
> > +		case AT803X_SS_SPEED_100:
> > +			phydev->speed = SPEED_100;
> > +			break;
> > +		case AT803X_SS_SPEED_1000:
> > +			phydev->speed = SPEED_1000;
> > +			break;
> > +		}
> > +
> > +		if (ss & AT803X_SS_DUPLEX)
> > +			phydev->duplex = DUPLEX_FULL;
> > +		else
> > +			phydev->duplex = DUPLEX_HALF;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> 
> > +static int qca807x_phy_package_probe_once(struct phy_device *phydev)
> > +{
> > +	struct phy_package_shared *shared = phydev->shared;
> > +	struct qca807x_shared_priv *priv = shared->priv;
> > +	unsigned int tx_driver_strength = 0;
> > +	const char *package_mode_name;
> > +
> > +	of_property_read_u32(shared->np, "qcom,tx-driver-strength",
> > +			     &tx_driver_strength);
> > +	switch (tx_driver_strength) {
> > +	case 140:
> > +		priv->tx_driver_strength = PQSGMII_TX_DRIVER_140MV;
> > +		break;
> > +	case 160:
> > +		priv->tx_driver_strength = PQSGMII_TX_DRIVER_160MV;
> > +		break;
> > +	case 180:
> > +		priv->tx_driver_strength = PQSGMII_TX_DRIVER_180MV;
> > +		break;
> > +	case 200:
> 
> ...
> 
> > +	case 500:
> > +		priv->tx_driver_strength = PQSGMII_TX_DRIVER_500MV;
> > +		break;
> > +	case 600:
> > +	default:
> 
> If its missing default to 600. But if its an invalid value, return
> -EINVAL.
> 
> > +		priv->tx_driver_strength = PQSGMII_TX_DRIVER_600MV;
> > +	}
> > +
> > +	priv->package_mode = PHY_INTERFACE_MODE_NA;
> > +	if (!of_property_read_string(shared->np, "qcom,package-mode",
> > +				     &package_mode_name)) {
> > +		if (!strcasecmp(package_mode_name,
> > +				phy_modes(PHY_INTERFACE_MODE_PSGMII)))
> > +			priv->package_mode = PHY_INTERFACE_MODE_PSGMII;
> > +
> > +		if (!strcasecmp(package_mode_name,
> > +				phy_modes(PHY_INTERFACE_MODE_QSGMII)))
> > +			priv->package_mode = PHY_INTERFACE_MODE_QSGMII;
> 
> Again, return -EINVAL if it is neither.
> 
> > +static int qca807x_phy_package_config_init_once(struct phy_device *phydev)
> > +{
> > +	struct phy_package_shared *shared = phydev->shared;
> > +	struct qca807x_shared_priv *priv = shared->priv;
> > +	int val, ret;
> > +
> > +	phy_lock_mdio_bus(phydev);
> > +
> > +	/* Set correct PHY package mode */
> > +	val = __phy_package_read(phydev, QCA807X_COMBO_ADDR,
> > +				 QCA807X_CHIP_CONFIGURATION);
> > +	val &= ~QCA807X_CHIP_CONFIGURATION_MODE_CFG_MASK;
> > +	if (priv->package_mode == PHY_INTERFACE_MODE_QSGMII)
> > +		val |= QCA807X_CHIP_CONFIGURATION_MODE_QSGMII_SGMII;
> > +	else
> > +		val |= QCA807X_CHIP_CONFIGURATION_MODE_PSGMII_ALL_COPPER;
> 
> What about priv->package_mode == PHY_INTERFACE_MODE_NA;
>

I changed this to a switch and added some comments to make this more
clear. We default to PSGMII if package-mode is not defined. (will also
update schema with default value)

-- 
	Ansuel

