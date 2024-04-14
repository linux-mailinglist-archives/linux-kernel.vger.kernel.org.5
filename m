Return-Path: <linux-kernel+bounces-143951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641748A3FFF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 05:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CE7281971
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 03:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD83117740;
	Sun, 14 Apr 2024 03:10:48 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F473FF4;
	Sun, 14 Apr 2024 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713064248; cv=none; b=MWZEKV7wVRmpBQlPOPMSOzJ4r/waTjtm3/RAqCyAxmv075H7oMBCrKh7qKDqQvq4U+ajGCgb6gfhg1oEXcQm5AqSyAnnKE4f0thThrL0L33ISIg8Q+xUEmbbWy63ZaYBcGduzsLMldHZXB8mZ37cTG/C9Ww0AE/3ykL1qVMAj4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713064248; c=relaxed/simple;
	bh=JdJeOeAkGiqavnP7rW3q+hbOD7id2uIqZiXRHC8Tm2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNfkhWjzRBl+A+HZfPc5ob6jtnn1kXeeVRrNa/SGRjOlPhaKUE9POKWfgdGAWbiuwKNP+Ez6vXaHHEGSsoT3CDCknTryPWGuaDq3N9bpdhiD6c0GYDJriiVeVxdYym8gwxkc2zIgzvmamSzT8R/RWh+JiLqkHHtJgDpB1OoDIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rvqG4-00018x-1q;
	Sun, 14 Apr 2024 03:10:20 +0000
Date: Sun, 14 Apr 2024 04:10:16 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: arinc.unal@arinc9.com
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 1/2] net: dsa: mt7530-mdio: read PHY address of
 switch from device tree
Message-ID: <ZhtJGEdjeS3LfMWF@makrotopia.org>
References: <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v1-0-b08936df2770@arinc9.com>
 <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v1-1-b08936df2770@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v1-1-b08936df2770@arinc9.com>

On Sun, Apr 14, 2024 at 01:08:19AM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Read the PHY address the switch listens on from the reg property of the
> switch node on the device tree. This change brings support for MT7530
> switches on boards with such bootstrapping configuration where the switch
> listens on a different PHY address than the hardcoded PHY address on the
> driver, 31.
> 
> As described on the "MT7621 Programming Guide v0.4" document, the MT7530
> switch and its PHYs can be configured to listen on the range of 7-12,
> 15-20, 23-28, and 31 and 0-4 PHY addresses.
> 
> There are operations where the switch PHY registers are used. For the PHY
> address of the control PHY, transform the MT753X_CTRL_PHY_ADDR constant
> into a macro and use it. The PHY address for the control PHY is 0 when the
> switch listens on 31. In any other case, it is one greater than the PHY
> address the switch listens on.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

See minor nit inline below.

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>
(only MT7530 and MT7531 on address 0x1f has been tested, I don't have
any board configuring the switch to any other base-address)

