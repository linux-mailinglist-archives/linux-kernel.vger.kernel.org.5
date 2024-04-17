Return-Path: <linux-kernel+bounces-149106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFF38A8BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F33288926
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E1A24B2F;
	Wed, 17 Apr 2024 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEmc6EZm"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FF31DA53;
	Wed, 17 Apr 2024 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713381223; cv=none; b=QwlUfQnz84EPHLFAgZB62KlgiC0409TxPI1OYJ+WYjzsLBgrAwsZZjPiezo9KLPYmsEuZYJ6fuWS1qla4ajw/Y5iRtjosBeKAvnICnF8sV6RcdonTOWNdGcBMAxeqE5ctHrvJnBwEyR8BWeupuNQqUWOml6RxG4sR9SidjATZ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713381223; c=relaxed/simple;
	bh=CmzwNIApee8Fwt4pVcYGZwnquvTzM85msk5kFBGJ/X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERdj+R365NJmUfz0xJbM4ao0tbKTIv5zEB7lxhiGLVDRXRmfwFq6Mz/blPK+MuNBP5c546C4HDTFo0siU3t3WWtxgi25TeNd7FwoF2RNz1kNvmwfYpzrr+35E+JiJi2Qppwm6mrVlG/6tZ0WYGqoF1T4oIWghIwVnVgMsBDXy3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEmc6EZm; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d1c8dc79so13277e87.1;
        Wed, 17 Apr 2024 12:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713381220; x=1713986020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTcCtqawFKRHlvcDtRKkDTTkbfy/GJAXrQ0aSEOy+RI=;
        b=EEmc6EZm0q9U8Kzdq5yphngQ5Bae36iIACiTgcJTOuiwgp4hUurKN9sPV6LqRnMTob
         QXviFalp1x7Ql8xEQ9RW15u/d1JqYqteetvQgN5D0yMD18aeyV6ih16CfNTg+qEgxubH
         3D2+DlnAHTkAqfQe8s0mO2aD7f7/ggQ6vhn5h3Ka3AWqTkZBz8un5qrukDkrBybxX7JK
         PpVY0t2MoFfNRpBVRi+9XaliLhvwAmjG5o4rSKPYwlF8cxC6XAgRNRJ4QJCl+cxo+xLG
         JSDFJ9/IIB6bgh617NrCozTHXHwnPC0aKWX8raDa+lAcippUIOwbXpnSp+fX4zBggZDc
         vR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713381220; x=1713986020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTcCtqawFKRHlvcDtRKkDTTkbfy/GJAXrQ0aSEOy+RI=;
        b=gyKornl0OnUwYRVhrSfGy+1m6AZUvbBqNQUDXDAJ4zVIHSki/KZrsGzU01PyH1+dyu
         dhKkqI+aFsa1JITBcCJ5DMG5HUuO1+qh+WrT5ySLSqImZNsLtc0jpV6GJCdxToDIQ/mO
         Usxw42yuESx+HExq4I1zbCIKhyJ+HRZWeNMy6U3Uz32b+UcDu7ei5lIwjXSydCUkOFOZ
         oETKXfUS4mDFPbVsjWuKJC817+jPwY27GWeZii0az+iYkr55VDsFmSlW6QyAg/2/Fyj7
         EZ4dPA404bDrH2jE8pKkapgzv1plOk9SVzdcn8aIFzqTDr2fbE6YkoaNb3xz4SqpHdkM
         Q56A==
X-Forwarded-Encrypted: i=1; AJvYcCVoSH+YXISuk7zeaEfk5rjav3uUYlGfLfjlX7NZI3wL3oUYVwTYphH/AsOE7CIr0qrfBF4A9y0ww4hGauX9SKXfw1r1xnVD5uaj4Sr8GcjBfwJjjH9YkEMYCwbLMCceyQgLWRFt
X-Gm-Message-State: AOJu0Yx0xzIeuUiN3/F7Hu3Y2I/j2xY1lbndKUxugoGc8jYTrlU5MxwF
	Fs4suGYWp+Yeur4Sy/uG5OIqPOILvYTYgITIVGl+HkSUFT+kEdyC
