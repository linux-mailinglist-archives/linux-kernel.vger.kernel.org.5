Return-Path: <linux-kernel+bounces-154730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCE68AE03E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663841F21AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD70E58234;
	Tue, 23 Apr 2024 08:49:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938AC56B73
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862158; cv=none; b=PPjoEhjx41qJ1Cr7IWxoT5RKI5G3oyfvQPznhc0mr0vbXbxzNxJhKPdvvVHczlg5IvLpLpQIi5dZh2Y9T5qKXgo3SZhpqJUlEu7RktCQzT67fzMGPpI9kKpdTmJF/V8PzN7j/gVRgdracPpjsdfkA9SH+RCK0R81DjQZUHyVNBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862158; c=relaxed/simple;
	bh=W7f1Jf2jYUuUwHeiLYjopYj8jBxllwwQe9ojyeI4tqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ+hvqhdsAQW3w3ibF2z4n5Dy7nSFYNu8Zcm8xPszUWXv/qviG5xBJBEl/cCoV5b3ECl26bLc6uHkAuQ6ZvoDxGQ1Y8kYmCffDTZ2DG3o05ReTb6FWqNmYCjQk/REznlHGPBrUntKaGghUjDNeaInsDCOy6bgdXpRZkFhxr0/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rzBpu-0007Tf-3I; Tue, 23 Apr 2024 10:49:10 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rzBpt-00DrZx-L6; Tue, 23 Apr 2024 10:49:09 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rzBpt-009nsy-1o;
	Tue, 23 Apr 2024 10:49:09 +0200
Date: Tue, 23 Apr 2024 10:49:09 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next v2 1/3] net: pse-pd: pse_core: Add missing kdoc
 return description
Message-ID: <Zid2BRA74cA8hXfI@pengutronix.de>
References: <20240422-fix_poe-v2-0-e58325950f07@bootlin.com>
 <20240422-fix_poe-v2-1-e58325950f07@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240422-fix_poe-v2-1-e58325950f07@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2024 at 03:35:46PM +0200, Kory Maincent (Dent Project) wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Add missing kernel documentation return description.
> This allows to remove all warning from kernel-doc test script.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

