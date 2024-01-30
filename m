Return-Path: <linux-kernel+bounces-44360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5FC8420E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BE71F2513D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B222260B9A;
	Tue, 30 Jan 2024 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upKCdCbW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0167860885;
	Tue, 30 Jan 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609590; cv=none; b=PQUbpaeCGfq4w96Ay7OZRQBHMkwjMxczGa8IkTbvLKtqGBz9qpzv9yX62ubjKejbQ1RB/vZE3/f4T5v8Kt3gN+ZQfi0AnJyc7VN5FzOtpe0nLwRzPM247SrlpwZSBPfyP/B/cd6EmuDl/R8rlk5Big1ne+CntRgaIaBygdmeDA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609590; c=relaxed/simple;
	bh=bHjhb7ec4V/9qFcEdq9saB1TdkNyxZJVjbB3yRsYgO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbEDKV0z/DKd7glaQDKNhejN0IOFlotJ0c9F7Q3L+mTbEKiA9bSAlY4OiTQwICHyT/PlZbSeSXxrowoMkFTmbUZMLSE4JlJRJpm2xdhoFSObOYUE1ZviBkzPRbKrnjCjXTgAUyMieuVy1UlUXDJxu2HjQol909ioeIKc2T0TxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upKCdCbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC36C433C7;
	Tue, 30 Jan 2024 10:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706609589;
	bh=bHjhb7ec4V/9qFcEdq9saB1TdkNyxZJVjbB3yRsYgO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=upKCdCbWCMu6O2DUujUu6FBWxFmraU34DJSlkckJglsaVtY2vGvNCUgqq/ruhWPEU
	 7yG5bFI/JA8WSY6IQJr2+ZFhYZIK/6CAFmUGgc5b70uZNaoT/TROi6HpO4mXFZB4rF
	 gq9tb+y/o8sWjDTbBAO+YB3QfbWaw7GETtqUW3P9uBS4s9KzupPAfP6/yJQ/Q/D6TY
	 lONw0wgWvp3+t/A/Ba7Mh1N149xbXO4XJac3pONPXFbFPQu0M/b5cwtGMx0SJwONob
	 GC56e4pqUpZLsOh4Dwr5l6vSkIrgIFs3icQ8zdCYuTbi0yVOrsVg1PUJLs7KJExID8
	 wUtDi4MEfa6Pg==
Date: Tue, 30 Jan 2024 10:11:34 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, dsahern@kernel.org, weiwan@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH net 02/10] net: fill in MODULE_DESCRIPTION()s for ocelot
Message-ID: <20240130101134.GG349047@kernel.org>
References: <20240125193420.533604-1-leitao@debian.org>
 <20240125193420.533604-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125193420.533604-3-leitao@debian.org>

On Thu, Jan 25, 2024 at 11:34:12AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the Ocelot SoCs (VSC7514) helpers driver.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/net/ethernet/mscc/ocelot.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
> index 56ccbd4c37fe..2194f2a7ab27 100644
> --- a/drivers/net/ethernet/mscc/ocelot.c
> +++ b/drivers/net/ethernet/mscc/ocelot.c
> @@ -3078,4 +3078,5 @@ void ocelot_deinit_port(struct ocelot *ocelot, int port)
>  }
>  EXPORT_SYMBOL(ocelot_deinit_port);
>  
> +MODULE_DESCRIPTION("Microsemi Ocelot (VSC7514) Switch driver");

Hi Breno,

I really appreciate your work in this area.

WRT this patch, I could well be wrong, but I think this code is also used
by Felix (VSC9959). If so the description might want tweaking.

Vladimir, can you shed some light on this?

>  MODULE_LICENSE("Dual MIT/GPL");
> -- 
> 2.39.3
> 

