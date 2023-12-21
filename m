Return-Path: <linux-kernel+bounces-8159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D2081B2D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E645E282B41
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BB724A0B;
	Thu, 21 Dec 2023 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5nBjTP3K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEF7374EB;
	Thu, 21 Dec 2023 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y027PhXaDTDY+uMBG9rt3+/y14lHqlBNIn0ihc9JSgw=; b=5nBjTP3KWHz4k63XbZaa7jPDhX
	H9HSFbajV1o8xbR31GGbXuA/vtmb0JF8U4nUWtvmJkFmefvN8Pfps+pXYFtmGVBqqOXPaoBz1ICuw
	IN23Xpkj3azioxiT1Jf1S7LNNvOfllUORbOxavYoMLcZaVC0xkIubTdEIKWd7X6/K78s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rGFbb-003Ut5-9l; Thu, 21 Dec 2023 10:44:39 +0100
Date: Thu, 21 Dec 2023 10:44:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] net: phy: marvell-88q2xxx: add driver for the
 Marvell 88Q2220 PHY
Message-ID: <c3addf0d-3693-41ef-9f8f-b9f28487c88d@lunn.ch>
References: <20231219093554.GA6393@debian>
 <20231221072853.107678-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221072853.107678-1-dima.fedrau@gmail.com>

On Thu, Dec 21, 2023 at 08:28:47AM +0100, Dimitri Fedrau wrote:
> Changes in v2:
> 	- used defines MDIO_CTRL1_LPOWER and MDIO_PMA_CTRL1_SPEED1000
> 	  in mv88q222x_config_aneg_preinit
> 	- use genphy_c45_loopback
> 	- mv88q2xxx_read_status reads speed, master or slave state when
> 	  autonegotiation is enabled
> 	- added defines for magic values in mv88q222x_get_sqi

Please create a new thread for each version of the patch. The
automation does not like new versions appended onto old versions, so
this might not of been build tested.

     Andrew

