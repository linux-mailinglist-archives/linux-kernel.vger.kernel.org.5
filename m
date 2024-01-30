Return-Path: <linux-kernel+bounces-45054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 929EC842B23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A87B22B81
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F62D14E2D1;
	Tue, 30 Jan 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="WYZB4kZx"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F001474B8;
	Tue, 30 Jan 2024 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636780; cv=none; b=M7CoU9OHev+2itxAHEeHGgFDyoiZBxLBgtgqjyWU3RiA+0KZNer5f/xmCY62Z/TGSnbK8MnlseZdzIgFOMaFq9OgkLBkctk2hYBljBEgruwig6z4sPbsBi+rYz9VifPczpHiZL8B6R+MrPRKaO/r/E2pllWf2r0+Jdsiw0vFJ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636780; c=relaxed/simple;
	bh=QNUWL3TUIQ6K07P3GF6s5IG46eZMvOnhkM9IL73zYqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilDW4t+fmaYGnHonJZhqJdEvTh3i6QqIJN1iOFjjA9D/bmMFIsiqo+J56fCB6Phnz/dSTGdkXt1lV7TRXEpJxUdrr2F7XHbcbY/BwQosPyNrIM+tSZRTRKkhZ9RkETdw9KEpF1WgTHMq9FcZekBCuwMg5wrQVxBF5DUWUAQP1Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=WYZB4kZx; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E81E40008;
	Tue, 30 Jan 2024 17:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1706636770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yeYHVBnNtWoSGK1TX7C9Ukvy1zAdkapytps+F5dGU8A=;
	b=WYZB4kZxCt5DddXc6lJXra4AMcWfbgZXZXYJ/3lAZqO6HfSqEZgrr6Ql8/Edzo/uQQ/m9e
	+5e3MSh9bra3/HnMcJrMZgDI/dExZTqlcxwagQcOEHp4v8B5Aw80DaMIaFxv53tXsN95Jp
	40NUFim7ysWHJRrbCWRZLiBAHr7r3APoSZpyB8H48u82EyQ5J8TI7qZEUpFh7IxrGk696h
	sbUor2a5hAeME4dA8Yjz5VCaPq1aHTkvJuhfAjiJjHSvvaqTCi53teTpXfmnYDV3Qc7Sf7
	eTyp7ivSSCDNAdleux9heW9Zm+ogIeELdgI1lUPqGRX+JQ6z5zxqpa8ldwnndg==
Message-ID: <77c38489-8a73-4b00-bd82-48174b4d620f@arinc9.com>
Date: Tue, 30 Jan 2024 20:46:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/7] net: dsa: mt7530: simplify
 mt7530_setup_port6() and change to void
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240130-for-netnext-mt7530-improvements-2-v2-0-ba06f5dd9eb0@arinc9.com>
 <20240130-for-netnext-mt7530-improvements-2-v2-5-ba06f5dd9eb0@arinc9.com>
 <Zbkc4BRORWYu79GZ@makrotopia.org>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <Zbkc4BRORWYu79GZ@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 30.01.2024 18:59, Daniel Golle wrote:
> On Tue, Jan 30, 2024 at 06:20:51PM +0300, Arınç ÜNAL via B4 Relay wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> This code is from before this driver was converted to phylink API. Phylink
>> deals with the unsupported interface cases before mt7530_setup_port6() is
>> run. Therefore, the default case would never run. However, it must be
>> defined nonetheless to handle all the remaining enumeration values, the
>> phy-modes.
>>
>> Switch to if statement for RGMII and return which simplifies the code and
>> saves an indent.
>>
>> Set P6_INTF_MODE, which is the the three least significant bits of the
>> MT7530_P6ECR register, to 0 for RGMII even though it will already be 0
>> after reset. This is to keep supporting dynamic reconfiguration of the port
>> in the case the interface changes from TRGMII to RGMII. The core operations
>> for TRGMII does not interfere with RGMII so no need to undo them.
> 
> That last sentence doesn't parse English gramar.
> "operations": plural
> "does": singular
> 
> Should probably be either "The core operation for TRGMII does not..."
> or "The core operations for TRGMII do not..."

