Return-Path: <linux-kernel+bounces-65776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DFF8551B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831C41F2636F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E9D12883A;
	Wed, 14 Feb 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ldy1A0ys"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF46A128367;
	Wed, 14 Feb 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933948; cv=none; b=bhsttuFLFblcvbQv/EWh3Im2UGl36aT6riIF6QvrYEkgpeKPWZCEcZgX6mBipDlFxF0VWkX506qBP+Lyv/mbQNU/pK7OBhGxKdIjLppzwy51jaZ/vPzpciHQoL1Hd87RxMz/gbb4nraGKJybAqkh0Ku6OTte8lyeB24srf9X9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933948; c=relaxed/simple;
	bh=3kGc3/z9sYbk91kW+DxKKjdy0e2Sd59ClHQ6rAJ+K+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDjskrZRbVSsc3abykUGKa3WjyquYMAKZmDNq7PWpPX4wc2Ac3heEaNhFp5mAwm4lacggHAloqv/XThcPPJ3g1RLNfuIy7UmwsdXPAmYfjlwS6BZvLl0GC8d4DgO7zBvkDXlOozklYszQfaJ0GlSZaUGJRDbv43Jlx1REYvHftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ldy1A0ys; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8tK1UJ5/eFfXQXOMZbs7Yv1qLXv8MfGCTcuShKzam1Y=; b=Ldy1A0yspDJD7662u1/cqBA9+Y
	qWfVO22Srl83cjS8PXQlyva2hOjIZO/dAoT1boe6Wf8I640Kq+Y4dWbO5+/70lrWBM15x7RQYhiDz
	oXVa00i9vt/847LGcV4Hod8rfGDHkjCio1sIcZL0wIBiH1u4ljyfkZZ6H8Pq2+Oex404=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raJdm-007oZ0-Kk; Wed, 14 Feb 2024 19:05:50 +0100
Date: Wed, 14 Feb 2024 19:05:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: aquantia: add AQR113 PHY ID
Message-ID: <1d30f923-8391-4e36-bf3f-2cdb733d464c@lunn.ch>
References: <20240213180228.15859-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213180228.15859-1-ansuelsmth@gmail.com>

On Tue, Feb 13, 2024 at 07:02:26PM +0100, Christian Marangi wrote:
> Add Aquantia AQR113 PHY ID. Aquantia AQR113 is just a chip size variant of
> the already supported AQR133C where the only difference is the PHY ID
> and the hw chip size.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

