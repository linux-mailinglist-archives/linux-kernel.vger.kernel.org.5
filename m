Return-Path: <linux-kernel+bounces-164773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47FD8B82AD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFB81F2409D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3721BF6F5;
	Tue, 30 Apr 2024 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Sbv0F32G"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1A5129E72;
	Tue, 30 Apr 2024 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714516084; cv=none; b=MtwlwYNaTkaw4s1PmC3XEdjNUiAB2Ty4X9BkARNN/EQ4mluLNfDo2TWRYUhAbt0CHwStlmNOXLQUmqWlwh9QX2DjDUGYY0KE7TXYH43SmO3A+1qIcePmWqwil+JSKHR2+vFgWEPyb0+V31C4Xzlc3AEbMup/7bwfKgV5CA41MlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714516084; c=relaxed/simple;
	bh=nCJ0j4T5hcnbSsOaAdtHnGckQLLph1fsGdcwW2w7Eh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRn5aufRPn/zFXNa6+RVqV4ItliGUMNluAdRVD4Seth5xuQhWV9jEqxVjW2gcv2MasHzhCzMWfuQ4a+BYNHr88gl+hQh+XiEXWHyfwVH3PoN3yhJYuFHisQ3oUyki0kgCQOPz6aMHorOwuUL1Puqd7c5iz5pWn1I0gw7XI2ByUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Sbv0F32G; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Yo2VxZsGCYZGIZ1iS7RdDXRNSVG5Zc5WRZQlm2xWZTE=; b=Sbv0F32G1WJNqNmKwl+BjKKsjQ
	taUGuGreIgQM9ex/bGom+ZIufrHq9cCJaxAesAVLWX6DGD1wGTkwDhgAmAoCWT6hA3ydUCtoBuJQH
	f8dcr4IJ4crgFIuFqGHD+53AX8Dv851y/23Biae8UyIlQ2LI7Xup/FPxZpb/Fk8DS72UIqo+SZlUP
	6rLCVSsNDYrFqJeOIv7y4FZumdk3EMzJK/kRiyTh7pmRhIVy7q8EhKpolwlAzyyIDZfJx7K/oTQs4
	mSUw/kdbzh9CEmZou3JB7gYXwv56kT03R/2iQu09ICUUGoxOceImRJe2YCQzTbAH4A++ODwbT/jhC
	wsyWSVYQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58144)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s1vwn-0005Zf-0r;
	Tue, 30 Apr 2024 23:27:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s1vwh-00027o-L9; Tue, 30 Apr 2024 23:27:31 +0100
Date: Tue, 30 Apr 2024 23:27:31 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Felix Fietkau <nbd@nbd.name>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
Message-ID: <ZjFwU24kReNJHKdY@shell.armlinux.org.uk>
References: <11f5f127d0350e72569c36f9060b6e642dfaddbb.1714514208.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11f5f127d0350e72569c36f9060b6e642dfaddbb.1714514208.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 30, 2024 at 11:01:17PM +0100, Daniel Golle wrote:
> +	/* Only MDIO bus address 7, 15, 23 and 31 are valid options */
> +	if (~(mdiodev->addr & 0x7) & 0x7) {

So the common thing about the three addresses you mention are that they
all have the least significant three bits set. So I'd suggest to spell
that out in the comment:

	/* Only MDIO bus addresses 7, 15, 23, and 31 are valid options,
	 * which all have the least significant three bits set. Check
	 * for this.
	 */

The test here is also not obvious, so I would suggest:

	if ((mdiodev->addr & 7) != 7) {

which is much easier to read and ties up with the above comment.

> +		/* If the address in DT must be wrong, make a good guess about
> +		 * the most likely intention, and issue a warning.
> +		 */
> +		int correct_addr = ((((mdiodev->addr - 7) & ~0x7) % 0x20) + 7) & 0x1f;

Huh? Again, not obvious what this is doing. So, I threw this into a C
program that wraps the thing in a for() loop from 0..31 to see what it
produces.

addr range	result
0-6		31
7-14		7
15-22		15
23-30		23
31		31

Is it really sane to be suggesting "31" for values 0-6 ?

> +
> +		dev_warn(&mdiodev->dev, FW_WARN
> +			 "impossible switch MDIO address in device tree: %d, assuming %d\n",
> +			 mdiodev->addr, correct_addr);
> +		mdiodev->addr = correct_addr;

Sorry, but no. You must not change the mdiodev address. The address
member is used to index arrays in the MDIO bus, and changing it will
end up corrupting those arrays.

For example, when a MDIO device is registered:

	mdiodev->bus->mdio_map[mdiodev->addr] = mdiodev;

when it is unregistered:

        if (mdiodev->bus->mdio_map[mdiodev->addr] != mdiodev)
                return -EINVAL;

will fail, and a dangling pointer will be left at the original
address. Moreover, the reset control (if any) will not be put.

If the MDIO device address is wrong, then you can either fail or
maybe create a new mdio device with the correct address - but the
latter may get quite icky from a coding point of view. You would
have to tear down this other device when the original incorrect
one is unbound from the driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

