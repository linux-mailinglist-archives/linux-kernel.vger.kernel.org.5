Return-Path: <linux-kernel+bounces-41362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F8F83EFA9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865FD1C21A79
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6227E2E62F;
	Sat, 27 Jan 2024 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOyaatE+"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DDA2D058;
	Sat, 27 Jan 2024 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706382420; cv=none; b=HLwCH1KLHG82zwcjyvI/PSDQ4N5yd5OYQ4p9zE9FNnLPvNbwM2ZMb1q6X2ML0PHy6cw+NgRte2KJ3ooCMepaKTyK5l+ya9S9YP3lNF6Ts7CZw52qnUYEH5As3mlqNJy3cCD+Nrzrf2jp7OWXDlxKMLObOpcgp+b5Ek9CC7TU4UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706382420; c=relaxed/simple;
	bh=VAk1ndah4XcwbsjdKyWGn/I749e0iRrH4PcKvrIOQpg=;
	h=Message-ID:Date:From:To:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jV7ttZp4EVPHNbcyLJJ9yVUJskWG/lD3J593fK9U/mFN71Qg19UwnsNcxDMqxJpVRswdB1FmxiM0Tl1Z/a4v0vCw4n1OaUPeDWvQUHVSFiKunJOVDui0Gxc5x+UwAD24CwVUlAXKICPps842+yyykqMztjZk6Ks3pUEcF3VoBxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOyaatE+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ae74e5394so79359f8f.3;
        Sat, 27 Jan 2024 11:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706382416; x=1706987216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pgCIJez2MxWlS+0vIhZ+LDaK1hbX6UBZRVNBG+vS6oA=;
        b=VOyaatE+RgQzP+pp9CYC4iS9HD70DM4DGh/dGCPU87wJqt1cWid4zi6JOzEd10jTku
         rX1426rREgEeHOz1h5iy+pRhNCdGkgbYS/mjxalLPHivZi7H+DhJseSdKG5byv1UL7+H
         4YFk0Fb6S5J3+bXv10bJ9QAv0wtIgTxhQDBHsOFtxJI8DZI3KCG6dGaSsC6H7UXLr36L
         UBVScfSqaIwEJWsjJTqDD6i3KGFip2e3y4YBKT/+WdbX8FFXT0TgvpGwvSj1UFHY9N5V
         SvaSy5BhPpNHM+gwsax99Jhm4bChC20j2LqX6/Fmf4LqJZB591YnLg3WHzcMnuRjHkix
         DwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706382416; x=1706987216;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgCIJez2MxWlS+0vIhZ+LDaK1hbX6UBZRVNBG+vS6oA=;
        b=nZsX45DJzLROTmkaR42zAqc++lnumcGV84pGsfS22lBsbzo1tQwvk/O/JXXpWbRcvH
         +fUhe9GxJkkeygISEpXEvAZlDx5rRGUIvVKJtMElrbagDAcUVpwjtsMe35ftGhqS+fsk
         3GatkXQYsE4dxASnGwluZ/ajMYcpT9mWebN8TqQImPIeOVRTmdgdLumIiRAmjAu8d/Pr
         SZ4xq3ToTMt3PBt4A3u7jw+B/JFFImCSqqE/2Kbj33UpYbyVS8MfHliLz2ApT+cYMdsf
         6Hy/IpiDHmVT+sL60JVJFKljm3+kjJE7yKzT2aArlcC1m9UnWe2k2ZnROnGsdPNOJ184
         XEZw==
X-Gm-Message-State: AOJu0YyfIdEgxaotqvpgjPHDRKEe5nN+b4bdLQ97QMWGZCJFqYbhfb6v
	wOZ5Q7GNZ1tOfqBM8hrBTCw5PiND66uUgpUXvWhguXtgsZqLMOcp
X-Google-Smtp-Source: AGHT+IFq1ZxtGBZbNZG3rojvYPV/7zvdXXkIj1MgNF6L4zmrZcbq6L8S+7u5/qeXrp958aag8itWmw==
X-Received: by 2002:adf:ec52:0:b0:33a:e36f:e843 with SMTP id w18-20020adfec52000000b0033ae36fe843mr2070345wrn.38.1706382415327;
        Sat, 27 Jan 2024 11:06:55 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id bj12-20020a0560001e0c00b00337d6f0013esm590472wrb.107.2024.01.27.11.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 11:06:54 -0800 (PST)
Message-ID: <65b5544e.050a0220.86866.2828@mx.google.com>
X-Google-Original-Message-ID: <ZbVSQIYqOgMafdO9@Ansuel-xps.>
Date: Sat, 27 Jan 2024 19:58:08 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v2 4/5] net: phy: qcom: move additional
 functions to shared library
References: <20240127144252.24767-1-ansuelsmth@gmail.com>
 <20240127144252.24767-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127144252.24767-5-ansuelsmth@gmail.com>

