Return-Path: <linux-kernel+bounces-54597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B9884B15C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FBA1F22C75
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB0212D156;
	Tue,  6 Feb 2024 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hcbmDRNj"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911C212D14A;
	Tue,  6 Feb 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212078; cv=none; b=qzqQ6cSuFSNMw5AfqHovfpm/vu45hgVv9RSRSZqVTPpN2+2OCoGUIwCidDvOPInFolVDCaJkuVyVRnVHMweObldnu5nd63COpwPfiSrdzz1Graa1rZsgHijempnecko94yc/D5rZjr3DKyXRvD0m+AB9f4GWOEjlZ8OmJc0n2i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212078; c=relaxed/simple;
	bh=ZjwtMnb/rp1IyLFLZEuYTb0KRKrk1a1mS6/JzlAlRWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fq0F5HDJmN2vyxsJGxbqJDK7NcmKkHWqiCVyFci54949iF04xF9t13iGC9YAGiBvco431UVKPAWwdohmHio9snp0uPwmOmKTSkuAeTKP63mnMpdIelLEmobmF0i3C+Qy+MIjJshxyksaeXIA2sG+ug081XKkzr+STHOXRXmCJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hcbmDRNj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82AA31C0004;
	Tue,  6 Feb 2024 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707212067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mUixx3iBL3zLfOd+J4Lc/59gG+HVlflMASxiV2Jzw18=;
	b=hcbmDRNjnQSZaxjzQPjZaqpaUocQchlBfZMaA3xreLWsdAsx14y6e5eZgqWEo5sjYasnrp
	xYzbetFMgNPSu4OEmfDPKxqlTnqL4FWDXd6VzqliPfUpJj3DeXHLeIkm7gt8UGQtPYlk/9
	UjxrS9LqjLOos/Xo7m/onVAtOjvwV2bWZATLG9xY3f2reOlsaYA9Ona79A9+nueZCrenZk
	FxB52U/y+uRDgVcFRXgUY0xy5Imi0AT8RZKPnger7moODGcgBM1SO0XZAjAEI5hdnon/CU
	se8Lj8Pb0pUgMFmK5PeXHLjJxl9Dh1jYx6kuP/EwwI9GFL/5lfNnbmy55l5boA==
Date: Tue, 6 Feb 2024 10:34:25 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Ariel Elior <aelior@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH 7/8] net: intel: igb: Use linkmode helpers for EEE
Message-ID: <20240206103425.28e64a8f@device-28.home>
In-Reply-To: <20240204-keee-u32-cleanup-v1-7-fb6e08329d9a@lunn.ch>
References: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
	<20240204-keee-u32-cleanup-v1-7-fb6e08329d9a@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Andrew,

On Sun, 04 Feb 2024 17:40:24 -0600
Andrew Lunn <andrew@lunn.ch> wrote:

> Make use of the existing linkmode helpers for converting PHY EEE
> register values into links modes, now that ethtool_keee uses link
> modes, rather than u32 values.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

[...]

> @@ -3109,6 +3111,8 @@ static int igb_set_eee(struct net_device *netdev,
>  		       struct ethtool_keee *edata)
>  {
>  	struct igb_adapter *adapter = netdev_priv(netdev);
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = {};
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp) = {};
>  	struct e1000_hw *hw = &adapter->hw;
>  	struct ethtool_keee eee_curr;
>  	bool adv1g_eee = true, adv100m_eee = true;
> @@ -3138,14 +3142,21 @@ static int igb_set_eee(struct net_device *netdev,
>  			return -EINVAL;
>  		}
>  
> -		if (!edata->advertised_u32 || (edata->advertised_u32 &
> -		    ~(ADVERTISE_100_FULL | ADVERTISE_1000_FULL))) {
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +				 supported);
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +				 supported);
> +		if (linkmode_andnot(tmp, edata->advertised, supported)) {
>  			dev_err(&adapter->pdev->dev,
>  				"EEE Advertisement supports only 100Tx and/or 100T full duplex\n");
>  			return -EINVAL;
>  		}
> -		adv100m_eee = !!(edata->advertised_u32 & ADVERTISE_100_FULL);
> -		adv1g_eee = !!(edata->advertised_u32 & ADVERTISE_1000_FULL);
> +		adv100m_eee = linkmode_test_bit(
> +			ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +			edata->advertised);
> +		adv1g_eee = linkmode_test_bit(
> +			ETHTOOL_LINK_MODE_100baseT_Full_BIT,

Probably a typo, I think it should be ETHTOOL_LINK_MODE_1000baseT_Full_BIT
here :)

> +			edata->advertised);
>  
>  	} else if (!edata->eee_enabled) {
>  		dev_err(&adapter->pdev->dev,
> @@ -3153,7 +3164,7 @@ static int igb_set_eee(struct net_device *netdev,
>  		return -EINVAL;
>  	}
>  
> -	adapter->eee_advert = ethtool_adv_to_mmd_eee_adv_t(edata->advertised_u32);
> +	adapter->eee_advert = linkmode_to_mii_eee_cap1_t(edata->advertised);
>  	if (hw->dev_spec._82575.eee_disable != !edata->eee_enabled) {
>  		hw->dev_spec._82575.eee_disable = !edata->eee_enabled;
>  		adapter->flags |= IGB_FLAG_EEE;
> 

Thanks,

Maxime

