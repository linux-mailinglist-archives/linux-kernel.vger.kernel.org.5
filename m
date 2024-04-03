Return-Path: <linux-kernel+bounces-129898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAF28971D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE5C1C25BB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A4F148FF5;
	Wed,  3 Apr 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="h1JTmxNw"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF80147C78;
	Wed,  3 Apr 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152798; cv=none; b=gEHtL7rhnljZtRqBAPPGjXLMp6UcK5IocL6Nk8cf2GyXLAy2M5LPb7Clmpr6U/MxmkQTaFn9nUWatbk7YHL1wpxQjjKn1KWa4PmSDwLeo2pmfoyMFPp/p9fbtkaq4rf86EYfswhcIq8gntx2Wd/Zwz0ghKWkzS74MgeCoLrP/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152798; c=relaxed/simple;
	bh=KbRzx5XXfKnY8b5mVC12BtJ8f70M3XHiILrAjyEucgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2uT0MY79vmk7tNo6yG861JYAmzJ7CB+P0o+YkkVG4777alBwTVqcnx89phi95qeyJXLd4j1nqdycstpdZI699HhZwaMe0bAa1c3xnmvZuUkfdKfcpByaFFbSNQ4+7rQXzVD8Mps+nPriq9zzUp46dHhIdxJgAdbRwOhOueP8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=h1JTmxNw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/sOckFOI1CXRAFgRsMvp6BVKsbI76bkKaQbhxYgnpCc=; b=h1JTmxNwIFKbz08jp5o7MxRNlC
	gpppGK7pOuBF2WPM/h3EhVAfUK36x9i/8+7rHLDQfYHPMXev/J4itbd6cQFENfJkQd+2Myv6e0nRF
	y5mP5Y+xc+0o2lBb/tBZmGJtIaDc2UTZ/wofV7PVf0y3DfBM/Py+BCcHpqIBhRZae9AcHbQohyPNc
	beVR6pfgGzqzCEZbDYVK7Cr2859pcr9YOrd1Ji/3/IRUZn9EoBmaMxO6oihutYUBmByw7Tj7T6S7I
	2TFsEAseZHbNQQimiNSYyG01B2PBSXFNp0QXRE/zAbRE1ari+nQT5RCiz0IDeJ3s4uhf8JeEFW2jH
	7NA/t7kA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48386)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rs19P-0008Tb-20;
	Wed, 03 Apr 2024 14:59:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rs19N-0007zX-CV; Wed, 03 Apr 2024 14:59:37 +0100
Date: Wed, 3 Apr 2024 14:59:37 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
	alexander.stein@ew.tq-group.com
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: add support for Rev B1 and B2
Message-ID: <Zg1gycEDL4llYrjI@shell.armlinux.org.uk>
References: <20240403-mv88q222x-revb1-b2-init-v1-1-48b855464c37@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403-mv88q222x-revb1-b2-init-v1-1-48b855464c37@ew.tq-group.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 03, 2024 at 03:45:22PM +0200, Gregor Herburger wrote:
> +static int mv88q222x_revb1_revb2_config_init(struct phy_device *phydev)
> +{
> +	bool is_rev_b2 = phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB2;
> +	int ret, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mv88q222x_revb1_init_seq0); i++) {
> +		/* Rev B2 init sequence differs compared to Rev B1. As noted in Marvell API:
> +		 * Remove the instruction to enable TXDAC setting overwrite bit for Rev B2.
> +		 */
> +		if (is_rev_b2 && mv88q222x_revb1_init_seq1[i].regnum == 0xffe3)
> +			continue;
> +
> +		ret = phy_write_mmd(phydev, mv88q222x_revb1_init_seq0[i].devad,
> +				    mv88q222x_revb1_init_seq0[i].regnum,
> +				    mv88q222x_revb1_init_seq0[i].val);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	usleep_range(3000, 5000);
> +
> +	for (i = 0; i < ARRAY_SIZE(mv88q222x_revb1_init_seq1); i++) {
> +		ret = phy_write_mmd(phydev, mv88q222x_revb1_init_seq1[i].devad,
> +				    mv88q222x_revb1_init_seq1[i].regnum,
> +				    mv88q222x_revb1_init_seq1[i].val);
> +		if (ret < 0)
> +			return ret;
> +	}

I think a helper would be useful to write these sequences, rather than
writing the same code several times:

static int mv88q2xxx_write_mmd_vals(struct phy_device *phydev,
				    const struct mmd_val *vals, size_t len)
{
	int ret;

	for (; len; vals++, len--) {
		ret = phy_write_mmd(phydev, vals->devad, vals->regnum,
				    vals->val);
		if (ret < 0)
			return ret;
	}

	return 0;
}

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