On Sat, Jan 27, 2024 at 03:42:44PM +0100, Christian Marangi wrote:
> Move additional functions to shared library in preparation for qca808x
> PHY Family to be detached from at803x driver.
> 
> Only the shared defines are moved to the shared qcom.h header.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/qcom/at803x.c       | 428 +---------------------------
>  drivers/net/phy/qcom/qcom-phy-lib.c | 376 ++++++++++++++++++++++++
>  drivers/net/phy/qcom/qcom.h         |  84 ++++++
>  3 files changed, 463 insertions(+), 425 deletions(-)
> 
> diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
> index 638babc50df1..442060793854 100644
> --- a/drivers/net/phy/qcom/at803x.c
> +++ b/drivers/net/phy/qcom/at803x.c
> @@ -24,65 +24,11 @@
>  
>  #include "qcom.h"
>  
> -#define AT803X_SPECIFIC_FUNCTION_CONTROL	0x10
> -#define AT803X_SFC_ASSERT_CRS			BIT(11)
> -#define AT803X_SFC_FORCE_LINK			BIT(10)
> -#define AT803X_SFC_MDI_CROSSOVER_MODE_M		GENMASK(6, 5)
> -#define AT803X_SFC_AUTOMATIC_CROSSOVER		0x3
> -#define AT803X_SFC_MANUAL_MDIX			0x1
> -#define AT803X_SFC_MANUAL_MDI			0x0
> -#define AT803X_SFC_SQE_TEST			BIT(2)
> -#define AT803X_SFC_POLARITY_REVERSAL		BIT(1)
> -#define AT803X_SFC_DISABLE_JABBER		BIT(0)
> -
> -#define AT803X_SPECIFIC_STATUS			0x11
> -#define AT803X_SS_SPEED_MASK			GENMASK(15, 14)
> -#define AT803X_SS_SPEED_1000			2
> -#define AT803X_SS_SPEED_100			1
> -#define AT803X_SS_SPEED_10			0
> -#define AT803X_SS_DUPLEX			BIT(13)
> -#define AT803X_SS_SPEED_DUPLEX_RESOLVED		BIT(11)
> -#define AT803X_SS_MDIX				BIT(6)
> -
> -#define QCA808X_SS_SPEED_MASK			GENMASK(9, 7)
> -#define QCA808X_SS_SPEED_2500			4

This was an intended remove and should be removed in patch 5 instead and
cause build fail on testing this single patch.

Will fix in v3, sorry for the noise!

