Return-Path: <linux-kernel+bounces-83001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05402868CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812291F25DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490C6137C4D;
	Tue, 27 Feb 2024 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X8jHwrl1"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4D56458;
	Tue, 27 Feb 2024 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028136; cv=none; b=trKWuy9deZC7HbQPxFy+Kmm8i1iOOH16r6CKtFVj2EAA6BwTE3PHDNblqKBqxD6DQXbJUnf1W23dKXv/Iy5wgV+1rNjauBtvhCMP2FTAt1+/atC/LDviLqnOJsLWe1K5JPhWA6LmKhWkpgEvt2ZxFu+4st1Kn80z+Z9ZK2AH+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028136; c=relaxed/simple;
	bh=7nIAExb27VzZd+ZMdEZs3B/W61mFpex3pInwkyXMyFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDX1CU+sX8XXAWf/gqk4Pd9WTmQpO1YF9aZx92CPF4/SRPNruFBGPeGirNLZF52aPXM8A7Jl6KoCFaCiJS1FqyXZOhgSNq/WJ3jGK0ljcIyJ1dU6BwDibGB81RsNMNIulPOTOolUt8PWsvKv/ABktlGovg4+KvCkC2OoGDGJBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X8jHwrl1; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C7554000D;
	Tue, 27 Feb 2024 10:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709028131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toC0BLcNzV5oaad0xCRwQL4Yuij9ac2JxP6Ca2Pe4d8=;
	b=X8jHwrl1Qu/t9BdDhQ4UYrFg7RaYU5vpKIBpeDWLx6PMySBpPLD7cBmF4x+yYZeU//VXzy
	WgHyqEPbwaV7OZDo0nAVF2yRJM7/fiBCjHVczG0HMFWz9agRDGZxYSEv7wmXLUcfGtFAQ1
	/Phwrg9hf7ifgBOhz0MWzUUPQpbTK/MDMrrCyVwnnM/E+Tri7f6Y8wkr07bnJxr/3UoTo4
	WVauUecxk4Lq11X61Kix+6HI4y3aLbVBqjPPc/RaRqmRvSetZtguO85zmzVhdNfg1ypX7y
	tr1RUnX3xI8rmwT7WBIX195bwAI8nD1yzDuwg9Vv8ucD/Bav88J/KWSWQk5KIg==
Date: Tue, 27 Feb 2024 11:02:09 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-leds@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
Subject: Re: [PATCH v2 4/6] net: phy: DP83640: Add EDPD management
Message-ID: <20240227110209.552ba4ed@device-28.home>
In-Reply-To: <20240227093945.21525-5-bastien.curutchet@bootlin.com>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
	<20240227093945.21525-5-bastien.curutchet@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Bastien,

On Tue, 27 Feb 2024 10:39:43 +0100
Bastien Curutchet <bastien.curutchet@bootlin.com> wrote:

> The driver does not support enabling/disabling Energy Detect Power Down
> (EDPD).
> The PHY itself support EDPD.
> 
> Add missing part in the driver in order to have this support based on
> ethtool {set,get}_phy_tunable functions.
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
>  drivers/net/phy/dp83640.c     | 62 +++++++++++++++++++++++++++++++++++
>  drivers/net/phy/dp83640_reg.h |  4 +++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
> index c46c81ef0ad0..16c9fda50b19 100644
> --- a/drivers/net/phy/dp83640.c
> +++ b/drivers/net/phy/dp83640.c
> @@ -1531,6 +1531,66 @@ static void dp83640_remove(struct phy_device *phydev)
>  	kfree(dp83640);
>  }
>  
> +static int dp83640_get_edpd(struct phy_device *phydev, u16 *edpd)
> +{
> +	int val;
> +
> +	phy_write(phydev, PAGESEL, 0);

Same comment as the previous patch on paged accesses

> +	val = phy_read(phydev, EDCR);
> +	if (val & ED_EN)
> +		*edpd = 2000; /* 2 seconds */
> +	else
> +		*edpd = ETHTOOL_PHY_EDPD_DISABLE;
> +
> +	return 0;
> +}
> +
> +static int dp83640_set_edpd(struct phy_device *phydev, u16 edpd)
> +{
> +	int val;
> +
> +	phy_write(phydev, PAGESEL, 0);

ditto

> +	val = phy_read(phydev, EDCR);
> +
> +	switch (edpd) {
> +	case ETHTOOL_PHY_EDPD_DFLT_TX_MSECS:
> +	case 2000: /* 2 seconds */
> +		val |= ED_EN;
> +		break;
> +	case ETHTOOL_PHY_EDPD_DISABLE:
> +		val &= ~ED_EN;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	phy_write(phydev, EDCR, val);

Here you could use phy_clear_bits / phy_set_bits, which are flavors of
the phy_modify accessors.

> +
> +	return 0;
> +}
> +
> +static int dp83640_get_tunable(struct phy_device *phydev,
> +			       struct ethtool_tunable *tuna, void *data)
> +{
> +	switch (tuna->id) {
> +	case ETHTOOL_PHY_EDPD:
> +		return dp83640_get_edpd(phydev, data);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int dp83640_set_tunable(struct phy_device *phydev,
> +			       struct ethtool_tunable *tuna, const void *data)
> +{
> +	switch (tuna->id) {
> +	case ETHTOOL_PHY_EDPD:
> +		return dp83640_set_edpd(phydev, *(u16 *)data);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>  static int dp83640_led_brightness_set(struct phy_device *phydev, u8 index,
>  				      enum led_brightness brightness)
>  {
> @@ -1692,6 +1752,8 @@ static struct phy_driver dp83640_driver = {
>  	.name		= "NatSemi DP83640",
>  	/* PHY_BASIC_FEATURES */
>  	.probe		= dp83640_probe,
> +	.get_tunable    = dp83640_get_tunable,
> +	.set_tunable    = dp83640_set_tunable,
>  	.remove		= dp83640_remove,
>  	.soft_reset	= dp83640_soft_reset,
>  	.config_init	= dp83640_config_init,
> diff --git a/drivers/net/phy/dp83640_reg.h b/drivers/net/phy/dp83640_reg.h
> index 09dd2d2527c7..bf34d422d91e 100644
> --- a/drivers/net/phy/dp83640_reg.h
> +++ b/drivers/net/phy/dp83640_reg.h
> @@ -9,6 +9,7 @@
>  #define LEDCR                     0x0018 /* PHY Control Register */
>  #define PHYCR                     0x0019 /* PHY Control Register */
>  #define PHYCR2                    0x001c /* PHY Control Register 2 */
> +#define EDCR                      0x001D /* Energy Detect Control Register */
>  
>  #define PAGE4                     0x0004
>  #define PTP_CTL                   0x0014 /* PTP Control Register */
> @@ -64,6 +65,9 @@
>  /* Bit definitions for the PHYCR2 register */
>  #define BC_WRITE                  (1<<11) /* Broadcast Write Enable */
>  
> +/* Bit definitions for the EDCR register */
> +#define ED_EN		          BIT(15) /* Enable Energy Detect Mode */
> +
>  /* Bit definitions for the PTP_CTL register */
>  #define TRIG_SEL_SHIFT            (10)    /* PTP Trigger Select */
>  #define TRIG_SEL_MASK             (0x7)

Thanks,

Maxime

