Return-Path: <linux-kernel+bounces-147762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580C8A7958
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F571F22FC9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14E213AA44;
	Tue, 16 Apr 2024 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DQsj77kK"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3D53B2A6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713311329; cv=none; b=jYN11K94xwMWw69WmEL4ENZ9nUdOLDMUEW2I5e2HFFuj0pnzjjBSwpnnXlimv5ue6Dr8J+/WGykX/SBHnJdZTZRGy/bT+kpjhRl/IbfMUqylIuhGnjMpqh17I87ztCPkEsCgQyA8FgzQIH9/dgbhx99svD/vnz/cdMFS7wBz55E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713311329; c=relaxed/simple;
	bh=/t2jaeTR1HEWQM7TECKiGQbkyE6b/hoJwZnjLhBOLpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxDqfGPjVdqVomIWD08dP3N3TuRJxB7wefUilFO6nYx/aJul+My9/EjA8PF9khALkoSwxDVUk2ZzQJdcP0oUh2re2IT6gGGmbKzNSer+s5suDftX5lvQkxkvXpxFbOqcL42WDQKt9YLvkzEZXFam95aO+HYR5f1tO2ST4lswe8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DQsj77kK; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4347e55066cso19567441cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713311326; x=1713916126; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bA4y7B4vtX3cVTLrK0KhmofaBtcISyRZFye2zuFzoqY=;
        b=DQsj77kKX0VQwDNqt3hOUvZerw2Ar4ck9x+VQbf2XluJNM/mIoKAoL4OTtfdLzolac
         Wq+DCQ9O+tvESgwm7bkOEEpgJh79otQCJYLAl+reKSfgYwqZItkEyQ6aTO44Umj7yZVH
         l4nczNU5usOBe548K/0vxMxlZu+Z5ZmpMhZCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713311326; x=1713916126;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bA4y7B4vtX3cVTLrK0KhmofaBtcISyRZFye2zuFzoqY=;
        b=C/7aIc16CtPZ6jTJec1oRoUT253fqM8tZ3Rp1mbNNbBCWhaIFxQVAI3VufmbCQzcbI
         3OYgAcZxbi9nwI4K9NJu1P6lEQoROyJnliLdZwSl6jj2XhkWjkxIbfxwbRrSR4xKpPsS
         ZhCi8mWwjsNVhV18zOcUiJASNHrnza+aa+Z5vYK6zmpBlN41ly183jOZE9/yY9swa3Mj
         x8rzI1kQELjUbXuaFAZhOHCAPKd5kSiInczYQVVIpamUIBv0M9Qx5IMm2/nJYMgmCvUf
         EkaM2r1JMepFptTK1Z3WXOyYENrBdePjSNipLlt7XCeG65P9N52la4JOTiUGW+NFDdTr
         U+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXT9LPmcTmKwr3djEIfzSawrnKTWSH4DVmpxvcWADkKo0YcdSZ2z9mntLd3dYwMfpN2ETqpNhN3Qmt1GCZGvusAAJ/doknrbaz2rjrB
X-Gm-Message-State: AOJu0YxrkCBh+Eje/Fa/0+9kJcX/q/OoIiZiEPYQ7OCef+3svmTwmMwK
	Or2HidovyWWxZ70Q0cV5NwMq+CIlQJBC+Ddp8YFXftsh7JjttWlxGtuWnxP73g==
X-Google-Smtp-Source: AGHT+IGsI2LiohfvORaUI7Wf72uNtRfgOs8lYShMrp/Pr/jK2baFKN9ABj3NG90CHPQBJgVp8bicJw==
X-Received: by 2002:ac8:5f46:0:b0:437:a1e:5eb0 with SMTP id y6-20020ac85f46000000b004370a1e5eb0mr7569754qta.14.1713311326372;
        Tue, 16 Apr 2024 16:48:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 17-20020a05620a04d100b0078d693c0b4bsm7885379qks.135.2024.04.16.16.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 16:48:44 -0700 (PDT)