> ---
>  drivers/net/dsa/mt7530-mdio.c | 28 ++++++++++++++--------------
>  drivers/net/dsa/mt7530.c      | 35 ++++++++++++++++++++++-------------
>  drivers/net/dsa/mt7530.h      |  4 +++-
>  3 files changed, 39 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
> index fa3ee85a99c1..599b28c8a340 100644
> --- a/drivers/net/dsa/mt7530-mdio.c
> +++ b/drivers/net/dsa/mt7530-mdio.c
> @@ -18,7 +18,8 @@
>  static int
>  mt7530_regmap_write(void *context, unsigned int reg, unsigned int val)
>  {
> -	struct mii_bus *bus = context;
> +	struct mt7530_priv *priv = context;
> +	struct mii_bus *bus = priv->bus;
>  	u16 page, r, lo, hi;
>  	int ret;
>  
> @@ -27,36 +28,35 @@ mt7530_regmap_write(void *context, unsigned int reg, unsigned int val)
>  	lo = val & 0xffff;
>  	hi = val >> 16;
>  
> -	/* MT7530 uses 31 as the pseudo port */
> -	ret = bus->write(bus, 0x1f, 0x1f, page);
> +	ret = bus->write(bus, priv->phy_addr, 0x1f, page);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = bus->write(bus, 0x1f, r,  lo);
> +	ret = bus->write(bus, priv->phy_addr, r, lo);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = bus->write(bus, 0x1f, 0x10, hi);
> +	ret = bus->write(bus, priv->phy_addr, 0x10, hi);
>  	return ret;
>  }
>  
>  static int
>  mt7530_regmap_read(void *context, unsigned int reg, unsigned int *val)
>  {
> -	struct mii_bus *bus = context;
> +	struct mt7530_priv *priv = context;
> +	struct mii_bus *bus = priv->bus;
>  	u16 page, r, lo, hi;
>  	int ret;
>  
>  	page = (reg >> 6) & 0x3ff;
>  	r = (reg >> 2) & 0xf;
>  
> -	/* MT7530 uses 31 as the pseudo port */
> -	ret = bus->write(bus, 0x1f, 0x1f, page);
> +	ret = bus->write(bus, priv->phy_addr, 0x1f, page);
>  	if (ret < 0)
>  		return ret;
>  
> -	lo = bus->read(bus, 0x1f, r);
> -	hi = bus->read(bus, 0x1f, 0x10);
> +	lo = bus->read(bus, priv->phy_addr, r);
> +	hi = bus->read(bus, priv->phy_addr, 0x10);
>  
>  	*val = (hi << 16) | (lo & 0xffff);
>  
> @@ -107,8 +107,7 @@ mt7531_create_sgmii(struct mt7530_priv *priv)
>  		mt7531_pcs_config[i]->unlock = mt7530_mdio_regmap_unlock;
>  		mt7531_pcs_config[i]->lock_arg = &priv->bus->mdio_lock;
>  
> -		regmap = devm_regmap_init(priv->dev,
> -					  &mt7530_regmap_bus, priv->bus,
> +		regmap = devm_regmap_init(priv->dev, &mt7530_regmap_bus, priv,
>  					  mt7531_pcs_config[i]);
>  		if (IS_ERR(regmap)) {
>  			ret = PTR_ERR(regmap);
> @@ -153,6 +152,7 @@ mt7530_probe(struct mdio_device *mdiodev)
>  
>  	priv->bus = mdiodev->bus;
>  	priv->dev = &mdiodev->dev;
> +	priv->phy_addr = mdiodev->addr;
>  
>  	ret = mt7530_probe_common(priv);
>  	if (ret)
> @@ -203,8 +203,8 @@ mt7530_probe(struct mdio_device *mdiodev)
>  	regmap_config->reg_stride = 4;
>  	regmap_config->max_register = MT7530_CREV;
>  	regmap_config->disable_locking = true;
> -	priv->regmap = devm_regmap_init(priv->dev, &mt7530_regmap_bus,
> -					priv->bus, regmap_config);
> +	priv->regmap = devm_regmap_init(priv->dev, &mt7530_regmap_bus, priv,
> +					regmap_config);
>  	if (IS_ERR(priv->regmap))
>  		return PTR_ERR(priv->regmap);
>  
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index c0d0bce0b594..fefa6dd151fa 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -86,22 +86,26 @@ core_read_mmd_indirect(struct mt7530_priv *priv, int prtad, int devad)
>  	int value, ret;
>  
>  	/* Write the desired MMD Devad */
> -	ret = bus->write(bus, 0, MII_MMD_CTRL, devad);
> +	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> +			 MII_MMD_CTRL, devad);
>  	if (ret < 0)
>  		goto err;
>  
>  	/* Write the desired MMD register address */
> -	ret = bus->write(bus, 0, MII_MMD_DATA, prtad);
> +	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> +			 MII_MMD_DATA, prtad);
>  	if (ret < 0)
>  		goto err;
>  
>  	/* Select the Function : DATA with no post increment */
> -	ret = bus->write(bus, 0, MII_MMD_CTRL, (devad | MII_MMD_CTRL_NOINCR));
> +	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> +			 MII_MMD_CTRL, devad | MII_MMD_CTRL_NOINCR);
>  	if (ret < 0)
>  		goto err;
>  
>  	/* Read the content of the MMD's selected register */
> -	value = bus->read(bus, 0, MII_MMD_DATA);
> +	value = bus->read(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> +			  MII_MMD_DATA);
>  
>  	return value;
>  err:
> @@ -118,22 +122,26 @@ core_write_mmd_indirect(struct mt7530_priv *priv, int prtad,
>  	int ret;
>  
>  	/* Write the desired MMD Devad */
> -	ret = bus->write(bus, 0, MII_MMD_CTRL, devad);
> +	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> +			 MII_MMD_CTRL, devad);
>  	if (ret < 0)
>  		goto err;
>  
>  	/* Write the desired MMD register address */
> -	ret = bus->write(bus, 0, MII_MMD_DATA, prtad);
> +	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> +			 MII_MMD_DATA, prtad);
>  	if (ret < 0)
>  		goto err;
>  
>  	/* Select the Function : DATA with no post increment */
> -	ret = bus->write(bus, 0, MII_MMD_CTRL, (devad | MII_MMD_CTRL_NOINCR));
> +	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> +			 MII_MMD_CTRL, devad | MII_MMD_CTRL_NOINCR);
>  	if (ret < 0)
>  		goto err;
>  
>  	/* Write the data into MMD's selected register */
> -	ret = bus->write(bus, 0, MII_MMD_DATA, data);
> +	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> +			 MII_MMD_DATA, data);
>  err:
>  	if (ret < 0)
>  		dev_err(&bus->dev,
> @@ -2671,16 +2679,17 @@ mt7531_setup(struct dsa_switch *ds)
>  	 * phy_[read,write]_mmd_indirect is called, we provide our own
>  	 * mt7531_ind_mmd_phy_[read,write] to complete this function.
>  	 */
> -	val = mt7531_ind_c45_phy_read(priv, MT753X_CTRL_PHY_ADDR,
> +	val = mt7531_ind_c45_phy_read(priv,
> +				      MT753X_CTRL_PHY_ADDR(priv->phy_addr),
>  				      MDIO_MMD_VEND2, CORE_PLL_GROUP4);
>  	val |= MT7531_RG_SYSPLL_DMY2 | MT7531_PHY_PLL_BYPASS_MODE;
>  	val &= ~MT7531_PHY_PLL_OFF;
> -	mt7531_ind_c45_phy_write(priv, MT753X_CTRL_PHY_ADDR, MDIO_MMD_VEND2,
> -				 CORE_PLL_GROUP4, val);
> +	mt7531_ind_c45_phy_write(priv, MT753X_CTRL_PHY_ADDR(priv->phy_addr),
> +				 MDIO_MMD_VEND2, CORE_PLL_GROUP4, val);
>  
>  	/* Disable EEE advertisement on the switch PHYs. */
> -	for (i = MT753X_CTRL_PHY_ADDR;
> -	     i < MT753X_CTRL_PHY_ADDR + MT7530_NUM_PHYS; i++) {
> +	for (i = MT753X_CTRL_PHY_ADDR(priv->phy_addr);
> +	     i < MT753X_CTRL_PHY_ADDR(priv->phy_addr) + MT7530_NUM_PHYS; i++) {
>  		mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
>  					 0);
>  	}
> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index 585db03c0548..76adc9d21bcf 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h
> @@ -625,7 +625,7 @@ enum mt7531_clk_skew {
>  #define  MT7531_PHY_PLL_OFF		BIT(5)
>  #define  MT7531_PHY_PLL_BYPASS_MODE	BIT(4)
>  
> -#define MT753X_CTRL_PHY_ADDR		0
> +#define MT753X_CTRL_PHY_ADDR(phy_addr)	(phy_addr == 0x1f ? 0 : phy_addr + 1)

#define MT753X_CTRL_PHY_ADDR(phy_addr)	(phy_addr + 1 & 0x1f)

It's shorter, and works without conditional operator which is expensive.

>  
>  #define CORE_PLL_GROUP5			0x404
>  #define  RG_LCDDS_PCW_NCPO1(x)		((x) & 0xffff)
> @@ -774,6 +774,7 @@ struct mt753x_info {
>   * @irq_enable:		IRQ enable bits, synced to SYS_INT_EN
>   * @create_sgmii:	Pointer to function creating SGMII PCS instance(s)
>   * @active_cpu_ports:	Holding the active CPU ports
> + * @phy_addr:		Holding the PHY address the switch listens on
>   */
>  struct mt7530_priv {
>  	struct device		*dev;
> @@ -800,6 +801,7 @@ struct mt7530_priv {
>  	u32 irq_enable;
>  	int (*create_sgmii)(struct mt7530_priv *priv);
>  	u8 active_cpu_ports;
> +	int phy_addr;
>  };
>  
>  struct mt7530_hw_vlan_entry {
> 
> -- 
> 2.40.1
> 
> 