I'll use the latter, thanks.

> 
> As you are mentioning it, I'm now curious if you consider to
> dynamically reconfiguring TRGIII<->RGMII on port 6 depending on
> whether there is more then 1 GBit/s possible bandwidth needed between
> port 6 and the remaining ports? That could make sense for power
> management, but then we should at least again switch off the TRGMII
> clocks in the RGMII case before returning, see my suggestion inline
> below.

Turning off the TRGMII clocks for RGMII makes sense to me. But I don't see
any cases where dynamic interface change between TRGMII and RGMII would
ever occur. Speed too. No PHYs support TRGMII, only some MediaTek SoC MACs
do. That means TRGMII would only be used in fixed links which there is no
dynamic reconfiguration. My patch is about simplifying the code so I don't
want to change the dynamic reconfiguration behaviour.

That said, last year, I have very thoroughly tested this "turbo" RGMII
interface between MT7530 standalone switch and MT7623NI SoC, which would
supposedly achieve 2 Gbps TX & 2 Gbps RX. The performance was as if the
link was regular RGMII. Unless the MediaTek SoC ethernet driver somehow
caps TRGMII to 1 Gbps, I consider this whole TRGMII shenanigans a scam, to
be extremely blunt. I'll give this a one last shot sometime before I push
for the removal of TRGMII from Linux altogether and default to RGMII where
it's used. Because of this, I don't want to spend too much time on this
patch as it's potentially wasted effort.

