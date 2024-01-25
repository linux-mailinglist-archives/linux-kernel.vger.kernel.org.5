Return-Path: <linux-kernel+bounces-39375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E92B83CF98
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5D7293D56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB954134A5;
	Thu, 25 Jan 2024 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="b6390Nbn"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD28111706;
	Thu, 25 Jan 2024 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222946; cv=none; b=oWd8UMElkz/vtWJYNVLAwZ0cCaRo2Rh9RxM7jRkgeO8mot+pnY3zbsTcGK+esGHfODMq1BsiguXc4fkrqjDSr9H6RBhTSruwX4/22Ffrfs6/cYK/htiC46Pk2MwqIYqSKs+fernAX0ZyEjfA2fJkFYL724bCF41jBxzqjv00wD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222946; c=relaxed/simple;
	bh=+7OvAbc65gMBHkNCZLbkYDkZOm9ZDtdcGTRus97SoRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aP9e371fLuLRKkCfwP+LnMHEGXfExwVq9w5vMpQpj9ayrFaXpK94ajd5GkZJhsgb4AjGl1thJIg+vQn9hToLwHJ/eFqaDqyxRy5POj64zgXKcZbKn5AcUs6N8/g5P0+r5eQQyj5UpQWluDFw6TDisVq9Uwx2L6HvPLcnWgU/E+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=b6390Nbn; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D7D4FF802;
	Thu, 25 Jan 2024 22:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1706222941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npd3pP1aReG/0ALjdGC6r+4bjQEOxICwXHbbVuqWcZ4=;
	b=b6390NbnuGXNe15DVpYrjlfa1PtjIqNM14bhVWY5DOZGJW3IrdQIxWsUry2cdr1ko4tpL2
	XYaM1eDs04rTuDv05UpUPeHePQfY40n9AM2SyvBKizzy15WRT2ukePEzD+BXGzNyI1EqBU
	01dehgiepB3Gv3jPJidrzbLlzOUFiR8vrCCOrr7SCkp39Ri65quXPYI8i/WVMZVqTE6V0/
	wxP2F8GR/RfCJ0XPj6t+8LoFzMkdRjpgiao5ymJs8U7x5dt/dgxDeFU/8k/H5Q0/enjohq
	/3sdCLsg8wTcKEoVz3cM7v9dZsF2g6pZ/mCLagndFZfRHWxcMcMoZo/sX0pyLg==
Message-ID: <a5b37e23-5f88-4a23-a1e3-908513a64f03@arinc9.com>
Date: Fri, 26 Jan 2024 01:48:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 6/7] net: dsa: mt7530: do not set
 priv->p5_interface on mt7530_setup_port5()
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
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
 linux-mediatek@lists.infradead.org
References: <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
 <20240122-for-netnext-mt7530-improvements-1-v3-6-042401f2b279@arinc9.com>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240122-for-netnext-mt7530-improvements-1-v3-6-042401f2b279@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

Vladimir could you review this too? This is the only patch remaining
without a review or ACK.

Arınç

On 22.01.2024 08:35, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Running mt7530_setup_port5() from mt7530_setup() used to handle all cases
> of configuring port 5, including phylink.
> 
> Setting priv->p5_interface under mt7530_setup_port5() makes sure that
> mt7530_setup_port5() from mt753x_phylink_mac_config() won't run.
> 
> The commit ("net: dsa: mt7530: improve code path for setting up port 5")
> makes so that mt7530_setup_port5() from mt7530_setup() runs only on
> non-phylink cases.
> 
> Get rid of unnecessarily setting priv->p5_interface under
> mt7530_setup_port5() as port 5 phylink configuration will be done by
> running mt7530_setup_port5() from mt753x_phylink_mac_config() now.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>   drivers/net/dsa/mt7530.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 33c15f10de34..5394d8c6a40e 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -978,8 +978,6 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
>   	dev_dbg(ds->dev, "Setup P5, HWTRAP=0x%x, intf_sel=%s, phy-mode=%s\n",
>   		val, p5_intf_modes(priv->p5_intf_sel), phy_modes(interface));
>   
> -	priv->p5_interface = interface;
> -
>   unlock_exit:
>   	mutex_unlock(&priv->reg_mutex);
>   }
> 

