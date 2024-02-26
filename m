Return-Path: <linux-kernel+bounces-80762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD681866C30
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74097284133
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85F91F94B;
	Mon, 26 Feb 2024 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WsQENq/c"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988421DA58;
	Mon, 26 Feb 2024 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936057; cv=none; b=BX/XY4mRuiYM/E5JczfvDpzHbaznkeRh/zGQwRjttbeCr/yfJ2U9EQypAiCVYPwH/yLgOSIJ8sD+OuouRrqDHMPm/XfBsuVYJnp+QZr36XT5GkPWF5OriUAhXDftHIZr/aZ63qd5Nhl2k5Evy0FBtUFMRru9XWetmoaQrtWQvgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936057; c=relaxed/simple;
	bh=09G0Yk6KRBOnmMZeg6+Rc4geP8eJ3iP12LiwS3Wv2Wg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lg0WJrsQePhTkoInKYjAIt3/JuJG1dnJpK5QZRiE70OJr2IN5N7I04MOsQ9cptWcmyBlfXtXpAp++HvSTaQQgd6HXoSagj6RwkJTl3TFK4f7Vk25IkaZiP+0BLKAYdH8QdkLeOk/NsdXyio+KTIrs/Xs/jfAaRy+N85SuTZ6Wwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WsQENq/c; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708936055; x=1740472055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=09G0Yk6KRBOnmMZeg6+Rc4geP8eJ3iP12LiwS3Wv2Wg=;
  b=WsQENq/cddFnS537KIyGX+LTFJJ3Q0dKOPkbmSnR2/k1LhTPH8eL4u3D
   369MzYyysqvFK3CjS7N+S3OezJYEg3wOPyHLFvnu2N4F1rrsyFQREp9Wd
   7NMBH/r97TizRtJbLvvg41mRAxP/JmwKDGuN58p9jxPT5ue75UEEc/TgD
   mraVasnlqwrYx3J434Iqw3dWbrL2iNnUvTUITJnf32NPPNHXGGXhukM8e
   r1RfUhUwjSJlVJfKBwwt6wN7cE/UyHOW5btp7HVcpI0WiHGux+gx64t6r
   b6QRqyKppzaxbb3MhqpIOb2vV3+o4bHAtt+fPSh/q657Vs3URu6Kzg35G
   g==;
X-CSE-ConnectionGUID: NK8lqbz2SqWiZPDcvpIv3A==
X-CSE-MsgGUID: CIwfs7BAQf2K8LdrshspUw==
X-IronPort-AV: E=Sophos;i="6.06,185,1705388400"; 
   d="scan'208";a="17343356"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2024 01:27:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 01:27:18 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 26 Feb 2024 01:27:18 -0700
Date: Mon, 26 Feb 2024 09:27:17 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <bryan.whitehead@microchip.com>,
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net 1/3] net: lan743x: disable WOL upon resume to restore
 full data path operation
Message-ID: <20240226082717.yo5onodu3c5tfvrh@DEN-DL-M31836.microchip.com>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-2-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240226080934.46003-2-Raju.Lakkaraju@microchip.com>

The 02/26/2024 13:39, Raju Lakkaraju wrote:
> In order for datapath to be restored to normal functionality after resume
> we disable all wakeup events. Additionally we clear all W1C status bits by
> writing 1's to them.

Have you run get_maintainer.pl before sending this?
To me it seems that Eric and Paolo are missing from the email list.

