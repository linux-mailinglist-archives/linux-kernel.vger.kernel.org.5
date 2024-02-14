Return-Path: <linux-kernel+bounces-65667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1A8855036
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461F01F21DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97CC1272D0;
	Wed, 14 Feb 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rwfZs9CA"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84212BE95;
	Wed, 14 Feb 2024 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931377; cv=none; b=HTbJVJjx8Xhq+vECZBAgQEhP0MRaMefdhDNBLmFPF5BTe/H5aF6ZxjAWL/+d8r/4nRFTJ2eHBryAvTFgYzFIlJ3B0o6ontz7K64cOpUAjSaq44lNZ6O1nMrAi304Jf0dgIQVV/dc+gFWkuPSct0K7WvQvGenaXtbF8Ssjim1HBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931377; c=relaxed/simple;
	bh=rozQICxhmctv2GzNoaOEIQYgEhph8grqZaAtWGhxx94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbytRIhlRiLA3CtLEmhM130J+LzK9kvTrXJLeezRQXxuAPmQbaiJ2MXUHTfoJfEEAvd74dPd7yzps3aSgkqtnGAIiJMoajNZmEII0YMqQKszw+s4MNeXeV4P7AVUrc05xj4TqnO9JuUIuN4qhZbfVk/mDyVUxFciYsHr8uqSscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rwfZs9CA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CGXTYQZVVr0cZ4QoeJoakk9XcwslsKhvBOR/3u3KHDU=; b=rwfZs9CAmsndcBVVbkBMk5ppz3
	b5NX9WKw56BMCBYB6qsq+W4iJCjtyciJ7Q7ef34/p8lVHt2OaLgeUTz/JnVS4CtLZzSFJf+AhAttY
	fb31h8dmURcY4IqVWeXM2H5YGJ+s2mD+9PcwgE4CvGhtUGriqGoz1Rl5F1Veb4sFxeSY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raIy7-007oCH-FH; Wed, 14 Feb 2024 18:22:47 +0100
Date: Wed, 14 Feb 2024 18:22:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 08/17] netlink: specs: Expand the pse netlink
 command with PoE interface
Message-ID: <d33383da-446a-4b92-930a-d601a7af9997@lunn.ch>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-8-531d2674469e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-feature_poe-v3-8-531d2674469e@bootlin.com>

On Thu, Feb 08, 2024 at 02:08:45PM +0100, Kory Maincent wrote:
> Add the PoE pse attributes prefix to be able to use PoE interface.
> 
> Example usage:
> ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get \
>              --json '{"header":{"dev-name":"eth0"}}'
> {'header': {'dev-index': 4, 'dev-name': 'eth0'},
>  'c33-pse-admin-state': 3,
>  'c33-pse-pw-d-status': 4}
> 
> ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-set \
>              --json '{"header":{"dev-name":"eth0"},
> 		     "c33-pse-admin-control":3}'
> 
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

