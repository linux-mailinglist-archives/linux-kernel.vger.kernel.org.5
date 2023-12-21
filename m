Return-Path: <linux-kernel+bounces-8568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFE981B97F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00631C241D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC2836089;
	Thu, 21 Dec 2023 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cwJcp4RE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF42E6D6F6;
	Thu, 21 Dec 2023 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=83/j5i4zu7kqHHtpPzIPW+ZpoOyRgtDx/AwjGXsP4d0=; b=cwJcp4REq06xDi2EuWB7Mu15O+
	SIru0EgHZgeOqPQGhSGuE9UYDynRzuTUYT63EuotMXZDPHkR983oGZPVzE1Sv8Mb0ep7wgin1C4lf
	sZN2cZdXb7AH8orVwquiluVXqHpj6eBE6gPPV3RJZpOdSsQubor8CA5p5dPtEyL9YKjo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rGJzo-003WBO-5E; Thu, 21 Dec 2023 15:25:56 +0100
Date: Thu, 21 Dec 2023 15:25:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Stefan Eichenberger <eichest@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] net: phy: marvell-88q2xxx: add driver for the
 Marvell 88Q2220 PHY
Message-ID: <59fed161-6c08-4537-b02d-19e67e342dd8@lunn.ch>
References: <20231219093554.GA6393@debian>
 <20231221072853.107678-1-dima.fedrau@gmail.com>
 <20231221072853.107678-5-dima.fedrau@gmail.com>
 <ZYRCDTWgHbM2qAom@eichest-laptop>
 <20231221141636.GA122124@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221141636.GA122124@debian>

> Without setting the master-slave option it didn't work. I think its
> mandatory.

I don't think it is. The PHY should have a default setting for
master-slave. Often its based on the typical use case. If its
typically inside a switch, then it should default to prefer-master. If
its typically in an end system, then it should be prefer-slave.

    Andrew

