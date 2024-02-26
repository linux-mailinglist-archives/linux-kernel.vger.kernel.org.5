Return-Path: <linux-kernel+bounces-80869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E3A866D76
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679231C23344
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB51B1292FA;
	Mon, 26 Feb 2024 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SiB7ahBR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7518E7D416;
	Mon, 26 Feb 2024 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936146; cv=none; b=dbvCMcQf5lzONI1P40ctK+3hqxQlweXCmkz7JcPbwPO7UR6megamQnEJbzZpN+VPrYfprVkMtw17F5JULP4Lmi3I9eKGK8YQ0ElQVTTMoTcGz6QXZerqippxhd4YMLFImqmSlqGYE+2pAHQGenKbd37b9X54oh58SuC1o+tHAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936146; c=relaxed/simple;
	bh=QwdokXlJ3prP3UF9aEemis8U44QlFFmI3psO/hocK/o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8w6/hAygUHqM/r7d15gIJ+SCIyT2L9mkdCVPmf/2KMeuPR8RR5d9/PfSyXxtEnOgyM/mRSBfzfla89rRciOhtIsZ8Gl05+7ZNEmwntG9P/TbnHQnx7PSM4J5KN3Azab5PkFz2+NN0UUrLsps3xQAORooXTb31Bsat5R4ILmDj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SiB7ahBR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708936144; x=1740472144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QwdokXlJ3prP3UF9aEemis8U44QlFFmI3psO/hocK/o=;
  b=SiB7ahBRcdxsngPF4zyQVglhMm+vm22u1856/pntAOlLPQBHjl7LUEG0
   2TYVkXQZsmhSnLydmGkuOKNwBME6PbS++Aa9Z43OfEIB4WryV4C/K2/R0
   XLDJAzskrOMF3BfTJs9MkagsPNB8C+5UJqScWV3KeKmVM1QxtKw/c5ElI
   irFvsO+4GkQKEWAZIdNRue5rJbrf27FBbXGkT3Q1xvIWNR2wrACkIjFM0
   CSMN7n4veht8tW+zGqFLn1E49TTmsfbcZL0sP/ncl2pLVLFgd5w6dF5fV
   eosVXU89r4sZEq/cNfqTkwosj0XWA+oEWBjWpG+UFN/GVv4XdPXXduA1H
   A==;
X-CSE-ConnectionGUID: hSJ/T3kRRSKwdBvF30aJmQ==
X-CSE-MsgGUID: qFUve9w1So+ytz1WOU+MeA==
X-IronPort-AV: E=Sophos;i="6.06,185,1705388400"; 
   d="scan'208";a="16813907"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2024 01:29:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 01:28:41 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 26 Feb 2024 01:28:41 -0700
Date: Mon, 26 Feb 2024 09:28:40 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <bryan.whitehead@microchip.com>,
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net 2/3] net: lan743x: support WOL in MAC even when PHY
 does not
Message-ID: <20240226082840.qbofj764s35zo352@DEN-DL-M31836.microchip.com>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-3-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240226080934.46003-3-Raju.Lakkaraju@microchip.com>

The 02/26/2024 13:39, Raju Lakkaraju wrote:
> Allow WOL support if MAC supports it, even if the PHY does not support it
> 
> Fixes: e9e13b6adc338 ("lan743x: fix for potential NULL pointer dereference
> with bare card")
> 
Please no spaces between the tags. And you should not split on multiple
line Fixes tag.

> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_ethtool.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> index a2b3f4433ca8..4899582b3d1d 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
> +++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> @@ -1163,6 +1163,17 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
>  				   struct ethtool_wolinfo *wol)
>  {
>  	struct lan743x_adapter *adapter = netdev_priv(netdev);
> +	int ret;
> +
> +	if (netdev->phydev) {
> +		ret = phy_ethtool_set_wol(netdev->phydev, wol);
> +		if (ret != -EOPNOTSUPP && ret != 0)
> +			return ret;
> +
> +		if (ret == -EOPNOTSUPP)
> +			netif_info(adapter, drv, adapter->netdev,
> +				   "phy does not support WOL\n");
> +	}
>  
>  	adapter->wolopts = 0;
>  	if (wol->wolopts & WAKE_UCAST)
> @@ -1187,8 +1198,7 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
>  
>  	device_set_wakeup_enable(&adapter->pdev->dev, (bool)wol->wolopts);
>  
> -	return netdev->phydev ? phy_ethtool_set_wol(netdev->phydev, wol)
> -			: -ENETDOWN;
> +	return 0;
>  }
>  #endif /* CONFIG_PM */
>  
> -- 
> 2.34.1
> 

-- 
/Horatiu

