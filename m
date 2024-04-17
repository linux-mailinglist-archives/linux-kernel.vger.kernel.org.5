Return-Path: <linux-kernel+bounces-149056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 152608A8B30
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3779285FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D284711725;
	Wed, 17 Apr 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ipL+I8TV"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DE8F51B;
	Wed, 17 Apr 2024 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378848; cv=none; b=eGA/3YkREJaUwh4CogTunBNmMp2WZJKy6zVg0ZUAhEPy7rcBGhu4LHm95Tk0lmcrfmLvVdaZzEEXHxljw0Uy7QysOzqgvkvDXuN3HTrEH64oIMUXDk73tMss0vgYc9wj6/3Rgp8HKCjEpoFZ3bqaJOLxSESyo4M9IHbLpZsB+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378848; c=relaxed/simple;
	bh=6veavc1e9T/l9NoSbIGFrOaQTgn3qFpNCXEWKSehzVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Att7oOr2ZPb9EMpoxNkCDhEmw9daRs8IRPSI0Lx6+NaFX/rOwFad09nZa6+3mxwyByjWx/YqbtYctd/ebxOl9S7qOmPvRlj9dT2vW8ArtpD8NAjxzF35sWLz3xvTbX2yEYDQIJprpagEkOF6nCnm9d6yrssOGhoHBZD6UTRtBlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ipL+I8TV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qyvdskYVnamQI3a/ILIalEumJFvEM9exFz2R/7q+4jE=; b=ipL+I8TVXay+xwWsxLnGcJxNq+
	3MXPVeffIwUTLH4aFqP2fzWB99kP6oLrc3fydU+rNpr2jleE5dV3VCx+y794YXUXnqUhYl9g208Gh
	hm5aTjVvDdsaJfvozWQ84C1ALa7MppKCBaGT9jY22rHzGVmw0tSveXsTpH4kuza9SKH0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxA6E-00DGzN-GY; Wed, 17 Apr 2024 20:33:38 +0200
Date: Wed, 17 Apr 2024 20:33:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v1 1/4] net: phy: Add TimeSync delay query
 support to PHYlib API
Message-ID: <898f435b-99dd-4636-9a52-558780c1bb06@lunn.ch>
References: <20240417164316.1755299-1-o.rempel@pengutronix.de>
 <20240417164316.1755299-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417164316.1755299-2-o.rempel@pengutronix.de>

On Wed, Apr 17, 2024 at 06:43:13PM +0200, Oleksij Rempel wrote:
> Add a new phy_get_timesync_data_path_delays() function, to the PHY
> device API. This function enables querying the ingress and egress
> TimeSync delays for PHY devices, as specified in IEEE 802.3-2022
> sections 30.13.1.3 to 30.13.1.6. The function adds the capability to
> obtain the average delays in nanoseconds, which can be used to
> compensate for time variations added by the PHY to PTP packets.
> 
> Since most PHYs do not provide register-based delay information, PHY
> drivers should supply this data, typically dependent on the interface
> type (MII, RGMII, etc.) and link speed. The MAC driver, or consumer of
> this API, is expected to invoke this function upon link establishment to
> accurately compensate for any PHY-induced time discrepancies.

So your intention is that this function is called from within the
adjust_link callback? Hence there is no locking being performed
because the lock is already held?

> +/**
> + * phy_get_timesync_data_path_delays - get the TimeSync data path ingress/egress
> + *                                     delays
> + * @phydev: phy_device struct
> + * @tx_delay_ns: pointer to the transmit delay in nanoseconds
> + * @rx_delay_ns: pointer to the receive delay in nanoseconds
> + *
> + * This function is used to get the TimeSync data path ingress/egress delays
> + * as described in IEEE 802.3-2022 sections:
> + * 30.13.1.3 aTimeSyncDelayTXmax, 30.13.1.4 aTimeSyncDelayTXmin,
> + * 30.13.1.5 aTimeSyncDelayRXmax and 30.13.1.6 aTimeSyncDelayRXmin.
> + *
> + * The delays are returned in nanoseconds and can be used to compensate time
> + * added by the PHY to the PTP packets.

Please document the context this function should be used in. If users
use it outside of the adjust_link callback, the locking will be
wrong....

> + *
> + * Returns 0 on success, negative value on failure.

I think kdocs now requires a : after Returns ?

> +	/**
> +	 * @get_timesync_data_path_delays: Get the PHY time sync delay values
> +	 * @dev: PHY device
> +	 * @tsd: PHY time sync delay values
> +	 *
> +	 * Returns 0 on success, or an error code.

Same here.

     Andrew

