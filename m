Return-Path: <linux-kernel+bounces-128394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA26895A44
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65BFEB2806F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA915AAD0;
	Tue,  2 Apr 2024 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="SPV4IS2w"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0873315AAC3;
	Tue,  2 Apr 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076804; cv=none; b=g3krpnZVE/XKu/RU9d9x4xnqOWrNRMSXGBe7WWQ6dpSF4tYXbEtVQeugyCKKxjL5V3TIS4fK3Eah7uqdWbWemLXzejHqM8YXRdEOXeOfnyeLUH4ku2q1MUJdz/dRpCN5PyJb4gw00tWmrNlXx+KunB6dyF0qNgzFxDH0wEYTV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076804; c=relaxed/simple;
	bh=atPMBkwnZRH1QfaOz8mJNu//uwTwpHitO8rlHlkvhd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbBC7VI6JGswhxQjX0w3IGNK+EVrqITxlXgk9P/AcHW8w1VdYRPdEVF7KilcVB8swWDP+29+NrORR4ZUKbsGlE83WO4gKqHyZoKWUDOY0kmN62RR1M0ls6BKT2NwUkFa/KqsAZ2ecdefgZAD0EULzWQJBoF8M34TYn0r7Yo0BYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=SPV4IS2w; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 619571FAA3;
	Tue,  2 Apr 2024 18:53:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712076792;
	bh=PctgBINCFX58WVqQY3z03UnoMSWRHAzvZU5WuaVRFQo=; h=From:To:Subject;
	b=SPV4IS2waVCTTGVjIqICRmtVQjms4nIPuOmv0oiWsDf0jJTHDe6SxPuK32GbH/mO5
	 3zeLNjxE3E1CuL6Zty521LUAsOmBmzhwx7fkzCcfH2Csc9WZfYIJFzZSQ71zSQhC4v
	 OXCgOb9mNPc2V4ie4aPYBHcP+/y4CdgoLU4qyK3sGXkthLFGkQu+0bmWv4dcs9fIx8
	 lIRImWikSATfVoPAe2p0cZ7tFr12oMeZm3S6ouJHdjkNEOos6qpj0C3iXEXAuUzkII
	 DSTLf7fYHbRngHE2PwywYLqfMDmezl6Hc/tfTsGo9mKAa5VkodPKlAy6AxTGAxI/Ez
	 4M4PgR3YEb6yA==
Date: Tue, 2 Apr 2024 18:53:07 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Alexandru Ardelean <alex@shruggie.ro>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, adrien.grassein@gmail.com,
	andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com,
	marius.muresan@mxt.ro, irina.muresan@mxt.ro
Subject: Re: [PATCH 1/2] drm/bridge: lt8912b: add support for P/N pin swap
Message-ID: <20240402165307.GA31874@francesco-nb>
References: <20240402105925.905144-1-alex@shruggie.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402105925.905144-1-alex@shruggie.ro>

Hello Alexandru, thanks for your patch.

On Tue, Apr 02, 2024 at 01:59:24PM +0300, Alexandru Ardelean wrote:
> On some HW designs, it's easier for the layout if the P/N pins are swapped.
> In those cases, we need to adjust (for this) by configuring the MIPI analog
> registers differently. Specifically, register 0x3e needs to be 0xf6
> (instead of 0xd6).
> 
> This change adds a 'lontium,pn-swap' device-tree property to configure the
> MIPI analog registers for P/N swap.
> 
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
>  drivers/gpu/drm/bridge/lontium-lt8912b.c | 25 +++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
> index 4b2ae27f0a57f..154126bb922b4 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
> @@ -47,6 +47,7 @@ struct lt8912 {
>  
>  	u8 data_lanes;
>  	bool is_power_on;
> +	bool do_pn_swap;
>  };
>  
>  static int lt8912_write_init_config(struct lt8912 *lt)
> @@ -78,15 +79,31 @@ static int lt8912_write_init_config(struct lt8912 *lt)
>  		{0x55, 0x44},
>  		{0x57, 0x01},
>  		{0x5a, 0x02},
> -
> -		/*MIPI Analog*/
> +	};
> +	const struct reg_sequence mipi_analog_seq[] = {
>  		{0x3e, 0xd6},
>  		{0x3f, 0xd4},
>  		{0x41, 0x3c},
>  		{0xB2, 0x00},
>  	};
> +	const struct reg_sequence mipi_analog_pn_swap_seq[] = {
> +		{0x3e, 0xf6},
> +		{0x3f, 0xd4},
> +		{0x41, 0x3c},
> +		{0xB2, 0x00},
> +	};
> +	int ret;
>  
> -	return regmap_multi_reg_write(lt->regmap[I2C_MAIN], seq, ARRAY_SIZE(seq));
> +	ret = regmap_multi_reg_write(lt->regmap[I2C_MAIN], seq, ARRAY_SIZE(seq));
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!lt->do_pn_swap)
> +		return regmap_multi_reg_write(lt->regmap[I2C_MAIN], mipi_analog_seq,
> +					      ARRAY_SIZE(mipi_analog_seq));
> +
> +	return regmap_multi_reg_write(lt->regmap[I2C_MAIN], mipi_analog_pn_swap_seq,
> +				      ARRAY_SIZE(mipi_analog_pn_swap_seq));

Can you just remove {0x3e, 0xd6} from the register/value array and write
it afterward depending on `do_pn_swap` value? Or keep it with the
current value and only overwrite it when do_pn_swap is true?

If you do it this way is a 4 line change.


>  static int lt8912_write_mipi_basic_config(struct lt8912 *lt)
> @@ -702,6 +719,8 @@ static int lt8912_parse_dt(struct lt8912 *lt)
>  	}
>  	lt->gp_reset = gp_reset;
>  
> +	lt->do_pn_swap = device_property_read_bool(dev, "lontium,pn-swap");

I would call this variable the same that is called in the lontium
documentation, mipirx_diff_swap

Francesco