X-Google-Smtp-Source: AGHT+IEA0/ml2vS2S5lnkSe66SZb269sVi/52jJbQD/EKj42WqO5Y8kEwvaZGCTBSCq0H+wObYP3lg==
X-Received: by 2002:ac2:5fcf:0:b0:515:99f6:2ca4 with SMTP id q15-20020ac25fcf000000b0051599f62ca4mr104968lfg.36.1713381219670;
        Wed, 17 Apr 2024 12:13:39 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id q3-20020ac25143000000b00518c86b3eb7sm1251742lfd.80.2024.04.17.12.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 12:13:39 -0700 (PDT)
Date: Wed, 17 Apr 2024 22:13:37 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Woojung Huh <woojung.huh@microchip.com>, Arun Ramadoss <arun.ramadoss@microchip.com>, 
	Richard Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v1 4/4] net: stmmac: use delays reported by the
 PHY driver to correct MAC propagation delay
Message-ID: <3ib7rkbwxtdd26waw2dseuwwlijhxxjmjp6jbxe6g6i5hk6ua2@3zt2avhdh2lu>
References: <20240417164316.1755299-1-o.rempel@pengutronix.de>
 <20240417164316.1755299-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417164316.1755299-5-o.rempel@pengutronix.de>

On Wed, Apr 17, 2024 at 06:43:16PM +0200, Oleksij Rempel wrote:
> Now after PHY drivers are able to report data path delays, we can use
> them in the MAC drivers for the delay correction.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h    |  2 ++
>  .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c   |  4 ++++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c   | 17 ++++++++++++++++-
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index dddcaa9220cc3..6db54ce33ea72 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -288,6 +288,8 @@ struct stmmac_priv {
>  	u32 sub_second_inc;
>  	u32 systime_flags;
>  	u32 adv_ts;

> +	u64 phy_tx_delay_ns;
> +	u64 phy_rx_delay_ns;

What's the point in adding these fields to the private data if you
retrieve the delays and use them in a single place? Just extend the
stmmac_hwtstamp_correct_latency() arguments list and pass the delays
as the function parameters.

-Serge(y)

>  	int use_riwt;
>  	int irq_wake;
>  	rwlock_t ptp_lock;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> index f05bd757dfe52..bbf284cb7cc2a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> @@ -71,6 +71,8 @@ static void hwtstamp_correct_latency(struct stmmac_priv *priv)
>  	/* MAC-internal ingress latency */
>  	scaled_ns = readl(ioaddr + PTP_TS_INGR_LAT);
>  
> +	scaled_ns += priv->phy_rx_delay_ns << 16;
> +
>  	/* See section 11.7.2.5.3.1 "Ingress Correction" on page 4001 of
>  	 * i.MX8MP Applications Processor Reference Manual Rev. 1, 06/2021
>  	 */
> @@ -95,6 +97,8 @@ static void hwtstamp_correct_latency(struct stmmac_priv *priv)
>  	/* MAC-internal egress latency */
>  	scaled_ns = readl(ioaddr + PTP_TS_EGR_LAT);
>  
> +	scaled_ns += priv->phy_tx_delay_ns << 16;
> +
>  	reg_tsec = scaled_ns >> 16;
>  	reg_tsecsns = scaled_ns & 0xff00;
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index fe3498e86de9d..30c7c278b7062 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1097,8 +1097,23 @@ static void stmmac_mac_link_up(struct phylink_config *config,
>  	if (priv->dma_cap.fpesel)
>  		stmmac_fpe_link_state_handle(priv, true);
>  
> -	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
> +	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY) {
> +		int ret = 0;
> +
> +		if (phy)
> +			ret = phy_get_timesync_data_path_delays(phy,
> +								&priv->phy_tx_delay_ns,
> +								&priv->phy_rx_delay_ns);
> +		if (!phy || ret) {
> +			if (ret != -EOPNOTSUPP)
> +				netdev_err(priv->dev, "Failed to get PHY delay: %pe\n",
> +					   ERR_PTR(ret));
> +			priv->phy_tx_delay_ns = 0;
> +			priv->phy_rx_delay_ns = 0;
> +		}
> +
>  		stmmac_hwtstamp_correct_latency(priv, priv);
> +	}
>  }
>  
>  static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
> -- 
> 2.39.2
> 
> 

