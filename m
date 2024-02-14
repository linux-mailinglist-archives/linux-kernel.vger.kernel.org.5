Return-Path: <linux-kernel+bounces-65634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C81854FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BE72854CD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287577E101;
	Wed, 14 Feb 2024 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4mD7JZfK"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79C6A002;
	Wed, 14 Feb 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931035; cv=none; b=jHyaLBSkOPza+vkr2GRzTqXsOmM2NRBWj9orv665H7SuufvHG1oHJH4d3Y5L+wR4+0w1ewToOOe1XnTSM/5UsnvjJl1j+rkkmv+Mn9aImLXQ3uonPSb6R8s1Dqj6CgApnF3R3I+ys0C1NUTAmck06WZi0ye6i4ZR+YEI281ww6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931035; c=relaxed/simple;
	bh=UTA6dQy4agQnhswSzw36oVcafU0M4bUjEInWDdi20YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXFZ2Wmapvgj1Co9N4EsGOuNFFZPG09GvKOu+6C1niCc+bKg8EMe9lNrjym3HuLg4J5X9BIXRB/ThGtls5tYXjmN6QbUt2+h3gAIhNeO8wcJv71etEozmPJecjDDABxcDx62jCefUm25aRI9uXquPb16480fbILua4v6/FTIZsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4mD7JZfK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iHkPVLSwZQNhDPIR6Y51dQVDy9dx3m/6H3kSC/CtpmM=; b=4mD7JZfK4F/xZNeENZHCJjuoj2
	QpqHJlsJ458khDQPjrNaho9B/2LKr33dqpE6/YY97ygqb6nvsk2DlL2og7GITKsACYXswhTdqhm6E
	sVJ2RJ8yDp3vXaudJcpUhF8LHkMCW7YkQKVuBXdD1MdT/wfzXuN0jyQHVVsmrD6H6hgE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raIsd-007o93-Re; Wed, 14 Feb 2024 18:17:07 +0100
Date: Wed, 14 Feb 2024 18:17:07 +0100
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
Subject: Re: [PATCH net-next v3 02/17] of: property: Add fw_devlink support
 for pse parent
Message-ID: <6ed80613-bd9b-44fd-828c-c3caa0e186bd@lunn.ch>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-2-531d2674469e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-feature_poe-v3-2-531d2674469e@bootlin.com>

On Thu, Feb 08, 2024 at 02:08:39PM +0100, Kory Maincent wrote:
> This allows fw_devlink to create device links between consumers of
> a PSE and the supplier of the PSE.

It will be interesting to see how this turns out. fw_devlink often
gets itself into knots with MAC and PHY dependencies sometimes being
circular. If we get a PSE on an MDIO bus, this is going to get even
more interesting.

> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

