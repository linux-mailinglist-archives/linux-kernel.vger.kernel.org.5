Return-Path: <linux-kernel+bounces-71938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4422E85ACC3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E84288AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFE752F65;
	Mon, 19 Feb 2024 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZdAaJRaG"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F63171B1;
	Mon, 19 Feb 2024 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373035; cv=none; b=k1MCSJLW8ZjVS+sidebay5OUMg8dhOgkT9Y8jgdgArEqjSveP4MJbD1U0Ao+uPLqhgcLD4Q/mZDNe4uHFy0cQaGsxngF+1bcQSnLwk1tvBkVtCNO645Jiiuokj0SLJcZNN5ad3cORzo1UgSPuHhjfkq0GqxeacKuV7KBsSsSPXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373035; c=relaxed/simple;
	bh=Q6YX/nSHF4SXTGacODXfDERzSEGJdnmUdA5aLHPu76Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hphvVitcdkcLxp9in6NTC4G7T4mK7UE5MNfF7K5tEY0J67CDSqZSFTtZvhqoDgMHR+orA+B1hypg6/KU7Uoglk6v/JglFouwr5nCKkneNjalEB01W9tKrqeCd5HIFRFJ7cmVtFakhFqbVzEMLLNQM0qilMWIPRATayRnXdZEjNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZdAaJRaG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b3vT0nj23S7kHYz1QGiFYSw/NcYxj4aBnJ8NurX22FU=; b=ZdAaJRaGQbRxNrO/+Xdsmr4dAx
	WqYljqcOZJCp/xKXCpmOtEYHPB8XI1PqLcLPQvyXk6Oc2wm3xCkDWfLd2zInMBj8hBYIgKPLSgjkc
	Wsv8Vcu0H/ojbimN41axCR0dSavCT2HpOJWOcgHfhR2dCh3/dQz/b52XotOJ1x2KxG2w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rc9rd-008EF1-Bf; Mon, 19 Feb 2024 21:03:45 +0100
Date: Mon, 19 Feb 2024 21:03:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: forbidden405@outlook.com
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/6] net: hisilicon: add support for
 hisi_femac core on Hi3798MV200
Message-ID: <29fc21f0-0e46-4d0f-8d4b-c4dbd1689c55@lunn.ch>
References: <20240220-net-v3-0-b68e5b75e765@outlook.com>
 <20240220-net-v3-3-b68e5b75e765@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-net-v3-3-b68e5b75e765@outlook.com>

> Note it's unable to put the MDIO bus node outside of MAC controller
> (i.e. at the same level in the parent bus node). Because we need to
> control all clocks and resets in FEMAC driver due to the phy reset
> procedure. So the clocks can't be assigned to MDIO bus device, which is
> an essential resource for the MDIO bus to work.

What PHY driver is being used? If there a specific PHY driver for this
hardware? Does it implement soft reset?

I'm wondering if you can skip hardware reset of the PHY and only do a
software reset.

	Andrew

