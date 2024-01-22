Return-Path: <linux-kernel+bounces-32450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AB8835BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816411F2254E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6011C18AF1;
	Mon, 22 Jan 2024 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RZDNb1BD"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CCF18053;
	Mon, 22 Jan 2024 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909412; cv=none; b=i40sBpfs8X36hpnpSSf5iubDe87CeD32Foi2hPnhuVdS4mFAgGs5xjsE3bVn+U/drup3bTrI2CAKaRW2BEY2Z8QsHBfnl5Cik/mr7+v/WEL9lSBDLgHkBSNHrQWdo3FXrN1HFh0+uxp4EbJhkf2/HWdD8jiiyRfPYA0w5KDMA0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909412; c=relaxed/simple;
	bh=S066ACWnpDFLMSrXOafm8Oz7IICr0G50mN3vio3lPcA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sfp1II7px3CG0efaZ/cZcem720UKjLTO6/5oSJrioy3IlbccMZmsJy6vOkG3J1UkemGK0J1VZmbkbGDQAKR0f2KT8dO8/95KTNbNnHnLSRcm+mGiEobdGWBUIFVWT05Wi74i/qMyfko0XYK2Mpbd68LVkQ0xI8juG7dMn55xNzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RZDNb1BD; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705909410; x=1737445410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S066ACWnpDFLMSrXOafm8Oz7IICr0G50mN3vio3lPcA=;
  b=RZDNb1BDFFOCDaT1zHk7jFg2vlyTZcGj1zEVITh6E9crOUgG/tzgQHSm
   G7RQk8DQz91v+GVNQ+XJDhKJMJMF7loV4aH9ylgnGMV9SGsUE/HBr0j9x
   K6esp+0k7+gTAZEikrusd1RkywtibjFw0nwk4axtYUenhli9NsQbtUGA4
   Oyr+SAq5+Fz26mu73kIM2/KiCOz+wT8JXrNe6kM8awbEmH/JnoYRIKvUj
   3c2AMo6sD6EIx/Hvi3R9fHi25kQMtswFed7Z1Gev65FBGLWfktWKGJLU+
   ezd9AzQjp4Plu1CZodrt9FI5fL+QT75i2jyZeFTJj10P3jUiKTtzhpgV7
   Q==;
X-CSE-ConnectionGUID: ulOQJgl/RJCokYS78RbMAw==
X-CSE-MsgGUID: 97GFvzoATnCDFpPTLTbNmw==
X-IronPort-AV: E=Sophos;i="6.05,211,1701154800"; 
   d="scan'208";a="182323138"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2024 00:43:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 00:42:59 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 22 Jan 2024 00:42:59 -0700
Date: Mon, 22 Jan 2024 08:42:58 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Andre Werner <andre.werner@systec-electronic.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v4 2/2] net: phy: adin1100: Add interrupt support
 for link change
Message-ID: <20240122074258.zmbzngrl7dzhkvwo@DEN-DL-M31836.microchip.com>
References: <20240121201511.8997-1-andre.werner@systec-electronic.com>
 <20240121201511.8997-3-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240121201511.8997-3-andre.werner@systec-electronic.com>

The 01/21/2024 20:54, Andre Werner wrote:

Hi Andre,

 
> An interrupt handler was added to the driver as well as functions
> to enable interrupts at the phy.
> 
> There are several interrupts maskable at the phy, but only link change
> interrupts are handled by the driver yet.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> ---
> v4:
> - Change read-modify-write behavior as suggested to phy_modify_mmd.

Usually it is good to keep the change log also from the previous
versions, so it is easier to see what has been changed.

> ---
>  drivers/net/phy/adin1100.c | 56 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
> index 7619d6185801..7c82384e5d30 100644
> --- a/drivers/net/phy/adin1100.c
> +++ b/drivers/net/phy/adin1100.c
> @@ -18,6 +18,12 @@
>  #define PHY_ID_ADIN1110                                0x0283bc91
>  #define PHY_ID_ADIN2111                                0x0283bca1
> 
> +#define ADIN_PHY_SUBSYS_IRQ_MASK               0x0021
> +#define   ADIN_LINK_STAT_CHNG_IRQ_EN           BIT(1)
> +
> +#define ADIN_PHY_SUBSYS_IRQ_STATUS             0x0011
> +#define   ADIN_LINK_STAT_CHNG                  BIT(1)
> +
>  #define ADIN_FORCED_MODE                       0x8000
>  #define   ADIN_FORCED_MODE_EN                  BIT(0)
> 
> @@ -136,6 +142,54 @@ static int adin_config_aneg(struct phy_device *phydev)
>         return genphy_c45_config_aneg(phydev);
>  }
> 
> +static int adin_phy_ack_intr(struct phy_device *phydev)
> +{
> +       /* Clear pending interrupts */
> +       int rc = phy_read_mmd(phydev, MDIO_MMD_VEND2,
> +                             ADIN_PHY_SUBSYS_IRQ_STATUS);
> +
> +       return rc < 0 ? rc : 0;
> +}
> +
> +static int adin_config_intr(struct phy_device *phydev)
> +{
> +       int ret;
> +       u16 irq_mask;

Please use reverse x-mas notation here.

> +
> +       ret = adin_phy_ack_intr(phydev);
> +

No new line here, between ret and if.

> +       if (ret)
> +               return ret;
> +
> +       if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
> +               irq_mask = ADIN_LINK_STAT_CHNG_IRQ_EN;
> +       else
> +               irq_mask = 0;
> +
> +       return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> +                             ADIN_PHY_SUBSYS_IRQ_MASK,
> +                             ADIN_LINK_STAT_CHNG_IRQ_EN, irq_mask);
> +}
> +
> +static irqreturn_t adin_phy_handle_interrupt(struct phy_device *phydev)
> +{
> +       int irq_status;
> +
> +       irq_status = phy_read_mmd(phydev, MDIO_MMD_VEND2,
> +                                 ADIN_PHY_SUBSYS_IRQ_STATUS);
> +       if (irq_status < 0) {
> +               phy_error(phydev);
> +               return IRQ_NONE;
> +       }
> +
> +       if (!(irq_status & ADIN_LINK_STAT_CHNG))
> +               return IRQ_NONE;
> +
> +       phy_trigger_machine(phydev);
> +
> +       return IRQ_HANDLED;
> +}
> +
>  static int adin_set_powerdown_mode(struct phy_device *phydev, bool en)
>  {
>         int ret;
> @@ -275,6 +329,8 @@ static struct phy_driver adin_driver[] = {
>                 .probe                  = adin_probe,
>                 .config_aneg            = adin_config_aneg,
>                 .read_status            = adin_read_status,
> +               .config_intr            = adin_config_intr,
> +               .handle_interrupt       = adin_phy_handle_interrupt,
>                 .set_loopback           = adin_set_loopback,
>                 .suspend                = adin_suspend,
>                 .resume                 = adin_resume,
> --
> 2.43.0
> 
> 

-- 
/Horatiu

