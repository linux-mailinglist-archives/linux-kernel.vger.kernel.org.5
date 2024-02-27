Return-Path: <linux-kernel+bounces-83007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8BE868CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFFE2285E69
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8978138485;
	Tue, 27 Feb 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sm0n5pQF"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02613699F;
	Tue, 27 Feb 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028496; cv=none; b=CBPpsfNSWs0+NhfviOIpkV9GgXsV8f26lFxEF2/yQpxq6ZL2drl8ZWqXfboeowkt9/DNuatFuvIgLJxHi9NV+NUEEtT2tNp/5zNJWukCCuldV9MMTzRqqpOA/caDNXHvBojju0GJ3c7lfsAmDPJ1LpwXZXJPIlT5LeHZsx3YNKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028496; c=relaxed/simple;
	bh=gayX3MThRtKAbxiT63s1KOxQeJc59MH4mNLhm21wvus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+VKAqoM62FmadKG8l7GM4+ymUCYjuhNDhRSQGtatYEw9oNH1OdlEpRByzM7aDEykKc5OZps2xH+HIfIkrV7JQGlqlWXwOFvxxZdjXU8nNt0d58hK92BODU8nL6Z/lZ0Yrgw5ER4okXPpoRMrKhYqS1e8zoPZl3aYU6I8K5nq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sm0n5pQF; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B79C240008;
	Tue, 27 Feb 2024 10:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709028486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvLaYo71E/i5pWv7T61eLjy9zgmIF4EWr3dIPInc76E=;
	b=Sm0n5pQFxXJLkiaB1TAaCuo0oEs+Mv9KG/JGBjQ91ZO5oPkAegydRj38YtkVb6gEQ8TBGh
	Obumgxy9ZP2JClMj0wIprCxMKrLtD29lZbBFNu28M5SXXAIA7WmTQlSepiTjtAQLUjuVGS
	o2Xadk0RaiA/446C7RrtFdY6k1bGuhNfDT2LnpRmSZhKlfWR4Awkf1q7LGu3R31kltysjQ
	j9H7+dpJUj6qS67T7BAy03eSeUkLRY8t9H3mK2smKAzwQJrbW1hNhgsYHhAZe8QEr7Sl7x
	hQ9dJnLSqTGkOzOQaCofynCSP9bfxCY6/ZtUXDA8dN/3eMNMvsJqwL7nEM0uKg==
Date: Tue, 27 Feb 2024 11:08:02 +0100
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
Subject: Re: [PATCH v2 5/6] net: phy: DP83640: Explicitly disabling PHY
 Control Frames
Message-ID: <20240227110802.552bff55@device-28.home>
In-Reply-To: <20240227093945.21525-6-bastien.curutchet@bootlin.com>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
	<20240227093945.21525-6-bastien.curutchet@bootlin.com>
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

Hi Bastien,

On Tue, 27 Feb 2024 10:39:44 +0100
Bastien Curutchet <bastien.curutchet@bootlin.com> wrote:

> The PHY offers a PHY control frame feature that allows to access PHY
> registers through the MAC transmit data interface. This functionality
> is not handled by the driver but can be enabled via hardware strap or
> register access.
> 
> Disable the feature in config_init() to save some latency on MII packets.
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
>  drivers/net/phy/dp83640.c     | 6 ++++++
>  drivers/net/phy/dp83640_reg.h | 4 ++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
> index 16c9fda50b19..b371dea23937 100644
> --- a/drivers/net/phy/dp83640.c
> +++ b/drivers/net/phy/dp83640.c
> @@ -1120,6 +1120,7 @@ static int dp83640_config_init(struct phy_device *phydev)
>  {
>  	struct dp83640_private *dp83640 = phydev->priv;
>  	struct dp83640_clock *clock = dp83640->clock;
> +	int val;
>  
>  	if (clock->chosen && !list_empty(&clock->phylist))
>  		recalibrate(clock);
> @@ -1135,6 +1136,11 @@ static int dp83640_config_init(struct phy_device *phydev)
>  	ext_write(0, phydev, PAGE4, PTP_CTL, PTP_ENABLE);
>  	mutex_unlock(&clock->extreg_lock);
>  
> +	/* Disable unused PHY control frames */
> +	phy_write(phydev, PAGESEL, 0);
> +	val = phy_read(phydev, PCFCR) & ~PCF_EN;
> +	phy_write(phydev, PCFCR, val);

Use phy_modify instead, and you might also want to look at the paging.
The ext_write before apparently does some page-management itself through
the clock struct (?).

> +
>  	return 0;
>  }
>  
> diff --git a/drivers/net/phy/dp83640_reg.h b/drivers/net/phy/dp83640_reg.h
> index bf34d422d91e..b5adb8958c08 100644
> --- a/drivers/net/phy/dp83640_reg.h
> +++ b/drivers/net/phy/dp83640_reg.h
> @@ -10,6 +10,7 @@
>  #define PHYCR                     0x0019 /* PHY Control Register */
>  #define PHYCR2                    0x001c /* PHY Control Register 2 */
>  #define EDCR                      0x001D /* Energy Detect Control Register */
> +#define PCFCR                     0x001F /* PHY Control Frames Control Register */
>  
>  #define PAGE4                     0x0004
>  #define PTP_CTL                   0x0014 /* PTP Control Register */
> @@ -68,6 +69,9 @@
>  /* Bit definitions for the EDCR register */
>  #define ED_EN		          BIT(15) /* Enable Energy Detect Mode */
>  
> +/* Bit definitions for the PCFCR register */
> +#define PCF_EN                    BIT(0)  /* Enable PHY Control Frames */
> +
>  /* Bit definitions for the PTP_CTL register */
>  #define TRIG_SEL_SHIFT            (10)    /* PTP Trigger Select */
>  #define TRIG_SEL_MASK             (0x7)

Thanks,

Maxime