> 
> Fixes: 4d94282afd95 ("lan743x: Add power management support")
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 24 ++++++++++++++++++-
>  drivers/net/ethernet/microchip/lan743x_main.h | 24 +++++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 45e209a7d083..5641b466d70d 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -3550,7 +3550,7 @@ static void lan743x_pm_set_wol(struct lan743x_adapter *adapter)
>  
>  	/* clear wake settings */
>  	pmtctl = lan743x_csr_read(adapter, PMT_CTL);
> -	pmtctl |= PMT_CTL_WUPS_MASK_;
> +	pmtctl |= PMT_CTL_WUPS_MASK_ | PMT_CTL_RES_CLR_WKP_MASK_;
>  	pmtctl &= ~(PMT_CTL_GPIO_WAKEUP_EN_ | PMT_CTL_EEE_WAKEUP_EN_ |
>  		PMT_CTL_WOL_EN_ | PMT_CTL_MAC_D3_RX_CLK_OVR_ |
>  		PMT_CTL_RX_FCT_RFE_D3_CLK_OVR_ | PMT_CTL_ETH_PHY_WAKE_EN_);
> @@ -3685,6 +3685,7 @@ static int lan743x_pm_resume(struct device *dev)
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct net_device *netdev = pci_get_drvdata(pdev);
>  	struct lan743x_adapter *adapter = netdev_priv(netdev);
> +	int data;
>  	int ret;
>  
>  	pci_set_power_state(pdev, PCI_D0);
> @@ -3715,6 +3716,27 @@ static int lan743x_pm_resume(struct device *dev)
>  	netif_info(adapter, drv, adapter->netdev,
>  		   "Wakeup source : 0x%08X\n", ret);
>  
> +	/* Clear the wol configuration and status bits when system
> +	 * events occurs.
> +	 * The status bits are "Write One to Clear (W1C)"
> +	 */
> +	data = MAC_WUCSR_EEE_TX_WAKE_ | MAC_WUCSR_EEE_RX_WAKE_ |
> +	       MAC_WUCSR_RFE_WAKE_FR_ | MAC_WUCSR_PFDA_FR_ | MAC_WUCSR_WUFR_ |
> +	       MAC_WUCSR_MPR_ | MAC_WUCSR_BCAST_FR_;
> +	lan743x_csr_write(adapter, MAC_WUCSR, data);
> +
> +	data = MAC_WUCSR2_NS_RCD_ | MAC_WUCSR2_ARP_RCD_ |
> +	       MAC_WUCSR2_IPV6_TCPSYN_RCD_ | MAC_WUCSR2_IPV4_TCPSYN_RCD_;
> +	lan743x_csr_write(adapter, MAC_WUCSR2, data);
> +
> +	data = MAC_WK_SRC_ETH_PHY_WK_ | MAC_WK_SRC_IPV6_TCPSYN_RCD_WK_ |
> +	       MAC_WK_SRC_IPV4_TCPSYN_RCD_WK_ | MAC_WK_SRC_EEE_TX_WK_ |
> +	       MAC_WK_SRC_EEE_RX_WK_ | MAC_WK_SRC_RFE_FR_WK_ |
> +	       MAC_WK_SRC_PFDA_FR_WK_ | MAC_WK_SRC_MP_FR_WK_ |
> +	       MAC_WK_SRC_BCAST_FR_WK_ | MAC_WK_SRC_WU_FR_WK_ |
> +	       MAC_WK_SRC_WK_FR_SAVED_;
> +	lan743x_csr_write(adapter, MAC_WK_SRC, data);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
> index be79cb0ae5af..77fc3abc1428 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.h
> +++ b/drivers/net/ethernet/microchip/lan743x_main.h
> @@ -60,6 +60,7 @@
>  #define PMT_CTL_RX_FCT_RFE_D3_CLK_OVR_		BIT(18)
>  #define PMT_CTL_GPIO_WAKEUP_EN_			BIT(15)
>  #define PMT_CTL_EEE_WAKEUP_EN_			BIT(13)
> +#define PMT_CTL_RES_CLR_WKP_MASK_		GENMASK(9, 8)
>  #define PMT_CTL_READY_				BIT(7)
>  #define PMT_CTL_ETH_PHY_RST_			BIT(4)
>  #define PMT_CTL_WOL_EN_				BIT(3)
> @@ -226,12 +227,31 @@
>  #define MAC_WUCSR				(0x140)
>  #define MAC_MP_SO_EN_				BIT(21)
>  #define MAC_WUCSR_RFE_WAKE_EN_			BIT(14)
> +#define MAC_WUCSR_EEE_TX_WAKE_			BIT(13)
> +#define MAC_WUCSR_EEE_RX_WAKE_			BIT(11)
> +#define MAC_WUCSR_RFE_WAKE_FR_			BIT(9)
> +#define MAC_WUCSR_PFDA_FR_			BIT(7)
> +#define MAC_WUCSR_WUFR_				BIT(6)
> +#define MAC_WUCSR_MPR_				BIT(5)
> +#define MAC_WUCSR_BCAST_FR_			BIT(4)
>  #define MAC_WUCSR_PFDA_EN_			BIT(3)
>  #define MAC_WUCSR_WAKE_EN_			BIT(2)
>  #define MAC_WUCSR_MPEN_				BIT(1)
>  #define MAC_WUCSR_BCST_EN_			BIT(0)
>  
>  #define MAC_WK_SRC				(0x144)
> +#define MAC_WK_SRC_ETH_PHY_WK_			BIT(17)
> +#define MAC_WK_SRC_IPV6_TCPSYN_RCD_WK_		BIT(16)
> +#define MAC_WK_SRC_IPV4_TCPSYN_RCD_WK_		BIT(15)
> +#define MAC_WK_SRC_EEE_TX_WK_			BIT(14)
> +#define MAC_WK_SRC_EEE_RX_WK_			BIT(13)
> +#define MAC_WK_SRC_RFE_FR_WK_			BIT(12)
> +#define MAC_WK_SRC_PFDA_FR_WK_			BIT(11)
> +#define MAC_WK_SRC_MP_FR_WK_			BIT(10)
> +#define MAC_WK_SRC_BCAST_FR_WK_			BIT(9)
> +#define MAC_WK_SRC_WU_FR_WK_			BIT(8)
> +#define MAC_WK_SRC_WK_FR_SAVED_			BIT(7)
> +
>  #define MAC_MP_SO_HI				(0x148)
>  #define MAC_MP_SO_LO				(0x14C)
>  
> @@ -294,6 +314,10 @@
>  #define RFE_INDX(index)			(0x580 + (index << 2))
>  
>  #define MAC_WUCSR2			(0x600)
> +#define MAC_WUCSR2_NS_RCD_		BIT(7)
> +#define MAC_WUCSR2_ARP_RCD_		BIT(6)
> +#define MAC_WUCSR2_IPV6_TCPSYN_RCD_	BIT(5)
> +#define MAC_WUCSR2_IPV4_TCPSYN_RCD_	BIT(4)
>  
>  #define SGMII_ACC			(0x720)
>  #define SGMII_ACC_SGMII_BZY_		BIT(31)
> -- 
> 2.34.1
> 

-- 
/Horatiu