> -
> -#define AT803X_INTR_ENABLE			0x12
> -#define AT803X_INTR_ENABLE_AUTONEG_ERR		BIT(15)
> -#define AT803X_INTR_ENABLE_SPEED_CHANGED	BIT(14)
> -#define AT803X_INTR_ENABLE_DUPLEX_CHANGED	BIT(13)
> -#define AT803X_INTR_ENABLE_PAGE_RECEIVED	BIT(12)
> -#define AT803X_INTR_ENABLE_LINK_FAIL		BIT(11)
> -#define AT803X_INTR_ENABLE_LINK_SUCCESS		BIT(10)
> -#define AT803X_INTR_ENABLE_LINK_FAIL_BX		BIT(8)
> -#define AT803X_INTR_ENABLE_LINK_SUCCESS_BX	BIT(7)
> -#define AT803X_INTR_ENABLE_WIRESPEED_DOWNGRADE	BIT(5)
> -#define AT803X_INTR_ENABLE_POLARITY_CHANGED	BIT(1)
> -#define AT803X_INTR_ENABLE_WOL			BIT(0)
> -
> -#define AT803X_INTR_STATUS			0x13
> -
> -#define AT803X_SMART_SPEED			0x14
> -#define AT803X_SMART_SPEED_ENABLE		BIT(5)
> -#define AT803X_SMART_SPEED_RETRY_LIMIT_MASK	GENMASK(4, 2)
> -#define AT803X_SMART_SPEED_BYPASS_TIMER		BIT(1)
> -#define AT803X_CDT				0x16
> -#define AT803X_CDT_MDI_PAIR_MASK		GENMASK(9, 8)
> -#define AT803X_CDT_ENABLE_TEST			BIT(0)
> -#define AT803X_CDT_STATUS			0x1c
> -#define AT803X_CDT_STATUS_STAT_NORMAL		0
> -#define AT803X_CDT_STATUS_STAT_SHORT		1
> -#define AT803X_CDT_STATUS_STAT_OPEN		2
> -#define AT803X_CDT_STATUS_STAT_FAIL		3
> -#define AT803X_CDT_STATUS_STAT_MASK		GENMASK(9, 8)
> -#define AT803X_CDT_STATUS_DELTA_TIME_MASK	GENMASK(7, 0)
>  #define AT803X_LED_CONTROL			0x18
>  
>  #define AT803X_PHY_MMD3_WOL_CTRL		0x8012
>  #define AT803X_WOL_EN				BIT(5)
> -#define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
> -#define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
> -#define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
> +
>  #define AT803X_REG_CHIP_CONFIG			0x1f
>  #define AT803X_BT_BX_REG_SEL			0x8000
>  
> @@ -138,10 +84,6 @@
>  #define AT803X_CLK_OUT_STRENGTH_HALF		1
>  #define AT803X_CLK_OUT_STRENGTH_QUARTER		2
>  
> -#define AT803X_DEFAULT_DOWNSHIFT		5
> -#define AT803X_MIN_DOWNSHIFT			2
> -#define AT803X_MAX_DOWNSHIFT			9
> -
>  #define AT803X_MMD3_SMARTEEE_CTL1		0x805b
>  #define AT803X_MMD3_SMARTEEE_CTL2		0x805c
>  #define AT803X_MMD3_SMARTEEE_CTL3		0x805d
> @@ -158,6 +100,8 @@
>  
>  #define QCA9561_PHY_ID				0x004dd042
>  
> +#define AT803X_SS_SPEED_MASK			GENMASK(15, 14)
> +
>  #define AT803X_PAGE_FIBER			0
>  #define AT803X_PAGE_COPPER			1
>  
> @@ -366,11 +310,6 @@ MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
>  MODULE_AUTHOR("Matus Ujhelyi");
>  MODULE_LICENSE("GPL");
>  
> -struct at803x_ss_mask {
> -	u16 speed_mask;
> -	u8 speed_shift;
> -};
> -
>  struct at803x_priv {
>  	int flags;
>  	u16 clk_25m_reg;
> @@ -470,80 +409,6 @@ static void at803x_context_restore(struct phy_device *phydev,
>  	phy_write(phydev, AT803X_LED_CONTROL, context->led_control);
>  }
>  
> -static int at803x_set_wol(struct phy_device *phydev,
> -			  struct ethtool_wolinfo *wol)
> -{
> -	int ret, irq_enabled;
> -
> -	if (wol->wolopts & WAKE_MAGIC) {
> -		struct net_device *ndev = phydev->attached_dev;
> -		const u8 *mac;
> -		unsigned int i;
> -		static const unsigned int offsets[] = {
> -			AT803X_LOC_MAC_ADDR_32_47_OFFSET,
> -			AT803X_LOC_MAC_ADDR_16_31_OFFSET,
> -			AT803X_LOC_MAC_ADDR_0_15_OFFSET,
> -		};
> -
> -		if (!ndev)
> -			return -ENODEV;
> -
> -		mac = (const u8 *)ndev->dev_addr;
> -
> -		if (!is_valid_ether_addr(mac))
> -			return -EINVAL;
> -
> -		for (i = 0; i < 3; i++)
> -			phy_write_mmd(phydev, MDIO_MMD_PCS, offsets[i],
> -				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
> -
> -		/* Enable WOL interrupt */
> -		ret = phy_modify(phydev, AT803X_INTR_ENABLE, 0, AT803X_INTR_ENABLE_WOL);
> -		if (ret)
> -			return ret;
> -	} else {
> -		/* Disable WOL interrupt */
> -		ret = phy_modify(phydev, AT803X_INTR_ENABLE, AT803X_INTR_ENABLE_WOL, 0);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	/* Clear WOL status */
> -	ret = phy_read(phydev, AT803X_INTR_STATUS);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* Check if there are other interrupts except for WOL triggered when PHY is
> -	 * in interrupt mode, only the interrupts enabled by AT803X_INTR_ENABLE can
> -	 * be passed up to the interrupt PIN.
> -	 */
> -	irq_enabled = phy_read(phydev, AT803X_INTR_ENABLE);
> -	if (irq_enabled < 0)
> -		return irq_enabled;
> -
> -	irq_enabled &= ~AT803X_INTR_ENABLE_WOL;
> -	if (ret & irq_enabled && !phy_polling_mode(phydev))
> -		phy_trigger_machine(phydev);
> -
> -	return 0;
> -}
> -
> -static void at803x_get_wol(struct phy_device *phydev,
> -			   struct ethtool_wolinfo *wol)
> -{
> -	int value;
> -
> -	wol->supported = WAKE_MAGIC;
> -	wol->wolopts = 0;
> -
> -	value = phy_read(phydev, AT803X_INTR_ENABLE);
> -	if (value < 0)
> -		return;
> -
> -	if (value & AT803X_INTR_ENABLE_WOL)
> -		wol->wolopts |= WAKE_MAGIC;
> -}
> -
>  static int at803x_suspend(struct phy_device *phydev)
>  {
>  	int value;
> @@ -816,73 +681,6 @@ static int at803x_config_init(struct phy_device *phydev)
>  	return phy_modify(phydev, MII_ADVERTISE, MDIO_AN_CTRL1_XNP, 0);
>  }
>  
> -static int at803x_ack_interrupt(struct phy_device *phydev)
> -{
> -	int err;
> -
> -	err = phy_read(phydev, AT803X_INTR_STATUS);
> -
> -	return (err < 0) ? err : 0;
> -}
> -
> -static int at803x_config_intr(struct phy_device *phydev)
> -{
> -	int err;
> -	int value;
> -
> -	value = phy_read(phydev, AT803X_INTR_ENABLE);
> -
> -	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
> -		/* Clear any pending interrupts */
> -		err = at803x_ack_interrupt(phydev);
> -		if (err)
> -			return err;
> -
> -		value |= AT803X_INTR_ENABLE_AUTONEG_ERR;
> -		value |= AT803X_INTR_ENABLE_SPEED_CHANGED;
> -		value |= AT803X_INTR_ENABLE_DUPLEX_CHANGED;
> -		value |= AT803X_INTR_ENABLE_LINK_FAIL;
> -		value |= AT803X_INTR_ENABLE_LINK_SUCCESS;
> -
> -		err = phy_write(phydev, AT803X_INTR_ENABLE, value);
> -	} else {
> -		err = phy_write(phydev, AT803X_INTR_ENABLE, 0);
> -		if (err)
> -			return err;
> -
> -		/* Clear any pending interrupts */
> -		err = at803x_ack_interrupt(phydev);
> -	}
> -
> -	return err;
> -}
> -
> -static irqreturn_t at803x_handle_interrupt(struct phy_device *phydev)
> -{
> -	int irq_status, int_enabled;
> -
> -	irq_status = phy_read(phydev, AT803X_INTR_STATUS);
> -	if (irq_status < 0) {
> -		phy_error(phydev);
> -		return IRQ_NONE;
> -	}
> -
> -	/* Read the current enabled interrupts */
> -	int_enabled = phy_read(phydev, AT803X_INTR_ENABLE);
> -	if (int_enabled < 0) {
> -		phy_error(phydev);
> -		return IRQ_NONE;
> -	}
> -
> -	/* See if this was one of our enabled interrupts */
> -	if (!(irq_status & int_enabled))
> -		return IRQ_NONE;
> -
> -	phy_trigger_machine(phydev);
> -
> -	return IRQ_HANDLED;
> -}
> -
>  static void at803x_link_change_notify(struct phy_device *phydev)
>  {
>  	/*
> @@ -908,69 +706,6 @@ static void at803x_link_change_notify(struct phy_device *phydev)
>  	}
>  }
>  
> -static int at803x_read_specific_status(struct phy_device *phydev,
> -				       struct at803x_ss_mask ss_mask)
> -{
> -	int ss;
> -
> -	/* Read the AT8035 PHY-Specific Status register, which indicates the
> -	 * speed and duplex that the PHY is actually using, irrespective of
> -	 * whether we are in autoneg mode or not.
> -	 */
> -	ss = phy_read(phydev, AT803X_SPECIFIC_STATUS);
> -	if (ss < 0)
> -		return ss;
> -
> -	if (ss & AT803X_SS_SPEED_DUPLEX_RESOLVED) {
> -		int sfc, speed;
> -
> -		sfc = phy_read(phydev, AT803X_SPECIFIC_FUNCTION_CONTROL);
> -		if (sfc < 0)
> -			return sfc;
> -
> -		speed = ss & ss_mask.speed_mask;
> -		speed >>= ss_mask.speed_shift;
> -
> -		switch (speed) {
> -		case AT803X_SS_SPEED_10:
> -			phydev->speed = SPEED_10;
> -			break;
> -		case AT803X_SS_SPEED_100:
> -			phydev->speed = SPEED_100;
> -			break;
> -		case AT803X_SS_SPEED_1000:
> -			phydev->speed = SPEED_1000;
> -			break;
> -		case QCA808X_SS_SPEED_2500:
> -			phydev->speed = SPEED_2500;
> -			break;
> -		}
> -		if (ss & AT803X_SS_DUPLEX)
> -			phydev->duplex = DUPLEX_FULL;
> -		else
> -			phydev->duplex = DUPLEX_HALF;
> -
> -		if (ss & AT803X_SS_MDIX)
> -			phydev->mdix = ETH_TP_MDI_X;
> -		else
> -			phydev->mdix = ETH_TP_MDI;
> -
> -		switch (FIELD_GET(AT803X_SFC_MDI_CROSSOVER_MODE_M, sfc)) {
> -		case AT803X_SFC_MANUAL_MDI:
> -			phydev->mdix_ctrl = ETH_TP_MDI;
> -			break;
> -		case AT803X_SFC_MANUAL_MDIX:
> -			phydev->mdix_ctrl = ETH_TP_MDI_X;
> -			break;
> -		case AT803X_SFC_AUTOMATIC_CROSSOVER:
> -			phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
> -			break;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>  static int at803x_read_status(struct phy_device *phydev)
>  {
>  	struct at803x_ss_mask ss_mask = { 0 };
> @@ -1006,50 +741,6 @@ static int at803x_read_status(struct phy_device *phydev)
>  	return 0;
>  }
>  
> -static int at803x_config_mdix(struct phy_device *phydev, u8 ctrl)
> -{
> -	u16 val;
> -
> -	switch (ctrl) {
> -	case ETH_TP_MDI:
> -		val = AT803X_SFC_MANUAL_MDI;
> -		break;
> -	case ETH_TP_MDI_X:
> -		val = AT803X_SFC_MANUAL_MDIX;
> -		break;
> -	case ETH_TP_MDI_AUTO:
> -		val = AT803X_SFC_AUTOMATIC_CROSSOVER;
> -		break;
> -	default:
> -		return 0;
> -	}
> -
> -	return phy_modify_changed(phydev, AT803X_SPECIFIC_FUNCTION_CONTROL,
> -			  AT803X_SFC_MDI_CROSSOVER_MODE_M,
> -			  FIELD_PREP(AT803X_SFC_MDI_CROSSOVER_MODE_M, val));
> -}
> -
> -static int at803x_prepare_config_aneg(struct phy_device *phydev)
> -{
> -	int ret;
> -
> -	ret = at803x_config_mdix(phydev, phydev->mdix_ctrl);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* Changes of the midx bits are disruptive to the normal operation;
> -	 * therefore any changes to these registers must be followed by a
> -	 * software reset to take effect.
> -	 */
> -	if (ret == 1) {
> -		ret = genphy_soft_reset(phydev);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static int at803x_config_aneg(struct phy_device *phydev)
>  {
>  	struct at803x_priv *priv = phydev->priv;
> @@ -1065,80 +756,6 @@ static int at803x_config_aneg(struct phy_device *phydev)
>  	return genphy_config_aneg(phydev);
>  }
>  
> -static int at803x_get_downshift(struct phy_device *phydev, u8 *d)
> -{
> -	int val;
> -
> -	val = phy_read(phydev, AT803X_SMART_SPEED);
> -	if (val < 0)
> -		return val;
> -
> -	if (val & AT803X_SMART_SPEED_ENABLE)
> -		*d = FIELD_GET(AT803X_SMART_SPEED_RETRY_LIMIT_MASK, val) + 2;
> -	else
> -		*d = DOWNSHIFT_DEV_DISABLE;
> -
> -	return 0;
> -}
> -
> -static int at803x_set_downshift(struct phy_device *phydev, u8 cnt)
> -{
> -	u16 mask, set;
> -	int ret;
> -
> -	switch (cnt) {
> -	case DOWNSHIFT_DEV_DEFAULT_COUNT:
> -		cnt = AT803X_DEFAULT_DOWNSHIFT;
> -		fallthrough;
> -	case AT803X_MIN_DOWNSHIFT ... AT803X_MAX_DOWNSHIFT:
> -		set = AT803X_SMART_SPEED_ENABLE |
> -		      AT803X_SMART_SPEED_BYPASS_TIMER |
> -		      FIELD_PREP(AT803X_SMART_SPEED_RETRY_LIMIT_MASK, cnt - 2);
> -		mask = AT803X_SMART_SPEED_RETRY_LIMIT_MASK;
> -		break;
> -	case DOWNSHIFT_DEV_DISABLE:
> -		set = 0;
> -		mask = AT803X_SMART_SPEED_ENABLE |
> -		       AT803X_SMART_SPEED_BYPASS_TIMER;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	ret = phy_modify_changed(phydev, AT803X_SMART_SPEED, mask, set);
> -
> -	/* After changing the smart speed settings, we need to perform a
> -	 * software reset, use phy_init_hw() to make sure we set the
> -	 * reapply any values which might got lost during software reset.
> -	 */
> -	if (ret == 1)
> -		ret = phy_init_hw(phydev);
> -
> -	return ret;
> -}
> -
> -static int at803x_get_tunable(struct phy_device *phydev,
> -			      struct ethtool_tunable *tuna, void *data)
> -{
> -	switch (tuna->id) {
> -	case ETHTOOL_PHY_DOWNSHIFT:
> -		return at803x_get_downshift(phydev, data);
> -	default:
> -		return -EOPNOTSUPP;
> -	}
> -}
> -
> -static int at803x_set_tunable(struct phy_device *phydev,
> -			      struct ethtool_tunable *tuna, const void *data)
> -{
> -	switch (tuna->id) {
> -	case ETHTOOL_PHY_DOWNSHIFT:
> -		return at803x_set_downshift(phydev, *(const u8 *)data);
> -	default:
> -		return -EOPNOTSUPP;
> -	}
> -}
> -
>  static int at803x_cable_test_result_trans(u16 status)
>  {
>  	switch (FIELD_GET(AT803X_CDT_STATUS_STAT_MASK, status)) {
> @@ -1170,45 +787,6 @@ static bool at803x_cdt_fault_length_valid(u16 status)
>  	return false;
>  }
>  
> -static int at803x_cdt_fault_length(int dt)
> -{
> -	/* According to the datasheet the distance to the fault is
> -	 * DELTA_TIME * 0.824 meters.
> -	 *
> -	 * The author suspect the correct formula is:
> -	 *
> -	 *   fault_distance = DELTA_TIME * (c * VF) / 125MHz / 2
> -	 *
> -	 * where c is the speed of light, VF is the velocity factor of
> -	 * the twisted pair cable, 125MHz the counter frequency and
> -	 * we need to divide by 2 because the hardware will measure the
> -	 * round trip time to the fault and back to the PHY.
> -	 *
> -	 * With a VF of 0.69 we get the factor 0.824 mentioned in the
> -	 * datasheet.
> -	 */
> -	return (dt * 824) / 10;
> -}
> -
> -static int at803x_cdt_start(struct phy_device *phydev,
> -			    u32 cdt_start)
> -{
> -	return phy_write(phydev, AT803X_CDT, cdt_start);
> -}
> -
> -static int at803x_cdt_wait_for_completion(struct phy_device *phydev,
> -					  u32 cdt_en)
> -{
> -	int val, ret;
> -
> -	/* One test run takes about 25ms */
> -	ret = phy_read_poll_timeout(phydev, AT803X_CDT, val,
> -				    !(val & cdt_en),
> -				    30000, 100000, true);
> -
> -	return ret < 0 ? ret : 0;
> -}
> -
>  static int at803x_cable_test_one_pair(struct phy_device *phydev, int pair)
>  {
>  	static const int ethtool_pair[] = {
> diff --git a/drivers/net/phy/qcom/qcom-phy-lib.c b/drivers/net/phy/qcom/qcom-phy-lib.c
> index 7192184429b7..e0295d4b4a51 100644
> --- a/drivers/net/phy/qcom/qcom-phy-lib.c
> +++ b/drivers/net/phy/qcom/qcom-phy-lib.c
> @@ -3,6 +3,9 @@
>  #include <linux/phy.h>
>  #include <linux/module.h>
>  
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +
>  #include "qcom.h"
>  
>  MODULE_DESCRIPTION("Qualcomm PHY driver Common Functions");
> @@ -51,3 +54,376 @@ int at803x_debug_reg_write(struct phy_device *phydev, u16 reg, u16 data)
>  	return phy_write(phydev, AT803X_DEBUG_DATA, data);
>  }
>  EXPORT_SYMBOL_GPL(at803x_debug_reg_write);
> +
> +int at803x_set_wol(struct phy_device *phydev,
> +		   struct ethtool_wolinfo *wol)
> +{
> +	int ret, irq_enabled;
> +
> +	if (wol->wolopts & WAKE_MAGIC) {
> +		struct net_device *ndev = phydev->attached_dev;
> +		const u8 *mac;
> +		unsigned int i;
> +		static const unsigned int offsets[] = {
> +			AT803X_LOC_MAC_ADDR_32_47_OFFSET,
> +			AT803X_LOC_MAC_ADDR_16_31_OFFSET,
> +			AT803X_LOC_MAC_ADDR_0_15_OFFSET,
> +		};
> +
> +		if (!ndev)
> +			return -ENODEV;
> +
> +		mac = (const u8 *)ndev->dev_addr;
> +
> +		if (!is_valid_ether_addr(mac))
> +			return -EINVAL;
> +
> +		for (i = 0; i < 3; i++)
> +			phy_write_mmd(phydev, MDIO_MMD_PCS, offsets[i],
> +				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
> +
> +		/* Enable WOL interrupt */
> +		ret = phy_modify(phydev, AT803X_INTR_ENABLE, 0, AT803X_INTR_ENABLE_WOL);
> +		if (ret)
> +			return ret;
> +	} else {
> +		/* Disable WOL interrupt */
> +		ret = phy_modify(phydev, AT803X_INTR_ENABLE, AT803X_INTR_ENABLE_WOL, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Clear WOL status */
> +	ret = phy_read(phydev, AT803X_INTR_STATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Check if there are other interrupts except for WOL triggered when PHY is
> +	 * in interrupt mode, only the interrupts enabled by AT803X_INTR_ENABLE can
> +	 * be passed up to the interrupt PIN.
> +	 */
> +	irq_enabled = phy_read(phydev, AT803X_INTR_ENABLE);
> +	if (irq_enabled < 0)
> +		return irq_enabled;
> +
> +	irq_enabled &= ~AT803X_INTR_ENABLE_WOL;
> +	if (ret & irq_enabled && !phy_polling_mode(phydev))
> +		phy_trigger_machine(phydev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(at803x_set_wol);
> +
> +void at803x_get_wol(struct phy_device *phydev,
> +		    struct ethtool_wolinfo *wol)
> +{
> +	int value;
> +
> +	wol->supported = WAKE_MAGIC;
> +	wol->wolopts = 0;
> +
> +	value = phy_read(phydev, AT803X_INTR_ENABLE);
> +	if (value < 0)
> +		return;
> +
> +	if (value & AT803X_INTR_ENABLE_WOL)
> +		wol->wolopts |= WAKE_MAGIC;
> +}
> +EXPORT_SYMBOL_GPL(at803x_get_wol);
> +
> +int at803x_ack_interrupt(struct phy_device *phydev)
> +{
> +	int err;
> +
> +	err = phy_read(phydev, AT803X_INTR_STATUS);
> +
> +	return (err < 0) ? err : 0;
> +}
> +EXPORT_SYMBOL_GPL(at803x_ack_interrupt);
> +
> +int at803x_config_intr(struct phy_device *phydev)
> +{
> +	int err;
> +	int value;
> +
> +	value = phy_read(phydev, AT803X_INTR_ENABLE);
> +
> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
> +		/* Clear any pending interrupts */
> +		err = at803x_ack_interrupt(phydev);
> +		if (err)
> +			return err;
> +
> +		value |= AT803X_INTR_ENABLE_AUTONEG_ERR;
> +		value |= AT803X_INTR_ENABLE_SPEED_CHANGED;
> +		value |= AT803X_INTR_ENABLE_DUPLEX_CHANGED;
> +		value |= AT803X_INTR_ENABLE_LINK_FAIL;
> +		value |= AT803X_INTR_ENABLE_LINK_SUCCESS;
> +
> +		err = phy_write(phydev, AT803X_INTR_ENABLE, value);
> +	} else {
> +		err = phy_write(phydev, AT803X_INTR_ENABLE, 0);
> +		if (err)
> +			return err;
> +
> +		/* Clear any pending interrupts */
> +		err = at803x_ack_interrupt(phydev);
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(at803x_config_intr);
> +
> +irqreturn_t at803x_handle_interrupt(struct phy_device *phydev)
> +{
> +	int irq_status, int_enabled;
> +
> +	irq_status = phy_read(phydev, AT803X_INTR_STATUS);
> +	if (irq_status < 0) {
> +		phy_error(phydev);
> +		return IRQ_NONE;
> +	}
> +
> +	/* Read the current enabled interrupts */
> +	int_enabled = phy_read(phydev, AT803X_INTR_ENABLE);
> +	if (int_enabled < 0) {
> +		phy_error(phydev);
> +		return IRQ_NONE;
> +	}
> +
> +	/* See if this was one of our enabled interrupts */
> +	if (!(irq_status & int_enabled))
> +		return IRQ_NONE;
> +
> +	phy_trigger_machine(phydev);
> +
> +	return IRQ_HANDLED;
> +}
> +EXPORT_SYMBOL_GPL(at803x_handle_interrupt);
> +
> +int at803x_read_specific_status(struct phy_device *phydev,
> +				struct at803x_ss_mask ss_mask)
> +{
> +	int ss;
> +
> +	/* Read the AT8035 PHY-Specific Status register, which indicates the
> +	 * speed and duplex that the PHY is actually using, irrespective of
> +	 * whether we are in autoneg mode or not.
> +	 */
> +	ss = phy_read(phydev, AT803X_SPECIFIC_STATUS);
> +	if (ss < 0)
> +		return ss;
> +
> +	if (ss & AT803X_SS_SPEED_DUPLEX_RESOLVED) {
> +		int sfc, speed;
> +
> +		sfc = phy_read(phydev, AT803X_SPECIFIC_FUNCTION_CONTROL);
> +		if (sfc < 0)
> +			return sfc;
> +
> +		speed = ss & ss_mask.speed_mask;
> +		speed >>= ss_mask.speed_shift;
> +
> +		switch (speed) {
> +		case AT803X_SS_SPEED_10:
> +			phydev->speed = SPEED_10;
> +			break;
> +		case AT803X_SS_SPEED_100:
> +			phydev->speed = SPEED_100;
> +			break;
> +		case AT803X_SS_SPEED_1000:
> +			phydev->speed = SPEED_1000;
> +			break;
> +		case QCA808X_SS_SPEED_2500:
> +			phydev->speed = SPEED_2500;
> +			break;
> +		}
> +		if (ss & AT803X_SS_DUPLEX)
> +			phydev->duplex = DUPLEX_FULL;
> +		else
> +			phydev->duplex = DUPLEX_HALF;
> +
> +		if (ss & AT803X_SS_MDIX)
> +			phydev->mdix = ETH_TP_MDI_X;
> +		else
> +			phydev->mdix = ETH_TP_MDI;
> +
> +		switch (FIELD_GET(AT803X_SFC_MDI_CROSSOVER_MODE_M, sfc)) {
> +		case AT803X_SFC_MANUAL_MDI:
> +			phydev->mdix_ctrl = ETH_TP_MDI;
> +			break;
> +		case AT803X_SFC_MANUAL_MDIX:
> +			phydev->mdix_ctrl = ETH_TP_MDI_X;
> +			break;
> +		case AT803X_SFC_AUTOMATIC_CROSSOVER:
> +			phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(at803x_read_specific_status);
> +
> +int at803x_config_mdix(struct phy_device *phydev, u8 ctrl)
> +{
> +	u16 val;
> +
> +	switch (ctrl) {
> +	case ETH_TP_MDI:
> +		val = AT803X_SFC_MANUAL_MDI;
> +		break;
> +	case ETH_TP_MDI_X:
> +		val = AT803X_SFC_MANUAL_MDIX;
> +		break;
> +	case ETH_TP_MDI_AUTO:
> +		val = AT803X_SFC_AUTOMATIC_CROSSOVER;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	return phy_modify_changed(phydev, AT803X_SPECIFIC_FUNCTION_CONTROL,
> +			  AT803X_SFC_MDI_CROSSOVER_MODE_M,
> +			  FIELD_PREP(AT803X_SFC_MDI_CROSSOVER_MODE_M, val));
> +}
> +EXPORT_SYMBOL_GPL(at803x_config_mdix);
> +
> +int at803x_prepare_config_aneg(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = at803x_config_mdix(phydev, phydev->mdix_ctrl);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Changes of the midx bits are disruptive to the normal operation;
> +	 * therefore any changes to these registers must be followed by a
> +	 * software reset to take effect.
> +	 */
> +	if (ret == 1) {
> +		ret = genphy_soft_reset(phydev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(at803x_prepare_config_aneg);
> +
> +static int at803x_get_downshift(struct phy_device *phydev, u8 *d)
> +{
> +	int val;
> +
> +	val = phy_read(phydev, AT803X_SMART_SPEED);
> +	if (val < 0)
> +		return val;
> +
> +	if (val & AT803X_SMART_SPEED_ENABLE)
> +		*d = FIELD_GET(AT803X_SMART_SPEED_RETRY_LIMIT_MASK, val) + 2;
> +	else
> +		*d = DOWNSHIFT_DEV_DISABLE;
> +
> +	return 0;
> +}
> +
> +static int at803x_set_downshift(struct phy_device *phydev, u8 cnt)
> +{
> +	u16 mask, set;
> +	int ret;
> +
> +	switch (cnt) {
> +	case DOWNSHIFT_DEV_DEFAULT_COUNT:
> +		cnt = AT803X_DEFAULT_DOWNSHIFT;
> +		fallthrough;
> +	case AT803X_MIN_DOWNSHIFT ... AT803X_MAX_DOWNSHIFT:
> +		set = AT803X_SMART_SPEED_ENABLE |
> +		      AT803X_SMART_SPEED_BYPASS_TIMER |
> +		      FIELD_PREP(AT803X_SMART_SPEED_RETRY_LIMIT_MASK, cnt - 2);
> +		mask = AT803X_SMART_SPEED_RETRY_LIMIT_MASK;
> +		break;
> +	case DOWNSHIFT_DEV_DISABLE:
> +		set = 0;
> +		mask = AT803X_SMART_SPEED_ENABLE |
> +		       AT803X_SMART_SPEED_BYPASS_TIMER;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = phy_modify_changed(phydev, AT803X_SMART_SPEED, mask, set);
> +
> +	/* After changing the smart speed settings, we need to perform a
> +	 * software reset, use phy_init_hw() to make sure we set the
> +	 * reapply any values which might got lost during software reset.
> +	 */
> +	if (ret == 1)
> +		ret = phy_init_hw(phydev);
> +
> +	return ret;
> +}
> +
> +int at803x_get_tunable(struct phy_device *phydev,
> +		       struct ethtool_tunable *tuna, void *data)
> +{
> +	switch (tuna->id) {
> +	case ETHTOOL_PHY_DOWNSHIFT:
> +		return at803x_get_downshift(phydev, data);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(at803x_get_tunable);
> +
> +int at803x_set_tunable(struct phy_device *phydev,
> +		       struct ethtool_tunable *tuna, const void *data)
> +{
> +	switch (tuna->id) {
> +	case ETHTOOL_PHY_DOWNSHIFT:
> +		return at803x_set_downshift(phydev, *(const u8 *)data);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(at803x_set_tunable);
> +
> +int at803x_cdt_fault_length(int dt)
> +{
> +	/* According to the datasheet the distance to the fault is
> +	 * DELTA_TIME * 0.824 meters.
> +	 *
> +	 * The author suspect the correct formula is:
> +	 *
> +	 *   fault_distance = DELTA_TIME * (c * VF) / 125MHz / 2
> +	 *
> +	 * where c is the speed of light, VF is the velocity factor of
> +	 * the twisted pair cable, 125MHz the counter frequency and
> +	 * we need to divide by 2 because the hardware will measure the
> +	 * round trip time to the fault and back to the PHY.
> +	 *
> +	 * With a VF of 0.69 we get the factor 0.824 mentioned in the
> +	 * datasheet.
> +	 */
> +	return (dt * 824) / 10;
> +}
> +EXPORT_SYMBOL_GPL(at803x_cdt_fault_length);
> +
> +int at803x_cdt_start(struct phy_device *phydev, u32 cdt_start)
> +{
> +	return phy_write(phydev, AT803X_CDT, cdt_start);
> +}
> +EXPORT_SYMBOL_GPL(at803x_cdt_start);
> +
> +int at803x_cdt_wait_for_completion(struct phy_device *phydev,
> +				   u32 cdt_en)
> +{
> +	int val, ret;
> +
> +	/* One test run takes about 25ms */
> +	ret = phy_read_poll_timeout(phydev, AT803X_CDT, val,
> +				    !(val & cdt_en),
> +				    30000, 100000, true);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +EXPORT_SYMBOL_GPL(at803x_cdt_wait_for_completion);
> diff --git a/drivers/net/phy/qcom/qcom.h b/drivers/net/phy/qcom/qcom.h
> index 8eb476d7c282..344f8c01d5b8 100644
> --- a/drivers/net/phy/qcom/qcom.h
> +++ b/drivers/net/phy/qcom/qcom.h
> @@ -1,5 +1,61 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  
> +#define AT803X_SPECIFIC_FUNCTION_CONTROL	0x10
> +#define AT803X_SFC_ASSERT_CRS			BIT(11)
> +#define AT803X_SFC_FORCE_LINK			BIT(10)
> +#define AT803X_SFC_MDI_CROSSOVER_MODE_M		GENMASK(6, 5)
> +#define AT803X_SFC_AUTOMATIC_CROSSOVER		0x3
> +#define AT803X_SFC_MANUAL_MDIX			0x1
> +#define AT803X_SFC_MANUAL_MDI			0x0
> +#define AT803X_SFC_SQE_TEST			BIT(2)
> +#define AT803X_SFC_POLARITY_REVERSAL		BIT(1)
> +#define AT803X_SFC_DISABLE_JABBER		BIT(0)
> +
> +#define AT803X_SPECIFIC_STATUS			0x11
> +#define AT803X_SS_SPEED_1000			2
> +#define AT803X_SS_SPEED_100			1
> +#define AT803X_SS_SPEED_10			0
> +#define AT803X_SS_DUPLEX			BIT(13)
> +#define AT803X_SS_SPEED_DUPLEX_RESOLVED		BIT(11)
> +#define AT803X_SS_MDIX				BIT(6)
> +
> +#define QCA808X_SS_SPEED_2500			4
> +
> +#define AT803X_INTR_ENABLE			0x12
> +#define AT803X_INTR_ENABLE_AUTONEG_ERR		BIT(15)
> +#define AT803X_INTR_ENABLE_SPEED_CHANGED	BIT(14)
> +#define AT803X_INTR_ENABLE_DUPLEX_CHANGED	BIT(13)
> +#define AT803X_INTR_ENABLE_PAGE_RECEIVED	BIT(12)
> +#define AT803X_INTR_ENABLE_LINK_FAIL		BIT(11)
> +#define AT803X_INTR_ENABLE_LINK_SUCCESS		BIT(10)
> +#define AT803X_INTR_ENABLE_LINK_FAIL_BX		BIT(8)
> +#define AT803X_INTR_ENABLE_LINK_SUCCESS_BX	BIT(7)
> +#define AT803X_INTR_ENABLE_WIRESPEED_DOWNGRADE	BIT(5)
> +#define AT803X_INTR_ENABLE_POLARITY_CHANGED	BIT(1)
> +#define AT803X_INTR_ENABLE_WOL			BIT(0)
> +
> +#define AT803X_INTR_STATUS			0x13
> +
> +#define AT803X_SMART_SPEED			0x14
> +#define AT803X_SMART_SPEED_ENABLE		BIT(5)
> +#define AT803X_SMART_SPEED_RETRY_LIMIT_MASK	GENMASK(4, 2)
> +#define AT803X_SMART_SPEED_BYPASS_TIMER		BIT(1)
> +
> +#define AT803X_CDT				0x16
> +#define AT803X_CDT_MDI_PAIR_MASK		GENMASK(9, 8)
> +#define AT803X_CDT_ENABLE_TEST			BIT(0)
> +#define AT803X_CDT_STATUS			0x1c
> +#define AT803X_CDT_STATUS_STAT_NORMAL		0
> +#define AT803X_CDT_STATUS_STAT_SHORT		1
> +#define AT803X_CDT_STATUS_STAT_OPEN		2
> +#define AT803X_CDT_STATUS_STAT_FAIL		3
> +#define AT803X_CDT_STATUS_STAT_MASK		GENMASK(9, 8)
> +#define AT803X_CDT_STATUS_DELTA_TIME_MASK	GENMASK(7, 0)
> +
> +#define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
> +#define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
> +#define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
> +
>  #define AT803X_DEBUG_ADDR			0x1D
>  #define AT803X_DEBUG_DATA			0x1E
>  
> @@ -16,6 +72,10 @@
>  #define   AT803X_DEBUG_HIB_CTRL_EN_ANY_CHANGE	BIT(13)
>  #define   AT803X_DEBUG_HIB_CTRL_PS_HIB_EN	BIT(15)
>  
> +#define AT803X_DEFAULT_DOWNSHIFT		5
> +#define AT803X_MIN_DOWNSHIFT			2
> +#define AT803X_MAX_DOWNSHIFT			9
> +
>  enum stat_access_type {
>  	PHY,
>  	MMD
> @@ -28,7 +88,31 @@ struct at803x_hw_stat {
>  	enum stat_access_type access_type;
>  };
>  
> +struct at803x_ss_mask {
> +	u16 speed_mask;
> +	u8 speed_shift;
> +};
> +
>  int at803x_debug_reg_read(struct phy_device *phydev, u16 reg);
>  int at803x_debug_reg_mask(struct phy_device *phydev, u16 reg,
>  			  u16 clear, u16 set);
>  int at803x_debug_reg_write(struct phy_device *phydev, u16 reg, u16 data);
> +int at803x_set_wol(struct phy_device *phydev,
> +		   struct ethtool_wolinfo *wol);
> +void at803x_get_wol(struct phy_device *phydev,
> +		    struct ethtool_wolinfo *wol);
> +int at803x_ack_interrupt(struct phy_device *phydev);
> +int at803x_config_intr(struct phy_device *phydev);
> +irqreturn_t at803x_handle_interrupt(struct phy_device *phydev);
> +int at803x_read_specific_status(struct phy_device *phydev,
> +				struct at803x_ss_mask ss_mask);
> +int at803x_config_mdix(struct phy_device *phydev, u8 ctrl);
> +int at803x_prepare_config_aneg(struct phy_device *phydev);
> +int at803x_get_tunable(struct phy_device *phydev,
> +		       struct ethtool_tunable *tuna, void *data);
> +int at803x_set_tunable(struct phy_device *phydev,
> +		       struct ethtool_tunable *tuna, const void *data);
> +int at803x_cdt_fault_length(int dt);
> +int at803x_cdt_start(struct phy_device *phydev, u32 cdt_start);
> +int at803x_cdt_wait_for_completion(struct phy_device *phydev,
> +				   u32 cdt_en);
> -- 
> 2.43.0
> 

-- 
	Ansuel

