Return-Path: <linux-kernel+bounces-51838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6EF848FDA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807811C20DAD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08D224A11;
	Sun,  4 Feb 2024 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="nGgIdTTW"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51325249ED;
	Sun,  4 Feb 2024 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707070216; cv=none; b=sN94NKbpBbXuEmCaT7isqLAcrzK2UNSFDxu4ygo3Q3sPR8nZf2F6v4VceYVbvTMI0j19F9onWFCwLZRl/Ily5E7XkSWHJ24f5QoO/32WVcpOmKEp4swbAjwJtL6DoMp8AmCbRU2C2Z28ms/VfSL4ZnBI6IoNbZqtYQU3KQQbZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707070216; c=relaxed/simple;
	bh=5kYtyqCLUvdZv+qqyt+Qe8sLsY1B5uu19eqnKrr6/SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QszgctQdzfGlaIn1wTi9iFB6jr6q5QLsdHD8ygQ/xX688svHLBHGMLPp2RzAUQ3hmSTVJcNSDRnRC/dCWU/CUtJqlG7Pz/rCdo2VC8DAfufTR1E0/Ppie8dP96e94/+RW7cK3UKRlGEI+yV6SfmYdLEugZf7jtuNzGDML16Mo+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=nGgIdTTW; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 648CCC0004;
	Sun,  4 Feb 2024 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1707070211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYcz89R33Vbh+hteH2uxagVcgEXlP6trCtTKBMirrXg=;
	b=nGgIdTTWmlkH0DkDso2eSM+L2dDdz01kEU0kZqK8M0d5a60UgsHWLSXYF8SEygdhsF2JY4
	pLHaAvDotWIG9Ss4Wm9YD5PEYxhDEO4hUpxS+9sM+Wxu1l1u6/WTlUNePVtXqQkEouU6MI
	fbYBl+CJwGEBa5yEF+Kgt3RZOuExjOBuVi0Cj+tRUc9T9tsc+Ba2JioxHUEOld61NbaeQX
	nL7D/luQi0snXO8eQMh+CI+sxRH7Xi6Ea3WFLbw5VG9TknhbOiK5vvt3bNpAKHCSpflk6p
	bskM7fJtOhMAh7v8iTSfZTtJgC7L6JAxgJTVqovFNAipEHkmHAi1QD21zl1oqA==
Message-ID: <e7371ff0-0c45-4c41-8baa-31cef01fbf0d@arinc9.com>
Date: Sun, 4 Feb 2024 21:10:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 4/7] net: dsa: mt7530: call port 6 setup from
 mt7530_mac_config()
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
References: <20240204-for-netnext-mt7530-improvements-2-v4-0-02bf0abaadb8@arinc9.com>
 <20240204-for-netnext-mt7530-improvements-2-v4-4-02bf0abaadb8@arinc9.com>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240204-for-netnext-mt7530-improvements-2-v4-4-02bf0abaadb8@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 4.02.2024 19:34, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> mt7530_pad_clk_setup() is called if port 6 is enabled. It used to do more
> things than setting up port 6. That part was moved to more appropriate
> locations, mt7530_setup() and mt7530_pll_setup().
> 
> Now that all it does is set up port 6, rename it to mt7530_setup_port6(),
> and move it to a more appropriate location, under mt7530_mac_config().
> 
> Change mt7530_setup_port6() to void as there're no error cases.
> 
> Leave an empty mt7530_pad_clk_setup() to satisfy the pad_setup function
> pointer.
> 
> This is the code path for setting up the ports before:
> 
> dsa_switch_ops :: phylink_mac_config() -> mt753x_phylink_mac_config()
> -> mt753x_mac_config()
>     -> mt753x_info :: mac_port_config() -> mt7530_mac_config()
>        -> mt7530_setup_port5()
> -> mt753x_pad_setup()
>     -> mt753x_info :: pad_setup() -> mt7530_pad_clk_setup()
> 
> This is after:
> 
> dsa_switch_ops :: phylink_mac_config() -> mt753x_phylink_mac_config()
> -> mt753x_mac_config()
>     -> mt753x_info :: mac_port_config() -> mt7530_mac_config()
>        -> mt7530_setup_port5()
>        -> mt7530_setup_port6()
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>   drivers/net/dsa/mt7530.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 82e90da1e52b..18842c759b63 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -414,8 +414,8 @@ mt753x_preferred_default_local_cpu_port(struct dsa_switch *ds)
>   }
>   
>   /* Setup port 6 interface mode and TRGMII TX circuit */
> -static int
> -mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
> +static void
> +mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
>   {
>   	struct mt7530_priv *priv = ds->priv;
>   	u32 ncpo1, ssc_delta, xtal;
> @@ -465,7 +465,11 @@ mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
>   
>   	/* Enable the MT7530 TRGMII clocks */
>   	core_set(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
> +}
>   
> +static int
> +mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
> +{
>   	return 0;
>   }
>   
> @@ -2613,11 +2617,10 @@ mt7530_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
>   {
>   	struct mt7530_priv *priv = ds->priv;
>   
> -	/* Only need to setup port5. */
> -	if (port != 5)
> -		return 0;
> -
> -	mt7530_setup_port5(priv->ds, interface);
> +	if (port == 5) {

Stray brace, will remove.

Arınç

