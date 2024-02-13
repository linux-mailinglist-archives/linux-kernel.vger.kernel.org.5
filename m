Return-Path: <linux-kernel+bounces-63348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A844F852DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F06728322E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8952324A13;
	Tue, 13 Feb 2024 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yoETFqjZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5306C1EEF7;
	Tue, 13 Feb 2024 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820362; cv=none; b=Nxq5A8pLMr7vKvFlXjbxId9cG7XYeqmAEEMljJlc/xiieGNrecLEh8Ly8mqo4Ap3pgchwFDv5FMpmKS1KL6JGNTrEzAYA1wd5s1bb+GPA74Mk9A/iMu8SHlRIPLUj/YC41ClCo/3asAind+5cu4utcYYf7AN4OCZYW86grtTMXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820362; c=relaxed/simple;
	bh=JXf3FW715Hij2/rVgflMXeAgFq6KllbSfYEa5EbJNnY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kThBDMC4LMzklsE+KJqqUDY4sP6qKuD3qJUZIpkFna/KTlvg8IL8nWSW4p1UJ+0WRncKjrEoQ/YC+AN7vTeM02ASU8+di363QLyEpAt49w8/Dmvp0TnxNJk8dDyrstYj2JndnsGMHiYN8zXvsF7JKTTqLa7qS0KY+RsZcEN3o3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yoETFqjZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707820360; x=1739356360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JXf3FW715Hij2/rVgflMXeAgFq6KllbSfYEa5EbJNnY=;
  b=yoETFqjZ0XYy8xwqsMrpkY2aB5+NKM8zX1JGGQrcmLdC8Lz0D/hupoNU
   Ho5IJNVodwuxigMR1XEs8R6mLJIxa9h1UFatH8rk8WRKPed23DqX4gZLB
   eOIuQwbOIMec3bbyp5P5ezWdtSZpQgSXRbCbfNeJ3Vzw/Bz+/Gen6146A
   Dp5FR8k6vhKoP9L0F8dBeMEuL2l83W+Jff2FyxD471Czfply4jLaI03To
   iu/sOvRLg53+HXWaMIM2Rqggb56UKTK2GlbF0RnMvSjcPbFQUC/43AUu7
   oy9LmG9nUBn/Dlg4yi51N6MqHeLrKgT74+xOdNBxDBi65vPtTXBcpF1Vg
   w==;
X-CSE-ConnectionGUID: s6Tn9VPjQXCSnrMkzhF8Kg==
X-CSE-MsgGUID: iHJrIj/tRK+lriDzJMhb5g==
X-IronPort-AV: E=Sophos;i="6.06,156,1705388400"; 
   d="scan'208";a="16162729"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 03:32:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 03:31:57 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 13 Feb 2024 03:31:56 -0700
Date: Tue, 13 Feb 2024 11:31:56 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next 2/3] net: lan966x: Allow using PCH extension for
 PTP
Message-ID: <20240213103156.rl4kzwpmxn3haz7y@DEN-DL-M31836.microchip.com>
References: <20240212173307.1124120-1-maxime.chevallier@bootlin.com>
 <20240212173307.1124120-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240212173307.1124120-3-maxime.chevallier@bootlin.com>

