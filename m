Return-Path: <linux-kernel+bounces-50545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C1E847A82
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463601C269B2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185CF8174E;
	Fri,  2 Feb 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AGmPciXs"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3D580601;
	Fri,  2 Feb 2024 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706905582; cv=none; b=EyAEe4CEt/02Sn+7YsSztl2yimH5tiIVjVZp0CtS2+zhTfKGl6GJjwWqT1YJRHPRO0AwqFXk1q0KwZWbA5sgKEcpKFWK4LCIQ2njV7spIgARR+htUmErLfQIdfjuQLlm5yDSYbAvOg7v+uWVyfVLdHrZ8tX4KHMDL0L6qEpS5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706905582; c=relaxed/simple;
	bh=VcZTs2Gq08PlBskokPhLEf4TRhE+oKA4D1KkVs9TtsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqdMzA1UAW4kBnG5rrj/zJrhizFy1YfXF5ZLj9oWRfOh18olrF3wnTAcMrk27Fmmz9VgX4GKrPZDT9GR5eJDQvUJnxdXc+d9nFBXeULYNMXhqB+gT5J5irfj7VamDGpxVCKev3kctLUB6w+lDBgeuLnX/sjNyqYyXTKlBTNp/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AGmPciXs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=WGnc/m8wZ5VekXMjEDlGv2LgOYZxP0Ar/ku6T9fE9Us=; b=AG
	mPciXsoxeRmPl2pgCQEew0vyueQo9nP5a9cQdrR+vatsm8Rr4aFOl3MqKSocFSSE/Orl8uXD6DN+s
	tZ17BYJL9sHXLLpXE/s7ECOaxX/7daK9ZtTjQDXczWjFuEWK588nEvNGnj111BYTG/AaTEMBvnC6b
	+BzMRtZQ4btiEDE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rW06l-006qZX-8r; Fri, 02 Feb 2024 21:25:55 +0100
Date: Fri, 2 Feb 2024 21:25:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/7] net: dsa: mt7530: empty default case on
 mt7530_setup_port5()
Message-ID: <59e88b15-da57-4cff-83b3-91e38a185461@lunn.ch>
References: <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
 <20240202-for-netnext-mt7530-improvements-2-v3-1-63d5adae99ca@arinc9.com>
 <ZbzUotyQm/FyKK7G@shell.armlinux.org.uk>
 <e3b4add6-425c-46ca-9da5-8713055fc422@arinc9.com>
 <Zb0u8NY0q6ay17j5@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zb0u8NY0q6ay17j5@shell.armlinux.org.uk>

On Fri, Feb 02, 2024 at 06:05:36PM +0000, Russell King (Oracle) wrote:
> On Fri, Feb 02, 2024 at 08:44:39PM +0300, Arınç ÜNAL wrote:
> > On 2.02.2024 14:40, Russell King (Oracle) wrote:
> > > While reviewing this change, but not related to it, I notice that this
> > > function sets the TX delay based on the RGMII interface mode. This isn't
> > > correct. I've explained why this is this many times in the past, but
> > > essentially it comes down to the model:
> > > 
> > > 
> > > phy-mode in NIC node	Network driver	PCB		PHY
> > > rgmii			no delays	delays		no delays
> > > rgmii-id		no delays	no delays	tx/rx delays
> > > rgmii-txid		no delays	no delays	tx delays
> > > rgmii-rxid		no delays	no delays	rx delays
> > > 
> > > Then we have rx-internal-delay-ps and tx-internal-delay-ps in the NIC
> > > node which define the RGMII delays at the local end and similar
> > > properties for the PHY node.
> > > 
> > > 
> > > So, if we take the view that, when a switch is connected to a NIC in
> > > RGMII mode, then the phy-mode specified delays still should not impact
> > > the local NIC.
> > > 
> > > Now, for the switch, we specify the phy-mode in the port node as well.
> > > Consider the case of a switch port connected to a RGMII PHY. This has
> > > to operate in exactly the same way as a normal NIC - that is, the
> > > RGMII delays at the port should be ignored as it's the responsibility
> > > of a PHY.

Not quite. It is unusual, but there are a few MAC drivers which do act
on phy-mode, to configure MAC delays. However, if they do this, they
then mask the value of phy-mode passed to the PHY in order to avoid
double delays. Its not something i recommend, we prefer the PHYs do
the delays. And it something i strongly suggest we avoid in DSA.

> > > The final scenario to examine is the case of a RGMII switch port
> > > connected to a NIC.

This should also extend to a port connected to a port of another
switch. For Marvell switches, these are so called DSA ports.

> > > The NIC's phy-mode has no way to be communicated
> > > to DSA or vice versa, so neither phy-mode can impact the other side
> > > of the RGMII link, but should only place the link into RGMII mode.
> > > Given everything I've said above, the only way to configure RGMII
> > > delays is via the rx-internal-delay-ps and tx-internal-delay-ps
> > > properties. So, DSA drivers should _not_ be configuring their ports
> > > with RGMII delays based on the RGMII phy interface mode.

Marvell goes against this. rx-internal-delay-ps and
tx-internal-delay-ps are pretty new, when compared to the age of
mv88e6xxx. I had the problem of a FEC connected to an mv88e6xxx using
RGMII and i needed to somehow configure RGMII delays, or packets did
not get through. So mv88e6xxx will apply phy-mode to ports being used
in CPU or DSA mode. So in the case of the FEC->switch, rgmii-id is
used by the switch. For DSA->DSA, there are DT blobs with rgmii-txid
on both ends of the link, which results in the needed delays.

> > > The above is my purely logically reasoned point of view on this
> > > subject. Others may have other (to me completely illogical)
> > > interpretations that can only lead to interoperability issues.

Now that rx-internal-delay-ps and tx-internal-delay-ps actually exist,
these are the best ways to handle such delays, for new drivers. But we
cannot change old drivers without causing regressions.

       Andrew

