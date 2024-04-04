Return-Path: <linux-kernel+bounces-131552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DE8898982
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4951F2B35D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28C41292FB;
	Thu,  4 Apr 2024 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="jqUe6OPt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="kkSHfl6Q"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD82F8528B;
	Thu,  4 Apr 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239585; cv=none; b=jILX1lrNJZpKLwgbWarnXA7vNtX6r+DIKbopV7hQ7ecHMKxYkQaNF5sAr46AwlW46edNHNtYNScj8y/opildQ2vV40lYR6B21al/lNqeXcnns+fvAytGxwIiZXUCKOgiFbTrtyWknQpE48gEyPmDoXFaJ/JB0qxKqUhyDH2fuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239585; c=relaxed/simple;
	bh=/zHAbt4y9sFY/xYAzcPpxk40Evw3pavCSB28vHMumug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UL6ovvP5ESO6OAbvq2teCSCtiDt0+1aad4spzNOS3Y0eNRzziCVa253PrzYc4PVI4tBnYOCUIaw4W0OLqhPn/n9iXC0eGIw9lBxA2f9UB2BNNiaFpxuWF+gbpXzV1v17qrCpBqbbDjGH2jjMZo03ircodtwBsDbCzSAQ86f/4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=jqUe6OPt; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=kkSHfl6Q reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1712239581; x=1743775581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=p9lyNNezsGzSH+r7ma4jkO5f1F+UgO5L9s51Fq+pDNs=;
  b=jqUe6OPth7IpABhfKnAPTzfbmuiL2gChVUJkVge/Dc5QId67IWIByafP
   Zn+CUci5ti7ikYW4F/5AKRHtoJuD7cerldIpKM2OwLryDe2nak2SmpUtz
   qDttbRtJ8PrO2LYIaZaDPhYjLURscbmlL36Y72JslyksF8z6kf+4a7Y/X
   3pl/BeP/oRZb1ZUU1L9xo/1mGeA9PUsL/i07OIBSmmOmDM1+V3MSH2T2x
   uVv8b+8fy7pEQnKEIJxI9R6Y4a4l0p3NFcJk+ZJqt/zHGUERfRHDelH1G
   3yRxbr6VGU9Hu3jDp/COIsfwKo7KfIdN9VZFyAgAhBfBL67RGc+MACevy
   w==;
X-IronPort-AV: E=Sophos;i="6.07,179,1708383600"; 
   d="scan'208";a="36253737"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Apr 2024 16:06:12 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD77416AB93;
	Thu,  4 Apr 2024 16:06:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1712239568;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=p9lyNNezsGzSH+r7ma4jkO5f1F+UgO5L9s51Fq+pDNs=;
	b=kkSHfl6QKcHUjhD9iRmDManPQlYhkIfDczW3AWWkoAagAQUAtSffCdLQIIqOUaXxIP84aF
	jZWb3FrtMkgNYFBpDEgb9LVvoJBWRSIP9vUiDASOKn2OWFZOa9Ef4wYQ8RdMpe7nxmIyDs
	tLDmDes1RkUZTc634DB6/uZI3SVyAmvdRiraZP9FcMPrVM1C9W6cnSBgJRiYM3/bJckFo1
	nhy3K0bwv93r2Kbyn2pUObkQ+GE0kam5QxYC82FLLabdLuCQlRn2LnbMEofpP2gL/ccMNX
	61OJcwBPIapQKaChkB9XIXKo0HXYZCWNWMFrs2g1JfbG7f2VgB2TnIcAM7h2zg==
Date: Thu, 4 Apr 2024 16:06:00 +0200
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
	alexander.stein@ew.tq-group.com
Subject: Re: Re: [PATCH] net: phy: marvell-88q2xxx: add support for Rev B1
 and B2
Message-ID: <Zg6zyJ8gMcwTiSOC@herburgerg-w2>
References: <20240403-mv88q222x-revb1-b2-init-v1-1-48b855464c37@ew.tq-group.com>
 <Zg1gycEDL4llYrjI@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zg1gycEDL4llYrjI@shell.armlinux.org.uk>
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On Wed, Apr 03, 2024 at 02:59:37PM +0100, Russell King (Oracle) wrote:
> I think a helper would be useful to write these sequences, rather than
> writing the same code several times:

Ok. Will add it to the next version.

> 
> static int mv88q2xxx_write_mmd_vals(struct phy_device *phydev,
> 				    const struct mmd_val *vals, size_t len)
> {
> 	int ret;
> 
> 	for (; len; vals++, len--) {
> 		ret = phy_write_mmd(phydev, vals->devad, vals->regnum,
> 				    vals->val);
> 		if (ret < 0)
> 			return ret;
> 	}
> 
> 	return 0;
> }
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