The 02/12/2024 18:33, Maxime Chevallier wrote:
> [Some people who received this message don't often get email from maxime.chevallier@bootlin.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]

Hi Maxime,

I have tried your patches on pcb8291, which is a lan966x without PHYs
that support timestamping. And on this platform this patch breaks up the
things. Because it should just do the timestamping the MAC in that case,
but with this patch it doesn't get any time.
The same issue can be reproduced on pcb8280 and then disable PHY
timestamping, or change the lan8814 not to support HW timestamping.

Please see bellow the reason why.

> 
> +/* Enable or disable PCH timestamp transmission. This uses the USGMII PCH
> + * extensions to transmit the timestamps in the frame preamble.
> + */
> +static void lan966x_ptp_pch_configure(struct lan966x_port *port, bool *enable)
> +{
> +       struct phy_device *phydev = port->dev->phydev;
> +       int ret;
> +
> +       if (!phydev)
> +               *enable = false;
> +
> +       if (*enable) {
> +               /* If we cannot enable inband PCH mode, we fallback to classic
> +                * timestamping
> +                */
> +               if (phy_inband_ext_available(phydev, PHY_INBAND_EXT_PCH_TIMESTAMP)) {
> +                       ret = phy_inband_ext_enable(phydev, PHY_INBAND_EXT_PCH_TIMESTAMP);
> +                       if (ret)
> +                               *enable = false;
> +               } else {
> +                       *enable = false;
> +               }
> +       } else {
> +               phy_inband_ext_disable(phydev, PHY_INBAND_EXT_PCH_TIMESTAMP);
> +       }
> +
> +       lan_rmw(SYS_PCH_CFG_PCH_SUB_PORT_ID_SET(port->chip_port % 4) |
> +               SYS_PCH_CFG_PCH_TX_MODE_SET(*enable) |
> +               SYS_PCH_CFG_PCH_RX_MODE_SET(*enable),
> +               SYS_PCH_CFG_PCH_SUB_PORT_ID |
> +               SYS_PCH_CFG_PCH_TX_MODE |
> +               SYS_PCH_CFG_PCH_RX_MODE,
> +               port->lan966x, SYS_PCH_CFG(port->chip_port));
> +}
> +
>  int lan966x_ptp_hwtstamp_set(struct lan966x_port *port,
>                              struct kernel_hwtstamp_config *cfg,
>                              struct netlink_ext_ack *extack)
>  {
>         struct lan966x *lan966x = port->lan966x;
> +       bool timestamp_in_pch = false;
>         struct lan966x_phc *phc;
> 
>         switch (cfg->tx_type) {
> @@ -303,10 +339,18 @@ int lan966x_ptp_hwtstamp_set(struct lan966x_port *port,
>                 return -ERANGE;
>         }
> 
> +       if (cfg->source == HWTSTAMP_SOURCE_PHYLIB &&
> +           cfg->tx_type == HWTSTAMP_TX_ON &&
> +           port->config.portmode == PHY_INTERFACE_MODE_QUSGMII)
> +               timestamp_in_pch = true;
> +
> +       lan966x_ptp_pch_configure(port, &timestamp_in_pch);
> +
>         /* Commit back the result & save it */
>         mutex_lock(&lan966x->ptp_lock);
>         phc = &lan966x->phc[LAN966X_PHC_PORT];
>         phc->hwtstamp_config = *cfg;
> +       phc->pch = timestamp_in_pch;

Here we figure out if pch is enabled or not. If the cfg->source is not
PHYLIB or the interface is not QUSGMII then timestamp_in_pch will stay
false.

>         mutex_unlock(&lan966x->ptp_lock);
> 
>         return 0;
> @@ -397,6 +441,7 @@ int lan966x_ptp_txtstamp_request(struct lan966x_port *port,
>         LAN966X_SKB_CB(skb)->jiffies = jiffies;
> 
>         lan966x->ptp_skbs++;
> +

I think this is just a small style change. So maybe it shouldn't be in
here.

>         port->ts_id++;
>         if (port->ts_id == LAN966X_MAX_PTP_ID)
>                 port->ts_id = 0;
> @@ -500,6 +545,27 @@ irqreturn_t lan966x_ptp_irq_handler(int irq, void *args)
>                 /* Read RX timestamping to get the ID */
>                 id = lan_rd(lan966x, PTP_TWOSTEP_STAMP);
> 
> +               /* If PCH is enabled, there is a "feature" that also the MAC
> +                * will generate an interrupt for transmitted frames. This
> +                * interrupt should be ignored, so clear the allocated resources
> +                * and try to get the next timestamp. Maybe should clean the
> +                * resources on the TX side?
> +                */
> +               if (phy_inband_ext_enabled(port->dev->phydev,
> +                                          PHY_INBAND_EXT_PCH_TIMESTAMP)) {
> +                       spin_lock(&lan966x->ptp_ts_id_lock);
> +                       lan966x->ptp_skbs--;
> +                       spin_unlock(&lan966x->ptp_ts_id_lock);
> +
> +                       dev_kfree_skb_any(skb_match);
> +
> +                       lan_rmw(PTP_TWOSTEP_CTRL_NXT_SET(1),
> +                               PTP_TWOSTEP_CTRL_NXT,
> +                               lan966x, PTP_TWOSTEP_CTRL);
> +
> +                       continue;
> +               }
> +
>                 spin_lock_irqsave(&port->tx_skbs.lock, flags);
>                 skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
>                         if (LAN966X_SKB_CB(skb)->ts_id != id)
> @@ -1088,19 +1154,27 @@ void lan966x_ptp_rxtstamp(struct lan966x *lan966x, struct sk_buff *skb,
>         struct timespec64 ts;
>         u64 full_ts_in_ns;
> 
> +       phc = &lan966x->phc[LAN966X_PHC_PORT];
> +
>         if (!lan966x->ptp ||
> -           !lan966x->ports[src_port]->ptp_rx_cmd)
> +           !lan966x->ports[src_port]->ptp_rx_cmd ||
> +           !phc->pch)

And here because phc->pch is false, it would just return.
Meaning that it would never be able to get the time.
I presume that this check should not be modified.

>                 return;
> 
> -       phc = &lan966x->phc[LAN966X_PHC_PORT];
> -       lan966x_ptp_gettime64(&phc->info, &ts);
> -
> -       /* Drop the sub-ns precision */
> -       timestamp = timestamp >> 2;
> -       if (ts.tv_nsec < timestamp)
> -               ts.tv_sec--;
> -       ts.tv_nsec = timestamp;
> -       full_ts_in_ns = ktime_set(ts.tv_sec, ts.tv_nsec);
> +       if (phc->pch) {
> +               /* Drop the sub-ns precision */
> +               timestamp = timestamp >> 2;
> +               full_ts_in_ns = lower_32_bits(timestamp);
> +       } else {
> +               lan966x_ptp_gettime64(&phc->info, &ts);
> +
> +               /* Drop the sub-ns precision */
> +               timestamp = timestamp >> 2;
> +               if (ts.tv_nsec < timestamp)
> +                       ts.tv_sec--;
> +               ts.tv_nsec = timestamp;
> +               full_ts_in_ns = ktime_set(ts.tv_sec, ts.tv_nsec);
> +       }
 

-- 
/Horatiu