Message-ID: <96dc827a-9f4b-4b9a-8577-170cb335bebf@broadcom.com>
Date: Tue, 16 Apr 2024 16:48:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: bcm54811: add support for BroadR-Reach mode
To: =?UTF-8?Q?Kamil_Hor=C3=A1k_-_2N?= <kamilh@axis.com>,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240416123811.1880177-1-kamilh@axis.com>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20240416123811.1880177-1-kamilh@axis.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000061a1b06163f6121"

--000000000000061a1b06163f6121
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/16/24 05:38, Kamil Horák - 2N wrote:
> Enable the BroadR-Reach link modes for BCM54811 PHY by Broadcom.
> This allows for two-wire Ethernet at 10 or 100MBit using BroadR-Reach
> mode and also for other BroadR-Reach modes using more than one pair.

In terms of organization, it seems like you could do at least 3 patches:

- one patch that adds the new BroadR-Reach link modes and ethtool plumbing
- one patch that adds all of the register definitions to brcmphy.h which 
can be easily skipped
- one patch that updates broadcom.c and bcm-phy-lib.[ch] to implement 
BroadR-Reach

I am happy that you introduced an ethtool tunable, rather than key it 
off Device Tree or module parameter, so kudos for doing that!

Need to wrap my head a bit as to what to do with the overlapping 
register mapping, and whether it would not be simpler to do some sort of 
register level remapping of values, rather than provide different 
callbacks for read_status, config_aneg, etc.

> 
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
> ---
>   drivers/net/phy/broadcom.c   | 432 ++++++++++++++++++++++++++++++++++-
>   drivers/net/phy/phy-core.c   |  13 +-
>   include/linux/brcmphy.h      |  91 +++++++-
>   include/uapi/linux/ethtool.h |  13 +-
>   net/ethtool/common.c         |  31 +++
>   net/ethtool/ioctl.c          |   1 +
>   net/ipv4/tcp.c               |   2 +-

This file should really not be modified, you must have made this 
temporary change to build test your changes, but this is now fixed in 
net-next as of a few days ago.

>   7 files changed, 567 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
> index 370e4ed45098..aeb49b566aca 100644
> --- a/drivers/net/phy/broadcom.c
> +++ b/drivers/net/phy/broadcom.c
> @@ -553,18 +553,46 @@ static int bcm54810_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
>   	return -EOPNOTSUPP;
>   }
>   
> -static int bcm54811_config_init(struct phy_device *phydev)
> +static int bcm54811_get_brrmode(struct phy_device *phydev, u8 *data)
>   {
> -	int err, reg;
> +	int reg;
>   
> -	/* Disable BroadR-Reach function. */
>   	reg = bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
> -	reg &= ~BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
> -	err = bcm_phy_write_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL,
> -				reg);
> -	if (err < 0)
> +
> +	*data = (reg & BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN) ?
> +				ETHTOOL_PHY_BRR_MODE_ON : ETHTOOL_PHY_BRR_MODE_OFF;
> +
> +	return 0;
> +}
> +
> +static int bcm54811_set_brrmode(struct phy_device *phydev, u8 on)
> +{
> +	int reg;
> +	int err;
> +
> +	reg = bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
> +
> +	if (on)
> +		reg |= BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
> +	else
> +		reg &= ~BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
> +
> +	err = bcm_phy_write_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL, reg);
> +	if (err)
>   		return err;
>   
> +	/* Ensure LRE or IEEE register set is accessed according to the brr on/off,
> +	 *  thus set the override
> +	 */
> +	return bcm_phy_write_exp(phydev, BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL,
> +		BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_EN |
> +		on ? 0 : BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL);
> +}
> +
> +static int bcm54811_config_init(struct phy_device *phydev)
> +{
> +	int err, reg;
> +
>   	err = bcm54xx_config_init(phydev);
>   
>   	/* Enable CLK125 MUX on LED4 if ref clock is enabled. */
> @@ -576,16 +604,151 @@ static int bcm54811_config_init(struct phy_device *phydev)
>   			return err;
>   	}
>   
> -	return err;
> +	/* Configure BroadR-Reach function. */
> +	return  bcm54811_set_brrmode(phydev, ETHTOOL_PHY_BRR_MODE_OFF);
> +}
> +
> +static int bcm_setup_master_slave(struct phy_device *phydev)

