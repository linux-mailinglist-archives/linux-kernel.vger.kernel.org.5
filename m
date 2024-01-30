Return-Path: <linux-kernel+bounces-44238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E5A841F38
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6BD295787
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EF560DE2;
	Tue, 30 Jan 2024 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ES2iWGBB"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925ED6089C;
	Tue, 30 Jan 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606334; cv=none; b=ofZcUOuPvnv9SFivnRezsGOWl7sCNfQ74ZhHpKmXSTXaLGVIE3oEuhYLrNoYyCB+ZKxZ+iN2vC+kmU2PkTNgokoIwNoJr/yVMzk5y5XYYqYnUlfv+c69yLWu8nt48Lxs2PhG9lIGiSepGqUl/+FLV6FeCq0fu2TolgGk78EnIMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606334; c=relaxed/simple;
	bh=T+QgwgampQETDJNda5F9UsxgSzpjEdFNDMDizKY4OZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZh8TXUwI5NwYkkFBKDBCpo8PH1pW8uA2SfOyifwXRrGb4F0MXYkFmA8W89HHR7AGLanvoxzpkaLNmtT9Ybgnb24k+mu5bRhGcOzatNgmaAR+L2hDdocFmQjZAF3g7Hdu6iBvdGf9sJDaK38ieNrCKF7lTtssfUm17mjgqkRT3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ES2iWGBB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ppSRHczfCYqsFW0Z83JIkYK4TUwJET7+q/2wnNCsxN4=; b=ES2iWGBBKIXFheif3vyFDRwFaI
	T+JgoPdEQ+xg6FZ7obnV/wVxh1g5kqHi7DhXtTYkH8EdOHsadZ3+dE984LC30O9sSLDJPUYrWH2H5
	Vjs0yxNsuIQgCc7D9/xdp4o9ZGhFRvRVwKCRk5+1h43Tnp5qxJqnQTqpdu0staoJFIV2Ph71ZA5ed
	xmJ+G37a7Pe7yR7YbXScjeldXLYM+fOhadRlScQszsYvJZJVy4KY7CT/Co5d+MTw4f3miSqZ83f70
	oo5ZZ0FVK+wWf7uHkJnK6ra48cjLuRRZFFW6e4d3mBIM3TTF6WfVkNyu4q6cSq2zfTrguyV/qVZU1
	4hrYbGlg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35996)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rUkGJ-0001Uj-1t;
	Tue, 30 Jan 2024 09:18:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rUkGG-0005OD-2R; Tue, 30 Jan 2024 09:18:32 +0000
Date: Tue, 30 Jan 2024 09:18:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 net-next 08/13] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Message-ID: <Zbi+5ymzbL9sckdi@shell.armlinux.org.uk>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122212848.3645785-9-dima.fedrau@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 22, 2024 at 10:28:41PM +0100, Dimitri Fedrau wrote:

	int tmp;

> +	switch (attr) {
> +	case hwmon_temp_input:
> +		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
> +				   MDIO_MMD_PCS_MV_TEMP_SENSOR3);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ((ret & MDIO_MMD_PCS_MV_TEMP_SENSOR3_MASK) - 75) * 1000;

		tmp = FIELD_GET(MDIO_MMD_PCS_MV_TEMP_SENSOR3_MASK, ret);
		*val = (tmp - 75) * 1000;

> +		return 0;
> +	case hwmon_temp_max:
> +		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
> +				   MDIO_MMD_PCS_MV_TEMP_SENSOR3);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = (((ret & MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK) >>
> +			MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_SHIFT) - 75) *
> +			1000;

		tmp = FIELD_GET(MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK,
				ret);
		*val = (tmp - 75) * 1000;

> +		return 0;
> +	case hwmon_temp_alarm:
> +		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
> +				   MDIO_MMD_PCS_MV_TEMP_SENSOR1);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = !!(ret & MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT);
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int mv88q2xxx_hwmon_write(struct device *dev,
> +				 enum hwmon_sensor_types type, u32 attr,
> +				 int channel, long val)
> +{
> +	struct phy_device *phydev = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_temp_max:
> +		if (val < -75000 || val > 180000)
> +			return -EINVAL;
> +
> +		val = ((val / 1000) + 75) <<
> +		       MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_SHIFT;

		val = (val / 1000) + 75;
		val = FIELD_PREP(MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK,
				 val);

.. and therefore no need for the _SHIFT constants.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

