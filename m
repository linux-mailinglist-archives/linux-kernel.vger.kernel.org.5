Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0597B2578
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjI1Sqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjI1Sqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:46:43 -0400
Received: from smtpcmd0987.aruba.it (smtpcmd0987.aruba.it [62.149.156.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F7D180
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:46:40 -0700 (PDT)
Received: from [192.168.50.162] ([146.241.127.78])
        by Aruba Outgoing Smtp  with ESMTPSA
        id lw21qSFQibrLalw21qIgBu; Thu, 28 Sep 2023 20:46:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1695926797; bh=K0LdKKq/NnEUV+DVGyvJG4AW6uu1fW2tZvzKIWMCM1w=;
        h=Date:MIME-Version:Subject:From:To:Content-Type;
        b=ic8NQcLqvipzPRuNdjvA7y/+k0ejai04Gqxv6yFJvZcGrhqQXX8BrI5LZ6siFdj8I
         Wut8LKRykj91FDVdb9SUTuJtKfdMXG47Q4J3/26GpT7AxJ+0Pw3e2goveWb5zskQnY
         dVxvfIbI3wqnSZO+79A0j4S9eqc1l3QTtiplUcq88dwFDlnvlJskb8xd8eZpJjSLkt
         tzTlPu4X4BfJuPevE2yrz0TYqJa2yyBdf0Kk0has6wp/9hY/ImoKaw06dzMMa1fPkm
         tFxXG/39LkBjuPAwEYsJI9HCZr5Ph8yO5S4FFOhx2e0DM2MP1LbxN6uPxa4WzjyXxw
         nH55qZMSAdOWg==
Message-ID: <c922942a-d876-4757-be53-2505bea0e6ab@benettiengineering.com>
Date:   Thu, 28 Sep 2023 20:46:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phy: broadcom: add support for BCM5221 phy
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>,
        Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
References: <20230928175718.1729663-1-giulio.benetti@benettiengineering.com>
Content-Language: en-US
In-Reply-To: <20230928175718.1729663-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJ60XBJC9i6DJDK191Jq0WyR31QSoFnj1ce8QEnDE7MWnJVhYTdCgd8zILMXg8sUIYPCpSF8OU1T4G0VSZKEneSwGaSH3D5DE6qkJVMfA+QPUpGfhcTn
 P65cmsHwlXV+6twucBy11spWa0saxO7QrcaRj2dtnJl5OENkYlpbyY4mHeE3Uc2CzZPdkhN5FdetViV35MSP+86yBOlkKmdNaAjFDVOUHmT1N2G04vs49dXM
 t2OHu29yfW3RSWVegiti1SUHIedlKlHnxEGymoDmSWDl/S4ZSRhjhsDMrnr6WpdjnWQZOKZgzfgrHJFvoYDfFpQCqrB7wu8z7bw9R1pvFdsBf7V5mZb6nJaA
 WXCL2OG/fWh6dtBK0/BIMbTjDB6hrZG8WjXy5AN/aoCwB4f3xyREPRjFL+E9kgGePboAii2a8yaHdwTlWKZypDvvriSnfnbxar23f8LEkUmpE2+ENdBg3BCD
 B17js8tzjL8zW/g3NDBX+k/dtQMqo+hdGWOKHG0ZkR8DImGBgxakbZA8Xpa18hcbQz59A0v6uSTFrCi/XDflUnh5EmxkQGrKdWzBInQU1+w6XKP6ceYVdkXm
 YkT5+dzKKSip20BeiLXaXQJZbAgmdCdoBAi+6ztYo9Ezvt3QtnvkzKvD6cHhoVzw3ktCrEV1vPQg1clcMCBKx24v8Q9cvnC4fiCkoH+gTtkHHg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pardon, I've forgotten to rebase to master branch.

I'm going to send V3.
Sorry for the noise.

Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas

On 28/09/23 19:57, Giulio Benetti wrote:
> From: Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>
> 
> This patch adds the BCM5221 PHY support by reusing brcm_fet_*()
> callbacks and adding quirks for BCM5221 when needed.
> 
> Cc: Jim Reinhart <jimr@tekvox.com>
> Cc: James Autry <jautry@tekvox.com>
> Cc: Matthew Maron <matthewm@tekvox.com>
> Signed-off-by: Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>
> ---
> V1->V2:
> Suggested by Andrew Lunn:
> * handle mdix_ctrl adding bcm5221_config_aneg() and bcm5221_read_status()
> * reorder PHY_ID_BCM5241 in broadcom_tbl[]
> Suggested by Russell King:
> * add comment on phy_read(..., MII_BRCM_FET_INTREG)
> * lock mdio bus when in shadow mode
> Suggested by Florian Fainelli:
> * reuse brcm_fet_*() callbacks checking for phy_id == PHY_ID_BCM5221
> ---
>   drivers/net/phy/broadcom.c | 155 +++++++++++++++++++++++++++++--------
>   include/linux/brcmphy.h    |  10 +++
>   2 files changed, 132 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
> index 6f5e8be73d9a..4b71207037d0 100644
> --- a/drivers/net/phy/broadcom.c
> +++ b/drivers/net/phy/broadcom.c
> @@ -648,16 +648,21 @@ static int brcm_fet_config_init(struct phy_device *phydev)
>   	if (err < 0 && err != -EIO)
>   		return err;
>   
> +	/* Read to clear status bits */
>   	reg = phy_read(phydev, MII_BRCM_FET_INTREG);
>   	if (reg < 0)
>   		return reg;
>   
>   	/* Unmask events we are interested in and mask interrupts globally. */
> -	reg = MII_BRCM_FET_IR_DUPLEX_EN |
> -	      MII_BRCM_FET_IR_SPEED_EN |
> -	      MII_BRCM_FET_IR_LINK_EN |
> -	      MII_BRCM_FET_IR_ENABLE |
> -	      MII_BRCM_FET_IR_MASK;
> +	if (phydev->phy_id == PHY_ID_BCM5221)
> +		reg = MII_BRCM_FET_IR_ENABLE |
> +		MII_BRCM_FET_IR_MASK;
> +	else
> +		reg = MII_BRCM_FET_IR_DUPLEX_EN |
> +		MII_BRCM_FET_IR_SPEED_EN |
> +		MII_BRCM_FET_IR_LINK_EN |
> +		MII_BRCM_FET_IR_ENABLE |
> +		MII_BRCM_FET_IR_MASK;
>   
>   	err = phy_write(phydev, MII_BRCM_FET_INTREG, reg);
>   	if (err < 0)
> @@ -670,42 +675,50 @@ static int brcm_fet_config_init(struct phy_device *phydev)
>   
>   	reg = brcmtest | MII_BRCM_FET_BT_SRE;
>   
> -	err = phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
> -	if (err < 0)
> -		return err;
> +	phy_lock_mdio_bus(phydev);
>   
> -	/* Set the LED mode */
> -	reg = phy_read(phydev, MII_BRCM_FET_SHDW_AUXMODE4);
> -	if (reg < 0) {
> -		err = reg;
> -		goto done;
> +	err = __phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
> +	if (err < 0) {
> +		phy_unlock_mdio_bus(phydev);
> +		return err;
>   	}
>   
> -	reg &= ~MII_BRCM_FET_SHDW_AM4_LED_MASK;
> -	reg |= MII_BRCM_FET_SHDW_AM4_LED_MODE1;
> +	if (phydev->phy_id != PHY_ID_BCM5221) {
> +		/* Set the LED mode */
> +		reg = __phy_read(phydev, MII_BRCM_FET_SHDW_AUXMODE4);
> +		if (reg < 0) {
> +			err = reg;
> +			goto done;
> +		}
>   
> -	err = phy_write(phydev, MII_BRCM_FET_SHDW_AUXMODE4, reg);
> -	if (err < 0)
> -		goto done;
> +		reg &= ~MII_BRCM_FET_SHDW_AM4_LED_MASK;
> +		reg |= MII_BRCM_FET_SHDW_AM4_LED_MODE1;
>   
> -	/* Enable auto MDIX */
> -	err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_MISCCTRL,
> -			   MII_BRCM_FET_SHDW_MC_FAME);
> -	if (err < 0)
> -		goto done;
> +		err = __phy_write(phydev, MII_BRCM_FET_SHDW_AUXMODE4, reg);
> +		if (err < 0)
> +			goto done;
> +
> +		/* Enable auto MDIX */
> +		err = __phy_set_bits(phydev, MII_BRCM_FET_SHDW_MISCCTRL,
> +				     MII_BRCM_FET_SHDW_MC_FAME);
> +		if (err < 0)
> +			goto done;
> +	}
>   
>   	if (phydev->dev_flags & PHY_BRCM_AUTO_PWRDWN_ENABLE) {
>   		/* Enable auto power down */
> -		err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXSTAT2,
> -				   MII_BRCM_FET_SHDW_AS2_APDE);
> +		err = __phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXSTAT2,
> +				     MII_BRCM_FET_SHDW_AS2_APDE);
>   	}
>   
>   done:
>   	/* Disable shadow register access */
> -	err2 = phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
> +	err2 = __phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
>   	if (!err)
>   		err = err2;
>   
> +	phy_unlock_mdio_bus(phydev);
> +
>   	return err;
>   }
>   
> @@ -784,23 +797,86 @@ static int brcm_fet_suspend(struct phy_device *phydev)
>   
>   	reg = brcmtest | MII_BRCM_FET_BT_SRE;
>   
> -	err = phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
> -	if (err < 0)
> +	phy_lock_mdio_bus(phydev);
> +
> +	err = __phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
> +	if (err < 0) {
> +		phy_unlock_mdio_bus(phydev);
>   		return err;
> +	}
> +
> +	if (phydev->phy_id == PHY_ID_BCM5221)
> +		/* Force Low Power Mode with clock enabled */
> +		reg = BCM5221_SHDW_AM4_EN_CLK_LPM | BCM5221_SHDW_AM4_FORCE_LPM;
> +	else
> +		/* Set standby mode */
> +		reg = MII_BRCM_FET_SHDW_AM4_STANDBY;
>   
> -	/* Set standby mode */
> -	err = phy_modify(phydev, MII_BRCM_FET_SHDW_AUXMODE4,
> -			 MII_BRCM_FET_SHDW_AM4_STANDBY,
> -			 MII_BRCM_FET_SHDW_AM4_STANDBY);
> +	err = __phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXMODE4, reg);
>   
>   	/* Disable shadow register access */
> -	err2 = phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
> +	err2 = __phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
>   	if (!err)
>   		err = err2;
>   
> +	phy_unlock_mdio_bus(phydev);
> +
>   	return err;
>   }
>   
> +static int bcm5221_config_aneg(struct phy_device *phydev)
> +{
> +	int ret, val;
> +
> +	ret = genphy_config_aneg(phydev);
> +	if (ret)
> +		return ret;
> +
> +	switch (phydev->mdix_ctrl) {
> +	case ETH_TP_MDI:
> +		val = BCM5221_AEGSR_MDIX_DIS;
> +		break;
> +	case ETH_TP_MDI_X:
> +		val = BCM5221_AEGSR_MDIX_DIS | BCM5221_AEGSR_MDIX_MAN_SWAP;
> +		break;
> +	case ETH_TP_MDI_AUTO:
> +		val = 0;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	return phy_modify(phydev, BCM5221_AEGSR, BCM5221_AEGSR_MDIX_MAN_SWAP |
> +						 BCM5221_AEGSR_MDIX_DIS,
> +						 val);
> +}
> +
> +static int bcm5221_read_status(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* Read MDIX status */
> +	ret = phy_read(phydev, BCM5221_AEGSR);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret & BCM5221_AEGSR_MDIX_DIS) {
> +		if (ret & BCM5221_AEGSR_MDIX_MAN_SWAP)
> +			phydev->mdix_ctrl = ETH_TP_MDI_X;
> +		else
> +			phydev->mdix_ctrl = ETH_TP_MDI;
> +	} else {
> +		phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
> +	}
> +
> +	if (ret & BCM5221_AEGSR_MDIX_STATUS)
> +		phydev->mdix = ETH_TP_MDI_X;
> +	else
> +		phydev->mdix = ETH_TP_MDI;
> +
> +	return genphy_read_status(phydev);
> +}
> +
>   static int bcm54xx_phy_probe(struct phy_device *phydev)
>   {
>   	struct bcm54xx_phy_priv *priv;
> @@ -1082,6 +1158,18 @@ static struct phy_driver broadcom_drivers[] = {
>   	.handle_interrupt = brcm_fet_handle_interrupt,
>   	.suspend	= brcm_fet_suspend,
>   	.resume		= brcm_fet_config_init,
> +}, {
> +	.phy_id		= PHY_ID_BCM5221,
> +	.phy_id_mask	= 0xfffffff0,
> +	.name		= "Broadcom BCM5221",
> +	/* PHY_BASIC_FEATURES */
> +	.config_init	= brcm_fet_config_init,
> +	.config_intr	= brcm_fet_config_intr,
> +	.handle_interrupt = brcm_fet_handle_interrupt,
> +	.suspend	= brcm_fet_suspend,
> +	.resume		= brcm_fet_config_init,
> +	.config_aneg	= bcm5221_config_aneg,
> +	.read_status	= bcm5221_read_status,
>   }, {
>   	.phy_id		= PHY_ID_BCM5395,
>   	.phy_id_mask	= 0xfffffff0,
> @@ -1154,6 +1242,7 @@ static struct mdio_device_id __maybe_unused broadcom_tbl[] = {
>   	{ PHY_ID_BCM50610M, 0xfffffff0 },
>   	{ PHY_ID_BCM57780, 0xfffffff0 },
>   	{ PHY_ID_BCMAC131, 0xfffffff0 },
> +	{ PHY_ID_BCM5221, 0xfffffff0 },
>   	{ PHY_ID_BCM5241, 0xfffffff0 },
>   	{ PHY_ID_BCM5395, 0xfffffff0 },
>   	{ PHY_ID_BCM53125, 0xfffffff0 },
> diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
> index 9e77165f3ef6..ee1c8160e4d5 100644
> --- a/include/linux/brcmphy.h
> +++ b/include/linux/brcmphy.h
> @@ -12,6 +12,7 @@
>   #define PHY_ID_BCM50610			0x0143bd60
>   #define PHY_ID_BCM50610M		0x0143bd70
>   #define PHY_ID_BCM5241			0x0143bc30
> +#define PHY_ID_BCM5221			0x004061e0
>   #define PHY_ID_BCMAC131			0x0143bc70
>   #define PHY_ID_BCM5481			0x0143bca0
>   #define PHY_ID_BCM5395			0x0143bcf0
> @@ -272,6 +273,15 @@
>   #define BCM54612E_EXP_SPARE0		(MII_BCM54XX_EXP_SEL_ETC + 0x34)
>   #define BCM54612E_LED4_CLK125OUT_EN	(1 << 1)
>   
> +/* BCM5221 Registers */
> +#define BCM5221_AEGSR			0x1C
> +#define BCM5221_AEGSR_MDIX_STATUS	BIT(13)
> +#define BCM5221_AEGSR_MDIX_MAN_SWAP	BIT(12)
> +#define BCM5221_AEGSR_MDIX_DIS		BIT(11)
> +
> +#define BCM5221_SHDW_AM4_EN_CLK_LPM	BIT(2)
> +#define BCM5221_SHDW_AM4_FORCE_LPM	BIT(1)
> +
>   /*****************************************************************************/
>   /* Fast Ethernet Transceiver definitions. */
>   /*****************************************************************************/

