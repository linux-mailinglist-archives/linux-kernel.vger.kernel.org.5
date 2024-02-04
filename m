Return-Path: <linux-kernel+bounces-51835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEDA848FD4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 193A1B227F4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1442249FA;
	Sun,  4 Feb 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Yz9FaFqP"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A02249ED;
	Sun,  4 Feb 2024 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707069810; cv=none; b=eUoMtSur61x5Y7wNEw7thN9+/UU0rVgQ9pQt7XujBWF0QZ9Q9jqxt5cOaLkmlmpgFu47/27TfvJbVa8FmAVRkWg2KhxAzv9/fberclG448XIAwsU83FpgggHmwmzC7QR1UQkAfCyEU/lYExkDasenJQ1G1sDdl/bqovdo5sMa+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707069810; c=relaxed/simple;
	bh=z/UZ8S54bvj5s04AanNyjlFBMqKy6VV/y/JjgfYizZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMEStST5kmZ9hOj5MwsEcLv9fMTYk+LmnXMKNOzKhXhUgpR0rkwvPu395Z67sTGniTaYbEmcqg9NX8r47mbsSBWEbKOQ+dGbKTxUU4LpGV12XZpFIPK30cc7NrggiyiUUyhK02TM19PTAONX811hi2ynHYB9x3amCU+gNDVBJAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Yz9FaFqP; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 357A360002;
	Sun,  4 Feb 2024 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1707069799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MI6lpIWgNfPYIufZPPUkrH5iDUtFzMUpZ7rJrZ2DilM=;
	b=Yz9FaFqPF7RNHn5IAgP/brxJzHHwL43WzXt4T7dUrZPwzs/S/LbG4DNcDcjjYa80SnjfDu
	e0fXEIck3tckJnDZKvUXuMB9QX3mD2S/ndjRGOdGke9xiLyeM6mIYfGbzWCdCUVJ+CAXkt
	nwHcc/0xIcxcRrdCr4iFdpk5e7cfJGilhmTyn2L+FL1HY1LoJc0qsoa5qMc2UDoweesVqY
	V0F7vzkJVxsmVdcQyrIQHHsu+wa8MUO4D8CMn3/8wRSugclu0jEttSr46nzQT2DKq5We5n
	LxCIiqObJ3wOmmMgLSx64NiC5qcr99kO42WGbkVtqhdGwvEePxuNTRYffRGtiA==
Message-ID: <d8838049-b0f3-4531-8ae0-83a7a7f14526@arinc9.com>
Date: Sun, 4 Feb 2024 21:03:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/7] net: dsa: mt7530: simplify
 mt7530_pad_clk_setup()
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
 <20240204-for-netnext-mt7530-improvements-2-v4-3-02bf0abaadb8@arinc9.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240204-for-netnext-mt7530-improvements-2-v4-3-02bf0abaadb8@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 4.02.2024 19:34, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> This code is from before this driver was converted to phylink API. Phylink
> deals with the unsupported interface cases before mt7530_pad_clk_setup() is
> run. Therefore, the default case would never run. However, it must be
> defined nonetheless to handle all the remaining enumeration values, the
> phy-modes.
> 
> Switch to if statement for RGMII and return which simplifies the code and
> saves an indent.
> 
> Set P6_INTF_MODE, which is the three least significant bits of the
> MT7530_P6ECR register, to 0 for RGMII even though it will already be 0
> after reset. This is to keep supporting dynamic reconfiguration of the port
> in the case the interface changes from TRGMII to RGMII.
> 
> Disable the TRGMII clocks for all cases. They will be enabled if TRGMII is
> being used.
> 
> Read XTAL after checking for RGMII as it's only needed for the TRGMII
> interface mode.
> 
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>   drivers/net/dsa/mt7530.c | 91 +++++++++++++++++++++---------------------------
>   1 file changed, 40 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 8b8469eba863..82e90da1e52b 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -418,64 +418,53 @@ static int
>   mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
>   {
>   	struct mt7530_priv *priv = ds->priv;
> -	u32 ncpo1, ssc_delta, trgint, xtal;
> +	u32 ncpo1, ssc_delta, xtal;
>   
> -	xtal = mt7530_read(priv, MT7530_MHWTRAP) & HWTRAP_XTAL_MASK;
> +	/* Disable the MT7530 TRGMII clocks */
> +	core_clear(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
>   
> -	switch (interface) {
> -	case PHY_INTERFACE_MODE_RGMII:
> -		trgint = 0;
> -		break;
> -	case PHY_INTERFACE_MODE_TRGMII:
> -		trgint = 1;
> -		if (xtal == HWTRAP_XTAL_25MHZ)
> -			ssc_delta = 0x57;
> -		else
> -			ssc_delta = 0x87;
> -		if (priv->id == ID_MT7621) {
> -			/* PLL frequency: 125MHz: 1.0GBit */
> -			if (xtal == HWTRAP_XTAL_40MHZ)
> -				ncpo1 = 0x0640;
> -			if (xtal == HWTRAP_XTAL_25MHZ)
> -				ncpo1 = 0x0a00;
> -		} else { /* PLL frequency: 250MHz: 2.0Gbit */
> -			if (xtal == HWTRAP_XTAL_40MHZ)
> -				ncpo1 = 0x0c80;
> -			if (xtal == HWTRAP_XTAL_25MHZ)
> -				ncpo1 = 0x1400;
> -		}
> -		break;
> -	default:
> -		dev_err(priv->dev, "xMII interface %d not supported\n",
> -			interface);
> -		return -EINVAL;
> +	if (interface == PHY_INTERFACE_MODE_RGMII) {
> +		mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK,
> +			   P6_INTF_MODE(0));
> +		return;

This should be "return 0;". I will address this.

pw-bot: cr

Arınç