> 
>>
>> Read XTAL after checking for RGMII as it's only needed for the TRGMII
>> interface mode.
>>
>> Change mt7530_setup_port6() to void now that there're no error cases left.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> 
>> ---
>>   drivers/net/dsa/mt7530.c | 103 ++++++++++++++++++++---------------------------
>>   1 file changed, 43 insertions(+), 60 deletions(-)
>>
>> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
>> index c4d492e29fdf..36dc2bbcf3b6 100644
>> --- a/drivers/net/dsa/mt7530.c
>> +++ b/drivers/net/dsa/mt7530.c
>> @@ -414,70 +414,57 @@ mt753x_preferred_default_local_cpu_port(struct dsa_switch *ds)
>>   }
>>   
>>   /* Setup port 6 interface mode and TRGMII TX circuit */
>> -static int
>> +static void
>>   mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
>>   {
>>   	struct mt7530_priv *priv = ds->priv;
>> -	u32 ncpo1, ssc_delta, trgint, xtal;
>> -
>> -	xtal = mt7530_read(priv, MT7530_MHWTRAP) & HWTRAP_XTAL_MASK;
>> +	u32 ncpo1, ssc_delta, xtal;
>>   
>> -	switch (interface) {
>> -	case PHY_INTERFACE_MODE_RGMII:
>> -		trgint = 0;
>> -		break;
>> -	case PHY_INTERFACE_MODE_TRGMII:
>> -		trgint = 1;
>> -		if (xtal == HWTRAP_XTAL_25MHZ)
>> -			ssc_delta = 0x57;
>> -		else
>> -			ssc_delta = 0x87;
>> -		if (priv->id == ID_MT7621) {
>> -			/* PLL frequency: 125MHz: 1.0GBit */
>> -			if (xtal == HWTRAP_XTAL_40MHZ)
>> -				ncpo1 = 0x0640;
>> -			if (xtal == HWTRAP_XTAL_25MHZ)
>> -				ncpo1 = 0x0a00;
>> -		} else { /* PLL frequency: 250MHz: 2.0Gbit */
>> -			if (xtal == HWTRAP_XTAL_40MHZ)
>> -				ncpo1 = 0x0c80;
>> -			if (xtal == HWTRAP_XTAL_25MHZ)
>> -				ncpo1 = 0x1400;
>> -		}
>> -		break;
>> -	default:
>> -		dev_err(priv->dev, "xMII interface %d not supported\n",
>> -			interface);
>> -		return -EINVAL;
>> +	if (interface == PHY_INTERFACE_MODE_RGMII) {
>> +		mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK,
>> +			   P6_INTF_MODE(0));
> 
> Maybe at least switch off TRGMIICK here because we are sure we don't need it
> in the RGMII case, ie:
> core_clear(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
> 
> And that then is another line of code already present just below which
> means you could keep variable trgint as it was and return after
> switching off TRGMIICK below anyway...
> 
>> +		return;
>>   	}
>>   
>> -	mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK,
>> -		   P6_INTF_MODE(trgint));
>> +	mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK, P6_INTF_MODE(1));
>>   
>> -	if (trgint) {
>> -		/* Disable the MT7530 TRGMII clocks */
>> -		core_clear(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
>> +	xtal = mt7530_read(priv, MT7530_MHWTRAP) & HWTRAP_XTAL_MASK;
>>   
>> -		/* Setup the MT7530 TRGMII Tx Clock */
>> -		core_write(priv, CORE_PLL_GROUP5, RG_LCDDS_PCW_NCPO1(ncpo1));
>> -		core_write(priv, CORE_PLL_GROUP6, RG_LCDDS_PCW_NCPO0(0));
>> -		core_write(priv, CORE_PLL_GROUP10, RG_LCDDS_SSC_DELTA(ssc_delta));
>> -		core_write(priv, CORE_PLL_GROUP11, RG_LCDDS_SSC_DELTA1(ssc_delta));
>> -		core_write(priv, CORE_PLL_GROUP4,
>> -			   RG_SYSPLL_DDSFBK_EN | RG_SYSPLL_BIAS_EN |
>> -			   RG_SYSPLL_BIAS_LPF_EN);
>> -		core_write(priv, CORE_PLL_GROUP2,
>> -			   RG_SYSPLL_EN_NORMAL | RG_SYSPLL_VODEN |
>> -			   RG_SYSPLL_POSDIV(1));
>> -		core_write(priv, CORE_PLL_GROUP7,
>> -			   RG_LCDDS_PCW_NCPO_CHG | RG_LCCDS_C(3) |
>> -			   RG_LCDDS_PWDB | RG_LCDDS_ISO_EN);
>> +	if (xtal == HWTRAP_XTAL_25MHZ)
>> +		ssc_delta = 0x57;
>> +	else
>> +		ssc_delta = 0x87;
>>   
>> -		/* Enable the MT7530 TRGMII clocks */
>> -		core_set(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
>> +	if (priv->id == ID_MT7621) {
>> +		/* PLL frequency: 125MHz: 1.0GBit */
>> +		if (xtal == HWTRAP_XTAL_40MHZ)
>> +			ncpo1 = 0x0640;
>> +		if (xtal == HWTRAP_XTAL_25MHZ)
>> +			ncpo1 = 0x0a00;
>> +	} else { /* PLL frequency: 250MHz: 2.0Gbit */
>> +		if (xtal == HWTRAP_XTAL_40MHZ)
>> +			ncpo1 = 0x0c80;
>> +		if (xtal == HWTRAP_XTAL_25MHZ)
>> +			ncpo1 = 0x1400;
>>   	}
>>   
>> -	return 0;
>> +	/* Disable the MT7530 TRGMII clocks */
>> +	core_clear(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
> 
> ... by moving this line up and letting it happen unconditionally for
> both RGMII and TRGMII (in case that works and doesn't break the RGMII
> case, but I assume it doesn't)

I've just tested this, works fine. This looks simpler than bringing back
the trgint variable.

static void
mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
{
	struct mt7530_priv *priv = ds->priv;
	u32 ncpo1, ssc_delta, xtal;

	/* Disable the MT7530 TRGMII clocks */
	core_clear(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);

	if (interface == PHY_INTERFACE_MODE_RGMII) {
		mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK,
			   P6_INTF_MODE(0));
		return;
	}

	mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK, P6_INTF_MODE(1));

..

Arınç