The namespace in this driver is such that we prefix with bcm54xx_ or 
bcm<phy number>, this is generic so this could go to bcm-phy-lib.[ch] as 
a matter of fact.

> +{
> +	u16 ctl = 0;
> +
> +	switch (phydev->master_slave_set) {
> +	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
> +	case MASTER_SLAVE_CFG_MASTER_FORCE:
> +		ctl = LRECR_MASTER;
> +		break;
> +	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
> +		break;
> +	case MASTER_SLAVE_CFG_SLAVE_FORCE:
> +		break;
> +	case MASTER_SLAVE_CFG_UNKNOWN:
> +	case MASTER_SLAVE_CFG_UNSUPPORTED:
> +		return 0;
> +	default:
> +		phydev_warn(phydev, "Unsupported Master/Slave mode\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return phy_modify_changed(phydev, MII_BCM54XX_LRECR, LRECR_MASTER, ctl);
> +}
> +
> +static int bcm_setup_forced(struct phy_device *phydev)
> +{
> +	u16 ctl = 0;
> +
> +	phydev->pause = 0;
> +	phydev->asym_pause = 0;
> +
> +	if (phydev->speed == SPEED_100)
> +		ctl |= LRECR_SPEED100;
> +
> +	if (phydev->duplex != DUPLEX_FULL)
> +		return -EOPNOTSUPP;
> +
> +	return phy_modify(phydev, MII_BCM54XX_LRECR, LRECR_SPEED100, ctl);
> +}
> +
> +/**
> + * bcm_linkmode_adv_to_mii_adv_t
> + * @advertising: the linkmode advertisement settings
> + *
> + * A small helper function that translates linkmode advertisement
> + * settings to phy autonegotiation advertisements for the
> + * MII_BCM54XX_LREANAA register.
> + */
> +static inline u32 bcm_linkmode_adv_to_mii_adv_t(unsigned long *advertising)
> +{
> +	u32 result = 0;
> +
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1BR10_BIT, advertising))
> +		result |= LREANAA_10_1PAIR;
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2BR10_BIT, advertising))
> +		result |= LREANAA_10_2PAIR;
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1BR100_BIT, advertising))
> +		result |= LREANAA_100_1PAIR;
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2BR100_BIT, advertising))
> +		result |= LREANAA_100_2PAIR;
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_4BR100_BIT, advertising))
> +		result |= LREANAA_100_4PAIR;
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT, advertising))
> +		result |= LRELPA_PAUSE;
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, advertising))
> +		result |= LRELPA_PAUSE_ASYM;
> +
> +	return result;
> +}
> +
> +/**
> + * bcm_config_advert - sanitize and advertise auto-negotiation parameters
> + * @phydev: target phy_device struct
> + *
> + * Description: Writes MII_BCM54XX_LREANAA with the appropriate values,
> + *   after sanitizing the values to make sure we only advertise
> + *   what is supported.  Returns < 0 on error, 0 if the PHY's advertisement
> + *   hasn't changed, and > 0 if it has changed.
> + */
> +static int bcm_config_advert(struct phy_device *phydev)
> +{
> +	int err;
> +	u32 adv;
> +
> +	/* Only allow advertising what this PHY supports */
> +	linkmode_and(phydev->advertising, phydev->advertising,
> +		     phydev->supported);
> +
> +	adv = bcm_linkmode_adv_to_mii_adv_t(phydev->advertising);
> +
> +	/* Setup BroadR-Reach mode advertisement */
> +	err = phy_modify_changed(phydev, MII_BCM54XX_LREANAA,
> +				 LRE_ADVERTISE_ALL | LREANAA_PAUSE |
> +				 LREANAA_PAUSE_ASYM, adv);
> +
> +	if (err < 0)
> +		return err;
> +
> +	return err > 0 ? 1 : 0;
> +}
> +
> +static int bcm_config_aneg(struct phy_device *phydev, bool changed)
> +{
> +	int err;
> +
> +	if (genphy_config_eee_advert(phydev))
> +		changed = true;
> +
> +	err = bcm_setup_master_slave(phydev);
> +	if (err < 0)
> +		return err;
> +	else if (err)
> +		changed = true;
> +
> +	if (phydev->autoneg != AUTONEG_ENABLE)
> +		return bcm_setup_forced(phydev);
> +
> +	err = bcm_config_advert(phydev);
> +	if (err < 0) /* error */
> +		return err;
> +	else if (err)
> +		changed = true;
> +
> +	return genphy_check_and_restart_aneg(phydev, changed);
>   }
>   
>   static int bcm5481_config_aneg(struct phy_device *phydev)
>   {

I would create a bcm54811_config_aneg() function here which checks for 
the BRR mode.

>   	struct device_node *np = phydev->mdio.dev.of_node;
>   	int ret;
> +	u8 brr_mode;
>   
>   	/* Aneg firstly. */
> -	ret = genphy_config_aneg(phydev);
> +	ret = bcm54811_get_brrmode(phydev, &brr_mode);
> +	if (ret)
> +		return ret;
> +
> +	if (brr_mode == ETHTOOL_PHY_BRR_MODE_ON)
> +		ret = bcm_config_aneg(phydev, false);
> +	else
> +		ret = genphy_config_aneg(phydev);
>   
>   	/* Then we can set up the delay. */
>   	bcm54xx_config_clock_delay(phydev);
> @@ -1062,6 +1225,253 @@ static void bcm54xx_link_change_notify(struct phy_device *phydev)
>   	bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_EXP08, ret);
>   }
>   
> +static int bcm54811_read_abilities(struct phy_device *phydev)
> +{
> +	int val, err;
> +	int i;
> +	static const int modes_array[] = {ETHTOOL_LINK_MODE_1BR100_BIT,
> +					  ETHTOOL_LINK_MODE_4BR100_BIT,
> +					  ETHTOOL_LINK_MODE_2BR100_BIT,
> +					  ETHTOOL_LINK_MODE_2BR10_BIT,
> +					  ETHTOOL_LINK_MODE_1BR10_BIT,
> +					  ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +					  ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
> +					  ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
> +					  ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +					  ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> +					  ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> +					  ETHTOOL_LINK_MODE_10baseT_Half_BIT};
> +
> +	u8 brr_mode;
> +
> +	for (i = 0; i < ARRAY_SIZE(modes_array); i++)
> +		linkmode_clear_bit(modes_array[i], phydev->supported);
> +
> +	err = bcm54811_get_brrmode(phydev, &brr_mode);
> +
> +	if (!err) {

Please do an early return so you can reduce the indentation here, and 
elsewhere, too.
-- 
Florian


--000000000000061a1b06163f6121
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHhy11smduKGTTiN
gi8iRlH9ZnI4wNzLuUbQhoXqvRmhMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDQxNjIzNDg0NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCupQR4mgRjiPQtfiYpgaiIGqIrj7bkct3m
BtxY8+XT+brR1yANCjpzWjPxyDJoKWXaHgyH12T57QSKig1ctDkXpCeZ5hnKACCk+4dkjR6x3E6p
fc4lXQUWCnOKeyamGIF9P9/zC1mDZWq3A07Kjft5hGYU+oPrZXrEI+6bYFusIZEyk6nU+gguc7z8
zT/ILrHQ1rT/Vt21gwnoU3KJ7i911PNhtiDHDtIMrE0k7tMVEyrTWV3UN4TAUUjFUsqC6sF6+5rb
twd4i4FOt3W7+NGThUgAoOtHAPf4Q9NCxdAEBURR+OGoZ5GPhgLm1MXWS0dG09DotDLIKa+TU0tv
q/Sm
--000000000000061a1b06163f6121--

