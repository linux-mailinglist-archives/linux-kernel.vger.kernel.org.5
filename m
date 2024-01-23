Return-Path: <linux-kernel+bounces-36181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ADA839D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E320F1C2210F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74D25466F;
	Tue, 23 Jan 2024 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d3OhwnX3"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9D53E1C;
	Tue, 23 Jan 2024 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051748; cv=none; b=lPNI8Q8B2YCR2Dr8a3krfVHycBuuBYi8GLxRkpNIw9iJYOiFixkRMyGb79PxGtO1afEBCFInDG8SLwTSTTH80cSLg1FEZ9KZjVM7ZT2iPH3My/0yN3uu4vS0nejJKjWK3Xt1vgCONLY+w49B0WxLgkwVzqWg4MU4xenLomofN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051748; c=relaxed/simple;
	bh=LclThSWSXCP8WshLZDE4E3mbffplgTTs9CoE7Jd/VJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRVBgIYItdk2+3lbzvE3jStTuPSjEQu47fzzpyYpjtSmefTHI29W4oKN4nVHUpmB+wA6U7etlcHrF7vibasVhLlkxe2q4WdJL9qgNVendZeNxIA0TQjkFiE5/Z3W3WUOObd+kblCDshHmnUaoC+ABJBUftGRqwPClGYQtP1C7tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d3OhwnX3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7yX5+XCrARod+VsoOp+tq6jnm8t8QU2YLMp+hsOIWWk=; b=d3OhwnX3Vuxy17BtXJOMDM36JV
	ooC8IcgtZCGs4yIn/8R2LlAh2pKkLVmTZsRqKetcoqJG3C109ilqxUjwDIQIY0jq9shUqNXbIXS86
	P/uLuyzEC9ryf7SUfoR71L7HyQZ5b6vhFmTypOlMLhaDQ/zvfn8RZUpVZ7eatF98x2To=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rSPzV-005t58-FR; Wed, 24 Jan 2024 00:15:37 +0100
Date: Wed, 24 Jan 2024 00:15:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyang Huang <hzyitc@outlook.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	richardcochran@gmail.com, p.zabel@pengutronix.de,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/8] net: phy: Introduce Qualcomm IPQ5018 internal PHY
 driver
Message-ID: <5ce729ad-549a-48f6-b261-ee8cb91e6474@lunn.ch>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556D5568546D6DA4313209EC9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <2c6c0d72-5d4e-4ec4-beb6-d30852108a67@lunn.ch>
 <TYZPR01MB5556D035D9A13962844BB553C9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <e1fd863a-6725-4180-8ad3-faeb44c09238@lunn.ch>
 <TYZPR01MB55567CE79D7F08C738A81683C9742@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR01MB55567CE79D7F08C738A81683C9742@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>

> After rechecking the vendor code, you are right. The only special thing of
> this device is that it's a combined device of UNIPHY and at803x general phy.
> So it needs the UNIPHY initialization sequence. But for the PHY part, it's
> almost same as others, just has some special registers. I will merge it into
> at803x driver.

The UNIPHY is a separate driver, its a generic PHY driver? Can we keep
them separate for this internal PHY as well?

The initialisation sequence is what is going to be most 'interesting'
here. How UNIPHY, this PHY and the GCC all come together to make it
work. But for the moment, i think its best the PHY driver controls its
own clock input and reset, using standard Linux APIs, once the driver
has probed via compatible IDs.

       Andrew

