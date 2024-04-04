Return-Path: <linux-kernel+bounces-131681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ABD898ABF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112F91C25B4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EDF12AAD7;
	Thu,  4 Apr 2024 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ILKd5cbz"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577191D543;
	Thu,  4 Apr 2024 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243453; cv=none; b=sVcDNNO72+ILzMtuVDhkORiA82V7izjvmNPBvs5RAaVuRSQmAztmmXniR/FEoA4xdRh+XnJxscW10+6oFvqQ/pP8jLPHIlOWjGSsPaOceQxMZhmsOWFm1DIRwsRyf/jevpDC+UVkoJujzm0WVDMU7CTFdI51BnVATRpzo5YyCo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243453; c=relaxed/simple;
	bh=DUPMyZ/xTsclqJcgpP/qVJGgpzSu7G7XOnc2Q+6j4DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbHa6k+Z8frATv8qRx7I0lHPM20m/EBvh6K4rQzTTaMtN/6UVMG8V11OSJmXLlQgadi58c5lcCAb071hHCeUhCUlCDGcu9ZSaHCchc1ieHp7YJIlE4vQFXaZInub2jf1sf7OL2pLZNq0/yItNB6j5XVxZOy5EagEGq7JTn5ZqiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ILKd5cbz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s98YOMLip/viIAxMH0MZuJz4Cxd3gdWcic10eltssBY=; b=ILKd5cbzcuFB5csUzEM688wtcZ
	gM85mlwHCTKiS1EtgUIeftyAozV/j2FYv6T0fDkWvjjMNrtiGCg6Yy0YEPZw9LnCX/LRaLAynjzDU
	ogZEG/XF4yVRPzx9pTZ0o5AhfYNSpNTAofzdWEyopqvGCOKD1cpfm2eDcYK6fwwBv2F8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsOjh-00CC5o-Ue; Thu, 04 Apr 2024 17:10:41 +0200
Date: Thu, 4 Apr 2024 17:10:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: add Protonic MECSBC device-tree
Message-ID: <9d325b4e-031c-4f6c-9788-fa5a68470efa@lunn.ch>
References: <20240404-protonic-mecsbc-v1-0-ad5b42ade6c6@pengutronix.de>
 <20240404-protonic-mecsbc-v1-2-ad5b42ade6c6@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-protonic-mecsbc-v1-2-ad5b42ade6c6@pengutronix.de>

> +&gmac1 {
> +	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
> +	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru CLK_MAC1_2TOP>;
> +	phy-handle = <&rgmii_phy1>;
> +	phy-mode = "rgmii";
> +	clock_in_out = "output";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1m1_miim
> +		     &gmac1m1_tx_bus2
> +		     &gmac1m1_rx_bus2
> +		     &gmac1m1_rgmii_clk
> +		     &gmac1m1_clkinout
> +		     &gmac1m1_rgmii_bus>;
> +	status = "okay";
> +	tx_delay = <0x30>;
> +	rx_delay = <0x10>;
> +};

There was a discussion about phy-mode = "rgmii"; and these
tx/rx_delays last month. Please could you go read that discussion and
them make use of rgmii-id, and change the delays.

Also, where did you copy this from? If possible, it would be good to
fix the example everybody copies into new DT blobs.

	Andrew

