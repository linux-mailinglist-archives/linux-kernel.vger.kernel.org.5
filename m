Return-Path: <linux-kernel+bounces-59379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E131684F61B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DF4BB25D8C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB81F3BB55;
	Fri,  9 Feb 2024 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="egkhDIst"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE231D542;
	Fri,  9 Feb 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486002; cv=none; b=V8Gbtejl+n7sF7G7R7pwlYl/vPoNWpFFVjK7wyf14H0LucWzsyOK2lcCNPf7LfxSCKdz4lCuijs3Mf92QGw7paBAgMhbtlq6AZPUhYBmJuPwGAo9ohshxGajtt+cYo5PdhFyRXmwtaMn3KPwmvM49yqua8JYuPv3F9J8X/iMQBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486002; c=relaxed/simple;
	bh=tDPQHf4pY/G3y5AncB7SBbCfkckRM6n70LvBuj11kvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sk9y/FvXRBbwEYYgZctYMXU0vCJEjWKpenj5HJyrwCfU2xArkqeEY3/gm8NVFbDPOYvV+7eXg105ZmHOccIpGBEOrqnvRGB/szMzOyy000V1mMW0cAa7YlAafMFlN02yvgWK7LZsWzTNGCa6eD5vKZZu6qfzzfHvRX3zQCTX8xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=egkhDIst; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EEwBZTSq5tZ2xlb3nc2TPXbIcX1LOC4zPU9/QASdY90=; b=egkhDIst07yrhaMiVgf3dGfVlY
	0PiQf0FzNxlMtZESIRZVa6W078hgZSr9Y4d0D0lCJGrMVY9kc2aa8J0mTm/qwGsKuqBn76+5x8c8p
	wii4c6P50d7UX6JjgjFMkt9u9QgoX5YTDALT25/E3Vg6Bb+DviKREDkHVeJQHs0/tA70=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYR6e-007O3u-T1; Fri, 09 Feb 2024 14:39:52 +0100
Date: Fri, 9 Feb 2024 14:39:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Aithal, Srikanth" <sraithal@amd.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: linux-next20240208: tg3 driver nw interfaces not getting
 configured
Message-ID: <6aa4c396-00f2-4479-8ea9-fa67253ee662@lunn.ch>
References: <20240208155740.24c6ada7@canb.auug.org.au>
 <ce7150b7-b6f1-4635-ba5f-fdfda84a6e2f@amd.com>
 <fd72544a-f3ed-44bb-86e3-bdfa4fca720e@gmail.com>
 <8a59f072-4a71-4662-bfde-308b81e4ce88@amd.com>
 <47987433-7d56-483e-a0fc-38140cc17448@gmail.com>
 <11baa678-8cbe-4a9a-af09-381d649d648c@amd.com>
 <aa9a3495-22fd-4fac-abb0-afedf1b4d8ec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa9a3495-22fd-4fac-abb0-afedf1b4d8ec@gmail.com>

> Could you please test whether the following fixes the issue for you?
> 
> The uninitialized struct ethtool_keee causes the bug because
> mii_eee_cap1_mod_linkmode_t() leaves unknown bits as-is.
> 
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 50f674031..7d0a2f5f3 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -4616,7 +4616,7 @@ static int tg3_init_5401phy_dsp(struct tg3 *tp)
>  
>  static bool tg3_phy_eee_config_ok(struct tg3 *tp)
>  {
> -	struct ethtool_keee eee;
> +	struct ethtool_keee eee = {};

Nice catch.

Please add my Reviewed-by, if you have not already sent the real
patch.

	Andrew

