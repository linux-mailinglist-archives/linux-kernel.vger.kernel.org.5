Return-Path: <linux-kernel+bounces-131723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88438898B14
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425102848CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CE684FDF;
	Thu,  4 Apr 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="VEDjnj55"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75051BC57;
	Thu,  4 Apr 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244405; cv=none; b=gEMbVudtbCRR6dEEPFZqpchKeq15bnr2grLRcQfk+TZ/iZorLNkI/josukxGMJV6+SGRAhZv8UrgMhVGzehFXEMd0N/pgj+Ng4DEfl3VUVqyyQbD0wVu7++HBR/rtUcffg1owHyjDwUVL8AQrXws9PvV5a+ewZm85p3S6nApOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244405; c=relaxed/simple;
	bh=PFoS6hGk1IYChkt0D459qrPjdqLmDhjdygszllD3YAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwgNCltLrC/5yyXv6KuLEU65/Fqowg+Apzeq2pgsyAnc7nKtCAMkzN9cDzM7BC5PpXeTeaDt/6PO00hbIlq8E8oYbRqoa3FWOb23L1lGrc8NTvtPbW5Sn9gys+crIed5WV+NR4ajxzcgrkZ79Y5cmzFy6up7lTpIfSMaeRXEhVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=VEDjnj55; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1712244400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nx5b7zK0NZWAaBwpJhf7wUMpMip3NAQgikWPRpdfU/s=;
	b=VEDjnj55HYYX44F3SuiljmNJkHo5+iLbvSgua8D3T4kwvjS+DkWwii4Kr/mnD+9v0XBEKI
	BRh7vcE0eA7VaS8dN1L8R2GPwciFFrb0ONJa3xiFeRPzPhjM7kgibR7/tXdRNeSSr86Wi3
	0ZSPD910rVrxnRdAAjbchIysPPJQTyHjofD7U+mYM4ruorO56lB2AIMyeikNpPW01BEBOl
	aBncoK0NemwlH5GiCG/yleySg9yGf7idy/ctsUKunshPNUXeBbCs7wat/d8YPAsOMHKzdW
	4h1vhIN6mg2Thnzmt+P0WFSeY2rxGaWxVo84PzM5ROZ3LqqbLWC51zTYyuaE0g==
From: Diederik de Haas <didi.debian@cknow.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-rockchip@lists.infradead.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 David Jander <david@protonic.nl>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: add Protonic MECSBC device-tree
Date: Thu, 04 Apr 2024 17:26:29 +0200
Message-ID: <4371633.n8APD0IoSg@bagend>
Organization: Connecting Knowledge
In-Reply-To: <9d325b4e-031c-4f6c-9788-fa5a68470efa@lunn.ch>
References:
 <20240404-protonic-mecsbc-v1-0-ad5b42ade6c6@pengutronix.de>
 <20240404-protonic-mecsbc-v1-2-ad5b42ade6c6@pengutronix.de>
 <9d325b4e-031c-4f6c-9788-fa5a68470efa@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1929697.ULixQHqF2j";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart1929697.ULixQHqF2j
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 04 Apr 2024 17:26:29 +0200
Message-ID: <4371633.n8APD0IoSg@bagend>
Organization: Connecting Knowledge
In-Reply-To: <9d325b4e-031c-4f6c-9788-fa5a68470efa@lunn.ch>
MIME-Version: 1.0

On Thursday, 4 April 2024 17:10:41 CEST Andrew Lunn wrote:
> > +&gmac1 {
> > +	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
> > +	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru
> > CLK_MAC1_2TOP>; +	phy-handle = <&rgmii_phy1>;
> > +	phy-mode = "rgmii";
> > +	clock_in_out = "output";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&gmac1m1_miim
> > +		     &gmac1m1_tx_bus2
> > +		     &gmac1m1_rx_bus2
> > +		     &gmac1m1_rgmii_clk
> > +		     &gmac1m1_clkinout
> > +		     &gmac1m1_rgmii_bus>;
> > +	status = "okay";
> > +	tx_delay = <0x30>;
> > +	rx_delay = <0x10>;
> > +};
> 
> There was a discussion about phy-mode = "rgmii"; and these
> tx/rx_delays last month. Please could you go read that discussion and
> them make use of rgmii-id, and change the delays.

https://lore.kernel.org/linux-rockchip/20240304084612.711678-2-ukleinek@debian.org/
titled "[PATCH] arm64: dts: rockchip: qnap-ts433: Simplify network PHY connection"
--nextPart1929697.ULixQHqF2j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZg7GpQAKCRDXblvOeH7b
bikgAQDxjNxJBtSfyXYuHl2r99LKDknNDnlaMsWaOdSg4gJNTgD/Uz5yWKZKbPYB
F61sFHT10aYaICXDOe/OgVF1lODpWQM=
=boHv
-----END PGP SIGNATURE-----

--nextPart1929697.ULixQHqF2j--




